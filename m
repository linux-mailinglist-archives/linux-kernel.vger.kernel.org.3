Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F09D4FA923
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiDIPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbiDIPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:08:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342C3BF86
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:05:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s14so778165plk.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bm3OLCMkSDypFlzT9/ZE3GLi/R/iGTe3P+37UHxSzTc=;
        b=Jh02YconE4UpSlidiDVIhSxHy12Kokd8Ol8EmXC75LvdIaQV6RT/kKl1i1EFScwhsR
         Q4NaPCdeFvNdoSrxzOjEQp/5NmGfA4jiH7XOY+bDbJ3JvVTSOgGgu+fPayw63X3VOkHZ
         O6CojxPYuPKMtjOzDPOy4RgTnmpvwMVOgkHH696+XQaJCyPMsSQOdEg3Zo03Ya4cJNaY
         084+Wqp8DHpOJrzb1hPU+bb0PEiVPm035N2w6mJ1biIhtiZ36JsZN+JO+vp18DBBRQc4
         8KI/4snVz0SkmZv4sLJ4NwmmTjrKPKaph4t3Iz3YYWFHlJGAQZeFYuogPr8Hn/Cd5vFt
         1rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bm3OLCMkSDypFlzT9/ZE3GLi/R/iGTe3P+37UHxSzTc=;
        b=2m5f5HxiXktJQgv68/tLqyTEEjUwLe2DA9X4EqaDYYnXkvNcHZSP5xcUEBMjJ3Goj9
         cFFqWJgzwIkNbgYvOxyiaUkcN7mEzMwTHPQPGRB97wIlc2XNXVlsa2CeWQ0AzV0ohEs7
         suFsx5lK+PIbX8lSzL1NygE+cambG7Qqu6pvCgJWPL39D9EFNmr7oYyiHw+yP2Arzyq0
         ty08IVOHlDzxfVh3PIiDVwfoC6lWSExCa/UhQbkR1WoynCndB1Q+UZgZEg5xBDYz+gQa
         lI98FxJeOZ2IhgKXcjpq/MzlLrJD+Jv6kBmn5wrp0T+2yCbTijcc8HuK+UUdqt7gzWYc
         lFxQ==
X-Gm-Message-State: AOAM530h1I4jWCloaU44alY5mkI+MpA9vcbotU9+BbHvLwBJPORT9gox
        XEKL8mnxfsADTyOGF09h7Cs=
X-Google-Smtp-Source: ABdhPJyzJ8cBYiJ51pbz4jFhNnRwWSmp2JIXBdNope2GwnNaQuIPShol8bpT7RCjwup8ns03olVZmA==
X-Received: by 2002:a17:903:1104:b0:154:c628:e7c2 with SMTP id n4-20020a170903110400b00154c628e7c2mr24870912plh.54.1649516751711;
        Sat, 09 Apr 2022 08:05:51 -0700 (PDT)
Received: from localhost.localdomain ([220.88.102.101])
        by smtp.googlemail.com with ESMTPSA id o1-20020a637e41000000b003804d0e2c9esm24668057pgn.35.2022.04.09.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 08:05:51 -0700 (PDT)
From:   Jiyoup Kim <lakroforce@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: remove duplicate flag in allocate_slab()
Date:   Sun, 10 Apr 2022 00:05:37 +0900
Message-Id: <20220409150538.1264-1-lakroforce@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In allocate_slab(), __GFP_NOFAIL flag is removed twice when trying
higher-order allocation. Remove it.

Signed-off-by: Jiyoup Kim <lakroforce@gmail.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 74d92aa4a3a2..a0e605ab3036 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1939,7 +1939,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	 */
 	alloc_gfp = (flags | __GFP_NOWARN | __GFP_NORETRY) & ~__GFP_NOFAIL;
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
-		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
+		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
 
 	slab = alloc_slab_page(alloc_gfp, node, oo);
 	if (unlikely(!slab)) {
-- 
2.25.1

