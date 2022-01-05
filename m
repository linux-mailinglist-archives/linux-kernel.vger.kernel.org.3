Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624074852EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiAEMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiAEMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:39:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C19C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 04:39:53 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x15so29235883plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 04:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rv3hpFNoQ1qNkYinvHNFrNCrgnypW56t0xtrMZ/Tcys=;
        b=OJHBv7PiyuHflqragaXTgXu3E7LYLJ243q9wcpw9FGWUe1iH6uKRw2vj54dfKGMPe8
         njABLnC/HjMGzo9baUaFm4RIqUn9JpfV3tdjYoKLdyeIcEMNTQSZUTRR9G/Iu9BjwBsx
         vubYUEPucXSKBIk/PWvGu7M6zqzvG3Y2AKUxB13ByXrsLnDF0mlBuRg+T24bLbdAU20m
         QwH6wt/wLoZF3bcQXnU6QIj12K0Fprr5Y3wtPEfmSAS5XT//J9RCmOK/vWrkHtrq09nY
         XM1s0LOORSvo+HTU2l98VRCNIH9XBRIzCarGNxIvfnWIlMS8HZL34dkuzsZAZkAxl3Fc
         iGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rv3hpFNoQ1qNkYinvHNFrNCrgnypW56t0xtrMZ/Tcys=;
        b=sZURoR7qMQCJ0QDEhGbj55LVDjLe8+CDPvZGvyRxR6v0nu/JO3PAKE2ey3kf+Ds7XI
         KLbVuJ7t42Tuw68LaDI+tp1Iy5GKvu3XnczAWP7bwXmzGhZn78ewW7HgWnX2IBNkNsiR
         ibniP0sSAhNALgIUuH2SLaFnRcXjmmIB3G58FWHwirH3HN8Hfbq8pj8zEqTxowZr3NO2
         EmxpBTxxCsuU55CqBVpDnLtdex0mPVyUxSc2ir268V3Ge/yB+SPSulMtuwgP4aVHEHW6
         VOnR0ClmbjdHAzZILux1l3cCGrfulTGtOeYszNExkFc6OvbNHtEp59irytlYBdn1wIzj
         dFEQ==
X-Gm-Message-State: AOAM531At1neYTT5jnqHxykRzWxcPt0m83KgguSdeiyoKRybbwkzaBZS
        DOrYUQQdRuqKUa595MxR6CHZ1G8sis8V4w==
X-Google-Smtp-Source: ABdhPJwjPVuYIAQ6/OKekHMB/mC7cv9yZsPZ3C0OdkfEGpypRfrigp2wRx9yTMyuTypK8muinHXWUQ==
X-Received: by 2002:a17:90b:1651:: with SMTP id il17mr3946413pjb.10.1641386392590;
        Wed, 05 Jan 2022 04:39:52 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id t191sm37769008pgd.3.2022.01.05.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 04:39:52 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: mapphone-mdm6600: Fix PM disable depth imbalance in phy_mdm6600_probe
Date:   Wed,  5 Jan 2022 12:39:42 +0000
Message-Id: <20220105123947.17946-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: f7f50b2 ("phy: mapphone-mdm6600: Add runtime PM support for n_gsm on USB suspend")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 5172971f4c36..14666750946c 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -630,6 +630,9 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	if (error < 0)
 		phy_mdm6600_device_power_off(ddata);
 
+disable_pm:
+	pm_runtime_disable(ddata->dev);
+
 	return error;
 }
 
-- 
2.17.1

