Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C35886AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiHCEz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiHCEzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:55:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A531F2D9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:55:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d20so8043243pfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IpMgub05osj0GdqKxseckZ4i/mup5zTuM2yqAVP/SCY=;
        b=ryxzzJDFc8FZmx+iWid826j6f5ymx07YzpvCDQ2SsSgUBOUhHryHq2dZh0M5i8Z+FO
         Bj4+ezexAk49d6HhUQgD96hQvVvJoaKKzfu4+m6cy7u5LiP4o0RwRpVa7OQscKFXYVLc
         fpN6VA5f9Y9ni0PiTNK5U6v41rcvGBocyYb8+dVvgWiklfoiF7MR2MMEZnYv31dgZCiw
         2lBARNpMTmyJnnttuJzzEOkn+PY2aV3gIO76OEKygrVFgR0hvbWKIpwqzVoPpO1t+6VQ
         zNQXZU1gUqEqwB5j9XB8HOTEURfgp16OxtveVkmhWf7X/v7sc6qEsKLAuLmhH37U699v
         S0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IpMgub05osj0GdqKxseckZ4i/mup5zTuM2yqAVP/SCY=;
        b=oIxJwYDvSTQWmAMvghmZpJUKphKtB0rgfrwllAB0awEvocLK6eXcm1kGo+oF35wFJn
         uf9KTQXG4bKuZIeJGH4RmTHK+DV0ZAm45qBqgtcSyNPrilfq+I78zKLC5HrKD9ImNTrH
         vjxjAMxjnPaqMmvkSPsKmhIizO1J4T5hCnQ70s6PTw8M7zkMu+QtgeZUCkynWc3SIsYT
         z/F2S++ORIi4Fa/FIm7nMmGb3aDV1ol5snkZgWhIJ0T/0/owPlGbja82aae+unTiHX7B
         Fb3aV3lJBs2+LA8j6hYjSDjEz3Ext8wWfyrHWKsxprlWTFNs5uqVohU2pCu5c6YUUmOZ
         Wmqg==
X-Gm-Message-State: AJIora8ghMkn0SVsTRBDOlrXJyCglqHnPiK9pnzd9jF63Or2IYU74jUi
        6DS5HeJjKRtKMKhUhtNYoYdlu8KHQfaY
X-Google-Smtp-Source: AGRyM1tAiLEpaPiDEehOTNJTIIDy4dCIvK4evOb8c6IM2UKkGw6rOE+Rz0dhO4XnkzgkW0jxDCd+0Q==
X-Received: by 2002:a63:d614:0:b0:411:acdb:5c55 with SMTP id q20-20020a63d614000000b00411acdb5c55mr19288702pgg.245.1659502544103;
        Tue, 02 Aug 2022 21:55:44 -0700 (PDT)
Received: from localhost ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902e75100b0016dc78d0153sm634099plf.296.2022.08.02.21.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:55:43 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     jasowang@redhat.com, mst@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v5 2/5] vduse: Use memcpy_{to,from}_page() in do_bounce()
Date:   Wed,  3 Aug 2022 12:55:20 +0800
Message-Id: <20220803045523.23851-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803045523.23851-1-xieyongji@bytedance.com>
References: <20220803045523.23851-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() is being deprecated in favor of kmap_local_page().

The use of kmap_atomic() in do_bounce() is all thread local therefore
kmap_local_page() is a sufficient replacement.

Convert to kmap_local_page() but, instead of open coding it,
use the helpers memcpy_to_page() and memcpy_from_page().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index bca1f0b8850c..50d7c08d5450 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -138,18 +138,17 @@ static void do_bounce(phys_addr_t orig, void *addr, size_t size,
 {
 	unsigned long pfn = PFN_DOWN(orig);
 	unsigned int offset = offset_in_page(orig);
-	char *buffer;
+	struct page *page;
 	unsigned int sz = 0;
 
 	while (size) {
 		sz = min_t(size_t, PAGE_SIZE - offset, size);
 
-		buffer = kmap_atomic(pfn_to_page(pfn));
+		page = pfn_to_page(pfn);
 		if (dir == DMA_TO_DEVICE)
-			memcpy(addr, buffer + offset, sz);
+			memcpy_from_page(addr, page, offset, sz);
 		else
-			memcpy(buffer + offset, addr, sz);
-		kunmap_atomic(buffer);
+			memcpy_to_page(page, offset, addr, sz);
 
 		size -= sz;
 		pfn++;
-- 
2.20.1

