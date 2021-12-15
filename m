Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE4476421
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhLOVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhLOVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:03:02 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE72C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:02 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id m6so4324691qvh.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df9+jLGWpWWmT9NM3fIUAh5IVXi+6QBCR7ad2jz9wxs=;
        b=JzeCQwWGA2Y/dMp1IC8Y1WVUbgo5GqL9++OUCRZzN+3uREgW8CmSli1xUFG3hD34VO
         iSBckW1mjWpPLH+TBXPVe6C6AS1b1PybBiFfJ8rk20C0mvzdZgF0CvrVNV/RUNZK9lot
         DzhYCTou5DyMyM2BJ1LcwYhitMfRUqCyjSGTfV34Ds9fR6sDjdgDYvtIQb1VM205cM/B
         LVjPh0E2yPZzstwuuj7IQWmnvoeeC1bN3CKwZ56z7Ht2BFD1X6HZQZuqRQCk3P60p9it
         UFG4VxenQrnkUCWtDvqRR8PazIl2VlYuQ3nkKfSXWR3jjTvlut3hHx44wvIzseEC1Kt/
         Tijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df9+jLGWpWWmT9NM3fIUAh5IVXi+6QBCR7ad2jz9wxs=;
        b=wuAM7vxyi7Wypht1vLcPPzJN27aCPqSvW+krrj3vtbB150/s16bNrywBnZbTIASv21
         slsC/mqQjXtxdEZvKswbbBtrzI0FlV90TcubmumroDae4ArltdXFHVck5cBV2UNaApdn
         +Uq5Z15pnfij3YxOkWzA0VHK9Xx4KhFMSfPUy0XVekfXi7dTUWtKZFDHlx4P1wCg9KCl
         j9hpkh5ydf8xZjFWT7/6/0NP5r6sPVafkSIaILh7aVMn6SvykHhQCJQiBSzgZDPj9KJy
         AmUu4BTmjUieylhSeuIxAj7ItW7+a5CH3QK4R1S5XxKbZ7n/qTitSbYi3CwRyCTo3IRX
         55Uw==
X-Gm-Message-State: AOAM533uQDFdtqau6cT/C1qBi48fBWN+T6lMG3t9mOI3OZOsowAjQfiU
        ToP5Ct8QZuTappnIaUt7aBg=
X-Google-Smtp-Source: ABdhPJzHXdQm0FRg98q5/QgMAlc0JVYTPSGVQQd9VCPiFNJsnjMNmYl5B1HSmn6brcszCZCQc+qC+g==
X-Received: by 2002:a05:6214:260c:: with SMTP id gu12mr13331158qvb.87.1639602181519;
        Wed, 15 Dec 2021 13:03:01 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:03:01 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] phy: phy-rockchip-inno-usb2: support #address_cells = 2
Date:   Wed, 15 Dec 2021 16:02:47 -0500
Message-Id: <20211215210252.120923-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Rockchip devices have the usb phy nodes as standalone devices.
These nodes have register nodes with #address_cells = 2, but only use 32
bit addresses.

Adjust the driver to check if the returned address is "0", and adjust
the index in that case.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 1938365abbb3..5cfa7169d879 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1091,12 +1091,21 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		rphy->usbgrf = NULL;
 	}
 
-	if (of_property_read_u32(np, "reg", &reg)) {
+	if (of_property_read_u32_index(np, "reg", 0, &reg)) {
 		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
 			np);
 		return -EINVAL;
 	}
 
+	/* support address_cells=2 */
+	if (reg == 0) {
+		if (of_property_read_u32_index(np, "reg", 1, &reg)) {
+			dev_err(dev, "the reg property is not assigned in %pOFn node\n",
+				np);
+			return -EINVAL;
+		}
+	}
+
 	rphy->dev = dev;
 	phy_cfgs = match->data;
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
-- 
2.25.1

