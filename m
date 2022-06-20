Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8B552289
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiFTQ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiFTQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DC19FA9;
        Mon, 20 Jun 2022 09:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49AC8B8120F;
        Mon, 20 Jun 2022 16:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28337C3411B;
        Mon, 20 Jun 2022 16:57:20 +0000 (UTC)
Date:   Mon, 20 Jun 2022 17:57:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/6] mm: hugetlb_vmemmap: delete
 hugetlb_optimize_vmemmap_enabled()
Message-ID: <YrCm7fL59QOSPUSp@arm.com>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613063512.17540-2-songmuchun@bytedance.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:07PM +0800, Muchun Song wrote:
> The name hugetlb_optimize_vmemmap_enabled() a bit confusing as it tests
> two conditions (enabled and pages in use).  Instead of coming up to
> an appropriate name, we could just delete it.  There is already a
> discussion about deleting it in thread [1].
> 
> There is only one user of hugetlb_optimize_vmemmap_enabled() outside of
> hugetlb_vmemmap, that is flush_dcache_page() in arch/arm64/mm/flush.c.
> However, it does not need to call hugetlb_optimize_vmemmap_enabled()
> in flush_dcache_page() since HugeTLB pages are always fully mapped and
> only head page will be set PG_dcache_clean meaning only head page's flag
> may need to be cleared (see commit cf5a501d985b).  So it is easy to
> remove hugetlb_optimize_vmemmap_enabled().
> 
> Link: https://lore.kernel.org/all/c77c61c8-8a5a-87e8-db89-d04d8aaab4cc@oracle.com/ [1]
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
