Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1034C6D00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiB1Mqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiB1MqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:14 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11A76E38
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 132so11271555pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZep28DhIdqNfp5J0eB33gO8gDlbZ2SZXLI7+YnFIhM=;
        b=WPu8k+dZJe8z8MeH8JjrfcoT59S/UDfwx98X+IWC7XEpr2XNjSBeV85wy5Y+oJNr4z
         yr0bnjDP2RUYqSoIlBuFt+HAmCOglq0dm/iq0OmAWUHyTCFpiBzwFBdhGq+F6frjRfho
         3iyv1+jevOwPT8D3cnZdCsO/kslUudma+3SXR5w0bQRuzqqPsfQaEIxmzIPrifdR0xUq
         jnk56nd2xsQVvgKbbS0Hrx0AAvxiHBhewsCK+qBpkTFiCIva152SOBJDwxc0nKOQelrD
         P5O0R9BQF/5yoGIa+wK9iekaxVgeUYCSxUsMIqNd6YY3+eXbG4NZQ4pNrOUgGEiuH9aj
         UQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZep28DhIdqNfp5J0eB33gO8gDlbZ2SZXLI7+YnFIhM=;
        b=h5gcMuIiioymxGHKCDwoR9Y+u21XXlX98bRNaz0iHF9zlueYX44Ft12SA85mq6XFEG
         XwW5aFJiOXQEgAVxeYUrT8dB0VRU4ojdW0M8ruCvpFf1ktyrAFSXpvtVc4Xd2vvw/+KL
         wUf4FWAcH+3IHOnHYFPvdlV5oJJUMvtYCKFfEDVclvpIsYrniroUMiGAaCs+iE2+5BeP
         rcC+owhGLxc4gvTSopoZWZBHsMf3yfCB0TDLguCJIJYhMS4qkQXQvfitrlfYiD1GUBUg
         4GrMqCID8SEAwGmOUoUPEHxJVsi7DaEAZDUOEhntx5RvbZMcyILg0qNdvhs/IZbzXVWI
         pAjQ==
X-Gm-Message-State: AOAM530KqcmA5+qAudmYP990ZKHYLxWbjMJ9D9uIAiMQE1qzSILcM4kM
        2D+ourxT6gbbxw9UV3/j6oFo
X-Google-Smtp-Source: ABdhPJxndLbOp3LP+7nUx5QdEZPg44A4JMetsCaOc6fbLOuPvRrNcq38XJH01Lkbm9LtfA9AkQ+WmQ==
X-Received: by 2002:a05:6a00:b92:b0:4f1:4b2:737f with SMTP id g18-20020a056a000b9200b004f104b2737fmr21511709pfj.31.1646052318829;
        Mon, 28 Feb 2022 04:45:18 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:45:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 15/27] bus: mhi: ep: Add support for sending events to the host
Date:   Mon, 28 Feb 2022 18:13:32 +0530
Message-Id: <20220228124344.77359-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/bus/mhi/common.h      | 22 +++++++++
 drivers/bus/mhi/ep/internal.h |  4 ++
 drivers/bus/mhi/ep/main.c     | 90 +++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  8 ++++
 4 files changed, 124 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index ec75ba1e6686..5b30e2d0832e 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -165,6 +165,22 @@
 #define MHI_TRE_GET_EV_LINKSPEED(tre)	FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1)))
 #define MHI_TRE_GET_EV_LINKWIDTH(tre)	FIELD_GET(GENMASK(7, 0), (MHI_TRE_GET_DWORD(tre, 0)))
 
+/* State change event */
+#define MHI_SC_EV_PTR			0
+#define MHI_SC_EV_DWORD0(state)		cpu_to_le32(FIELD_PREP(GENMASK(31, 24), state))
+#define MHI_SC_EV_DWORD1(type)		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), type))
+
+/* EE event */
+#define MHI_EE_EV_PTR			0
+#define MHI_EE_EV_DWORD0(ee)		cpu_to_le32(FIELD_PREP(GENMASK(31, 24), ee))
+#define MHI_EE_EV_DWORD1(type)		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), type))
+
+
+/* Command Completion event */
+#define MHI_CC_EV_PTR(ptr)		cpu_to_le64(ptr)
+#define MHI_CC_EV_DWORD0(code)		cpu_to_le32(FIELD_PREP(GENMASK(31, 24), code))
+#define MHI_CC_EV_DWORD1(type)		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), type))
+
 /* Transfer descriptor macros */
 #define MHI_TRE_DATA_PTR(ptr)		cpu_to_le64(ptr)
 #define MHI_TRE_DATA_DWORD0(len)	cpu_to_le32(FIELD_PREP(GENMASK(15, 0), len))
@@ -175,6 +191,12 @@
 								FIELD_PREP(BIT(9), ieot) |  \
 								FIELD_PREP(BIT(8), ieob) |  \
 								FIELD_PREP(BIT(0), chain))
+#define MHI_TRE_DATA_GET_PTR(tre)	le64_to_cpu((tre)->ptr)
+#define MHI_TRE_DATA_GET_LEN(tre)	FIELD_GET(GENMASK(15, 0), MHI_TRE_GET_DWORD(tre, 0))
+#define MHI_TRE_DATA_GET_CHAIN(tre)	FIELD_GET(BIT(0), MHI_TRE_GET_DWORD(tre, 1))
+#define MHI_TRE_DATA_GET_IEOB(tre)	FIELD_GET(BIT(8), MHI_TRE_GET_DWORD(tre, 1))
+#define MHI_TRE_DATA_GET_IEOT(tre)	FIELD_GET(BIT(9), MHI_TRE_GET_DWORD(tre, 1))
+#define MHI_TRE_DATA_GET_BEI(tre)	FIELD_GET(BIT(10), MHI_TRE_GET_DWORD(tre, 1))
 
 /* RSC transfer descriptor macros */
 #define MHI_RSCTRE_DATA_PTR(ptr, len)	cpu_to_le64(FIELD_PREP(GENMASK(64, 48), len) | ptr)
diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index b3b8770f2f4e..8753ae93eda3 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -195,4 +195,8 @@ void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *s
 void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
 void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
 
+/* MHI EP core functions */
+int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
+int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env);
+
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index d76387c4d5fa..903f9bd3e03d 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -18,6 +18,94 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
+			     struct mhi_ring_element *el, bool bei)
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
+			dev_err(dev, "Error starting event ring (%u)\n", ring_idx);
+			goto err_unlock;
+		}
+	}
+
+	/* Add element to the event ring */
+	ret = mhi_ep_ring_add_element(ring, el);
+	if (ret) {
+		dev_err(dev, "Error adding element to event ring (%u)\n", ring_idx);
+		goto err_unlock;
+	}
+
+	mutex_unlock(&mhi_cntrl->event_lock);
+
+	/*
+	 * Raise IRQ to host only if the BEI flag is not set in TRE. Host might
+	 * set this flag for interrupt moderation as per MHI protocol.
+	 */
+	if (!bei)
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
+static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
+					struct mhi_ring_element *tre, u32 len, enum mhi_ev_ccs code)
+{
+	struct mhi_ring_element event = {};
+
+	event.ptr = cpu_to_le64(ring->rbase + (ring->rd_offset * (sizeof(*tre))));
+	event.dword[0] = MHI_TRE_EV_DWORD0(code, len);
+	event.dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
+
+	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event, !!MHI_TRE_DATA_GET_BEI(tre));
+}
+
+int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
+{
+	struct mhi_ring_element event = {};
+
+	event.dword[0] = MHI_SC_EV_DWORD0(state);
+	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
+
+	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+}
+
+int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env)
+{
+	struct mhi_ring_element event = {};
+
+	event.dword[0] = MHI_EE_EV_DWORD0(exec_env);
+	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
+
+	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+}
+
+static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
+{
+	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_cmd->ring;
+	struct mhi_ring_element event = {};
+
+	event.ptr = cpu_to_le64(ring->rbase + (ring->rd_offset *
+					       (sizeof(struct mhi_ring_element))));
+	event.dword[0] = MHI_CC_EV_DWORD0(code);
+	event.dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
+
+	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -227,6 +315,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	mutex_init(&mhi_cntrl->event_lock);
+
 	/* Set MHI version and AMSS EE before enumeration */
 	mhi_ep_mmio_write(mhi_cntrl, EP_MHIVER, config->mhi_version);
 	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 8e1de062f820..44a4669382ad 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -59,10 +59,14 @@ struct mhi_ep_db_info {
  * @mhi_event: Points to the event ring configurations table
  * @mhi_cmd: Points to the command ring configurations table
  * @sm: MHI Endpoint state machine
+ * @ch_ctx_cache: Cache of host channel context data structure
+ * @ev_ctx_cache: Cache of host event context data structure
+ * @cmd_ctx_cache: Cache of host command context data structure
  * @ch_ctx_host_pa: Physical address of host channel context data structure
  * @ev_ctx_host_pa: Physical address of host event context data structure
  * @cmd_ctx_host_pa: Physical address of host command context data structure
  * @chdb: Array of channel doorbell interrupt info
+ * @event_lock: Lock for protecting event rings
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_addr: CB function for allocating memory in endpoint for storing host context
  * @map_addr: CB function for mapping host context to endpoint
@@ -89,11 +93,15 @@ struct mhi_ep_cntrl {
 	struct mhi_ep_cmd *mhi_cmd;
 	struct mhi_ep_sm *sm;
 
+	struct mhi_chan_ctxt *ch_ctx_cache;
+	struct mhi_event_ctxt *ev_ctx_cache;
+	struct mhi_cmd_ctxt *cmd_ctx_cache;
 	u64 ch_ctx_host_pa;
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
 
 	struct mhi_ep_db_info chdb[4];
+	struct mutex event_lock;
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,
-- 
2.25.1

