Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84349554649
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiFVIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiFVIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D08C11A1F;
        Wed, 22 Jun 2022 01:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 097D361766;
        Wed, 22 Jun 2022 08:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0BDC34114;
        Wed, 22 Jun 2022 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655886270;
        bh=YbuYr5/ie+xJQcPyfNne1QY4FDSlOh+xwavMqcIsMnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeE7pxOHB1owDbNrefzoSq4pKLcFSTifGgjLZlz5Vqg0MHXH7Un2gk9NlDFQw0L8H
         tJeGbPX5BCTacAgEZpRXso9n9IfPTXYTgLGAMwwttl+GY4KuCmuqyFUGx7nPJS10/z
         4kLiDY/g2Y8mIccxuXLTBl5Ky28evFXltp3I8A0g=
Date:   Wed, 22 Jun 2022 10:24:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Yang Shen <shenyang39@huawei.com>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrLRwF24FHV9nhA8@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica>
 <YrB30M9yAbUbPFrG@kroah.com>
 <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
 <YrF2yypHZfiNVRBh@kroah.com>
 <6fb8bed5-8d40-fd63-4537-44e9eb6aa053@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fb8bed5-8d40-fd63-4537-44e9eb6aa053@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:14:45PM +0800, Zhangfei Gao wrote:
> Hi, Greg
> 
> On 2022/6/21 下午3:44, Greg Kroah-Hartman wrote:
> > On Tue, Jun 21, 2022 at 03:37:31PM +0800, Zhangfei Gao wrote:
> > > 
> > > On 2022/6/20 下午9:36, Greg Kroah-Hartman wrote:
> > > > On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
> > > > > On Fri, Jun 17, 2022 at 02:05:21PM +0800, Zhangfei Gao wrote:
> > > > > > > The refcount only ensures that the uacce_device object is not freed as
> > > > > > > long as there are open fds. But uacce_remove() can run while there are
> > > > > > > open fds, or fds in the process of being opened. And atfer uacce_remove()
> > > > > > > runs, the uacce_device object still exists but is mostly unusable. For
> > > > > > > example once the module is freed, uacce->ops is not valid anymore. But
> > > > > > > currently uacce_fops_open() may dereference the ops in this case:
> > > > > > > 
> > > > > > > 	uacce_fops_open()
> > > > > > > 	 if (!uacce->parent->driver)
> > > > > > > 	 /* Still valid, keep going */		
> > > > > > > 	 ...					rmmod
> > > > > > > 						 uacce_remove()
> > > > > > > 	 ...					 free_module()
> > > > > > > 	 uacce->ops->get_queue() /* BUG */
> > > > > > uacce_remove should wait for uacce->queues_lock, until fops_open release the
> > > > > > lock.
> > > > > > If open happen just after the uacce_remove: unlock, uacce_bind_queue in open
> > > > > > should fail.
> > > > > Ah yes sorry, I lost sight of what this patch was adding. But we could
> > > > > have the same issue with the patch, just in a different order, no?
> > > > > 
> > > > > 	uacce_fops_open()
> > > > > 	 uacce = xa_load()
> > > > > 	 ...					rmmod
> > > > Um, how is rmmod called if the file descriptor is open?
> > > > 
> > > > That should not be possible if the owner of the file descriptor is
> > > > properly set.  Please fix that up.
> > > Thanks Greg
> > > 
> > > Set cdev owner or use module_get/put can block rmmod once fops_open.
> > > -       uacce->cdev->owner = THIS_MODULE;
> > > +       uacce->cdev->owner = uacce->parent->driver->owner;
> > > 
> > > However, still not find good method to block removing parent pci device.
> > > 
> > > $ echo 1 > /sys/bus/pci/devices/0000:00:02.0/remove &
> > > 
> > > [   32.563350]  uacce_remove+0x6c/0x148
> > > [   32.563353]  hisi_qm_uninit+0x12c/0x178
> > > [   32.563356]  hisi_zip_remove+0xa0/0xd0 [hisi_zip]
> > > [   32.563361]  pci_device_remove+0x44/0xd8
> > > [   32.563364]  device_remove+0x54/0x88
> > > [   32.563367]  device_release_driver_internal+0xec/0x1a0
> > > [   32.563370]  device_release_driver+0x20/0x30
> > > [   32.563372]  pci_stop_bus_device+0x8c/0xe0
> > > [   32.563375]  pci_stop_and_remove_bus_device_locked+0x28/0x60
> > > [   32.563378]  remove_store+0x9c/0xb0
> > > [   32.563379]  dev_attr_store+0x20/0x38
> > Removing the parent pci device does not remove the module code, it
> > removes the device itself.  Don't confuse code vs. data here.
> 
> Do you mean even parent pci device is removed immediately, the code has to
> wait, like dma etc?

No, reads will fail, as will DMA transfers, all PCI drivers need to
handle surprise removal like this as we have had PCI hotplug systems for
decades now.

> Currently parent driver has to ensure all dma stopped then call
> uacce_remove,
> ie, after uacce_fops_open succeed, parent driver need wait fops_release,
> then uacce_remove can be called.

remove can be called before the file close can happen all the time, you
need to handle that properly.

> For example:
> drivers/crypto/hisilicon/zip/zip_main.c:
> hisi_qm_wait_task_finish
> 
> If remove this wait , there may other issue,
> Unable to handle kernel paging request at virtual address ffff80000b700204
> pc : hisi_qm_cache_wb.part.0+0x2c/0xa0
> 
> So uacce only need serialize uacce_fops_open and uacce_remove.

That's not going to help much.

> After uacce_fops_open, we can assume uacce_remove only happen after
> uacce_fops_release?

Nope, again, device remove can happen at any point in time and is
independent of userspace open/close of file descriptors on the char
device.

This is a common problem/pattern that drivers need to handle, and
unfortunatly they all need to handle it on their own.  We have discussed
ways of making it easier (see the ksummit discuss list archives from
last year), but no one has stepped up and done the work yet :(

> Then it would be much simpler.

Sorry.  If you treat the structures as independant, and properly grab
some reference counts or a lock, you should be ok.

greg k-h
