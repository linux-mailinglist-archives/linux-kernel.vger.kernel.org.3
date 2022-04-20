Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A250938D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiDTXYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383158AbiDTXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:24:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA41C13D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:21:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t13so3105751pgn.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ty3DFGunF6jW21MAnsyi+iAr+gyos3k1HPrH3m9fTc=;
        b=XnWq2s9XXwGGB2wgFdDYbKC7tkgxh2/Z4V4PkH12svVokJESgvrFm5JNzgsc74GH3y
         PRmXS5NWLTC5YYg3pP+kw7BUee1T44m8duw4HXfmeLtW6YHy8MuBR4c8niTk8T0VuZ9b
         QJEAL6A9MGfaxtHAG67ubRu9en7CGwFeOVg9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ty3DFGunF6jW21MAnsyi+iAr+gyos3k1HPrH3m9fTc=;
        b=g1EOS6h6uWeMSXalCakKxrh+pJKxsttUkm3rL4+Tf09/ZplkqopR+eVSrRJ96wSrOG
         b/jtOPVYVrH56GWjI+KJEqp4NfgzNdnV9tJ9uBLXRgGGIhWYpIAYBL+4OMKemlzcwGSc
         YufsUEk6v2l67n8RYYW7PXWI0/asGK4pk2/3rgONowFc5jowerj5aCliKMqpf7fkJrWl
         f6cZXOoX4PA11yc9NTirZNoa1Rnp1sTrOduWydd9610nUhV33+z+qjt8uVpv9nBflooe
         yT97H2F1mlw1aR8VVBgTjycKWL/o58+LhALdikJeJDlCqkBsNbjXLCWtRsyh3MBLGXMu
         6zbg==
X-Gm-Message-State: AOAM5325a0IQnwb/Cm87q5MzMP3b0bRqDSJRHzD5e0ZuNvM4X7TOYyx7
        TIzuc8+nIk5K1JopvWxC7UpvyQ==
X-Google-Smtp-Source: ABdhPJwXpf1B85gWACAiQZBQg4zWKjO4yRVSkAvJBvOqRuLOMe9Mwe1L7hhkVq+XyKdgJYc9LDZ6kA==
X-Received: by 2002:a65:46cf:0:b0:399:13b3:dd8b with SMTP id n15-20020a6546cf000000b0039913b3dd8bmr21529884pgr.585.1650496906919;
        Wed, 20 Apr 2022 16:21:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7-20020aa78487000000b00505d9277cb3sm20637059pfn.38.2022.04.20.16.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 16:21:46 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:21:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
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
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <202204201610.093C9D5FE8@keescook>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:34:33PM +0300, Topi Miettinen wrote:
> On 20.4.2022 16.01, Catalin Marinas wrote:
> > On Thu, Apr 14, 2022 at 11:52:17AM -0700, Kees Cook wrote:
> > > On Wed, Apr 13, 2022 at 02:49:42PM +0100, Catalin Marinas wrote:
> > > > The background to this is that systemd has a configuration option called
> > > > MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
> > > > is to prevent a user task from inadvertently creating an executable
> > > > mapping that is (or was) writeable. Since such BPF filter is stateless,
> > > > it cannot detect mappings that were previously writeable but
> > > > subsequently changed to read-only. Therefore the filter simply rejects
> > > > any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
> > > > support (Branch Target Identification), the dynamic loader cannot change
> > > > an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
> > > > For libraries, it can resort to unmapping and re-mapping but for the
> > > > main executable it does not have a file descriptor. The original bug
> > > > report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
> > > > for libraries - [3].
> > > 
> > > Right, so, the systemd filter is a big hammer solution for the kernel
> > > not having a very easy way to provide W^X mapping protections to
> > > userspace. There's stuff in SELinux, and there have been several
> > > attempts[1] at other LSMs to do it too, but nothing stuck.
> > > 
> > > Given the filter, and the implementation of how to enable BTI, I see two
> > > solutions:
> > > 
> > > - provide a way to do W^X so systemd can implement the feature differently
> > > - provide a way to turn on BTI separate from mprotect to bypass the filter
> > > 
> > > I would agree, the latter seems like the greater hack,
> > 
> > We discussed such hacks in the past but they are just working around the
> > fundamental issue - systemd wants W^X but with BPF it can only achieve
> > it by preventing mprotect(PROT_EXEC) irrespective of whether the mapping
> > was already executable. If we find a better solution for W^X, we
> > wouldn't have to hack anything for mprotect(PROT_EXEC|PROT_BTI).
> > 
> > > so I welcome
> > > this RFC, though I think it might need to explore a bit of the feature
> > > space exposed by other solutions[1] (i.e. see SARA and NAX), otherwise
> > > it risks being too narrowly implemented. For example, playing well with
> > > JITs should be part of the design, and will likely need some kind of
> > > ELF flags and/or "sealing" mode, and to handle the vma alias case as
> > > Jann Horn pointed out[2].
> > 
> > I agree we should look at what we want to cover, though trying to avoid
> > re-inventing SELinux. With this patchset I went for the minimum that
> > systemd MDWE does with BPF.
> > 
> > I think JITs get around it using something like memfd with two separate
> > mappings to the same page. We could try to prevent such aliases but
> > allow it if an ELF note is detected (or get the JIT to issue a prctl()).
> > 
> > Anyway, with a prctl() we can allow finer-grained control starting with
> > anonymous and file mappings and later extending to vma aliases,
> > writeable files etc. On top we can add a seal mask so that a process
> > cannot disable a control was set. Something like (I'm not good at
> > names):
> > 
> > 	prctl(PR_MDWX_SET, flags, seal_mask);
> > 	prctl(PR_MDWX_GET);
> > 
> > with flags like:
> > 
> > 	PR_MDWX_MMAP - basics, should cover mmap() and mprotect()
> > 	PR_MDWX_ALIAS - vma aliases, allowed with an ELF note
> > 	PR_MDWX_WRITEABLE_FILE
> > 
> > (needs some more thinking)
> > 
> 
> For systemd, feature compatibility with the BPF version is important so that
> we could automatically switch to the kernel version once available without
> regressions. So I think PR_MDWX_MMAP (or maybe PR_MDWX_COMPAT) should match
> exactly what MemoryDenyWriteExecute=yes as implemented with BPF has: only
> forbid mmap(PROT_EXEC|PROT_WRITE) and mprotect(PROT_EXEC). Like BPF, once
> installed there should be no way to escape and ELF flags should be also
> ignored. ARM BTI should be allowed though (allow PROT_EXEC|PROT_BTI if the
> old flags had PROT_EXEC).
> 
> Then we could have improved versions (other PR_MDWX_ prctls) with lots more
> checks. This could be enabled with MemoryDenyWriteExecute=strict or so.
> 
> Perhaps also more relaxed versions (like SARA) could be interesting (system
> service running Python with FFI, or perhaps JVM etc), enabled with for
> example MemoryDenyWriteExecute=trampolines. That way even those programs
> would get some protection (though there would be a gap in the defences).

Yup, I think we're all on the same page. Catalin, can you respin with a
prctl for enabling MDWE? I propose just:

	prctl(PR_MDWX_SET, flags);
	prctl(PR_MDWX_GET);

	PR_MDWX_FLAG_MMAP
		disallows PROT_EXEC on any VMA that is or was PROT_WRITE,
		covering at least: mmap, mprotect, pkey_mprotect, and shmat.

I don't think anything should be allowed to be disabled once set.

-- 
Kees Cook
