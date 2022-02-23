Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F74C0D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiBWH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiBWH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:29:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEB94B855
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VJesZ9EAyg1Zm46davUB5tP7GHU2iodGAWukMPFPbSM=; b=J4rjVn1twbu7m25ABN8Knuq0S7
        Kl2gB1WuDTQl3mXS4yD9JXv7bMAm+o+YZe3zhcIpPM/xVwhn3NeoqZxTXM60JsySRRnowUseYPNgF
        mROQnAd/m8fniZDF7KjIcJv5D0e8UrtXi0OtxghUjjL2NXsrbwMgIlFgwVZN16ulremUJO3Txr4mk
        R5wJUoq6wiQCBrslSXv7lFgcec/kPJ6EPBPS6xvvpBcWuV6OPh36OEF8FaJ+CnXwJgBfrKxiTcQfa
        ukpcKlt4eIWeXqF/yRIDdocnRifGjUm6HgyXrUNnlLnUAibbET44NurYLEsr3XiZqQLw6gRRlye7o
        5be3VEug==;
Received: from [2001:4bb8:198:f8fc:771a:afd3:3ec5:425a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMm50-00D8Br-Py; Wed, 23 Feb 2022 07:28:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     luto@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/pat: Remove the unused set_pages_array_wt function
Date:   Wed, 23 Feb 2022 08:28:52 +0100
Message-Id: <20220223072852.616143-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/set_memory.h | 1 -
 arch/x86/mm/pat/set_memory.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d90338a1..60bdede41466d 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -53,7 +53,6 @@ int set_memory_global(unsigned long addr, int numpages);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
-int set_pages_array_wt(struct page **pages, int addrinarray);
 int set_pages_array_wb(struct page **pages, int addrinarray);
 
 /*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef6..9bdaf828ee68f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2121,12 +2121,6 @@ int set_pages_array_wc(struct page **pages, int numpages)
 }
 EXPORT_SYMBOL(set_pages_array_wc);
 
-int set_pages_array_wt(struct page **pages, int numpages)
-{
-	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WT);
-}
-EXPORT_SYMBOL_GPL(set_pages_array_wt);
-
 int set_pages_wb(struct page *page, int numpages)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-- 
2.30.2

