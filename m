Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753F848EC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbiANPJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbiANPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:49 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:49 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p27so19520847lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwI8FoTifdXWAKhHzqpeiPhswUT20WDuLw+g3B+0PMQ=;
        b=fCNXkPpRYTo9IliKsoHIH0v2yU8zmgF6CPFJYwbbBPkEKVsa4rxyP3BVCiFFZgquYX
         z3wddR87WVCQJ0Bt+kqhP4uIDPBIdIYw6MQUPSg1sMm++qSZfx7SJ/LaKBTqLhiZtwDY
         PzG1fq8zGi3Uiyr7ivRGjb2lt3whrN1nE/umpIwNUrFAvs03YU5TnI720Jx+B1Ub/kR2
         r0o7YrxH58DyoeZ3dzEIiPnqshjgGTJ2y3Ec44qwM8XmkRQYbnn7Rf8liXG8pUb1IWAJ
         VfCJJ/cvMYD8hj7wr+lRZ5/uYpzoMmtXgwAxH0dPGPEJ4sGxV2dK4dfI0Din8z/4Dk0Y
         4ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwI8FoTifdXWAKhHzqpeiPhswUT20WDuLw+g3B+0PMQ=;
        b=a3uOzI59Mw56i5rTBGd2ctKrp9v5SUn2XQYuvOtzoSosEGKiAPYUoZmrY9+0NnTTOO
         UikJMWbYeJTRid4Az7vJid+Cx95+8Z11QC7qlgPQeLcJB8nTKlxcsu1m1VqW2lnV8Zt+
         ykNpYoqU/klucpqTT9kuPSDZnJU/1oanIvQXcSo+H5i6fCCQaughBwP9QTaBiC799eZe
         8hImU/jhjZymIToHvwXxhxqfFa1NjgKBtBk6RejXLMUB5y4RW3C9sl7bitA/TMrMTgvF
         stnNA1gGV8tpIiRoPYoFsXHVY3smQPH8f7vPh8VT55FXZO9S6wQ7ovPe/bFxBBumUARH
         8PqA==
X-Gm-Message-State: AOAM5338cKlYszTkj9NfJ5FEamqjv36BPE+e+U7nFPe+abNhhFkOz9Ob
        mYMwqXtkdPaDL0g+/c8KADJPyvmDDhV2XA==
X-Google-Smtp-Source: ABdhPJwlW7g5gOBkY5CQKML6bw18bvndNjFy+WzHTbQYGsJGbfmWYCzB3RAbnzHB60u5+yVKiJaUwQ==
X-Received: by 2002:a05:6512:1088:: with SMTP id j8mr6885781lfg.220.1642172927674;
        Fri, 14 Jan 2022 07:08:47 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:47 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 10/12] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
Date:   Fri, 14 Jan 2022 16:08:22 +0100
Message-Id: <20220114150824.3578829-11-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the new simplified tee_shm_register_kernel_buf() function instead
of the old tee_shm_alloc() function which required specific
TEE_SHM-flags

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

