Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEE3536DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiE1QMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiE1QMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 12:12:40 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044E11C03
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:12:38 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id a16-20020a4ad1d0000000b0040edb942aa2so944815oos.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CuVbTAvzY+QWUP1IzG5ja4oDWL1lfXVEyJuS0ev3io=;
        b=MKQC5uQUI9fopxEoV6HKJIQ+w8LTATy9A3QxoxS6fpyrj3Il9Tc8baXe5xRQmqEUq2
         yDmNmKEWPGCgnu5KlxSbDEDij1EUCfTV/n6RPHyXXWpppCVL+hbhclzJi0Ez4PLZxfzr
         oSesYYV1VomSKCXJ5LX53fMUFSUEpn6kv3KKGjy7YQwdeI9nMgxr0HldyvYs72OeCx8P
         68orktmsiXNYxjSMx3TzpJCED9k4O59DkJ5n7+Ue8CaK8Mi0nw7T+O3ylH8dPTHKeFKt
         42hIZ3xBNvAnj1e0gdJQq3ICfvqIqRpBi/cUutgZuUTRKJQ6e/qAweZDbyVdsWp3RHOq
         d/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CuVbTAvzY+QWUP1IzG5ja4oDWL1lfXVEyJuS0ev3io=;
        b=Gy533IQsEVRwS1h9Ypp1zAqb5bgwwIRr3yV7N97Eu+NTEyKNHhN4pOuumiNntKP17s
         av92PFOiM2Tj6kMSOU7ZhnvfH/Ytuahklu+3/Lm57Xl8h7sctOeK8bMJQ9qF1bm7Qbcw
         45Tl5LtLZ+LHs9XutVuHuqOufCqDliIv18ZEiooEF6QyPdVC2ZJE6iTtjtCB6VhOeMq2
         U6bpJTIvqpt++FTgghD7/bazwBvYrbxgjyoeKwfZpTyTXAZV36952Om6ZM4/2i4X8Atr
         U6bTkN3atmlzlBFzHDc9TKuY6Z4FWmI13bVGvqb63vVBsSQSKVNt/tYkkvdK2IpoQIst
         itaw==
X-Gm-Message-State: AOAM532QpqZ5dHJGos0c9A9Jnvjycr/LjdaGeMj2vsRcK4ckw3S4TTi5
        SIpyR8iYnuuW53/04i7YMxCJZc73T8X2pv6gV54=
X-Google-Smtp-Source: ABdhPJxbMqOKEcdyPh3QlXmXLQy8tFxkS9turoxTy6CWF4Cfw3YXx4xMyHay4iS4unou3SELw1hlWQ==
X-Received: by 2002:a4a:430b:0:b0:35e:a582:5ba1 with SMTP id k11-20020a4a430b000000b0035ea5825ba1mr18737312ooj.75.1653754358159;
        Sat, 28 May 2022 09:12:38 -0700 (PDT)
Received: from localhost ([199.180.249.178])
        by smtp.gmail.com with ESMTPSA id z10-20020a056870514a00b000f284870a68sm1621842oak.25.2022.05.28.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 09:12:37 -0700 (PDT)
From:   bh1scw@gmail.com
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Fanjun Kong <bh1scw@gmail.com>
Subject: [PATCH] mm/slub: replace alloc_pages with folio_alloc
Date:   Sun, 29 May 2022 00:11:58 +0800
Message-Id: <20220528161157.3934825-1-bh1scw@gmail.com>
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

From: Fanjun Kong <bh1scw@gmail.com>

This patch will use folio allocation functions for allocating pages.

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e5535020e0fd..00c4049a17d6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1794,9 +1794,9 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	unsigned int order = oo_order(oo);
 
 	if (node == NUMA_NO_NODE)
-		folio = (struct folio *)alloc_pages(flags, order);
+		folio = (struct folio *)folio_alloc(flags, order);
 	else
-		folio = (struct folio *)__alloc_pages_node(node, flags, order);
+		folio = (struct folio *)__folio_alloc_node(node, flags, order);
 
 	if (!folio)
 		return NULL;
-- 
2.36.0

