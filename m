Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9601A4AA0DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiBDUFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiBDUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:03:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA472C061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lqHl8xBvyV60Dd9+nj/xXQC+e0UCf3P24iA9ARtiGrs=; b=W9LZfu2k1ivZtxAZLNsbyblH9c
        Pgqr3OqHUZJ7pXw2DJa04Hn6Cb5ZhQFB2JZ8nsaiSlvll2o5yCUk7KQk56cTTjQyMOSjQAo2gGemQ
        q4axcyZaMsq5eJNjGAIHavXNFRJ8O1FN2qiSOfvpipKBioJ6Zvhez/JsG6eX9PQ/tIo5WmjguSSbr
        so4pUghKEC0NBonlTWLwshZva3qCh+3DS7i4PTBTt57NmJSGZt9gj9Ghhw1fiAXxS9bbQMVbosDzA
        S27a9eQZXOSeF5zB1Oh5/O3hAYEQplLLMdAxIpgQ4zqc3/Sxa1iFk8S3QvPVqEEp/FjusFcRyjxGy
        WXB2ViAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlX-Pg; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 13/75] mm: Add folio_pincount_ptr()
Date:   Fri,  4 Feb 2022 19:57:50 +0000
Message-Id: <20220204195852.1751729-14-willy@infradead.org>
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

This is the folio equivalent of compound_pincount_ptr().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd7d6e95e43b..d5f0f2cfd552 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -891,6 +891,11 @@ static inline void destroy_compound_page(struct page *page)
 	compound_page_dtors[page[1].compound_dtor](page);
 }
 
+static inline atomic_t *folio_pincount_ptr(struct folio *folio)
+{
+	return &folio_page(folio, 1)->compound_pincount;
+}
+
 static inline int head_compound_pincount(struct page *head)
 {
 	return atomic_read(compound_pincount_ptr(head));
-- 
2.34.1

