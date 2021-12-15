Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125794755FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbhLOKOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbhLOKOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:14:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB2EC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:14:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y196so16177903wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:14:45 -0800 (PST)
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
        b=jMtSE8PTaUwZz2yjSyfN1siCU0ypJFBa4fPVYh+1pEBGiNqBfXP5F8ZP772SjbTzh7
         Uw7rg2N9FJGKSJbnDfEeYLDYiwMlruUH8Pn3MBhyyFUfDz+xX9mY3bcIt1BS70iyvsMl
         ZPyYeDAbDkpcSE5DO0RYqx8HYSY0MviIwbhpb0PuJWIVBkJ6JwJKbQEX9DZkyHzwSiPU
         JOL301Coa7Cih4z+ineMnaXHxZhmdW87Po8Kw0ZWJEMritbtBoJQZHbk+npxrMqXO5Or
         LWLySkodlNqAXJ05OQKGU2XaKyg+takDo/TwFx+SsgxzU2Ix8RWfRWa2M2J/tz3C3/tV
         reyQ==
X-Gm-Message-State: AOAM531MFOazdoqumLW4jKtB1rn5Vipo7RS32Ru9QwQSkr2Ts7+q6DvE
        ijYTUS6vJUDY8HqmQzanw+k=
X-Google-Smtp-Source: ABdhPJw86sym6o+0GNOn4CXPNXcanl17/6jY+y49t7BjLdrpLezjOXjBVNDVM8EBXKrbG5Psjxv2QQ==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr3955229wmk.92.1639563284568;
        Wed, 15 Dec 2021 02:14:44 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:6862:8ea7:f293:5328? (p200300ea8f24fd0068628ea7f2935328.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:6862:8ea7:f293:5328])
        by smtp.googlemail.com with ESMTPSA id g16sm1583066wmq.20.2021.12.15.02.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:14:44 -0800 (PST)
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

