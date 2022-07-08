Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777AF56C36C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiGHTqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiGHTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:46:03 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 575A588F11
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:45:50 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id D1E0316C3;
        Fri,  8 Jul 2022 22:47:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com D1E0316C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657309655;
        bh=Gjf4Wg6tDAxYDxNLlcgkoZo/rjD6uSfhRtCOK8F6Wrs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=TC7g4eYlnlpgV6Eb8c3K3boHFrX87ta016m1fE60SgQ3Cv6RkiaD15Xw6JNsUlHBR
         zRaeGzEG3PaVCfau56yxAMeHQZ+gdVSpxXRaTry55xe69L1/XaldXAavhb47OLSvre
         5Uz7CtJ5NdkEf9QlWj4j7aeqFs9hDlgFvBhZ+qog=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Jul 2022 22:45:48 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v4 2/2] bus: bt1-axi: Don't print error on -EPROBE_DEFER
Date:   Fri, 8 Jul 2022 22:44:48 +0300
Message-ID: <20220708194448.10700-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220708194448.10700-1-Sergey.Semin@baikalelectronics.ru>
References: <20220708194448.10700-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Baikal-T1 AXI bus driver correctly handles the deferred probe
situation, but still pollutes the system log with a misleading error
message. Let's fix that by using the dev_err_probe() method to print the
log message in case of the clocks/resets request errors.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Link: https://lore.kernel.org/lkml/20220610080103.10689-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Use the dev_err_probe() return value as the return status of the
  corresponding method. (@Philipp)

Link: https://lore.kernel.org/lkml/20220610104030.28399-2-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- Just resend.
- Rebase onto the kernel v5.19-rcX.

Link: https://lore.kernel.org/lkml/20220624211233.7529-2-Sergey.Semin@baikalelectronics.ru/
Changelog v4:
- Just resend.
---
 drivers/bus/bt1-axi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index e7a6744acc7b..70e49a6e5374 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -135,10 +135,9 @@ static int bt1_axi_request_rst(struct bt1_axi *axi)
 	int ret;
 
 	axi->arst = devm_reset_control_get_optional_exclusive(axi->dev, "arst");
-	if (IS_ERR(axi->arst)) {
-		dev_warn(axi->dev, "Couldn't get reset control line\n");
-		return PTR_ERR(axi->arst);
-	}
+	if (IS_ERR(axi->arst))
+		return dev_err_probe(axi->dev, PTR_ERR(axi->arst),
+				     "Couldn't get reset control line\n");
 
 	ret = reset_control_deassert(axi->arst);
 	if (ret)
@@ -159,10 +158,9 @@ static int bt1_axi_request_clk(struct bt1_axi *axi)
 	int ret;
 
 	axi->aclk = devm_clk_get(axi->dev, "aclk");
-	if (IS_ERR(axi->aclk)) {
-		dev_err(axi->dev, "Couldn't get AXI Interconnect clock\n");
-		return PTR_ERR(axi->aclk);
-	}
+	if (IS_ERR(axi->aclk))
+		return dev_err_probe(axi->dev, PTR_ERR(axi->aclk),
+				     "Couldn't get AXI Interconnect clock\n");
 
 	ret = clk_prepare_enable(axi->aclk);
 	if (ret) {
-- 
2.35.1

