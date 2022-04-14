Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6B500482
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbiDNDB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiDNDB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:01:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E24EF5B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649905144; x=1681441144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PbAfj1r4A32EcIrxNdDaYDZ2NeJN6WT4A6qcNZBBano=;
  b=CGssSyNHMS6E3qd/GYBqYoIGe4GMw0vXN8zsmfdFlRdKk178fmtsRzuR
   cietMjBhLx08yQ2/MkZpnSsjxbbjdHmFigLe63PklWiKYn4tnMjiSNKeg
   s0axpIOBSkkqMYqPFMncLcZD9q3QYP48vc1OZ6A+iG/Yl+RHAeisNm2/7
   LIOx0fBTxZqnmMbJkKpBZtycccKCz8Vb3j24cLIRHEhIxR6TBGOeoJuP3
   I/G8CPeVDo08i/iLrMBBmLJqjI3jLaSPJivoZ1jHbU5zNosFA7vbtCiZy
   ZyAcKFR3nGFbflH36XHQfu3i3DBWIUB6r9aVamttCv7Tlwe4+JxuOyIMW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262270391"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="262270391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 19:59:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="573558777"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 19:59:02 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     ryabinin.a.a@gmail.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: Prevent cpu_quarantine corruption when CPU offline and cache shrink occur at same time
Date:   Thu, 14 Apr 2022 10:59:25 +0800
Message-Id: <20220414025925.2423818-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kasan_quarantine_remove_cache() is called in kmem_cache_shrink()/
destroy(), the kasan_quarantine_remove_cache() call is protected by
cpuslock in kmem_cache_destroy(), can ensure serialization with
kasan_cpu_offline(). however the kasan_quarantine_remove_cache() call
is not protected by cpuslock in kmem_cache_shrink(), when CPU going
offline and cache shrink occur at same time, the cpu_quarantine may be
corrupted by interrupt(per_cpu_remove_cache operation). so add
cpu_quarantine offline flags check in per_cpu_remove_cache().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 mm/kasan/quarantine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 0e33d30abb8d..51a8192d49cf 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -330,6 +330,8 @@ static void per_cpu_remove_cache(void *arg)
 	struct cpu_shrink_qlist *sq;
 #endif
 	q = this_cpu_ptr(&cpu_quarantine);
+	if (READ_ONCE(q->offline))
+		return;
 #ifndef CONFIG_PREEMPT_RT
 	qlist_move_cache(q, &to_free, cache);
 	qlist_free_all(&to_free, cache);
-- 
2.25.1

