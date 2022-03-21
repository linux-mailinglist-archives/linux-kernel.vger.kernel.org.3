Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFDC4E272E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346888AbiCUNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347698AbiCUNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:05:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E04D11A00
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so12496094lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=Lz/FOVX26uayYZYlzmjUwm07Y9oB4oNpOrCjJWBE52iTkKbkClMbVmACvEICTzdbH1
         FNfqso+sVxYSbptKLbg4C8K6BTakUnZvgzYLzBWx9Kjkd1hZK9oS9mCBFbgw56xZkjr9
         TqUxmyD17y9Jhskz/ttkVGmQdd4OY35QBbxWs5/XM1f9ehDm/KqI4H0LqUCvDClhgY85
         NePCqzU2c42u7RWWXg/HnSBaYW6mnpEsmt89aYST9fpE4f3WWanh428wL6NzUi9CkJb6
         rH3bVYqs73DQ2PX2mEbiVf9onaLUDerSBMT0h3hKXwpPH/aDNi26tO1FY3Swe0V3km/e
         DHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=vogp+QkwFnpAoSgCryKkL+fIzfEOB9KWbNOFFXl45DCcG+Qnopt2AfcZboCAr42ebM
         QJotRkFGqiotDBOu/lJNj9nUvzG/xz4VmyTtMF0nVEeQ0Cq7kqsfTKwVrN8DMjih+1Bx
         ffbXuxkfWTIMPZOibHgwsJPVPRqOZaCvGeCu6sPiQF/okJEwJf7ptg5cz+t5ng2/Mesi
         vW59PjWWzQtq+pdbpbPIhrubv0Pqu8iEHP3VEwLP748nBg0yRthcidqN/ExQHvx8pyR6
         CDSFA0WcWUrlKHEsXlcFHxhUDZVVlqL7UZ+U1Fu22fJYKWhFvmM5J6i3YFrjY8Yfhb1m
         XGrA==
X-Gm-Message-State: AOAM531tKSONYFgGGWBZtguUt+0Pb1PO3/Wg5S82oB9QeIw8OtayB/ns
        qBtkac3UXU9TPYfTr14kzb05qfaU+3awYQ==
X-Google-Smtp-Source: ABdhPJwOG6jjG3iZ9YMHTq7TqDll1uPUiJNIBWC6llDj8cTK+LUJ+QzrO/qEQqBOlNeA2gh3xmt83w==
X-Received: by 2002:a05:6512:3c97:b0:44a:1183:bd48 with SMTP id h23-20020a0565123c9700b0044a1183bd48mr9038739lfv.525.1647867834313;
        Mon, 21 Mar 2022 06:03:54 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b00247f32b572asm2067738ljk.19.2022.03.21.06.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:03:53 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 3/4] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
Date:   Mon, 21 Mar 2022 14:03:40 +0100
Message-Id: <20220321130341.935535-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220321130341.935535-1-jens.wiklander@linaro.org>
References: <20220321130341.935535-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indicate that
OP-TEE with FF-A can support an argument struct at a non-zero offset into
a passed shared memory object.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
 drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7686f7020616..cc863aaefcd9 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 		.data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
 		.data1 = (u32)shm->sec_world_id,
 		.data2 = (u32)(shm->sec_world_id >> 32),
-		.data3 = shm->offset,
+		.data3 = 0,
 	};
 	struct optee_msg_arg *arg;
 	unsigned int rpc_arg_offs;
 	struct optee_msg_arg *rpc_arg;
 
+	/*
+	 * The shared memory object has to start on a page when passed as
+	 * an argument struct. This is also what the shm pool allocator
+	 * returns, but check this before calling secure world to catch
+	 * eventual errors early in case something changes.
+	 */
+	if (shm->offset)
+		return -EINVAL;
+
 	arg = tee_shm_get_va(shm, 0);
 	if (IS_ERR(arg))
 		return PTR_ERR(arg);
@@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    const struct ffa_dev_ops *ops,
+				    u32 *sec_caps,
 				    unsigned int *rpc_param_count)
 {
 	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
@@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 	}
 
 	*rpc_param_count = (u8)data.data1;
+	*sec_caps = data.data2;
 
 	return true;
 }
@@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	struct optee *optee;
+	u32 sec_caps;
 	int rc;
 
 	ffa_ops = ffa_dev_ops_get(ffa_dev);
@@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
 
-	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
+	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
+				     &rpc_param_count))
 		return -EINVAL;
 
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
index ee3a03fc392c..97266243deaa 100644
--- a/drivers/tee/optee/optee_ffa.h
+++ b/drivers/tee/optee/optee_ffa.h
@@ -81,8 +81,16 @@
  *                   as the second MSG arg struct for
  *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
  *        Bit[31:8]: Reserved (MBZ)
- * w5-w7: Note used (MBZ)
+ * w5:	  Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
+ *	  unused bits MBZ.
+ * w6-w7: Not used (MBZ)
+ */
+/*
+ * Secure world supports giving an offset into the argument shared memory
+ * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
  */
+#define OPTEE_FFA_SEC_CAP_ARG_OFFSET	BIT(0)
+
 #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
 
 /*
@@ -112,6 +120,8 @@
  *	  OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct optee_msg_arg
  *	  for RPC, this struct has reserved space for the number of RPC
  *	  parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITIES.
+ *	  MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is received with
+ *	  OPTEE_FFA_EXCHANGE_CAPABILITIES.
  * w7:    Not used (MBZ)
  * Resume from RPC. Register usage:
  * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
-- 
2.31.1

