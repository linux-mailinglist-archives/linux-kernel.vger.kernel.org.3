Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB7502F72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350526AbiDOUDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349856AbiDOUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:03:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA2C5D1BF;
        Fri, 15 Apr 2022 13:01:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o16so10510253ljp.3;
        Fri, 15 Apr 2022 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eg4gbJGTcuDjydc93ZgiyQp7rGraJcFEx1C1W41BcoE=;
        b=h9J8t2jbujSYA51XssuWPT+TwPBC0hpc4NNrexHCEGwQHAuOieOurTwZYlyAYw+HNq
         ChT2X77bZtwp1CcM6eDjCnR11R6Nh82vxVzBenPkApzoZHHmnp/icFdomknh2OLflAUy
         1d2GD4XrY/9bilZfh064seB9+ldnhy1kwCeifrn7Wpt+DRR/K62FTXLnHvLcML1I8N+N
         vEs4ivWBPRt8itxGZyDoTaMpYd1OW7FewxAuZZ+1KPFPhj///tyVx2puQBqe0yUMia6V
         MRXiQb3AbFzYVcLbAfWShlNQkoyM2NFNNybmUS/TJgr3ggcERl7PcIWLj278jnUGAbA0
         hgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eg4gbJGTcuDjydc93ZgiyQp7rGraJcFEx1C1W41BcoE=;
        b=eq0k5kE5GqS/o1WRq3p2l0GiHZ9QrkqRlwyqNylZu41TrzA+lr12hxtC8pH5lU9brL
         Y8w8JV4AqbGyASwCxT+siL/E1sVk1fYbKObaSRExdUAWWTTxVwdwsELLf7bY2bH4ZmRU
         XDmoOVcrCQznbRPOml8T8WvDErN+aPwbFvjN5nhgv2sgVi6c2MDXOE56SHtxa+qt/7VC
         2zWRWnls9G/hrt75txpdeIkG2epwhg7/nIJsGGAXSoox1FWALdY0ThoxmccZFV9rUv0l
         GcKfBF8NBpnNWhwlRnMYTKAch+K97Q7dI0iCLVy1AiKPYdKGBe1rWqi8uXaDXRK1dgZf
         HI5A==
X-Gm-Message-State: AOAM530D10uJs6p9mODVcu7sEBX54vOUe1t98G3S8OSiBT/UAUewjY/w
        1KZE6BLMSgd1xuKhklnP3NI=
X-Google-Smtp-Source: ABdhPJxo7t7sKZ95V5o15r/5Ws72mkjtn0VsMmnL3V3M++Sv6h05ITpulnOCCPrR2+mNheI9i/c2Xg==
X-Received: by 2002:a05:651c:b11:b0:249:9504:e929 with SMTP id b17-20020a05651c0b1100b002499504e929mr402051ljr.0.1650052863776;
        Fri, 15 Apr 2022 13:01:03 -0700 (PDT)
Received: from [192.168.1.38] (91-159-150-194.elisa-laajakaista.fi. [91.159.150.194])
        by smtp.gmail.com with ESMTPSA id c11-20020a19e34b000000b0046f423c87e2sm260940lfk.173.2022.04.15.13.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 13:01:02 -0700 (PDT)
Message-ID: <eb8ba1ad-eb39-9ac3-de5e-ca69ce5af75e@gmail.com>
Date:   Fri, 15 Apr 2022 23:01:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>
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
 <202204141028.0482B08@keescook>
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <202204141028.0482B08@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.4.2022 21.52, Kees Cook wrote:
> On Wed, Apr 13, 2022 at 02:49:42PM +0100, Catalin Marinas wrote:
>> The background to this is that systemd has a configuration option called
>> MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
>> is to prevent a user task from inadvertently creating an executable
>> mapping that is (or was) writeable. Since such BPF filter is stateless,
>> it cannot detect mappings that were previously writeable but
>> subsequently changed to read-only. Therefore the filter simply rejects
>> any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
>> support (Branch Target Identification), the dynamic loader cannot change
>> an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
>> For libraries, it can resort to unmapping and re-mapping but for the
>> main executable it does not have a file descriptor. The original bug
>> report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
>> for libraries - [3].
> 
> Right, so, the systemd filter is a big hammer solution for the kernel
> not having a very easy way to provide W^X mapping protections to
> userspace. There's stuff in SELinux, and there have been several
> attempts[1] at other LSMs to do it too, but nothing stuck.
> 
> Given the filter, and the implementation of how to enable BTI, I see two
> solutions:
> 
> - provide a way to do W^X so systemd can implement the feature differently
> - provide a way to turn on BTI separate from mprotect to bypass the filter
> 
> I would agree, the latter seems like the greater hack, so I welcome
> this RFC, though I think it might need to explore a bit of the feature
> space exposed by other solutions[1] (i.e. see SARA and NAX), otherwise
> it risks being too narrowly implemented. For example, playing well with
> JITs should be part of the design, and will likely need some kind of
> ELF flags and/or "sealing" mode, and to handle the vma alias case as
> Jann Horn pointed out[2].

Another interesting case from 2006 by Ulrich Drepper is to use a 
temporary file and map it twice, once with PROT_WRITE and once with 
PROT_EXEC [1]. This isn't possible if the mount flags of the file 
systems are also in line with W^X principle. System services (unlike 
user apps) typically don't use /tmp nor /dev/shm (mounted with 
"rw,exec"). With systemd a simple file system W^X policy can be 
implemented for a service for example with NoExecPaths=/ ExecPaths=/usr 
ReadOnlyPaths=/usr. In-kernel MDWE probably could look beyond file 
descriptors and check if the mount flags of the file system containing 
the file being mmap()ed agree with W^X. The use cases for system 
services and user apps may be different: system services are often 
compatible with maximum hardening, while user apps may need various 
compatibility solutions if they use JIT, trampolines or FFI and access 
to W+X file systems may be also needed.

-Topi

[1] https://akkadia.org/drepper/selinux-mem.html

>> Add in-kernel support for such feature as a DENY_WRITE_EXEC personality
>> flag, inherited on fork() and execve(). The kernel tracks a previously
>> writeable mapping via a new VM_WAS_WRITE flag (64-bit only
>> architectures). I went for a personality flag by analogy with the
>> READ_IMPLIES_EXEC one. However, I'm happy to change it to a prctl() if
>> we don't want more personality flags. A minor downside with the
>> personality flag is that there is no way for the user to query which
>> flags are supported, so in patch 3 I added an AT_FLAGS bit to advertise
>> this.
> 
> My instinct here is to use a prctl(), which maps to other kinds of modern
> inherited state (like no_new_privs).
> 
>> Posting this as an RFC to start a discussion and cc'ing some of the
>> systemd guys and those involved in the earlier thread around the glibc
>> workaround for dynamic libraries [4]. Before thinking of upstreaming
>> this we'd need the systemd folk to buy into replacing the MDWE SECCOMP
>> BPF filter with the in-kernel one.
>>
>> Thanks,
>>
>> Catalin
>>
>> [1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#MemoryDenyWriteExecute=
>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1888842
>> [3] https://sourceware.org/bugzilla/show_bug.cgi?id=26831
>> [3] https://lore.kernel.org/r/cover.1604393169.git.szabolcs.nagy@arm.com
> 
> So, yes, let's do it. It's long long overdue in the kernel. :)
> 
> -Kees
> 
> [1] https://github.com/KSPP/linux/issues/32
> [2] https://github.com/KSPP/linux/issues/32#issuecomment-1084859611
> 
>>
>> Catalin Marinas (4):
>>    mm: Track previously writeable vma permission
>>    mm, personality: Implement memory-deny-write-execute as a personality
>>      flag
>>    fs/binfmt_elf: Tell user-space about the DENY_WRITE_EXEC personality
>>      flag
>>    arm64: Select ARCH_ENABLE_DENY_WRITE_EXEC
>>
>>   arch/arm64/Kconfig               |  1 +
>>   fs/binfmt_elf.c                  |  2 ++
>>   include/linux/mm.h               |  6 ++++++
>>   include/linux/mman.h             | 18 +++++++++++++++++-
>>   include/uapi/linux/binfmts.h     |  4 ++++
>>   include/uapi/linux/personality.h |  1 +
>>   mm/Kconfig                       |  4 ++++
>>   mm/mmap.c                        |  3 +++
>>   mm/mprotect.c                    |  5 +++++
>>   9 files changed, 43 insertions(+), 1 deletion(-)
>>
> 

