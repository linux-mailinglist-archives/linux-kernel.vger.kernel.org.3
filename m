Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9048EC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbiANPJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbiANPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C458AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b14so12738648lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+PMrt9ZoFFUyS+nI8cuBydf4l/fJgxfwN4fEj0TGMU=;
        b=lzW8KWNoC1fqc7SLWfi4NlHlo4piN1ZDgKk2ofcWfVdLPQ2kIaUFYEvGPHI3gowT6E
         13RCNdmP7OKfdix2j61FC129j/LIGiSpc5HHvQpRE47x/GEvx0QjB7Z1v2/463iz5G3O
         ZXZBcht1c8rYbiJHJScCXvSf1D7x/IuPbikVm6yboktWlyGKY/LVUQWDRM7GUewbPsbK
         F4/Yl5XhZWfofuVVACdLi5heb0iPMOrltKZjKhtDbBbM/sMUbPMZ5Js3sVPp1ufGXTg/
         8eC+ktqhOG3mi7+UqQZPyCx/lOGxJjr6RALVDKVQ1FZB2eNP3nXZDSZRM4RR8uEkzcgR
         Zo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+PMrt9ZoFFUyS+nI8cuBydf4l/fJgxfwN4fEj0TGMU=;
        b=DCxZT+omLDxls9SlKFXd9GCNBPrz+gxE6vTkc2GNTIUaupPynIoINsDSjRDL6DtJ+l
         a1dAKqRdzcjvMAC73fYfV+Cs3uNdAYO9G+IpAs0RQYjAYMCKuqg2TXBYC4GgD9xDaSsy
         o3DNqd5/b/rFMUh8qgpojbl38Tg+Y8BN5MJhC3Aof3etckKQVQ6Grn29XZzJ0welfVX2
         zd/ErVtUDWeY1puCoJKzurk0zPZ/8lVKDxdCWWFGWV9fSWpOFv2hdmrKO2I3LSpsow6L
         hGSW+4VXio7VzOd1K8tYRkaNX1m5FWTYmPXPGy5ASsZmMjSmHCn7CoIRtwnpSx2YoFk2
         2q3w==
X-Gm-Message-State: AOAM533t3lHCpAQ0XJiD7BjiKcUrtcE6aFs0M94tBIKlIF6gdNXpYqaX
        qtrd6xgkQwYo/sJZupymnY4V+65zc+T+mQ==
X-Google-Smtp-Source: ABdhPJw4fN0F/Y5WwdJ22CSUtFiug4nes1etBlslC/SO1RTgBbbw6W4pXxWHWNGQhD34PYFAyPSTVg==
X-Received: by 2002:a2e:9bcd:: with SMTP id w13mr6721364ljj.360.1642172925879;
        Fri, 14 Jan 2022 07:08:45 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:45 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 08/12] optee: add optee_pool_op_free_helper()
Date:   Fri, 14 Jan 2022 16:08:20 +0100
Message-Id: <20220114150824.3578829-9-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a common helper function to free a tee_shm allocated using the
helper function optee_pool_op_alloc_helper().

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
index 5ec484b42432..4cbc45035f92 100644
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
index f2ef76451443..0b27688d1e97 100644
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

