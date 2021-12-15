Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541A94755FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbhLOKOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhLOKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:14:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:14:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso1080980wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:cc:content-transfer-encoding;
        bh=4J+Unl3XhdMp8B6pZM0WOABX8WJmG4ysRDdpuSeJCR0=;
        b=d2cK4j1HT27DODdn/cECHnwt6+YcZTlCRVfSS+xhiO1K29STpAWgyLpVhaUZQ6X4LL
         kxpviIxCEVFHjWvcithKF7WZ/iSJNelgWoNlwK8MCCph5/RI04U/rWHrU56DpajITnd+
         WKdU4X2iiqcxtVD9ryQmNtLwVC9gIQguHtVSHnk1/tfVDF7uKzjc0I7tCYRvdHshqs+x
         W/qJYORQYvK8rj/WuG4ZppSU0Elg4ptI0Kp9nnqKV5oIsHqbgvB/YagnEnXHxTni3dfR
         LOS4RC4WblDMIrA3i3kBaRMjwYtSvA/G6JasNhAmaBFCbAUXG/BJs0gHixu88eKQTZJt
         Og2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:cc:content-transfer-encoding;
        bh=4J+Unl3XhdMp8B6pZM0WOABX8WJmG4ysRDdpuSeJCR0=;
        b=38bSKbUtWa2olEDh4Z5IIK6ZvRhWeQAZhgUtaEJqqoVbPFgdFRsmJ2chRkl/s0stVa
         BNUOpVwTKc30JCPHMOsM4XVYNJvkroRQ3pIf7TmJDfRCFv/4127IOtDzWiES0+umrttm
         ng145itrIq+3o92o3uwOrsolFDYWHDWgUlPNcRU+kCADPVR9j5+bnhA35bpda7ex2BBS
         Jv5/lO7pOK8PnZOzSguT2e9kKxLVZa2j9CMTgyftwMmyovNehxnSbbioxymI+teSJK4F
         RGZ5FCSADzcSlYOwNPK5NoNYpe0VgHqOEhsePPn72vpxvYS8tTE6cfQNbfYFS525zqAz
         ZIHA==
X-Gm-Message-State: AOAM531DlTRy4BUYKfwb36Y0Ie2t1bQhMHf286wvDh3tIkDxWYzzaS7p
        uBuymtrurQnkRejPU9QQ9QpBEa4DiSU=
X-Google-Smtp-Source: ABdhPJzFw6jAIk+gHKFf2fczb6PB33zS0j95EBu/wMQseCh3YQVyBDKN6Xtco7B3P64DCR5xx4fvMw==
X-Received: by 2002:a05:600c:29a:: with SMTP id 26mr3843480wmk.86.1639563278900;
        Wed, 15 Dec 2021 02:14:38 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:6862:8ea7:f293:5328? (p200300ea8f24fd0068628ea7f2935328.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:6862:8ea7:f293:5328])
        by smtp.googlemail.com with ESMTPSA id t8sm1538060wrv.30.2021.12.15.02.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:14:38 -0800 (PST)
Message-ID: <ec24e13f-0530-b091-7a08-864577b9b3be@gmail.com>
Date:   Wed, 15 Dec 2021 11:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH resend v3] reset: renesas: Fix Runtime PM usage
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Language: en-US
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If pm_runtime_resume_and_get() fails then it returns w/o the RPM usage
counter being incremented. In this case call pm_runtime_put() in
remove() will result in a usage counter imbalance. Therefore check the
return code of pm_runtime_resume_and_get() and bail out in case of error.

Fixes: bee08559701f ("reset: renesas: Add RZ/G2L usbphy control driver")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- bail out in case of error instead of switching to pm_runtime_get_sync()
v3:
- add dev_err_probe() in case of error
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index e0704fd2b..46fcd2218 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -137,7 +137,12 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, priv);
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_resume_and_get(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0) {
+		pm_runtime_disable(&pdev->dev);
+		reset_control_assert(priv->rstc);
+		return dev_err_probe(&pdev->dev, error, "pm_runtime_resume_and_get failed");
+	}
 
 	/* put pll and phy into reset state */
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.34.1

