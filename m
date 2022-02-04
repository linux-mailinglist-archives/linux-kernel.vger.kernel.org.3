Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863714A96E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiBDJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiBDJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D4C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b9so11469564lfq.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oN4lu8lbyhaxFZyXszWUPj3DflZg95OHRJxVYyEjsXM=;
        b=UU95mJTP6WlHYcPQ0GN9VROVMxSS0JRSVCzbKFEAYHnJoB4JyMBBEiEkiwvUuswO3Z
         SXFT3opI9McnKmzb5wMSV9LCGdlWtpJ0kzmItSwgLghRQ+Ym32W1nyVtOVYDh65Hcx0k
         APLu3aqR/ytZvJv3OtwGG8kcEDR5m1d8XXUziRFOP/3Q00qlxu1KCHkwVlyDbWWCcKEn
         kTAP1lO7yA+94HKU5PkuFhpfeQtd4JYnmYRNlTRK61gPxVzXR15l0HJMWoO2wyoQOeFd
         PyMIfw16cJW2PFXyJRcE45IgkxI959nl53NwzsTKIq1Lt4Kl33zO5zz77c/RcxQTctHK
         65wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oN4lu8lbyhaxFZyXszWUPj3DflZg95OHRJxVYyEjsXM=;
        b=eRQNIP9xpcMdvkZoagUhuiB1ktO8U9Bu2G3ozsygNBH7BW77JzP1t+LysH11z9LFBX
         DNpuy4mwflSd2hQ2rcbsJ1FYa4M0HnPKX+ei0xJmR3YCZ4R9crAb1aQ6itx9I6D/ttsh
         fF+67R4IMxzwvDTQuxzRfCfdz5zD/S/qz+Z4FlSH9RsrCFJ/4St7iFn+ZwyIbPdqWZYq
         RhAhc7WyBsXV75IjoA38fHzYIEju2sPBn4HOVUGcglw0r+zK9TNQkEeusY2+qIqKG2sf
         LTLdb0MoF8iNZSuteeXMH/rLhbNV7ebWfEriDWsmiAcLUitodWG/uuM3WnrINcic3M6u
         4jhw==
X-Gm-Message-State: AOAM531Qwlo7JBJsY/6LlGhVP6+BRE0ibqx6bTh3eGA85wmyrNDfxjOZ
        Go25MTVRstv054i++P4nDOvj3yx0VeFxkQ==
X-Google-Smtp-Source: ABdhPJziNpLJLMmIZ85Q4lpqOwiwZHjxS5EeMJG95tfsUjeRSr6gPUjZF/BbVRFly7nfdMPfiKSLJQ==
X-Received: by 2002:ac2:54aa:: with SMTP id w10mr1691943lfk.357.1643967250387;
        Fri, 04 Feb 2022 01:34:10 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:09 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 01/10] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date:   Fri,  4 Feb 2022 10:33:50 +0100
Message-Id: <20220204093359.359059-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
the old deprecated tee_shm_alloc() function which required specific
TEE_SHM-flags.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

