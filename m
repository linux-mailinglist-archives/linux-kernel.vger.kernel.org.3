Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF259B9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiHVGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiHVGgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:36:20 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645FF24BED
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:36:19 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id EB188412DF;
        Mon, 22 Aug 2022 06:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1661150176; x=1662964577; bh=whFlBZP+yR9KhM+S8ZHayWSEL
        7ddcPPVJQw/8yS0LJI=; b=YbI+l9rX9Po/xOaXVC9iyJEYlSZgC/aGmRBuJuqPB
        Z2bw7cakcrEEGhoJBSQBgBlFs+j67Km5QodOqneIhhE7AiNsxRPG+GnNIr6WPk6E
        Btxg9Il+Ynt2lg/tTbICV7lHjcWn9mCwU6ljo1oLUimNRH0HYnvYN5KWFqjd18zt
        1c=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NcYq-AMldSeq; Mon, 22 Aug 2022 09:36:16 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1F9A9412DB;
        Mon, 22 Aug 2022 09:36:15 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 22 Aug 2022 09:36:15 +0300
Received: from ik-yadro.yadro.com (10.178.113.33) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Mon, 22 Aug
 2022 09:36:10 +0300
From:   Igor Kononenko <i.kononenko@yadro.com>
To:     Corey Minyard <minyard@acm.org>, Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, Igor Kononenko <i.kononenko@yadro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] ipmi:kcs_bmc: Add cleanup regmap(interrupt-regs) on a shutdown.
Date:   Mon, 22 Aug 2022 09:35:57 +0300
Message-ID: <ad3cd046c4dcb9169aaff6c0b739b23d0a06014d.1661149313.git.i.kononenko@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
References: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.113.33]
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

The previos v1 [PATCH 1/3] have error of getting `struct kcs_bmc_device` 
pointer from `struct platform_device *`. Replaced to retriveing pointer by 
`platform_get_drvdata()`

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index cdc88cde1e9a..8437f3cfe3f4 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -636,6 +636,14 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void aspeed_kcs_shutdown(struct platform_device *pdev)
+{
+	struct aspeed_kcs_bmc *priv = platform_get_drvdata(pdev);
+	struct kcs_bmc_device *kcs_bmc = &priv->kcs_bmc;
+
+	aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF), 0);
+}
+
 static const struct of_device_id ast_kcs_bmc_match[] = {
 	{ .compatible = "aspeed,ast2400-kcs-bmc-v2" },
 	{ .compatible = "aspeed,ast2500-kcs-bmc-v2" },
@@ -651,6 +659,7 @@ static struct platform_driver ast_kcs_bmc_driver = {
 	},
 	.probe  = aspeed_kcs_probe,
 	.remove = aspeed_kcs_remove,
+	.shutdown = aspeed_kcs_shutdown,
 };
 module_platform_driver(ast_kcs_bmc_driver);
 
-- 
2.25.1

