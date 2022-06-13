Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80854A073
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbiFMUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351492AbiFMUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:38 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114918357
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:17:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFl1aLadfWJPQ+Xg4RcAPABChePIqsdWPpe8i7e+EqU=;
        b=gY7JQXEBuSeNnEDCgLkcnyiE/DA+U2o3XKD0esu5cVnDXMCN4xpUf4g6sutMdMIbUtGf73
        a1zplBChQUeo0ROg1thTsy+Fdn6m3+vLMYuukA+vIoYyvUtAmTNvUVdfHLByaaOWECK8os
        WtcT5mx80L6O+Oual9NGhwQYgarO5bw=
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
Subject: [PATCH 13/32] kasan: drop CONFIG_KASAN_GENERIC check from kasan_init_cache_meta
Date:   Mon, 13 Jun 2022 22:14:04 +0200
Message-Id: <d9a5f3886e8cce132121fe3a4ed2379a2fc1d1c2.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

