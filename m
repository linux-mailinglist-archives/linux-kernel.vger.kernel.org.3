Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85031465DED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 06:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355387AbhLBFcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 00:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345061AbhLBFcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 00:32:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED23C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:28:44 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b13so19437754plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 21:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gyrjwojk1GcahkeOLujzX/65YL1h5Tz+BMWNTXHTLBo=;
        b=AON+Nlf/5ielvaDTnhmOGiV0P/OQNI+S52CyWaGdl+UevpRt7PY+Z0M7QTJSX6/CEE
         Mac4UoFZKUxVC929g7KvqvrPlRWVxVn5oOJlyaVUKStGUqhlSB/BCpf6PgpLh1dtjJjo
         up0OskwE4f1DUH8xfc7NkzUWn4s0refD2iSIfe1vHslYyTka81JgEbndY5ZtxO9jwNDT
         vlUmugeekEjHbUW/ynsGrsgGfhXiXzeARB78LPJSPD+hNNNYcYkyOhU1ZZSDZpWUtILT
         4QsiJY3OneskyqqbeIa9fHrCUdNMUt7YReYrqCmqhjeFw8cwb66cThizuB6MqlsJWooX
         F2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gyrjwojk1GcahkeOLujzX/65YL1h5Tz+BMWNTXHTLBo=;
        b=iC2BGtz0f3O0Uw6EKbctK1FtCTnshsl3nTc0i6o2AAuy1Q11zIEZRrVqZt1+u8JTxY
         +no+sWTqLZpd3xPKWzFMuhlvyz1MjKokGUsBtKmONEsOV6iruTcaGumkiLFM+8i6A0oT
         HMY4uh8WyaLijwIuDklH7uajf0KN3O7fQ32DF7r1f1kiglEyHbPqqkCbZ2aVy84v6mnI
         c7W/mdgdv0NaAbT0BHp77PcZVRqCojEPSRxB4+aWUl7sdjXCUBj9YlzNhHPfQh145g1r
         pq4pV7GHPYif8X09xX3DQW6TOfGmrKBtZ/RoZ2uK6Nhc5ZySGt206Jajfw7exV5YNF4v
         uRQg==
X-Gm-Message-State: AOAM532aTfmsYoxkEVFeErnTNk9hyffh5L0FplXjiI+ljvYMM+fEREGM
        34Vrny46Zm9F//JQyMyhVuSMvQ==
X-Google-Smtp-Source: ABdhPJxsZzRD9T3ewIjEvivZksYYBpLu0dCdt/9JYaVkSEdiNLcnSV7ZdWw1UIlxvaUDlAWsnFWLUA==
X-Received: by 2002:a17:903:22c5:b0:142:3100:65af with SMTP id y5-20020a17090322c500b00142310065afmr13193034plg.83.1638422924294;
        Wed, 01 Dec 2021 21:28:44 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id il13sm1063137pjb.52.2021.12.01.21.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 21:28:43 -0800 (PST)
Subject: Re: Re: [PATCH v2 2/2] KVM: x86: use x86_get_freq to get freq for
 kvmclock
To:     Thomas Gleixner <tglx@linutronix.de>, pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20211201024650.88254-1-pizhenwei@bytedance.com>
 <20211201024650.88254-3-pizhenwei@bytedance.com> <877dcn7md2.ffs@tglx>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <b37ffc3d-4038-fc5e-d681-b89c04a37b04@bytedance.com>
Date:   Thu, 2 Dec 2021 13:26:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <877dcn7md2.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 10:48 AM, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 10:46, zhenwei pi wrote:
>> If the host side supports APERF&MPERF feature, the guest side may get
>> mismatched frequency.
>>
>> KVM uses x86_get_cpufreq_khz() to get the same frequency for guest side.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   arch/x86/kvm/x86.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 5a403d92833f..125ed3c8b21a 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -8305,10 +8305,8 @@ static void tsc_khz_changed(void *data)
>>   
>>   	if (data)
>>   		khz = freq->new;
>> -	else if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
>> -		khz = cpufreq_quick_get(raw_smp_processor_id());
>>   	if (!khz)
>> -		khz = tsc_khz;
>> +		khz = x86_get_cpufreq_khz(raw_smp_processor_id());
> 
> my brain compiler tells me that this is broken.
> Without this patch:
1, boot_cpu_has(X86_FEATURE_CONSTANT_TSC) is true:
no kvmclock_cpufreq_notifier, and khz = tsc_khz;

2, boot_cpu_has(X86_FEATURE_CONSTANT_TSC) is false:
during installing kmod, try cpufreq_quick_get(), or use tsc_khz;
and get changed by kvmclock_cpufreq_notifier.

With this patch:
1, boot_cpu_has(X86_FEATURE_CONSTANT_TSC) is true:
no kvmclock_cpufreq_notifier, try aperf/mperf, or try 
cpufreq_quick_get(), or use cpu_khz

2, boot_cpu_has(X86_FEATURE_CONSTANT_TSC) is false:
during installing kmod, try aperf/mperf, or try cpufreq_quick_get(), or 
use cpu_khz;
and get changed by kvmclock_cpufreq_notifier.

I tested on Skylake&Icelake CPU, and got different CPU frequency from 
host & guest, the main purpose of this patch is to get the same frequency.

-- 
zhenwei pi
