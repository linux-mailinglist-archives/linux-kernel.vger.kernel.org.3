Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C174A96E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357816AbiBDJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiBDJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:20 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE6C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:20 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u6so11415983lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IS0JYukQ1AvM/V854xXkjA8DA3zzQrPupG56zCEbY2A=;
        b=BV11LaWbT+uZvF/l/ofhsdy/6VN42Av/53aXa1sONswjmdtEl5IOQBghFsXAMWOIt4
         rbFwq4D/zncNVGL2GWOXdPhJkaZwCCHzkKR2/F3W1j6Zngbxo9zIbeecpD6CPvh1kJ87
         lEkovKZ1w3u2IppcrJPM5l4UAC75+Ph702TC1JJE2OiYxqF5xNB46maMI6DGpgPIjGsa
         QnRQElPxsyhhgOavaW5k9RmWwTB2y2f93ksWIq9LkMs4JsUTuzMluTqlxxFIug4bg9xe
         NpMcbnZU2sPpDWSNrl0pteDJ7PkSZeTFn5SwgvLgyboKStiD2Hq7W7+XKo8uZsOIriMD
         4GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IS0JYukQ1AvM/V854xXkjA8DA3zzQrPupG56zCEbY2A=;
        b=l+veqFXlGqzbfh8MWgWXZvhF6pM42eSYaRUXd50e4s+YUSlk45gXTbQGvXH8/mqahR
         PEJI85g5bWlwYadnaxF0CYf3Hlic3DTU0WTzPYqIfxLr+9F2DqfslHOwZr5u6G9fnKtC
         X9L3CY6vKGYUMIzzqItSInBE7XuQeL5nMn+TLwaYQnWReqdD4tmtN5W6pbI7yuj3MOha
         2/OeG3B1uPD6hvsbX4ybeBoSND4+qFU2BVsufqfQKwvp/cclqzJHJkvgpN1c9BBURsr+
         h0wOC95esi7BPscRyL/gBicrNJT3bRA+kLWXwnYrN9TwxUUycOR4VWaNOPGXIkjxZCYu
         yTUQ==
X-Gm-Message-State: AOAM531XgCS5mp1wLNyrWSv8w/v0VfJwqjO9NesUPm/EKmmHrY9DFPsP
        k3A3bApm7zvU9EsTLMaZkDq6qfL0kkgeYw==
X-Google-Smtp-Source: ABdhPJyas4FuzuURUzUq8NzENbhxnd5Lfe/CyP+PE5eFl4zIzdMOtpyCqeFsb6RpJSEnBfZaBExpjg==
X-Received: by 2002:a19:dc4b:: with SMTP id f11mr328419lfj.152.1643967258337;
        Fri, 04 Feb 2022 01:34:18 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:17 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 08/10] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
Date:   Fri,  4 Feb 2022 10:33:57 +0100
Message-Id: <20220204093359.359059-9-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
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

