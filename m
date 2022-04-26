Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8B50F292
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiDZHhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbiDZHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:36:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8A81331AD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n14so9653946lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=WP7sqDZ48rEv4cSxiRTawe+56Tc6xRmz/UeackTd98EFc1XhED+zkuowlnNnhyF4Yt
         e8346QfOghWfxKAsRZ88R+ruPw71rUOVqpEUe0iq44nTtX2CwgfpAPuEMvGp2cQqDCkT
         jx6W290Lrph+qu3d43vIPujkfVCeccWyI7do7aHK2l3XWWQNDVpQKjyYn7DKCdqG1Yth
         +PKC0AcwA9RzaZaB2gt1XeLaYwTOlpXvqTShi6ydjuAs1NoXQ+tY/WCWoPBK4pf+9K+M
         iNKVmnJhZ/C1DS0kYdNJj+11WvXAlX1eZETZ4cJIh4VUScczAYnST3BkGxkPP/v2IxYd
         /aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0z57MDTx8X/SyhgQAkhX31Rs5nhmqitrzVboECbkLA=;
        b=iwmKWKIAJyXCnB9bZk0+0Nvh12oic4b3SLzpMjuBAaNoidiPacJ8o5qwla1HzDjUsR
         4DtoS/8ij20dpSbJbnF0iT4rYcjYKSOuU39YgrN3Xb4UUUruDycklkOEvcuOSxW0CMSt
         WXdjhv/PTJadC1Dnmfdyv0dwW7qhJZsyUYL0+BH2CPkVHjYl8rwQzJcoeAlsKJ72HUEi
         szBNCLfku3kU4J09ebFd3QdOMOVG4ZO59AcE8Fvru+LbGDrKjbV1lpK6Zh+6PjP3M9z2
         rhchLrehCemud52A2UBJqp89CRR7V0X2+puwJv191kKUzUhShxLFz+v6DGXHgxh7F8Xl
         VvcA==
X-Gm-Message-State: AOAM533jbWSKZg0iotaWu0QemDJ1u9A9ifLb2TEbOdSeOMtkEoLExzBa
        Ki+8WkBDt/850LSbUPqqt9xLd9z95tkmPg==
X-Google-Smtp-Source: ABdhPJxUi1qWTQu0+2nmb1rDZMm0oMG+mPhs1iILA/YVf9MpPFQfHjTiSkp33Cpo2lt00ZofPq8djA==
X-Received: by 2002:a05:6512:260e:b0:44a:fa3e:f77b with SMTP id bt14-20020a056512260e00b0044afa3ef77bmr15334948lfb.175.1650958425635;
        Tue, 26 Apr 2022 00:33:45 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm1430491lji.116.2022.04.26.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:33:44 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 3/4] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
Date:   Tue, 26 Apr 2022 09:33:37 +0200
Message-Id: <20220426073338.3048192-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220426073338.3048192-1-jens.wiklander@linaro.org>
References: <20220426073338.3048192-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

