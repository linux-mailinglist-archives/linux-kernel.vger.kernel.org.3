Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD44F4B79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574636AbiDEXAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443727AbiDEPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CED26154
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 7so5155594pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMFxVrvia9OrZ+g+VU9hpXF4WwQXbQ5dVk1gjFBtBLg=;
        b=oF6jR8PBrY7r+F+CMHmGFfxLTa31Wwz9Bk6+2awDabCwI++At1IOHSQm9dj531uyPe
         7b5Sd2bK1G9aydN0n87ICjS8664My1Fig3+1qegEDs2fjp/VA1bF3TFqG36647+90k0W
         pmPEoCaJqCKPIpAEKB9z1k5MWdpC3tLHGFb4+GW0wK7jAkY8jSgUU4YiICVvbwJMjzvO
         Mjc4nBItl0e9LiI5x9CsgPnt73Knu64uXMr+sDqOll4tQu94rt4b/L261f6Bh9FHnqCz
         Nwz7mBDlaSPRPabkuNWYleB0kZH7Ry16khdJVPVG3XVLXOUeKrXhyGqEFQcOOvXbZvIv
         3OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMFxVrvia9OrZ+g+VU9hpXF4WwQXbQ5dVk1gjFBtBLg=;
        b=C1Lkmuy18ZEFqk47TAjCzp7X0kHttb/5dAn4k7pOb+YNUaGVUoStpLU+vGBvieF6/4
         lhw7HYtbUmQQzf0r1uJwkNS8CALCl4y5h321Nq5ByYlhtqVFnS0eIdiVLX595h/i4azU
         R4Ms9O6dX7uIFadyORH7aFi/uiwDNGvuqkQM7q4kG1CJR0CSmWpimwdB2gBxicCrdqO0
         1tCo4lOMeCOLEgseZDPd9Wso3VFH4+AizmgRoBP7dyg3mX5X5ZaR7GCcoDq1KNwX7Vpx
         Vql3+AyXpc48P6wgDXiRRapT6Cd9CEpusR7zgOJWzJjgbsJ2HaxqybhI4D+QQwqsJcR/
         pgiA==
X-Gm-Message-State: AOAM533lZDt+VkOqmV8CAX+gE3v91by0qrLYb0vAjMIPy+NwBXPQrgaE
        TeF7LmWX0WJK+nwQ1LJdZVeK
X-Google-Smtp-Source: ABdhPJyxkkmoczC7gFJGs5yoM/Hhc04762d/uyEPrTZ2SAtFyjoJHCdFhvsxIsnMoZqrxATEeFxMMA==
X-Received: by 2002:a63:e952:0:b0:382:65eb:257 with SMTP id q18-20020a63e952000000b0038265eb0257mr2971933pgj.465.1649167114565;
        Tue, 05 Apr 2022 06:58:34 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:58:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/18] bus: mhi: ep: Add support for sending events to the host
Date:   Tue,  5 Apr 2022 19:27:42 +0530
Message-Id: <20220405135754.6622-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
References: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
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

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/common.h      | 22 +++++++++
 drivers/bus/mhi/ep/internal.h |  4 ++
 drivers/bus/mhi/ep/main.c     | 89 +++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  8 ++++
 4 files changed, 123 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index b4ef9acd3ce7..f794b9c8049e 100644
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
+#define MHI_TRE_DATA_GET_CHAIN(tre)	(!!(FIELD_GET(BIT(0), MHI_TRE_GET_DWORD(tre, 1))))
+#define MHI_TRE_DATA_GET_IEOB(tre)	(!!(FIELD_GET(BIT(8), MHI_TRE_GET_DWORD(tre, 1))))
+#define MHI_TRE_DATA_GET_IEOT(tre)	(!!(FIELD_GET(BIT(9), MHI_TRE_GET_DWORD(tre, 1))))
+#define MHI_TRE_DATA_GET_BEI(tre)	(!!(FIELD_GET(BIT(10), MHI_TRE_GET_DWORD(tre, 1))))
 
 /* RSC transfer descriptor macros */
 #define MHI_RSCTRE_DATA_PTR(ptr, len)	cpu_to_le64(FIELD_PREP(GENMASK(64, 48), len) | ptr)
diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index d16b87061ac6..e096d9cb2cb1 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -197,4 +197,8 @@ void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *s
 void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
 void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
 
+/* MHI EP core functions */
+int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
+int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env);
+
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 7dcc784f10d1..eca1f58ba5fb 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -18,6 +18,93 @@
 
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
+	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
+	event.dword[0] = MHI_TRE_EV_DWORD0(code, len);
+	event.dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
+
+	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event, MHI_TRE_DATA_GET_BEI(tre));
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
+	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(struct mhi_ring_element));
+	event.dword[0] = MHI_CC_EV_DWORD0(code);
+	event.dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
+
+	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -227,6 +314,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	mutex_init(&mhi_cntrl->event_lock);
+
 	/* Set MHI version and AMSS EE before enumeration */
 	mhi_ep_mmio_write(mhi_cntrl, EP_MHIVER, config->mhi_version);
 	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 5db048e258e4..46236ffb528a 100644
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
  * @alloc_map: CB function for allocating memory in endpoint for storing host context and mapping it
  * @unmap_free: CB function to unmap and free the allocated memory in endpoint for storing host context
@@ -87,11 +91,15 @@ struct mhi_ep_cntrl {
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
 	int (*alloc_map)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t *phys_ptr,
-- 
2.25.1

