Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7F4509087
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381812AbiDTThZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbiDTThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:37:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7C3EF1D;
        Wed, 20 Apr 2022 12:34:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q14so3095907ljc.12;
        Wed, 20 Apr 2022 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tjgtD5b88stSGfQKWtLEKZrrmLsw2qkBuwSeeJ0zuRk=;
        b=REQ3x7fKLP/EuTnv0GmQmMXaaniRwUtG/2NAsMQ0MKCDkm1I6tRznXQUJsItKuoTlm
         p2MF8iE5Zzu70G+Gasx2709mXA32PLi1wAASYvs9Q+xTSQ6+D9l0maFctJ2wOTMXGrai
         bXT3nA9aBaIPBAQsD2PONNhOJkMpkO0CtaImBZd91OqIgwwKnIukZKvAOeSfejYz+uoA
         pmSTmTrd9MKdpBJza5p0CZyEbb97EnQ4kmBNIyEBE9MjU3kxGEbL/vd8cAMOmYYBgV+E
         cM5GkendfRXfCHNQhG1krUj2XdXAt5aLy1IZPHTXMHM/5rGHWxU+ZYijqStV6BvlSlGD
         r2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tjgtD5b88stSGfQKWtLEKZrrmLsw2qkBuwSeeJ0zuRk=;
        b=A8WtQ+iIAH04sp9ymTQmdrko69Haa6UNbB57Om7Oh7DvO6yY8s4h4qm54RoVvJb9Ep
         5pNpKUk8X4EW/SPCTPWN4p8afaxKRdRdT8R/c6YOZJEdEgYBbWgsywxGG85t6FsGazZ3
         mdsh1Cg/z6SwBRjbAphxso3tyS+kzZPWnBy30+zqzazcZPaK2zsDVjRo063rkQn6jDsE
         vuEou1LYugkrf8oPW/Mu3zthsptfS05oJSu7BGNK5sqx6IBPD3KRHQYaBOL54jaPJV6B
         kVUhl1mdnkK0H1aqL6Qtams3qagdkY6t6PMuLUrtDz9b4bp6sdEtmsWubgagS3sndPje
         gJKQ==
X-Gm-Message-State: AOAM533rzEgjktU1nfe3sDf9WyhL94c6JoFFte6bvUb1D6x5blPXMfFJ
        VVhL7LFqfLl8/51hNnNWSGk=
X-Google-Smtp-Source: ABdhPJxsHjCQqq6WluovUBYdrQyV3jelbuozqG0OYcQa6CZdvrrYWe8QWnKWHKNYaNel51RNGyzwhg==
X-Received: by 2002:a05:651c:905:b0:247:e451:48a5 with SMTP id e5-20020a05651c090500b00247e45148a5mr14529352ljq.313.1650483275515;
        Wed, 20 Apr 2022 12:34:35 -0700 (PDT)
Received: from [192.168.1.38] (91-159-150-194.elisa-laajakaista.fi. [91.159.150.194])
        by smtp.gmail.com with ESMTPSA id d14-20020a19f24e000000b00471a405963asm698679lfk.304.2022.04.20.12.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 12:34:35 -0700 (PDT)
Message-ID: <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
Date:   Wed, 20 Apr 2022 22:34:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook> <YmAEDsGtxhim46UI@arm.com>
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <YmAEDsGtxhim46UI@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.4.2022 16.01, Catalin Marinas wrote:
> On Thu, Apr 14, 2022 at 11:52:17AM -0700, Kees Cook wrote:
>> On Wed, Apr 13, 2022 at 02:49:42PM +0100, Catalin Marinas wrote:
>>> The background to this is that systemd has a configuration option called
>>> MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
>>> is to prevent a user task from inadvertently creating an executable
>>> mapping that is (or was) writeable. Since such BPF filter is stateless,
>>> it cannot detect mappings that were previously writeable but
>>> subsequently changed to read-only. Therefore the filter simply rejects
>>> any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
>>> support (Branch Target Identification), the dynamic loader cannot change
>>> an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
>>> For libraries, it can resort to unmapping and re-mapping but for the
>>> main executable it does not have a file descriptor. The original bug
>>> report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
>>> for libraries - [3].
>>
>> Right, so, the systemd filter is a big hammer solution for the kernel
>> not having a very easy way to provide W^X mapping protections to
>> userspace. There's stuff in SELinux, and there have been several
>> attempts[1] at other LSMs to do it too, but nothing stuck.
>>
>> Given the filter, and the implementation of how to enable BTI, I see two
>> solutions:
>>
>> - provide a way to do W^X so systemd can implement the feature differently
>> - provide a way to turn on BTI separate from mprotect to bypass the filter
>>
>> I would agree, the latter seems like the greater hack,
> 
> We discussed such hacks in the past but they are just working around the
> fundamental issue - systemd wants W^X but with BPF it can only achieve
> it by preventing mprotect(PROT_EXEC) irrespective of whether the mapping
> was already executable. If we find a better solution for W^X, we
> wouldn't have to hack anything for mprotect(PROT_EXEC|PROT_BTI).
> 
>> so I welcome
>> this RFC, though I think it might need to explore a bit of the feature
>> space exposed by other solutions[1] (i.e. see SARA and NAX), otherwise
>> it risks being too narrowly implemented. For example, playing well with
>> JITs should be part of the design, and will likely need some kind of
>> ELF flags and/or "sealing" mode, and to handle the vma alias case as
>> Jann Horn pointed out[2].
> 
> I agree we should look at what we want to cover, though trying to avoid
> re-inventing SELinux. With this patchset I went for the minimum that
> systemd MDWE does with BPF.
> 
> I think JITs get around it using something like memfd with two separate
> mappings to the same page. We could try to prevent such aliases but
> allow it if an ELF note is detected (or get the JIT to issue a prctl()).
> 
> Anyway, with a prctl() we can allow finer-grained control starting with
> anonymous and file mappings and later extending to vma aliases,
> writeable files etc. On top we can add a seal mask so that a process
> cannot disable a control was set. Something like (I'm not good at
> names):
> 
> 	prctl(PR_MDWX_SET, flags, seal_mask);
> 	prctl(PR_MDWX_GET);
> 
> with flags like:
> 
> 	PR_MDWX_MMAP - basics, should cover mmap() and mprotect()
> 	PR_MDWX_ALIAS - vma aliases, allowed with an ELF note
> 	PR_MDWX_WRITEABLE_FILE
> 
> (needs some more thinking)
> 

For systemd, feature compatibility with the BPF version is important so 
that we could automatically switch to the kernel version once available 
without regressions. So I think PR_MDWX_MMAP (or maybe PR_MDWX_COMPAT) 
should match exactly what MemoryDenyWriteExecute=yes as implemented with 
BPF has: only forbid mmap(PROT_EXEC|PROT_WRITE) and mprotect(PROT_EXEC). 
Like BPF, once installed there should be no way to escape and ELF flags 
should be also ignored. ARM BTI should be allowed though (allow 
PROT_EXEC|PROT_BTI if the old flags had PROT_EXEC).

Then we could have improved versions (other PR_MDWX_ prctls) with lots 
more checks. This could be enabled with MemoryDenyWriteExecute=strict or so.

Perhaps also more relaxed versions (like SARA) could be interesting 
(system service running Python with FFI, or perhaps JVM etc), enabled 
with for example MemoryDenyWriteExecute=trampolines. That way even those 
programs would get some protection (though there would be a gap in the 
defences).

-Topi
