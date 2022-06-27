Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A6155D10D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiF0HrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiF0HrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2FC60E7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656316024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O41SPTINQewaiTEEXheNcbqXApvzJfrGLeI0iN71ztc=;
        b=ONSkrSR5ZHZOFviNqtvEWS9ELVVm8o2/Wayk2ddK7b36D2v8sM2bhU78R6i9E1tBT+CALs
        9ErWsFOicuSmIXAQfVQFGSQreYXgGgPzRHp5LsR5+PBo2hSZn6OQL4aJZtbl4Z/qxm4w73
        6VQW6JQHSpC5q/AWJT6bfRq+kH/vkc0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-9ryAMn8QOu2goYOBzV-9fA-1; Mon, 27 Jun 2022 03:47:02 -0400
X-MC-Unique: 9ryAMn8QOu2goYOBzV-9fA-1
Received: by mail-ej1-f70.google.com with SMTP id hp8-20020a1709073e0800b0072629757566so2052649ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O41SPTINQewaiTEEXheNcbqXApvzJfrGLeI0iN71ztc=;
        b=FPA6fArVfElxMfJgJN5fcZTqQ8S1F4BwkDTMc0g7mV+6D4Ch4F+PYa/NtpX7l+nho9
         Oj0YplpOBk0bevXCW5DhAVj+szyuNPyH76sOdGoYOVDKcndmfJ/AkaKhgX7iuLNF9/05
         l6eKJrz9d25fIx5yNtD9s1i+pN1qrAhCzslx1wI820O1MklxCcRDwxclhKsXL7y2keBf
         g5JY3KWtuHkKrOiwdFtdv+T0m3Rk/8UrKOcdPo+/0aDOSTWyRoXERPg2XU1/aZ/Hxe97
         aoufZ4mhQU6LApyQzEobvcSarZzx+pfwCJmItwZux1+HlqU134Lo2JxWvesH+ECK7nAz
         W5CA==
X-Gm-Message-State: AJIora++kpuFRCQbhOrw9vz3dkE6/7iMop//4mo669z1BkkuKzbJ0lks
        75Dy1EbMKp0jwNHZszWB1DHIyFJPC/n2JVZm0ijh2tiTyHSClRe+OjDZN3rl24UjL4n4m79Iq2K
        UgUdWnRNgikXrHt6b8rFEh0FU
X-Received: by 2002:aa7:c352:0:b0:435:7fbd:90b9 with SMTP id j18-20020aa7c352000000b004357fbd90b9mr14993697edr.139.1656316021397;
        Mon, 27 Jun 2022 00:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vI0GYBvX7+TU34vpS/TdEuNLFGBo0OUd5Z63Q15rQixBleAil+59tqDrskJL5H3Si/TWttnA==
X-Received: by 2002:aa7:c352:0:b0:435:7fbd:90b9 with SMTP id j18-20020aa7c352000000b004357fbd90b9mr14993682edr.139.1656316021187;
        Mon, 27 Jun 2022 00:47:01 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906179700b006ff19354f9fsm4685334eje.215.2022.06.27.00.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:47:00 -0700 (PDT)
Message-ID: <ec9550c2-982f-12b6-e368-2cf94a1dba60@redhat.com>
Date:   Mon, 27 Jun 2022 09:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] platform/x86: intel/pmc: Add Alder Lake N support to
 PMC core driver
Content-Language: en-US
To:     "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
References: <20220615002751.3371730-1-gayatri.kammela@linux.intel.com>
 <caaca84e-1cc4-bf81-f705-fdabe2313d71@redhat.com>
 <3fc73477-59e3-2935-489b-d3dbfd77eafc@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3fc73477-59e3-2935-489b-d3dbfd77eafc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/22/22 19:56, Kammela, Gayatri wrote:
> On 6/22/2022 3:23 AM, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 6/15/22 02:27, Gayatri Kammela wrote:
>>> Add Alder Lake N (ADL-N) to the list of the platforms that Intel's
>>> PMC core driver supports. RocketLake reuses all the TigerLake PCH IPs.
>>>
>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Cc: David E. Box <david.e.box@linux.intel.com>
>>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
>> Thank you for your patch, I've applied this patch to my review-hans
>> branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> Note it will show up in my review-hans branch once I've pushed my
>> local branch there, which might take a while.
>>
>> Once I've run some tests on this branch the patches there will be
>> added to the platform-drivers-x86/for-next branch and eventually
>> will be included in the pdx86 pull-request to Linus for the next
>> merge-window.
>>
>> Regards,
>>
>> Hans
> Thank you Hans! I have sent v2 fixing the typo.

Next time please send newer versions before I apply them. I've updated
the version in my review-hans and fixes branches now and done a
forced push of those branches.

Regards,

Hans


>>
>>> ---
>>>   drivers/platform/x86/intel/pmc/core.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>>> index 40183bda7894..a1fe1e0dcf4a 100644
>>> --- a/drivers/platform/x86/intel/pmc/core.c
>>> +++ b/drivers/platform/x86/intel/pmc/core.c
>>> @@ -1911,6 +1911,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>>       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,    &icl_reg_map),
>>>       X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,        &tgl_reg_map),
>>>       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,        &tgl_reg_map),
>>> +    X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,        &tgl_reg_map),
>>>       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,        &adl_reg_map),
>>>       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>>>       {}
>>>
>>> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> 

