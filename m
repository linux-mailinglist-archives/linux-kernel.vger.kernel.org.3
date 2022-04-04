Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA174F14EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbiDDMeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiDDMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A6F4252A2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649075551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bfu/mStPYG5d1Vz4TNDHt4/dv4CJ9ungTZX6DsULc/o=;
        b=M+NX7fAacIP/Ta7CsCh+KH6V7xFde9/UusozISZRksI4fiB6CE1o+fLj3QnVbrC8jJcNG0
        KNRWboGBi9BPswq1exdE5U4XaQNpAogtEfW0owf9c2YCxErAiWVec3c+ZB/POGMnJXk+VF
        NgeH45G9Qqg/fIoI9N9JgbwGg3SBCc4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-WjHAUVeEOwm529YGWtBuZw-1; Mon, 04 Apr 2022 08:32:30 -0400
X-MC-Unique: WjHAUVeEOwm529YGWtBuZw-1
Received: by mail-qv1-f71.google.com with SMTP id m12-20020ad45dcc000000b00443d70cc310so2383066qvh.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 05:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Bfu/mStPYG5d1Vz4TNDHt4/dv4CJ9ungTZX6DsULc/o=;
        b=Tg1hHACCZ2a8qH69JCRquiNwgDwBdLpUaX3F1FpA+Cqm0s9KuUPlctol/sdh4wDgg/
         +sBrrWICEM2eQxADHglY0baW4783YEUsoLS/+FTtJQ7EsBXMpTHVpPSgUipXH4MeECDN
         vjqXLsGlDjJpZEcsCoeSp2pNKQc/MBq6yFFhXIMKMaFW3YladV3BcgoQvXYATDqQUnfv
         mi2ckEibKOp3SGSU1305KxCpMSxF8PrFmhuP64cuJVaR/1f0r+pGQvf3hMIsdf3Bg9sE
         oORSmYce8u4AJduDOCfMw2iUDeRrjj3aK6rza2/Ry+UkBe+dbD6zOOBE2SxB7YI1L2Sg
         t8yQ==
X-Gm-Message-State: AOAM532FJ1GSgXIPAJhGXKV2UBHkvEBrksydYx9U5iObGyM732R7Xfra
        x951ozc1AkxVGtdbz1ctUB+9PgIxQXKwwmArGGAHdV/NFH4dr8azSPFrCjj9yUtseN/I85jdwa5
        2NY0WzKbDbu4uChlc5CvtzO1S
X-Received: by 2002:a37:a608:0:b0:67b:27c5:3251 with SMTP id p8-20020a37a608000000b0067b27c53251mr13162587qke.516.1649075549866;
        Mon, 04 Apr 2022 05:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyENZ0sDO3KgVpl+tt/qGUZXRXuC+4jtLgV16tEmVvwC9divMIrV3uGThF2bTlpVJqJjicbzg==
X-Received: by 2002:a37:a608:0:b0:67b:27c5:3251 with SMTP id p8-20020a37a608000000b0067b27c53251mr13162565qke.516.1649075549473;
        Mon, 04 Apr 2022 05:32:29 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a064700b002e238d6db02sm8597932qtb.54.2022.04.04.05.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:32:29 -0700 (PDT)
Subject: Re: [PATCH] drm/radeon: change si_default_state table from global to
 static
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20220402162750.2805433-1-trix@redhat.com>
 <9e407616-47b5-ad16-bd16-cde23684fc69@amd.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <12b2fd82-174a-6f05-0de6-02b6f0d2a1d6@redhat.com>
Date:   Mon, 4 Apr 2022 05:32:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9e407616-47b5-ad16-bd16-cde23684fc69@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/22 8:23 AM, Christian König wrote:
> Am 02.04.22 um 18:27 schrieb Tom Rix:
>> Smatch reports these issues
>> si_blit_shaders.c:31:11: warning: symbol 'si_default_state'
>>    was not declared. Should it be static?
>> si_blit_shaders.c:253:11: warning: symbol 'si_default_size'
>>    was not declared. Should it be static?
>>
>> Both symbols are only used in si.c.  Single file symbols
>> should be static.  So move the si_default_state and
>> si_default_size to si.c and change their
>> storage-class-specifier to static.
>>
>> Remove unneeded si_blit_shaders.[c|h]
>
> Uff, well NAK.
>
> IIRC this was intentionally moved into a separate file because it is 
> rather large and not related to anything in si.c.
>
> It's unlikely that we are ever going to update it, but I would still 
> rather want to keep it separated.
>
> You should rather just include si_blit_shaders.h in si_blit_shaders.c.

Do you mean #include "si_blit_shaders.c" in si.c or similar ?

This could have the same effect of while keeping these separate failes

Tom

>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/radeon/Makefile          |   2 +-
>>   drivers/gpu/drm/radeon/si.c              | 224 +++++++++++++++++++-
>>   drivers/gpu/drm/radeon/si_blit_shaders.c | 253 -----------------------
>>   drivers/gpu/drm/radeon/si_blit_shaders.h |  32 ---
>>   4 files changed, 224 insertions(+), 287 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/radeon/si_blit_shaders.c
>>   delete mode 100644 drivers/gpu/drm/radeon/si_blit_shaders.h
>>
>> diff --git a/drivers/gpu/drm/radeon/Makefile 
>> b/drivers/gpu/drm/radeon/Makefile
>> index 11c97edde54d..664381f4eb07 100644
>> --- a/drivers/gpu/drm/radeon/Makefile
>> +++ b/drivers/gpu/drm/radeon/Makefile
>> @@ -44,7 +44,7 @@ radeon-y += radeon_device.o radeon_asic.o 
>> radeon_kms.o \
>>       evergreen.o evergreen_cs.o evergreen_blit_shaders.o \
>>       evergreen_hdmi.o radeon_trace_points.o ni.o 
>> cayman_blit_shaders.o \
>>       atombios_encoders.o radeon_semaphore.o radeon_sa.o 
>> atombios_i2c.o si.o \
>> -    si_blit_shaders.o radeon_prime.o cik.o cik_blit_shaders.o \
>> +    radeon_prime.o cik.o cik_blit_shaders.o \
>>       r600_dpm.o rs780_dpm.o rv6xx_dpm.o rv770_dpm.o rv730_dpm.o 
>> rv740_dpm.o \
>>       rv770_smc.o cypress_dpm.o btc_dpm.o sumo_dpm.o sumo_smc.o 
>> trinity_dpm.o \
>>       trinity_smc.o ni_dpm.o si_smc.o si_dpm.o kv_smc.o kv_dpm.o 
>> ci_smc.o \
>> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
>> index 8d5e4b25609d..a4032702e302 100644
>> --- a/drivers/gpu/drm/radeon/si.c
>> +++ b/drivers/gpu/drm/radeon/si.c
>> @@ -38,7 +38,6 @@
>>   #include "radeon_asic.h"
>>   #include "radeon_audio.h"
>>   #include "radeon_ucode.h"
>> -#include "si_blit_shaders.h"
>>   #include "si.h"
>>   #include "sid.h"
>>   @@ -3553,6 +3552,229 @@ static int si_cp_load_microcode(struct 
>> radeon_device *rdev)
>>       return 0;
>>   }
>>   +static const u32 si_default_state[] = {
>> +    0xc0066900,
>> +    0x00000000,
>> +    0x00000060, /* DB_RENDER_CONTROL */
>> +    0x00000000, /* DB_COUNT_CONTROL */
>> +    0x00000000, /* DB_DEPTH_VIEW */
>> +    0x0000002a, /* DB_RENDER_OVERRIDE */
>> +    0x00000000, /* DB_RENDER_OVERRIDE2 */
>> +    0x00000000, /* DB_HTILE_DATA_BASE */
>> +
>> +    0xc0046900,
>> +    0x00000008,
>> +    0x00000000, /* DB_DEPTH_BOUNDS_MIN */
>> +    0x00000000, /* DB_DEPTH_BOUNDS_MAX */
>> +    0x00000000, /* DB_STENCIL_CLEAR */
>> +    0x00000000, /* DB_DEPTH_CLEAR */
>> +
>> +    0xc0036900,
>> +    0x0000000f,
>> +    0x00000000, /* DB_DEPTH_INFO */
>> +    0x00000000, /* DB_Z_INFO */
>> +    0x00000000, /* DB_STENCIL_INFO */
>> +
>> +    0xc0016900,
>> +    0x00000080,
>> +    0x00000000, /* PA_SC_WINDOW_OFFSET */
>> +
>> +    0xc00d6900,
>> +    0x00000083,
>> +    0x0000ffff, /* PA_SC_CLIPRECT_RULE */
>> +    0x00000000, /* PA_SC_CLIPRECT_0_TL */
>> +    0x20002000, /* PA_SC_CLIPRECT_0_BR */
>> +    0x00000000,
>> +    0x20002000,
>> +    0x00000000,
>> +    0x20002000,
>> +    0x00000000,
>> +    0x20002000,
>> +    0xaaaaaaaa, /* PA_SC_EDGERULE */
>> +    0x00000000, /* PA_SU_HARDWARE_SCREEN_OFFSET */
>> +    0x0000000f, /* CB_TARGET_MASK */
>> +    0x0000000f, /* CB_SHADER_MASK */
>> +
>> +    0xc0226900,
>> +    0x00000094,
>> +    0x80000000, /* PA_SC_VPORT_SCISSOR_0_TL */
>> +    0x20002000, /* PA_SC_VPORT_SCISSOR_0_BR */
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x80000000,
>> +    0x20002000,
>> +    0x00000000, /* PA_SC_VPORT_ZMIN_0 */
>> +    0x3f800000, /* PA_SC_VPORT_ZMAX_0 */
>> +
>> +    0xc0026900,
>> +    0x000000d9,
>> +    0x00000000, /* CP_RINGID */
>> +    0x00000000, /* CP_VMID */
>> +
>> +    0xc0046900,
>> +    0x00000100,
>> +    0xffffffff, /* VGT_MAX_VTX_INDX */
>> +    0x00000000, /* VGT_MIN_VTX_INDX */
>> +    0x00000000, /* VGT_INDX_OFFSET */
>> +    0x00000000, /* VGT_MULTI_PRIM_IB_RESET_INDX */
>> +
>> +    0xc0046900,
>> +    0x00000105,
>> +    0x00000000, /* CB_BLEND_RED */
>> +    0x00000000, /* CB_BLEND_GREEN */
>> +    0x00000000, /* CB_BLEND_BLUE */
>> +    0x00000000, /* CB_BLEND_ALPHA */
>> +
>> +    0xc0016900,
>> +    0x000001e0,
>> +    0x00000000, /* CB_BLEND0_CONTROL */
>> +
>> +    0xc00e6900,
>> +    0x00000200,
>> +    0x00000000, /* DB_DEPTH_CONTROL */
>> +    0x00000000, /* DB_EQAA */
>> +    0x00cc0010, /* CB_COLOR_CONTROL */
>> +    0x00000210, /* DB_SHADER_CONTROL */
>> +    0x00010000, /* PA_CL_CLIP_CNTL */
>> +    0x00000004, /* PA_SU_SC_MODE_CNTL */
>> +    0x00000100, /* PA_CL_VTE_CNTL */
>> +    0x00000000, /* PA_CL_VS_OUT_CNTL */
>> +    0x00000000, /* PA_CL_NANINF_CNTL */
>> +    0x00000000, /* PA_SU_LINE_STIPPLE_CNTL */
>> +    0x00000000, /* PA_SU_LINE_STIPPLE_SCALE */
>> +    0x00000000, /* PA_SU_PRIM_FILTER_CNTL */
>> +    0x00000000, /*  */
>> +    0x00000000, /*  */
>> +
>> +    0xc0116900,
>> +    0x00000280,
>> +    0x00000000, /* PA_SU_POINT_SIZE */
>> +    0x00000000, /* PA_SU_POINT_MINMAX */
>> +    0x00000008, /* PA_SU_LINE_CNTL */
>> +    0x00000000, /* PA_SC_LINE_STIPPLE */
>> +    0x00000000, /* VGT_OUTPUT_PATH_CNTL */
>> +    0x00000000, /* VGT_HOS_CNTL */
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000, /* VGT_GS_MODE */
>> +
>> +    0xc0026900,
>> +    0x00000292,
>> +    0x00000000, /* PA_SC_MODE_CNTL_0 */
>> +    0x00000000, /* PA_SC_MODE_CNTL_1 */
>> +
>> +    0xc0016900,
>> +    0x000002a1,
>> +    0x00000000, /* VGT_PRIMITIVEID_EN */
>> +
>> +    0xc0016900,
>> +    0x000002a5,
>> +    0x00000000, /* VGT_MULTI_PRIM_IB_RESET_EN */
>> +
>> +    0xc0026900,
>> +    0x000002a8,
>> +    0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
>> +    0x00000000,
>> +
>> +    0xc0026900,
>> +    0x000002ad,
>> +    0x00000000, /* VGT_REUSE_OFF */
>> +    0x00000000,
>> +
>> +    0xc0016900,
>> +    0x000002d5,
>> +    0x00000000, /* VGT_SHADER_STAGES_EN */
>> +
>> +    0xc0016900,
>> +    0x000002dc,
>> +    0x0000aa00, /* DB_ALPHA_TO_MASK */
>> +
>> +    0xc0066900,
>> +    0x000002de,
>> +    0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +
>> +    0xc0026900,
>> +    0x000002e5,
>> +    0x00000000, /* VGT_STRMOUT_CONFIG */
>> +    0x00000000,
>> +
>> +    0xc01b6900,
>> +    0x000002f5,
>> +    0x76543210, /* PA_SC_CENTROID_PRIORITY_0 */
>> +    0xfedcba98, /* PA_SC_CENTROID_PRIORITY_1 */
>> +    0x00000000, /* PA_SC_LINE_CNTL */
>> +    0x00000000, /* PA_SC_AA_CONFIG */
>> +    0x00000005, /* PA_SU_VTX_CNTL */
>> +    0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
>> +    0x3f800000, /* PA_CL_GB_VERT_DISC_ADJ */
>> +    0x3f800000, /* PA_CL_GB_HORZ_CLIP_ADJ */
>> +    0x3f800000, /* PA_CL_GB_HORZ_DISC_ADJ */
>> +    0x00000000, /* PA_SC_AA_SAMPLE_LOCS_PIXEL_X0Y0_0 */
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0x00000000,
>> +    0xffffffff, /* PA_SC_AA_MASK_X0Y0_X1Y0 */
>> +    0xffffffff,
>> +
>> +    0xc0026900,
>> +    0x00000316,
>> +    0x0000000e, /* VGT_VERTEX_REUSE_BLOCK_CNTL */
>> +    0x00000010, /*  */
>> +};
>> +
>> +static const u32 si_default_size = ARRAY_SIZE(si_default_state);
>> +
>>   static int si_cp_start(struct radeon_device *rdev)
>>   {
>>       struct radeon_ring *ring = 
>> &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
>> diff --git a/drivers/gpu/drm/radeon/si_blit_shaders.c 
>> b/drivers/gpu/drm/radeon/si_blit_shaders.c
>> deleted file mode 100644
>> index ec415e7dfa4b..000000000000
>> --- a/drivers/gpu/drm/radeon/si_blit_shaders.c
>> +++ /dev/null
>> @@ -1,253 +0,0 @@
>> -/*
>> - * Copyright 2011 Advanced Micro Devices, Inc.
>> - *
>> - * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> - * copy of this software and associated documentation files (the 
>> "Software"),
>> - * to deal in the Software without restriction, including without 
>> limitation
>> - * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> - * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> - * Software is furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice (including 
>> the next
>> - * paragraph) shall be included in all copies or substantial 
>> portions of the
>> - * Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> - * THE COPYRIGHT HOLDER(S) AND/OR ITS SUPPLIERS BE LIABLE FOR ANY 
>> CLAIM, DAMAGES OR
>> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR OTHER
>> - * DEALINGS IN THE SOFTWARE.
>> - *
>> - * Authors:
>> - *     Alex Deucher <alexander.deucher@amd.com>
>> - */
>> -
>> -#include <linux/types.h>
>> -#include <linux/bug.h>
>> -#include <linux/kernel.h>
>> -
>> -const u32 si_default_state[] =
>> -{
>> -    0xc0066900,
>> -    0x00000000,
>> -    0x00000060, /* DB_RENDER_CONTROL */
>> -    0x00000000, /* DB_COUNT_CONTROL */
>> -    0x00000000, /* DB_DEPTH_VIEW */
>> -    0x0000002a, /* DB_RENDER_OVERRIDE */
>> -    0x00000000, /* DB_RENDER_OVERRIDE2 */
>> -    0x00000000, /* DB_HTILE_DATA_BASE */
>> -
>> -    0xc0046900,
>> -    0x00000008,
>> -    0x00000000, /* DB_DEPTH_BOUNDS_MIN */
>> -    0x00000000, /* DB_DEPTH_BOUNDS_MAX */
>> -    0x00000000, /* DB_STENCIL_CLEAR */
>> -    0x00000000, /* DB_DEPTH_CLEAR */
>> -
>> -    0xc0036900,
>> -    0x0000000f,
>> -    0x00000000, /* DB_DEPTH_INFO */
>> -    0x00000000, /* DB_Z_INFO */
>> -    0x00000000, /* DB_STENCIL_INFO */
>> -
>> -    0xc0016900,
>> -    0x00000080,
>> -    0x00000000, /* PA_SC_WINDOW_OFFSET */
>> -
>> -    0xc00d6900,
>> -    0x00000083,
>> -    0x0000ffff, /* PA_SC_CLIPRECT_RULE */
>> -    0x00000000, /* PA_SC_CLIPRECT_0_TL */
>> -    0x20002000, /* PA_SC_CLIPRECT_0_BR */
>> -    0x00000000,
>> -    0x20002000,
>> -    0x00000000,
>> -    0x20002000,
>> -    0x00000000,
>> -    0x20002000,
>> -    0xaaaaaaaa, /* PA_SC_EDGERULE */
>> -    0x00000000, /* PA_SU_HARDWARE_SCREEN_OFFSET */
>> -    0x0000000f, /* CB_TARGET_MASK */
>> -    0x0000000f, /* CB_SHADER_MASK */
>> -
>> -    0xc0226900,
>> -    0x00000094,
>> -    0x80000000, /* PA_SC_VPORT_SCISSOR_0_TL */
>> -    0x20002000, /* PA_SC_VPORT_SCISSOR_0_BR */
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x80000000,
>> -    0x20002000,
>> -    0x00000000, /* PA_SC_VPORT_ZMIN_0 */
>> -    0x3f800000, /* PA_SC_VPORT_ZMAX_0 */
>> -
>> -    0xc0026900,
>> -    0x000000d9,
>> -    0x00000000, /* CP_RINGID */
>> -    0x00000000, /* CP_VMID */
>> -
>> -    0xc0046900,
>> -    0x00000100,
>> -    0xffffffff, /* VGT_MAX_VTX_INDX */
>> -    0x00000000, /* VGT_MIN_VTX_INDX */
>> -    0x00000000, /* VGT_INDX_OFFSET */
>> -    0x00000000, /* VGT_MULTI_PRIM_IB_RESET_INDX */
>> -
>> -    0xc0046900,
>> -    0x00000105,
>> -    0x00000000, /* CB_BLEND_RED */
>> -    0x00000000, /* CB_BLEND_GREEN */
>> -    0x00000000, /* CB_BLEND_BLUE */
>> -    0x00000000, /* CB_BLEND_ALPHA */
>> -
>> -    0xc0016900,
>> -    0x000001e0,
>> -    0x00000000, /* CB_BLEND0_CONTROL */
>> -
>> -    0xc00e6900,
>> -    0x00000200,
>> -    0x00000000, /* DB_DEPTH_CONTROL */
>> -    0x00000000, /* DB_EQAA */
>> -    0x00cc0010, /* CB_COLOR_CONTROL */
>> -    0x00000210, /* DB_SHADER_CONTROL */
>> -    0x00010000, /* PA_CL_CLIP_CNTL */
>> -    0x00000004, /* PA_SU_SC_MODE_CNTL */
>> -    0x00000100, /* PA_CL_VTE_CNTL */
>> -    0x00000000, /* PA_CL_VS_OUT_CNTL */
>> -    0x00000000, /* PA_CL_NANINF_CNTL */
>> -    0x00000000, /* PA_SU_LINE_STIPPLE_CNTL */
>> -    0x00000000, /* PA_SU_LINE_STIPPLE_SCALE */
>> -    0x00000000, /* PA_SU_PRIM_FILTER_CNTL */
>> -    0x00000000, /*  */
>> -    0x00000000, /*  */
>> -
>> -    0xc0116900,
>> -    0x00000280,
>> -    0x00000000, /* PA_SU_POINT_SIZE */
>> -    0x00000000, /* PA_SU_POINT_MINMAX */
>> -    0x00000008, /* PA_SU_LINE_CNTL */
>> -    0x00000000, /* PA_SC_LINE_STIPPLE */
>> -    0x00000000, /* VGT_OUTPUT_PATH_CNTL */
>> -    0x00000000, /* VGT_HOS_CNTL */
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000, /* VGT_GS_MODE */
>> -
>> -    0xc0026900,
>> -    0x00000292,
>> -    0x00000000, /* PA_SC_MODE_CNTL_0 */
>> -    0x00000000, /* PA_SC_MODE_CNTL_1 */
>> -
>> -    0xc0016900,
>> -    0x000002a1,
>> -    0x00000000, /* VGT_PRIMITIVEID_EN */
>> -
>> -    0xc0016900,
>> -    0x000002a5,
>> -    0x00000000, /* VGT_MULTI_PRIM_IB_RESET_EN */
>> -
>> -    0xc0026900,
>> -    0x000002a8,
>> -    0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
>> -    0x00000000,
>> -
>> -    0xc0026900,
>> -    0x000002ad,
>> -    0x00000000, /* VGT_REUSE_OFF */
>> -    0x00000000,
>> -
>> -    0xc0016900,
>> -    0x000002d5,
>> -    0x00000000, /* VGT_SHADER_STAGES_EN */
>> -
>> -    0xc0016900,
>> -    0x000002dc,
>> -    0x0000aa00, /* DB_ALPHA_TO_MASK */
>> -
>> -    0xc0066900,
>> -    0x000002de,
>> -    0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -
>> -    0xc0026900,
>> -    0x000002e5,
>> -    0x00000000, /* VGT_STRMOUT_CONFIG */
>> -    0x00000000,
>> -
>> -    0xc01b6900,
>> -    0x000002f5,
>> -    0x76543210, /* PA_SC_CENTROID_PRIORITY_0 */
>> -    0xfedcba98, /* PA_SC_CENTROID_PRIORITY_1 */
>> -    0x00000000, /* PA_SC_LINE_CNTL */
>> -    0x00000000, /* PA_SC_AA_CONFIG */
>> -    0x00000005, /* PA_SU_VTX_CNTL */
>> -    0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
>> -    0x3f800000, /* PA_CL_GB_VERT_DISC_ADJ */
>> -    0x3f800000, /* PA_CL_GB_HORZ_CLIP_ADJ */
>> -    0x3f800000, /* PA_CL_GB_HORZ_DISC_ADJ */
>> -    0x00000000, /* PA_SC_AA_SAMPLE_LOCS_PIXEL_X0Y0_0 */
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0x00000000,
>> -    0xffffffff, /* PA_SC_AA_MASK_X0Y0_X1Y0 */
>> -    0xffffffff,
>> -
>> -    0xc0026900,
>> -    0x00000316,
>> -    0x0000000e, /* VGT_VERTEX_REUSE_BLOCK_CNTL */
>> -    0x00000010, /*  */
>> -};
>> -
>> -const u32 si_default_size = ARRAY_SIZE(si_default_state);
>> diff --git a/drivers/gpu/drm/radeon/si_blit_shaders.h 
>> b/drivers/gpu/drm/radeon/si_blit_shaders.h
>> deleted file mode 100644
>> index c739e51e3961..000000000000
>> --- a/drivers/gpu/drm/radeon/si_blit_shaders.h
>> +++ /dev/null
>> @@ -1,32 +0,0 @@
>> -/*
>> - * Copyright 2011 Advanced Micro Devices, Inc.
>> - *
>> - * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> - * copy of this software and associated documentation files (the 
>> "Software"),
>> - * to deal in the Software without restriction, including without 
>> limitation
>> - * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> - * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> - * Software is furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice (including 
>> the next
>> - * paragraph) shall be included in all copies or substantial 
>> portions of the
>> - * Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> - * THE COPYRIGHT HOLDER(S) AND/OR ITS SUPPLIERS BE LIABLE FOR ANY 
>> CLAIM, DAMAGES OR
>> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR OTHER
>> - * DEALINGS IN THE SOFTWARE.
>> - *
>> - */
>> -
>> -#ifndef SI_BLIT_SHADERS_H
>> -#define SI_BLIT_SHADERS_H
>> -
>> -extern const u32 si_default_state[];
>> -
>> -extern const u32 si_default_size;
>> -
>> -#endif
>

