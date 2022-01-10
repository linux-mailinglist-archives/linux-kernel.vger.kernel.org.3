Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E02488F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiAJEZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBCC06175E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fC4mfcf/XAHzYtj0vYWgXRylAg3qW7XjyC6jR63n0ws=; b=G8FxiLvPsae9GR/t85Spn5ZHFx
        YOtLGi7JPPDzlItCRlMqM6B76CuawBJ6HkD3SK7XQsfLpIrVcPhRbhsBvt0CCRGHMGkW7MJXtimh3
        vnqAYCyMjelK5u8jFMEkFjMxjzOL7WoHidac+q474yFVCn47qhdjhoFhIdMEpIFd6t9LZV3Q6scZv
        +d5KpY89Mw0mw09jWK8SF+Ix0odXuP9dWx+xHAz7W8mgpPaz1hCCnPs+/RNEP1G97LlLqlnz6aqX3
        4Ny9Lsn0lGlLjRQWNF4iiaiYJ73Q47X8bemQGmMp0HFLgAvtvFZdjZgTcIHNs+EPBU6zaylj6iih9
        IEzUEUAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025x2-Al; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 19/28] gup: Convert try_grab_page() to call try_grab_folio()
Date:   Mon, 10 Jan 2022 04:23:57 +0000
Message-Id: <20220110042406.499429-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_grab_page() only cares about success or failure, not about the
type returned.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 20703de2f107..c3e514172eaf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -192,7 +192,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (!(flags & (FOLL_GET | FOLL_PIN)))
 		return true;
 
-	return try_grab_compound_head(page, 1, flags);
+	return try_grab_folio(page, 1, flags);
 }
 
 /**
-- 
2.33.0

