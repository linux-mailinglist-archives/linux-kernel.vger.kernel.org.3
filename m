Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2981258783C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiHBHs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbiHBHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:48:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C374BD36;
        Tue,  2 Aug 2022 00:48:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 206so8201641pgb.0;
        Tue, 02 Aug 2022 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1MS9pf4ztVbyCKv989qflQ+PxKq3BLF8CrASWzL5Thk=;
        b=lGIiLus4o2SfA2Jxob2Ha+khYgBkKyGJKS+Vcci102rBZUndmRJ5ljsqfYbY9GTCax
         fWGx7ZodJ5lzCXLb6GCJFPY7/I+iY1UgUaNn51Sg/U06fGB47G7uCY9T8SRtPJTgrqw2
         /faFbPbiAoTWKxQTHOGn0IKmjo3IYIDfrgVanrSewmwdfqtoMYrUKA5Jd3LBVEdwYgUa
         kmMbAI2kGntsDeibkuagDFgO++O4jQQfFNwPeB/5bER7mfp9ErYpkOJ1sbabGAJKvQzK
         nzjdxhwuf5JhrNd5fdB8pXKG8/8y9f1BwOJJ6nf60acaDbFu5N5ek7OVT4wf4xGZ2lKO
         1OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1MS9pf4ztVbyCKv989qflQ+PxKq3BLF8CrASWzL5Thk=;
        b=PKHnlkln1hi9N3hJCVQN3EzTt4dDzEQN7wHqWd1TmrpheCz58MXRVNtqYDrAwrv7cA
         DWN5ddaBZlnQY6RNq85fIebyOBUCm+lnXLrdIUTkd4gji2KEmbj6QlAXVkWo9CRR67v9
         67Vt7XMqoUdNGZgsgFrs+7ApM0h7zlqv49QdivkRS1tWpG73qQUfRFLrDGfZqHHRMpod
         GLN2xUJVcoOJBWP7tjchJkYh5glf4wHM6eAJbTLJBWYrVV5nXa4jY6tbqPbRNXn2Zfam
         MA/Vb9gNIZjmm/P7EvdfEkBiUBgYov43REp0caYGjiOMvypQvCGhi5FsFhqiemrBGkoD
         2l1w==
X-Gm-Message-State: AJIora+qBydb75fhH8zODjbEFxt5rVWsGve9AfSfZzmDi28QqRPzTjB2
        cMMQma8svzA51ffsj7cgls0ZZhwLtw4=
X-Google-Smtp-Source: AGRyM1v1gY2V3nnnptsChGo3jWDB2lLIfhIs+d8gvjTPXPhtu/yYY3HgvYwrtligtEO7ZgSGWqKeoQ==
X-Received: by 2002:a63:f143:0:b0:41a:3744:8639 with SMTP id o3-20020a63f143000000b0041a37448639mr16131973pgk.254.1659426504327;
        Tue, 02 Aug 2022 00:48:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b0016ec8286733sm7485135plx.243.2022.08.02.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:48:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] crypto: sun8i-ce:using the pm_runtime_resume_and_get  to simplify the code
Date:   Tue,  2 Aug 2022 07:48:20 +0000
Message-Id: <20220802074820.1648786-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
index 19cd2e52f89d..ef9cfc61af32 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
@@ -54,9 +54,8 @@ static int sun8i_ce_trng_read(struct hwrng *rng, void *data, size_t max, bool wa
 		goto err_dst;
 	}
 
-	err = pm_runtime_get_sync(ce->dev);
+	err = pm_runtime_resume_and_get(ce->dev);
 	if (err < 0) {
-		pm_runtime_put_noidle(ce->dev);
 		goto err_pm;
 	}
 
-- 
2.25.1
