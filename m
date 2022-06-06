Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36453EBF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiFFOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbiFFOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:15:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E282D1F6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:15:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v25so19029907eda.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rWhlveeN1TxX4QHQ5iFPAm0c2ZnKQvWl2EyCos39TM=;
        b=ZZfEZRiLhkBMeDoURpm3uOeoX3BbxCOg5m6ukqdT3N+bgCa4cZY0UYuPiz01bJni7w
         S1I42czSmWZjgAA1z/SkChFOB6tDovtRLJNjtkkzrh5nc6nHkiznCGu0UW9TaQMBcIuk
         6EXpAnWy8RQiXzcN+99s5NHDgVVnhAabieMYeM1CZErYqV50/sUKaRK1MgvYgkH7G80F
         rD9tONFaF0ii9fiSsHQDUrujVUAEJ+iXbIGKazHiDF4i7YHQJ78rZ6DXnn2FQRKK9RvB
         CuA3ImFDY7FgaXH8s5Rbcs/lVqNxFB1Q9QDyXkHbFXC4dc5H0fdfJ4fL2ixyeQaakbCI
         32Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6rWhlveeN1TxX4QHQ5iFPAm0c2ZnKQvWl2EyCos39TM=;
        b=69PKp9oRoExuHlk2JooWFh615ghg/UwVKTXVqwv/58vcdHnIVpKmc2aRdpZfd7+6MR
         oycpsNV5u4I8S9svd7jKglFs+eYeTW1iQplxLWkTBb0g1bz1HC6cEMPTIFbYjDZUUW6U
         gUlgGmWgvsGnR+jyClxEw3phkV1Pu+6mIbGDjJ4H3d3FXgk8wA2kVakqnljGLjsvHD6I
         uWoGCduXHurCkCoCOj6UrUzwwoATIBvsmHtmRmHo/n8wpb0Kn5Q4Z9WGRpSQSm9Z6n6h
         c6q8qYN98QAvCusVfi4m1VbWQsLZME9d55mfJ9IIaaPecF16I9E3mJxyI5exM1wnYhcg
         WNSw==
X-Gm-Message-State: AOAM531II5Iw3kjFPtru+3SKTzqvLeFyHJId6QF9MkcYyMb+TM2qxhpP
        FOiGjfvcTS9i2OF8GuxOtaQ=
X-Google-Smtp-Source: ABdhPJwvLpggZGcluym7wsFNn4RHXYfzHTkwCPuZ2jBlXQZYtAudkyn7Br+hRBOtcpK/6Voy+abcZg==
X-Received: by 2002:a05:6402:430f:b0:42e:2a86:abaf with SMTP id m15-20020a056402430f00b0042e2a86abafmr20795604edc.194.1654524942790;
        Mon, 06 Jun 2022 07:15:42 -0700 (PDT)
Received: from localhost.localdomain (host-79-13-108-3.retail.telecomitalia.it. [79.13.108.3])
        by smtp.gmail.com with ESMTPSA id y21-20020a056402135500b0042aa5a74598sm9069837edw.52.2022.06.06.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:15:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] mm/highmem: Delete memmove_page()
Date:   Mon,  6 Jun 2022 16:15:33 +0200
Message-Id: <20220606141533.555-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox reported that, while he was looking at memmove_page(), he
realized that it can't actually work.

The reasons are hidden in its implementation, which makes use of
memmove() on logical addresses provided by kmap_local_page(). memmove()
does the wrong thing when it tests "if (dest <= src)".

Therefore, delete memmove_page().

No need to change any other code because we have no call sites of
memmove_page() across the whole kernel.

Reported-by: Matthew Wilcox <willy@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3af34de54330..fee9835e3793 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -336,19 +336,6 @@ static inline void memcpy_page(struct page *dst_page, size_t dst_off,
 	kunmap_local(dst);
 }
 
-static inline void memmove_page(struct page *dst_page, size_t dst_off,
-			       struct page *src_page, size_t src_off,
-			       size_t len)
-{
-	char *dst = kmap_local_page(dst_page);
-	char *src = kmap_local_page(src_page);
-
-	VM_BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
-	memmove(dst + dst_off, src + src_off, len);
-	kunmap_local(src);
-	kunmap_local(dst);
-}
-
 static inline void memset_page(struct page *page, size_t offset, int val,
 			       size_t len)
 {
-- 
2.36.1

