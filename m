Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134604718F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 07:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhLLGuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 01:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLLGuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:50:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD28BC061714;
        Sat, 11 Dec 2021 22:50:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so12383526pju.3;
        Sat, 11 Dec 2021 22:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Vv5HnCBn8ZZpA7yWumcO3TVtFyNutN2LSOBDm38pII4=;
        b=lHproLaSO5xxAcZ7keHz60psiB6fnSyaocv07YHedRG0Ni2Sgdiu213n4n6BKu5n1X
         hF/kmfnosyvrSljTVUdQhGwq+T/anRyJ1z2WtNC8hHCeFCz/712L5Z45TjJy2IWlqtyj
         20oLbMA92hkwdqPlg7Xm0Rl1WbUCudBOUULoVH/RYWmh4UGHbZA9aKP7/kwv5+p5ww5U
         fxiJVTY8NuFVviJg81e1dlJ1JCN2+eghcYFNUcJ9iCH+W4ac9gaPZiynECOL3KflT5Gb
         SwAY8uuj0UA4seNSR4M824qTr8Srt1e7AcQJqYpBlkhmIwqDBe/4TFPLfNuTdvDg1rVd
         gibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vv5HnCBn8ZZpA7yWumcO3TVtFyNutN2LSOBDm38pII4=;
        b=u2itCKGs2Tf6LOvPXFzpco7K4Mdh7kBRttzv8aBFaFecjd7Y8z3ypb+tLSEJ9G9CTF
         SqeeJ5Igsctph3DoH2tzDU/9rrMlf9u/j0rOEoAiJQ3U/XZxNFKYJ1z5hF0rgEOZ+L6F
         9x+tHckwFoBNXzCi6dRpRw5GjgUTACXJ5g/o3xFYFy+5UchXD6NNxBhLrOdiq8EFMeVd
         QFndBag9kOnk83oodCQeWqb+EG7kP8i3Hzq7xBrIgjd72zhWENzIQVR3eC6dIuUDHDud
         TcLEAbk4ngLS1LjE9HOcw1H/v6DqWbGz0BNp82DP1VHR4b5xnNLUDENgQuKIfZEBRIhU
         w/Qg==
X-Gm-Message-State: AOAM5312IsG4d2JNrUpaLw4ewD3N0QkKXYLj/u24e68x51b2+riAfFvS
        iU/HuNQlU8eR08hcTht8T+4=
X-Google-Smtp-Source: ABdhPJwGWiBsr3aky1R6JtO8s875qTPMx14Q38lR67upO5k8arQsQEmsr43TObpKWSsNtL550Npx/A==
X-Received: by 2002:a17:903:2082:b0:142:7dff:f7dc with SMTP id d2-20020a170903208200b001427dfff7dcmr87437835plc.46.1639291819898;
        Sat, 11 Dec 2021 22:50:19 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q10sm2910261pjd.0.2021.12.11.22.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 22:50:19 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: tegra: xusb: Fix NULL vs IS_ERR_OR_NULL checking
Date:   Sun, 12 Dec 2021 06:50:14 +0000
Message-Id: <20211212065014.31660-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra_xusb_find_port_node() function may return error pointer when
kasprintf() return NULL. Using IS_ERR_OR_NULL to check the return value
of tegra_xusb_find_port_node() to catch this.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/tegra/xusb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 963de5913e50..52c2f85c67c3 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -472,7 +472,7 @@ tegra_xusb_find_port(struct tegra_xusb_padctl *padctl, const char *type,
 	struct device_node *np;
 
 	np = tegra_xusb_find_port_node(padctl, type, index);
-	if (!np)
+	if (IS_ERR_OR_NULL(np))
 		return NULL;
 
 	list_for_each_entry(port, &padctl->ports, list) {
@@ -763,7 +763,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	 * marked as disabled there is no reason to register it.
 	 */
 	np = tegra_xusb_find_port_node(padctl, "usb2", index);
-	if (!np || !of_device_is_available(np))
+	if (IS_ERR_OR_NULL(np) || !of_device_is_available(np))
 		goto out;
 
 	usb2 = kzalloc(sizeof(*usb2), GFP_KERNEL);
@@ -829,7 +829,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	int err = 0;
 
 	np = tegra_xusb_find_port_node(padctl, "ulpi", index);
-	if (!np || !of_device_is_available(np))
+	if (IS_ERR_OR_NULL(np) || !of_device_is_available(np))
 		goto out;
 
 	ulpi = kzalloc(sizeof(*ulpi), GFP_KERNEL);
@@ -884,7 +884,7 @@ static int tegra_xusb_add_hsic_port(struct tegra_xusb_padctl *padctl,
 	int err = 0;
 
 	np = tegra_xusb_find_port_node(padctl, "hsic", index);
-	if (!np || !of_device_is_available(np))
+	if (IS_ERR_OR_NULL(np) || !of_device_is_available(np))
 		goto out;
 
 	hsic = kzalloc(sizeof(*hsic), GFP_KERNEL);
@@ -970,7 +970,7 @@ static int tegra_xusb_add_usb3_port(struct tegra_xusb_padctl *padctl,
 	 * hence return 0 instead of an error to allow ports to be optional.
 	 */
 	np = tegra_xusb_find_port_node(padctl, "usb3", index);
-	if (!np || !of_device_is_available(np))
+	if (IS_ERR_OR_NULL(np) || !of_device_is_available(np))
 		goto out;
 
 	usb3 = kzalloc(sizeof(*usb3), GFP_KERNEL);
@@ -1035,7 +1035,7 @@ static int tegra_xusb_find_unused_usb3_port(struct tegra_xusb_padctl *padctl)
 
 	for (i = 0; i < padctl->soc->ports.usb3.count; i++) {
 		np = tegra_xusb_find_port_node(padctl, "usb3", i);
-		if (!np || !of_device_is_available(np))
+		if (IS_ERR_OR_NULL(np) || !of_device_is_available(np))
 			return i;
 	}
 
-- 
2.17.1

