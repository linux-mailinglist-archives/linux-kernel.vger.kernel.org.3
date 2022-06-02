Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208853B4BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiFBIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiFBIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:04:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6669FDD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:04:08 -0700 (PDT)
Received: from ipservice-092-217-081-045.092.217.pools.vodafone-ip.de ([92.217.81.45] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nwfoH-0006H9-Hg; Thu, 02 Jun 2022 10:04:01 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] ARM: imx25: support silicon revision 1.2
Date:   Thu,  2 Jun 2022 10:03:42 +0200
Message-Id: <20220602080344.208702-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602080344.208702-1-martin@kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the mx25_read_cpu_rev function to recognize silicon revision 1.2
for imx25 chipsets.

Silicon revision 1.2 is mentioned in the errata document at
https://www.nxp.com/docs/en/errata/IMX25CE.pdf. The imx25 chips on my
test boards show revision 1.2 as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/mach-imx/cpu-imx25.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
index b2e1963f473d..3e63445cde06 100644
--- a/arch/arm/mach-imx/cpu-imx25.c
+++ b/arch/arm/mach-imx/cpu-imx25.c
@@ -32,6 +32,8 @@ static int mx25_read_cpu_rev(void)
 		return IMX_CHIP_REVISION_1_0;
 	case 0x01:
 		return IMX_CHIP_REVISION_1_1;
+	case 0x02:
+		return IMX_CHIP_REVISION_1_2;
 	default:
 		return IMX_CHIP_REVISION_UNKNOWN;
 	}
-- 
2.30.2

