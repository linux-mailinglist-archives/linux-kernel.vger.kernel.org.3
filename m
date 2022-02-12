Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C358B4B3729
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiBLSXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBLSXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F142606C1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso11828549pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/hPWm0+5LcdOB8NWzzaMRU3PadY6NbOKvxGtL82+j4=;
        b=MAYIMl8lfe4WoVIa2YvE97sC8uSrnnZiWqPEW1iuYn1xqCViy5MGkLuyrr4oy3Yqgb
         3Fb/y0+eVDYDTesbT61m0ivf/4VJ20M5qr98GpUTO0nDl3YdW6gm7W2D7zkFhx9waMBy
         GwfctOKxATTTcPAwC8z52r/TCI2xZELn9C1PJrElhW1YLlPJA43lcJx4r0TDWFUQVIXT
         woNBDUGgPObzMsWbJ4vvorjGixuKglumXzccBAehLGuZDnJASuAwYYkpqAjxDKy6cuPe
         8lAE9IbqF6ODOwZCZSM2dLD31/ORj7MRAoJA6Tx6mvBiC76XV5fdr3B033CU2svNeZd+
         dB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/hPWm0+5LcdOB8NWzzaMRU3PadY6NbOKvxGtL82+j4=;
        b=xihcIJ6H4Vq+dF0yOrc65H3GuFFLSfWgv72/LFHGnv10/k9uugGKs5Rp59Zt1UyRIx
         vl95v4xWBjmT04wEPSUop5wdD0Mii3OuBCMOrJwFGxvVaIaC0CkwifjT7cuKlIVQtQTy
         sQg5HS8EkwOqX7MBwWKIQ081sWuRKWrQbG4SV8hOv4Y8Rom++jQZHxOxwdU04Dgm13AF
         +WTNnNg8mpgoZNetg801iKj/akQ0q7n/6+x8mKU1KHtR3WuNuqOgNrGCn5mruukm2JLy
         Y+CxdeGnrdTAGte+h8GEY6acr/U0+GjIXnxDlPsCLEBLZ5eQSYMew6KnQDOWIUtUtfrb
         60bA==
X-Gm-Message-State: AOAM531wiLwRR28p5YIoXHRTX/PV9K+JCmFy40CnB8iky2PDM1pcDvgA
        xAwJAQYePzKqWNovPetF60Zh
X-Google-Smtp-Source: ABdhPJwRrc/SxpGGHBJIIaKyU1LDqCDZZdi4badsonGW1XzxaGDljBrPXmLf3jIz6WrVI9Sh1b7dtA==
X-Received: by 2002:a17:90b:398:: with SMTP id ga24mr6372706pjb.108.1644690199968;
        Sat, 12 Feb 2022 10:23:19 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:23:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 20/25] bus: mhi: ep: Add support for processing command ring
Date:   Sat, 12 Feb 2022 23:51:12 +0530
Message-Id: <20220212182117.49438-21-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
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

Add support for processing the command ring. Command ring is used by the
host to issue channel specific commands to the ep device. Following
commands are supported:

1. Start channel
2. Stop channel
3. Reset channel

Once the device receives the command doorbell interrupt from host, it
executes the command and generates a command completion event to the
host in the primary event ring.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 151 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 6378ac5c7e37..4c2ee517832c 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -21,6 +21,7 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
 static int mhi_ep_destroy_device(struct device *dev, void *data);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
@@ -185,6 +186,156 @@ void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t
 	mhi_cntrl->free_addr(mhi_cntrl, phys - offset, virt - offset, size);
 }
 
+int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_result result = {};
+	struct mhi_ep_chan *mhi_chan;
+	struct mhi_ep_ring *ch_ring;
+	u32 tmp, ch_id;
+	int ret;
+
+	ch_id = MHI_TRE_GET_CMD_CHID(el);
+	mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
+	ch_ring = &mhi_cntrl->mhi_chan[ch_id].ring;
+
+	switch (MHI_TRE_GET_CMD_TYPE(el)) {
+	case MHI_PKT_TYPE_START_CHAN_CMD:
+		dev_dbg(dev, "Received START command for channel (%d)\n", ch_id);
+
+		mutex_lock(&mhi_chan->lock);
+		/* Initialize and configure the corresponding channel ring */
+		if (!ch_ring->started) {
+			ret = mhi_ep_ring_start(mhi_cntrl, ch_ring,
+				(union mhi_ep_ring_ctx *)&mhi_cntrl->ch_ctx_cache[ch_id]);
+			if (ret) {
+				dev_err(dev, "Failed to start ring for channel (%d)\n", ch_id);
+				ret = mhi_ep_send_cmd_comp_event(mhi_cntrl,
+							MHI_EV_CC_UNDEFINED_ERR);
+				if (ret)
+					dev_err(dev, "Error sending completion event (%d)\n",
+						MHI_EV_CC_UNDEFINED_ERR);
+
+				goto err_unlock;
+			}
+		}
+
+		/* Enable DB for the channel */
+		mhi_ep_mmio_enable_chdb_a7(mhi_cntrl, ch_id);
+
+		/* Set channel state to RUNNING */
+		mhi_chan->state = MHI_CH_STATE_RUNNING;
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_RUNNING);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event (%d)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+
+		/*
+		 * Create MHI device only during UL channel start. Since the MHI
+		 * channels operate in a pair, we'll associate both UL and DL
+		 * channels to the same device.
+		 *
+		 * We also need to check for mhi_dev != NULL because, the host
+		 * will issue START_CHAN command during resume and we don't
+		 * destroy the device during suspend.
+		 */
+		if (!(ch_id % 2) && !mhi_chan->mhi_dev) {
+			ret = mhi_ep_create_device(mhi_cntrl, ch_id);
+			if (ret) {
+				dev_err(dev, "Error creating device for channel (%d)\n", ch_id);
+				return ret;
+			}
+		}
+
+		break;
+	case MHI_PKT_TYPE_STOP_CHAN_CMD:
+		dev_dbg(dev, "Received STOP command for channel (%d)\n", ch_id);
+		if (!ch_ring->started) {
+			dev_err(dev, "Channel (%d) not opened\n", ch_id);
+			return -ENODEV;
+		}
+
+		mutex_lock(&mhi_chan->lock);
+		/* Disable DB for the channel */
+		mhi_ep_mmio_disable_chdb_a7(mhi_cntrl, ch_id);
+
+		/* Send channel disconnect status to client drivers */
+		result.transaction_status = -ENOTCONN;
+		result.bytes_xferd = 0;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+		/* Set channel state to STOP */
+		mhi_chan->state = MHI_CH_STATE_STOP;
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_STOP);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event (%d)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+		break;
+	case MHI_PKT_TYPE_RESET_CHAN_CMD:
+		dev_dbg(dev, "Received STOP command for channel (%d)\n", ch_id);
+		if (!ch_ring->started) {
+			dev_err(dev, "Channel (%d) not opened\n", ch_id);
+			return -ENODEV;
+		}
+
+		mutex_lock(&mhi_chan->lock);
+		/* Stop and reset the transfer ring */
+		mhi_ep_ring_reset(mhi_cntrl, ch_ring);
+
+		/* Send channel disconnect status to client driver */
+		result.transaction_status = -ENOTCONN;
+		result.bytes_xferd = 0;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+		/* Set channel state to DISABLED */
+		mhi_chan->state = MHI_CH_STATE_DISABLED;
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_DISABLED);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event (%d)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+		break;
+	default:
+		dev_err(dev, "Invalid command received: %d for channel (%d)\n",
+			MHI_TRE_GET_CMD_TYPE(el), ch_id);
+		return -EINVAL;
+	}
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&mhi_chan->lock);
+
+	return ret;
+}
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-- 
2.25.1

