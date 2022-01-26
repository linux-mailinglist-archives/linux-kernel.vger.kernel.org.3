Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C313949D2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbiAZT4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiAZT4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:56:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B0C061748
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:56:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n16-20020a17090a091000b001b46196d572so635232pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3RiDts757cZNDXWuCjuazq6SO2jRwzQKv/crENeSiB0=;
        b=kpBp6pi/DEl1ZEEfHfjXz4yG/wGDlt5X6bfXax+jmH3Br1OVIuoez9WkAlMZ1mipMQ
         hyOCII7LdkJQH/VvbL37M403Fc2rf6V8VDb8PhyC5fOn3Cmm6a2wh8MAg+mqozepizQ9
         DVyGq504D3MftJBgcwFIVgRLHmmXTsGMd6Wjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3RiDts757cZNDXWuCjuazq6SO2jRwzQKv/crENeSiB0=;
        b=WMFIoYUF2MPACjcl7sTnqLLDTni4Xu25PbD8zocvVH6OXhNTaVKLRXn2rR6eZ6trWj
         ij+H5DfDf2Qg4J4dcWm4GzIfS7V4yaulCPEwZjyz325e2DGqULqf3+KuUOp0Bki7tjbL
         LHlNneKaA+GxyzK0zcfj4oE99wAUCHvL7S49YWgAgPlf75sLSve5cl/Ow9jIxJXnGaxE
         n0QcU2SIMBgg7wFs8mfpKsw7gfh9plGHic9gSpxb9xHTL/rsZ7s/qq1nvFbbkSOIBqWl
         75uzD/O2R8RMpHevPMTWQjiOCLxlqXbEZTR3tx3i7yyPtNUdxCCfQxuMOTocgucNhLdj
         F3SA==
X-Gm-Message-State: AOAM532xFLh1RruGoF477sJFp0Z0CyE5ZwQ/XnIlFFtwti+RYk1G8ioU
        TYVpcmPsJWPqP7wbwfMdGSVFMw==
X-Google-Smtp-Source: ABdhPJzj9Mz0IrHesqmqkcL462alqR63s5rXKVhBhrBb4Rbo0h4LiqEDYYuPIv91Fw7biD+vzlleGQ==
X-Received: by 2002:a17:90b:4b0a:: with SMTP id lx10mr542612pjb.16.1643226991822;
        Wed, 26 Jan 2022 11:56:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 189sm2790384pfe.164.2022.01.26.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:56:31 -0800 (PST)
Date:   Wed, 26 Jan 2022 11:56:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_elf: Add padding NULL when argc == 0
Message-ID: <202201261155.7CC0A992@keescook>
References: <20220126175747.3270945-1-keescook@chromium.org>
 <CAG48ez3hN8+zNCmLVP0yU0A5op6BAS+A-rs05aiLm4RQvzzBpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3hN8+zNCmLVP0yU0A5op6BAS+A-rs05aiLm4RQvzzBpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 07:07:20PM +0100, Jann Horn wrote:
> On Wed, Jan 26, 2022 at 6:58 PM Kees Cook <keescook@chromium.org> wrote:
> > Quoting Ariadne Conill:
> >
> > "In several other operating systems, it is a hard requirement that the
> > first argument to execve(2) be the name of a program, thus prohibiting
> > a scenario where argc < 1. POSIX 2017 also recommends this behaviour,
> > but it is not an explicit requirement[1]:
> >
> >     The argument arg0 should point to a filename string that is
> >     associated with the process being started by one of the exec
> >     functions.
> > ...
> > Interestingly, Michael Kerrisk opened an issue about this in 2008[2],
> > but there was no consensus to support fixing this issue then.
> > Hopefully now that CVE-2021-4034 shows practical exploitative use[3]
> > of this bug in a shellcode, we can reconsider."
> >
> > An examination of existing[4] users of execve(..., NULL, NULL) shows
> > mostly test code, or example rootkit code. While rejecting a NULL argv
> > would be preferred, it looks like the main cause of userspace confusion
> > is an assumption that argc >= 1, and buggy programs may skip argv[0]
> > when iterating. To protect against userspace bugs of this nature, insert
> > an extra NULL pointer in argv when argc == 0, so that argv[1] != envp[0].
> >
> > Note that this is only done in the argc == 0 case because some userspace
> > programs expect to find envp at exactly argv[argc]. The overlap of these
> > two misguided assumptions is believed to be zero.
> 
> Will this result in the executed program being told that argc==0 but
> having an extra NULL pointer on the stack?
> If so, I believe this breaks the x86-64 ABI documented at
> https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf - page 29,
> figure 3.9 describes the layout of the initial process stack.
> 
> Actually, does this even work? Can a program still properly access its
> environment variables when invoked with argc==0 with this patch
> applied? AFAIU the way userspace locates envv on x86-64 is by
> calculating 8*(argc+1)?

Hrm, yeah, I guess it's libc providing the envp pointer; it's not passes
separately. Hrm.

-- 
Kees Cook
