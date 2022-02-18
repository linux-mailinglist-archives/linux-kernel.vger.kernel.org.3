Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E14BB66A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiBRKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:09:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiBRKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:09:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDE369E8;
        Fri, 18 Feb 2022 02:08:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D9E04219A0;
        Fri, 18 Feb 2022 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645178922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pH/gpsR4V/bMLJyVBc0wWkSnS/FoIs/cyCo4Bs15SHM=;
        b=Ll4ATReqN58yJ1DqMUkw+0+CJelCiPPtC0LbR0IkScm6rtH9ydUGQMxZOMShV9eomI7p4q
        8r+qedUt544XWfkqGw7Upx2ByqHF7YEVJCyIN0t71eo0ByXGRQjMViskKxMG1FSRvtuOyT
        d1G4vnBheCDwsKYfE2pgmxwq9UNlBw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645178922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pH/gpsR4V/bMLJyVBc0wWkSnS/FoIs/cyCo4Bs15SHM=;
        b=AYvWPIaG2Azj0WJiP3xMoYp96W8Q5tJRoFKuCH/VsqtE0MFLrd2Eix+nCdwCTXLNcZWEpd
        wkJCdcP01JfWIQAw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 949F5A3B84;
        Fri, 18 Feb 2022 10:08:42 +0000 (UTC)
Date:   Fri, 18 Feb 2022 11:08:41 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>,
        linux-video@atrey.karlin.mff.cuni.cz,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] simpldrm: Enable boot time VESA graphic mode selection.
Message-ID: <20220218100841.GV3113@kunlun.suse.cz>
References: <20220218093334.24830-1-msuchanek@suse.de>
 <4c6e1d15-3bb3-5a69-972f-592cc33ac0cd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6e1d15-3bb3-5a69-972f-592cc33ac0cd@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Feb 18, 2022 at 10:57:33AM +0100, Thomas Zimmermann wrote:
> Hi Michal
> 
> Am 18.02.22 um 10:33 schrieb Michal Suchanek:
> > Since switch to simpledrm VESA graphic modes are no longer available
> > with legacy BIOS.
> > 
> > The x86 realmode boot code enables the VESA graphic modes when option
> > FB_BOOT_VESA_SUPPORT is enabled.
> > 
> > To enable use of VESA modes with simpledrm in legacy BIOS boot mode drop
> > dependency of BOOT_VESA_SUPPORT on FB, also drop the FB_ prefix, and
> > select the option when simpledrm is built-in on x86.
> 
> Thanks for sending the patch.
> 
> I tested simpledrm on a VESA-based systems and it work. Do you have a

In EFI or legacy mode?

> concrete example of a mode that doesn't work any longer?

As per discussion in
https://bugzilla.opensuse.org/show_bug.cgi?id=1193250 vga=791 does not.

Also it is clear examinig the realmode code that this option is needed
to enable graphic mode selection.

I don't have a system with legacy BIOS at hand but from user testing
this improves the situation - kernel does not reeject the videomode
argument, and simpledrm is initialized during boot.

Thanks

Michal

> 
> > 
> > Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   arch/x86/boot/video-vesa.c   | 4 ++--
> >   drivers/gpu/drm/tiny/Kconfig | 1 +
> >   drivers/video/fbdev/Kconfig  | 9 ++++-----
> >   3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/boot/video-vesa.c b/arch/x86/boot/video-vesa.c
> > index 7e185977a984..c2c6d35e3a43 100644
> > --- a/arch/x86/boot/video-vesa.c
> > +++ b/arch/x86/boot/video-vesa.c
> > @@ -83,7 +83,7 @@ static int vesa_probe(void)
> >   			   (vminfo.memory_layout == 4 ||
> >   			    vminfo.memory_layout == 6) &&
> >   			   vminfo.memory_planes == 1) {
> > -#ifdef CONFIG_FB_BOOT_VESA_SUPPORT
> > +#ifdef CONFIG_BOOT_VESA_SUPPORT
> >   			/* Graphics mode, color, linear frame buffer
> >   			   supported.  Only register the mode if
> >   			   if framebuffer is configured, however,
> > @@ -121,7 +121,7 @@ static int vesa_set_mode(struct mode_info *mode)
> >   	if ((vminfo.mode_attr & 0x15) == 0x05) {
> >   		/* It's a supported text mode */
> >   		is_graphic = 0;
> > -#ifdef CONFIG_FB_BOOT_VESA_SUPPORT
> > +#ifdef CONFIG_BOOT_VESA_SUPPORT
> >   	} else if ((vminfo.mode_attr & 0x99) == 0x99) {
> >   		/* It's a graphics mode with linear frame buffer */
> >   		is_graphic = 1;
> > diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> > index 712e0004e96e..1bc30c64ed15 100644
> > --- a/drivers/gpu/drm/tiny/Kconfig
> > +++ b/drivers/gpu/drm/tiny/Kconfig
> > @@ -54,6 +54,7 @@ config DRM_GM12U320
> >   config DRM_SIMPLEDRM
> >   	tristate "Simple framebuffer driver"
> >   	depends on DRM && MMU
> > +	select BOOT_VESA_SUPPORT if X86 && DRM_SIMPLEDRM = y
> 
> We shouldn't select this option in drivers IMHO. Simple-framebuffer devices
> with VESA are enabled with [1] and that should also select the
> BOOT_VESA_SUPPORT.

Sounds ok to select from there, it should also cover simplefb then.

Thanks

Michal
