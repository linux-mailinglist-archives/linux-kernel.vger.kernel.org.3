Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E89F52EB10
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbiETLnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbiETLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:43:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3317E15A74B;
        Fri, 20 May 2022 04:43:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so11289327pjb.2;
        Fri, 20 May 2022 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/xyoqkIvhfgBM1R/pjz/c5Tr/c0eTmfasuHvGueSGA=;
        b=E3lOmoRFlOjxGHQDXs7cJf+HWAAZZ657dnehtNx5da0GaOhXpguTlSuwp+7YxD2U6G
         tUeg8HfmUkxOwpEW4bcR99LqEpfE1sQL8B+h4grfBbLZM0qGLWhNsnlaliulhkefbtEc
         YsTN/Ehr7vjeEEEzNtdU5GibsXVpBj4OY6KasC13TR5un4WbH6dhVtGIrs71BaJeuNnL
         twiQtPdR8AOg6A4iBXaINGXmW1HHQ3OZNuM+nlvwy04oeSXPxoImHdJRwf2OyNJirjYH
         tCrQDQhOtAT1BZ9aGmJ+QKp66YApNeN4RWWL+Kn33leyLvkZb8JydN99flQlD+j50+Hx
         O1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/xyoqkIvhfgBM1R/pjz/c5Tr/c0eTmfasuHvGueSGA=;
        b=k0OIMqALFJnBz4osFwYVYTMlkBinVs4EomsJYzPuGDd8nUNIcTTcYa0YgDbLei2TjI
         IsyYzD2U8Byreb8lt1k+OtORvT/LNWi1OTb0y5iucnJ6VQ/AcGoy3s4M+3uZZxnR1Rcw
         /w0s3qCGC5EjBCkDC5OaXo74xkBU7BMTUNLxWHhm2LOhjScQcTmS8pmOKJlPg3SERhZh
         Nx/e8MOs5aaWnw6lI9cSskRqIol0rnVsq4rUN4ckeHkv1TWFGJvmzf9T5pFZd9faUJX0
         Giy9M3zD3voxaOzdY3ivrFdfDp7P2b+MqR6m2ML3SNzCaEdz4ZubW9cTikbVh7oT1cK7
         IVjg==
X-Gm-Message-State: AOAM533KqDscXEfAXwRxU4YXodLYOxMpfaNkTwO9Rd1yMDKWgbegz0Oy
        i8Tjq+XZ+RAyPlq3OdIBZuk=
X-Google-Smtp-Source: ABdhPJzm5Sgk+3QTFye3qt75CV2NmIm3tHPvNd0i8hsyfjED3q8+LigmehXbM79CdKWBtmpTzYsYjA==
X-Received: by 2002:a17:90b:1a8b:b0:1dc:e565:3238 with SMTP id ng11-20020a17090b1a8b00b001dce5653238mr10586140pjb.64.1653046980673;
        Fri, 20 May 2022 04:43:00 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b00161955fe0d5sm6042050plh.274.2022.05.20.04.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:43:00 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw,
        kane.chen@intel.corp-partner.google.com,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RESEND, PATCH] mmc: sdhci-pci-gli: Fix GL9763E runtime PM when the system resumes from suspend
Date:   Fri, 20 May 2022 19:42:42 +0800
Message-Id: <20220520114242.150235-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.36.0
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

When the system resumes from suspend (S3 or S4), the power mode is
MMC_POWER_OFF. In this status, gl9763e_runtime_resume() should not enable
PLL. Add a condition to this function to enable PLL only when the power
mode is MMC_POWER_ON.

Fixes: d607667bb8fa (mmc: sdhci-pci-gli: Add runtime PM for GL9763E)
Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
---
Hi,

Sorry, resend this patch because typo two email addresses.
Sorry for Adrian and Kane.

Best regards,
Ben
---
 drivers/mmc/host/sdhci-pci-gli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d09728c37d03..d81e5dc90e15 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -972,6 +972,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	struct sdhci_host *host = slot->host;
 	u16 clock;
 
+	if (host->mmc->ios.power_mode != MMC_POWER_ON)
+		return 0;
+
 	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 
 	clock |= SDHCI_CLOCK_PLL_EN;
-- 
2.36.0

