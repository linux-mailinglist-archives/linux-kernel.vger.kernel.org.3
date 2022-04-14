Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17DA500937
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiDNJFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiDNJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:02:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089052A259
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:00:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t12so4120760pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7gcZ2iThFka6LvykgF/itOBPX1z1QotaADm6wrPK4A=;
        b=aleL4N3zpF/Ea+70rZj2fCuVsct15PZsMcWwS03pX3yQiXe8ck7/m4zT6KNmGYgDvo
         mqEjk6mtV2uPs6Luaq/+ilfVnpYUeogNBGzEmh3vbyvT3C8ZsU4Qe9Ln6IGBRZeNH7QF
         6WKwZNbxfUyLSKI2Ta2d+GF0DizhSqXlmAqPm9M0KhFv6bmyxSAigSZKIGWv9jNeETz7
         44/WOwe7f8uK9yTDF1cWYFv8nFc9ZB590hw1Ka/eRUs/8mXqX2mUh8jIOZGvxxoYrCl/
         h/O3OsN/P/VTP5eozp7LggK0Y9SO+ja0h87RlxoOuy97ZaBdRfGmt4vHdiCf7pUTz1fq
         FGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7gcZ2iThFka6LvykgF/itOBPX1z1QotaADm6wrPK4A=;
        b=CtMKwc0a32ycjw0pWTRpJY7xXHtzbSDAkQ+w/jhDsz7SuB1Qs6V7f5HnqgO+8MkwAo
         3aXOmxPpzR2xfUjP+EQELKf2FZpbrQfIWdI/+cl+vVYKUYd6yETzSp8prqgObiD38YDl
         lOluuJpUppPhR1HmUZe/IkLjjocAV5j6CQfPKlkIfr2MeIZ5JWqDkcPl7mORm1UqcTjc
         AtRjy9anBKvLsqSOF4W3LbB3rB+AIV9z7NXl8gsc62ZOAy6PI89wzb5zO/e1z5Kk1ueR
         anMw4KOZuXcBX9o1SpNxRk1Z34W4USdAkvDO5j9zLAO05H+rri2hVMwo+woboBs4+qpx
         fWpg==
X-Gm-Message-State: AOAM533FJ/Rl9JcHey/H0eWQ0tm5DVCCNWWlZXJf+xKby1o3Tfe0AdBL
        f/iiu+/MXgD1Ot1yQti9NlI=
X-Google-Smtp-Source: ABdhPJz+MKOJRhVGRMjYjrgkLtZKyFXNHXy5iSwnzJ2XplH/gav0LkRz1Gf7Zci/tlCcRcywt3k2lg==
X-Received: by 2002:a17:902:9684:b0:158:b28c:41e0 with SMTP id n4-20020a170902968400b00158b28c41e0mr3854458plp.85.1649926800535;
        Thu, 14 Apr 2022 02:00:00 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:59 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/23] mm/sl[au]b: check if large object is valid in __ksize()
Date:   Thu, 14 Apr 2022 17:57:27 +0900
Message-Id: <20220414085727.643099-24-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414085727.643099-1-42.hyeyoo@gmail.com>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
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
index 8facade42bdd..a14f9990b159 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -994,8 +994,12 @@ size_t __ksize(const void *object)
 
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
2.32.0

