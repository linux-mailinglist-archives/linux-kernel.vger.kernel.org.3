Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71505088AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378722AbiDTNEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378705AbiDTND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3D13E1E;
        Wed, 20 Apr 2022 06:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5ACC619F3;
        Wed, 20 Apr 2022 13:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2875C385A0;
        Wed, 20 Apr 2022 13:01:05 +0000 (UTC)
Date:   Wed, 20 Apr 2022 14:01:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <YmAEDsGtxhim46UI@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204141028.0482B08@keescook>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:52:17AM -0700, Kees Cook wrote:
> On Wed, Apr 13, 2022 at 02:49:42PM +0100, Catalin Marinas wrote:
> > The background to this is that systemd has a configuration option called
> > MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
> > is to prevent a user task from inadvertently creating an executable
> > mapping that is (or was) writeable. Since such BPF filter is stateless,
> > it cannot detect mappings that were previously writeable but
> > subsequently changed to read-only. Therefore the filter simply rejects
> > any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
> > support (Branch Target Identification), the dynamic loader cannot change
> > an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
> > For libraries, it can resort to unmapping and re-mapping but for the
> > main executable it does not have a file descriptor. The original bug
> > report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
> > for libraries - [3].
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
> I would agree, the latter seems like the greater hack,

We discussed such hacks in the past but they are just working around the
fundamental issue - systemd wants W^X but with BPF it can only achieve
it by preventing mprotect(PROT_EXEC) irrespective of whether the mapping
was already executable. If we find a better solution for W^X, we
wouldn't have to hack anything for mprotect(PROT_EXEC|PROT_BTI).

> so I welcome
> this RFC, though I think it might need to explore a bit of the feature
> space exposed by other solutions[1] (i.e. see SARA and NAX), otherwise
> it risks being too narrowly implemented. For example, playing well with
> JITs should be part of the design, and will likely need some kind of
> ELF flags and/or "sealing" mode, and to handle the vma alias case as
> Jann Horn pointed out[2].

I agree we should look at what we want to cover, though trying to avoid
re-inventing SELinux. With this patchset I went for the minimum that
systemd MDWE does with BPF.

I think JITs get around it using something like memfd with two separate
mappings to the same page. We could try to prevent such aliases but
allow it if an ELF note is detected (or get the JIT to issue a prctl()).

Anyway, with a prctl() we can allow finer-grained control starting with
anonymous and file mappings and later extending to vma aliases,
writeable files etc. On top we can add a seal mask so that a process
cannot disable a control was set. Something like (I'm not good at
names):

	prctl(PR_MDWX_SET, flags, seal_mask);
	prctl(PR_MDWX_GET);

with flags like:

	PR_MDWX_MMAP - basics, should cover mmap() and mprotect()
	PR_MDWX_ALIAS - vma aliases, allowed with an ELF note
	PR_MDWX_WRITEABLE_FILE

(needs some more thinking)

-- 
Catalin
