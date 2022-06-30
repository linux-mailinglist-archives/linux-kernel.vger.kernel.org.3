Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE9056192E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiF3LaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiF3LaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:15 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE3451B24
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:12 -0700 (PDT)
X-QQ-mid: bizesmtp88t1656588607t477ilmz
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 30 Jun 2022 19:30:06 +0800 (CST)
X-QQ-SSF: D140000000200030E000000A0100000
X-QQ-FEAT: aP2oNmVYkM8sUCvPTo0LbC7fDuf56FZ3uAO5OAe5cfBDTxxb7RDtoPZQzzSFj
        sRVurMKpDP1KIa0156h+PDTo1ETZTZQbGG50cFR0X/NpSKbsiAWNI0ENgvMy3Nh6BL3eICg
        pl1GAsPEKgZp4xgLJG3YP+ZzIBcVnc4X+wKEkE/O9HJVxh39iOHMhzODE/pheudVt+ZkW+J
        5HKXymip9pE2KW4RgEQ9uaIb1jSSpI5ix6uhEjGvbGcJUFcgjWUCPjTsbZJwjh+yu2AVTR9
        isJZiDBbOX9mCk3u0MLI7jqoLaV7RbD/y/TNr0Af/9E8Dk321yL7qCm7t8hdfoVkryef69w
        WaEET6rbc5GgEaIHGg=
X-QQ-GoodBg: 1
From:   hmy <huanglin@uniontech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, "3127791@qq.com" <3127791@qq.com>
Subject: [PATCH] of/fdt:  extend cmdline is not avail when kernel grub config ends with "--"
Date:   Thu, 30 Jun 2022 19:28:39 +0800
Message-Id: <20220630112839.30941-1-huanglin@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "3127791@qq.com" <3127791@qq.com>

when boot_command_line = boot-command "--" CONFIG_CMDLINE,
parse_args() will exit and without parsing the contents of CONFIG_CMDLINE

Signed-off-by: 3127791@qq.com <3127791@qq.com>
---
 drivers/of/fdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..6f46dc94766d 100644
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
+	q = strstr(data, "--");
+	if (q)
+		*q = '\0';
 	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
 	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #elif defined(CONFIG_CMDLINE_FORCE)
-- 
2.25.1



