Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2896549F75C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiA1Kec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:34:32 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38006 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiA1Ke2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:34:28 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A6D3B9C;
        Fri, 28 Jan 2022 11:34:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643366066;
        bh=SjngVim/bAf9eBc4Da9VVdDH4QW1J82EoUqAY4mOegc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIqVB+7jiNvEi7UPEfL67GXviPPO5/o3PB4DBuzEpg9fSbb0AATxZL2mqIDQQcANj
         v8v6AmI/srfB2KUotIg5IvS35m/GHPvurjFIJ/DRqeC88pmKvnGJq1JNfpGDtYVANf
         zvAnZ2+TEMafOBeJESYCAfNJMA7aGxI2yv4UD+ac=
Date:   Fri, 28 Jan 2022 12:34:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/37] drm: rcar-du: Add support for the nomodeset
 kernel parameter
Message-ID: <YfPGnfly3GOAOlfp@pendragon.ideasonboard.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
 <20211217003752.3946210-32-javierm@redhat.com>
 <164336121612.533872.1685181669511488706@Monstersaurus>
 <eb27fa44-2972-4a6e-465f-b9e4775820f4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb27fa44-2972-4a6e-465f-b9e4775820f4@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jan 28, 2022 at 10:33:21AM +0100, Thomas Zimmermann wrote:
> Am 28.01.22 um 10:13 schrieb Kieran Bingham:
> > Quoting Javier Martinez Canillas (2021-12-17 00:37:46)
> >> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> >> parameter can be used to disable kernel modesetting.
> >>
> >> DRM drivers will not perform display-mode changes or accelerated rendering
> >> and only the system framebuffer will be available if it was set-up.
> > 
> > What is the 'system framebuffer' in this instance? Reading
> > https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt
> > it sounds like that means anything already set up by the bootloader.
> 
> Exactly this.
> 
> >> But only a few DRM drivers currently check for nomodeset, make this driver
> >> to also support the command line parameter.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>   drivers/gpu/drm/rcar-du/rcar_du_drv.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> index 5a8131ef81d5..982e450233ed 100644
> >> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> @@ -701,6 +701,9 @@ static struct platform_driver rcar_du_platform_driver = {
> >>   
> >>   static int __init rcar_du_init(void)
> >>   {
> >> +       if (drm_firmware_drivers_only())
> >> +               return -ENODEV;
> >> +
> > 
> > This will completely disable all control of the display device when
> > nomodeset is enabled.
> > 
> > Is there any requirement for us to support outputting to the display if
> > it was previously set up? presumably without setting or changing any
> > modes, but simply allowing the existing frame to be updated?
> 
> There's no requirement for your driver. We just want a parameter where 
> we can conveniently disable most of DRM's drivers and reduce it to a 
> minimum. Helps distributions to provide a simple fallback mode.  Most 
> PCI-based drivers already support that. Now we're added it to the other 
> drivers as well.
> 
> > 
> > I think the implication is that 'firmware drivers' would mean a display
> > could be updated through some firmware interface, which we won't have
> > ... so it seems reasonable to accept that this whole driver can be
> > disabled in that instance.
> 
> It cannot be 'mode-setted'. We get a pre-configured framebuffer from the 
> firmware or bootloader. Whatever we draw there shows up on the screen.

I doubt that's going to work as you expect, clocks and regulators will
get disabled at boot if not used by any driver.

> > Reading your mail that brought this thread up in my inbox, I think
> > you've already hit merge on this, so don't worry about adding a tag in
> > that instance, but I think this is ok.
> > 
> > Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> >>          rcar_du_of_init(rcar_du_of_table);
> >>   
> >>          return platform_driver_register(&rcar_du_platform_driver);

-- 
Regards,

Laurent Pinchart
