Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF64FCC44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiDLCLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiDLCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:11:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764C133A30
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:08:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so1187583pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=A9IM1YoZMYeZsqiXebTOSXRaO7Y40jkfHoWw9tH/GgQ=;
        b=p45NeFlRokfGIHAwDw3LrGme7BVQhmjbIeG4y03mfHnm/z+ixqJvLyUjzqJHf3/Y8a
         8EFs5M1RhlWjFnHKLyVjOGPhVr+eZy2tYYkhgFRlfe78s2H2RBVXbOTHwffPFmdqwQ9C
         J5e1igcw7vyWXbAN425N/SrwOS8U+b6YcvDNnCWw1lNAXH2ObhjFHUhepJ+XvMyazSyL
         BpuHWWCKZLPRXwsfICsIIe8ZGsutHOEmmOE8I4ceNVWkeEpocWZvAFLDRG997GyWYA2F
         aZ/s+/5dx/WlQMiNn4Oqa2WqCxCmrtpXBvH/Py7UfxUclf10MvXYNCE+Qd4HtTMZQue1
         cMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=A9IM1YoZMYeZsqiXebTOSXRaO7Y40jkfHoWw9tH/GgQ=;
        b=zq/fmK8jJaTG02Wcf8lH+5HtpSW8IWH8ydofQNwypldn10juYGtGP8w/3plbmQB88C
         5Jd/nU2/Lyf2R8gPW4HWgKZYXJDb/woNR6EZqHPlwmp4/o+h0gdiuPMZ9AejNATepDah
         ghyDAuMrQgJDGolr5fIs8mj7ABCAMi99j0pKz2YY4vnH5/mFPJ+0w/LB2Y2g6kyBgsPF
         tMsIlqeiVApqV2w80hFvkTam5Fk5qX+7xgStub/J+sIxz2cBgcZiqdw+rnnaO/LwaXqr
         tu/S+e8RP1uM0lGU3GxGJWrU7kDGanwPFo15D4AsggT4dtObMaIZAGbu79pCGzqggP1x
         Ui7A==
X-Gm-Message-State: AOAM53225tSsg3mX0qeJPxBa6mzjHY6KTRxq+t2zIB0NtglFTibA/pDQ
        wE53XLSQ7UWTUc1xX56ji5E=
X-Google-Smtp-Source: ABdhPJxaljyawvYpKPw3HWG2wZ8Dt5AeofevjTAIjQcY6iTvRHkUM8O9mJwfjlRhlw3oI7MtnYdfSA==
X-Received: by 2002:a17:902:6ac7:b0:150:24d6:b2ee with SMTP id i7-20020a1709026ac700b0015024d6b2eemr35515745plt.168.1649729329898;
        Mon, 11 Apr 2022 19:08:49 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm903361pgp.15.2022.04.11.19.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 19:08:49 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: Fix return value check of wait_for_completion_timeout
Date:   Tue, 12 Apr 2022 02:08:30 +0000
Message-Id: <20220412020834.7161-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not int.
It returns 0 if timed out, and positive if completed.
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case.

Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mtd/nand/raw/sh_flctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index b85b9c6fcc42..4f326a2dd170 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -385,6 +385,7 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 	dma_cookie_t cookie;
 	uint32_t reg;
 	int ret;
+	unsigned long time_left;
 
 	if (dir == DMA_FROM_DEVICE) {
 		chan = flctl->chan_fifo0_rx;
@@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 		goto out;
 	}
 
-	ret =
+	time_left =
 	wait_for_completion_timeout(&flctl->dma_complete,
 				msecs_to_jiffies(3000));
 
-	if (ret <= 0) {
+	if (time_left == 0) {
 		dmaengine_terminate_all(chan);
 		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
+		ret = -ETIMEDOUT;
 	}
 
 out:
-- 
2.17.1

