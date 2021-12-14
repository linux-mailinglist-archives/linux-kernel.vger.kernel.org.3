Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69747478A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhLNQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:21:27 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38839 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhLNQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:21:26 -0500
Received: (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6D367240006;
        Tue, 14 Dec 2021 16:21:23 +0000 (UTC)
Date:   Tue, 14 Dec 2021 17:21:23 +0100
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Levente Polyak <levente@leventepolyak.net>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: [PATCH] mm/page_alloc: Fix __alloc_size attribute for
 alloc_pages_exact_nid
Message-ID: <YbjEgwhn4bGblp//@coeus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>

The second parameter of alloc_pages_exact_nid is the one indicating the
size of memory pointed by the returned pointer.

Fixes: abd58f38dfb4 ("mm/page_alloc: add __alloc_size attributes for better bounds checking")
Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Levente Polyak <levente@leventepolyak.net>
Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
---
 include/linux/gfp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b976c4177299..8fcc38467af6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -624,7 +624,7 @@ extern unsigned long get_zeroed_page(gfp_t gfp_mask);
 
 void *alloc_pages_exact(size_t size, gfp_t gfp_mask) __alloc_size(1);
 void free_pages_exact(void *virt, size_t size);
-__meminit void *alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __alloc_size(1);
+__meminit void *alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask), 0)
-- 
2.34.1

