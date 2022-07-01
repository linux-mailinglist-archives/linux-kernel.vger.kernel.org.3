Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DB562AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiGAFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGAFiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:38:21 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A451213D42
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:38:15 -0700 (PDT)
X-QQ-mid: bizesmtp82t1656653886tas9yn4g
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Jul 2022 13:38:05 +0800 (CST)
X-QQ-SSF: 0140000000200030E000B00A0000000
X-QQ-FEAT: NTY7odTD9S8eJmyIzlgWU+gO64fV4JWkdyCSwSeoGxiwH93mqtBnMse1UzN6w
        ItPCOk0cUCob25ONj8cT2VksNdth3vmhHtQ7HDDX1EIFKY8qqJYcb0x8kQdQySyYViwdz+7
        uR1Nv92Dmm3sH1Iyqrh6KsNaHxuPPyuGyheGK5rFsrQD0zPpsGuxbI3IM71iOkCe9YTDJcT
        sbRvCSzHIRv+SUciszEu9lT1gKsCuoM7gqqQ0Ve53RVP9LHgwY0GCKKrQqAJCuIsI9mTxuy
        ICDMDsvdU2vhRzO18n7jOH9fEVhAyo6GOE6zCQSdZ/7KwsiPaf3z2CGyJv5N8WY6QANJVlm
        v/9Ja/hbQtE6/ddrZY=
X-QQ-GoodBg: 2
From:   hmy <huanglin@uniontech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, hmy <huanglin@uniontech.com>
Subject: [PATCH] of/fdt:  extend cmdline is not avail when kernel grub config ends with "--"
Date:   Fri,  1 Jul 2022 13:38:03 +0800
Message-Id: <20220701053803.26165-1-huanglin@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index a8f5b6532165..5a289712c8fb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1162,6 +1162,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	const char *p;
 	const void *rng_seed;
 	const void *fdt = initial_boot_params;
+	char  *q __maybe_unused;
 
 	node = fdt_path_offset(fdt, "/chosen");
 	if (node < 0)
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



