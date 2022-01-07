Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF23C487C67
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiAGSqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiAGSqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99EC061574;
        Fri,  7 Jan 2022 10:46:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c2so5871010pfc.1;
        Fri, 07 Jan 2022 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SNHpzA6FkPy7IZMV8KM77XcancB04AysWoNYDyPct0=;
        b=S6U3Vkqir3kza+H4liGIRTeZGJqWgv9o/B9o7wDr0/MwSUjATAoUthqoTx8QGYcGER
         Jh8xNY4l2zZZWWibPug+69+o7fiq7zWmhcyl/tCJEmwEZ1VWebKObr8hZ7TmVevW5J8e
         NDh862oEF9oykH5ZVK+U2cn49mTHn3TBmdG7w4WiF4Eob8QLLTworwLDcy8+AZp7152k
         SI/sm+c0GWiUJx0dbDTSr6hbSexvyy3qsfHUaiY5WTveR2uX1zrpMeKeoA4ufZgOj0K6
         rHX0u4DhDJnSAr6zHmt4sshB9zZkqjd58gJoTtLZXn4S5nkd4puoXDpLiSvANj9OUaAM
         oS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SNHpzA6FkPy7IZMV8KM77XcancB04AysWoNYDyPct0=;
        b=G4q/Aelj7iiblvxzsnERtwKvJXSwbGBzZBsHvJMYhbDshsTEUNuzXlNW/Pj/3iZJLM
         5wT27QcufQ+pQETATMbUvBwXo10S5K592v6GxuHn4a989h5lTu/IOxVNEC3RyzSDuGzS
         Op0CjFMcUX7kcOCYkqLYc96ZEXMU8tpS9yaeeXOAfTPNQpE3XreZgD6TgT57j/RYFKP+
         cj6R6kVuitCeh81FSob9hHLVuB/ghxejbgKF60YH+wn4RWyCuh5wiXeRsH0SSszlK74M
         589hC0fQ5u5zIp2eUB9EpZ65aTj89IXiDU83Tmu6NDgDaIu7qU7nbRZqF9pcs0j6wxma
         YN5w==
X-Gm-Message-State: AOAM533bnqWfUTQcutxIehZnGCDbMTFq7zrztQ49fL2LrkGYpdI82Q7T
        paeeRemUnUT4I/JwAKQa18c=
X-Google-Smtp-Source: ABdhPJwLoQ8g8tvgpBidAKCpvCBwIXZ/nNmFCy9WLby+U1NoavHQE8vU5Q/IC0k1Evzx023BThFz5A==
X-Received: by 2002:a65:5c87:: with SMTP id a7mr58184852pgt.600.1641581199667;
        Fri, 07 Jan 2022 10:46:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:39 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: [PATCH v3 8/9] mtd: rawnand: brcmnand: BCMA controller uses command shift of 0
Date:   Fri,  7 Jan 2022 10:46:13 -0800
Message-Id: <20220107184614.2670254-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some odd and unexplained reason the BCMA NAND controller, albeit
revision 3.4 uses a command shift of 0 instead of 24 as it should be,
quirk that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index eab19df152f3..4759303ece7c 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -916,6 +916,12 @@ static void brcmnand_wr_corr_thresh(struct brcmnand_host *host, u8 val)
 
 static inline int brcmnand_cmd_shift(struct brcmnand_controller *ctrl)
 {
+	/* Kludge for the BCMA-based NAND controller which does not actually
+	 * shift the command
+	 */
+	if (ctrl->nand_version == 0x0304 && brcmnand_non_mmio_ops(ctrl))
+		return 0;
+
 	if (ctrl->nand_version < 0x0602)
 		return 24;
 	return 0;
-- 
2.25.1

