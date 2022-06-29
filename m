Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6041D55FA72
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiF2I0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiF2I0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:26:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0303C72B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d17so14382342pfq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1U879wVoKQgC+VVp5dSPlJ1DI5JNILGgmGyf1KCySs=;
        b=BvkRFh8bBV3U6dHqDi6jrAEoT/PTZq1y7LfDUzbpqj5zY2sD/ZXrg4Y5hysICNVTMz
         eTmLu1zcUsewGjZ3A/E8QQlHbVPB29UKdzfr+130zsytTooPxh31QMjV29EYdtjXNCNB
         9H1sEF34KaNV0KXHfLkAJJmRUniuE5khGAvIIDDSOsk4y42d1xdeyUtc2iXv1gj1LxzC
         H3lfbWSWy+SL5+scFrIGotyhEbWd/Ypnm6jPyqkQWLpxmg3pSdFik6Xf6d0wZ0Y2CpMH
         m+QFsy2k47t0Zixb5P46r2gWQLJBcQbbu3QuSph6xVBNMcVPcoNcCUnXN82deeabdXKu
         +IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1U879wVoKQgC+VVp5dSPlJ1DI5JNILGgmGyf1KCySs=;
        b=qCLxR50GbVp5O1nVZYdAlZLhTWeyksPCATGF+aueVXG6YcUynUqnhDB8/iGWxJ+I4H
         eQ45oAZjRyduWF/ayTxWGamPajnxeV1wrNs6icw+EEWwwdKRKMFDPGwvRwKBIiTLrX+J
         QXsElijoQ3NC5Osk1IyWOVZ6M2L3wD0dlIZ2RM9/ZkXJYI8j4trH5w/NvdjJN9xAxTix
         OPObwAMR5BxofYTtzWEUH7+9UDHuKejIbDlZuqNoFZM/qL+wwtZmnGTFsi/MbHB9qHzJ
         pFtLdeVlOXszpXw4V1VlH0kcpCQScJ1ml1pCio/uNefMMfT9mnIKPWmx7RpOQKKhf/2b
         63CA==
X-Gm-Message-State: AJIora8PnVKKKSFQG/kbytOSyyOEI/EBAbfIhf9HZINcJdfkGVESxpD9
        ZGmUf+HeOcs0PNig+c8aYmWXytjRANIgazQ=
X-Google-Smtp-Source: AGRyM1tUnlVAKVZbFfPgsmGxaJVo+O+4kI41DIEqnXqUFqKH/A0+mo7ATWQL26QEL2Qtu2cifot7jg==
X-Received: by 2002:a63:af1c:0:b0:40c:f9fb:deca with SMTP id w28-20020a63af1c000000b0040cf9fbdecamr1980782pge.479.1656491198022;
        Wed, 29 Jun 2022 01:26:38 -0700 (PDT)
Received: from localhost ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id c19-20020a62e813000000b005252adb89b3sm10859382pfi.32.2022.06.29.01.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:26:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] vduse: Use memcpy_{to,from}_page() in do_bounce()
Date:   Wed, 29 Jun 2022 16:25:37 +0800
Message-Id: <20220629082541.118-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
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

