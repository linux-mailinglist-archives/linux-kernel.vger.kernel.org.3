Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601CA578A90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiGRTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiGRTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:20:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C752ED64
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:20:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so23080534eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDVNBc5XFFotjrwcydHiypKXUfp1J1vJ62G1p2tMV7U=;
        b=EJ/i0KJbHMhLxMbMKiPgUB+Ict+QTFLWIizt2rzN6Mpuseg9ivTpkRHifKSoauZXdr
         K99ieViZW/J8eAIa50eUtNDmKo2UBd+zELvGikiVob3lJTp4CNYzO2tIUyRu6SqWZiy/
         26GrO13LXaJPVpChcY3s0tMFzhdTQ/HLX7q/UpUK+W+BU1UMCFBUsXY6GcxMnrmWieGH
         5b9VAhdgS8GQ+m1WIi0mXyR4LdUgp3WVdLQDTSoffyoWa87ZEdzTdeqTDZRKkbzjyDW6
         ZMQkPm8sK15ubhCHc3hgSW1hftVdya748mT8RXSJdgJEfgh6eazy/9K2MYm3QW0A+BV5
         5VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDVNBc5XFFotjrwcydHiypKXUfp1J1vJ62G1p2tMV7U=;
        b=bpbJFEh0+052x9pE1XA5u3Ne8wmEp4pXcIbB0AmXhc7VlQwWEU1wPhjsNDAe0mtBDF
         aEQUBcc1AOkCtt//H5uq97GfI0Wbp36tIaQ82eTay20B8o3boKLzpuGwIBL9xMupLJYX
         cSrJk5d5ypNJXSaDnTj3HJkClwhSBfGs5VDnTwHc/Q+6V/8/uVn8fdCu6odY1KvxlkSt
         dd2UJEbrKvpdyvuTckHSGTuS7ynA81fsAen9PYPfZnlrQDnLcDlCtQZnhBMsTh6/d8CU
         dDXOeqIAnlXTK4EpjSVF3ySJphsOGWnG3CQLcGcpHUgsh33Y9Gri0Y6ms8l7RV8Czc5G
         0H8Q==
X-Gm-Message-State: AJIora8tD9q0CLNHXOsmBbKKJag+ycfNE79lOWjLtiPgR2Dxhj+FRQ8X
        8iveQYWsnuuldhePWJumjb/C6E0W/6M0SjUObKo=
X-Google-Smtp-Source: AGRyM1ur2bqm5pr5cbh5rgKbT3pVk/P8Dls3bG/jth0KuxuUuRorDatAm+HJDMCix4gcpdnhluhJceIdy1X/+KT1aoM=
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id
 hb35-20020a170907162300b0072b64e3878amr27869282ejc.185.1658172010375; Mon, 18
 Jul 2022 12:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220716195144.342960-1-mwen@igalia.com>
In-Reply-To: <20220716195144.342960-1-mwen@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 15:19:57 -0400
Message-ID: <CADnq5_PYbVMKwfDhxAU2GEKG_CBB7QHohirX2WkCn33k6cVkug@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: move dcn31_update_soc_for_wm_a func to
 dml fpu folder
To:     Melissa Wen <mwen@igalia.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel-dev@igalia.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with a trivial fix for dcn314_resource.c.

Thanks!

Alex

On Sat, Jul 16, 2022 at 3:52 PM Melissa Wen <mwen@igalia.com> wrote:
>
> Although dcn31_update_soc_for_wm_a() is only called in dml/dcn31/dcn31_fpu by
> dc->res_pool->funcs->update_soc_for_wm_a(dc, context), it's declared in
> dcn31_resource that is not FPU protected. Move this function to dcn31_fpu
> file as part of the work to isolate FPU code.
>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 9 ---------
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h | 1 -
>  drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 9 +++++++++
>  drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  | 2 ++
>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 16bbccc69fdc..17c776e88514 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1716,15 +1716,6 @@ int dcn31_populate_dml_pipes_from_context(
>         return pipe_cnt;
>  }
>
> -void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
> -{
> -       if (dc->clk_mgr->bw_params->wm_table.entries[WM_A].valid) {
> -               context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].pstate_latency_us;
> -               context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_enter_plus_exit_time_us;
> -               context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_exit_time_us;
> -       }
> -}
> -
>  void dcn31_calculate_wm_and_dlg(
>                 struct dc *dc, struct dc_state *context,
>                 display_e2e_pipe_params_st *pipes,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
> index 393458015d6a..41f8ec99da6b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
> @@ -59,7 +59,6 @@ dcn31_set_mcif_arb_params(struct dc *dc,
>                           struct dc_state *context,
>                           display_e2e_pipe_params_st *pipes,
>                           int pipe_cnt);
> -void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
>
>  struct resource_pool *dcn31_create_resource_pool(
>                 const struct dc_init_data *init_data,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> index 7be3476989ce..facac3daeaca 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> @@ -435,6 +435,15 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
>         .urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
>  };
>
> +void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
> +{
> +       if (dc->clk_mgr->bw_params->wm_table.entries[WM_A].valid) {
> +               context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].pstate_latency_us;
> +               context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_enter_plus_exit_time_us;
> +               context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_exit_time_us;
> +       }
> +}
> +
>  void dcn31_calculate_wm_and_dlg_fp(
>                 struct dc *dc, struct dc_state *context,
>                 display_e2e_pipe_params_st *pipes,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
> index 24ac19c83687..0a10de80c1a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
> @@ -31,6 +31,8 @@
>  #define DCN3_15_MIN_COMPBUF_SIZE_KB 128
>  #define DCN3_16_DEFAULT_DET_SIZE 192
>
> +void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
> +
>  void dcn31_calculate_wm_and_dlg_fp(
>                 struct dc *dc, struct dc_state *context,
>                 display_e2e_pipe_params_st *pipes,
> --
> 2.35.1
>
