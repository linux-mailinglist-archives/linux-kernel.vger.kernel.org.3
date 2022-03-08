Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329C4D167B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbiCHLok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346686AbiCHLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F0636F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:43:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c11so3819493pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVm1wzeU0y3JZ7p5wnCxhldPZJzxYO3AZTbbV3y/P8c=;
        b=ZBYHDJThFStU0rnWXfOROGQPKtGJeftM5/haZPk61cjnmK0NY2ff0+YovK1r93UWff
         nBW833vQD2RsHWbqNHCMMH/AR77E5Lz1jfEMB8E4OykBIZbzj4eME/lV7KBnbCGJmB3o
         0ep1QuphjEuW4XuET2NnIioVZAUeoCb+619lNATjkhEk1N0C+T2LLYxFI7ZalNPf4m5Q
         IJLZAlX4exdqdRPhg0aVFWjVTuRpUlW+IBu8+WTxuxePp/VozSMNG1oK1jX4ep9ffVI9
         Eq5T+FXzZAHxLhAiG45Kf6F3Z0/1rdRqP3SAMRf2mgRNWz+tDISTm4WhCPfv6ew8QUTz
         30og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVm1wzeU0y3JZ7p5wnCxhldPZJzxYO3AZTbbV3y/P8c=;
        b=IwKndD8qeV1c7CEXWZH+QhxQcUvv7P2PWKfch8nfFnMt5rTqNmSDkhKkKaPxh9rsmq
         YBBO1oNoA1r2ktw0IVPn5YfaAsG5WJB1BtYsPk535v2QZiYHomvJYXIpAiVBr86fYbRP
         TYHh5snlFq4SmYYFYjqP0EXMXwLbMJvT5ofLhnk/xH8ZEQCDG+EgA/BoyhJswXaF8J3W
         8VVfdCp+z0kOMoxFZfU6ZMzbB4oEz+fynf2mwUhbisKF7SztB0Vi8G8QZxmv7kIbQTR9
         CQV8/YO85lwpGB/1NrUHnVHwIvMqqLznOtp+0PEJtOoXAza5aDq4z6F4l/+kPv6vuwBk
         mpOA==
X-Gm-Message-State: AOAM531xM8ILEsDlVG3I0ISgRNCFsOzXeAV4MyARohTvGRXq1bsU1gFn
        +OixqR5Vc4DtidQmlXYGldE=
X-Google-Smtp-Source: ABdhPJyW3GhA94fMa4pOEEGPq4uBk6v8GzY3MUV4sfCOd9eI1msJ0Vi83xfnoaqt6lifAHrKbS/ECg==
X-Received: by 2002:a63:ec11:0:b0:378:5331:7f18 with SMTP id j17-20020a63ec11000000b0037853317f18mr13695809pgh.577.1646739785937;
        Tue, 08 Mar 2022 03:43:05 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:43:05 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [RFC PATCH v1 15/15] mm/sl[au]b: check if large object is valid in __ksize()
Date:   Tue,  8 Mar 2022 11:41:42 +0000
Message-Id: <20220308114142.1744229-16-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
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
index 07ed382ed5a9..acb1d27fc9e3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -986,8 +986,12 @@ size_t __ksize(const void *object)
 
 	folio = virt_to_folio(object);
 
-	if (unlikely(!folio_test_slab(folio)))
+	if (unlikely(!folio_test_slab(folio))) {
+		if (object != folio_address(folio) ||
+				folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE)
+			return 0;
 		return folio_size(folio);
+	}
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-- 
2.33.1

