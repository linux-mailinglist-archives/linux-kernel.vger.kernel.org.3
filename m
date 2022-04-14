Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F9501B61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiDNSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiDNSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:54:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B83CE0AC4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:52:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t4so5546423pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KPncbYJNbA92y1tOvGAA/kfwDjyfM1X8IrkxMDKfJ+M=;
        b=oNJvsyY0dZL8jzpd34U1+lD1Mh8SQf6LfMh/R2x0RNJXbEdp0Xg7P85/Y+6PQt0AES
         rhaP4cro55hlKlnS+hw2JRDJMYhHFgA8+9OIE42iBmqFG6lmbZCLPNkLehXQLN21cuOM
         91/dtOApOgZJLABiR/avAVberdE2aWu4pBxhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPncbYJNbA92y1tOvGAA/kfwDjyfM1X8IrkxMDKfJ+M=;
        b=QTazqMWt7zt1mI08CoWgQ/P87R7an7r1OGDxpe0KATda5zXOLxbuolM+rqhT7HkBBB
         O1LzVEnA2+U/zM0g+kGZMajIztmON6lg0Dx2Jy5Ef4oOjFFqOJ6yLcCvtMli8JPgCBGb
         NaqHUJyLMcSscuRDiufhjNMiD2CZDYuNawQa+7plnS5+DHvVAH+rrHmTR9uq9LdJQOxZ
         XKL7loeeWSCQEY8Uz7eOZhrDBtnPYoK4PSsljfj3H2Yx2w5kytMClgYXe/npEnaiZmuy
         +WUu+0+CMJfL8CFTIV2QhWNqgrIu9SEYWrggrKgfKq6oDaetegRRbLvPhEcI6u+tEqHc
         Tyvw==
X-Gm-Message-State: AOAM532G7YwGiUD1slN9AKcefctclBkQHDWPxVTDxlzfwXd6G3LpGaFL
        O0IOn+IQP7MJe/KyeCy+jYfgMA==
X-Google-Smtp-Source: ABdhPJw+Fal9pBni7mp3U0SmabFGXSbaUnm/vG5K31I/eUCpSn6eG3IceNt4WGY+Pb6rg423uVG4qg==
X-Received: by 2002:a62:1548:0:b0:505:fd84:33f1 with SMTP id 69-20020a621548000000b00505fd8433f1mr5299523pfv.66.1649962338843;
        Thu, 14 Apr 2022 11:52:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b005081ec7d679sm613192pfb.1.2022.04.14.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:52:18 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:52:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <202204141028.0482B08@keescook>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413134946.2732468-1-catalin.marinas@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 02:49:42PM +0100, Catalin Marinas wrote:
> The background to this is that systemd has a configuration option called
> MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
> is to prevent a user task from inadvertently creating an executable
> mapping that is (or was) writeable. Since such BPF filter is stateless,
> it cannot detect mappings that were previously writeable but
> subsequently changed to read-only. Therefore the filter simply rejects
> any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
> support (Branch Target Identification), the dynamic loader cannot change
> an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
> For libraries, it can resort to unmapping and re-mapping but for the
> main executable it does not have a file descriptor. The original bug
> report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
> for libraries - [3].

Right, so, the systemd filter is a big hammer solution for the kernel
not having a very easy way to provide W^X mapping protections to
userspace. There's stuff in SELinux, and there have been several
attempts[1] at other LSMs to do it too, but nothing stuck.

Given the filter, and the implementation of how to enable BTI, I see two
solutions:

- provide a way to do W^X so systemd can implement the feature differently
- provide a way to turn on BTI separate from mprotect to bypass the filter

I would agree, the latter seems like the greater hack, so I welcome
this RFC, though I think it might need to explore a bit of the feature
space exposed by other solutions[1] (i.e. see SARA and NAX), otherwise
it risks being too narrowly implemented. For example, playing well with
JITs should be part of the design, and will likely need some kind of
ELF flags and/or "sealing" mode, and to handle the vma alias case as
Jann Horn pointed out[2].

> Add in-kernel support for such feature as a DENY_WRITE_EXEC personality
> flag, inherited on fork() and execve(). The kernel tracks a previously
> writeable mapping via a new VM_WAS_WRITE flag (64-bit only
> architectures). I went for a personality flag by analogy with the
> READ_IMPLIES_EXEC one. However, I'm happy to change it to a prctl() if
> we don't want more personality flags. A minor downside with the
> personality flag is that there is no way for the user to query which
> flags are supported, so in patch 3 I added an AT_FLAGS bit to advertise
> this.

My instinct here is to use a prctl(), which maps to other kinds of modern
inherited state (like no_new_privs).

> Posting this as an RFC to start a discussion and cc'ing some of the
> systemd guys and those involved in the earlier thread around the glibc
> workaround for dynamic libraries [4]. Before thinking of upstreaming
> this we'd need the systemd folk to buy into replacing the MDWE SECCOMP
> BPF filter with the in-kernel one.
> 
> Thanks,
> 
> Catalin
> 
> [1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#MemoryDenyWriteExecute=
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1888842
> [3] https://sourceware.org/bugzilla/show_bug.cgi?id=26831
> [3] https://lore.kernel.org/r/cover.1604393169.git.szabolcs.nagy@arm.com

So, yes, let's do it. It's long long overdue in the kernel. :)

-Kees

[1] https://github.com/KSPP/linux/issues/32
[2] https://github.com/KSPP/linux/issues/32#issuecomment-1084859611

> 
> Catalin Marinas (4):
>   mm: Track previously writeable vma permission
>   mm, personality: Implement memory-deny-write-execute as a personality
>     flag
>   fs/binfmt_elf: Tell user-space about the DENY_WRITE_EXEC personality
>     flag
>   arm64: Select ARCH_ENABLE_DENY_WRITE_EXEC
> 
>  arch/arm64/Kconfig               |  1 +
>  fs/binfmt_elf.c                  |  2 ++
>  include/linux/mm.h               |  6 ++++++
>  include/linux/mman.h             | 18 +++++++++++++++++-
>  include/uapi/linux/binfmts.h     |  4 ++++
>  include/uapi/linux/personality.h |  1 +
>  mm/Kconfig                       |  4 ++++
>  mm/mmap.c                        |  3 +++
>  mm/mprotect.c                    |  5 +++++
>  9 files changed, 43 insertions(+), 1 deletion(-)
> 

-- 
Kees Cook
