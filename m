Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3ED590658
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiHKS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiHKS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:26:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EAA9C8E3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:26:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p8so17575986plq.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DNRqJUO9qW+nOcXv54/BTKzSqJWHyKLs5RY2LsJLtKw=;
        b=xc0VQ/tXgJI3CNx3hHgICA6Z2jEuWQ/uwjKgyzakD9pvtgaib073alKdtAxe0Exz6L
         bCPUdYQlVzM/Nz34uuK70LSXiBfUUpNlWrLM04+G0Z/lyuj3csGesp6p/8HBaJt/ni7h
         dFQpnrFXf6UysrTohohxCGSYXB0YL5yavCBJVPNucgXlVuXS7kpF34mYcyi5hEgIvFVA
         cagr9VMwdF45mDJH4T6ptGgJj+Kdubuw1TKk4Myhx7t5Enjky8wMVggeTrTv0vs4s7j+
         XsXjpefcMOWDJuiFpemFXUieXEf/r9K3HvRTkfedaBD7pgZoaNs6uXO1W55AL8q5uOSd
         OVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DNRqJUO9qW+nOcXv54/BTKzSqJWHyKLs5RY2LsJLtKw=;
        b=NrOKbdzvyBXNzGLovOD67S35l5+/qRGg6wloP+UtdWrO96BHr6EWFtQ6anAWHT1ViK
         TnsPOyuk4Jla1FJ+jhmPnF8D96fcJvkXjnvxqqEZRzWZ1Nc8DBa/X56b940AZFrN7l+3
         ZumS+eKqkOL00Mg5yhunh833Dgx+WxvNhOd/H9c0SZTHrCG/iRf3AKmS2fsRgKqsaDw2
         DIvnjoZbc1bUS5u+LF86BW9/7u3boSsxbFXB7j7xd4x5BuFTuDQusZU4ry55FARBQi3D
         lUeUI6+LZ6xobAXxd27MeLjPQ6nbFCNTF2NQg+8nBFh2WuAcd6IQBG+Xn2rwK4TpBrvj
         MsIA==
X-Gm-Message-State: ACgBeo26mPtvwh2ivPtfmPZpr38Z4ZVb42JZS+WyGIjPzGmPLB0Jf3/p
        UnB8q8XA+OwgNDNKXJi9goUNNnp9bv+Bm65+DeF4Ag==
X-Google-Smtp-Source: AA6agR6E7weULEtj7kwVFvfsBwBE4Gop3xNBO3A8utdizicMa/BbTEIuAq5NU9tKxnYE47khriF2jMkXLkNBAs4yiHY=
X-Received: by 2002:a17:903:120d:b0:171:4fa0:7b4a with SMTP id
 l13-20020a170903120d00b001714fa07b4amr381532plh.45.1660242375230; Thu, 11 Aug
 2022 11:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <CADVatmN_TzJKdfM40BQPW=cRm5VxX=qAKxq2yW4P_xDN6=VoOA@mail.gmail.com>
 <20220811175759.1518840-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220811175759.1518840-1-hamza.mahfooz@amd.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 11 Aug 2022 20:26:04 +0200
Message-ID: <CADYN=9JgX6PVhes_9cbL4qFEjyiYhbpHMXTB-oEdn4j9Rz3tJA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix DSC related non-x86/PPC64
 compilation issue
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        hersen wu <hersenxs.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 at 20:00, Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> Need to protect DSC code with CONFIG_DRM_AMD_DC_DCN.
> Fixes the following build errors on arm64:
> ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> Fixes: 0087990a9f57 ("drm/amd/display: consider DSC pass-through during mode validation")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Thank you for the quick fix.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
> v2: Fix WERROR build failure by guarding unused variables
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index ef6c94cd852b..ce6929224a6e 100644
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
> @@ -1416,17 +1414,19 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
>
>         return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
>  }
> +#endif /* CONFIG_DRM_AMD_DC_DCN */
>
>  enum dc_status dm_dp_mst_is_port_support_mode(
>         struct amdgpu_dm_connector *aconnector,
>         struct dc_stream_state *stream)
>  {
> +       int bpp, pbn, branch_max_throughput_mps = 0;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         struct dc_link_settings cur_link_settings;
>         unsigned int end_to_end_bw_in_kbps = 0;
>         unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
>         unsigned int max_compressed_bw_in_kbps = 0;
>         struct dc_dsc_bw_range bw_range = {0};
> -       int bpp, pbn, branch_max_throughput_mps = 0;
>
>         /*
>          * check if the mode could be supported if DSC pass-through is supported
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
