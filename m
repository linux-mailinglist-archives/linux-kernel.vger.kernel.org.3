Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D455F4F7815
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiDGHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbiDGHuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:50:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD030E9CBF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:48:12 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KYtg30z7mzBs1D;
        Thu,  7 Apr 2022 15:43:59 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 15:48:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <yuehaibing@huawei.com>, <mcgrof@kernel.org>,
        <tangmeng@uniontech.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] reboot: Fix build warning without CONFIG_SYSFS
Date:   Thu, 7 Apr 2022 15:48:07 +0800
Message-ID: <20220407074807.1580-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SYSFS is n, build warn:

kernel/reboot.c:443:20: error: ‘kernel_reboot_sysctls_init’ defined but not used [-Werror=unused-function]
 static void __init kernel_reboot_sysctls_init(void)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~

Move kernel_reboot_sysctls_init() to #ifdef block to fix this.

Fixes: 6e73c8344931 ("kernel/reboot: move reboot sysctls to its own file")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/reboot.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ed4e6dfb7d44..ecbf09ea03c5 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -421,33 +421,6 @@ void ctrl_alt_del(void)
 static char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
 static const char reboot_cmd[] = "/sbin/reboot";
 
-#ifdef CONFIG_SYSCTL
-static struct ctl_table kern_reboot_table[] = {
-	{
-		.procname       = "poweroff_cmd",
-		.data           = &poweroff_cmd,
-		.maxlen         = POWEROFF_CMD_PATH_LEN,
-		.mode           = 0644,
-		.proc_handler   = proc_dostring,
-	},
-	{
-		.procname       = "ctrl-alt-del",
-		.data           = &C_A_D,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-	{ }
-};
-
-static void __init kernel_reboot_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_reboot_table);
-}
-#else
-#define kernel_reboot_sysctls_init() do { } while (0)
-#endif /* CONFIG_SYSCTL */
-
 static int run_cmd(const char *cmd)
 {
 	char **argv;
@@ -895,6 +868,33 @@ static struct attribute *reboot_attrs[] = {
 	NULL,
 };
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_reboot_table[] = {
+	{
+		.procname       = "poweroff_cmd",
+		.data           = &poweroff_cmd,
+		.maxlen         = POWEROFF_CMD_PATH_LEN,
+		.mode           = 0644,
+		.proc_handler   = proc_dostring,
+	},
+	{
+		.procname       = "ctrl-alt-del",
+		.data           = &C_A_D,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{ }
+};
+
+static void __init kernel_reboot_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_reboot_table);
+}
+#else
+#define kernel_reboot_sysctls_init() do { } while (0)
+#endif /* CONFIG_SYSCTL */
+
 static const struct attribute_group reboot_attr_group = {
 	.attrs = reboot_attrs,
 };
-- 
2.17.1

