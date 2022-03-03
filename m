Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA394CC344
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiCCQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiCCQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:52:44 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C819DE9F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:51:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j15so9524618lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8Lu3oFI2ZSXIjn4HjXJkzNerbpjcjtzRyNcVMXGM4A=;
        b=qu09WohgsJ0hjJOyszWoqeJPQoUnp8CED/1vHL0hzJnV/3MUQ1j90bmMqoD6Hzh7JE
         VFfKcYMk7dTuoYhKLN9R8wR2Ko5C+1oBs1/Km2IuTCdtebufAqR6+2ih5doOoWdsy2l3
         sz+6rftOqCstvRW08U7Al0P9YLy5tqIbRE1exjFS6xQAu/zPuM1kaDGpEcsXVewApGGB
         dcm+v3rORuzehmsyVG55C/QVKEc2B2yNGBM1oGsKSKN/W4IKL2XOHMzLstDfU4vmPRD+
         RwiRGgpptJI+jBL+82J2UBe4/hmrXJClISEcFlzkATPw/WGWM0xYo483CUgc7ieqB8Yw
         CMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8Lu3oFI2ZSXIjn4HjXJkzNerbpjcjtzRyNcVMXGM4A=;
        b=jZ5vp336yKKNmt/YK0vp09JZt/vq4Mul/R+Xzicvp5urA8ESTnlXWXzQegnSjvcdEX
         jb2vs70mhkImaAawFQtH8bog+dCdMZ7PpZLk8HRXZIZIdRTxVicc08sj6ZfzepHI1FkD
         HZau70E1O4IUOURxojXlXRcc3uJSyOYsOrtllKVX4kMUSxKRDvdDJeNdVXsTeCihN8LM
         yZFuZ8vQk2WIyLZQsgGlrJVOVX/BScd9JmQxJE4rshoyrTZ2U7Lyq8CXDvMNB29azhJw
         FeuOz0Av18EI7AUSFoePqY/Us0/extYgS19GCg+mxdThlb+ttg/myOEIjnJVsx2HkgOT
         meOg==
X-Gm-Message-State: AOAM53215psgHcIkSJaGLZq/ShhuezMvo//SvvBs5B9+9Mcl+gwh1/Ft
        0G5aMqov1XxcgbVUH9PanIXkyg==
X-Google-Smtp-Source: ABdhPJxqSxDqDpbg5z4fk4n3/acDJIJSK9XvXCRU68aYBiPocCyO6iolHI6ogsNslNeph62IASQexw==
X-Received: by 2002:a05:6512:1382:b0:445:9536:903 with SMTP id p2-20020a056512138200b0044595360903mr14611090lfa.89.1646326314602;
        Thu, 03 Mar 2022 08:51:54 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id q10-20020ac2528a000000b00445bcfca461sm519338lfm.249.2022.03.03.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:51:53 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: core: Drop HS400 caps unless 8-bit bus is supported too
Date:   Thu,  3 Mar 2022 17:51:51 +0100
Message-Id: <20220303165151.129806-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

When mmc_select_hs400es() tries to switch to the HS400 ES mode, it may bail
out early if the host doesn't support an 8-bit buswidth, as it's required
for the HS400 mode.

To improve the situation, let's instead drop the HS400 bits from the
capability field if the 8-bit bus isn't supported. In this way, we allow
the mmc initialization to continue by trying a lower speed mode.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c | 13 +++++++++++--
 drivers/mmc/core/mmc.c  |  5 -----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d739e2b631fe..2ed2b4d5e5a5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -590,11 +590,20 @@ EXPORT_SYMBOL(mmc_alloc_host);
 
 static int mmc_validate_host_caps(struct mmc_host *host)
 {
-	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
-		dev_warn(host->parent, "missing ->enable_sdio_irq() ops\n");
+	struct device *dev = host->parent;
+	u32 caps = host->caps, caps2 = host->caps2;
+
+	if (caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
+		dev_warn(dev, "missing ->enable_sdio_irq() ops\n");
 		return -EINVAL;
 	}
 
+	if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
+	    !(caps & MMC_CAP_8_BIT_DATA)) {
+		dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
+		host->caps2 = caps2 & ~MMC_CAP2_HS400_ES & ~MMC_CAP2_HS400;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 13abfcd130a5..141f851c9f58 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1355,11 +1355,6 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	int err = -EINVAL;
 	u8 val;
 
-	if (!(host->caps & MMC_CAP_8_BIT_DATA)) {
-		err = -ENOTSUPP;
-		goto out_err;
-	}
-
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
-- 
2.25.1

