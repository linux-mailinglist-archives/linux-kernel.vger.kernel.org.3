Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47F4AC6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357424AbiBGQ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344852AbiBGQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:54:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F4C0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1F36B812AA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE54C004E1;
        Mon,  7 Feb 2022 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644252871;
        bh=ZhCOMln0Zt5onmq74lvlwpZ3OfaHsYGRSVchu6lO+i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoH0Sklp/HpYS+1O2MEju3lzMw6MFoHYmoNUVkt7h71Xc3kOgUsdt/MF3jE9qG/fh
         SpPvDrOPpM1nSKu3WbxkPhHxacfSBUomPbOkV6CWJ5ytSZ0Oes7z7xsIssV+TJT+g0
         7fn0OCTGl6IwBlXyqimlw19GqhMQodQYmpib6mnxJVca5Bb3e4fjB+cbDlDP7ylDEZ
         L/VEY4S5jrlU3/7SVPpAkrbseOMB1sy2hBABFDe+hC6pNHAqmwr6UDmvDZFRniIrux
         DsADCI7jjJ9ZawX77pU3m4V6vWufLfmsdDVKy0O+D0xKr+Mx2GFOPyXrt5uPPXM//O
         SAHEwT093ecGg==
Date:   Mon, 7 Feb 2022 09:54:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     yannick Fertre <yannick.fertre@foss.st.com>
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/stm: ltdc: add support of ycbcr pixel formats
Message-ID: <YgFOwl896WjY6DHM@dev-arch.archlinux-ax161>
References: <20211215214843.20703-1-yannick.fertre@foss.st.com>
 <Yfq3XwozrxYaFhgD@dev-arch.archlinux-ax161>
 <7bd0a0a9-4015-b54c-f745-f813496be61b@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd0a0a9-4015-b54c-f745-f813496be61b@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 11:00:34AM +0100, yannick Fertre wrote:
> Hi Nathan,
> 
> On 2/2/22 17:54, Nathan Chancellor wrote:
> > Hi Yannick,
> > 
> > On Wed, Dec 15, 2021 at 10:48:43PM +0100, Yannick Fertre wrote:
> > > This patch adds the following YCbCr input pixel formats on the latest
> > > LTDC hardware version:
> > > 
> > > 1 plane  (co-planar)  : YUYV, YVYU, UYVY, VYUY
> > > 2 planes (semi-planar): NV12, NV21
> > > 3 planes (full-planar): YU12=I420=DRM YUV420, YV12=DRM YVU420
> > > 
> > > Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> > 
> > <snip>
> > 
> > > +static inline void ltdc_set_ycbcr_config(struct drm_plane *plane, u32 drm_pix_fmt)
> > > +{
> > > +	struct ltdc_device *ldev = plane_to_ltdc(plane);
> > > +	struct drm_plane_state *state = plane->state;
> > > +	u32 lofs = plane->index * LAY_OFS;
> > > +	u32 val;
> > > +
> > > +	switch (drm_pix_fmt) {
> > > +	case DRM_FORMAT_YUYV:
> > > +		val = (YCM_I << 4) | LxPCR_YF | LxPCR_CBF;
> > > +		break;
> > > +	case DRM_FORMAT_YVYU:
> > > +		val = (YCM_I << 4) | LxPCR_YF;
> > > +		break;
> > > +	case DRM_FORMAT_UYVY:
> > > +		val = (YCM_I << 4) | LxPCR_CBF;
> > > +		break;
> > > +	case DRM_FORMAT_VYUY:
> > > +		val = (YCM_I << 4);
> > > +		break;
> > > +	case DRM_FORMAT_NV12:
> > > +		val = (YCM_SP << 4) | LxPCR_CBF;
> > > +		break;
> > > +	case DRM_FORMAT_NV21:
> > > +		val = (YCM_SP << 4);
> > > +		break;
> > > +	case DRM_FORMAT_YUV420:
> > > +	case DRM_FORMAT_YVU420:
> > > +		val = (YCM_FP << 4);
> > > +		break;
> > > +	default:
> > > +		/* RGB or not a YCbCr supported format */
> > > +		break;
> > > +	}
> > > +
> > > +	/* Enable limited range */
> > > +	if (state->color_range == DRM_COLOR_YCBCR_LIMITED_RANGE)
> > > +		val |= LxPCR_YREN;
> > > +
> > > +	/* enable ycbcr conversion */
> > > +	val |= LxPCR_YCEN;
> > > +
> > > +	regmap_write(ldev->regmap, LTDC_L1PCR + lofs, val);
> > > +}
> > 
> > This patch as commit 484e72d3146b ("drm/stm: ltdc: add support of ycbcr
> > pixel formats") in -next introduced the following clang warning:
> > 
> > drivers/gpu/drm/stm/ltdc.c:625:2: warning: variable 'val' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
> >          default:
> >          ^~~~~~~
> > drivers/gpu/drm/stm/ltdc.c:635:2: note: uninitialized use occurs here
> >          val |= LxPCR_YCEN;
> >          ^~~
> > drivers/gpu/drm/stm/ltdc.c:600:9: note: initialize the variable 'val' to silence this warning
> >          u32 val;
> >                 ^
> >                  = 0
> > 1 warning generated.
> > 
> > Would it be okay to just return in the default case (maybe with a
> > message about an unsupported format?) or should there be another fix?
> > 
> > Cheers,
> 
> 
> Thanks for your help.
> It'okay for a message for unsupported format with a return in the default
> case.
> Do you want create & push the patch?

Thank you for the input! I have sent a fix now, please take a look.

https://lore.kernel.org/r/20220207165304.1046867-1-nathan@kernel.org/

Cheers,
Nathan
