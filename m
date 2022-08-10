Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2A58EFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiHJP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiHJP4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:56:42 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268511B1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:55:11 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w197so5164302oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=2NpBJL5Oejk+iIT/DC4B4ULXoEjQZcdGj6m0d833WQA=;
        b=MPtrFXnEut25sx1mauN7GkjxQFXYWnErQi6Qiw+n13qy3voobf7+V0bUkNNN/0lhso
         tnG2IdUgV1jlK2VW+2Tk6A8wxt8YvGh8AsjSdtcFyKu8RI7DQWph6F3PrXUwZQClPdmO
         xi4fIAdLFy5spwFTFQAaUz1kiWt+9FiodjWwPXAZ8sOGNwy4pF2qn6Z1m9BdKf9a56vt
         eXN7fkyeFSZ53vqYHlS8ySMboqF7rrSuFsFgZPOP+R/ujdP0TXTl+yNfO9cRZnv/Vnw6
         shB24KcngB+tL8y12aVBFD29F4y54KwaCVgry/XkMgGvIu5jdo8u5xt3//JP4/oj6Awz
         SrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2NpBJL5Oejk+iIT/DC4B4ULXoEjQZcdGj6m0d833WQA=;
        b=YdG0U763tgseI+J0per+z4DpqvEoriwlxNyK2+9EkFwS5c17Z9+Gl/UEoni09KmWa/
         E3Td3c9548G61djhlb+o9pqEo+KXxIf7Hf4QfXtEMUCTC6qvLBkJl7YceY6+kfNy/8td
         7R+0sYBOjlXJunKliduTkKUZqBphkPRFy9y1FdwFUqvReZfUKntctL7ER0fLh0Sz19tO
         +p/uA8LEx5XSyVik2M7UKfCTUA0RX4McAk6OXFc+WRlSWWtaxFN4VzyBAMGoyFq2fhyq
         gByghj9UNP3EPoUn16E4RKCdfRXmpmPtxbLgNkbG/OfX0tGjXAiCKkDKQxN2Qt34H1Un
         Bhyg==
X-Gm-Message-State: ACgBeo1pnKy4NMRirdUYIiMwoLKXg5NOxzfn6wtw2mKsc920hq7daN9m
        CU+hvHkY9nyKryDl/FTcnNBnpf/imWxLOYtX2U3f3GbO
X-Google-Smtp-Source: AA6agR7VJ4Gq4aAbczhaMc7F1e1T0a4pBOSkdraFXe8AfkbUglogtPnjuXMnm1P81QXwHYC2Oe5+be9FyxXJxmzjcoQ=
X-Received: by 2002:a05:6808:19a3:b0:33e:1525:3fb4 with SMTP id
 bj35-20020a05680819a300b0033e15253fb4mr1697185oib.106.1660146910438; Wed, 10
 Aug 2022 08:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220726182152.123649-1-andrealmeid@igalia.com> <20220726182152.123649-3-andrealmeid@igalia.com>
In-Reply-To: <20220726182152.123649-3-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Aug 2022 11:54:59 -0400
Message-ID: <CADnq5_N45m1Ce76bX6VnLWE6GgsqGCdmWmrSvgjEF=meEWf-jQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/amd/pm: Implement GFXOFF's entry count and
 residency for vangogh
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        kernel-dev@igalia.com
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

On Tue, Jul 26, 2022 at 2:23 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Implement functions to get and set GFXOFF's entry count and residency
> for vangogh.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  5 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  5 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 92 +++++++++++++++++++
>  3 files changed, 100 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index fe130a497d6c..7471e2df2828 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -108,7 +108,10 @@
>  #define PPSMC_MSG_SetSlowPPTLimit                      0x4A
>  #define PPSMC_MSG_GetFastPPTLimit                      0x4B
>  #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
> -#define PPSMC_Message_Count                            0x4D
> +#define PPSMC_MSG_GetGfxOffStatus                     0x50
> +#define PPSMC_MSG_GetGfxOffEntryCount                 0x51
> +#define PPSMC_MSG_LogGfxOffResidency                  0x52
> +#define PPSMC_Message_Count                            0x53
>
>  //Argument for PPSMC_MSG_GfxDeviceDriverReset
>  enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_types.h
> index 19084a4fcb2b..76fb6cbbc09c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -235,7 +235,10 @@
>         __SMU_DUMMY_MAP(UnforceGfxVid),           \
>         __SMU_DUMMY_MAP(HeavySBR),                      \
>         __SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel), \
> -       __SMU_DUMMY_MAP(EnableGfxImu),
> +       __SMU_DUMMY_MAP(EnableGfxImu),                  \
> +       __SMU_DUMMY_MAP(GetGfxOffStatus),                \
> +       __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
> +       __SMU_DUMMY_MAP(LogGfxOffResidency),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 89504ff8e9ed..4e547573698b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -138,6 +138,9 @@ static struct cmn2asic_msg_mapping vangogh_message_ma=
p[SMU_MSG_MAX_COUNT] =3D {
>         MSG_MAP(SetSlowPPTLimit,                    PPSMC_MSG_SetSlowPPTL=
imit,                                          0),
>         MSG_MAP(GetFastPPTLimit,                    PPSMC_MSG_GetFastPPTL=
imit,                                          0),
>         MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTL=
imit,                                          0),
> +       MSG_MAP(GetGfxOffStatus,                    PPSMC_MSG_GetGfxOffSt=
atus,                                          0),
> +       MSG_MAP(GetGfxOffEntryCount,                PPSMC_MSG_GetGfxOffEn=
tryCount,                                      0),
> +       MSG_MAP(LogGfxOffResidency,                 PPSMC_MSG_LogGfxOffRe=
sidency,                                       0),
>  };
>
>  static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUN=
T] =3D {
> @@ -2200,6 +2203,92 @@ static int vangogh_set_power_limit(struct smu_cont=
ext *smu,
>         return ret;
>  }
>
> +/**
> + * vangogh_set_gfxoff_residency
> + *
> + * @smu: amdgpu_device pointer
> + * @start: start/stop residency log
> + *
> + * This function will be used to log gfxoff residency
> + *
> + *
> + * Returns standard response codes.
> + */
> +static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool st=
art)
> +{
> +       int ret =3D 0;
> +       u32 residency;
> +       struct amdgpu_device *adev =3D smu->adev;
> +
> +       switch (adev->ip_versions[MP1_HWIP][0]) {
> +       case IP_VERSION(11, 5, 0):

Minor nit, but you can drip the IP version checks here.  This whole
file is specific to 11.5.

> +               if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> +                       return 0;
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogG=
fxOffResidency,
> +                                                     start, &residency);
> +               if (!start)
> +                       adev->gfx.gfx_off_residency =3D residency;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * vangogh_get_gfxoff_residency
> + *
> + * @smu: amdgpu_device pointer
> + *
> + * This function will be used to get gfxoff residency.
> + *
> + * Returns standard response codes.
> + */
> +static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_=
t *residency)
> +{
> +       int ret =3D 0;
> +       struct amdgpu_device *adev =3D smu->adev;
> +
> +       switch (adev->ip_versions[MP1_HWIP][0]) {
> +       case IP_VERSION(11, 5, 0):

Same here.

> +               *residency =3D adev->gfx.gfx_off_residency;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * vangogh_get_gfxoff_entrycount - get gfxoff entry count
> + *
> + * @smu: amdgpu_device pointer
> + *
> + * This function will be used to get gfxoff entry count
> + *
> + * Returns standard response codes.
> + */
> +static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64=
_t *entrycount)
> +{
> +       int ret =3D 0, value =3D 0;
> +       struct amdgpu_device *adev =3D smu->adev;
> +
> +       switch (adev->ip_versions[MP1_HWIP][0]) {
> +       case IP_VERSION(11, 5, 0):
> +               if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> +                       return 0;
> +               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetGfxOffEntryC=
ount, &value);
> +               *entrycount =3D value + adev->gfx.gfx_off_entrycount;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  static const struct pptable_funcs vangogh_ppt_funcs =3D {
>
>         .check_fw_status =3D smu_v11_0_check_fw_status,
> @@ -2237,6 +2326,9 @@ static const struct pptable_funcs vangogh_ppt_funcs=
 =3D {
>         .mode2_reset =3D vangogh_mode2_reset,
>         .gfx_off_control =3D smu_v11_0_gfx_off_control,
>         .get_gfx_off_status =3D vangogh_get_gfxoff_status,
> +       .get_gfx_off_entrycount =3D vangogh_get_gfxoff_entrycount,
> +       .get_gfx_off_residency =3D vangogh_get_gfxoff_residency,
> +       .set_gfx_off_residency =3D vangogh_set_gfxoff_residency,
>         .get_ppt_limit =3D vangogh_get_ppt_limit,
>         .get_power_limit =3D vangogh_get_power_limit,
>         .set_power_limit =3D vangogh_set_power_limit,
> --
> 2.37.1
>
