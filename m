Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E0590528
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiHKQyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiHKQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:53:54 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAA0A98DB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:26:53 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10cf9f5b500so22104214fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5J2eH8J3KSl2i4YDEioQLvvMu1VvonnCUhWQOwBSDRw=;
        b=g5NLb4S5XMMgc+h6eG+K38NaBHb92GcTAzTX77Jua8RvMjEfTYydyLtADeo/smWoT9
         5THR+29CZPyFptA0p63FWuVu2HLssx5ppjo+jarmSd9O0s5QS6V9yX28IulVq6uJbUVx
         whwcctoxwZeSdZW9PrsJFgC9mN9xCUNP5qkEnKTjubG6xCHvdvKl0d48LbDXOq/mq/ui
         vMsNvLcrbw6Cr/CCCvVcMkfq3+bc+eIhFA2fvjdnuxlXMWhF9QAaZLyZT9JTVnEL7Snk
         GJS2tz0QlJiRXNB8FkE+aEa/hrR2mZvVEt8crfWb1lAUSJlWQgwkZmFjcrinNLp5vWbJ
         qZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5J2eH8J3KSl2i4YDEioQLvvMu1VvonnCUhWQOwBSDRw=;
        b=wfRje8kK7rn1uoGqhbl7q6wRnfxtX/pnEB3xSGqWNWwtFOfZl5+0ang3APxffFwg8Z
         MLXPRtOGj7rKFo6019T8NNVsClnPbuIianPJH7ELxYPlBlVUfC2imnDnvj7A6TJry+ek
         cpWiLn1GuJ+ygUPF6RVky+vWcF/F0qweJEEDv1THCTDyO7nEC1sbdq+eNdYTy55bhQJd
         6sriIXlGRqlaE4ueksj3oVLI7Fv8p6MPnX0VtYJYNyP7JWVKF1WYZCvqTe+ZjbUCmwPK
         OYXY76MhiHjHDmXDh7x0HeUR55jhmymtu8zoZyCM9IWGDdlqJTrpf1y4/Ryozp+/EDZz
         EmMg==
X-Gm-Message-State: ACgBeo3TjQ2by5Nm+cJUcX0ERQkv7UGdppLS0jC2EPccGSNUtTqaTECK
        7F8ZcQI/Qyvo2yZSuN9tflLomMfigvM2PZqAxIg=
X-Google-Smtp-Source: AA6agR6gwmUJ5JYVJhxblwMwPCs6Fab74OrRJm7YlWzO6etz4AwDRdeZ4nBqzVap0+TZfCco+KRx0oX0DaxKDa6r5DM=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr3826646oae.33.1660235212490; Thu, 11
 Aug 2022 09:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220811162307.1384962-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220811162307.1384962-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 11 Aug 2022 12:26:41 -0400
Message-ID: <CADnq5_MiH6_n5nnq5KW+LMxMyHtm0Mwmb7e5pi=Pr2S8Hjjiog@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix DSC related non-x86/PPC64
 compilation issue
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Leo Li <sunpeng.li@amd.com>, dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, Aug 11, 2022 at 12:24 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> Need to protect DSC code with CONFIG_DRM_AMD_DC_DCN.
> Fixes the following build errors on arm64:
> ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> Fixes: 0087990a9f57 ("drm/amd/display: consider DSC pass-through during mode validation")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index ef6c94cd852b..0c52c0867211 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1387,8 +1387,6 @@ bool pre_validate_dsc(struct drm_atomic_state *state,
>         return (ret == 0);
>  }
>
> -#endif
> -
>  static unsigned int kbps_from_pbn(unsigned int pbn)
>  {
>         unsigned int kbps = pbn;
> @@ -1416,6 +1414,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
>
>         return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
>  }
> +#endif /* CONFIG_DRM_AMD_DC_DCN */
>
>  enum dc_status dm_dp_mst_is_port_support_mode(
>         struct amdgpu_dm_connector *aconnector,
> @@ -1428,6 +1427,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>         struct dc_dsc_bw_range bw_range = {0};
>         int bpp, pbn, branch_max_throughput_mps = 0;
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         /*
>          * check if the mode could be supported if DSC pass-through is supported
>          * AND check if there enough bandwidth available to support the mode
> @@ -1461,13 +1461,16 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                         return DC_FAIL_BANDWIDTH_VALIDATE;
>                 }
>         } else {
> +#endif
>                 /* check if mode could be supported within full_pbn */
>                 bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
>                 pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, false);
>
>                 if (pbn > aconnector->port->full_pbn)
>                         return DC_FAIL_BANDWIDTH_VALIDATE;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         }
> +#endif
>
>         /* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
>         switch (stream->timing.pixel_encoding) {
> --
> 2.37.1
>
