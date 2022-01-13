Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B397348DDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiAMSok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiAMSoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:44:39 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F78C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:44:38 -0800 (PST)
Received: from localhost.localdomain (83.6.165.232.neoplus.adsl.tpnet.pl [83.6.165.232])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 103461F5EB;
        Thu, 13 Jan 2022 19:44:34 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction on READID
Date:   Thu, 13 Jan 2022 19:44:26 +0100
Message-Id: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I have absolutely 0 idea why and how, running clear_bam_transaction
when READID is issued makes the DMA totally clog up and refuse to function
at all on mdm9607. In fact, it is so bad that all the data gets garbled
and after a short while in the nand probe flow, the CPU decides that
sepuku is the only option.

Removing _READID from the if condition makes it work like a charm, I can
read data and mount partitions without a problem.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
This is totally just an observation which took me an inhumane amount of
debug prints to find.. perhaps there's a better reason behind this, but
I can't seem to find any answers.. Therefore, this is a BIG RFC!


 drivers/mtd/nand/raw/qcom_nandc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 04e6f7b26706..506006ccdf1a 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1459,8 +1459,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
 
 	clear_read_regs(nandc);
 
-	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
-	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
+	if (command == NAND_CMD_RESET || command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
 		clear_bam_transaction(nandc);
 }
 
-- 
2.34.1

