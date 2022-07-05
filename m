Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6166E567274
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiGEPXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGEPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:23:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7E1036
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:23:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so22251281ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ly1jZz5akE/c0HYsm9XqK6PUqioIjWfxQyei0YBT/CM=;
        b=KslsP71OtkjY/RUON8rZ4XWDQkNUzzPk0fC5My/KASx5nhO3fL4PbOkRJA6GfdMoKg
         5lmjkp4Z02Uoumrb+s4gV1ymIuASV5Wd+rtevMPwVsjKWGfN4UvjGGr8VN4S9VpNJBPP
         9NSl6dbXG8Z2LjbW3fJiBS0Of5tRirW9AZ5sc5G74vr5cTwq4DTnsytQAwLrhL04Vk2z
         +uX2pdLrZKHNJM5vwfVqRAUeObwN117pBfNl1u7Zq65nBghKgVP0GZDdmsHxDm2kgmcD
         5A5IMCK3+MHJldiEQBQSM/wPCjABJriTeKkTdZgShhKqeiASdTMJps38xkVLoKUF6h9Q
         Ov6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ly1jZz5akE/c0HYsm9XqK6PUqioIjWfxQyei0YBT/CM=;
        b=Mc1Bv2JxTYl1LZuL/qvfbOB2nJjvda8cb0uMMHQnNPZ9l13KUw9wdlu1IgOwoDhLSw
         3mbNN1OLIUWkax1L9ZQsglnczcZTBnBu8Nv79RRI51OVwUe95m/BQYwr6h+o5xp6uSNM
         sfWrWzx4yUX6SVmsdDGLHQSMFpxm/SqShTW+OhQe87hUl0xpKCpYzICIN6Pq6b/m63mg
         ksIP8K4NnZ5BcfI0nP/c6SUMku2YBkoSLj72thdA2JwIrIl0gAmouQmMqI5wsMIzKHUu
         pythFQX8XKt8pqeYUftyGUaiqNUE91ndCGwMhlTe8YOct+k8iIjS9F720wpkFW5g1IH2
         eXUQ==
X-Gm-Message-State: AJIora/D6AJNA5jDdtUd3ftnYsY1AiBo83Kh+ymbKN4vV2XMVdyeZLuv
        bCRl1KduGS1lYUMKi8R2EAQ2swb12AXZkGvMVsk=
X-Google-Smtp-Source: AGRyM1vNtvUgITUCrpn1uASVCZj8dDlEmqEj6qQftT/8d7ijGepwFN90JNaSqxtnjv98fM6KoPRBdsFZkzSSjywRPko=
X-Received: by 2002:a17:907:a40f:b0:726:a8f5:1031 with SMTP id
 sg15-20020a170907a40f00b00726a8f51031mr35064739ejc.185.1657034609068; Tue, 05
 Jul 2022 08:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220630201741.991501-1-mairacanal@riseup.net>
In-Reply-To: <20220630201741.991501-1-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Jul 2022 11:23:16 -0400
Message-ID: <CADnq5_O3gX_fpMN1Bzd3Av7Kfoc+EC0t_pcJLVipHeRgv32jcg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate code across dcn30 and dcn31
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jun 30, 2022 at 4:18 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> The function CalculateBytePerPixelAnd256BBlockSizes was defined four
> times: on display_mode_vba_30.c, display_rq_dlg_calc_30.c,
> display_mode_vba_31.c and display_rq_dlg_calc_31.c. In order to avoid
> code duplication, the CalculateBytePerPixelAnd256BBlockSizes is defined
> on display_mode_vba_30.h and used across dcn30 and dcn31.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn30/display_mode_vba_30.c        |  21 +---
>  .../dc/dml/dcn30/display_mode_vba_30.h        |  11 ++
>  .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  93 +--------------
>  .../dc/dml/dcn31/display_mode_vba_31.c        | 106 +-----------------
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  91 +--------------
>  5 files changed, 23 insertions(+), 299 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index fb4aa4c800bf..842eb94ebe04 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -712,18 +712,6 @@ static double CalculateUrgentLatency(
>                 double UrgentLatencyAdjustmentFabricClockReference,
>                 double FabricClockSingle);
>
> -static bool CalculateBytePerPixelAnd256BBlockSizes(
> -               enum source_format_class SourcePixelFormat,
> -               enum dm_swizzle_mode SurfaceTiling,
> -               unsigned int *BytePerPixelY,
> -               unsigned int *BytePerPixelC,
> -               double       *BytePerPixelDETY,
> -               double       *BytePerPixelDETC,
> -               unsigned int *BlockHeight256BytesY,
> -               unsigned int *BlockHeight256BytesC,
> -               unsigned int *BlockWidth256BytesY,
> -               unsigned int *BlockWidth256BytesC);
> -
>  void dml30_recalculate(struct display_mode_lib *mode_lib)
>  {
>         ModeSupportAndSystemConfiguration(mode_lib);
> @@ -2095,7 +2083,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchPar=
ametersWatermarksAndPerforman
>         DTRACE("   return_bus_bw      =3D %f", v->ReturnBW);
>
>         for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
> -               CalculateBytePerPixelAnd256BBlockSizes(
> +               dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                                 v->SourcePixelFormat[k],
>                                 v->SurfaceTiling[k],
>                                 &v->BytePerPixelY[k],
> @@ -3165,7 +3153,7 @@ static void DisplayPipeConfiguration(struct display=
_mode_lib *mode_lib)
>
>         for (k =3D 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
>
> -               CalculateBytePerPixelAnd256BBlockSizes(
> +               dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                                 mode_lib->vba.SourcePixelFormat[k],
>                                 mode_lib->vba.SurfaceTiling[k],
>                                 &BytePerPixY[k],
> @@ -3218,7 +3206,7 @@ static void DisplayPipeConfiguration(struct display=
_mode_lib *mode_lib)
>                         &dummysinglestring);
>  }
>
> -static bool CalculateBytePerPixelAnd256BBlockSizes(
> +void dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                 enum source_format_class SourcePixelFormat,
>                 enum dm_swizzle_mode SurfaceTiling,
>                 unsigned int *BytePerPixelY,
> @@ -3305,7 +3293,6 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
>                 *BlockWidth256BytesY =3D 256U / *BytePerPixelY / *BlockHe=
ight256BytesY;
>                 *BlockWidth256BytesC =3D 256U / *BytePerPixelC / *BlockHe=
ight256BytesC;
>         }
> -       return true;
>  }
>
>  static double CalculateTWait(
> @@ -3709,7 +3696,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(st=
ruct display_mode_lib *mode_l
>         /*Bandwidth Support Check*/
>
>         for (k =3D 0; k <=3D v->NumberOfActivePlanes - 1; k++) {
> -               CalculateBytePerPixelAnd256BBlockSizes(
> +               dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                                 v->SourcePixelFormat[k],
>                                 v->SurfaceTiling[k],
>                                 &v->BytePerPixelY[k],
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> index 4e249eaabfdb..daaf0883b84d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> @@ -39,5 +39,16 @@ double dml30_CalculateWriteBackDISPCLK(
>                 long   WritebackDestinationWidth,
>                 unsigned int HTotal,
>                 unsigned int WritebackLineBufferSize);
> +void dml30_CalculateBytePerPixelAnd256BBlockSizes(
> +               enum source_format_class SourcePixelFormat,
> +               enum dm_swizzle_mode SurfaceTiling,
> +               unsigned int *BytePerPixelY,
> +               unsigned int *BytePerPixelC,
> +               double       *BytePerPixelDETY,
> +               double       *BytePerPixelDETC,
> +               unsigned int *BlockHeight256BytesY,
> +               unsigned int *BlockHeight256BytesC,
> +               unsigned int *BlockWidth256BytesY,
> +               unsigned int *BlockWidth256BytesC);
>
>  #endif /* __DML30_DISPLAY_MODE_VBA_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc=
_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> index 747167083dea..8179be1f34bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> @@ -29,6 +29,7 @@
>  #include "../display_mode_vba.h"
>  #include "../dml_inline_defs.h"
>  #include "display_rq_dlg_calc_30.h"
> +#include "display_mode_vba_30.h"
>
>  static bool is_dual_plane(enum source_format_class source_format)
>  {
> @@ -275,96 +276,6 @@ static void handle_det_buf_split(struct display_mode=
_lib *mode_lib,
>                 full_swath_bytes_packed_c);
>  }
>
> -static bool CalculateBytePerPixelAnd256BBlockSizes(
> -               enum source_format_class SourcePixelFormat,
> -               enum dm_swizzle_mode SurfaceTiling,
> -               unsigned int *BytePerPixelY,
> -               unsigned int *BytePerPixelC,
> -               double       *BytePerPixelDETY,
> -               double       *BytePerPixelDETC,
> -               unsigned int *BlockHeight256BytesY,
> -               unsigned int *BlockHeight256BytesC,
> -               unsigned int *BlockWidth256BytesY,
> -               unsigned int *BlockWidth256BytesC)
> -{
> -       if (SourcePixelFormat =3D=3D dm_444_64) {
> -               *BytePerPixelDETY =3D 8;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 8;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_32 || SourcePixelForma=
t =3D=3D dm_rgbe) {
> -               *BytePerPixelDETY =3D 4;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 4;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_16) {
> -               *BytePerPixelDETY =3D 2;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_8) {
> -               *BytePerPixelDETY =3D 1;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 1;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_rgbe_alpha) {
> -               *BytePerPixelDETY =3D 4;
> -               *BytePerPixelDETC =3D 1;
> -               *BytePerPixelY =3D 4;
> -               *BytePerPixelC =3D 1;
> -       } else if (SourcePixelFormat =3D=3D dm_420_8) {
> -               *BytePerPixelDETY =3D 1;
> -               *BytePerPixelDETC =3D 2;
> -               *BytePerPixelY =3D 1;
> -               *BytePerPixelC =3D 2;
> -       } else if (SourcePixelFormat =3D=3D dm_420_12) {
> -               *BytePerPixelDETY =3D 2;
> -               *BytePerPixelDETC =3D 4;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 4;
> -       } else {
> -               *BytePerPixelDETY =3D 4.0 / 3;
> -               *BytePerPixelDETC =3D 8.0 / 3;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 4;
> -       }
> -
> -       if ((SourcePixelFormat =3D=3D dm_444_64 || SourcePixelFormat =3D=
=3D dm_444_32
> -                       || SourcePixelFormat =3D=3D dm_444_16 || SourcePi=
xelFormat =3D=3D dm_444_8
> -                       || SourcePixelFormat =3D=3D dm_mono_16 || SourceP=
ixelFormat =3D=3D dm_mono_8
> -                       || SourcePixelFormat =3D=3D dm_rgbe)) {
> -               if (SurfaceTiling =3D=3D dm_sw_linear) {
> -                       *BlockHeight256BytesY =3D 1;
> -               } else if (SourcePixelFormat =3D=3D dm_444_64) {
> -                       *BlockHeight256BytesY =3D 4;
> -               } else if (SourcePixelFormat =3D=3D dm_444_8) {
> -                       *BlockHeight256BytesY =3D 16;
> -               } else {
> -                       *BlockHeight256BytesY =3D 8;
> -               }
> -               *BlockWidth256BytesY =3D 256U / *BytePerPixelY / *BlockHe=
ight256BytesY;
> -               *BlockHeight256BytesC =3D 0;
> -               *BlockWidth256BytesC =3D 0;
> -       } else {
> -               if (SurfaceTiling =3D=3D dm_sw_linear) {
> -                       *BlockHeight256BytesY =3D 1;
> -                       *BlockHeight256BytesC =3D 1;
> -               } else if (SourcePixelFormat =3D=3D dm_rgbe_alpha) {
> -                       *BlockHeight256BytesY =3D 8;
> -                       *BlockHeight256BytesC =3D 16;
> -               } else if (SourcePixelFormat =3D=3D dm_420_8) {
> -                       *BlockHeight256BytesY =3D 16;
> -                       *BlockHeight256BytesC =3D 8;
> -               } else {
> -                       *BlockHeight256BytesY =3D 8;
> -                       *BlockHeight256BytesC =3D 8;
> -               }
> -               *BlockWidth256BytesY =3D 256U / *BytePerPixelY / *BlockHe=
ight256BytesY;
> -               *BlockWidth256BytesC =3D 256U / *BytePerPixelC / *BlockHe=
ight256BytesC;
> -       }
> -       return true;
> -}
> -
>  static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
>         display_data_rq_dlg_params_st *rq_dlg_param,
>         display_data_rq_misc_params_st *rq_misc_param,
> @@ -450,7 +361,7 @@ static void get_meta_and_pte_attr(struct display_mode=
_lib *mode_lib,
>         double byte_per_pixel_det_y =3D 0;
>         double byte_per_pixel_det_c =3D 0;
>
> -       CalculateBytePerPixelAnd256BBlockSizes((enum source_format_class)=
(source_format),
> +       dml30_CalculateBytePerPixelAnd256BBlockSizes((enum source_format_=
class)(source_format),
>                 (enum dm_swizzle_mode)(tiling),
>                 &bytes_per_element_y,
>                 &bytes_per_element_c,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> index 448fbbcdf88a..9957313da732 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> @@ -26,6 +26,7 @@
>  #include "dc.h"
>  #include "dc_link.h"
>  #include "../display_mode_lib.h"
> +#include "dml/dcn30/display_mode_vba_30.h"
>  #include "display_mode_vba_31.h"
>  #include "../dml_inline_defs.h"
>
> @@ -86,17 +87,6 @@ typedef struct {
>  #define BPP_INVALID 0
>  #define BPP_BLENDED_PIPE 0xffffffff
>
> -static bool CalculateBytePerPixelAnd256BBlockSizes(
> -               enum source_format_class SourcePixelFormat,
> -               enum dm_swizzle_mode SurfaceTiling,
> -               unsigned int *BytePerPixelY,
> -               unsigned int *BytePerPixelC,
> -               double *BytePerPixelDETY,
> -               double *BytePerPixelDETC,
> -               unsigned int *BlockHeight256BytesY,
> -               unsigned int *BlockHeight256BytesC,
> -               unsigned int *BlockWidth256BytesY,
> -               unsigned int *BlockWidth256BytesC);
>  static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib);
>  static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP=
erformanceCalculation(struct display_mode_lib *mode_lib);
>  static unsigned int dscceComputeDelay(
> @@ -2220,7 +2210,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchPar=
ametersWatermarksAndPerforman
>         DTRACE("   return_bus_bw      =3D %f", v->ReturnBW);
>
>         for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
> -               CalculateBytePerPixelAnd256BBlockSizes(
> +               dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                                 v->SourcePixelFormat[k],
>                                 v->SurfaceTiling[k],
>                                 &v->BytePerPixelY[k],
> @@ -3415,7 +3405,7 @@ static void DisplayPipeConfiguration(struct display=
_mode_lib *mode_lib)
>
>         for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
>
> -               CalculateBytePerPixelAnd256BBlockSizes(
> +               dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                                 v->SourcePixelFormat[k],
>                                 v->SurfaceTiling[k],
>                                 &BytePerPixY[k],
> @@ -3469,94 +3459,6 @@ static void DisplayPipeConfiguration(struct displa=
y_mode_lib *mode_lib)
>                         &dummysinglestring);
>  }
>
> -static bool CalculateBytePerPixelAnd256BBlockSizes(
> -               enum source_format_class SourcePixelFormat,
> -               enum dm_swizzle_mode SurfaceTiling,
> -               unsigned int *BytePerPixelY,
> -               unsigned int *BytePerPixelC,
> -               double *BytePerPixelDETY,
> -               double *BytePerPixelDETC,
> -               unsigned int *BlockHeight256BytesY,
> -               unsigned int *BlockHeight256BytesC,
> -               unsigned int *BlockWidth256BytesY,
> -               unsigned int *BlockWidth256BytesC)
> -{
> -       if (SourcePixelFormat =3D=3D dm_444_64) {
> -               *BytePerPixelDETY =3D 8;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 8;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_32 || SourcePixelForma=
t =3D=3D dm_rgbe) {
> -               *BytePerPixelDETY =3D 4;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 4;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_16) {
> -               *BytePerPixelDETY =3D 2;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_8) {
> -               *BytePerPixelDETY =3D 1;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 1;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_rgbe_alpha) {
> -               *BytePerPixelDETY =3D 4;
> -               *BytePerPixelDETC =3D 1;
> -               *BytePerPixelY =3D 4;
> -               *BytePerPixelC =3D 1;
> -       } else if (SourcePixelFormat =3D=3D dm_420_8) {
> -               *BytePerPixelDETY =3D 1;
> -               *BytePerPixelDETC =3D 2;
> -               *BytePerPixelY =3D 1;
> -               *BytePerPixelC =3D 2;
> -       } else if (SourcePixelFormat =3D=3D dm_420_12) {
> -               *BytePerPixelDETY =3D 2;
> -               *BytePerPixelDETC =3D 4;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 4;
> -       } else {
> -               *BytePerPixelDETY =3D 4.0 / 3;
> -               *BytePerPixelDETC =3D 8.0 / 3;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 4;
> -       }
> -
> -       if ((SourcePixelFormat =3D=3D dm_444_64 || SourcePixelFormat =3D=
=3D dm_444_32 || SourcePixelFormat =3D=3D dm_444_16 || SourcePixelFormat =
=3D=3D dm_444_8 || SourcePixelFormat =3D=3D dm_mono_16
> -                       || SourcePixelFormat =3D=3D dm_mono_8 || SourcePi=
xelFormat =3D=3D dm_rgbe)) {
> -               if (SurfaceTiling =3D=3D dm_sw_linear) {
> -                       *BlockHeight256BytesY =3D 1;
> -               } else if (SourcePixelFormat =3D=3D dm_444_64) {
> -                       *BlockHeight256BytesY =3D 4;
> -               } else if (SourcePixelFormat =3D=3D dm_444_8) {
> -                       *BlockHeight256BytesY =3D 16;
> -               } else {
> -                       *BlockHeight256BytesY =3D 8;
> -               }
> -               *BlockWidth256BytesY =3D 256U / *BytePerPixelY / *BlockHe=
ight256BytesY;
> -               *BlockHeight256BytesC =3D 0;
> -               *BlockWidth256BytesC =3D 0;
> -       } else {
> -               if (SurfaceTiling =3D=3D dm_sw_linear) {
> -                       *BlockHeight256BytesY =3D 1;
> -                       *BlockHeight256BytesC =3D 1;
> -               } else if (SourcePixelFormat =3D=3D dm_rgbe_alpha) {
> -                       *BlockHeight256BytesY =3D 8;
> -                       *BlockHeight256BytesC =3D 16;
> -               } else if (SourcePixelFormat =3D=3D dm_420_8) {
> -                       *BlockHeight256BytesY =3D 16;
> -                       *BlockHeight256BytesC =3D 8;
> -               } else {
> -                       *BlockHeight256BytesY =3D 8;
> -                       *BlockHeight256BytesC =3D 8;
> -               }
> -               *BlockWidth256BytesY =3D 256U / *BytePerPixelY / *BlockHe=
ight256BytesY;
> -               *BlockWidth256BytesC =3D 256U / *BytePerPixelC / *BlockHe=
ight256BytesC;
> -       }
> -       return true;
> -}
> -
>  static double CalculateTWait(unsigned int PrefetchMode, double DRAMClock=
ChangeLatency, double UrgentLatency, double SREnterPlusExitTime)
>  {
>         if (PrefetchMode =3D=3D 0) {
> @@ -4066,7 +3968,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(st=
ruct display_mode_lib *mode_l
>         /*Bandwidth Support Check*/
>
>         for (k =3D 0; k < v->NumberOfActivePlanes; k++) {
> -               CalculateBytePerPixelAnd256BBlockSizes(
> +               dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                                 v->SourcePixelFormat[k],
>                                 v->SurfaceTiling[k],
>                                 &v->BytePerPixelY[k],
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc=
_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> index dd570689c095..c94cf6e01e25 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
> @@ -27,94 +27,7 @@
>  #include "../display_mode_vba.h"
>  #include "../dml_inline_defs.h"
>  #include "display_rq_dlg_calc_31.h"
> -
> -static bool CalculateBytePerPixelAnd256BBlockSizes(
> -               enum source_format_class SourcePixelFormat,
> -               enum dm_swizzle_mode SurfaceTiling,
> -               unsigned int *BytePerPixelY,
> -               unsigned int *BytePerPixelC,
> -               double *BytePerPixelDETY,
> -               double *BytePerPixelDETC,
> -               unsigned int *BlockHeight256BytesY,
> -               unsigned int *BlockHeight256BytesC,
> -               unsigned int *BlockWidth256BytesY,
> -               unsigned int *BlockWidth256BytesC)
> -{
> -       if (SourcePixelFormat =3D=3D dm_444_64) {
> -               *BytePerPixelDETY =3D 8;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 8;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_32 || SourcePixelForma=
t =3D=3D dm_rgbe) {
> -               *BytePerPixelDETY =3D 4;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 4;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_16) {
> -               *BytePerPixelDETY =3D 2;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_444_8) {
> -               *BytePerPixelDETY =3D 1;
> -               *BytePerPixelDETC =3D 0;
> -               *BytePerPixelY =3D 1;
> -               *BytePerPixelC =3D 0;
> -       } else if (SourcePixelFormat =3D=3D dm_rgbe_alpha) {
> -               *BytePerPixelDETY =3D 4;
> -               *BytePerPixelDETC =3D 1;
> -               *BytePerPixelY =3D 4;
> -               *BytePerPixelC =3D 1;
> -       } else if (SourcePixelFormat =3D=3D dm_420_8) {
> -               *BytePerPixelDETY =3D 1;
> -               *BytePerPixelDETC =3D 2;
> -               *BytePerPixelY =3D 1;
> -               *BytePerPixelC =3D 2;
> -       } else if (SourcePixelFormat =3D=3D dm_420_12) {
> -               *BytePerPixelDETY =3D 2;
> -               *BytePerPixelDETC =3D 4;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 4;
> -       } else {
> -               *BytePerPixelDETY =3D 4.0 / 3;
> -               *BytePerPixelDETC =3D 8.0 / 3;
> -               *BytePerPixelY =3D 2;
> -               *BytePerPixelC =3D 4;
> -       }
> -
> -       if ((SourcePixelFormat =3D=3D dm_444_64 || SourcePixelFormat =3D=
=3D dm_444_32 || SourcePixelFormat =3D=3D dm_444_16 || SourcePixelFormat =
=3D=3D dm_444_8 || SourcePixelFormat =3D=3D dm_mono_16
> -                       || SourcePixelFormat =3D=3D dm_mono_8 || SourcePi=
xelFormat =3D=3D dm_rgbe)) {
> -               if (SurfaceTiling =3D=3D dm_sw_linear) {
> -                       *BlockHeight256BytesY =3D 1;
> -               } else if (SourcePixelFormat =3D=3D dm_444_64) {
> -                       *BlockHeight256BytesY =3D 4;
> -               } else if (SourcePixelFormat =3D=3D dm_444_8) {
> -                       *BlockHeight256BytesY =3D 16;
> -               } else {
> -                       *BlockHeight256BytesY =3D 8;
> -               }
> -               *BlockWidth256BytesY =3D 256U / *BytePerPixelY / *BlockHe=
ight256BytesY;
> -               *BlockHeight256BytesC =3D 0;
> -               *BlockWidth256BytesC =3D 0;
> -       } else {
> -               if (SurfaceTiling =3D=3D dm_sw_linear) {
> -                       *BlockHeight256BytesY =3D 1;
> -                       *BlockHeight256BytesC =3D 1;
> -               } else if (SourcePixelFormat =3D=3D dm_rgbe_alpha) {
> -                       *BlockHeight256BytesY =3D 8;
> -                       *BlockHeight256BytesC =3D 16;
> -               } else if (SourcePixelFormat =3D=3D dm_420_8) {
> -                       *BlockHeight256BytesY =3D 16;
> -                       *BlockHeight256BytesC =3D 8;
> -               } else {
> -                       *BlockHeight256BytesY =3D 8;
> -                       *BlockHeight256BytesC =3D 8;
> -               }
> -               *BlockWidth256BytesY =3D 256U / *BytePerPixelY / *BlockHe=
ight256BytesY;
> -               *BlockWidth256BytesC =3D 256U / *BytePerPixelC / *BlockHe=
ight256BytesC;
> -       }
> -       return true;
> -}
> +#include "dml/dcn30/display_mode_vba_30.h"
>
>  static bool is_dual_plane(enum source_format_class source_format)
>  {
> @@ -467,7 +380,7 @@ static void get_meta_and_pte_attr(
>         double byte_per_pixel_det_y;
>         double byte_per_pixel_det_c;
>
> -       CalculateBytePerPixelAnd256BBlockSizes(
> +       dml30_CalculateBytePerPixelAnd256BBlockSizes(
>                         (enum source_format_class) (source_format),
>                         (enum dm_swizzle_mode) (tiling),
>                         &bytes_per_element_y,
> --
> 2.36.1
>
