Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12A57F63C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiGXRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGXRsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:48:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D811463;
        Sun, 24 Jul 2022 10:48:45 -0700 (PDT)
Received: from dslb-178-004-201-227.178.004.pools.vodafone-ip.de ([178.4.201.227] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oFfiT-0005LM-Lg; Sun, 24 Jul 2022 19:48:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 1/2] clk: imx25: print silicon revision during init
Date:   Sun, 24 Jul 2022 19:47:36 +0200
Message-Id: <20220724174737.212028-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220724174737.212028-1-martin@kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx>
 <20220724174737.212028-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the imx25 silicon revision when the clocks are initialised.

Use the same mechanism as for imx27, i.e. call mx25_revision.
This function is unused at the moment.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
changes in v3:
- rebase against today's linux-next

changes in v2:
- send the patch to the clk maintainers

 drivers/clk/imx/clk-imx25.c | 3 +++
 include/soc/imx/revision.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index 66192fe0a898..263409fca1eb 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <soc/imx/revision.h>
 
 #include "clk.h"
 
@@ -220,6 +221,8 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 
 	imx_register_uart_clocks(6);
 
+	imx_print_silicon_rev("i.MX25", mx25_revision());
+
 	return 0;
 }
 
diff --git a/include/soc/imx/revision.h b/include/soc/imx/revision.h
index b2a55dafaf0a..b122d2fc8881 100644
--- a/include/soc/imx/revision.h
+++ b/include/soc/imx/revision.h
@@ -22,6 +22,7 @@
 #define IMX_CHIP_REVISION_3_3		0x33
 #define IMX_CHIP_REVISION_UNKNOWN	0xff
 
+int mx25_revision(void);
 int mx27_revision(void);
 int mx31_revision(void);
 int mx35_revision(void);
-- 
2.30.2

