Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70956571B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiGLNmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiGLNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:41:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F6B8E9E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so11433436pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHX6u+uuT0Qv/UMIRhleUO+BgcB2HGRMakbokCWE8Fs=;
        b=Ihzm2rddLGzNKF4YXXSxlXjbHdCTscB0yqKGkiatFFI5tMV1MKKybwz46/gefAVWW/
         uHag3srSoMJMC8+UcknJNrRV8FPVQfTKKnQ3pNaw44uEtgQUv7d/H/huqn8/BmtP3RK7
         P0wt/gNUbftGkpGgJcCsY5IyXb5HuQKPSJS9+FSw/w86QbzAsw98x2+oC2UBgYgEgxqZ
         cNXkhaobZ9JF9wYFAs8caGM4lZXYluwZpyF/f6Re6xczg3RD3pmVkFVYiKgLFMpCUqNH
         DYPRdqfDhrsYLX2mUHikivQ6A0p02w+HPIBG02A8nDqyMUV9x/dhfmXIBhlSNTdTuKaJ
         JJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHX6u+uuT0Qv/UMIRhleUO+BgcB2HGRMakbokCWE8Fs=;
        b=BZ+fJTbyh5sjQZjhHggumVeZHqjeTzzW0+WoKj06nOSbFVfHIFictbC8rVzjqQhjwj
         Hgf6pRc1KCAjyrn9Tr6KpH17wwXrTo3lanLu4rWm/6AWm4Wv2w8pc+g7CuEWS4qnK0eS
         LxzAYDfK7nIF96iMCx3ajMZG78G1Z0ICk/IKciy2eH+uwWydN1hYnHuuF4NObAea0GKb
         wbWgBTOF4njYzvrvBY93xtXn/AVFIO2VWEFbTw7knatLeulORl3eBkwRLC3gfFVF7oG6
         KYDGG9MXTh392tef4m6H+/bf9LJfMrVeXsnhARD/9hkIRJquYRQfP8hrAJ9wrs8FB8M+
         iuLQ==
X-Gm-Message-State: AJIora/RLbUi6MYAGVIWjMWYgEErV+vGO2RZk+gqFvEKm4kzknBLjTRp
        vi37cjb4/HaKSaSPiLMQwCM=
X-Google-Smtp-Source: AGRyM1tLVKYRqR/7FAuECqcy2MJ1lHFZ77GM2G7vH4DXeoiG1wAQZNcrfpbj6S8pBzGrN9YwT5/13g==
X-Received: by 2002:a17:90b:17d1:b0:1f0:6f1:90d1 with SMTP id me17-20020a17090b17d100b001f006f190d1mr4367814pjb.221.1657633247691;
        Tue, 12 Jul 2022 06:40:47 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:47 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 16/16] mm/sl[au]b: check if large object is valid in __ksize()
Date:   Tue, 12 Jul 2022 13:39:46 +0000
Message-Id: <20220712133946.307181-17-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712133946.307181-1-42.hyeyoo@gmail.com>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ksize() returns size of objects allocated from slab allocator.
When invalid object is passed to __ksize(), returning zero
prevents further memory corruption and makes caller be able to
check if there is an error.

If address of large object is not beginning of folio or size of
the folio is too small, it must be invalid. Return zero in such cases.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1f8db7959366..0d6cbe9d7ad0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1013,8 +1013,12 @@ size_t __ksize(const void *object)
 
 	folio = virt_to_folio(object);
 
-	if (unlikely(!folio_test_slab(folio)))
+	if (unlikely(!folio_test_slab(folio))) {
+		if (WARN_ON(object != folio_address(folio) ||
+				folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
+			return 0;
 		return folio_size(folio);
+	}
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-- 
2.34.1

