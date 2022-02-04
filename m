Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2804AA0B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbiBDUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiBDT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B3C061753
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rCeZZFnhMgFeUZK5dhbFsBos7wHqny8hzB4SCwbybSo=; b=nuGaQO9JHx2CVzfQ1TI2nfi9Hz
        OTmxyNTT/O3OR66t73bZm4nNoBVQEpOWQcaUjR6WZZDlm9yiDLm4ogovQUVCPOCWBuAk/2OalnNcJ
        7C1eiXNGx68vpIaSdoMQp/iCAjqamG0QCPCGncoCVgqtQsgsZYOp53AVVNtMaNYg5koJF0/0gE8hY
        C/OhXYlISSt0Tqmqa+J2DQHv9oSWIcs3PxSaqp/vIWI1lX8TisBFT4+hz4DE5UtLfOaskxc/b3Tvl
        EUckkV/Vd0Dyvos86okZ9o0EHRjJtiB/1OLsBoaKO6TYtbhAx2F4s3qgsNd5PIu5UwywA352/CGdv
        qNhudXaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007Lr4-Mr; Fri, 04 Feb 2022 19:59:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 69/75] mm: Make large folios depend on THP
Date:   Fri,  4 Feb 2022 19:58:46 +0000
Message-Id: <20220204195852.1751729-70-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some parts of the VM still depend on THP to handle large folios
correctly.  Until those are fixed, prevent creating large folios
if THP are disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 39115f75962c..ccf02a7d4d65 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -192,9 +192,14 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
+/*
+ * Large folio support currently depends on THP.  These dependencies are
+ * being worked on but are not yet fixed.
+ */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
-- 
2.34.1

