Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEE4AD6AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbiBHL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347690AbiBHKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:33:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3241C03FEC0;
        Tue,  8 Feb 2022 02:33:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 843B5B819D3;
        Tue,  8 Feb 2022 10:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED721C004E1;
        Tue,  8 Feb 2022 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644316399;
        bh=NjZVvFDpCokRsNYFmGbL6uf2PEi0paLoaM6pmwUfwg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoPDojkRCyKyurVc6+Z9NuA5N9T34Vwzlt3a6NyhBVNOn/kmJC2NSKmBQj2dGmO3n
         dPC0czljcJMtg4zX9ygXDe8Y5qJXeR6eyvxdPgcMCqytu3n6SX2VNWWBuvMErhrSmr
         OnZappvVotQnJAJkZ3/AvykVzgIiRF2//hY5rZT3aFuBRkX3mWaTxVhw3vxLjuV3Bk
         AEh4ZSFrocpqOFVJDAA9CvNN7lcN79EAxrNuUQIcatkWVmh9sf6gZbiDflNGoG1PxN
         I9kBQh7d0L9cRkQSPGtthSFuJrtwqo9UUJovWsIFsqx63gajuQCQjj9iK5aE42APlW
         X/bm9Dd0uMDBg==
Date:   Tue, 8 Feb 2022 10:33:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 01/12] mm: x86, arm64: add arch_has_hw_pte_young()
Message-ID: <20220208103309.GB1002@willie-the-truck>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208081902.3550911-2-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:18:51AM -0700, Yu Zhao wrote:
> Some architectures automatically set the accessed bit in PTEs, e.g.,
> x86 and arm64 v8.2. On architectures that don't have this capability,
> clearing the accessed bit in a PTE usually triggers a page fault
> following the TLB miss of this PTE (to emulate the accessed bit).
> 
> Being aware of this capability can help make better decisions, e.g.,
> whether to spread the work out over a period of time to reduce bursty
> page faults when trying to clear the accessed bit in many PTEs.
> 
> Note that theoretically this capability can be unreliable, e.g.,
> hotplugged CPUs might be different from builtin ones. Therefore it
> shouldn't be used in architecture-independent code that involves
> correctness, e.g., to determine whether TLB flushes are required (in
> combination with the accessed bit).
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> ---
>  arch/arm64/include/asm/pgtable.h | 14 ++------------
>  arch/x86/include/asm/pgtable.h   |  6 +++---
>  include/linux/pgtable.h          | 13 +++++++++++++
>  mm/memory.c                      | 14 +-------------
>  4 files changed, 19 insertions(+), 28 deletions(-)

For the arm64 bit:

Acked-by: Will Deacon <will@kernel.org>

Will
