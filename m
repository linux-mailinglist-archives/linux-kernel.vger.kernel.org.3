Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE64B3656
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiBLQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:18:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiBLQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:17:55 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398F20E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:52 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5p-0007YM-1u; Sat, 12 Feb 2022 17:17:49 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/10] staging: r8188eu: clarify that bb_reg_dump uses only path a
Date:   Sat, 12 Feb 2022 17:17:32 +0100
Message-Id: <20220212161737.381841-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212161737.381841-1-martin@kaiser.cx>
References: <20220212161737.381841-1-martin@kaiser.cx>
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

The path variable is always 0 in bb_reg_dump. Remove the path variable
and replace the constant 0 with RF_PATH_A to make it clearer that path
a is used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 548ed6f965f8..e815ae223f53 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3538,13 +3538,13 @@ static void bb_reg_dump(struct adapter *padapter)
 
 static void rf_reg_dump(struct adapter *padapter)
 {
-	int i, j = 1, path = 0;
+	int i, j = 1;
 	u32 value;
 
 	pr_info("\n ======= RF REG =======\n");
-	pr_info("\nRF_Path(%x)\n", path);
+	pr_info("\nRF_Path(%x)\n", RF_PATH_A);
 	for (i = 0; i < 0x100; i++) {
-		value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
+		value = rtl8188e_PHY_QueryRFReg(padapter, RF_PATH_A, i, 0xffffffff);
 		if (j % 4 == 1)
 			pr_info("0x%02x ", i);
 		pr_info(" 0x%08x ", value);
-- 
2.30.2

