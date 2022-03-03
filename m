Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0EB4CBA0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiCCJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiCCJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:22:28 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66AA16BCF7;
        Thu,  3 Mar 2022 01:21:41 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j5so3602633qvs.13;
        Thu, 03 Mar 2022 01:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjLVAHYQdC3TfzYteC4e+EJhOBPlyxvi64+3KhE2C5s=;
        b=NKZoGBfk+iQND9eakA2JUeF6APzkG+fv/OG/s6y9qLE6vDgNzd4Fu1MU8cLlsXjbC5
         SxYslRU5jgrTojt4IRaWKAE8k4aN3iy0hXVGcslqTDTJjfGu7NN2YVm7hcpmILxITJmy
         gxT/txtX3M5tmL8tkkeX3RJ9z97DxmjgZFf/86GN3WK83PFsoHrIUfkKMuFLt0i1qrDz
         atyxM91HleoV5OiyR4Yz1hjTS5NHRZVe6614yfTKNgbtpbVb1ApgqXSBvQKn+MUDcXU+
         xGDSdX4L93QwN1OH6ysP1WkwfflwQ/+jCaVZYT0pX52jub2MY5Ou+tSjWE8xBGZlcvbd
         CrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjLVAHYQdC3TfzYteC4e+EJhOBPlyxvi64+3KhE2C5s=;
        b=fZ5lrHaSS1K/PHQIJeP2uVEEqzwVnCGLPaYdjUlHVEjK+EvF9bEzOuFoirGqXVcYBm
         BaI5EsSdju3ecLujIO2enirErHWoUre8gFmhNK59LetD+m5C5gc/X+LGx3gcIoazes1X
         VEyrtDs9BO8grkH6Q663XV2vsSsL7KSMVQJ5m173qdXpgdQ8urp6yDPtMGeRfFDieIU3
         JZp5sZSDHOtqWZGB5Dc+2LF953evU1LMNMUhZYxAFAdaf2hM1214SGlaCddu8YzD40OO
         VVUDN6M6ItX/AdULCEpD+XSa4tOwI85ENj0cVREJP9dBXqXEPoKPRtfJ086+q4vU3TOm
         nQcA==
X-Gm-Message-State: AOAM5322keskCOKcIhdOVC8wIdJS57zscbXO03rcTGpXN+JRKSeBVsba
        KCc/Dhzha3w3GBP3y4OpVLs=
X-Google-Smtp-Source: ABdhPJwTYr80xdhkF6DAmqLB+Q2CxbEpRoiiEYyuf1CvwDdKaCXLrR6Ek0NzRds1DRSDXCtp6IhS3g==
X-Received: by 2002:a05:6214:2265:b0:433:2aa7:5a5a with SMTP id gs5-20020a056214226500b004332aa75a5amr12275641qvb.114.1646299300872;
        Thu, 03 Mar 2022 01:21:40 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m21-20020a05622a119500b002de3d0bdf28sm1084461qtk.45.2022.03.03.01.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:21:40 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     avifishman70@gmail.com
Cc:     tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, broonie@kernel.org,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: Use of_device_get_match_data()
Date:   Thu,  3 Mar 2022 09:21:31 +0000
Message-Id: <20220303092131.2060044-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-npcm-fiu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index b62471ab6d7f..71ed75bf0a20 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -671,7 +671,6 @@ static const struct of_device_id npcm_fiu_dt_ids[] = {
 static int npcm_fiu_probe(struct platform_device *pdev)
 {
 	const struct fiu_data *fiu_data_match;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
 	struct npcm_fiu_spi *fiu;
@@ -685,13 +684,12 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 
 	fiu = spi_controller_get_devdata(ctrl);
 
-	match = of_match_device(npcm_fiu_dt_ids, dev);
-	if (!match || !match->data) {
+	fiu_data_match = of_device_get_match_data(dev);
+	if (!fiu_data_match) {
 		dev_err(dev, "No compatible OF match\n");
 		return -ENODEV;
 	}
 
-	fiu_data_match = match->data;
 	id = of_alias_get_id(dev->of_node, "fiu");
 	if (id < 0 || id >= fiu_data_match->fiu_max) {
 		dev_err(dev, "Invalid platform device id: %d\n", id);
-- 
2.25.1

