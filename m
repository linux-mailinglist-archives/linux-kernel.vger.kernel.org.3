Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18549B8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583712AbiAYQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379305AbiAYQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:48 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F5C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:47 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q127so2798121ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oN4lu8lbyhaxFZyXszWUPj3DflZg95OHRJxVYyEjsXM=;
        b=d4Lgc7EeeMJ4uPc5SPPd5GZD4n3Q9Xc67fU5XsOVjJGh8lxQ9Xp0bEs6OGoLMusZst
         peZ0AyCrvHbdXCpbRqOj9fpepFn2qQV4+gVXwJnK0q/DaZ8zXvEvlMsKh9uOqMvCpJFN
         jxjzbxuD1+kEXfneEbg7ydFbCLL3bdlC8CtpbSzzJrKc9x8skOSJbvLr6SmpLMV0FQpG
         6j8EuRDEJ7P7Wed2SpaasZWtHsWeVFEQLmeqRJf0ZVnEXa4mkbM6JO8ExgBGn2WM3lWg
         7dto3Y/85cqfmQVP/l9aYE4mQHtZ/IqgCpSo/P83qKGYu0fYayOd/J5tx4Vl63XryQ/j
         K9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oN4lu8lbyhaxFZyXszWUPj3DflZg95OHRJxVYyEjsXM=;
        b=zxWYIjHexnd7esWNF+GT+mEp/NNQ6cqze1VFY03WiL8DoeX1xWXoirjYtHwYyquoav
         OWNXdNn1frIftfwKptocV7vfwh2exgY0qSZLiLteg7X2LdSfYWuCUIncK48FCQydXEaT
         pRH9cYSpPhjt7Cnyx3ykvjeuW7TsXL3qI96Kt2ioLyJqirI/Cnt22ZNU9cTIyHiDJ+JO
         LhIfSXUlkJXibqXy7mOdFtN62LeE5/Oo2qKMLA1zDtb8wuorHltg6NMUhpWTxgIgzQ6Q
         Yac8RiS0xkV01eKVNidCPRC4B6FGuzqqkkCDy6W4kkYAMxna2cnrkmPGWGcEt11VK4Q/
         IDsw==
X-Gm-Message-State: AOAM531qI6RrbPx37klDCQdqkkqGumPXPI7PKLlyMv0la9wqXYPOdr21
        hbEube+YW9Ld6WqxsbFJ6w4+r8DuI59Sng==
X-Google-Smtp-Source: ABdhPJz5+F6eAqDaurF5xrLoqgASnvG4LkTEdjgcOydVL9zTEF4lTZEVGbQYh92zv4eVfY5oe+qQMQ==
X-Received: by 2002:a2e:913:: with SMTP id 19mr7947878ljj.299.1643128185951;
        Tue, 25 Jan 2022 08:29:45 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:45 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 01/12] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date:   Tue, 25 Jan 2022 17:29:27 +0100
Message-Id: <20220125162938.838382-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
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

