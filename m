Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE95755A359
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiFXVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiFXVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:12:52 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F60A85D33
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:12:51 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 3DB9B16CF;
        Sat, 25 Jun 2022 00:14:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 3DB9B16CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656105250;
        bh=EVjSlxO14l8e2kikyRC3XsnI7trVHKvpd6yQROJjrNI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OqoNP7o33DjMdg1MucEEQUwgO9V3dACdAmJyRQbS+NuVHdtSDOuq13cZEWPkYVlH/
         igxFCz/JO/zZmRkmIv+nmS8aGWmoC8CsfuLqQa7qutxYhe9T9LEjzEvX956FVbyX1p
         yfUdmUj5hT/lbK92Pgb3njIYOPJzP56Xbb5YCW64=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 25 Jun 2022 00:12:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 2/2] bus: bt1-axi: Don't print error on -EPROBE_DEFER
Date:   Sat, 25 Jun 2022 00:12:33 +0300
Message-ID: <20220624211233.7529-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624211233.7529-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624211233.7529-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

