Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E94C9504
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiCATuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiCATuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73D574AF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:49:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b9so28720508lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=PVRCG9oFJDwF/WWH/5Izi8XDXDv7qgaHhDEgJdmVnzGRebSVDhOyafp/QBhJAJHu9i
         G0jVzUkQFaMvYg8t6FAr11digKQLsrIeL1SBjNev4n0b0eujylAnz/jysWW6AwJEHm9o
         s3oDMNFv7OuV7x+gHtCNiw6pVTZUAeZWw+JV+slg5fQIzUSc+v6FBMBPccqtBxi67Vis
         pXkpbZztaiwMvMoTPcg+UJYBf+1QyNh0u2HY6YpqakdpfbKNYyJDXHPGixbko8DQkvCM
         zoKMGx9+Qg/OMceGozNr3yrW58cJ18ETPkGpwDawIBHC8p5jwOxACbHMyWsFdPh571nD
         VEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=vSlRbf0M3GYMUypMGQzPjPAuKenFjfw44amCjP9LeyLtY0gb+PGothV8tYDexdTurF
         PkDAJ3s+9hJ6XhyrVN7zJRxKbPGicwU7uQ+0xsDMrhhVLux8FXWck9kshnjFk6kp0inV
         M7YwDfnCyCNUEVFKxThHB0XjZSPaCNmUWfW/mJs0JAv5G1Sd5c9yfgZmddBTM3FFY+y+
         eAqOzcq3mjh46utFTiyQTii1eO/r0zc9p+wfGJZZcS/25Lpp2WU19R6vqerhwVIa9ULq
         WwShqfWtwVvnm5JcAdCCLnzwRIjN33qR4BIGCQqnXF4B4cDZ9ICQ35Oxra/WMQz4pIt/
         jyZQ==
X-Gm-Message-State: AOAM533hMbS4WgTtqXR7QzDGc8YfCN3KyWhtNszSDa8pi35UXdkno2Bn
        SJemuD9+mSx4NcWsue5PtOhOpRG+1zM3Og==
X-Google-Smtp-Source: ABdhPJwgGzYYyDAeYY2XwQYnqn0Lxos+HPH3kYg+I1qAm/dWdyRYiLvuGvgfXd0m6L3kEtfaJ/pKtg==
X-Received: by 2002:a05:6512:3619:b0:443:1597:8293 with SMTP id f25-20020a056512361900b0044315978293mr16625242lfs.439.1646164115757;
        Tue, 01 Mar 2022 11:48:35 -0800 (PST)
Received: from jade.urgonet (h-176-10-238-36.A175.priv.bahnhof.se. [176.10.238.36])
        by smtp.gmail.com with ESMTPSA id m2-20020a196142000000b00443d65ea163sm1635891lfk.248.2022.03.01.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:35 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 2/3] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
Date:   Tue,  1 Mar 2022 20:48:29 +0100
Message-Id: <20220301194830.3557578-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220301194830.3557578-1-jens.wiklander@linaro.org>
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
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

