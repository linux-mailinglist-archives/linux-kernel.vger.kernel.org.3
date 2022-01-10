Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04FD488F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiAJE1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiAJEZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:25:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E198C061759
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w+88rodVOkiUqMds1CDDO2rnbx+ZzvbF6EDnhZLZjHk=; b=MHde1Qleuqe7Nk4xqACcAx7HEl
        D8kJGZeV3c227mQCZyDaXVLZZyyzsX283wSRbmVtVux8gfh65uIkUe9PKbmG7LiN8Av1rGrz0b64n
        wzKrvVfSE8faTN1k0nH9mOXqLhoC2As+LH2ynMSk2GovVwLBt8PhprrxJGMwurHMoQN0j2e5UdE3d
        matAxpEXJXnrEz0GvItCgqQ/YSIzOpNc1FmFeBXxfCgj1n7Krq20kEMmHbbFFHodTHPqMzuBEJkbu
        +GVmJzrwFRfYm5SfWSxrlFJy1tI2FcZk9l8FDXj+mYCMLNpfQV739wpVskuIZrwIK6yfdqEQ/AdN7
        fNaNMXMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wq-SO; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 13/28] mm: Add folio_pincount_ptr()
Date:   Mon, 10 Jan 2022 04:23:51 +0000
Message-Id: <20220110042406.499429-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the folio equivalent of compound_pincount_ptr().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 60e4595eaf63..34c7114ea9e9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -312,6 +312,12 @@ static inline atomic_t *compound_mapcount_ptr(struct page *page)
 	return &page[1].compound_mapcount;
 }
 
+static inline atomic_t *folio_pincount_ptr(struct folio *folio)
+{
+	struct page *tail = &folio->page + 1;
+	return &tail->compound_pincount;
+}
+
 static inline atomic_t *compound_pincount_ptr(struct page *page)
 {
 	return &page[1].compound_pincount;
-- 
2.33.0

