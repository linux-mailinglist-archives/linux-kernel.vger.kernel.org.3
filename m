Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4604D77E7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiCMTJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiCMTJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA224BED;
        Sun, 13 Mar 2022 12:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBF4EB80C6D;
        Sun, 13 Mar 2022 19:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AA7C340E8;
        Sun, 13 Mar 2022 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647198481;
        bh=S85F7ZrTXTrFfys0rJRseAMPLnZqh6VsxjYx3rCW0qE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dmNaUYlaZzqRi5HFPSpsaDKlblQ3p5MVwueWdtZ27nwr8sXgDKGi2zeY/AjXhia3r
         t3niMVPVw7ZMGjht2uPQpdIjDG4Xhh9RGBhkGpYYOvaUeyV1uyl7/Ooe5SRkYIpGeX
         nPRzgYBl7I9TulXE9lJimj0/y8WedW4Wi+roZ8v+CzAwespYPgVioTi8rInofHYnIy
         491oP//dd5FdrR2OaOwIhThTPNfNsfaRZeZ3HQhK2GC9Kcx+ke0YN8MaSRvnFceHGK
         pt91NFQbpkfyZg/QEihqmYtQ09K3FaejAvhCvgIlhJQH+gCJk9QSEoxFWap65S3vAZ
         MpeygeZQ1qMyA==
Date:   Sun, 13 Mar 2022 20:07:55 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] media: Kconfig: cleanup VIDEO_DEV dependencies
Message-ID: <20220313200755.0873537c@coco.lan>
In-Reply-To: <Yi3ciCTbHrxYUatX@pendragon.ideasonboard.com>
References: <42ae3d28d4d822f3e14db76b99f2f4c41688ae3e.1647155467.git.mchehab@kernel.org>
        <Yi3ciCTbHrxYUatX@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 13 Mar 2022 13:59:04 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> Hi Mauro,
> 
> Thank you for the patch.
> 
> Trimming the CC list to keep a few mailing lists only.
> 
> On Sun, Mar 13, 2022 at 08:12:05AM +0100, Mauro Carvalho Chehab wrote:
> > media Kconfig has two entries associated to V4L API:
> > VIDEO_DEV and VIDEO_V4L2.
> > 
> > On Kernel 2.6.x, there were two V4L APIs, each one with its own flag.
> > VIDEO_DEV were meant to:
> > 	1) enable Video4Linux and make its Kconfig options to appear;
> > 	2) it makes the Kernel build the V4L core.
> > 
> > while VIDEO_V4L2 where used to distinguish between drivers that
> > implement the newer API and drivers that implemented the former one.
> > 
> > With time, such meaning changed, specially after the removal of
> > all V4L version 1 drivers.
> > 
> > At the current implementation, VIDEO_DEV only does (1): it enables
> > the media options related to V4L, that now has:
> > 
> > 	menu "Video4Linux options"
> > 		visible if VIDEO_DEV
> > 
> > 	source "drivers/media/v4l2-core/Kconfig"
> > 	endmenu
> > 
> > but it doesn't affect anymore the V4L core drivers.
> > 
> > The rationale is that the V4L2 core has a "soft" dependency
> > at the I2C bus, and now requires to select a number of other
> > Kconfig options:
> > 
> > 	config VIDEO_V4L2
> > 		tristate
> > 		depends on (I2C || I2C=n) && VIDEO_DEV
> > 		select RATIONAL
> > 		select VIDEOBUF2_V4L2 if VIDEOBUF2_CORE
> > 		default (I2C || I2C=n) && VIDEO_DEV
> > 
> > In the past, merging them would be tricky, but it seems that it is now
> > possible to merge those symbols, in order to simplify V4L dependencies.
> > 
> > Let's keep VIDEO_DEV, as this one is used on some make *defconfig
> > configurations.  
> 
> I would have gone for VIDEO_V4L2, but if it makes configuration changes
> easier to handle, VIDEO_DEV is fine with me too.

That was actually my first option ;-) VIDEO_V4L2 (or VIDEO_V4L) is a much
better name. From my side, I'm fine either way.

As a plus, using VIDEO_V4L2 would produce a much smaller patch that won't be
rejected by some ML servers, but maybe it would require distros and people 
who have their own .config files stored somewhere to re-configure their
Kernels.

> [snip]
> 
> > diff --git a/drivers/media/pci/tw5864/Kconfig b/drivers/media/pci/tw5864/Kconfig
> > index d376d4ed65b9..0a0f3191f238 100644
> > --- a/drivers/media/pci/tw5864/Kconfig
> > +++ b/drivers/media/pci/tw5864/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config VIDEO_TW5864
> >  	tristate "Techwell TW5864 video/audio grabber and encoder"
> > -	depends on VIDEO_DEV && PCI && VIDEO_V4L2
> > +	depends on VIDEO_DEV && PCI && VIDEO_DEV  
> 
> You can drop the second VIDEO_DEV.
> 
> >  	select VIDEOBUF2_DMA_CONTIG
> >  	help
> >  	  Support for boards based on Techwell TW5864 chip which provides
> > diff --git a/drivers/media/pci/tw68/Kconfig b/drivers/media/pci/tw68/Kconfig
> > index af0cb60337bb..ef29be7db493 100644
> > --- a/drivers/media/pci/tw68/Kconfig
> > +++ b/drivers/media/pci/tw68/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config VIDEO_TW68
> >  	tristate "Techwell tw68x Video For Linux"
> > -	depends on VIDEO_DEV && PCI && VIDEO_V4L2
> > +	depends on VIDEO_DEV && PCI && VIDEO_DEV  
> 
> Here too.
> 
> Apart from that, the patch looks good to me.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Mauro
