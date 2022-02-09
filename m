Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3826A4AEEF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiBIKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiBIKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:07:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6594CE083C49
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:06:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n23so3448922pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvVIJL7G+MoVaAaTQbJAgUmCSIup6bzWE2y/T2o5dIc=;
        b=rsbsPZfQMI3NPYmG/P6BTvfC3qiGBICF8ZXe5GTx794yLnoYnv4qeKnGJuiurXxAnY
         sJwwpzp7jWwm5VgjzOR2De8ZoMlDekmId51nnX0qFXn+DsskhHWNZLXvr4lwyIzqqsSH
         k6WhOHr6CjGZntMuRZmpgm13RIUD7Pe/zadXTsS82nayrX9bf+fqEy2hjHH7gaqMHm2p
         LgRo5ebNkjUf3FJkTbsa8bGOcw+/LDMdu4kBAr9lIxw5aGWnDGWnA2Ey6oH+4amvVOdD
         6WjgcXAOf/4Vg1jv5HQMA4RJPgWjnP/lXw+O6SqH7Bu+tDFSxsaM9QKRIJDR6XYMihDz
         orVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvVIJL7G+MoVaAaTQbJAgUmCSIup6bzWE2y/T2o5dIc=;
        b=PqbIHF4dpvpES+lp+XcTJ7+ENrrGugeODnKBADJLcRzcSzxB9SOBNqLy16gBvb+RRE
         Za/xeff6kL6H+ziZow8af/RkM4S7nbz7sOXYzhgkZByxOQ+gBJ8s/0+HQxb8foRVPwje
         nDgAszKdiDqa2aoctjsVXxgqY3942aOJG3zxnPjpwb1diddRs/6f4CwORfseyka5IMKa
         ZFsrixnUqPrmqB0xECyD+XPg38iBu6Aoh7PVVnoOfK9Vhhu/TmyGFlPq64DrpQiEvjNs
         f8gtU8qU84xaRHZDaWbf3rIXUQCEAtVR2V/LRxpdqa2EXNx/Y5cFoKwhF4XBC03SzPgs
         T3BA==
X-Gm-Message-State: AOAM532NOvi7B34d1tuFIaWEoe2qnb1T3I5Z1fTyZwsozulpnwcCGHEy
        CJhFw3zU81PJwTG6hDOfirAx
X-Google-Smtp-Source: ABdhPJw4dLxlOBb+w72LT1Jc2+IJXgpYPyOqGNlInW8RMtJjIkcawRYa45tkS3JhtXdQ4Ee8nFkB2g==
X-Received: by 2002:a63:8842:: with SMTP id l63mr1259518pgd.421.1644401184543;
        Wed, 09 Feb 2022 02:06:24 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/23] bus: mhi: ep: Add support for sending events to the host
Date:   Wed,  9 Feb 2022 15:26:14 +0530
Message-Id: <20220209095624.26389-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
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

Add support for sending the events to the host over MHI bus from the
endpoint. Following events are supported:

1. Transfer completion event
2. Command completion event
3. State change event
4. Execution Environment (EE) change event

An event is sent whenever an operation has been completed in the MHI EP
device. Event is sent using the MHI event ring and additionally the host
is notified using an IRQ if required.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/common.h      |  15 ++++
 drivers/bus/mhi/ep/internal.h |   8 ++-
 drivers/bus/mhi/ep/main.c     | 126 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |   8 +++
 4 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index 89b2ba8c8305..c180ba981c9e 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -176,6 +176,21 @@
 #define MHI_TRE_GET_EV_LINKSPEED(tre)			((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
 #define MHI_TRE_GET_EV_LINKWIDTH(tre)			(MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
 
+/* State change event */
+#define MHI_SC_EV_PTR					0
+#define MHI_SC_EV_DWORD0(state)				cpu_to_le32(state << 24)
+#define MHI_SC_EV_DWORD1(type)				cpu_to_le32(type << 16)
+
+/* EE event */
+#define MHI_EE_EV_PTR					0
+#define MHI_EE_EV_DWORD0(ee)				cpu_to_le32(ee << 24)
+#define MHI_EE_EV_DWORD1(type)				cpu_to_le32(type << 16)
+
+/* Command Completion event */
+#define MHI_CC_EV_PTR(ptr)				cpu_to_le64(ptr)
+#define MHI_CC_EV_DWORD0(code)				cpu_to_le32(code << 24)
+#define MHI_CC_EV_DWORD1(type)				cpu_to_le32(type << 16)
+
 /* Transfer descriptor macros */
 #define MHI_TRE_DATA_PTR(ptr)				cpu_to_le64(ptr)
 #define MHI_TRE_DATA_DWORD0(len)			cpu_to_le32(len & MHI_MAX_MTU)
diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 48d6e9667d55..fd63f79c6aec 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -131,8 +131,8 @@ enum mhi_ep_ring_type {
 };
 
 struct mhi_ep_ring_element {
-	u64 ptr;
-	u32 dword[2];
+	__le64 ptr;
+	__le32 dword[2];
 };
 
 /* Ring element */
@@ -227,4 +227,8 @@ void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *s
 void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
 void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
 
+/* MHI EP core functions */
+int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
+int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ep_execenv exec_env);
+
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index f907f76aa1f2..1bf46d33f3c3 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -18,6 +18,131 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
+			     struct mhi_ep_ring_element *el)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	union mhi_ep_ring_ctx *ctx;
+	struct mhi_ep_ring *ring;
+	int ret;
+
+	mutex_lock(&mhi_cntrl->event_lock);
+	ring = &mhi_cntrl->mhi_event[ring_idx].ring;
+	ctx = (union mhi_ep_ring_ctx *)&mhi_cntrl->ev_ctx_cache[ring_idx];
+	if (!ring->started) {
+		ret = mhi_ep_ring_start(mhi_cntrl, ring, ctx);
+		if (ret) {
+			dev_err(dev, "Error starting event ring (%d)\n", ring_idx);
+			goto err_unlock;
+		}
+	}
+
+	/* Add element to the event ring */
+	ret = mhi_ep_ring_add_element(ring, el);
+	if (ret) {
+		dev_err(dev, "Error adding element to event ring (%d)\n", ring_idx);
+		goto err_unlock;
+	}
+
+	/* Ensure that the ring pointer gets updated in host memory before triggering IRQ */
+	smp_wmb();
+
+	mutex_unlock(&mhi_cntrl->event_lock);
+
+	/*
+	 * Raise IRQ to host only if the BEI flag is not set in TRE. Host might
+	 * set this flag for interrupt moderation as per MHI protocol.
+	 */
+	if (!MHI_EP_TRE_GET_BEI(el))
+		mhi_cntrl->raise_irq(mhi_cntrl, ring->irq_vector);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&mhi_cntrl->event_lock);
+
+	return ret;
+}
+
+static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl,
+					struct mhi_ep_ring *ring, u32 len,
+					enum mhi_ev_ccs code)
+{
+	struct mhi_ep_ring_element event = {};
+	__le32 tmp;
+
+	event.ptr = le64_to_cpu(ring->ring_ctx->generic.rbase) +
+			ring->rd_offset * sizeof(struct mhi_ep_ring_element);
+
+	tmp = event.dword[0];
+	tmp |= MHI_TRE_EV_DWORD0(code, len);
+	event.dword[0] = tmp;
+
+	tmp = event.dword[1];
+	tmp |= MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
+	event.dword[1] = tmp;
+
+	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event);
+}
+
+int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
+{
+	struct mhi_ep_ring_element event = {};
+	__le32 tmp;
+
+	tmp = event.dword[0];
+	tmp |= MHI_SC_EV_DWORD0(state);
+	event.dword[0] = tmp;
+
+	tmp = event.dword[1];
+	tmp |= MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
+	event.dword[1] = tmp;
+
+	return mhi_ep_send_event(mhi_cntrl, 0, &event);
+}
+
+int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ep_execenv exec_env)
+{
+	struct mhi_ep_ring_element event = {};
+	__le32 tmp;
+
+	tmp = event.dword[0];
+	tmp |= MHI_EE_EV_DWORD0(exec_env);
+	event.dword[0] = tmp;
+
+	tmp = event.dword[1];
+	tmp |= MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
+	event.dword[1] = tmp;
+
+	return mhi_ep_send_event(mhi_cntrl, 0, &event);
+}
+
+static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring_element event = {};
+	__le32 tmp;
+
+	if (code > MHI_EV_CC_BAD_TRE) {
+		dev_err(dev, "Invalid command completion code (%d)\n", code);
+		return -EINVAL;
+	}
+
+	event.ptr = le64_to_cpu(mhi_cntrl->cmd_ctx_cache->rbase)
+			+ (mhi_cntrl->mhi_cmd->ring.rd_offset *
+			(sizeof(struct mhi_ep_ring_element)));
+
+	tmp = event.dword[0];
+	tmp |= MHI_CC_EV_DWORD0(code);
+	event.dword[0] = tmp;
+
+	tmp = event.dword[1];
+	tmp |= MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
+	event.dword[1] = tmp;
+
+	return mhi_ep_send_event(mhi_cntrl, 0, &event);
+}
+
 static void mhi_ep_ring_worker(struct work_struct *work)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
@@ -269,6 +394,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
 	spin_lock_init(&mhi_cntrl->list_lock);
+	mutex_init(&mhi_cntrl->event_lock);
 
 	/* Set MHI version and AMSS EE before enumeration */
 	mhi_ep_mmio_write(mhi_cntrl, MHIVER, config->mhi_version);
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 33828a6c4e63..062133a68118 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -59,6 +59,9 @@ struct mhi_ep_db_info {
  * @mhi_event: Points to the event ring configurations table
  * @mhi_cmd: Points to the command ring configurations table
  * @sm: MHI Endpoint state machine
+ * @ch_ctx_cache: Cache of host channel context data structure
+ * @ev_ctx_cache: Cache of host event context data structure
+ * @cmd_ctx_cache: Cache of host command context data structure
  * @ch_ctx_host_pa: Physical address of host channel context data structure
  * @ev_ctx_host_pa: Physical address of host event context data structure
  * @cmd_ctx_host_pa: Physical address of host command context data structure
@@ -67,6 +70,7 @@ struct mhi_ep_db_info {
  * @ch_db_list: List of queued channel doorbells
  * @st_transition_list: List of state transitions
  * @list_lock: Lock for protecting state transition and channel doorbell lists
+ * @event_lock: Lock for protecting event rings
  * @chdb: Array of channel doorbell interrupt info
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_addr: CB function for allocating memory in endpoint for storing host context
@@ -94,6 +98,9 @@ struct mhi_ep_cntrl {
 	struct mhi_ep_cmd *mhi_cmd;
 	struct mhi_ep_sm *sm;
 
+	struct mhi_chan_ctxt *ch_ctx_cache;
+	struct mhi_event_ctxt *ev_ctx_cache;
+	struct mhi_cmd_ctxt *cmd_ctx_cache;
 	u64 ch_ctx_host_pa;
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
@@ -104,6 +111,7 @@ struct mhi_ep_cntrl {
 	struct list_head ch_db_list;
 	struct list_head st_transition_list;
 	spinlock_t list_lock;
+	struct mutex event_lock;
 	struct mhi_ep_db_info chdb[4];
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
-- 
2.25.1

