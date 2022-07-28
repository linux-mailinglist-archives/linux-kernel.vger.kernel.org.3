Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4830583DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiG1LsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiG1LsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:48:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852267CB5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7DD3B82322
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D021CC433D6;
        Thu, 28 Jul 2022 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659008885;
        bh=bmnhC51lVRzoD/ELMNtwN9HgEsw5L7dsWpRX5ebkBro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOoz2dA3JGhA5JyMErivTV72PA+VRiO5m8C8ALB1WflGRyykUDZHAPN9H4z/C0PXG
         Vhaf+aYKKO5xNpKGMAPL55GNqO8ww6N0Lakj+NaMDHFdsfzDpUkpQYYNWrsYvakPBz
         4G4YORB8EM1u2+fvdgEOe8ZrdexKvvrRJE1qRx9c=
Date:   Thu, 28 Jul 2022 13:48:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] component: try_module_get() to prevent unloading while
 in use
Message-ID: <YuJ3cuuQETb2A7gv@kroah.com>
References: <20220725160859.1274472-1-rf@opensource.cirrus.com>
 <Yt7cT66p0Bn+aXn5@kroah.com>
 <4165774b-2b96-83d1-67eb-f7c49dd8041e@opensource.cirrus.com>
 <YuAkQtik4ud6xw8L@kroah.com>
 <85bb9c36-33e9-c3e2-1838-9ef45311669b@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85bb9c36-33e9-c3e2-1838-9ef45311669b@opensource.cirrus.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:49:57AM +0100, Richard Fitzgerald wrote:
> On 26/07/2022 18:28, Greg KH wrote:
> > On Tue, Jul 26, 2022 at 11:32:28AM +0100, Richard Fitzgerald wrote:
> > > On 25/07/2022 19:09, Greg KH wrote:
> > > > On Mon, Jul 25, 2022 at 05:08:59PM +0100, Richard Fitzgerald wrote:
> > > > > Call try_module_get() on a component before attempting to call its
> > > > > bind() function, to ensure that a loadable module cannot be
> > > > > unloaded while we are executing its bind().
> > > > 
> > > > How can bind be called while the module is unloaded?
> > > > 
> > > 
> > > I didn't say it could. What I said is "unloaded while we are executing
> > > its bind()". Maybe that's already guaranteed to be safe somehow. It's
> > > actually the problem below that I was trying to fix but placing the
> > > try_module_get() before the bind() rather than after bind() seemed a
> > > trivial extra safety.
> > 
> > It should be safe, bind() can't race with module remove as the driver
> > core locks will handle this.
> > 
> > > > > If the bind is successful the module_put() is called only after it
> > > > > has been unbound. This ensures that the module cannot be unloaded
> > > > > while it is in use as an aggregate device.
> > > > 
> > > > That's almost never the correct thing to do, what problem is this
> > > > solving?
> > > > 
> > > 
> > > What I see is that when a loadable module has been made part of an
> > > aggregate it is still possible to rmmod'd it.
> > > 
> > > An alternative workaround would be for the parent to softdep to every
> > > driver that _might_ provide the aggregated components. Softdeps aren't
> > > unusual (we use it in some drivers that are directly related but don't
> > > directly link into each other). But to me this feels like a hack when
> > > used with the component framework - isn't the idea that the parent
> > > doesn't know (or doesn't need to know) which drivers will be aggregated?
> > > Wouldn't it be better that when a component driver is bound into an
> > > aggregate its module is automatically marked in-use?
> > > 
> > > If there's a better way to mark the module in-use while is it bound
> > > into an aggregate, let me know and I'll look at implementing it.
> > 
> > No module references should be incremented if a device is bound to a
> > driver, that's the old (1990's) way of thinking.  If a module wants to
> > be unloaded, let it, and clean up everything that it was
> > controlling/talking to before the module remove is finished.
> > 
> > That's the way all busses should be working, you don't increment a
> > module count when a driver binds to a device, otherwise how would you
> > unload a module that was being used at all?
> > 
> > So just remove the components controlled by the module properly when it
> > is removed and all should be good.
> > 
> > Do you have example code in the kernel tree today that does not properly
> > do this?  Why not just fix that instead?
> > 
> 
> The actual code I'm working on isn't upstream yet, but it's a derivative
> of the way these two interoperate:
>  sound/pci/hda/patch_realtek
>  sound/pci/hda/cs35l41_hda.c
> 
> In these systems the host audio interface is HDA but the amps are not
> HDA devices. Audio goes through the Realtek HDA codec to the amp but
> the amp is on a different bus (i2c or spi). The modules in the HDA stack
> all get marked as in-use, but the amp driver doesn't. So if it's
> unloaded the audio system is left in a limbo state where ALSA and the
> HDA stack are still up but the amp driver code has gone.
> 
> However I realised that my try_module_get() isn't a fix anyway.
> It's claiming use of the module implementing the component but not
> of the bus that owns that module. I assume that's what you were
> referring to by having to deal with an unload instead of trying to
> prevent the unload.

Yes.

Also there is no requirement that a module increment its reference count
even if it is being used, as long as it can properly tear things down
when it is removed.  Look at network modules for examples of that
working properly.  Odds are other modules should move to that model over
time, and we are not going to try to go backwards and add module
reference counting to the driver core.

module references lock code, you are modifying data here, two different
things.

thanks,

greg k-h
