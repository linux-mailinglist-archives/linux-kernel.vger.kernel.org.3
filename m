Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9B4B3753
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiBLSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:22:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiBLSWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:22:38 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E825FF26
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d187so21918949pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRyVbSQXppN/OUuF4/pZFzmZtZ5UsMfwyjfSr89DRIw=;
        b=y0/VsjANcaLH2vRblATIxK3xx4jk4uiGpLeyo6hO672fh0QEeXI08eUWqVw232OvCW
         xOIyO4AhXpI3LL6nxCd8BmoFThKPLWU4skh9MF1zHMKRAUJSs9ujn/ZNQ4Z3wfpdrNZb
         kIs37yfnIntz2BU9NfUYtFbsxLiPAUNvchXn37NFg1nF3qINiukzPz/Vk8rMXlxSl67Q
         38m6theu77LbsBfaQovsETvlxyoUKsel4WgVZHO7gwNCQw83BM0yrIRYZ5tfNUkG5idf
         Ebt3KbC/QO4xrpBKPtyprXbH1amIboXJfuVKDbolURzZxT9rR+0vXzouPOHIfFmexzP2
         bHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRyVbSQXppN/OUuF4/pZFzmZtZ5UsMfwyjfSr89DRIw=;
        b=f5SgokYWfPI4Gaml6dD2ySJNyXBSfPGIToBWLx6mcaze5yYGEY49NEaDA3Ts3rIByJ
         W3djBwkOZHS5wKFXuIAbV0gGTmUPJnG6Cnanbiq76NijNL6Hokfs/WOht86QK28tJgAX
         ZgIaHSfFUOgXVa8EpYA9ni3YqCcdeoR1LgXRgxxm1YmdLejI3qen6rjagrFre0xb3req
         zrRx8z9bctPxBnEJ30XTbrp3AQJSXJiEFneI664MeGORT5fFudNcM6Pm8PFan/23X49P
         pnTbk1eA+HAEUSF3+lHE9mg3kOP1yfdCt3fAj5h2A8MNCRuTBoBi8dB02c6jQUxEa7D4
         b5gQ==
X-Gm-Message-State: AOAM530IgK5k6dV26gjda4eTJNZZnzRlNYizy/nTEC/aQdD6ATp/HTAf
        So3UtPbr7DTDNckNgT1D5/EZ
X-Google-Smtp-Source: ABdhPJxubjawu1rUQHWDhi1P1ZgIgZ89wp/2lwaVUSDQqFAkJ4M4AnqMt65H7xfVqgts9O46SjG95w==
X-Received: by 2002:a63:555b:: with SMTP id f27mr5780074pgm.468.1644690152896;
        Sat, 12 Feb 2022 10:22:32 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:22:32 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 10/25] bus: mhi: ep: Add support for creating and destroying MHI EP devices
Date:   Sat, 12 Feb 2022 23:51:02 +0530
Message-Id: <20220212182117.49438-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
index f66404181972..fcaacf9ddbd1 100644
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

