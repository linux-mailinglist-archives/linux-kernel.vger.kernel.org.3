Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79E5016D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbiDNPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347318AbiDNN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C924BEC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2D03B82986
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D85C385AA;
        Thu, 14 Apr 2022 13:49:19 +0000 (UTC)
Date:   Thu, 14 Apr 2022 14:49:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <YlgmXA49frnQKdaT@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <2a2becf1-fc19-a7da-deb7-1c12781d503d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2becf1-fc19-a7da-deb7-1c12781d503d@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Topi,

On Wed, Apr 13, 2022 at 09:39:37PM +0300, Topi Miettinen wrote:
> On 13.4.2022 16.49, Catalin Marinas wrote:
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
> > 
> > Add in-kernel support for such feature as a DENY_WRITE_EXEC personality
> > flag, inherited on fork() and execve(). The kernel tracks a previously
> > writeable mapping via a new VM_WAS_WRITE flag (64-bit only
> > architectures).

BTW, we can avoid the VM_WAS_WRITE tracking if we limit the check to the
current permissions. It would allow mprotect(PROT_EXEC) only if the
mapping is already executable. The mmap(PROT_WRITE|PROT_EXEC) would be
rejected, as expected. The difference from the current BPF filter is
that mprotect(PROT_EXEC|PROT_BTI) is allowed if the mapping was
previously mmap(PROT_READ|PROT_EXEC).

I'm open to go in this direction if it fits the systemd requirements
better. It's also less state to track in the kernel.

> > I went for a personality flag by analogy with the
> > READ_IMPLIES_EXEC one. However, I'm happy to change it to a prctl() if
> > we don't want more personality flags. A minor downside with the
> > personality flag is that there is no way for the user to query which
> > flags are supported, so in patch 3 I added an AT_FLAGS bit to advertise
> > this.
> 
> With systemd there's a BPF construct to block personality changes
> (LockPersonality=yes) but I think prctl() would be easier to lock down
> irrevocably.

The personality flag is not sticky, so one could inadvertently clear it
without LockPersonality=yes. We could add a mask of sticky bits to
sys_personality() (only for new flags), though we might as well go with
a prctl(), we have more flexibility and finer-grained control if we want
to expand this to memfd files.

Would there be any reason to disable such behaviour for an application,
once enabled? I don't think it's currently possible with the BPF filter
but we can add it to a prctl().

> > Posting this as an RFC to start a discussion and cc'ing some of the
> > systemd guys and those involved in the earlier thread around the glibc
> > workaround for dynamic libraries [4]. Before thinking of upstreaming
> > this we'd need the systemd folk to buy into replacing the MDWE SECCOMP
> > BPF filter with the in-kernel one.
> 
> As the author of this feature in systemd (also similar feature in Firejail),
> I'd highly prefer in-kernel version to BPF protection. I'd definitely also
> want to use this in place of BPF on x86_64 and other arches too.

It is generic, so yes, it can be enabled for other architectures. A
minor issue with the VM_WAS_WRITE flag is that we ran out of 32-bit vma
flags. It could be expanded but not sure how much you care about MDWE on
32-bit architectures. An alternative is to drop the VM_WAS_WRITE
approach entirely, just use the current protection for the decision.

> In-kernel version would probably allow covering pretty easily this case
> (maybe it already does):
> 
> 	fd = memfd_create(...);
> 	write(fd, malicious_code, sizeof(malicious_code));
> 	mmap(..., PROT_EXEC, ..., fd);

This series doesn't cover it.

> Other memory W^X implementations include S.A.R.A [1] and SELinux
> EXECMEM/EXECSTACK/EXECHEAP protections [2], [3]. SELinux checks
> IS_PRIVATE(file_inode(file)) and vma->anon_vma != NULL, which might be
> useful additions here too (or future extensions if you prefer).

I had a quick look at SELinux and, IIUC, without the execmem permission
it prevents any anonymous mmap(PROT_EXEC). We could probably do
something similar here and check the file permission. I had an attempt
but S_PRIVATE doesn't seem to be set on the memfd_create() allocated
inode. I have to dig a bit more to see how to detect this. If we keep
the check for all files, it won't be able to map any ELF text sections
unless the binary is read-only.

> [1] https://smeso.it/sara/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n3708
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n3787

-- 
Catalin
