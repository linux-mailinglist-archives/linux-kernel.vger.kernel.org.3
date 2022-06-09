Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE3544CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243016AbiFIMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFIMvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:51:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B1129EF9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:51:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 123so11379047pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwSRcViehwfAYeRTO3icyIMXkIxuHW5eq5bOlxud59g=;
        b=NOqJF7S/WByS4u665bimD3BKbv7ahHS1l6RPUqD0TU5ms64qlM4kF5yV7KJC89nNHv
         a17tntzu44cTUIoP8sSPb6j87kVUhI/unLOiNJNhaNEwSlOy/1wkKEwuGoFp20WZ6Eeh
         rRbbhfDIC5738q4r1eRNRkWTD1pmIwbvuv7zZGApID/OoUv7fr+jIwIoVwIFa19T6U2U
         Fxfpm7umKjzBN7pyUYtp2+7NdwJ/axPsWaCm6tA//usReZMhlnpEtOeCE1hiolMUKL64
         D7uSlc3ofD5f6FnlZZTkZH8+mxYZiXrURz6eEM3Y9p7ATd+yBSQ57nLxaMv2skT8IT6o
         Ftxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwSRcViehwfAYeRTO3icyIMXkIxuHW5eq5bOlxud59g=;
        b=mNJtrJ3cGaxp3IdjWvO7IPKlV+Gf5SOV2DcYAyfqybKpv5mYobnLhBiwvfmWSdmI9e
         7h2/LtBWqC62K1QHhS6kXcNhQbGF9HVOrHTl9dD4vtdkZLP6N3qFo//PLu/QO2yHti32
         u64VNvvbtUZ0wXdmiLwoqtN1sFSFA1QzjKdd9pEKbnS9DtUzxdJZcE7Si1d12Kujwbmy
         XF1tWF24wC6Tv0PVW9/ca4PjkiLdWwt+xApBap0af1IeSavFN1NIo0+muey6LlE8d1ed
         lEK8FrpcDMevZ7FdonPShCjsOyojgmENySN71tOngypkFFfbXROXLut/fGTE5ZmrjGy0
         UjHg==
X-Gm-Message-State: AOAM531wtbDxpmoa63hYCGE+ivK9DXwpleUSWE8aPHb/XhNjPCH0uzU8
        BVOZAiPuku5gkss4AIFDhAQ=
X-Google-Smtp-Source: ABdhPJwKD7D9ZF1N62MeDGI5N2JXZ4WpXk3reHXe99z40A6BXMvU8ygtsV1HC2LEIcBh9MHFwuZQTw==
X-Received: by 2002:a63:82c6:0:b0:3fe:3600:f816 with SMTP id w189-20020a6382c6000000b003fe3600f816mr7343707pgd.155.1654779064103;
        Thu, 09 Jun 2022 05:51:04 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id a190-20020a6390c7000000b003c62fa02f08sm17294112pge.43.2022.06.09.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:51:03 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v3 3/3] mm: kmemleak: check physical address when scan
Date:   Thu,  9 Jun 2022 20:49:50 +0800
Message-Id: <20220609124950.1694394-4-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
References: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
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

Check the physical address of objects for its boundary
when scan instead of in kmemleak_*_phys().

Fixes: 23c2d497de21 ("mm: kmemleak: take a full lowmem check in kmemleak_*_phys()")
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 mm/kmemleak.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 155f50e1a604..387d6fa402c6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1184,7 +1184,7 @@ void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
 	pr_debug("%s(0x%pa, %zu)\n", __func__, &phys, size);
 
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (kmemleak_enabled)
 		/*
 		 * Create object with OBJECT_PHYS flag and
 		 * assume min_count 0.
@@ -1204,7 +1204,7 @@ void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
 	pr_debug("%s(0x%pa)\n", __func__, &phys);
 
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (kmemleak_enabled)
 		delete_object_part((unsigned long)phys, size, true);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
@@ -1218,7 +1218,7 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
 	pr_debug("%s(0x%pa)\n", __func__, &phys);
 
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (kmemleak_enabled)
 		make_black_object((unsigned long)phys, true);
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
@@ -1493,6 +1493,17 @@ static void kmemleak_scan(void)
 			dump_object_info(object);
 		}
 #endif
+
+		/* ignore objects outside lowmem (paint them black) */
+		if ((object->flags & OBJECT_PHYS) &&
+		   !(object->flags & OBJECT_NO_SCAN)) {
+			unsigned long phys = object->pointer;
+
+			if (PHYS_PFN(phys) < min_low_pfn ||
+			    PHYS_PFN(phys + object->size) >= max_low_pfn)
+				__paint_it(object, KMEMLEAK_BLACK);
+		}
+
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
 		if (color_gray(object) && get_object(object))
-- 
2.25.1

