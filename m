Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815FB4DC9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiCQPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiCQPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:30:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9010316F6CE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:29:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so9605379lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73OoSacSDvFhxxRgzZaXeE59BqLPs6obhzhzNPkozSw=;
        b=QUREg4kHWnnp6zurzo6oI5HEMeBnr61/oZMWQty1m0hGnaSy6HHU+Pfz50LUnG6gNd
         Jlu+274qPi6Az/jM03t9VrxgM7tpCFw83n6A31VPmmfesDnbJaQvy9j0DuaaQFPv7/fW
         J4pbig/s1jI787oVJzsc3ZG992IfU2uLezW9/Bm3sTdMqIu7n/SsAq1ZBSTlPCcbwQp0
         467sz6nDtQeedGX0wdjypIN4iy8ZKHc0QJOnV1voStHTwJEAUXaPBrh1XVvTi31wv6Z/
         W8nRkm7wEamzAiiPu3qqVmHiEhTq1PcRspyNw+r+JJ0UM85EfKr+NBgKqwMek6EntNKl
         7URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73OoSacSDvFhxxRgzZaXeE59BqLPs6obhzhzNPkozSw=;
        b=qyyZ3h2YsEaZe6h6j2uH/ltW15Z6EdIBwsdqe+nyMmwZXDAQ6UWLdeqSadHCQSkh3K
         12DOMh7V8kqSFVB2R6XHBqvzR/038FHTJe25BM5DtM4ku8OTR8VpI3iJpW24j6BxnXwA
         CdG6yY/Wlm66bpDvRI/qiqCVx0t8kAj9q3YZLIhdAFbhP2P3NZAuh4sDcJKQZiZM7ge2
         bDhlBw3eDxmHyF2C4VePIOm7eSUZRiDbKY2nS1cLrrWAayCRL4xPnQxKD2LN++MeJEPc
         CyGcYn/V009BtNeOgaLzS64BRF2Z50ErgN72nmLO5HDhW/uulNm1iR4r0W8Js5+gHrAQ
         Bw5w==
X-Gm-Message-State: AOAM5320E+Jc/3emPbGoYb9yyQ0qV0Yo7Eyoz3/iHrtQKL2QHKz/1aJH
        mVVuUkmawyzRYxxDz55ApYFhlQ==
X-Google-Smtp-Source: ABdhPJzLmU0zY5O6Hkp9EoPU07swOYLlw9GI/BmLO8proJ4mupQjGZDCZFz2uFy/Qopw0Y92YU405A==
X-Received: by 2002:a05:6512:2037:b0:448:92de:21de with SMTP id s23-20020a056512203700b0044892de21demr3216056lfs.52.1647530938721;
        Thu, 17 Mar 2022 08:28:58 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id m15-20020a2eb6cf000000b00247e82c1c32sm466565ljo.89.2022.03.17.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:28:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH] brcmfmac: Avoid keeping power to SDIO card unless WOWL is used
Date:   Thu, 17 Mar 2022 16:28:46 +0100
Message-Id: <20220317152846.246281-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Keeping the power to the SDIO card during system wide suspend, consumes
energy. Especially on battery driven embedded systems, this can be a
problem. Therefore, let's change the behaviour into allowing the SDIO card
to be powered off, unless WOWL is supported and enabled.

Note that, the downside from this change, is that at system resume the SDIO
card needs to be re-initialized and the FW must re-programmed. Even it that
may take some time to complete, it should we worth it, rather than draining
a battery.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Please note that, I have only compile-tested this patch, so I am relying on help
from Yann and others to run tests on real HW.

Kind regards
Ulf Hansson

---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 33 +++++++++++--------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index ac02244a6fdf..351886c9d68e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1119,9 +1119,21 @@ void brcmf_sdio_wowl_config(struct device *dev, bool enabled)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
 	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	mmc_pm_flag_t pm_caps = sdio_get_host_pm_caps(sdiodev->func1);
 
-	brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
-	sdiodev->wowl_enabled = enabled;
+	/* Power must be preserved to be able to support WOWL. */
+	if (!(pm_caps & MMC_PM_KEEP_POWER))
+		goto notsup;
+
+	if (sdiodev->settings->bus.sdio.oob_irq_supported ||
+	    pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
+		sdiodev->wowl_enabled = enabled;
+		brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
+		return;
+	}
+
+notsup:
+	brcmf_dbg(SDIO, "WOWL not supported\n");
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1130,7 +1142,7 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	struct sdio_func *func;
 	struct brcmf_bus *bus_if;
 	struct brcmf_sdio_dev *sdiodev;
-	mmc_pm_flag_t pm_caps, sdio_flags;
+	mmc_pm_flag_t sdio_flags;
 	int ret = 0;
 
 	func = container_of(dev, struct sdio_func, dev);
@@ -1142,20 +1154,15 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	bus_if = dev_get_drvdata(dev);
 	sdiodev = bus_if->bus_priv.sdio;
 
-	pm_caps = sdio_get_host_pm_caps(func);
-
-	if (pm_caps & MMC_PM_KEEP_POWER) {
-		/* preserve card power during suspend */
+	if (sdiodev->wowl_enabled) {
 		brcmf_sdiod_freezer_on(sdiodev);
 		brcmf_sdio_wd_timer(sdiodev->bus, 0);
 
 		sdio_flags = MMC_PM_KEEP_POWER;
-		if (sdiodev->wowl_enabled) {
-			if (sdiodev->settings->bus.sdio.oob_irq_supported)
-				enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
-			else
-				sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
-		}
+		if (sdiodev->settings->bus.sdio.oob_irq_supported)
+			enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
+		else
+			sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
 
 		if (sdio_set_host_pm_flags(sdiodev->func1, sdio_flags))
 			brcmf_err("Failed to set pm_flags %x\n", sdio_flags);
-- 
2.25.1

