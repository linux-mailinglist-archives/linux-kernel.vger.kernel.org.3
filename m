Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9627651763F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386778AbiEBSFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbiEBSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:05:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7093113D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:01:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A023484;
        Mon,  2 May 2022 20:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651514511;
        bh=67dJ41o3vCWN4qbsLwb+8WQiFi5Hhk+5gnF+lEfS/O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wY8yZ28zD03WpGE6pKLG8r5qRoXLg1yZi9pNrc+T3Rin4Kb2QID5s5ge3R3VlmrM5
         /38QaJTAweQJLJMPywP/5/3yS9mx1D9hP9f+13JjqIYMONKrp6w4dyzMIxg7vrlrKu
         +pRHjxOuAOcm+Efn0ecFW3wk/j7U0MC3KhGR7UFE=
Date:   Mon, 2 May 2022 21:01:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Message-ID: <YnAcj9O3l/qLc5ss@pendragon.ideasonboard.com>
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-4-javierm@redhat.com>
 <YnAEDlikr+d8cvy4@pendragon.ideasonboard.com>
 <9556f080-d309-f396-6d28-1190bc94cc38@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9556f080-d309-f396-6d28-1190bc94cc38@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Mon, May 02, 2022 at 07:09:17PM +0200, Javier Martinez Canillas wrote:
> On 5/2/22 18:17, Laurent Pinchart wrote:
> > On Mon, May 02, 2022 at 05:39:00PM +0200, Javier Martinez Canillas wrote:
> >> Indicate to fbdev subsystem that the registered framebuffer is provided by
> >> the system firmware, so that it can handle accordingly. For example, would
> >> unregister the FB devices if asked to remove the conflicting framebuffers.
> >>
> >> Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
> >> Drivers can use this to indicate the FB helper initialization that the FB
> >> registered is provided by the firmware, so it can be configured as such.
> >>
> >> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>  drivers/gpu/drm/drm_fb_helper.c  |  9 +++++++++
> >>  drivers/gpu/drm/tiny/simpledrm.c |  2 +-
> >>  include/drm/drm_fb_helper.h      | 10 ++++++++++
> >>  3 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> >> index fd0084ad77c3..775e47c5de1f 100644
> >> --- a/drivers/gpu/drm/drm_fb_helper.c
> >> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >> @@ -1891,6 +1891,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
> >>  		/* don't leak any physical addresses to userspace */
> >>  		info->flags |= FBINFO_HIDE_SMEM_START;
> >>  
> >> +	/* Indicate that the framebuffer is provided by the firmware */
> >> +	if (fb_helper->firmware)
> >> +		info->flags |= FBINFO_MISC_FIRMWARE;
> >> +
> >>  	/* Need to drop locks to avoid recursive deadlock in
> >>  	 * register_framebuffer. This is ok because the only thing left to do is
> >>  	 * register the fbdev emulation instance in kernel_fb_helper_list. */
> >> @@ -2512,6 +2516,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
> >>   *
> >>   * * DRM_FB_BPP: bits per pixel for the device. If the field is not set,
> >>   *   @dev->mode_config.preferred_depth is used instead.
> >> + * * DRM_FB_FW: if the framebuffer for the device is provided by the
> >> + *   system firmware.
> >>   *
> >>   * This function sets up generic fbdev emulation for drivers that supports
> >>   * dumb buffers with a virtual address and that can be mmap'ed.
> >> @@ -2538,6 +2544,7 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
> >>  {
> >>  	struct drm_fb_helper *fb_helper;
> >>  	unsigned int preferred_bpp = DRM_FB_GET_OPTION(DRM_FB_BPP, options);
> >> +	bool firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);
> >>  	int ret;
> >>  
> >>  	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
> >> @@ -2570,6 +2577,8 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
> >>  		preferred_bpp = 32;
> >>  	fb_helper->preferred_bpp = preferred_bpp;
> >>  
> >> +	fb_helper->firmware = firmware;
> > 
> > I'd get rid of the local variable and write
> >
> 
> I actually considered that but then decided to add a local variable to
> have both options set in the same place, since I thought that would be
> easier to read and also consistent with how preferred_bpp is handled.
> 
> Maybe I could go the other way around and rework patch 2/3 to also not
> require a preferred_bpp local variable ? That patch won't be as small
> as it's now though. -- 

Up to you, or you could ignore the comment, it's minor. If you want to
keep the variable, you could also make it const, it's a good practice to
show it isn't intended to be modified.

-- 
Regards,

Laurent Pinchart
