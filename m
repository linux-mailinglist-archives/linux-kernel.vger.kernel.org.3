Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2D4672AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378911AbhLCHju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350852AbhLCHjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:39:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8105C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:36:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso1785201pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 23:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KjJvjXLE84A8Tp2zgE64yxeO3Z42dzfdF9inCICVOqg=;
        b=sTnV/UJjFrntjoK+5RgyPvGchzO0T5aBO6CdvIJqHRpvd5ASEtD1RgsSImzoQSTNkQ
         Ju140Zwz5b9L4wUHm5e6h2CIgCT8XqEf+PiYV7g0Y+3QL+uaO1EZdBlBqiQ4rlux0j8o
         I8EfnHpYWUWwbNnpsPGcTyuMWWBuSq09DwIzWvHv7Kk0jjoBIvdcQSScS2VRe0ohPx+s
         MfRT7qv0Upskt8WK+M4IbZJ7qtd/8wIIuBMZ9MdaUesQP06EOODQ35AV3OJOl3Ce2lAK
         vBb0Hih+ONP24pmpnWAWZovNbcKu8XbRwmg9XPLy+fkpAknQaOp8YqRRysUDPdWxmyVT
         mY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KjJvjXLE84A8Tp2zgE64yxeO3Z42dzfdF9inCICVOqg=;
        b=DgoLLffH1qTr3tsZ4TYRr32WxRHsDrMUaxd48gQbZ7FOUBWXUwqMm4o4yIL9GqXlex
         uPvd53+1yAzfAtJzcI3p7Dvgvv/uNcIJu9nO6yAHv8CLM6ael/DhMF/wxyYWn+h7pSt9
         Ez7Lk0dVYv0fppC5N0271JLSJa44V5wQ3l62AgaetMqpb0N9+Qv7mDWk89XbUh0jDGCN
         NzvpyNE2NgmYbKh0/E8K5kpbIPhw76fh7ECv2IvxWbENZ3vXjdtiubMhXDxUG8FoqVlK
         HVNgKdkLR6lfeuAD0YI2yKe5IXCpi9l2bxlSzOMg8VSxuOXbSy8ZWFctdC9ZMsCiCUpw
         /DhQ==
X-Gm-Message-State: AOAM532ajN0woMIk28z1PtDMOA619jxE/ijEixAyVRdLDlsWSoMEmoZG
        /l/u+6NKwjepkeH9h7Ll8Pnlpg==
X-Google-Smtp-Source: ABdhPJy4egCE8rQOb7tJ2GeVtLdIc30+wYbZBi29M/Fe0sdl+orVxIjNxbhea/luBn7LIaynASA2Fg==
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr12209936pjb.194.1638516981196;
        Thu, 02 Dec 2021 23:36:21 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p33sm1549107pgm.85.2021.12.02.23.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 23:36:20 -0800 (PST)
Subject: Re: Re: [PATCH v2 1/2] x86/cpu: Introduce x86_get_cpufreq_khz()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20211201024650.88254-1-pizhenwei@bytedance.com>
 <20211201024650.88254-2-pizhenwei@bytedance.com>
 <20211202222514.GD16608@worktop.programming.kicks-ass.net>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <947de021-df91-9219-7378-8addc6f66612@bytedance.com>
Date:   Fri, 3 Dec 2021 15:34:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202222514.GD16608@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 6:25 AM, Peter Zijlstra wrote:
> On Wed, Dec 01, 2021 at 10:46:49AM +0800, zhenwei pi wrote:
>> Wrapper function x86_get_cpufreq_khz() to get frequency on a x86
>> platform, hide detailed implementation from proc routine.
>>
>> Also export this function for the further use, a typical case is that
>> kvm module gets the frequency of the host and tell the guest side by
>> kvmclock.
> 
> This function was already complete crap, and now you want to export it,
> *WHY* ?!
> 
> What possible use does KVM have for this random number generator?
> 
A KVM guest overwrites the '.calibrate_tsc' and '.calibrate_cpu' if 
kvmclock is supported:

in function kvmclock_init(void) (linux/arch/x86/kernel/kvmclock.c)
	...
         x86_platform.calibrate_tsc = kvm_get_tsc_khz;
         x86_platform.calibrate_cpu = kvm_get_tsc_khz;
	...

And kvm_get_tsc_khz reads PV data from host side. Before guest reads 
this, KVM should writes the frequency into the PV data structure.

And the problem is that KVM gets tsc_khz directly without aperf/mperf 
detection. So user may gets different frequency(cat /proc/cpuinfo) from 
guest & host.

Or is that possible to export function 'aperfmperf_get_khz'?

-- 
zhenwei pi
