Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20850A453
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390163AbiDUPiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390118AbiDUPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE5240AF;
        Thu, 21 Apr 2022 08:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB3D61BF4;
        Thu, 21 Apr 2022 15:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A0AC385A1;
        Thu, 21 Apr 2022 15:35:18 +0000 (UTC)
Date:   Thu, 21 Apr 2022 16:35:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <YmF5s4KqT5WL4O0G@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
 <202204201610.093C9D5FE8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204201610.093C9D5FE8@keescook>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 04:21:45PM -0700, Kees Cook wrote:
> On Wed, Apr 20, 2022 at 10:34:33PM +0300, Topi Miettinen wrote:
> > For systemd, feature compatibility with the BPF version is important so that
> > we could automatically switch to the kernel version once available without
> > regressions. So I think PR_MDWX_MMAP (or maybe PR_MDWX_COMPAT) should match
> > exactly what MemoryDenyWriteExecute=yes as implemented with BPF has: only
> > forbid mmap(PROT_EXEC|PROT_WRITE) and mprotect(PROT_EXEC). Like BPF, once
> > installed there should be no way to escape and ELF flags should be also
> > ignored. ARM BTI should be allowed though (allow PROT_EXEC|PROT_BTI if the
> > old flags had PROT_EXEC).

I agree.

> > Then we could have improved versions (other PR_MDWX_ prctls) with lots more
> > checks. This could be enabled with MemoryDenyWriteExecute=strict or so.
> > 
> > Perhaps also more relaxed versions (like SARA) could be interesting (system
> > service running Python with FFI, or perhaps JVM etc), enabled with for
> > example MemoryDenyWriteExecute=trampolines. That way even those programs
> > would get some protection (though there would be a gap in the defences).
> 
> Yup, I think we're all on the same page. Catalin, can you respin with a
> prctl for enabling MDWE? I propose just:
> 
> 	prctl(PR_MDWX_SET, flags);
> 	prctl(PR_MDWX_GET);
> 
> 	PR_MDWX_FLAG_MMAP
> 		disallows PROT_EXEC on any VMA that is or was PROT_WRITE,
> 		covering at least: mmap, mprotect, pkey_mprotect, and shmat.

Do we want the "was PROT_WRITE" or we just reject mprotect(PROT_EXEC) if
the vma is not already PROT_EXEC? The latter is closer to the current
systemd approach. The former allows an mprotect(PROT_EXEC) if the
mapping was PROT_READ only for example.

I'd drop the "was PROT_WRITE" for now if the aim is a drop-in
replacement for BPF MDWE.

-- 
Catalin
