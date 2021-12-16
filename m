Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E6A477B42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbhLPSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhLPSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:05:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:05:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso1816818wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=co1FoCzjJObyRRqgwQ4hd10/dV+3xFk2/Vyzp/U6U8Y=;
        b=4rL5g7iMfhBnyq3oDe2cbKJ1AVHW2MbbuyOBdgmqq4WGMI3gm36d3+sQ2mUuf51fo5
         UOQMzLWc0WvSYN4YWKMPZH5KfjK4/AidzMRQpnV01lrkf0yFPn16pfsUAMyqRa4Iewmy
         myJYDzsOm3NwQyK4hbYkmeBA3vk5CQm1deWt6O3yMhCQB26EZFAACEpTOJY9xvUloNlZ
         f03kZ1tWHKThP4IaXn0qqu48wWHhVCsfVd3sfDbQNVbgf1oCVry2Mht0MvoQCFEP/CQj
         lD6kt5JKMkUPGBKd8fV2u9eKgcHh7K/KVA9KmclSdtDBr4oqlrq9HsszR0cvhXYP5Vsk
         b50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=co1FoCzjJObyRRqgwQ4hd10/dV+3xFk2/Vyzp/U6U8Y=;
        b=fRkALGI70dn8ZyoNaFitZJwRzwuluB2F0RwvZnQ2V8kZgIybW0LlFhZRe3pPS9XkKB
         YJskeKL0BJ3ymzacI9NM65yDK56cMuI2E8tLMHhrZ8fKoL9fFzBgnf94Ix03s28szhJF
         yNuOFT+IMqXHRmflCc4uANLZxqJ44U4O5kG7E3jK5LwZUKdCU9+QKo/OuWpZpUp2xBiR
         bdfmOuGQDSg6eVm6OlgFRPIks4o9+/bKc0oNs9+8L7PfWctnB3dJ86sXQaihzyjWGijZ
         RZpEI5MbjFcD4QhiISy67I79CWTiGJluHu94FGBJnlm+Jk+CVI911ve5oIsq4/IHs89i
         30/g==
X-Gm-Message-State: AOAM530/KEvxdYrlGszg6PimRyc9a4Noh9YdqAvEOuNH3lGFjpdhQDS4
        HUYbdVeZXsoCpnmK/mqd5cpwBQ==
X-Google-Smtp-Source: ABdhPJwKCAq4Y81w93DjKzMmQ2q9xLrcZZX5N0qYJ0dmvnTQJGHIpusVLT03xewyFmcfoqeHuMsIOw==
X-Received: by 2002:a05:600c:a06:: with SMTP id z6mr6131453wmp.9.1639677904126;
        Thu, 16 Dec 2021 10:05:04 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:3624:2649:255a:1e32? ([2a02:6b6d:f804:0:3624:2649:255a:1e32])
        by smtp.gmail.com with ESMTPSA id g13sm6387228wri.102.2021.12.16.10.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 10:05:03 -0800 (PST)
Subject: Re: [PATCH] x86/purgatory: provide config to disable purgatory
From:   Usama Arif <usama.arif@bytedance.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        tglx@linutronix.de, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        fam.zheng@bytedance.com
References: <20211123150508.3397898-1-usama.arif@bytedance.com>
 <YZ0HkaOiKfmgN8zl@zn.tnic> <YaTd4ZID7O+bVRXT@redhat.com>
 <79517d3c-3674-cc21-fbdc-b26946809756@bytedance.com>
 <87o862c396.fsf@email.froward.int.ebiederm.org>
 <433e69ec-3079-b905-b07f-b9c7a910be4f@bytedance.com>
 <33d9b711-288c-e5f4-0cc8-365c01861da5@bytedance.com>
Message-ID: <c74fa6ef-1b55-1f60-39c5-4b26efbabddc@bytedance.com>
Date:   Thu, 16 Dec 2021 18:05:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <33d9b711-288c-e5f4-0cc8-365c01861da5@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wanted to check again if there were any comments on my responses 
below or the v3 of the patch at 
https://lore.kernel.org/lkml/20211206164724.2125489-1-usama.arif@bytedance.com/.

Thanks!
Usama

On 06/12/2021 16:51, Usama Arif wrote:
> Hi,
> 
> I have sent a v3 of the patch with a much clearer commit message, please
> let me know if there are any comments for the v3 patch or my responses 
> below.
> 
> Thanks,
> Usama
> 
> On 01/12/2021 10:29, Usama Arif wrote:
>> Hi,
>>
>> (Resending the reply as my email client had updated and inserted html 
>> code and caused a bounceback from the mailing list, sorry about that.)
>>
>> Thanks for your reply, I have responded with further 
>> comments/questions inline below, and also have provided some context 
>> for the patch at the start:
>>
>> The patch is not introducing a new CONFIG option, as can be seen in 
>> the v2 patch diff. It is converting an existing CONFIG option that 
>> only enabled purgatory for specific architectures in which it has been 
>> implemented (x86, powerpc and s390) to an option that can that allow 
>> purgatory to be disabled (with default enabled) and only provides code 
>> to disable purgatory for x86 only. From what i see, purgatory is 
>> currently not yet implemented in other architectures like arm64 
>> kexec_file case and riscv, so this would on a high level,
>> provide only the option to make kexec on x86 similar to other the 
>> other architectures.
>>
>> As a background to the discussion, the usecase we are aiming is to 
>> update the host kernel with kexec in servers which is managing 
>> multiple VMs, to cut down the downtime of servers as much as possible 
>> so that its not noticeable to VMs. The patch is aimed at x86 purgatory 
>> code specifically. We are targetting other optimizations as well in 
>> other areas in boot path to cut down the 600ms time much further, so 
>> that cut down of 200ms downtime is significant in the usecase 
>> described. I did have a few comments/questions about your reply, 
>> please see my responses below:
>>
>>
>> On 29/11/2021 16:53, Eric W. Biederman wrote:
>>> Usama Arif <usama.arif@bytedance.com> writes:
>>>
>>>> Hi,
>>>>
>>>> Thanks for your replies. I have submitted a v2 of the patch with a
>>>> much more detailed commit message including reason for the patch and 
>>>> timing values.
>>>>
>>>> The time taken from reboot to running init process was measured
>>>> with both purgatory enabled and disabled over 20 runs and the
>>>> averages are:
>>>> Purgatory disabled:
>>>> - TSC = 3908766161 cycles
>>>> - ktime = 606.8 ms
>>>> Purgatory enabled:
>>>> - TSC = 5005811885 cycles (28.1% worse)
>>>> - ktime = 843.1 ms (38.9% worse)
>>>>
>>>>
>>>> Our reason for this patch is that it helps reduce the downtime of 
>>>> servers when
>>>> the host kernel managing multiple VMs needs to be updated via kexec,
>>>> but it makes reboot with kexec much faster so should be a general 
>>>> improvement in
>>>> boot time if purgatory is not needed and could have other usecases 
>>>> as well.
>>>> I believe only x86, powerpc and s390 have purgatory supported, other 
>>>> platforms
>>>> like arm64 dont have it implemented yet, so with the reboot time 
>>>> improvement seen,
>>>> it would be a good idea to have the option to disable purgatory 
>>>> completely but set default to y.
>>>> We also have the CONFIG_KEXEC_BZIMAGE_VERIFY_SIG which can be 
>>>> enabled to verify the next
>>>> kernel image to be booted and purgatory can be completely skipped if
>>>> not required.
>>>
>>> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is something totally and completely
>>> different.  It's job is to verify that the kernel to be booted comes
>>> from a trusted source.   The sha256 verification in purgatory's job
>>> is to verify that memory the kernel cares about was not corrupted
>>> during the kexec process.
>>>
>>
>> Thanks, acknowledged.
>>
>>> I believe when you say purgatory you are really talking about that
>>> sha256 checksum.  It really is not possible to disable all of
>>> the code that runs between kernels, as the old and the new kernel may
>>> run at the same addresses.  Anything that runs between the two kernels
>>> is what is referred to as purgatory.  Even if it is just a small
>>> assembly stub.
>>>
>>  >
>>
>> With this patch, i am trying to give an option (with default purgatory 
>> enabled)to disable purgatory completely on x86 only, i.e. no code 
>> running between 2 kernels on x86. From my understanding there is no 
>> purgatory in arm64 kexec_file case, in riscv and in some other archs 
>> as well, so I am not sure why its not possible to disable purgatory 
>> (all code running between 2 kernels) in x86? Unless i misunderstood 
>> something about the working of other platforms? In x86 case, from what 
>> i see relocate_kernel is still part of the older kernel and not 
>> purgatory, and with my patch, purgatory.ro is not built and kexec does 
>> execute successfully with purgatory disabled.
>>
>> About your point for the old and the new kernel may run at the same 
>> addresses,i dont think that can happen as in bzImage64_load function 
>> its loaded using the kbuf struct. This doesnt happen in other 
>> architectures (for e.g. arm64) that dont implement purgatory and any 
>> of the tests I conducted with the patch applied due to the use of kbuf 
>> struct.
>>
>>  From what i see in the code, purgatory in x86 specifically, has 2 
>> main functions, sha256 verification and loading the %rsi register for 
>> bootparam_load_addr. In this patch purgatory was disabled, which 
>> resulted in sha256 verification disabled and bootparam_load_addr moved 
>> to relocate_kernel. Our analysis revealed that most of the time is 
>> spent in the sha256 verification, so I would be ok to reformat the patch
>> to make the sha verification optional and keep purgatory enabled if 
>> thats preferred? Although in my opinion the current patch of only 
>> providing an option to disable purgatory seems much better.
>>
>>
>>> That sha256 verification is always needed for kexec on panic, there are
>>> by the nature of a kernel panic too many unknowns to have any confidence
>>> the new kernel will not be corrupted in the process of kexec before it
>>> gets started.
>>>
>>> For an ordinary kexec it might be possible to say that you have a
>>> reliable kernel shutdown process and you know for a fact that something
>>> won't come along and corrupt the kernel.  I find that a questionable
>>> assertion.  I haven't seen anyone yet whose focus when getting an
>>> ordinary kexec to work as anything other than making certain all of the
>>> drivers are shutdown properly.
>>>
>>> I have seen countless times when a network packet comes in a the wrong
>>> time and the target kernel's memory is corrupted before it gets far
>>> enough to initialize the network driver. >
>>
>> I agree that when doing testing and research, there are things that can
>> go wrong during kexec process, but i assume that the expectation is that
>> in production environment, when for e.g. updating a kernel with kexec 
>> in servers,the expectation is that kexec will execute successfully as 
>> long as there is nothing wrong in the old kernel and the new kernel.
>>
>> Maybe I didn't understand this correctly, but if a network packet 
>> comes in and corrupts the kernel memory, wont it also cause a problem 
>> even when purgatory is enabled? I agree that issue like these would be 
>> caught earlier with purgatory, but then if something like this breaks 
>> the kexec process in a production environment where the old and new 
>> kernel are well tested, trusted and expected to work, wouldn't there 
>> be a much more fundamental issue with the reliability of the current 
>> kexec process.
>>
>>> For a 0.2s speed up you are talking about disabling all of the safety
>>> checks in a very dangerous situation.  How much can you can in
>>> performance by optimizing the sha256 implementation instead of using
>>> what is essentially a reference implementation in basic C that I copied
>>> from somewhere long ago.
>>>
>>> Optimize the sha256 implementation and the memory copy loop and then
>>> show how the tiny bit of time that is left is on a mission critical path
>>> and must be removed.  Then we can reasonably talk about a config option
>>> for disabling the sha256 implementation in the kexec in not-panic case.
>>>
>> Thanks for this, I assume that over here you are suggesting for e.g. 
>> in x86 to replace the existing sha verification implementation in 
>> purgatory with the one in arch/x86/crypto/sha256_ssse3_glue.c? Also 
>> could you point to the memory copy loop to optimize? I can have a look 
>> at these 2 options.
>>
>> Even with these optimizations, i think the v2 patch should still be 
>> considered. The patch in the end is providing only an option to 
>> disable purgatory on x86 only, with the default value of keeping it 
>> enabled and not changing kexec behaviour. The CONFIG already existed, 
>> it is just renamed and now provides user the option to select to 
>> disable purgatory for x86, rather than it being architecture dependent.
>>
>> Thanks again for the review and comments,
>> Usama
>>
>>
>>> That sha256 implementation in part so that we can all sleep at night
>>> because we don't have to deal with very very strange heizenbugs.
>>>
>>> Eric
>>>
