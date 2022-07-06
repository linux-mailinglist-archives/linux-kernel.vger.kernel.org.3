Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02685567D9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGFFGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGFFF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:05:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590991B792
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:05:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so8847289pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1U879wVoKQgC+VVp5dSPlJ1DI5JNILGgmGyf1KCySs=;
        b=jtP2p/aSSZbB9SXA3VbtkDj9O8wB+KrZpRWQrndcYnad8nX0i3ffu9aoua+H7Skw+x
         rlc0GMe2N9PX/SzDImhd8umzF4Zdg2GT0o+EAqVKHXnWE5gBRjLLOHMFhD3PCPNp55fW
         dkQooq0Pqbd10G/gewX4bjz5a51ODX+B25a2dbzxMV52gtdmCgB0wJfSV0u9fRZJwM6j
         l2km4CS+WGaMGUkiy8cL2Z2SHOGjrA4sVZkDf9/+w3oVo+dwJU4VKeJd5x0A5IWgv7BN
         welT8+s8aZM36koSgwtLNyIy0ZBJwIqVDLkIi2r9J1FxzRR/kTTHPIDFlFyiplWwa0cE
         KIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1U879wVoKQgC+VVp5dSPlJ1DI5JNILGgmGyf1KCySs=;
        b=sQiGrbiqz1L7jG6JRy5ziJHg4S1ql6SNXYh5x2qlSy2O341kZtWwZ1jSfwKGnESezn
         bL/1+4Rz80rkJwV1DDOaA5SpINDcbXuOS9l60E30pzJ6QAN4ex3gr/L8qu606TZOcssv
         7NYgxYaXsqP7/toEOFnU3A17jBRgHGpJ1PzKz34lUjj1Ev1iteguBNWDDXGhXNoyWr+A
         2dBKtQ8is5ZW9cARuxex7Qd0BXbiOqDStP7M7TMry7Bd52Ils+odmHVVzsCF3PSBLyhm
         AbR5PmiPrNgiLtt/ZcgBns9eDzEJSQpPoBqr33FS9NxitQnpCGNSWbrFc4FtdA9OFIVV
         QDZA==
X-Gm-Message-State: AJIora+tdAUFR6y1WC43FZUSOfvR6KNyiQ0lDds6c+EGKQHMSizC4yzS
        70kqaC4Vp90AiYHUkT1Hirhd
X-Google-Smtp-Source: AGRyM1uGO6hDXem1gjCyCJgwOMjwiLCEHm0bzbw74D8COK5kqMJuCy28Eaj8nAGEqQ7EWPbvxII4AA==
X-Received: by 2002:a17:902:f646:b0:168:e2da:8931 with SMTP id m6-20020a170902f64600b00168e2da8931mr44666522plg.84.1657083956892;
        Tue, 05 Jul 2022 22:05:56 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id c20-20020a656754000000b003fcf1279c84sm22834363pgu.33.2022.07.05.22.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 22:05:56 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] vduse: Use memcpy_{to,from}_page() in do_bounce()
Date:   Wed,  6 Jul 2022 13:05:00 +0800
Message-Id: <20220706050503.171-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706050503.171-1-xieyongji@bytedance.com>
References: <20220706050503.171-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

