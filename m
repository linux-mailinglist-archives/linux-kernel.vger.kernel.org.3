Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52B486E78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbiAGAOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbiAGAOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453BEC034000;
        Thu,  6 Jan 2022 16:14:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 8so3971808pgc.10;
        Thu, 06 Jan 2022 16:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SNHpzA6FkPy7IZMV8KM77XcancB04AysWoNYDyPct0=;
        b=JP9sJd36LaI6tlWTPYV3ZZDcnPvpmIW8ju10dauCV4wFKrx+oYVjK1Vg3n703qn0EZ
         MdBllUijLJzXq3CEBDLTaMZTa5WV7C3rkl+Q5UYal4JZiajT/M9woR2rjAx23HQFuuqv
         ADcbGpP4IJIc8ZScXm2GU90D8lTnsC376ceOZgBJ5jLI5NZaqzuSoGpw1z1fj4r8/XuV
         iIwbJVnOpR1S7VvCgwu3t8ZP6+JiFUrXxxDWeM5hPnVWx6qaUf4lhSswo1gz09HiT16v
         IGVU+JFNgxj532d/kpLxXQUU7b8MYG6HlweKRzkuL1fB5FfrPhHiG3pv0+DzQYUU+3rK
         2p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SNHpzA6FkPy7IZMV8KM77XcancB04AysWoNYDyPct0=;
        b=Uwwv7f8jesETUIzXH2SaKUqfmp9W/vmiilSR2DG5OMgACCPr1HEBPFM52A0CCspYuA
         cMr93S67AhzCzjOtbFumQkDbfpq7M6KH+9UvEXkRBdb95g/g78xP100GgkYRfz22Kq7Z
         63m+gWAScdNQXI6RRes4eOXflZzhC5I2ruW5+c0nv14fGDWNoXW60NNwIe1Bc9+aQlE5
         gVU+q/z6ER9eE0gSQnx59I7oWFOxBUdTptW6EnTlYF9ND2jO8oa6kGEWcv+3aMAYTLMM
         XEGZsDqt4GHJaKtFbPkOAKJht2sC6zE7qmHyby+9PVaNtJhAG86zlll80bJOOEamf52D
         nAkg==
X-Gm-Message-State: AOAM530WTQtfLgbMs7djdsv/pLPCO76pHZjjmNAizPiPxTOkON+evdaz
        ynEol7oJGpOe9DEheKoTo8M=
X-Google-Smtp-Source: ABdhPJxFvTDquVB7tDgTiBL/lsdMzOHLV9K5SLroi1l0ri57BVl98cr4OCpu5EGippZkIDsDh6Dbbg==
X-Received: by 2002:a65:498e:: with SMTP id r14mr54303628pgs.47.1641514454766;
        Thu, 06 Jan 2022 16:14:14 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:14 -0800 (PST)
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
Subject: [PATCH v2 8/9] mtd: rawnand: brcmnand: BCMA controller uses command shift of 0
Date:   Thu,  6 Jan 2022 16:13:27 -0800
Message-Id: <20220107001328.2233896-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
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

