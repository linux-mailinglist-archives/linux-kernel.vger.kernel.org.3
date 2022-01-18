Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB28493038
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbiARVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbiARVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:51:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA107C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:51:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m1so959041lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=JeYoWwfchvNJOmrZgHyYDokoWzu/xjtZKfF1uxEPiY0=;
        b=4PrA+f6BhxoJRVWv4pzCCp7JcgyL+SZ4Hx2xPu+iqc8A34u9z7lX/pHyhw4ZVJ3DFt
         LbGrgWmC0g5mCDQAsOWOHwNYYYp4ADtFkqWRqC8zNoEACrugXDGqcCFbslSeGmaphapc
         VRoLdYETqUAuQ6ftH02tRJRcbUE7gh+LqMqgt8vHBSTJFJV1cWDRXYf5wWXhg4X66fMf
         yj7kyBw7Oei15CA4t4gjSgqEgim/yFU+OvSCLec/OdteG/CEtvdVKo6BJ6ihGUbBElNR
         XrQKNfC8Yn2lDXitCsoixlImwxs1QuCIdhPEceXSmTQz4ql/JsKktrwvbGP/aPIptWbj
         PaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=JeYoWwfchvNJOmrZgHyYDokoWzu/xjtZKfF1uxEPiY0=;
        b=qGdR6lxPUWRoLv0VbVHHTXzEMrgiWB8KKHgfzVuNjZgvwuT3UPltK4kiWa5+tzJGSO
         ymhLyNdAkGUxZ5QMlH5CXCP9Sv68BfwKGkwR8/m8yMFJLXtKA08cDWH7q2hqOLw5le66
         fzDEJVnoYtf42vZk9z4YDBKut9mHkgQfSum91aR57ge9EnPCVKth8mpp1e7VlGI7eZgW
         ygfHAqzF4S7hvMYgnG1yraSU9Eo1QDpgpiDck0QRZ1V1IClgm1d46qiPhI2TfvqIIg+o
         D1L+ox79ZwlFdw8ZrUKpBuy8YAtBg/CtKLCxbH9kqJ7YbjksuTkbyTnwQWM8LLxvI0OG
         kL8Q==
X-Gm-Message-State: AOAM530SeY5WdbxK+zybpKsqMqsWX8AzeWpi/GOeS7nPe9Vh0f6PTomi
        gGEeoljHq2CvkWPnGGuxiwCwXA==
X-Google-Smtp-Source: ABdhPJwG2GbqbOuxYvUygDn3T+Khl6cMcmtGwzlWfulo6HUOsG2urxLos90dWacYQlHql3n4YGYpag==
X-Received: by 2002:ac2:531a:: with SMTP id c26mr22724055lfh.356.1642542671173;
        Tue, 18 Jan 2022 13:51:11 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id w5sm1704808ljm.55.2022.01.18.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:51:10 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Timur Tabi <timur@freescale.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 4/4] net/fsl: xgmac_mdio: Fix incorrect iounmap when removing module
Date:   Tue, 18 Jan 2022 22:50:53 +0100
Message-Id: <20220118215054.2629314-5-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118215054.2629314-1-tobias@waldekranz.com>
References: <20220118215054.2629314-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by sparse: In the remove path, the driver would attempt to
unmap its own priv pointer - instead of the io memory that it mapped
in probe.

Fixes: 9f35a7342cff ("net/fsl: introduce Freescale 10G MDIO driver")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/freescale/xgmac_mdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index bf566ac3195b..266e562bd67a 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -331,9 +331,10 @@ static int xgmac_mdio_probe(struct platform_device *pdev)
 static int xgmac_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
+	struct mdio_fsl_priv *priv = bus->priv;
 
 	mdiobus_unregister(bus);
-	iounmap(bus->priv);
+	iounmap(priv->mdio_base);
 	mdiobus_free(bus);
 
 	return 0;
-- 
2.25.1

