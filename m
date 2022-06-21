Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B02552C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347428AbiFUHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347280AbiFUHoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:44:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2A2317A;
        Tue, 21 Jun 2022 00:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23D31B8169E;
        Tue, 21 Jun 2022 07:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED6BC3411D;
        Tue, 21 Jun 2022 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655797454;
        bh=TgZQktU/5vsZP3GPNZ/qWZleinBCCk2cgAR6Lox4crc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wht0PXyeuQwQyGpWl60X7KoWQ4g7oJT8n4WSl6EFrGYthyFE7HShKTIyBJGnBxmAb
         467t3Luka6NxNagPemIBgkgzsXnCDWmc5oXT9YqDSLh8BX8/0LLURrypXa+4Qk8Aq+
         Ap1psmSnRkJLyskIBIwSkuYFJ8Kf6sideKMUsN6o=
Date:   Tue, 21 Jun 2022 09:44:11 +0200
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
Message-ID: <YrF2yypHZfiNVRBh@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica>
 <YrB30M9yAbUbPFrG@kroah.com>
 <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:37:31PM +0800, Zhangfei Gao wrote:
> 
> 
> On 2022/6/20 下午9:36, Greg Kroah-Hartman wrote:
> > On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
> > > On Fri, Jun 17, 2022 at 02:05:21PM +0800, Zhangfei Gao wrote:
> > > > > The refcount only ensures that the uacce_device object is not freed as
> > > > > long as there are open fds. But uacce_remove() can run while there are
> > > > > open fds, or fds in the process of being opened. And atfer uacce_remove()
> > > > > runs, the uacce_device object still exists but is mostly unusable. For
> > > > > example once the module is freed, uacce->ops is not valid anymore. But
> > > > > currently uacce_fops_open() may dereference the ops in this case:
> > > > > 
> > > > > 	uacce_fops_open()
> > > > > 	 if (!uacce->parent->driver)
> > > > > 	 /* Still valid, keep going */		
> > > > > 	 ...					rmmod
> > > > > 						 uacce_remove()
> > > > > 	 ...					 free_module()
> > > > > 	 uacce->ops->get_queue() /* BUG */
> > > > uacce_remove should wait for uacce->queues_lock, until fops_open release the
> > > > lock.
> > > > If open happen just after the uacce_remove: unlock, uacce_bind_queue in open
> > > > should fail.
> > > Ah yes sorry, I lost sight of what this patch was adding. But we could
> > > have the same issue with the patch, just in a different order, no?
> > > 
> > > 	uacce_fops_open()
> > > 	 uacce = xa_load()
> > > 	 ...					rmmod
> > Um, how is rmmod called if the file descriptor is open?
> > 
> > That should not be possible if the owner of the file descriptor is
> > properly set.  Please fix that up.
> Thanks Greg
> 
> Set cdev owner or use module_get/put can block rmmod once fops_open.
> -       uacce->cdev->owner = THIS_MODULE;
> +       uacce->cdev->owner = uacce->parent->driver->owner;
> 
> However, still not find good method to block removing parent pci device.
> 
> $ echo 1 > /sys/bus/pci/devices/0000:00:02.0/remove &
> 
> [   32.563350]  uacce_remove+0x6c/0x148
> [   32.563353]  hisi_qm_uninit+0x12c/0x178
> [   32.563356]  hisi_zip_remove+0xa0/0xd0 [hisi_zip]
> [   32.563361]  pci_device_remove+0x44/0xd8
> [   32.563364]  device_remove+0x54/0x88
> [   32.563367]  device_release_driver_internal+0xec/0x1a0
> [   32.563370]  device_release_driver+0x20/0x30
> [   32.563372]  pci_stop_bus_device+0x8c/0xe0
> [   32.563375]  pci_stop_and_remove_bus_device_locked+0x28/0x60
> [   32.563378]  remove_store+0x9c/0xb0
> [   32.563379]  dev_attr_store+0x20/0x38

Removing the parent pci device does not remove the module code, it
removes the device itself.  Don't confuse code vs. data here.

thanks,

greg k-h
