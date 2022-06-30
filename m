Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616B556196F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiF3LnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiF3LnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:43:21 -0400
X-Greylist: delayed 25469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 04:43:18 PDT
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56C51573B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:43:18 -0700 (PDT)
X-QQ-mid: bizesmtp69t1656589393ts5bmp7u
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 30 Jun 2022 19:43:12 +0800 (CST)
X-QQ-SSF: 0140000000200030E000B00A0000000
X-QQ-FEAT: Z953UCsBqO6kN67F+E0XhFu5sDv3aADX0KOi6NhRcYFQf6ThkFEWH3os3Xw57
        2GDt8n6vjXIoOOjYLh+YneA5hLjfw/hSlF154Z5tnTkPEXtsQ0BVVkPYXGe77e/W6ujyzpS
        SPqAy7Aoj90m5kKk4L9Pik2W2YfvereRIF2coVnzT3KapiN0X/xs4VRUhbctMhwScRKBjaG
        OvPHG/9r2mJ+DRjNzsjCIS+h8rBw171rKpMggmJTOUhtsF/FaX8Oufs62MUDZFBvjvWHKIg
        XD/xjweyR2rDoKlY+j7OL/Y97FW1mYYxqAkaU3SzoWXQqAypJ0pdqfa0Qsf/0Gi71EkX96k
        OOaVPjx6xZ2cD0YLrmBiKafBKDuw1e6c5gifm9/
X-QQ-GoodBg: 2
From:   hmy <huanglin@uniontech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, hmy <huanglin@uniontech.com>
Subject: [PATCH] of/fdt:  extend cmdline is not avail when kernel grub config ends with "--"
Date:   Thu, 30 Jun 2022 19:43:10 +0800
Message-Id: <20220630114310.830-1-huanglin@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when boot_command_line = boot-command "--" CONFIG_CMDLINE,
parse_args() will exit and without parsing the contents of CONFIG_CMDLINE

Signed-off-by: hmy <huanglin@uniontech.com>
---
 drivers/of/fdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..4a71acc172ef 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1160,6 +1160,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 {
 	int l, node;
 	const char *p;
+	char *q;
 	const void *rng_seed;
 	const void *fdt = initial_boot_params;
 
@@ -1186,6 +1187,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	 */
 #ifdef CONFIG_CMDLINE
 #if defined(CONFIG_CMDLINE_EXTEND)
+	q = strstr(cmdline, "--");
+	if (q)
+		*q = '\0';
 	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
 	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #elif defined(CONFIG_CMDLINE_FORCE)
-- 
2.20.1



