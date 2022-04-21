Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7737450A60A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiDUQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiDUQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:45:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B1048E41
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:42:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so5707765pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGKEvdgYRQ7SM+AO2vjpmqYxP+BldJQN162qNBP3cZU=;
        b=mB7+i6aOyxqKX81weI4FoQBPHQS7Yc1HSgzDeU5y/1s3jioCgVQBAmxogLw3X4u405
         ATFSON/HUUhbKe5oLUTZgoght91a9ULLu35Mr6atCZrkVtOimFJMlRhT2KfW3BEIVjN7
         9fLhdFyUIDyvHVOyuKDh/goUflgsOwBuirkuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGKEvdgYRQ7SM+AO2vjpmqYxP+BldJQN162qNBP3cZU=;
        b=q3fmmFmB+ABoQ7uC7NVyUUcYhGwSJXF7O6vSRA1AMvRsfmaRMRi8kdwZ3vYhR91XIz
         EpnMQnKbeHKB8rodHM8GmxkGuh2qLlnaRPTQ4lp/dvUIiw1Y1rPIp8Fe37xxFviGb3wH
         ROXmjkc+RACnsdHGW8voGVQqK9sWZ6lStyK5gvFe5bIV++ZEowY1QuWOBleCojfCUd2m
         2kZ/lGNnVDaJkCM+nGHenAsU/B/Y3c+AZ5faBY6NZgAuajh4qo/eeAOAMNI+Rnbmzvje
         FapdwuvNmmS2kzBbuJtcaPW/4Tde4qKgEzslP1QgJWinbQe3oLoVZsFZSLhUFKayptrC
         LtYg==
X-Gm-Message-State: AOAM532DPs0IKfBt6db8zUoAL4p2ApZ9KyxuPI6ib1t20AQMlmTAoISh
        6JLcUQSkQDCfBNpmqpAryIXZcQ==
X-Google-Smtp-Source: ABdhPJzhFmMSZnztpRzJKTkyr58MC5Qtizd2jhpjoY39cLT1geTbd0SbOnPo810CxKtCMtjBkj76hg==
X-Received: by 2002:a17:902:778a:b0:158:da0f:f299 with SMTP id o10-20020a170902778a00b00158da0ff299mr366502pll.29.1650559344761;
        Thu, 21 Apr 2022 09:42:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm25268821pfh.83.2022.04.21.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:42:24 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:42:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
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
Message-ID: <202204210941.4318DE6E8@keescook>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
 <202204201610.093C9D5FE8@keescook>
 <YmF5s4KqT5WL4O0G@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmF5s4KqT5WL4O0G@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:35:15PM +0100, Catalin Marinas wrote:
> On Wed, Apr 20, 2022 at 04:21:45PM -0700, Kees Cook wrote:
> > On Wed, Apr 20, 2022 at 10:34:33PM +0300, Topi Miettinen wrote:
> > > For systemd, feature compatibility with the BPF version is important so that
> > > we could automatically switch to the kernel version once available without
> > > regressions. So I think PR_MDWX_MMAP (or maybe PR_MDWX_COMPAT) should match
> > > exactly what MemoryDenyWriteExecute=yes as implemented with BPF has: only
> > > forbid mmap(PROT_EXEC|PROT_WRITE) and mprotect(PROT_EXEC). Like BPF, once
> > > installed there should be no way to escape and ELF flags should be also
> > > ignored. ARM BTI should be allowed though (allow PROT_EXEC|PROT_BTI if the
> > > old flags had PROT_EXEC).
> 
> I agree.
> 
> > > Then we could have improved versions (other PR_MDWX_ prctls) with lots more
> > > checks. This could be enabled with MemoryDenyWriteExecute=strict or so.
> > > 
> > > Perhaps also more relaxed versions (like SARA) could be interesting (system
> > > service running Python with FFI, or perhaps JVM etc), enabled with for
> > > example MemoryDenyWriteExecute=trampolines. That way even those programs
> > > would get some protection (though there would be a gap in the defences).
> > 
> > Yup, I think we're all on the same page. Catalin, can you respin with a
> > prctl for enabling MDWE? I propose just:
> > 
> > 	prctl(PR_MDWX_SET, flags);
> > 	prctl(PR_MDWX_GET);
> > 
> > 	PR_MDWX_FLAG_MMAP
> > 		disallows PROT_EXEC on any VMA that is or was PROT_WRITE,
> > 		covering at least: mmap, mprotect, pkey_mprotect, and shmat.
> 
> Do we want the "was PROT_WRITE" or we just reject mprotect(PROT_EXEC) if
> the vma is not already PROT_EXEC? The latter is closer to the current
> systemd approach. The former allows an mprotect(PROT_EXEC) if the
> mapping was PROT_READ only for example.
> 
> I'd drop the "was PROT_WRITE" for now if the aim is a drop-in
> replacement for BPF MDWE.

I think "was PROT_WRITE" is an important part of the defense that
couldn't be done with a simple seccomp filter (which is why the filter
ended up being a problem in the first place).

-- 
Kees Cook
