Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DF5A2596
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245359AbiHZKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbiHZKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:12:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C2B6035
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:12:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id tl26so1513797ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jUvL2nRoIT+XrpDJMxG8OypfnLdV/LevBya7ruKPhk8=;
        b=UxmG8eY5zkAdmjtDBAbYbXWOa2h9YrO4OtS+/4m1qPyamDZtGw7WBQnJ45mIXJrYHD
         kvudJM+xAJZGJnoEpgDmd9D0vWHJK+4X4sAIT0IR7zO4fUN7eIyZJOGkh9te6xvuwprF
         AOiz/bIFLHw9vWkd1weTOK84jX63z9qorZNx4BSZbO7bep/g/Y5TLIpn8bFMGQh2nczi
         0VcIr9rdLY/rmyarUw62IiTS3OAjoRvxKIk0n0E53ey0lAkhdMDhKvK43AAHoM2GQYKq
         pCO9z/wjknIRbBOVqNbrWHXlgRyJCwaYLqr65zeL3jOYB0Hy/XT4qXLZnbsASgzPb3Ri
         R7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jUvL2nRoIT+XrpDJMxG8OypfnLdV/LevBya7ruKPhk8=;
        b=bSm9uNLKYF+d4Bdvx5JjN7wT8dVnBQ3ZO/C5cNcVaLceMpTjSa82kHABKXlXsB5DyM
         N9J6gN6i2Zyk7YwQS4exZEiF6ZaiR+T6zl8K+eAV2QsCda8KCVaT3Z/MNGPSyAk0LS6c
         Q7LqoBkXm5nnbH/Pw5jI/r34nOIN7UViNsVYiL1RAQY4/qtX6iU1nslctD8CrvpGC07w
         l+76hZqukcsldvVDBsI1EIXMnpGtv3xJnaQFCDrZoLZbANvBWiETUbnXtvJoLnROcmJd
         Q9hvY3huKryiqPqw7JsXjnZeA+r0v1wMyrZ+0+9xI958qYoylkjeb+3h4QTUYEJMIXbM
         Ujew==
X-Gm-Message-State: ACgBeo3j+iR/Tukvm79ll2KgnDEz+55rLL5hXUDkfKYyMX2evyzchv71
        0R2NmItaGLAyiyVl/GOdVCC8fg7hscu6Zw==
X-Google-Smtp-Source: AA6agR6Ozrm30sD/I7yn8QuylHfsQaO/9IoNOa38flrGeAWuFudB03ZyctI0m4E/nW6mt1MvtgLfqg==
X-Received: by 2002:a17:907:724f:b0:731:9ec:10fc with SMTP id ds15-20020a170907724f00b0073109ec10fcmr5085017ejc.427.1661508748671;
        Fri, 26 Aug 2022 03:12:28 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id h3-20020a056402094300b00445e037345csm1056984edz.14.2022.08.26.03.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:12:27 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] HSI: omap_ssi_port: Fix dma_map_sg error check
Date:   Fri, 26 Aug 2022 12:12:27 +0200
Message-Id: <20220826101227.78237-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
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
Fixes: b209e047bc74 ("HSI: Introduce OMAP SSI driver")
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

