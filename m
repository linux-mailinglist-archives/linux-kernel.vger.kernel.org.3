Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC749F7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbiA1LFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347954AbiA1LFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:05:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA3C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:05:12 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7862A471;
        Fri, 28 Jan 2022 12:05:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643367910;
        bh=4Xn27GmT4IPOILu+mnZMOLuRnykp9Oh/JgVsxlEnZfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLF/9TQZzYyt2QniaKwAnwWN1GGnk4U/7s83fRZzQLas83YEtqH7CV9CtHHds5/h2
         XDPs759dvxRALAdMpMDQIHA5gkV4OEw8Bd15jkAiYD6KJdAcKPEF1vjJwT1VUemGrX
         42GQGbkhJgGKM8BbOzxcQ6wdz6zvZbZ3z3GN53GE=
Date:   Fri, 28 Jan 2022 13:04:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/37] drm: rcar-du: Add support for the nomodeset
 kernel parameter
Message-ID: <YfPN0fLfvWFC6mha@pendragon.ideasonboard.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
 <20211217003752.3946210-32-javierm@redhat.com>
 <164336121612.533872.1685181669511488706@Monstersaurus>
 <eb27fa44-2972-4a6e-465f-b9e4775820f4@suse.de>
 <YfPGnfly3GOAOlfp@pendragon.ideasonboard.com>
 <584f1343-b285-bf8e-e48c-764c2a56bce3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <584f1343-b285-bf8e-e48c-764c2a56bce3@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jan 28, 2022 at 11:46:49AM +0100, Thomas Zimmermann wrote:
> Am 28.01.22 um 11:34 schrieb Laurent Pinchart:
> > On Fri, Jan 28, 2022 at 10:33:21AM +0100, Thomas Zimmermann wrote:
> >> Am 28.01.22 um 10:13 schrieb Kieran Bingham:
> >>> Quoting Javier Martinez Canillas (2021-12-17 00:37:46)
> >>>> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> >>>> parameter can be used to disable kernel modesetting.
> >>>>
> >>>> DRM drivers will not perform display-mode changes or accelerated rendering
> >>>> and only the system framebuffer will be available if it was set-up.
> >>>
> >>> What is the 'system framebuffer' in this instance? Reading
> >>> https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt
> >>> it sounds like that means anything already set up by the bootloader.
> >>
> >> Exactly this.
> >>
> >>>> But only a few DRM drivers currently check for nomodeset, make this driver
> >>>> to also support the command line parameter.
> >>>>
> >>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >>>> ---
> >>>>
> >>>> (no changes since v1)
> >>>>
> >>>>    drivers/gpu/drm/rcar-du/rcar_du_drv.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>>> index 5a8131ef81d5..982e450233ed 100644
> >>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>>> @@ -701,6 +701,9 @@ static struct platform_driver rcar_du_platform_driver = {
> >>>>    
> >>>>    static int __init rcar_du_init(void)
> >>>>    {
> >>>> +       if (drm_firmware_drivers_only())
> >>>> +               return -ENODEV;
> >>>> +
> >>>
> >>> This will completely disable all control of the display device when
> >>> nomodeset is enabled.
> >>>
> >>> Is there any requirement for us to support outputting to the display if
> >>> it was previously set up? presumably without setting or changing any
> >>> modes, but simply allowing the existing frame to be updated?
> >>
> >> There's no requirement for your driver. We just want a parameter where
> >> we can conveniently disable most of DRM's drivers and reduce it to a
> >> minimum. Helps distributions to provide a simple fallback mode.  Most
> >> PCI-based drivers already support that. Now we're added it to the other
> >> drivers as well.
> >>
> >>>
> >>> I think the implication is that 'firmware drivers' would mean a display
> >>> could be updated through some firmware interface, which we won't have
> >>> ... so it seems reasonable to accept that this whole driver can be
> >>> disabled in that instance.
> >>
> >> It cannot be 'mode-setted'. We get a pre-configured framebuffer from the
> >> firmware or bootloader. Whatever we draw there shows up on the screen.
> > 
> > I doubt that's going to work as you expect, clocks and regulators will
> > get disabled at boot if not used by any driver.
> 
> Simpledrm and simplefb attach to these firmware framebuffers. Both 
> drivers look at the device tree nodes to acquire the relevant clocks and 
> regulators.

How about clocks and regulators for the ancillary devices, such as
encoders, or in the R-Car case, the external composer handled by the
vsp1 driver (in drivers/media/platform/vsp1) ?

This approach may work fine on x86 desktop systems, but for ARM-based
devices, the situation is usually more complex.

> >>> Reading your mail that brought this thread up in my inbox, I think
> >>> you've already hit merge on this, so don't worry about adding a tag in
> >>> that instance, but I think this is ok.
> >>>
> >>> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >>>
> >>>>           rcar_du_of_init(rcar_du_of_table);
> >>>>    
> >>>>           return platform_driver_register(&rcar_du_platform_driver);

-- 
Regards,

Laurent Pinchart
