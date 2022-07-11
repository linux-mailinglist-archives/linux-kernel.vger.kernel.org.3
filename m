Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DFC56C277
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbiGHTqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbiGHTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:46:05 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F26087361
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:45:49 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id ECC1016C2;
        Fri,  8 Jul 2022 22:47:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com ECC1016C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657309655;
        bh=y1DTHsN+7ZchbtK1/LYzLBSRwhnzdXBFd3LNm99BTAA=;
        h=From:To:CC:Subject:Date:From;
        b=FDB1zz9tnFxVZr4QNMUvuIITGGGYdNFkPcxqq7S5RSQCGactRA4Cwe5XJ3EYbpIF9
         L0jg21N0I/NlkS2xQKJYuUy5am69/h7qXT+4+PX2D2rAe9oa0IvI+5zF6DHwx+ENyN
         zmC2z3FD7UGoJe16WhC7ok5RXzik9McFmFLVW+uw=
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
Subject: [PATCH RESEND v4 1/2] bus: bt1-apb: Don't print error on -EPROBE_DEFER
Date:   Fri, 8 Jul 2022 22:44:47 +0300
Message-ID: <20220708194448.10700-1-Sergey.Semin@baikalelectronics.ru>
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

The Baikal-T1 APB bus driver correctly handles the deferred probe
situation, but still pollutes the system log with a misleading error
message. Let's fix that by using the dev_err_probe() method to print the
log message in case of the clocks/resets request errors.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Link: https://lore.kernel.org/lkml/20220610080103.10689-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Use the dev_err_probe() return value as the return status of the
  corresponding method. (@Philipp)

Link: https://lore.kernel.org/lkml/20220610104030.28399-1-Sergey.Semin@baikalelectronics.ru
Changelog v3:
- Just resend.
- Rebase onto the kernel v5.19-rcX.

Link: https://lore.kernel.org/lkml/20220624211233.7529-1-Sergey.Semin@baikalelectronics.ru/
Changelog v4:
- Just resend.
---
 drivers/bus/bt1-apb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index b25ff941e7c7..63b1b4a76671 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -175,10 +175,9 @@ static int bt1_apb_request_rst(struct bt1_apb *apb)
 	int ret;
 
 	apb->prst = devm_reset_control_get_optional_exclusive(apb->dev, "prst");
-	if (IS_ERR(apb->prst)) {
-		dev_warn(apb->dev, "Couldn't get reset control line\n");
-		return PTR_ERR(apb->prst);
-	}
+	if (IS_ERR(apb->prst))
+		return dev_err_probe(apb->dev, PTR_ERR(apb->prst),
+				     "Couldn't get reset control line\n");
 
 	ret = reset_control_deassert(apb->prst);
 	if (ret)
@@ -199,10 +198,9 @@ static int bt1_apb_request_clk(struct bt1_apb *apb)
 	int ret;
 
 	apb->pclk = devm_clk_get(apb->dev, "pclk");
-	if (IS_ERR(apb->pclk)) {
-		dev_err(apb->dev, "Couldn't get APB clock descriptor\n");
-		return PTR_ERR(apb->pclk);
-	}
+	if (IS_ERR(apb->pclk))
+		return dev_err_probe(apb->dev, PTR_ERR(apb->pclk),
+				     "Couldn't get APB clock descriptor\n");
 
 	ret = clk_prepare_enable(apb->pclk);
 	if (ret) {
-- 
2.35.1

