Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F25ADAB0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiIEVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiIEVIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:08:09 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0F659C7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:08:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7s+y+NnFVR6SyFemhnOS8Di33idWzWChFcSyQrIGTFc=;
        b=MhZf34zW8g7msIkJ6Hi53oNdGsMbCO0SSXSal68C05dDkRfBW2HWXu0xrCDi0IWwvgbn0a
        obKerD9WtlA1KYihfdrWmJVlvZrhzrZ1EgTN19sSmW2cn2Bw6ZuBL9LfHyuOU7oXlj1aTG
        9dns8cLxlS1xSOBmsHcBx5JsbWaBKzQ=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 16/34] kasan: only define metadata offsets for Generic mode
Date:   Mon,  5 Sep 2022 23:05:31 +0200
Message-Id: <d4bafa0534facafd1a23c465a94261e64f366493.1662411799.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Hide the definitions of alloc_meta_offset and free_meta_offset under
an ifdef CONFIG_KASAN_GENERIC check, as these fields are now only used
when the Generic mode is enabled.

Reviewed-by: Marco Elver <elver@google.com>
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

