Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D194845E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiADQVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiADQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:21:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5EC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:21:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48F62B81744
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 16:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6DCC36AED;
        Tue,  4 Jan 2022 16:21:39 +0000 (UTC)
Date:   Tue, 4 Jan 2022 16:21:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 04/14] mm, hugetlbfs: Allow for "high" userspace
 addresses
Message-ID: <YdR0EN2mdJuysugk@arm.com>
References: <cover.1639736449.git.christophe.leroy@csgroup.eu>
 <db238c1ca2d46e33c57328f8d450f2563e92f8c2.1639736449.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db238c1ca2d46e33c57328f8d450f2563e92f8c2.1639736449.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:27:28AM +0000, Christophe Leroy wrote:
> This is a complement of f6795053dac8 ("mm: mmap: Allow for "high"
> userspace addresses") for hugetlb.
> 
> This patch adds support for "high" userspace addresses that are
> optionally supported on the system and have to be requested via a hint
> mechanism ("high" addr parameter to mmap).
> 
> Architectures such as powerpc and x86 achieve this by making changes to
> their architectural versions of hugetlb_get_unmapped_area() function.
> However, arm64 uses the generic version of that function.
> 
> So take into account arch_get_mmap_base() and arch_get_mmap_end() in
> hugetlb_get_unmapped_area(). To allow that, move those two macros
> out of mm/mmap.c into include/linux/sched/mm.h
> 
> If these macros are not defined in architectural code then they default
> to (TASK_SIZE) and (base) so should not introduce any behavioural
> changes to architectures that do not define them.
> 
> For the time being, only ARM64 is affected by this change.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  fs/hugetlbfs/inode.c     | 9 +++++----
>  include/linux/sched/mm.h | 8 ++++++++
>  mm/mmap.c                | 8 --------
>  3 files changed, 13 insertions(+), 12 deletions(-)

This would be an ABI change but I'm fine with it. Basically with this
patch, getting hugetblfs addresses above 48-bit require explicit hint
passed to mmap().

I wonder whether we should add a fixes tag (or at least the cc stable):

Fixes: f6795053dac8 ("mm: mmap: Allow for "high" userspace addresses")
Cc: <stable@vger.kernel.org> # 5.0.x

I think the original commit should have changed
hugetlb_get_unmapped_area() to have the same behaviour as
arch_get_unmapped_area(). Steve, any thoughts?

FWIW,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
