Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8735E59B546
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiHUPyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiHUPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:54:53 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8120BDD
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:54:52 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B8C80415F5;
        Sun, 21 Aug 2022 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1661097289; x=1662911690; bh=Ku00ZrVtdPNiED3i2tH0fKryi
        aGDaVN1a0m5ee0ZOks=; b=W0Q+54AA699WRAKFPnb2gaXCGDEifsoajPhzHKvWV
        ooA7uVk07+5KwBO9VV3HCY6CAx+sjFv2Uyd4SWvHH2JewowJu9kIPFRkNcvTLR+n
        bwu6+MkndCnsljMcV0rsjl8LcjHtIHVPRMWq+RZMgMej4BwnF0o/N7ffj47Y7GSR
        y8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ohLeA0VIuBhc; Sun, 21 Aug 2022 18:54:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 7FDE741370;
        Sun, 21 Aug 2022 18:54:49 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Sun, 21 Aug 2022 18:54:48 +0300
Received: from ik-yadro.yadro.com (10.199.18.154) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Sun, 21 Aug
 2022 18:54:45 +0300
From:   Igor Kononenko <i.kononenko@yadro.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     <openbmc@lists.ozlabs.org>, Igor Kononenko <i.kononenko@yadro.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] drivers/misc: (aspeed-lpc-snoop): Add regmap cleanup on a shutdown.
Date:   Sun, 21 Aug 2022 18:54:10 +0300
Message-ID: <f9814f62fe2d6b6c21400ee3c83e46e61e0c72d1.1661094034.git.i.kononenko@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661094034.git.i.kononenko@yadro.com>
References: <cover.1661094034.git.i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.154]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bmc might be rebooted while the host is still reachable and the host
might send requests through configured lpc-kcs channels in same time.
That leads to raise lpc-snoop interrupts that haven't adjusted IRQ
handlers on next early kernel boot, because on the aspeed-chip reboot
might keep registers on a unclean state that is configured on the last
boot.

The patch brings an way to masking lpc-snoop interrupts all through
a bmc-rebooting time.

Tested on a YADRO VEGMAN N110 stand.

Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8dfbeb..6ec47bf1dc6b 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -235,6 +235,41 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	return rc;
 }
 
+static void aspeed_lpc_reset_regmap(struct aspeed_lpc_snoop *lpc_snoop)
+{
+	u8 index;
+	struct lpc_regman_cleanup {
+		u32 offset;
+		u32 mask;
+		u8 val;
+	};
+	static struct lpc_regman_cleanup cleanup_list[] = {
+		// Prevent handling ENINIT_SNPxW
+		{ .offset = HICR5,
+		  .mask = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
+		  .val = 0 },
+		{ .offset = HICR5,
+		  .mask = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
+		  .val = 0 },
+		{ .offset = HICRB,
+		  .mask = HICRB_ENSNP0D | HICRB_ENSNP1D,
+		  .val = 0 },
+		// Reset SNOOP channel IRQ status
+		{ .offset = HICR6,
+		  .mask = HICR6_STR_SNP0W | HICR6_STR_SNP1W,
+		  .val = 1 },
+	};
+	for (index = 0; index < ARRAY_SIZE(cleanup_list); index++) {
+		u32 val = 0;
+
+		if (cleanup_list[index].val)
+			val = cleanup_list[index].mask;
+		regmap_update_bits(lpc_snoop->regmap,
+				   cleanup_list[index].offset,
+				   cleanup_list[index].mask, val);
+	}
+}
+
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     int channel)
 {
@@ -285,6 +320,7 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	aspeed_lpc_reset_regmap(lpc_snoop);
 	dev_set_drvdata(&pdev->dev, lpc_snoop);
 
 	rc = of_property_read_u32_index(dev->of_node, "snoop-ports", 0, &port);
@@ -345,6 +381,13 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void aspeed_lpc_snoop_shutdown(struct platform_device *pdev)
+{
+	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
+
+	aspeed_lpc_reset_regmap(lpc_snoop);
+}
+
 static const struct aspeed_lpc_snoop_model_data ast2400_model_data = {
 	.has_hicrb_ensnp = 0,
 };
@@ -370,6 +413,7 @@ static struct platform_driver aspeed_lpc_snoop_driver = {
 	},
 	.probe = aspeed_lpc_snoop_probe,
 	.remove = aspeed_lpc_snoop_remove,
+	.shutdown = aspeed_lpc_snoop_shutdown,
 };
 
 module_platform_driver(aspeed_lpc_snoop_driver);
-- 
2.25.1

