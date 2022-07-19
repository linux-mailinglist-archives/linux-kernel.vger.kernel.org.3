Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A29578EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiGSANO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiGSANG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:13:06 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B38537FB4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:13:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSwVFyyCCOKYSS6nxmIV1PC3/qH9HgKDBeITqQWAPk0=;
        b=iaswNaVcKlE6Ibx4Q/VaDqXuU//N8Bb1UH2IAMNJ/JWMbQ+g7p+b8yxsXFuzuVs1OLrb1/
        WO2FkIPf2mND0jqNAq+nV6C4i52UasUQh94R1v6bxjJJhOXKBCsjr/oJoEXPYDHvqy/R/0
        jWVu+YLfZGTImLr6K4Xcsg4M9iinHi0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v2 16/33] kasan: only define metadata offsets for Generic mode
Date:   Tue, 19 Jul 2022 02:09:56 +0200
Message-Id: <902cc38713c94e729b3eca170cd53ce9dfb5fb47.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Hide the definitions of alloc_meta_offset and free_meta_offset under
an ifdef CONFIG_KASAN_GENERIC check, as these fields are now only used
when the Generic mode is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 9743d4b3a918..a212c2e3f32d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -98,8 +98,10 @@ static inline bool kasan_has_integrated_init(void)
 #ifdef CONFIG_KASAN
 
 struct kasan_cache {
+#ifdef CONFIG_KASAN_GENERIC
 	int alloc_meta_offset;
 	int free_meta_offset;
+#endif
 	bool is_kmalloc;
 };
 
-- 
2.25.1

