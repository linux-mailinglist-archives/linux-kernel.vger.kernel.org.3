Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550BF54CF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiFOQ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiFOQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:56:17 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA6E4EA1A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:56:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-fe15832ce5so17241440fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocMgTzRkWH3eBYp2u/PAG0Fm6G35s0xKn8yvsRpMe88=;
        b=f9YhM52ySsPsP9RkggdjlzhlY3Kl0Zt9sCMg1sPl2ipMDfCj7Apt1+HeR26+sE7a+g
         Pd+vcOvk+nLPs7LcTOv6kyfhOmc2h1rBo8n3L9Z8TPxX3XZiVDICAlkPK5cfU77z3TRN
         oBepdA0T/Oq2wz6XGLBbg4DhivuOWkaSv6Y1KFPebi+KVrU1RyJu35M8yZ22SPCMIGOP
         tETIlAvLk5XgExpOhZBCvGy/CUM6DrtZczDyEVArLA8tDgf8IHi2mnT5XeN1gccR+lxY
         FbS14v3u5iuj2I1OzaMjRWtgbgPXwaN+S0mfG6cjh7tv5fNwI0QTYOqkxj3uScPVhjpD
         rqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocMgTzRkWH3eBYp2u/PAG0Fm6G35s0xKn8yvsRpMe88=;
        b=CL99wd5FW7tsFQ6YMnbOkkMfD13B26RHsmC8JJIvklUoGF8/O+afzydatxuyTJMyU9
         hmuDKAT5x8ae25ktikMh3aACPoUZvMq3+HZu+Sz7RuFe77yNkTO/3keDPIly30KI8U8H
         FOxmvKECHrwSCW07RkidozF033u/8G1t5oQjPsAGVweCH+EHgwLZanxzIboDItjHmocM
         KxNBZSDgyRBLo4Owj7jFDDu1Av9MkV3/5146xIXYRxh1z0a6oNAACUmx9XNwuWkt5LNd
         k9PhBDgN2Jp1HbGWIKMiEd7itAWHCmxwFUHjllXTZeLaAVcALG+Y3YzZm2MlMGbzVFGp
         itiA==
X-Gm-Message-State: AJIora8srwkX1Wg+bBawJPVsRs9K2hsrkfhLp3j0wYrxFTIA4mKt/jNB
        lHgc0vbzmxlGK3OH5uYqIgmFk7gK89Gp9Lu8ZPE=
X-Google-Smtp-Source: AGRyM1t2ME88iAIQzsGcfH0HXLVexL004pXS5sohWl/TRzf7/ndK7Zv2s3VsmqHQflAW2BGdKo6sVu6zokuo770HPuc=
X-Received: by 2002:a05:6870:538b:b0:101:17f2:d6e with SMTP id
 h11-20020a056870538b00b0010117f20d6emr5908958oan.200.1655312174819; Wed, 15
 Jun 2022 09:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220615122458.20145-1-hongao@uniontech.com>
In-Reply-To: <20220615122458.20145-1-hongao@uniontech.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Jun 2022 12:56:03 -0400
Message-ID: <CADnq5_P-A2UeCu9oRpXYRTXdeeZNEKPst_gnfZf7g+QWrZWBdQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
To:     hongao <hongao@uniontech.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>, inhui.Pan@amd.com,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 8:33 AM hongao <hongao@uniontech.com> wrote:
>
> Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi for more
> efficiency
>
> Tested on "Oland [Radeon HD 8570 / R7 240/340 OEM]" & "Caicos [R5 230]"

Can you verify that drm_display_info.is_hdmi has been populated when
all of these functions are called?

Alex

>
> Signed-off-by: hongao <hongao@uniontech.com>
> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c |  6 +++---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 12 ++++++------
>  drivers/gpu/drm/radeon/radeon_display.c    |  2 +-
>  drivers/gpu/drm/radeon/radeon_encoders.c   |  4 ++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
> index 70bd84b7ef2b..393d471ba396 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -714,7 +714,7 @@ atombios_get_encoder_mode(struct drm_encoder *encoder)
>                         if (radeon_connector->use_digital &&
>                             (radeon_connector->audio == RADEON_AUDIO_ENABLE))
>                                 return ATOM_ENCODER_MODE_HDMI;
> -                       else if (drm_detect_hdmi_monitor(radeon_connector_edid(connector)) &&
> +                       else if (connector->display_info.is_hdmi &&
>                                  (radeon_connector->audio == RADEON_AUDIO_AUTO))
>                                 return ATOM_ENCODER_MODE_HDMI;
>                         else if (radeon_connector->use_digital)
> @@ -733,7 +733,7 @@ atombios_get_encoder_mode(struct drm_encoder *encoder)
>                 if (radeon_audio != 0) {
>                         if (radeon_connector->audio == RADEON_AUDIO_ENABLE)
>                                 return ATOM_ENCODER_MODE_HDMI;
> -                       else if (drm_detect_hdmi_monitor(radeon_connector_edid(connector)) &&
> +                       else if (connector->display_info.is_hdmi &&
>                                  (radeon_connector->audio == RADEON_AUDIO_AUTO))
>                                 return ATOM_ENCODER_MODE_HDMI;
>                         else
> @@ -757,7 +757,7 @@ atombios_get_encoder_mode(struct drm_encoder *encoder)
>                 } else if (radeon_audio != 0) {
>                         if (radeon_connector->audio == RADEON_AUDIO_ENABLE)
>                                 return ATOM_ENCODER_MODE_HDMI;
> -                       else if (drm_detect_hdmi_monitor(radeon_connector_edid(connector)) &&
> +                       else if (connector->display_info.is_hdmi &&
>                                  (radeon_connector->audio == RADEON_AUDIO_AUTO))
>                                 return ATOM_ENCODER_MODE_HDMI;
>                         else
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 58db79921cd3..2fbec7bdd56b 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -130,7 +130,7 @@ int radeon_get_monitor_bpc(struct drm_connector *connector)
>         case DRM_MODE_CONNECTOR_DVII:
>         case DRM_MODE_CONNECTOR_HDMIB:
>                 if (radeon_connector->use_digital) {
> -                       if (drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +                       if (connector->display_info.is_hdmi) {
>                                 if (connector->display_info.bpc)
>                                         bpc = connector->display_info.bpc;
>                         }
> @@ -138,7 +138,7 @@ int radeon_get_monitor_bpc(struct drm_connector *connector)
>                 break;
>         case DRM_MODE_CONNECTOR_DVID:
>         case DRM_MODE_CONNECTOR_HDMIA:
> -               if (drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +               if (connector->display_info.is_hdmi) {
>                         if (connector->display_info.bpc)
>                                 bpc = connector->display_info.bpc;
>                 }
> @@ -147,7 +147,7 @@ int radeon_get_monitor_bpc(struct drm_connector *connector)
>                 dig_connector = radeon_connector->con_priv;
>                 if ((dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT) ||
>                     (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_eDP) ||
> -                   drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +                   connector->display_info.is_hdmi) {
>                         if (connector->display_info.bpc)
>                                 bpc = connector->display_info.bpc;
>                 }
> @@ -171,7 +171,7 @@ int radeon_get_monitor_bpc(struct drm_connector *connector)
>                 break;
>         }
>
> -       if (drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +       if (connector->display_info.is_hdmi) {
>                 /* hdmi deep color only implemented on DCE4+ */
>                 if ((bpc > 8) && !ASIC_IS_DCE4(rdev)) {
>                         DRM_DEBUG("%s: HDMI deep color %d bpc unsupported. Using 8 bpc.\n",
> @@ -1500,7 +1500,7 @@ static enum drm_mode_status radeon_dvi_mode_valid(struct drm_connector *connecto
>                     (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
>                     (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B))
>                         return MODE_OK;
> -               else if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +               else if (ASIC_IS_DCE6(rdev) && connector->display_info.is_hdmi) {
>                         /* HDMI 1.3+ supports max clock of 340 Mhz */
>                         if (mode->clock > 340000)
>                                 return MODE_CLOCK_HIGH;
> @@ -1808,7 +1808,7 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
>                     (radeon_dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_eDP)) {
>                         return radeon_dp_mode_valid_helper(connector, mode);
>                 } else {
> -                       if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +                       if (ASIC_IS_DCE6(rdev) && connector->display_info.is_hdmi) {
>                                 /* HDMI 1.3+ supports max clock of 340 Mhz */
>                                 if (mode->clock > 340000)
>                                         return MODE_CLOCK_HIGH;
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
> index 57ff2b723c87..c7a1e3af55cf 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -1728,7 +1728,7 @@ bool radeon_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
>                             (!(mode->flags & DRM_MODE_FLAG_INTERLACE)) &&
>                             ((radeon_encoder->underscan_type == UNDERSCAN_ON) ||
>                              ((radeon_encoder->underscan_type == UNDERSCAN_AUTO) &&
> -                             drm_detect_hdmi_monitor(radeon_connector_edid(connector)) &&
> +                             connector->display_info.is_hdmi &&
>                               is_hdtv_mode(mode)))) {
>                                 if (radeon_encoder->underscan_hborder != 0)
>                                         radeon_crtc->h_border = radeon_encoder->underscan_hborder;
> diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
> index 46549d5179ee..b999464f213a 100644
> --- a/drivers/gpu/drm/radeon/radeon_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_encoders.c
> @@ -383,7 +383,7 @@ bool radeon_dig_monitor_is_duallink(struct drm_encoder *encoder,
>         case DRM_MODE_CONNECTOR_HDMIB:
>                 if (radeon_connector->use_digital) {
>                         /* HDMI 1.3 supports up to 340 Mhz over single link */
> -                       if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +                       if (ASIC_IS_DCE6(rdev) && connector->display_info.is_hdmi) {
>                                 if (pixel_clock > 340000)
>                                         return true;
>                                 else
> @@ -408,7 +408,7 @@ bool radeon_dig_monitor_is_duallink(struct drm_encoder *encoder,
>                         return false;
>                 else {
>                         /* HDMI 1.3 supports up to 340 Mhz over single link */
> -                       if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
> +                       if (ASIC_IS_DCE6(rdev) && connector->display_info.is_hdmi) {
>                                 if (pixel_clock > 340000)
>                                         return true;
>                                 else
> --
> 2.20.1
>
>
>
>
