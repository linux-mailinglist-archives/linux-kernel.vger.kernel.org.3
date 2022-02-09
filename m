Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5054AEFB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiBILK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiBILK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:10:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B1E081109
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:06:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w20so1747409plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouITQk3JWyKLA4aS9Z1TEhHxLU1dm/dFTurUA0AndPg=;
        b=UL+o/DvQlKxzuSAnlH45X8P/kXtoX+CBk8xBIozdnL423GtmVuNOTebXw+TlDXyIGE
         Y+BTX9+6AhPyqMYYHDIJ+y/fytCbGgAt7h3fMwpQhgKUGfhWwahDBdULQWQfTeU+KBBG
         jDdxOnzRBaLVfDKVb2dfe9u5Y+XteRZKYIPOGlNyrPKoQxjvBJTNhEtZ3bLCzlVO0jVE
         PVZN2/y6GgSIaczy8nTcd2Myz+L+/RpZ4rq0v2+3CIzBeYOrjIjQO21rpKNhR9qp+sxZ
         74OXyeLXWpTnffru5BOlgcy1d3Vxv+21YAhOJ/IGbHz7PdF29R1PPGMRDxapqgl61yZ9
         I5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouITQk3JWyKLA4aS9Z1TEhHxLU1dm/dFTurUA0AndPg=;
        b=NYDIdpPIcG/5F4eL5x5b0fWj2d7hx1f2iSbOn9Ze60LfuYSkHNvARbmaf4Pv9fULlF
         fyNz05hZxLZZsJ1jOGcjV4dKcRJ7b0MXe41TA3fHOkRlPhdt+pAdhHvFVa1sE5y8U6UM
         OsPT7RBovNVvsZ2A2rsCfGnqJRJksrya5ygHoT/tOenZswFT+9Q4gp/lRMxJ1ERdgqGj
         bu1KpE2/kFaYY4BTMtu6nMDhp5lfKepxLt4S7bOEzpv3MU+hYhlcUOK2sAkX3l11tM1/
         lax15DAGKYH6EYsRYJ3JUqlNzS5dJ9bveFfw8qXDhgwXReilB4XWS9LjPUd6TxPVYiln
         Gk7g==
X-Gm-Message-State: AOAM532wsybJHdSknPJ4dfJ8gH0YJQP6TkN1lYjA/fRVmYvo2dCt/DKN
        pbY55+6NIPgBk6ClQMbNKw5I
X-Google-Smtp-Source: ABdhPJyWsoo7CRjGKHatmNzGiFBVnODdOxleSOYlij1KI1nkyCyfUgkW6mIFfmojQhUo+PFckZemtA==
X-Received: by 2002:a17:903:2412:: with SMTP id e18mr1482964plo.74.1644401167158;
        Wed, 09 Feb 2022 02:06:07 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 10/23] bus: mhi: ep: Add support for creating and destroying MHI EP devices
Date:   Wed,  9 Feb 2022 15:26:11 +0530
Message-Id: <20220209095624.26389-11-manivannan.sadhasivam@linaro.org>
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

This commit adds support for creating and destroying MHI endpoint devices.
The MHI endpoint devices binds to the MHI endpoint channels and are used
to transfer data between MHI host and endpoint device.

There is a single MHI EP device for each channel pair. The devices will be
created when the corresponding channels has been started by the host and
will be destroyed during MHI EP power down and reset.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index de7d52d15da4..f1241b935bbc 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -67,6 +67,83 @@ static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl,
 	return mhi_dev;
 }
 
+/*
+ * MHI channels are always defined in pairs with UL as the even numbered
+ * channel and DL as odd numbered one.
+ */
+static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
+{
+	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
+	struct mhi_ep_device *mhi_dev;
+	int ret;
+
+	/* Check if the channel name is same for both UL and DL */
+	if (strcmp(mhi_chan->name, mhi_chan[1].name))
+		return -EINVAL;
+
+	mhi_dev = mhi_ep_alloc_device(mhi_cntrl, MHI_DEVICE_XFER);
+	if (IS_ERR(mhi_dev))
+		return PTR_ERR(mhi_dev);
+
+	/* Configure primary channel */
+	mhi_dev->ul_chan = mhi_chan;
+	get_device(&mhi_dev->dev);
+	mhi_chan->mhi_dev = mhi_dev;
+
+	/* Configure secondary channel as well */
+	mhi_chan++;
+	mhi_dev->dl_chan = mhi_chan;
+	get_device(&mhi_dev->dev);
+	mhi_chan->mhi_dev = mhi_dev;
+
+	/* Channel name is same for both UL and DL */
+	mhi_dev->name = mhi_chan->name;
+	dev_set_name(&mhi_dev->dev, "%s_%s",
+		     dev_name(&mhi_cntrl->mhi_dev->dev),
+		     mhi_dev->name);
+
+	ret = device_add(&mhi_dev->dev);
+	if (ret)
+		put_device(&mhi_dev->dev);
+
+	return ret;
+}
+
+static int mhi_ep_destroy_device(struct device *dev, void *data)
+{
+	struct mhi_ep_device *mhi_dev;
+	struct mhi_ep_cntrl *mhi_cntrl;
+	struct mhi_ep_chan *ul_chan, *dl_chan;
+
+	if (dev->bus != &mhi_ep_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_ep_device(dev);
+	mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	/* Only destroy devices created for channels */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	ul_chan = mhi_dev->ul_chan;
+	dl_chan = mhi_dev->dl_chan;
+
+	if (ul_chan)
+		put_device(&ul_chan->mhi_dev->dev);
+
+	if (dl_chan)
+		put_device(&dl_chan->mhi_dev->dev);
+
+	dev_dbg(&mhi_cntrl->mhi_dev->dev, "Destroying device for chan:%s\n",
+		 mhi_dev->name);
+
+	/* Notify the client and remove the device from MHI bus */
+	device_del(dev);
+	put_device(dev);
+
+	return 0;
+}
+
 static int parse_ch_cfg(struct mhi_ep_cntrl *mhi_cntrl,
 			const struct mhi_ep_cntrl_config *config)
 {
-- 
2.25.1

