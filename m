Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A22561052
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiF3EjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiF3EjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:39:00 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D66366A4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:38:56 -0700 (PDT)
X-QQ-mid: bizesmtp71t1656563923tyko63ek
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 30 Jun 2022 12:38:42 +0800 (CST)
X-QQ-SSF: 0140000000200020E000B00A0000000
X-QQ-FEAT: qBnuawaR0pu4uDA8sOwmwiyLzjBcRMiL0xpJp1Hl+xfrprQzKye1GFSgXCY2g
        NmeaO6vaMmHpbrRT4DTSz++Z2nYOZUhH+74nOrXpwbvvDTq302DC4yKteAtXYZyRZ3VA5Ma
        NVX9rJYYYsuBT7oFX0Ag4K/C1foriQWQ6LFF7hkS/CaBM+WSNjBZHsM66FQgA27qHVbXc22
        vAkInFEue3/vJRnmEKhIpc7Qj/N29CV5wdgjiuAq9FJUzA5kFGFMv8aCByrYi1fxY1OxZ31
        vYAXLYy4jj9EG2xAjL6jNnFjuBZz1kWUME4CDjB1P9PLv3lTQAO8hKBD7Vg3IA+jEatujre
        Fd72yCg
X-QQ-GoodBg: 2
From:   hmy <huanglin@uniontech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, hmy <huanglin@uniontech.com>
Subject: [PATCH] FIX CONFIG_CMDLINE is not avail when kernel config line in grub ends with --
Date:   Thu, 30 Jun 2022 12:38:23 +0800
Message-Id: <20220630043823.19242-1-huanglin@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when boot_command_line = grub-command "--" CONFIG_CMDLINE,
    parse_args() will exit and without parsing the contents of CONFIG_CMDLINE

Signed-off-by: hmy <huanglin@uniontech.com>
---
 drivers/of/fdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..696dc4179944 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1160,6 +1160,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 {
 	int l, node;
 	const char *p;
+	char *q;
 	const void *rng_seed;
 	const void *fdt = initial_boot_params;
 
@@ -1188,6 +1189,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 #if defined(CONFIG_CMDLINE_EXTEND)
 	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
 	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+	q = strstr(data, "--");
+	if (q)
+		*q = '\0';
 #elif defined(CONFIG_CMDLINE_FORCE)
 	strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #else
-- 
2.20.1



