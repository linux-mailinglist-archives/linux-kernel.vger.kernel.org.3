Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8655099AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386226AbiDUHwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386243AbiDUHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:52:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE2658D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:49:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g18so5411913wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DFQKe1n95vI0XDB784IqHRLfSSbnFgC1EIy7oNGC7HE=;
        b=TPvTpgTblTkQC4CQr/PPJSInoi8or8385/pljejfBQu45ClwM9mXAjrsVm8xVtAJLx
         iiYUxBiMCrsvFwO099irTD/nB3f5/aIueOwnrgdrq9aAENBXHIjzNxe7wTi8qu6GhzUO
         N6HNtSGgRBnGyIie4ZEwaML0+FxU0qdkljDSHa9u4vfnNv+oFxM3gnoa4mfgREZH3QST
         sVM/xmjCvMGSVXQoM9be6N6F4nA+JCaZXGRh1sUoM2dKvJM01aRJx+s6kqVfLb3gJ5ER
         mQ1O2cq8E3dVBNdBHd6Xtpk78JgjwRBBEuSekAh301/YCurPn4T/aZpp8QdsWCopVjvp
         H71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DFQKe1n95vI0XDB784IqHRLfSSbnFgC1EIy7oNGC7HE=;
        b=UNVjBf+hVUsOggZAUQ+Z1hCbc2JmbqEIsQSwKWnPB4EAfX1pS37ytRBr36v+pXbL3E
         EnMPycjY1CEBLxxtnK09bScevFbjFrcjpWm9aaCaZil4lwehvzH3pCbZ03uLRSiwfjkz
         f2EXZSGCFVtzG9fKPXlpZ/sCu8I7LffEje6T5NkjMx23T4cvFA6JwgOAquQut3UNYxSh
         F+hYaNWogtxBgI+R0pvuU5JKiveLB+tgNmhNxQ/QSX/w/aI+Ktq3AHeMkiDJS+RME1nh
         nrjazZRNssJfng8cS/iF88T+DGWv2wK00EZmZwyDfiLYWgnisH2bK56HO6KQ6c9iRxnZ
         KDTw==
X-Gm-Message-State: AOAM533LWNclxrFFceltUDWjGKM4tt9zGwALm7HwuVlBY96nYR6hoJOu
        dfyfM+kClYH53nnSJNEeCxDNvc8RF2DopQP7
X-Google-Smtp-Source: ABdhPJynJf3SAwQDgUkdKPv1dpmaB5+nxjc816woxhjRa5rnntQO48wq/wGPWZSwAeU6RU3V7GkvCA==
X-Received: by 2002:a5d:60d2:0:b0:20a:8591:9a28 with SMTP id x18-20020a5d60d2000000b0020a85919a28mr17999178wrt.553.1650527379404;
        Thu, 21 Apr 2022 00:49:39 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:11d9:822a:59f9:7282:b43a:bacc])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm1541767wmq.40.2022.04.21.00.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 00:49:39 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2] firmware: arm_scmi: support optee shared memory in optee transport
Date:   Thu, 21 Apr 2022 09:49:35 +0200
Message-Id: <20220421074935.7549-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for tee shared memory in optee scmi transport. When using
tee shared memory, scmi optee transport manages SCMI messages using
msg protocol (from msg.c) in shared memory, whereas smt (from shmem.c)
protocol is used with static IOMEM shared buffers.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_scmi/optee.c | 128 ++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 8302a2b4aeeb..6676b17d2587 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -64,6 +64,22 @@ enum scmi_optee_pta_cmd {
 	 * [in]     value[0].b: Requested capabilities mask (enum pta_scmi_caps)
 	 */
 	PTA_SCMI_CMD_GET_CHANNEL = 3,
+
+	/*
+	 * PTA_SCMI_CMD_PROCESS_MSG_CHANNEL - Process SCMI message in a MSG
+	 * buffer pointed by memref parameters
+	 *
+	 * [in]     value[0].a: Channel handle
+	 * [in]     memref[1]: Message buffer (MSG and SCMI payload)
+	 * [out]    memref[2]: Response buffer (MSG and SCMI payload)
+	 *
+	 * Shared memories used for SCMI message/response are MSG buffers
+	 * referenced by param[1] and param[2]. MSG transport protocol
+	 * uses a 32bit header to carry SCMI meta-data (protocol ID and
+	 * protocol message ID) followed by the effective SCMI message
+	 * payload.
+	 */
+	PTA_SCMI_CMD_PROCESS_MSG_CHANNEL = 4,
 };
 
 /*
@@ -72,9 +88,17 @@ enum scmi_optee_pta_cmd {
  * PTA_SCMI_CAPS_SMT_HEADER
  * When set, OP-TEE supports command using SMT header protocol (SCMI shmem) in
  * shared memory buffers to carry SCMI protocol synchronisation information.
+ *
+ * PTA_SCMI_CAPS_MSG_HEADER
+ * When set, OP-TEE supports command using MSG header protocol in an OP-TEE
+ * shared memory to carry SCMI protocol synchronisation information and SCMI
+ * message payload.
  */
 #define PTA_SCMI_CAPS_NONE		0
 #define PTA_SCMI_CAPS_SMT_HEADER	BIT(0)
+#define PTA_SCMI_CAPS_MSG_HEADER	BIT(1)
+#define PTA_SCMI_CAPS_MASK		(PTA_SCMI_CAPS_SMT_HEADER | \
+					 PTA_SCMI_CAPS_MSG_HEADER)
 
 /**
  * struct scmi_optee_channel - Description of an OP-TEE SCMI channel
@@ -85,7 +109,8 @@ enum scmi_optee_pta_cmd {
  * @mu: Mutex protection on channel access
  * @cinfo: SCMI channel information
  * @shmem: Virtual base address of the shared memory
- * @tee_shm: Reference to TEE shared memory or NULL if using static shmem
+ * @req: Shared memory protocol handle for SCMI request and synchronous response
+ * @tee_shm: TEE shared memory handle @req or NULL if using IOMEM shmem
  * @link: Reference in agent's channel list
  */
 struct scmi_optee_channel {
@@ -94,7 +119,10 @@ struct scmi_optee_channel {
 	u32 caps;
 	struct mutex mu;
 	struct scmi_chan_info *cinfo;
-	struct scmi_shared_mem __iomem *shmem;
+	union {
+		struct scmi_shared_mem __iomem *shmem;
+		struct scmi_msg_payld *msg;
+	} req;
 	struct tee_shm *tee_shm;
 	struct list_head link;
 };
@@ -178,8 +206,8 @@ static int get_capabilities(struct scmi_optee_agent *agent)
 
 	caps = param[0].u.value.a;
 
-	if (!(caps & PTA_SCMI_CAPS_SMT_HEADER)) {
-		dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT\n");
+	if (!(caps & (PTA_SCMI_CAPS_SMT_HEADER | PTA_SCMI_CAPS_MSG_HEADER))) {
+		dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT and MSG\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -193,9 +221,14 @@ static int get_channel(struct scmi_optee_channel *channel)
 	struct device *dev = scmi_optee_private->dev;
 	struct tee_ioctl_invoke_arg arg = { };
 	struct tee_param param[1] = { };
-	unsigned int caps = PTA_SCMI_CAPS_SMT_HEADER;
+	unsigned int caps = 0;
 	int ret;
 
+	if (channel->tee_shm)
+		caps = PTA_SCMI_CAPS_MSG_HEADER;
+	else
+		caps = PTA_SCMI_CAPS_SMT_HEADER;
+
 	arg.func = PTA_SCMI_CMD_GET_CHANNEL;
 	arg.session = channel->tee_session;
 	arg.num_params = 1;
@@ -249,6 +282,37 @@ static int invoke_process_smt_channel(struct scmi_optee_channel *channel)
 	return 0;
 }
 
+static int invoke_process_msg_channel(struct scmi_optee_channel *channel, size_t msg_size)
+{
+	struct tee_ioctl_invoke_arg arg = {
+		.func = PTA_SCMI_CMD_PROCESS_MSG_CHANNEL,
+		.session = channel->tee_session,
+		.num_params = 3,
+	};
+	struct tee_param param[3] = { };
+	int ret;
+
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a = channel->channel_id;
+
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[1].u.memref.shm = channel->tee_shm;
+	param[1].u.memref.size = msg_size;
+
+	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[2].u.memref.shm = channel->tee_shm;
+	param[2].u.memref.size = SCMI_OPTEE_MAX_MSG_SIZE;
+
+	ret = tee_client_invoke_func(scmi_optee_private->tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret) {
+		dev_err(scmi_optee_private->dev, "Can't invoke channel %u: %d / %#x\n",
+			channel->channel_id, ret, arg.ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int scmi_optee_link_supplier(struct device *dev)
 {
 	if (!scmi_optee_private) {
@@ -279,7 +343,26 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
-	shmem_clear_channel(channel->shmem);
+	if (!channel->tee_shm)
+		shmem_clear_channel(channel->req.shmem);
+}
+
+static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
+{
+	const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
+	void *shbuf;
+
+	channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
+	if (IS_ERR(channel->tee_shm)) {
+		dev_err(channel->cinfo->dev, "shmem allocation failed\n");
+		return -ENOMEM;
+	}
+
+	shbuf = tee_shm_get_va(channel->tee_shm, 0);
+	memset(shbuf, 0, msg_size);
+	channel->req.msg = shbuf;
+
+	return 0;
 }
 
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
@@ -304,8 +387,8 @@ static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 
 	size = resource_size(&res);
 
-	channel->shmem = devm_ioremap(dev, res.start, size);
-	if (!channel->shmem) {
+	channel->req.shmem = devm_ioremap(dev, res.start, size);
+	if (!channel->req.shmem) {
 		dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n");
 		ret = -EADDRNOTAVAIL;
 		goto out;
@@ -325,7 +408,7 @@ static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 	if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
 		return setup_static_shmem(dev, cinfo, channel);
 	else
-		return -ENOMEM;
+		return setup_dynamic_shmem(dev, channel);
 }
 
 static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
@@ -405,27 +488,22 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 	return 0;
 }
 
-static struct scmi_shared_mem __iomem *
-get_channel_shm(struct scmi_optee_channel *chan, struct scmi_xfer *xfer)
-{
-	if (!chan)
-		return NULL;
-
-	return chan->shmem;
-}
-
-
 static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 				   struct scmi_xfer *xfer)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
-	struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
 	int ret;
 
 	mutex_lock(&channel->mu);
-	shmem_tx_prepare(shmem, xfer);
 
-	ret = invoke_process_smt_channel(channel);
+	if (channel->tee_shm) {
+		msg_tx_prepare(channel->req.msg, xfer);
+		ret = invoke_process_msg_channel(channel, msg_command_size(xfer));
+	} else {
+		shmem_tx_prepare(channel->req.shmem, xfer);
+		ret = invoke_process_smt_channel(channel);
+	}
+
 	if (ret)
 		mutex_unlock(&channel->mu);
 
@@ -436,9 +514,11 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 				      struct scmi_xfer *xfer)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
-	struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
 
-	shmem_fetch_response(shmem, xfer);
+	if (channel->tee_shm)
+		msg_fetch_response(channel->req.msg, SCMI_OPTEE_MAX_MSG_SIZE, xfer);
+	else
+		shmem_fetch_response(channel->req.shmem, xfer);
 }
 
 static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
-- 
2.17.1

