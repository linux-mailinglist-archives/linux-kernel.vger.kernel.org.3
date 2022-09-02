Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CFA5ABB24
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIBXbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIBXbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:31:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7DD34C1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662161467; x=1693697467;
  h=from:to:cc:subject:date:message-id;
  bh=qLq0yeIaO/mvA3cm8hCykqt3PIzVE68HdER9lamMWV8=;
  b=XiTAure7RJkNoDskjPK37b/gyeh9Kxu4JrxoiiMzBbr8Ueu+R1BcZUzE
   mmxQ9/FKmw10UsqjO3swVXAipRlEgi54w93MpwdXhP1yvW1MOvJAxF4DJ
   pncE1C0bnFKwchyWwcXYou8/HtU81RrY8znyK/lgk8YDnw9cYV/KAVPnf
   +YVaCLUD/tPD1Z6wpCazpPmcFCdguQuqXsxzGEJVyisLwQhLQNgz5/nQv
   B0NgqTFbuSqd+Stos+zH7QK0nPxz6Z5brhLIjvK6AtQVBmdgBva2R4NDt
   lh0vh7qdocIgVD7epaNYiN2spdAqELabFCwry8mwj4ljaaXlWO+U5bNiw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="294848359"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="294848359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:31:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="643103273"
Received: from gescaler-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.116.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 16:31:06 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Check writable zero page in page table check
Date:   Fri,  2 Sep 2022 16:27:32 -0700
Message-Id: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zero page should remain all zero, so that it can be mapped as
read-only for read faults of memory that should be zeroed. If it is ever
mapped writable to userspace, it could become non-zero and so other apps
would unexpectedly get non-zero data. So the zero page should never be
mapped writable to userspace. Check for this condition in
page_table_check_set().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

Hi,

CONFIG_PAGE_TABLE_CHECK is pretty explicit about what it checks (and
doesn't mention the zero page), but this condition seems to fit with the
general category of "pages mapped wrongly to userspace". I added it
locally to help me debug something. Maybe it's more widely useful.

 mm/page_table_check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index e2062748791a..665ece0d55d4 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 	if (!pfn_valid(pfn))
 		return;
 
+	BUG_ON(is_zero_pfn(pfn) && rw);
+
 	page = pfn_to_page(pfn);
 	page_ext = lookup_page_ext(page);
 	anon = PageAnon(page);

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.17.1

