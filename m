Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6791C583772
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiG1DUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiG1DUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC3FD20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so910285pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+4wXLhCqMOnatfAou0qtELmUB5gm3L0a/ZVBnly/jQ=;
        b=JZz5L1rI8gDfPCtPy2bFkPx1G4Xi+2MMcQVBfPH8Opa+uFG4D02+m2QTPOiNmM7WiJ
         knkPJhfknWLhfc1tdRpqlKdHb/dH5Ahw9b9GqhF8yIzSePlnkOab5bmH5LQ11uZLX68u
         L9AYby3t8XJMPGzOWUoVybGYopKAZoXEcB2HzHr9lzfGpIuCihREgWdEBpWWD8me5qtc
         5Q3IeXFcDx1qyy+VlfyjuLkwBSWnsTE7ohPaa+Q89DmSGINvVKoQoUF0k4zyvfmEMiX/
         d4/O9piU7zDgts2p4nd5w/PSrhNxHEiHLiUDiDrgTjRuUxgFGyR+DPhd9mwdsd/Slkhp
         DhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+4wXLhCqMOnatfAou0qtELmUB5gm3L0a/ZVBnly/jQ=;
        b=TmEUGC+W80JKE8Re6BHsOsHE6FKOShfQqbRP26QcC2o7zVOsNe/DYHoHlMHlr3jzmb
         JbidiQDGEmx7+VjoaOuoWv7W4VC+9YeycjwvziPGvRRqaTeqZBRsEIw6UyycSdwxWLAF
         8TSlRfXrrl/6DG//mAjVEvqmopr2UekWwQP5j8Xu1ouXZZsufQeuy1RRd5Fs5se18jU9
         tSy3033PjdZvpsY+w5b3VoFgYXpOwD11lVe8vqAeUUTd9DAczyL7nEegMxLI6efEIgVq
         Wvzyr02gQvjP1/ai6++HSG3+qEhRK5XglJEWk9x6A43gnyMqfpsrOzaAenCu19y7VSss
         Im4Q==
X-Gm-Message-State: AJIora/QGQVbj4DXzw0o71yOIhHuVP9fj2Mvk7bsOBC2MUlfYqKWlJCB
        KWCqDUAMcNXngr4xNongPX6p
X-Google-Smtp-Source: AGRyM1tspLhw8CgRCi1fQqiq7dNs1syI93DZKHJYclwGOXh1RKI2u7cdOG8lI1qImuWD+nzHqGP6bw==
X-Received: by 2002:a17:90b:1e03:b0:1f2:518a:8f78 with SMTP id pg3-20020a17090b1e0300b001f2518a8f78mr8044965pjb.217.1658978423003;
        Wed, 27 Jul 2022 20:20:23 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016c1cdd2de3sm14340148pln.281.2022.07.27.20.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:20:22 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] vduse: Use memcpy_{to,from}_page() in do_bounce()
Date:   Thu, 28 Jul 2022 11:19:57 +0800
Message-Id: <20220728032000.127-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728032000.127-1-xieyongji@bytedance.com>
References: <20220728032000.127-1-xieyongji@bytedance.com>
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

