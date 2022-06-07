Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC32F53FCD6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiFGLEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiFGLAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58F9CEB5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654599612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pv9OCphMJ8B8Yb2Tt0nMaxCJDDpQGMH/396frBVwZ80=;
        b=NHva8EfFc7Trmq/FtQyWqEvbG+CvGaedLwhsLRLXxxVqzMHKKbzf7ECaGT+Mo/vudtYfps
        pD8M2lJpw8F1Kvox924OQNdgVJwEg0dsfprhh+VVpfrlQQAR2jilnQGmmIG56bnIJixNEg
        axVBBmvpsteFw6P4/kpfPPNQ4j7wofE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-vmbiaouaOw6D81OcAzc7AA-1; Tue, 07 Jun 2022 07:00:09 -0400
X-MC-Unique: vmbiaouaOw6D81OcAzc7AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBAA71D33867;
        Tue,  7 Jun 2022 11:00:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-113.pek2.redhat.com [10.72.13.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE2C01121314;
        Tue,  7 Jun 2022 11:00:05 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, urezki@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/4] mm/vmalloc: invoke classify_va_fit_type() in adjust_va_to_fit_type()
Date:   Tue,  7 Jun 2022 18:59:55 +0800
Message-Id: <20220607105958.382076-2-bhe@redhat.com>
In-Reply-To: <20220607105958.382076-1-bhe@redhat.com>
References: <20220607105958.382076-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function adjust_va_to_fit_type(), it checks all values of passed
in fit type, including NOTHING_FIT in the else branch. However, the
check of NOTHING_FIT has been done inside adjust_va_to_fit_type() and
before it's called in all call sites.

In fact, both of these two functions are coupled tightly, since
classify_va_fit_type() is doing the preparation work for
adjust_va_to_fit_type(). So putting invocation of classify_va_fit_type()
inside adjust_va_to_fit_type() can simplify code logic and the redundant
check of NOTHING_FIT issue will go away.

Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 07db42455dd4..f9d45aa90b7c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1335,10 +1335,10 @@ classify_va_fit_type(struct vmap_area *va,
 
 static __always_inline int
 adjust_va_to_fit_type(struct vmap_area *va,
-	unsigned long nva_start_addr, unsigned long size,
-	enum fit_type type)
+	unsigned long nva_start_addr, unsigned long size)
 {
 	struct vmap_area *lva = NULL;
+	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
 
 	if (type == FL_FIT_TYPE) {
 		/*
@@ -1444,7 +1444,6 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 	bool adjust_search_size = true;
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
-	enum fit_type type;
 	int ret;
 
 	/*
@@ -1472,14 +1471,9 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 	if (nva_start_addr + size > vend)
 		return vend;
 
-	/* Classify what we have found. */
-	type = classify_va_fit_type(va, nva_start_addr, size);
-	if (WARN_ON_ONCE(type == NOTHING_FIT))
-		return vend;
-
 	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(va, nva_start_addr, size, type);
-	if (ret)
+	ret = adjust_va_to_fit_type(va, nva_start_addr, size);
+	if (WARN_ON_ONCE(ret))
 		return vend;
 
 #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
@@ -3735,7 +3729,6 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	int area, area2, last_area, term_area;
 	unsigned long base, start, size, end, last_end, orig_start, orig_end;
 	bool purged = false;
-	enum fit_type type;
 
 	/* verify parameters and allocate data structures */
 	BUG_ON(offset_in_page(align) || !is_power_of_2(align));
@@ -3846,15 +3839,11 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
 
-		type = classify_va_fit_type(va, start, size);
-		if (WARN_ON_ONCE(type == NOTHING_FIT))
+		ret = adjust_va_to_fit_type(va, start, size);
+		if (WARN_ON_ONCE(unlikely(ret)))
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
 
-		ret = adjust_va_to_fit_type(va, start, size, type);
-		if (unlikely(ret))
-			goto recovery;
-
 		/* Allocated area. */
 		va = vas[area];
 		va->va_start = start;
-- 
2.34.1

