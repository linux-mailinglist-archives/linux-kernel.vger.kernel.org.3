Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5059951D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbiHSGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbiHSGIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9FC6B60
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so4449921edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=go4dvEqia6V/fZxmN51/sJtBvXxxyfCPi+dAy/HXyXo=;
        b=VxLm9bmVN54BCjUabUuzJyntx78WSMGA2ScgHljGmX3yILIHDVDSu2s0h+thyaO1Ba
         jvHV2pGGsVHOKDF0NdcKYiMGa3bobPAyASxUneQRAM+Wyiwt/1RX8NDYqrb0j0SslK/q
         jBa7mJKpuu6Pw1p+OgpqLLBUK3SNuNNRcWgvuAKxUEekniP54XKnBvpBxQRQ2HwGFX0u
         tS7VjIKeSNj7GVWjukpdyX1KISPAceqw4LruTTThMrJ1DDKtQPTzKEyw4VTmywtR9SiQ
         nL8z6ujP/0/c+BrjZtSULCy2vI94RIzOj2RkAeztN44jZ/ErtZnExFzmfiE99c9SyP8Z
         wWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=go4dvEqia6V/fZxmN51/sJtBvXxxyfCPi+dAy/HXyXo=;
        b=FNXCJe3mJZpGl4KAVXq60E7hA/LcwcVtTyJ/AdKiAdbfhSfQvGtV+N8P5A9GPeaZBb
         UStrC0sUOCfjahsr9PyU5LAiBvd4rIKd/5SspEvh8Apyrfb3kMvGVX85/+stQdewbybW
         YRj6ndisrVdtiqhjz+zIwdTNHOG7D6/Sw0tBQEORgCYJTazkJZrz1tf7vlNacwTyq9Rb
         OAZBxhqALKhO0AadXr40ToJ7l8vHoGP0sKKHf1LhGIm1xBnPyj3PEhm07lH4VpEcL1nc
         zJjVqKs27CqR3HxLcsvGxV/e77VyvghNgtsPictbWz43VcUC1l9sK/xGPlCSXTb7Sj/O
         KTXA==
X-Gm-Message-State: ACgBeo1xXAaVflwx4ZE2rB4VtWqxg+W13yy7GxlbdOKhLaK2OYXerdUW
        k7ChNEY9LhSWNmId35ZHtUUdzp506RNxAA==
X-Google-Smtp-Source: AA6agR7BwaAHixNpkd8Ns0nUFUt0FNO6JJuhrJ7FCouUDH1Yr+TV7FDsA5OE27Loqn8SJ2gAZJW3sg==
X-Received: by 2002:a05:6402:450c:b0:443:6279:774f with SMTP id ez12-20020a056402450c00b004436279774fmr4934547edb.11.1660889286796;
        Thu, 18 Aug 2022 23:08:06 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:06 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v1 03/19] HSI: omap_ssi_port: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:45 +0200
Message-Id: <20220819060801.10443-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, in case of error return -EIO
to caller.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/hsi/controllers/omap_ssi_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index a0cb5be246e1..b9495b720f1b 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -230,10 +230,10 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 	if (msg->ttype == HSI_MSG_READ) {
 		err = dma_map_sg(&ssi->device, msg->sgt.sgl, msg->sgt.nents,
 							DMA_FROM_DEVICE);
-		if (err < 0) {
+		if (!err) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
 			pm_runtime_put_autosuspend(omap_port->pdev);
-			return err;
+			return -EIO;
 		}
 		csdp = SSI_DST_BURST_4x32_BIT | SSI_DST_MEMORY_PORT |
 			SSI_SRC_SINGLE_ACCESS0 | SSI_SRC_PERIPHERAL_PORT |
@@ -247,10 +247,10 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 	} else {
 		err = dma_map_sg(&ssi->device, msg->sgt.sgl, msg->sgt.nents,
 							DMA_TO_DEVICE);
-		if (err < 0) {
+		if (!err) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
 			pm_runtime_put_autosuspend(omap_port->pdev);
-			return err;
+			return -EIO;
 		}
 		csdp = SSI_SRC_BURST_4x32_BIT | SSI_SRC_MEMORY_PORT |
 			SSI_DST_SINGLE_ACCESS0 | SSI_DST_PERIPHERAL_PORT |
-- 
2.34.1

