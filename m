Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96B50B808
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447752AbiDVNPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447745AbiDVNP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:15:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5957B2E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33ACDB82D43
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0EBC385A8;
        Fri, 22 Apr 2022 13:12:24 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:12:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-abi-devel@lists.sourceforge.net" 
        <linux-abi-devel@lists.sourceforge.net>
Subject: Re: [PATCH RFC 2/4] mm, personality: Implement
 memory-deny-write-execute as a personality flag
Message-ID: <YmKptQoIw2mkGdic@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <20220413134946.2732468-3-catalin.marinas@arm.com>
 <443d978a-7092-b5b1-22f3-ae3a997080ad@redhat.com>
 <YmKDaEaOpOaKl7m9@arm.com>
 <59401856-0e45-0ee6-1e45-667c8e00cf21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59401856-0e45-0ee6-1e45-667c8e00cf21@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:04:31PM +0200, David Hildenbrand wrote:
> On 22.04.22 12:28, Catalin Marinas wrote:
> > On Thu, Apr 21, 2022 at 06:37:49PM +0100, David Hildenbrand wrote:
> >> Note that in the (FOLL_WRITE|FOLL_FORCE) we only require VM_MAYWRITE on
> >> the vma and trigger a write fault. As the VMA is not VM_WRITE, we won't
> >> actually map the PTE writable, but set it dirty. GUP will retry, find a
> >> R/O pte that is dirty and where it knows that it broke COW and will
> >> allow the read access, although the PTE is R/O.
> >>
> >> That mechanism is required to e.g., set breakpoints in R/O MAP_PRIVATE
> >> kernel sections, but it's used elsewhere for page pinning as well.
> >>
> >> My gut feeling is that GUP(FOLL_WRITE|FOLL_FORCE) could be used right
> >> now to bypass that mechanism, I might be wrong.
> > 
> > GUP can be used to bypass this. But if an attacker can trigger such GUP
> > paths via a syscall (e.g. ptrace(PTRACE_POKEDATA)), I think we need the
> > checks on those paths (and reject the syscall) rather than on
> > mmap/mprotect(). This would be covered by something like CAP_SYS_PTRACE.
> 
> I was told that RDMA uses FOLL_FORCE|FOLL_WRITE and is available to
> unprivileged users.

Ah, do they really need this? At a quick search, ib_umem_get() for
example:

	unsigned int gup_flags = FOLL_WRITE;
	...
	if (!umem->writable)
		gup_flags |= FOLL_FORCE;

I guess with a new MDWE flag we can make the GUP code ignore FOLL_FORCE
if VM_EXEC.

-- 
Catalin
