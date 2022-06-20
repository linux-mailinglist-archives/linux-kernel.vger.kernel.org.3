Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D37551E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbiFTOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiFTOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1751E3EA;
        Mon, 20 Jun 2022 06:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB9B614A2;
        Mon, 20 Jun 2022 13:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A80AC3411B;
        Mon, 20 Jun 2022 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655732332;
        bh=xeNQ0+6hDjpNvZkk4v9Q9lxDKoWOP3OWykh/y4PzEg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFi9Z1e+H3yTylWZ6HfCXs2xOcJteAbnw0pJcK11A8lNApLffBb7jaoxbtrdIB/dt
         JSKMgzhjwpHtnv0TyD1GSGaWsfl0TcZHgZrH+Fal+Dueu8QsDkGW31FQHq9eJYuOa8
         7njbVEtvUXZUBG1dmz638qYD4/HnGfoqevK+FSP0=
Date:   Mon, 20 Jun 2022 15:36:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Yang Shen <shenyang39@huawei.com>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrB30M9yAbUbPFrG@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrB1D9rv9G4h/BYU@myrica>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Jun 17, 2022 at 02:05:21PM +0800, Zhangfei Gao wrote:
> > > The refcount only ensures that the uacce_device object is not freed as
> > > long as there are open fds. But uacce_remove() can run while there are
> > > open fds, or fds in the process of being opened. And atfer uacce_remove()
> > > runs, the uacce_device object still exists but is mostly unusable. For
> > > example once the module is freed, uacce->ops is not valid anymore. But
> > > currently uacce_fops_open() may dereference the ops in this case:
> > > 
> > > 	uacce_fops_open()
> > > 	 if (!uacce->parent->driver)
> > > 	 /* Still valid, keep going */		
> > > 	 ...					rmmod
> > > 						 uacce_remove()
> > > 	 ...					 free_module()
> > > 	 uacce->ops->get_queue() /* BUG */
> > 
> > uacce_remove should wait for uacce->queues_lock, until fops_open release the
> > lock.
> > If open happen just after the uacce_remove: unlock, uacce_bind_queue in open
> > should fail.
> 
> Ah yes sorry, I lost sight of what this patch was adding. But we could
> have the same issue with the patch, just in a different order, no?
> 
> 	uacce_fops_open()
> 	 uacce = xa_load()
> 	 ...					rmmod

Um, how is rmmod called if the file descriptor is open?

That should not be possible if the owner of the file descriptor is
properly set.  Please fix that up.

thanks,

greg k-h
