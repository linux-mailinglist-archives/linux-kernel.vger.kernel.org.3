Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB149B900
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380789AbiAYQgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383773AbiAYQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316C6C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:58 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e17so4452032ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IS0JYukQ1AvM/V854xXkjA8DA3zzQrPupG56zCEbY2A=;
        b=UWaP0AO1n2pGaP2HeNNtZwiIpiNSxrKn9hvufz8KXH8tidHqfE7craAOpuWNAh3aUI
         8nA7oMVKIUrstRQ/+mixAodiJCxocrBBebTEO6kYMSuvn2VxlwhUVYH+3uqsuwp/Qj5k
         65rDQixL////VfikBNNtr2AMWJGvhal1BsdYL2CUNFYUXE+tp8s0sTeEKUaZZPtxK60k
         DfhyzcZrBXnpQv/VdiPkHur7UqOcB5I3j2DMrhpmbkjy6Kvp7nd0LrgYgs1lLi6gmeKS
         hkNPOgtjdcxgaVBhibOaG0JlOW5x5Wj2U2hNMqNQcX/LpYSnW2JK8TYUCRafeV3HffTQ
         +YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IS0JYukQ1AvM/V854xXkjA8DA3zzQrPupG56zCEbY2A=;
        b=rfWD0NwGJRklQCM9y+iMGTXKz9PNDX+4/iycUTe6FpbyDGia4C45BJQgG3BmmmGpfa
         gxkl8BYHbFgtmFFRo7nbmhn1VP+aSLqDFpuWCCpxkCphBFu0RlNBzEtMYrD9Ybj9LRLU
         L0utvud/3aomVd6GGPTJMq+W6d/8v2tHYVinio0D/45hUUs0M6zuESwvXljny+IYMXoK
         l54mF80208FmeQQJ0CqCQQhM/bCarMQAHOxZh1VV/fKGWMyveSHxx56gdX1zxF8eCipx
         JtOfGxD3URMEpaA0SrrnIw+hpcc7+ZzIC/3We3+SalwE1cKbimT64p4tU4j9v3Gv6vYr
         /ypg==
X-Gm-Message-State: AOAM532ruIKWBT+d2J6g4W7H4SAahEzhpjTb+rPinICj6USm+KZCvtZn
        jJIyV9Tp2LxW1oNfWNMSKddIijDkN4ly2w==
X-Google-Smtp-Source: ABdhPJyt2baCBXDu7rjIjXTmZHaKBDthZf1ExPVNShOaWzTP/1WYkOhm6KV7XxshoN5yFZymIIiedw==
X-Received: by 2002:a2e:a279:: with SMTP id k25mr14523841ljm.163.1643128196299;
        Tue, 25 Jan 2022 08:29:56 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:55 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 10/12] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
Date:   Tue, 25 Jan 2022 17:29:36 +0100
Message-Id: <20220125162938.838382-11-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the new simplified tee_shm_register_kernel_buf() function instead
of the old tee_shm_alloc() function which required specific
TEE_SHM-flags

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index 2ce66c199e1d..c8626686ee1b 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -70,17 +70,15 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
-				      p->key_len, TEE_SHM_DMA_BUF |
-				      TEE_SHM_KERNEL_MAPPED);
+	reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
+						 p->key_len);
 	if (IS_ERR(reg_shm_in)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
 		return PTR_ERR(reg_shm_in);
 	}
 
-	reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
-				       sizeof(p->blob), TEE_SHM_DMA_BUF |
-				       TEE_SHM_KERNEL_MAPPED);
+	reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
+						  sizeof(p->blob));
 	if (IS_ERR(reg_shm_out)) {
 		dev_err(pvt_data.dev, "blob shm register failed\n");
 		ret = PTR_ERR(reg_shm_out);
@@ -131,17 +129,15 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
-				      p->blob_len, TEE_SHM_DMA_BUF |
-				      TEE_SHM_KERNEL_MAPPED);
+	reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
+						 p->blob_len);
 	if (IS_ERR(reg_shm_in)) {
 		dev_err(pvt_data.dev, "blob shm register failed\n");
 		return PTR_ERR(reg_shm_in);
 	}
 
-	reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
-				       sizeof(p->key), TEE_SHM_DMA_BUF |
-				       TEE_SHM_KERNEL_MAPPED);
+	reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
+						  sizeof(p->key));
 	if (IS_ERR(reg_shm_out)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
 		ret = PTR_ERR(reg_shm_out);
@@ -192,8 +188,7 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	reg_shm = tee_shm_register(pvt_data.ctx, (unsigned long)key, key_len,
-				   TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+	reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
 	if (IS_ERR(reg_shm)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
 		return PTR_ERR(reg_shm);
-- 
2.31.1

