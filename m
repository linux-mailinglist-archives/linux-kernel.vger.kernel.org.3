Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF04CE74F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiCEV7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiCEV7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:59:33 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8103DA7E;
        Sat,  5 Mar 2022 13:58:42 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t28so10331191qtc.7;
        Sat, 05 Mar 2022 13:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ct38wuS+j+KdARYVXEvHL+p/0EBV034tSVqTgQxYy/U=;
        b=lfUc/RQ3J+tTlsfPuOC/ab+OMU3mVuCcB4s7Px11WkslxfatjJrSn+avZ0CETKOM4R
         vNcCBnebj/girjqxQHd2H7h/tRv4gi/WDxgWoOE2cRfANKVz4wMIedKVBahV9olXt6el
         +U35guGBBVNvrmS31BjkHkM9yz/sK1Nm1S12Ofj/GvMRGj0Jl/IpIvKA538nMQT1Pck0
         hnxIPQcnwSQJJVu4FpAILCgmcV5XAwq7Sa1BTyJeFbA6K6MlzJiq6oZYhXJwuk+10Qc+
         RnefUeOYfO0P/mWNTAIDXnj5GmFZY5LWYUYNJPe2ZKVwoS0tSwza07qTjo4WX4hiooIV
         v33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ct38wuS+j+KdARYVXEvHL+p/0EBV034tSVqTgQxYy/U=;
        b=sc3p3aiK7TJhgePjiP/vBj7mQ9hexUVTiXjqk91kLNR6XoehV38W3c7BoHZIVqX1xk
         2kEv5MuHjkbBN5qu31URGkwR5p3CNi5jg8y8hM4H+3uJxB1uB9VqTRDZOqrivHD8Cu1l
         vEneAKAVxsQZaIo0IFj+cYbt0jAjdvu/XXYGjTZQOwL0+iP0AUVCW6HMfMXCUczprWjg
         eru9dndtMVxliKG3lYLDjvaQyOdt+CgNhP7ry4end7zKCdbWvCCE1NRtKfgfuHwFN9SR
         XnY8nF2OhtJRhJfdIsNDYxnPhK8KJcqibpsaByG4oauwHGL1MQ/e8K1ksSeM5QmiNcIo
         hNrA==
X-Gm-Message-State: AOAM533FbrymLKHl99F86SQITrkkDEUJxiyazvUXuN9nKN0xUTNpcnDI
        xmwsSWABOdSIXh2idzIRMbI=
X-Google-Smtp-Source: ABdhPJwkcUtvAR6twCDRCalsZKvOr+O+o9namgpdwUWCoHGmZOsKiCUtUVyLUEgi2B5e9H2Y49ftCA==
X-Received: by 2002:a05:622a:1809:b0:2de:6f5c:23ed with SMTP id t9-20020a05622a180900b002de6f5c23edmr4224001qtc.406.1646517521810;
        Sat, 05 Mar 2022 13:58:41 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h188-20020a376cc5000000b00648d7e2a36bsm4230067qkc.117.2022.03.05.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 13:58:41 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     robin.murphy@arm.com, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mmc: host: dw_mmc: support setting f_min from host drivers
Date:   Sat,  5 Mar 2022 16:58:34 -0500
Message-Id: <20220305215835.2210388-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305215835.2210388-1-pgwipeout@gmail.com>
References: <20220305215835.2210388-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host drivers may not be able to support frequencies as low as dw-mmc
supports. Unfortunately f_min isn't available when the drv_data->init
function is called, as the mmc_host struct hasn't been set up yet.

Support the host drivers saving the requested minimum frequency, so we
can later set f_min when it is available.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 7 ++++++-
 drivers/mmc/host/dw_mmc.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 42bf8a2287ba..0d90d0201759 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2898,7 +2898,12 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
-	mmc->f_min = DW_MCI_FREQ_MIN;
+	/* if host has set a minimum_freq, we should respect it */
+	if (host->minimum_speed)
+		mmc->f_min = host->minimum_speed;
+	else
+		mmc->f_min = DW_MCI_FREQ_MIN;
+
 	if (!mmc->f_max)
 		mmc->f_max = DW_MCI_FREQ_MAX;
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 7f1e38621d13..4ed81f94f7ca 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -99,6 +99,7 @@ struct dw_mci_dma_slave {
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
  * @current_speed: Configured rate of the controller.
+ * @minimum_speed: Stored minimum rate of the controller.
  * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
  * @dev: Device associated with the MMC controller.
@@ -201,6 +202,7 @@ struct dw_mci {
 
 	u32			bus_hz;
 	u32			current_speed;
+	u32			minimum_speed;
 	u32			fifoth_val;
 	u16			verid;
 	struct device		*dev;
-- 
2.25.1

