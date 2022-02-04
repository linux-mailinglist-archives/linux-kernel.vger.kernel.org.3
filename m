Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9A4A96E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357629AbiBDJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346715AbiBDJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:18 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F5EC061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a28so11430524lfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5cCpSDuv/t5xo91QXmJBGTql1lRnAMifhmqKFFJLsY=;
        b=N0OHNtGfvyYbJh6Nl6pPHVf3BMgGzzZiW6GzRJhBYom3F9uEsE3B8j3SqJMRJQLrkA
         h4Mjd7DvDAVyfOJgP1zlIJqPc2FpPwyVmlKnpbHZxBKH70qYxbEK0sWRtiQZduUxkvXr
         oIJki6xPBJO2uaqUb9uqyrWSy0ndXrEQASMHgfj9K1tPWsiXJi2XHaIBlHPp2MeTslKz
         3XVdcIS1gM0XOs0MAp9b/JLOLYQEYz/GtenySUnJm4FUbkY31+bWCDvsbGkz/2XWhVmc
         ki8Vh12yPrZMhLW85Al7LkadCjsvwS5OlnBlw1sCaVHxiH4WJF4DFIXrWVwMoJ0Q6H+m
         M14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5cCpSDuv/t5xo91QXmJBGTql1lRnAMifhmqKFFJLsY=;
        b=JO8qH0LOqtcZm9b0ySGjNaRX+j0FqmEiduiaxvGzGsnMZVmzoUPmJn0twNjmitjzft
         s1dywdlXv8U9fmerDXQlm8YC9t3nzX+BSrKumPqELbfQs4mFunT5M+NTeJGSUTa88bgH
         Hwj2/XoS8wpGJm3cwO9ldb0c0O9oUJWx+GVSeHMx8oK//8pnoURvspkIG6hnhVGRbM8o
         3iGFRsZgaRu8DGgCrs1CWbnocojp9e7FY2EJq32pir01gyG9ctB536TcTUBs+6MxpAM8
         TCTP7Sk6A9QrN4jBbzlO2Uv7xtVfcse79fsoIhfPloXmUJz/cl/jHG/GG9rzPmWSl8BA
         Wt6Q==
X-Gm-Message-State: AOAM533JfEoksJ0fH8Zw9orDEyCV86gOc7ivoz8J9OhfghKaJEui3stV
        yCHKBwHZMZ1CJ1SA9S/HTPKM42TIO5F39w==
X-Google-Smtp-Source: ABdhPJzyo3dc6L2SBwh8vz1vJy95dhwgN2ZHNs0JalsSw4rbaCCLXKpk/Fixc6x9ZQDSfjXdi6ZmZQ==
X-Received: by 2002:a05:6512:10d6:: with SMTP id k22mr1766955lfg.243.1643967256168;
        Fri, 04 Feb 2022 01:34:16 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:15 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 06/10] optee: add optee_pool_op_free_helper()
Date:   Fri,  4 Feb 2022 10:33:55 +0100
Message-Id: <20220204093359.359059-7-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a common helper function to free a tee_shm allocated using the
helper function optee_pool_op_alloc_helper().

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c          | 10 ++++++++++
 drivers/tee/optee/ffa_abi.c       |  4 +---
 drivers/tee/optee/optee_private.h |  3 +++
 drivers/tee/optee/smc_abi.c       |  7 +++----
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index f4bccb5f0e93..daf947e98d14 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -69,6 +69,16 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 	return rc;
 }
 
+void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+			       int (*shm_unregister)(struct tee_context *ctx,
+						     struct tee_shm *shm))
+{
+	if (shm_unregister)
+		shm_unregister(shm->ctx, shm);
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr = NULL;
+}
+
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index bf85975c6e95..695f73becf6a 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -379,9 +379,7 @@ static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
 static void pool_ffa_op_free(struct tee_shm_pool *pool,
 			     struct tee_shm *shm)
 {
-	optee_ffa_shm_unregister(shm->ctx, shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
-	shm->kaddr = NULL;
+	optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
 }
 
 static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index df3a483bbf46..e77765c78878 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -236,6 +236,9 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						   struct page **pages,
 						   size_t num_pages,
 						   unsigned long start));
+void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+			       int (*shm_unregister)(struct tee_context *ctx,
+						     struct tee_shm *shm));
 
 
 void optee_remove_common(struct optee *optee);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 8198479d330e..0b68127a8afa 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -548,10 +548,9 @@ static void pool_op_free(struct tee_shm_pool *pool,
 			 struct tee_shm *shm)
 {
 	if (!(shm->flags & TEE_SHM_PRIV))
-		optee_shm_unregister(shm->ctx, shm);
-
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
-	shm->kaddr = NULL;
+		optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
+	else
+		optee_pool_op_free_helper(pool, shm, NULL);
 }
 
 static void pool_op_destroy_pool(struct tee_shm_pool *pool)
-- 
2.31.1

