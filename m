Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1D5A9C15
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiIAPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiIAPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82B8B2C9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662047264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Md/EFxH02CSlIIsOFEuaDgKD4tP3/B9dpxGxZa1Xwmc=;
        b=d7oiJoTGryjErbuoLBWdnO+vj9CUSVMCrzZ52tQisSpAFNUr2KNPQdSA6BNGjV/yGmslGY
        C0zLkjVDJRx1l0WBrGANNatYUWkApZBcQVfLXOPkILIefTgab00n04qPju33yHIbCqU8At
        B3ZzCGgTa/tTzgF+MtkCS4TlmjBS7HI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-189-P2zVQ63zPX22OYb2qLvYjw-1; Thu, 01 Sep 2022 11:47:42 -0400
X-MC-Unique: P2zVQ63zPX22OYb2qLvYjw-1
Received: by mail-ed1-f71.google.com with SMTP id m15-20020a056402430f00b00448af09b674so6620981edc.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Md/EFxH02CSlIIsOFEuaDgKD4tP3/B9dpxGxZa1Xwmc=;
        b=buO7hTNY8sr46NnVsaN9D0rD0Zek2sNsdUFXs8n8U7CgXOKO3kQGVxzusaKZd4+ftY
         NI6LO2o7BifT0H1OFVtO/BxlFHP5deI+yPKsLzEkU5evONae7RN50FN1Kc0XcA8AZVXB
         YaqeUMVwSQ9cyomCeGy/0hFrp98WPy3H5NRdXoVRFwLGsPZxU8vZuzLeq8M0UR116IxB
         jjlAtOFVglyXBnMV3qtBgMmv+oPOBzsrEdZpGr+Gjt0ckDqOfFc73Ba12rPYv9Advkc5
         tH6O9q/m7wNOrRq1sx+IXFm4xHd6fVegfoNOWVufMkDl2LWv8eCwB5m65Fx34qTv7tYp
         WW0w==
X-Gm-Message-State: ACgBeo0xYK07UvbQLEngInVajgCmoIsEZUol21/wK2vjf3yCj6USzs0K
        rVoOsNXQ9V0eMUfeYbidvweDx8UYKDwbT5tUYphU4JDa6rtEYFu2kiMkzlGqSjfvqHAcAfO7/Uo
        0FDqUxzdynlWni62MhLhZCpKe
X-Received: by 2002:a17:907:a064:b0:73d:d6bd:65fb with SMTP id ia4-20020a170907a06400b0073dd6bd65fbmr22793276ejc.716.1662047261441;
        Thu, 01 Sep 2022 08:47:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5FIWKF+q/A0Pw7/mHbETdAmKqwoRWze9oaTN5QmEkZnLM2Gq9bjNtc+5Pn/TEDlcU8HTy2wg==
X-Received: by 2002:a17:907:a064:b0:73d:d6bd:65fb with SMTP id ia4-20020a170907a06400b0073dd6bd65fbmr22793272ejc.716.1662047261204;
        Thu, 01 Sep 2022 08:47:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ck7-20020a0564021c0700b00445c0ab272fsm1496608edb.29.2022.09.01.08.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:47:40 -0700 (PDT)
Message-ID: <e14b3264-7e60-9cfe-34f8-f79815878d50@redhat.com>
Date:   Thu, 1 Sep 2022 17:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] platform/x86/intel: pmc/core: Add Raptor Lake support
 to pmc core driver
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
 <b8a5038b-3d3a-4a2c-8fca-32b47f11e85c@redhat.com>
In-Reply-To: <b8a5038b-3d3a-4a2c-8fca-32b47f11e85c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/1/22 17:43, Hans de Goede wrote:
> Hi,
> 
> On 8/30/22 20:20, Gayatri Kammela wrote:
>> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
>> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
>>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: David Box <david.e.box@intel.com>
>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

In file included from drivers/platform/x86/intel/pmc/core.c:29:
./arch/x86/include/asm/cpu_device_id.h:161:46: error: ‘INTEL_FAM6_RAPTORLAKE_S’ undeclared here (not in a function); did you mean ‘INTEL_FAM6_RAPTORLAKE_P’?
  161 |         X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
      |                                              ^~~~~~~~~~~
./arch/x86/include/asm/cpu_device_id.h:46:27: note: in definition of macro ‘X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE’
   46 |         .model          = _model,                                       \
      |                           ^~~~~~
./arch/x86/include/asm/cpu_device_id.h:129:9: note: in expansion of macro ‘X86_MATCH_VENDOR_FAM_MODEL_FEATURE’
  129 |         X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model,       \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/cpu_device_id.h:161:9: note: in expansion of macro ‘X86_MATCH_VENDOR_FAM_MODEL’
  161 |         X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/intel/pmc/core.c:1918:9: note: in expansion of macro ‘X86_MATCH_INTEL_FAM6_MODEL’
 1918 |         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &adl_reg_map),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:249: drivers/platform/x86/intel/pmc/core.o] Error 1

And dropped again, please upstream this through the tree which also has the new
INTEL_FAM6_RAPTORLAKE* macros.

Here is my Acked-by for merging this through another tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>> ---
>>  drivers/platform/x86/intel/pmc/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index a1fe1e0dcf4a..17ec5825d13d 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
>>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
>>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_reg_map),
>> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_reg_map),
>>  	{}
>>  };
>>  
>>
>> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5

