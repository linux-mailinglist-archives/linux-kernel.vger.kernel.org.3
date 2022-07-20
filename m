Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0457B012
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiGTEmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiGTEmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:42:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD7B4D81A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 17so5163874pfy.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+4wXLhCqMOnatfAou0qtELmUB5gm3L0a/ZVBnly/jQ=;
        b=t2MZ1IsaQ3n2EXNUQ1JyEG6zysWpWMMHguIetrtJeT2xEzyMtSjWzlSeZYxmXsa9B2
         aGIK+V9RGAG33dmV6r0YF4C8o3WTieruPmCHkjps9nYquVJr/+3F/SY2M11yiPFTrYI6
         CvOhUclItF4qhzVTJGLNC/9OIJMH4ZRM9QDxU5Rmvqr90b9EJ5aqAKCj+t04FUhgRI3C
         afp9cTGmkl8dzOlEbcMyLjReT8vmkOIBq0ZXRI6njNKESJSk6oiyWDatAYMkX/Roy0cl
         ZVMrBp12q1KVdJv8Q0U2goQj3gM1OPYlcEYdu/AF2YkSCKqU5dTnzhJcm+uNKx7ixXTI
         lr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+4wXLhCqMOnatfAou0qtELmUB5gm3L0a/ZVBnly/jQ=;
        b=0PADzvlFgzKeAU+fgdhV9jWi//ihTsmfAcWCg9XIT3Kou2OQTdLBQZI+NdTAMRCO+k
         dT/Wf402taRfIt0wRolSD5LmVTbF9/MuERDV+cGSaWezL1ch8V+hXYB8a3jJSXhX3l6o
         64awznE9FUpQ+tWl49M9jkRRnxH3fk2qHVZA/3rSs/tSJI8TduMb3MP6LmjV5DwZhNIk
         ToZNBctLKeHpzbO+2WDnwELEETu/xgzACuxUareDmdbUKbaSVyQnnjCeXZmJCO9OjIOk
         rp4FTjxyCm6niplQ4zSzmFUG+auLx224yiv+ReFsj1p2C1Y2hJZoZSh59g8+im9WgoUU
         oJaw==
X-Gm-Message-State: AJIora8rZYMq/jACmwrBBDQLzz56sQlodF9kIE07YR3dR0y5QfV0xEWk
        vcwow+p2ZXh/M4aZG025tlKb
X-Google-Smtp-Source: AGRyM1u0zHPbglOpZK7eHiym3Ks0QoaMZC09LG/TNQRAdzM+DXT6fspLpPRd4YGGyBsi8pfcPBAUtA==
X-Received: by 2002:a63:4546:0:b0:41a:5e8f:508a with SMTP id u6-20020a634546000000b0041a5e8f508amr2630148pgk.419.1658292131380;
        Tue, 19 Jul 2022 21:42:11 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id v26-20020aa799da000000b0052b11fdb353sm11966201pfi.125.2022.07.19.21.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:42:11 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] vduse: Use memcpy_{to,from}_page() in do_bounce()
Date:   Wed, 20 Jul 2022 12:41:41 +0800
Message-Id: <20220720044144.90-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720044144.90-1-xieyongji@bytedance.com>
References: <20220720044144.90-1-xieyongji@bytedance.com>
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

