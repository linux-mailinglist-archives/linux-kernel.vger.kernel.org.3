Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E19570301
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiGKMn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiGKMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:43:47 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B7EDECB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657542507; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Wj44IkAqMXaiKU22l0jln19+dFZUF2tU1v6Ac7YOgtpb7vvnuFcD34l08N0YVG5nbJN2R/+aYu0sMawgJiFRjkG5NTyizEg5zz82r2G5Fuavr9rJ7dAIm9Gk1uicehNvkJsl5Iu3r4UvzamBKsmZDQXDKHfZpaLKatzU4OGALH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657542507; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XcBY/Eq5IywNEBwnOGSytrIPNKZEd+GUxWkjesqgdhE=; 
        b=BY4tqD/qFDF9rINfEZzxZKU+DaJNwKdHh1xD5Y+CVu4grzv+a9lvB9jhxgANvAy0p7xxK976w1KMBdDQhMhIIWYrqdY3GrmjDQfK4805g/qdEhPLEpuAkpWRFvkSC2ukCmVBB3pM0XMPR6G/X7TYFDG9NwL93CbGOiuxwQOVyGc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657542507;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=XcBY/Eq5IywNEBwnOGSytrIPNKZEd+GUxWkjesqgdhE=;
        b=ZtcV/kLTYKL80lJw5yjgoMSBb4kqp2TEbTehtIGGwreBUCqr63ySryzpBf6w5IzY
        AIKjzm5yLsYgY1zXvcUsf1xJM1Op5zu0c1+cIxJnWup9K6mr8+cTEzpHJXeu4g73b2Y
        JWLicwjaA0FO8VmTqNcRBsP917DGU9KHhd+PIbmE=
Received: from sh-lchen.ambarella.net (180.169.129.130 [180.169.129.130]) by mx.zohomail.com
        with SMTPS id 1657542504796249.49555353239066; Mon, 11 Jul 2022 05:28:24 -0700 (PDT)
From:   Li Chen <me@linux.beauty>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/4] arm64: mm: move memblock_clear_nomap after __add_pages
Date:   Mon, 11 Jul 2022 20:24:53 +0800
Message-Id: <20220711122459.13773-4-me@linux.beauty>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711122459.13773-1-me@linux.beauty>
References: <20220711122459.13773-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

I'm trying to add struct page support to nomap reserved memory,
and have skipped nomap bitmap_intersects check in fill_subsection_map,
so just move memblock_clear_nomap after __add_pages.

Signed-off-by: Li Chen <lchen@ambarella.com>
Change-Id: I5e26fdc3f3e55b12f1acc1adb47fb262c4877ff3
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6680689242df..2e7f503837e4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1537,10 +1537,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
 			     size, params->pgprot, __pgd_pgtable_alloc,
 			     flags);
 
-	memblock_clear_nomap(start, size);
 
 	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   params);
+	memblock_clear_nomap(start, size);
 	if (ret)
 		__remove_pgd_mapping(swapper_pg_dir,
 				     __phys_to_virt(start), size);
-- 
2.25.1

