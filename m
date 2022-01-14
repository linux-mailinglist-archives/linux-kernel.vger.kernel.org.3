Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1448EC48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiANPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbiANPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB127C061401
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o12so14499474lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBza1mKhlqsg6etHF8D7TfcQzqGCBqmRr7/AGAencgU=;
        b=mWoA3iCe1z2dOukN3ywIDsVcujjm357N+aSwG6Z5e/kedopn/L0pgeG7yDgY0/rlHH
         vTswikc5e/ienX62gJsmRVzXS/I9YV7bJSJk+Rgvf36bEvbXRdU3Z7TXqw0YbHJvwzNH
         sfXwZ4ZsjGqps34yGaDI80H/WccXqvJ2U+IHXhpXp25Gi0fwJUjYMWaOQGb+aTXMoSv5
         CVg6nQDlrFt1QVEv8p0S8U96CiszzDk+3sRFpm9C/nTrah0zW8ims+sd9BnJONyt9C3c
         ha3CKsV3s9mDiR1umRROhqjdWu5lvm80j8brrAuhITfuTBShbFsCGAKMN8eZFsBFfdK3
         i8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBza1mKhlqsg6etHF8D7TfcQzqGCBqmRr7/AGAencgU=;
        b=A4K9TzdhWQoj3RYLjZN5fg/LSBiTFF6WUv5n3B0GYJeTi8F77jhe7SpT7/cmxFIWGO
         JWTCObdTialMUhDX0AcMzCMYZBZPbNobk9BNaeNARRDp00qk3Gbcl+2QySpnumlOsH0I
         DtVK/6nPPPNx6ZycjVkbFotHyUHhhrNeQpdAh7FQni5HveinGjOV6zDrO51FruYfyZKl
         0YcCEq0miaPXYmKVKqZwXTPA8M1Kf8b/k/8ixsarL+xgqtDz2CkG8zeQ/SDNiFwUvKk1
         3x3WiRuwnQ+LYtZR4zqttHJ3rtYJ0yOSGARtFurQBdkpv+fUC9F7m0CEwv+OYxHMpC6c
         Otfw==
X-Gm-Message-State: AOAM530SBZr7SwozZcccAEI+jzn7HkRymFbjiwz556i0WyvUBzD0dKew
        Q1XW0Hfo6jTg8VK4+zLw94nKCGlNqEV11Q==
X-Google-Smtp-Source: ABdhPJwMWgsO17BCykpmK5ITtDHSnLFw9U+WsqyXcV83Nc21zW8s5Kf/ZPVKKd2E66k2rzpkPyl9Kg==
X-Received: by 2002:a19:f202:: with SMTP id q2mr326004lfh.650.1642172920151;
        Fri, 14 Jan 2022 07:08:40 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:39 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 01/12] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date:   Fri, 14 Jan 2022 16:08:13 +0100
Message-Id: <20220114150824.3578829-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
the old deprecated tee_shm_alloc() function which required specific
TEE_SHM-flags.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/char/hw_random/optee-rng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index 135a82590923..a948c0727b2b 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -145,10 +145,10 @@ static int optee_rng_init(struct hwrng *rng)
 	struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
 	struct tee_shm *entropy_shm_pool = NULL;
 
-	entropy_shm_pool = tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_SZ,
-					 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	entropy_shm_pool = tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						    MAX_ENTROPY_REQ_SZ);
 	if (IS_ERR(entropy_shm_pool)) {
-		dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
+		dev_err(pvt_data->dev, "tee_shm_alloc_kernel_buf failed\n");
 		return PTR_ERR(entropy_shm_pool);
 	}
 
-- 
2.31.1

