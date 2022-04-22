Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5504950B852
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447930AbiDVNZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447914AbiDVNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:25:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED4457B27
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:22:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g3so6702098pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aTsYn+fbrLEF70DYT+XvQa13+urwQkivcKboFHg6Ao=;
        b=BOWeG3zHuKTf7IsyuvqRU3jzy2o2wts7viRFugf1Pq0w96/Km8O4Z+eJ2+lyhol87H
         +nf+ptgdCfyRAaqddYGbtV4kEO+ytbIsmQeEGqiHBne7/jNBDm67O5iYSFNFrjm7RAsw
         N6C3S2vmvGkMTEPHkduQOV+yLdG5nxhYV2QHDGaU3OH8ebpGH77AEutetm5R9RavxTKU
         KEU8uLmduxy72vCwY749LFujpiNd7YHncSrAEYOJdveIC8sDklLoyn5svJGrUBY0AVce
         pwjP1COoZcqz8dArUevYhB2ccY6+/LThiedXZ1zt/hMTaVEMaAGlX0OsBc2l9td7HRxX
         VBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aTsYn+fbrLEF70DYT+XvQa13+urwQkivcKboFHg6Ao=;
        b=Oky44QaPJBs16kmDDP94MOLFkozAz7ycP6r1cDNLAQLxDOaT32+nmXANNaSylai7aQ
         EpA5HwopIpg+lAnmimnziCyQk1W4Xg3nYpR+DLRlmzpZV7UHRvQ34PHYd5qj4p81CdQQ
         Y1wL3JVpr3w5TnF8bT2vqfqgbsN5I9uq86ATCvr/9aEqyfOeymCQDps9zZAWcu2w2pfv
         HiHd4H2SvomC7e7cu/2mCk9p/1ilph+Hmk5mMmUHFzWv2V14cNlZsKye97kK7d4xC/yb
         uW78TGbM78PG/3gaA9uRUNN7BNsno5UJRdEXIyc/ZuFK1IDV4M9yuXmqDwo3lwUEZlPq
         qB6Q==
X-Gm-Message-State: AOAM5322irNDU/ue2jWlQrHW2dtwHLcrt0JqyZXEdnM4XcxB4cZommZh
        RY7XKJXcavTJzok09VAybzLw
X-Google-Smtp-Source: ABdhPJzvnw8o1O07FvEJgfNvXBizaKMHbMO8qkm1OWHXlD40i9elG+wZHzzrDZiNB5lhOGu8ebUopg==
X-Received: by 2002:a63:d855:0:b0:39c:e714:c79f with SMTP id k21-20020a63d855000000b0039ce714c79fmr3830235pgj.570.1650633733833;
        Fri, 22 Apr 2022 06:22:13 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id g13-20020a62520d000000b0050a923a7754sm2586840pfb.119.2022.04.22.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:22:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 3/5] scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled
Date:   Fri, 22 Apr 2022 18:51:38 +0530
Message-Id: <20220422132140.313390-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
References: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
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

In ufs_qcom_dev_ref_clk_ctrl(), it was noted that the ref_clk needs to be
stable for atleast 1us. Eventhough there is wmb() to make sure the write
gets "completed", there is no guarantee that the write actually reached
the UFS device. There is a good chance that the write could be stored in
a Write Buffer (WB). In that case, eventhough the CPU waits for 1us, the
ref_clk might not be stable for that period.

So lets do a readl() to make sure that the previous write has reached the
UFS device before udelay().

Cc: stable@vger.kernel.org
Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and power optimizations")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 5f0a8f646eb5..5b9986c63eed 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -690,6 +690,12 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_qcom_host *host, bool enable)
 		/* ensure that ref_clk is enabled/disabled before we return */
 		wmb();
 
+		/*
+		 * Make sure the write to ref_clk reaches the destination and
+		 * not stored in a Write Buffer (WB).
+		 */
+		readl(host->dev_ref_clk_ctrl_mmio);
+
 		/*
 		 * If we call hibern8 exit after this, we need to make sure that
 		 * device ref_clk is stable for at least 1us before the hibern8
-- 
2.25.1

