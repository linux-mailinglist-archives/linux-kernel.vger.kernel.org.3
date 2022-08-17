Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E55596CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiHQKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbiHQKUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:20:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA4D82F9A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r69so11608286pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QvbBlM64XGXvCYpSrw2ZhXubC7osA9SaKrvHemruWUk=;
        b=OH1i67TRQUnuhYunmmI/MYZkQu3kqwPcoWFksU+md4pWKAZnkbL8LMUnQFZcQ2ihXg
         AXvgKmdFw8N9HiH4T1CGwUKqhKiLDSXrAw1D6savzF8DUwAN1q0NeZNH18ESnyEIQGu6
         nugZqGOPIbMKIQDiyvg9qiWA1W+EysZuIoPc58j95+BudKMg4WPJiSVfrxmz36ASlbSh
         Xd07i+oFEYQ7f2iWznifckbG5x6HlGnLRSUwyz0uFBT2C0TNca2HBDwbWCXuxm3Pel3N
         uxY6CHinDJ/cnbjrWvKy3JqwZ9dHWsFlPLb2AlhKDtCzlwsdULxFoAWm6UV0hO7fTKtB
         +wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QvbBlM64XGXvCYpSrw2ZhXubC7osA9SaKrvHemruWUk=;
        b=3tCG+cIXVRU3wxG/Kv+vddJwiAzRqCF/Tw6WjShZ6UQySF53lWzYJqAUHtFgECLhDL
         nz9GSlPsuzIpdYhVwwGkX9z+B/oNYgxshtbUXIYwogGfRq2r67aqADAtFdI0PKnGHfNp
         lsd4KL9fM4LPBk/oNyA9JDnNk2p9ue4b9GaaJy83Ij+aOYT7FwJPnT4+4367WSY41gtU
         C0X+VeTkfo+GBKdKFXUiEBAg6cVAtwWrazNlvxjBasPfReJ7oEhwmO4not0gmE9pE0aw
         SIeju3O07Q1d+aCZRKm+fuzs3ZOH072tO7uuiO1eKOnInYt7XiKMdiDVaCnDikntIsDW
         ITvw==
X-Gm-Message-State: ACgBeo3FLnZR8osYK4UL0r/Dk24dsUqUKupnLKK2vw05NYzB6G1HMiP/
        TCI9WuUYr35uhUoi+YuSbTk=
X-Google-Smtp-Source: AA6agR5BivBlhg3XB+mK1tMfAb8bN7Obm740H6tldqe9nQKKdLaKub/ufv6AC+sNXwisZ+Ihenb5GA==
X-Received: by 2002:a05:6a00:1c53:b0:52d:d673:2241 with SMTP id s19-20020a056a001c5300b0052dd6732241mr24646290pfw.71.1660731590183;
        Wed, 17 Aug 2022 03:19:50 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:49 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: [PATCH v4 17/17] mm/sl[au]b: check if large object is valid in __ksize()
Date:   Wed, 17 Aug 2022 19:18:26 +0900
Message-Id: <20220817101826.236819-18-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817101826.236819-1-42.hyeyoo@gmail.com>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
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

If address of large object is not beginning of folio or size of
the folio is too small, it must be invalid. BUG() in such cases.

Cc: Marco Elver <elver@google.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9c273a5fb0d7..98d029212682 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -984,8 +984,11 @@ size_t __ksize(const void *object)
 
 	folio = virt_to_folio(object);
 
-	if (unlikely(!folio_test_slab(folio)))
+	if (unlikely(!folio_test_slab(folio))) {
+		BUG_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE);
+		BUG_ON(object != folio_address(folio));
 		return folio_size(folio);
+	}
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-- 
2.32.0

