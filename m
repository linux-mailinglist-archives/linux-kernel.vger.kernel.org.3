Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA994FEEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiDMFrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiDMFq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:46:57 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428202708
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:44:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so882523ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=rU2AzZuJAp1JfGXOemwV55qQxLH91Hle7zcjeugWvEydD6koOJpUdTS9mbg+7HJott
         DmWB/17z9XvJjvBTm9t33zQVNS1dc/APsukVytXI87b6JGGPrBPZpF7e4HfndvX4hh3V
         V7AdCang6aSJ/6v/qfeu1BIY2nKvD+PyiGKic0Q1/uFc39IZ0Yyey8uIXMVbrjoAooBx
         rrKMWzzNmCEnKNOA+QDqrDNbT6gasa8zPu1UFTII5H5cF8d0tnb/v9uUWwHunXJJQ3Js
         P6xyLlI6kf8x37/mTNPYJS6lRprnidnJfejxeXbv8VL9WMFpjDA1fdUHXJEdOzdqR0e4
         mt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=u94ZKUoPTAHYa0r5fJE1Yj+X9I/48D+Qu5yvNBCOTgMnYXizeJyA2bTkaXu0g9o0b3
         M/RaCKKFfltj0TBYcrM1nQb2DaQHJ0vdyV9Y2MMMJrBSQViIct9j3ypVU4uF113fGnxJ
         ZkBY8JtQc2pK8gg23VKaa8cHLA5qn0C2/EivtrHtmYcSThZZv93U64Sb413001uHTMdT
         JGzI0WiVX2wAOvIcul2z5R2byJDxr/NWg3I3hA8pvTFqM3A9b1rZfd1aZQkaPXs4d70s
         bfNcieCr7inM1KSQ3DZkTWr7SxL1fJ+0YylbT0Kr/DsZlGl+4YPIsPinzzl+JoYH1ffl
         JxLg==
X-Gm-Message-State: AOAM531Fq3px+MDCXUpt7JzQttvbuYEeFZDHOfiM9o+IpQvlXjs29iDp
        ug+Hm5EGOCGYZoYioYrUaLITGWchDTwh7Q==
X-Google-Smtp-Source: ABdhPJyVD6VDw+a4kTmHcoyJaG4kEavKbFleUM867bPMK4dNmQIY8XXEA0SZ9vZXdnx4jdbvi36Feg==
X-Received: by 2002:a2e:9089:0:b0:24b:5d12:18cc with SMTP id l9-20020a2e9089000000b0024b5d1218ccmr11304160ljg.105.1649828674970;
        Tue, 12 Apr 2022 22:44:34 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24357000000b0044adb34b68csm3919835lfl.32.2022.04.12.22.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:44:34 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 3/4] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
Date:   Wed, 13 Apr 2022 07:44:17 +0200
Message-Id: <20220413054418.71996-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220413054418.71996-1-jens.wiklander@linaro.org>
References: <20220413054418.71996-1-jens.wiklander@linaro.org>
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

