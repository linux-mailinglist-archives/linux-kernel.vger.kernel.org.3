Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61483481A96
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhL3IAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhL3IAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:00:43 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26CC061574;
        Thu, 30 Dec 2021 00:00:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r5so20840472pgi.6;
        Thu, 30 Dec 2021 00:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4uA7esXhcDSHJbZ7Mjo7PojXGD+W2Pww5KfPM/kIPPM=;
        b=ahUsvOxb+3Za/20OSG9KaukpQMgGmhNZR8IHwPHqa+ugUa7cUKcyWNLPF/XmVTPv00
         9LOfQcIuBZqOMrG7kLrrFQ86jwh3RoYtpfQsniAZSZ8C/ZWDxho8jl4KhI7vnJih12rE
         U4jYEpWyuSIyCEQrlAON8IhTxF24J6AsW8Y3aX3mI9lFr+f64Dm98jyffPUCkfPIIa7b
         jFe54gltc/jdGoUn8xvjn5vxTbWQItlGJBGOck+rSDvYSm4IE1rd03JSrctKzSgUHsYK
         A5/BN4QXrIkdEq7Vhm8FgvulwwkO//R+zgyVYmHyjrOc+I9Rzhh6+844rnc/ogxVeK67
         0nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4uA7esXhcDSHJbZ7Mjo7PojXGD+W2Pww5KfPM/kIPPM=;
        b=ybiAW/uNqfVFAehVVwVDZdjDPWerVxDyWanzE8DmEWQ6W5kIOhmdo192Gb3bbs4rsk
         PuvIfWvRaxI8qG0FW5Ksb4VlO23ytIORRevWcOHG9aZI+V4fGDKedu7QCfvIx8SqqaUN
         av7AL7gVUcSyMpjmI9jevRaW+Gi82/YOZDCjK2uB6FI4YoFLNtBfkwMtAch3N5rfWohQ
         uAyqvZu5KJx2wmHhIZd3ntkiTDgE0V39cx4d4JNixllHr3GGfcufQScQBr4JzuhV9beG
         X4FDF+HFmHcibG26QibTPJqMY6a9zpvnLI3MsctBExxfilcnOijV5yqNLX4pKg1EAxYP
         pasg==
X-Gm-Message-State: AOAM532HpmYYiyNLJ0bbaWGfv3cJeHCw37OcUwndsYQ0OUeL6cpEimPs
        c46wRzh9Tfc6URe+fZBUT1huYHTXhXfbNoynS5g=
X-Google-Smtp-Source: ABdhPJx760XrjH+HZrZC2Z2gnCQ76KWUvwcQX+asvmcEtoedQg1YwqeLV6jhb+13GWRJXgZUZos6vw==
X-Received: by 2002:a63:62c6:: with SMTP id w189mr25916919pgb.343.1640851242351;
        Thu, 30 Dec 2021 00:00:42 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k23sm4051598pji.3.2021.12.30.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 00:00:42 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: tegra: xusb: Fix missing put_device() in tegra210_xusb_padctl_probe
Date:   Thu, 30 Dec 2021 08:00:31 +0000
Message-Id: <20211230080031.26952-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_find_device_by_node() succeeds, tegra210_xusb_padctl_probe()
doesn't have a corresponding put_device(). Thus add put_device() to
fix the exception handling.

Fixes: 2d10214 ("phy: tegra: xusb: Add wake/sleepwalk for Tegra210")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index eedfc7c2cc05..05a0800af0e8 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -3170,8 +3170,10 @@ tegra210_xusb_padctl_probe(struct device *dev,
 		goto out;
 	}
 
-	if (!platform_get_drvdata(pdev))
+	if (!platform_get_drvdata(pdev)) {
+		put_device(&pdev->dev);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	padctl->regmap = dev_get_regmap(&pdev->dev, "usb_sleepwalk");
 	if (!padctl->regmap)
-- 
2.17.1

