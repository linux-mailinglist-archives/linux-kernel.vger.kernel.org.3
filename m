Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865274AA08E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiBDT7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiBDT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF5C061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mHFxR5NGbeSDMBxJHP5N5leN9vHaAhl5n47FMsBbbDE=; b=tgkrGRYcpNjb/Pl79jKJUaHlYZ
        +I42XDP52oi3pwhSa9RIE3PsYG1ORzrv+TBkXB0/cYugbP4CEaRxKOu1nYP3LOVoL0SW2An8dIp65
        DcaFbZTrG0DDmx2D6rCTrtejUYDO5bRmeQg8uQmaxtr1uYMX8x1OUdKJXJS6qFRPHb08IXCi5+ImD
        xwxBlNFl2rtdHwtqOO6tUdS+18MIBaX6gkrv47HJAxJd5N4SRj3qWbFtRThgc1lfeLvYn5B0VG3/D
        YxmZNGpy+M7bQPuYQ1TjZhJnkq6px24oQfbKnutHZBpVu8AisC7hyVjiH4agHh3jLLi8VL2vd7bDo
        sIz/8QlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007LmH-Fs; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/75] mm: Add lru_to_folio()
Date:   Fri,  4 Feb 2022 19:58:08 +0000
Message-Id: <20220204195852.1751729-32-willy@infradead.org>
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

Since page->lru occupies the same bytes as compound_head, any page
on the LRU list must be a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3ca6dea4fe4a..6cb2651eccbe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -229,6 +229,7 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+#define lru_to_folio(head) (list_entry((head)->prev, struct folio, lru))
 
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk);
-- 
2.34.1

