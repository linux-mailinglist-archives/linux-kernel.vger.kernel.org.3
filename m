Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F62476420
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhLOVDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhLOVDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:03:03 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F46C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:03 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t83so21363226qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxn6GGaZuVidLca/WMl3sqT9jVHJLPvQP6VZiUsVJrY=;
        b=XaWurc0R+0NGNOVmgUDJyVMha1V09ZYhzefIqaFhfkj0OWCWJ2k2r296h/SAHvtQ4+
         NuTgnojrPxsYbSqfv296jcpMCB1OJbHpbWwEhzXk0OSplmoiAQy4DA652/H53A8EZhka
         4LCfn7mdyifEhwEIJ4AoE7nuPfAIwjCZONbsY2DCmQmIuF/bsjQOTfdpJA33ffWfHyZL
         M1imDOgnAb9viTpFk3htBEeCa9uJCBbenjA4+TGWsmYROojLlM2IaSDMd3Ag8c1Xam9d
         VocniaETqsUqF5oqKT6P+KHxsB85eVTfaGDDq4jCStFPQcetcGG3eSmzcS4UvAJRwO3G
         vWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxn6GGaZuVidLca/WMl3sqT9jVHJLPvQP6VZiUsVJrY=;
        b=T170Ncz65ZFyCe49ZI7IcwX6y1oAiK4u0Be1Eh+qMGv2K4CM4mBbLHrnURqwEadsie
         j67RqYAUK98Sy6hW1V2xw8iUu8tMN7napAe74aJRtbe7KvuBSjlgSGnJXfNGUfjOZnfl
         1CI8lQ1QgvNVdzChGD2u8W+EG9dE8m3GqsOpW5q7DVTz6L3HD9/ximlUULEvsTirWmwY
         orWihMAJKaCpeMxTkojZCPdslaYBe4F+DbaCcqg71Yi59sQ07WeGl7o3G+TY3wS/hg4J
         YkXydtMegsUF2zBMCxdCBPSCCmYIlvci3WWovm5h5GipolKexKROMENBwg47XGP8CNGZ
         2Axw==
X-Gm-Message-State: AOAM533lTtYo1tTmMnPbtNVbNho7oB9lCnXtXxe6536U7jcWRi2gckIo
        AX9XvKcKVYUrqXc+dBq+BYQ=
X-Google-Smtp-Source: ABdhPJwz8LraXYh5bgWPQ24gKaH1IILFk+lRM2zMLltMoydsz/oJ62aRgdKdO2xo/lVSfOzWaIbFzg==
X-Received: by 2002:a37:3d6:: with SMTP id 205mr10120606qkd.250.1639602182773;
        Wed, 15 Dec 2021 13:03:02 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:03:02 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] phy: phy-rockchip-inno-usb2: support standalone phy nodes
Date:   Wed, 15 Dec 2021 16:02:48 -0500
Message-Id: <20211215210252.120923-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Rockchip devices have the usb2 phy devices as standalone nodes
instead of children of the grf node.
Allow the driver to find the grf node from a phandle.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 5cfa7169d879..29e3a0da8c26 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1074,12 +1074,19 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!dev->parent || !dev->parent->of_node)
-		return -EINVAL;
+	if (!dev->parent || !dev->parent->of_node) {
+		rphy->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbgrf");
+		if (IS_ERR(rphy->grf)) {
+			dev_err(dev, "failed to locate usbgrf\n");
+			return PTR_ERR(rphy->grf);
+		}
+	}
 
-	rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(rphy->grf))
-		return PTR_ERR(rphy->grf);
+	else {
+		rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
+			if (IS_ERR(rphy->grf))
+				return PTR_ERR(rphy->grf);
+	}
 
 	if (of_device_is_compatible(np, "rockchip,rv1108-usb2phy")) {
 		rphy->usbgrf =
-- 
2.25.1

