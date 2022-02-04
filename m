Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7A4AA098
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiBDUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiBDT7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07861C06175B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zTm3UKIPo0pAmozKFeOiJi5zd1mljuu4xE3KYJzSbEE=; b=Tp7w3zgZe+a2RBP4SmGhUnS4SH
        mgH6iwH6AIo5CZKkvsNOjc4FKyV9SpUMN7nSgYiXsC+U3DQo0lnGm9OaFGMP4u/ttjyKytndgKZ8g
        edos9o0wOI7aZoabDW1ZTH13QOO8J38OT/S5kcqwojeVi2sUg3QLyfhO9MGSWPgtd+z8a5RV6xxAp
        Q/In7JeoicoTYXyu3gUk+4otfBqSqI2aCgG8jcAeCE/7rd8/lwnT4Ee2EjpnLwiOEgGXj3EUyJGJV
        fL/NythGRd/3L4E9uRBXhEU+XeAXanJPAOhkH45mHHO2G3icaOTBNOVW6Bf6gRttr0clTz/aYxgNa
        HyrZ+loA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007Lmx-AV; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/75] mm: Add folio_is_zone_device() and folio_is_device_private()
Date:   Fri,  4 Feb 2022 19:58:15 +0000
Message-Id: <20220204195852.1751729-39-willy@infradead.org>
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

These two wrappers are the equivalent of is_zone_device_page()
and is_device_private_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6a19cd97d5aa..028bd9336e82 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1096,6 +1096,11 @@ static inline bool is_zone_device_page(const struct page *page)
 }
 #endif
 
+static inline bool folio_is_zone_device(const struct folio *folio)
+{
+	return is_zone_device_page(&folio->page);
+}
+
 static inline bool is_zone_movable_page(const struct page *page)
 {
 	return page_zonenum(page) == ZONE_MOVABLE;
@@ -1142,6 +1147,11 @@ static inline bool is_device_private_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
 }
 
+static inline bool folio_is_device_private(const struct folio *folio)
+{
+	return is_device_private_page(&folio->page);
+}
+
 static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
-- 
2.34.1

