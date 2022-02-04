Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF04AA0AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiBDUBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiBDT7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC5C061757
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4LhiUb2YL8mECv8XTDZL8CGh0I12b+7YaoyPvJgbat8=; b=uoxQ8XePDAxD5eIOshL/zh9+ds
        rbcAE5b6NeLwDbv0w9Ds894HhP+diifs99OW9x5AvTBzdic3K/Sc5JwBUIDm4BJiEWXfknmFR3YBH
        Z9NH7dIwnYXmk3Blt6du5vXnKIjyCD7uwsZ9IPcudMIY8SeYF7xIKWs4MZKPX22iYHJCP2CkvAdvH
        +nuo2kwUsD+4Hb7frq9e7lwJDMSxbDH/4h4WF5kaFHHR3SQXRh1IRQHqWM49V2wFN0I/tdczaU/kH
        EzSdIA2LsNxmejkwEFB6tlPkgxa8wRUHVy3KFZ+a+HS99txIwGmcG2g6CYkbJzO2cg0Kj1OMMjeZ3
        fxd+oegg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007LnI-OQ; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 41/75] hexagon: Add pmd_pfn()
Date:   Fri,  4 Feb 2022 19:58:18 +0000
Message-Id: <20220204195852.1751729-42-willy@infradead.org>
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

I need to use this function in common code, so define it for hexagon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/hexagon/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 18cd6ea9ab23..87e96463ccd6 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -235,10 +235,11 @@ static inline int pmd_bad(pmd_t pmd)
 	return 0;
 }
 
+#define pmd_pfn(pmd)	(pmd_val(pmd) >> PAGE_SHIFT)
 /*
  * pmd_page - converts a PMD entry to a page pointer
  */
-#define pmd_page(pmd)  (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
+#define pmd_page(pmd)  (pfn_to_page(pmd_pfn(pmd)))
 
 /**
  * pte_none - check if pte is mapped
-- 
2.34.1

