Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5423D56254E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiF3VeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiF3VeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:34:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553764475B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:34:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id jh14so552318plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=m5LTLCvSbl3Mimeu9cxekADyiuhH9Ah66rwKi2/jIWE=;
        b=LbSJfheaBJvAm3n4hF89qMFLPLF9B8GGg1NwuaiSHKdHguUeOq1j7I2oKsawuMgpor
         V5wBah2cCiJX5cRW1Cve+ain+VJUEkXyv1uaNDcDJOG/WW6vw11iBnx21CMBs+O3S/cQ
         CaHdbg0fyyRC6dAT4ymEVyIIq0ds6NZwzgMOwzcxV+W2hV14s+qpFyyLJLhUxPEq6w3b
         CisPVszGJPNVi/D7JGtRRUKjHWbG/fZptrlLFsq9MDxoihpXxJQu9PkY1+W0cxZiIuIE
         H8uHDxEvGJqTtkA1KFaA1AvTKNMv27Qp52OuSJuzhrEKl/VDTPp/goRdlGUU8T0CXnQP
         Y0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=m5LTLCvSbl3Mimeu9cxekADyiuhH9Ah66rwKi2/jIWE=;
        b=DK0UXsauTBTHjcTEry3LsKMTz0pKGqeElurjPHkbsod6bfZBA4LrOaDMjNVVi3x8iY
         7aVJdCrFn1UvJj5SIg/KWu5TyuMpqHsZHhfNzsKV/mI0a0kM3VjtAvZ57KYnAyoXnw3V
         GECS9dSRHuFJSQjV6ggfnwSrQAJZNDNonBddMQmY4OsNvjnv37SFvutmoFY6wa7iQNSc
         Cn2itelp5IRZhSWGy0Uei2kTkW+JyGiCBDJuqIIY6oPYTUGy+653IrUbztDuhHQ7Ir2Y
         hOq1J9M/etsRUjOwUiISzwj5atbP5yCUerLTg8GdVpQg1swFb59P/GJ+N7DPUmEGFBig
         IFIw==
X-Gm-Message-State: AJIora86ZgW7HKdbtKke6MOB8QXVF9Iq+z1CqOzNLl2PtnQu32pm0mo/
        nIDK0pufkuB1G2RIgBuqIT9HFxBetyM=
X-Google-Smtp-Source: AGRyM1uHNieIqEeaaoEg6sdpmGfjbYmezVY2gbd7xjvOiUAgyTIY8ax2+/1dgdk4uhOc8Vyuj31cMQ==
X-Received: by 2002:a17:902:c651:b0:16b:aebc:3615 with SMTP id s17-20020a170902c65100b0016baebc3615mr4672749pls.48.1656624849623;
        Thu, 30 Jun 2022 14:34:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64-20020a621743000000b0051e7b6e8b12sm14490535pfx.11.2022.06.30.14.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 14:34:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d2e699a-fb14-9adb-4d88-3f0cab3dd954@roeck-us.net>
Date:   Thu, 30 Jun 2022 14:34:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>
References: <20220618232737.2036722-1-linux@roeck-us.net>
 <584fc348-7a60-26a2-af61-9edc4f4830e4@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] drm/amd/display: Add missing hard-float compile flags for
 PPC64 builds
In-Reply-To: <584fc348-7a60-26a2-af61-9edc4f4830e4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 14:01, Rodrigo Siqueira Jordao wrote:
> 
> 
> On 2022-06-18 19:27, Guenter Roeck wrote:
>> ppc:allmodconfig builds fail with the following error.
>>
>> powerpc64-linux-ld:
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
>>         uses hard float,
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
>>         uses soft float
>> powerpc64-linux-ld:
>>     failed to merge target specific data of file
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
>> powerpc64-linux-ld:
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
>>         uses hard float,
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
>>         uses soft float
>> powerpc64-linux-ld:
>>     failed to merge target specific data of
>>     file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
>> powerpc64-linux-ld:
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
>>         uses hard float,
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o
>>         uses soft float
>> powerpc64-linux-ld:
>>     failed to merge target specific data of file
>>     drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o
>>
>> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
>> 64-bit outline-only KASAN support") which adds support for KASAN. This
>> commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
>> KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
>> compiled which lack the selection of hard-float.
>>
>> Fixes: 41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Daniel Axtens <dja@axtens.net>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn31/Makefile  | 4 ++++
>>   drivers/gpu/drm/amd/display/dc/dcn315/Makefile | 4 ++++
>>   drivers/gpu/drm/amd/display/dc/dcn316/Makefile | 4 ++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
>> index ec041e3cda30..74be02114ae4 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
>> @@ -15,6 +15,10 @@ DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o
>>       dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
>>       dcn31_afmt.o dcn31_vpg.o
>> +ifdef CONFIG_PPC64
>> +CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -maltivec
>> +endif
>> +
>>   AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
>>   AMD_DISPLAY_FILES += $(AMD_DAL_DCN31)
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
>> index 59381d24800b..1395c1ced8c5 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
>> @@ -25,6 +25,10 @@
>>   DCN315 = dcn315_resource.o
>> +ifdef CONFIG_PPC64
>> +CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o := -mhard-float -maltivec
>> +endif
>> +
>>   AMD_DAL_DCN315 = $(addprefix $(AMDDALPATH)/dc/dcn315/,$(DCN315))
>>   AMD_DISPLAY_FILES += $(AMD_DAL_DCN315)
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
>> index 819d44a9439b..c3d2dd78f1e2 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
>> @@ -25,6 +25,10 @@
>>   DCN316 = dcn316_resource.o
>> +ifdef CONFIG_PPC64
>> +CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o := -mhard-float -maltivec
>> +endif
>> +
>>   AMD_DAL_DCN316 = $(addprefix $(AMDDALPATH)/dc/dcn316/,$(DCN316))
>>   AMD_DISPLAY_FILES += $(AMD_DAL_DCN316)
> 
> Hi,
> 
> I don't want to re-introduce those FPU flags for DCN31/DCN314/DCN316 since we fully isolate FPU operations for those ASICs inside the DML folder. Notice that we have the PPC64 in the DML Makefile:
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dml/Makefile
> 

Yes, sure, ppc64 is in dc/dml/Makefile. The problem is that it selects hard-float

ifdef CONFIG_PPC64
dml_ccflags := -mhard-float -maltivec
endif

and dc/{dcn31,dcn315,dcn316} don't.


> Could you share what you see without your patch in the amd-staging-drm-next?

You mean linux-next ? Same error.

Building powerpc:allmodconfig ... failed
--------------
Error log:
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o

This isn't really surprising since dc/dml/ does build with hard float, and
dc/{dcn31,dcn315,dcn316} build with soft float. As mentioned above,
the problem is now seen because DRM_AMD_DC_DCN is now enabled which was
previously not the case.

select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Up to v5.18, both KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS were enabled
and DRM_AMD_DC_DCN was therefore disabled. Now KCOV_INSTRUMENT_ALL and
KCOV_ENABLE_COMPARISONS are disabled, which results in DRM_AMD_DC_DCN=y.
This in turn results in the hard/soft float inconsistencies and the compile
failure.

  Also:
> * Are you using cross-compilation? If so, could you share your setup?
> * Which GCC/Clang version are you using?

gcc 11.2.0 with binutils 2.36.1, but that really does not make a difference.

Guenter
