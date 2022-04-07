Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875DB4F77BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiDGHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiDGHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:39:43 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF81853E2E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649317056;
        bh=qIYpRIIGIZS6wznmSd1MMDOKoS66e0FCfSniC9O6YO8=;
        h=From:To:Cc:Subject:Date;
        b=k9/DIsZFXTUX3VT2nhO6wT5hRErr6YLuQJVBWohdxPNGuNxx9myjxQ3nhqw2vcyY/
         t+1Fc4uF4IHuAhTHNgYn+60n4E+qSqDUp6FIBfna6Cmpvx1OuXYulqNi4fQd/B/G21
         +mkPcenZAoej0BPuYt9bj8iBDgixaCMD4kp/0dYU=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 95F9B854; Thu, 07 Apr 2022 15:37:31 +0800
X-QQ-mid: xmsmtpt1649317051tejii460c
Message-ID: <tencent_27FF59903EE6AB5C0D0E6D0A8E7059A59007@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iC6dVTi0w/K2/r2cPQgQ2DFLTrf+BMVpkat8EXSvi5QcmiBXXBxE
         +EbsXIPZxYM48llGGFI7YiycvP3J39n27EiKyTjwnpV0pmzpFuh1Ydrrk7FRzwPiIyG+WGId3y1v
         +87S3ViPl0ujHBcpvBgRUvvqphw1l5z93+AD1g81EF5iAxX1i97wWBSAqoeiruyhdMQQBGrs7h9f
         K1ofMxYadZpJ+yyepf8yiqd+vT41kYRqK6fjkjwjUq90vYAB6/qDJYZ2yZ9mhAsIj8K8hZcCp95l
         HKVO/nulyPJYtvBmMAYWZ5f64BfnD+fCJGUAW/uYtU86LIdUGlgOvSeBRxWsiVrhLz1z/JETwykH
         SCoqiVKCHEjSWCW3mv/WlLZU3rPD43SlkK5r79/wZcF1yIDUyMKirLli+uVKUutIYWe5ZAWAEUjI
         LtLZWAIOjM2pqHd9rhaycpgC6vdYWIcFXNJPXmwXW21302b6FTwpngn5DbglMKBWEs0/PDRtxoqH
         QbkEpZFJsquywnE4rbPsC0FdPuzHnvTZEtwSmMet8fMhcyt4W4pAvxdnV95gGSee1R4RDekvmDqn
         dhf7rSpmJHoCyEdt76YPM4XqcMIpF4mZMOEdhI2aiGWnBTF7QHo3KJZSkcuKwBp8wFs+ro2PLR2a
         3+0dApzm9QX4pd4WjkJl6Ye7A6NJR+tTm7a1ZdCjZ14NF6+HP4B44RSsJzghT9PjN26BYxvOtb52
         VP8zlP6DdjAi0ucYtFI6TNEicLH946xf7zCQMzPpe+9Rx3k0n9KnLnabAChR7kiqpvRxia5su1TH
         b8ht0JAGUuC1tc7v9VguXoxh7ddmVLimy480C0N2E0ZQqA7DPJWI21/9mujBXBYgaSoRggn6b0lu
         fmuhLGKK0VVnhT6AzGcS0CaAR45EbK+9XOw7HwXYB/s23Nw8i863ALaYwHPpcQkIE/EFrYLWXZOb
         BwUgadjM5L6e05Is013V/KXlRIJxf9
From:   xkernel.wang@foxmail.com
To:     abel.vesa@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] clk: imx: scu: fix a potential memory leak in __imx_clk_gpr_scu()
Date:   Thu,  7 Apr 2022 15:37:22 +0800
X-OQ-MSGID: <20220407073722.13934-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In __imx_clk_gpr_scu(), if imx_scu_clk_is_valid(rsrc_id) fails, then
`clk_node` which is allocated by kzalloc() is not properly released,
which may lead to memory leak.
So this patch added kfree(clk_node) on the above error path before
return ERR_PTR(-EINVAL).

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/clk/imx/clk-scu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31..ed3c01d 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -837,8 +837,10 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
 	if (!clk_node)
 		return ERR_PTR(-ENOMEM);
 
-	if (!imx_scu_clk_is_valid(rsrc_id))
+	if (!imx_scu_clk_is_valid(rsrc_id)) {
+		kfree(clk_node);
 		return ERR_PTR(-EINVAL);
+	}
 
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk) {
-- 
