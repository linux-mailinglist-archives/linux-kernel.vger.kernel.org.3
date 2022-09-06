Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA64B5AE1AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiIFH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiIFH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:56:56 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29E1371704
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=x/egb
        LS48pTNBty2xojgAw1st7eopK8g5RnPNBeh3Rk=; b=OSoaIwO1iXZHF8+Pn7s0n
        VhX9DAUGr4AJqxilo5oav8eVElSrSOx2i0hu5BlnjiYs5j8X3jUDumcRWM6UyBeJ
        sBJtUgunMmguT/iJOfI0rmlBTxjY51EKPoTO9H++JCpkU1/cRmSFSaDQuNz52fb+
        XO1GQRDIf1bCXbeoeJd0Uc=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp8 (Coremail) with SMTP id DMCowAD3nSIh_RZjXrl6ZQ--.31024S3;
        Tue, 06 Sep 2022 15:56:18 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgeny Boger <boger@wirenboard.com>,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH 2/2] drivers: net: mdio-sun4i: Wait mdio write done
Date:   Tue,  6 Sep 2022 15:56:16 +0800
Message-Id: <20220906075616.21347-2-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906075616.21347-1-qianfanguijin@163.com>
References: <20220906075616.21347-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAD3nSIh_RZjXrl6ZQ--.31024S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw15KFW5AFyUCryrtr47Arb_yoWDJFb_ur
        93XFWkXrs8urZFqwnFkw4FvryIyFyUXFn7WF4aga98X348W3Z5uFWvvrn8Zrn7Wry8t3Zr
        CrnFqr1Iya4a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUrWrJUUUUU==
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbCqRx07V0Dg3ODzwAAsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

Data maybe written to the B register if the B register is reading
immediately after 'sun4i_mdio_write' write a value to A register.

Wait write done and fix it.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 drivers/net/mdio/mdio-sun4i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-sun4i.c b/drivers/net/mdio/mdio-sun4i.c
index 168e2a375535..72ac142f2edf 100644
--- a/drivers/net/mdio/mdio-sun4i.c
+++ b/drivers/net/mdio/mdio-sun4i.c
@@ -79,7 +79,10 @@ static int sun4i_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	/* and write data */
 	writel(value, data->membase + EMAC_MAC_MWTD_REG);
 
-	return 0;
+	/* Wait write complete */
+	return read_poll_timeout(readl, tmp, (tmp & 1) == 0,
+				 20, 10000, false,
+				 data->membase + EMAC_MAC_MIND_REG);
 }
 
 static int sun4i_mdio_probe(struct platform_device *pdev)
-- 
2.25.1

