Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C73578EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiGSAMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiGSAMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:12:33 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197933E21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:12:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFl1aLadfWJPQ+Xg4RcAPABChePIqsdWPpe8i7e+EqU=;
        b=GGtCf53TQnL1kZxA120KVapzN39vL6tDViucW+URm5HgflNNpIrtRxPN3Kp7BrL2t6IzvH
        AH3YyL6UhrAFteVWBoKtRDHhEFRQyToCA01A7olK5sGQpmWSVlsA8VUs1BBFRDt4gohHX3
        bB+YHVL6hw+Ap6XDONJrHErSVswR61s=
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
Subject: [PATCH mm v2 13/33] kasan: drop CONFIG_KASAN_GENERIC check from kasan_init_cache_meta
Date:   Tue, 19 Jul 2022 02:09:53 +0200
Message-Id: <b523760220958f50e3a04b281b635551cecd6c78.1658189199.git.andreyknvl@google.com>
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

As kasan_init_cache_meta() is only defined for the Generic mode, it does
not require the CONFIG_KASAN_GENERIC check.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/generic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 73aea784040a..5125fad76f70 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -367,12 +367,6 @@ void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int *size)
 		/* Continue, since free meta might still fit. */
 	}
 
-	/* Only the generic mode uses free meta or flexible redzones. */
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
-		return;
-	}
-
 	/*
 	 * Add free meta into redzone when it's not possible to store
 	 * it in the object. This is the case when:
-- 
2.25.1

