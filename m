Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC64D5D37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiCKIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiCKIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:24:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B37EB15;
        Fri, 11 Mar 2022 00:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47847B81851;
        Fri, 11 Mar 2022 08:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470ACC340E9;
        Fri, 11 Mar 2022 08:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646986982;
        bh=KverrhU0ilwYSOTbDjb5NWI3RqQ1D4NxyR5YGBIYlUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+MpEl5dSt63vGIvS8CupZNeN35ejCtgrZeVkPJInVupcsB8t6ZFziVp64gQcKpCu
         l3JU2gAiU18J3SYdDgE7q+qpxX/bN50kzuR8UaNyIdPNlFFr4nOuM4iosxNuLw7TjI
         VN/an72iUvHceWgq/6TvSB8bSL0fLriY7nTUNsRUnDv/KbFW+PiiNQWSxYPSubpmI1
         Q7DACwgm1QjQPrzPQgNA7kdf70psqz3Aom5RBS1E/aebAT+roWjpiciqcA4lZ5Iny7
         axkAJVywn/LIfDnpEBolS4nvB1zjvBPIvJkxi9PesV5wa2ppv/o9A0najUnElXqH7I
         YJ6yGGRecAvkA==
Date:   Fri, 11 Mar 2022 10:22:45 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
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
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v9 14/14] mm: multi-gen LRU: design doc
Message-ID: <YisG1Q5wZP16B13o@kernel.org>
References: <20220309021230.721028-1-yuzhao@google.com>
 <20220309021230.721028-15-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309021230.721028-15-yuzhao@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 07:12:31PM -0700, Yu Zhao wrote:
> Add a design doc.
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
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  Documentation/vm/index.rst        |   1 +
>  Documentation/vm/multigen_lru.rst | 156 ++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+)
>  create mode 100644 Documentation/vm/multigen_lru.rst
> 
> diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> index 44365c4574a3..b48434300226 100644
> --- a/Documentation/vm/index.rst
> +++ b/Documentation/vm/index.rst
> @@ -25,6 +25,7 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
>     ksm
>     memory-model
>     mmu_notifier
> +   multigen_lru
>     numa
>     overcommit-accounting
>     page_migration
> diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
> new file mode 100644
> index 000000000000..cde60de16621
> --- /dev/null
> +++ b/Documentation/vm/multigen_lru.rst
> @@ -0,0 +1,156 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Multi-Gen LRU
> +=============

Here I also miss an introductory paragraph about what Multi-Gen LRU is.

All the rest looks good to me.
> +
> +Design overview
> +===============
> +Objectives
> +----------

-- 
Sincerely yours,
Mike.
