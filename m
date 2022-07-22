Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1257E981
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiGVWId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiGVWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:08:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B30BA4EA;
        Fri, 22 Jul 2022 15:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoJpNnU99ITf1DbqOtJ3WMEn73y+Hhk5sK5y3RDoQ35qkY89oIyt8rUw9rhUinL/mnAQr5cII+ADkjIScsuC8AqCwblJpWn3sBPSSOdE4JOPRfQp89+vYKi8tGOG98NQUCbe05jVchkxKdhddOSWZFiTy0o1SEMmonfOKqxhrIhVZ69/KbeABrSErGfFHmiHPkmlYpI4t0qlEPIjliOIA5aHS8m6xDK1nClyqTK/gw82wtJUNojST/YrmBplR2rAFb//IW3npSdGOIX96+g4z+GH9g8+alykzgaZ5imWUShEBfkNcm/n+ss1pXWahgnxCzTJnMLTOmblK7hjB3imsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMDi3wzRhIchYJNFKCIJ+He++4E0u351Yjd/eH2hQ0E=;
 b=Nu4TOYpMpvZOAYWxmjJfxXO+JZ9+cvCdafJSsMrRhmMhssHtUSjoHkXLc3xVjQM9qDJQXeFJMhbeSGUGIkzBABzzNOb7BSFCN2xJZS9coOIDaucJwjFR62TJ+EaB1ylAh/GmO2cmKy1KVbxfe/J/4tKc//ytG4W2UqKe3V/zpPx01SUibjSbYbdR+6hjpbfvwaKcVu0xfK7bnvwmbAz/u8X76c0UitDLaZtN+GmZ8oKC1uJNqDZ+gs5LVvtAyu+JuIIZgVu40393BnPSyTAU0l739X3FPWtBS/AGF/qT5yi0XvcNxjDvsbnfzrfzoeHXK7Q3KUTq7JfsLdbAFz839g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMDi3wzRhIchYJNFKCIJ+He++4E0u351Yjd/eH2hQ0E=;
 b=b2nGMGjOtw672pj55j3T2fHhYSKj3Tmxl6jsOE8zwJQE8S3Pp2K9LDF4iiFQhUNyqSCeMWz6uuWVYxdYHHAnb/QXVlFLuqASs/+outIkDMsKZ4IklcecYIzUZbgDOk/IF3kALRmvdgD3GcxZwNNWxFd2ccEWoD9AA9rKZkIrLPs=
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by CH2PR12MB4006.namprd12.prod.outlook.com (2603:10b6:610:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 22:08:17 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::7) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 22:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 22:08:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 17:08:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] pinctrl: amd: Use unicode for debugfs output
Date:   Fri, 22 Jul 2022 17:08:10 -0500
Message-ID: <20220722220810.28894-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722220810.28894-1-mario.limonciello@amd.com>
References: <20220722220810.28894-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80cf0bd2-049a-40c4-2c3d-08da6c2eae41
X-MS-TrafficTypeDiagnostic: CH2PR12MB4006:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZF8B9H7KM2tD7xpMOMsuFYi7VzWERb65frxoZiohfkwvxCLb56HtxVclF8Slyt21lESCGCNdV7+AzJ/HzZTRfuvuNRluHrxRUkvWWYJwe1ijkPkYHX1GheJC3n17vlJiqxf9Lxvak/S26V6GV+NqQHcm43kld1keiu92pDx/oJsFilYXBoXXPll6ABvH2yTAs1iWXF2hcucGLAku8+L3NQXEC3sylvH6V+S/qaS/9YUpzNv9V+zZ8RclRbNW0B58mvgioCuzkhTQVAPW0wP5dveLNcXyxp/gbUk7l5cKltWYOLRN6DlTrwca12Dx697aaNIsuiUje5lKjM0IQPIyAVDuV7IMKhuLNfiBT5J/VQ9VEFbI4S6Q6hko0blfTRkmU4xMNW6iKRcNwpEvhjt7E7fAZdrQt8tZie92H0zmJ632ctjrQUGp7sw9kBLzET+U315tYGVQjGp2P3tpCMe7ydRdS9BhzRiBE0ATa0jktNDEwNJooQ2aJwEutt/lob23i486SiIeH2rWNeJtz5nwO6aR+4uz3XjoHW3YBNT0LkG0qf5t1kT9+y1GQ0JcDqBFQMDYR6dHntdnQzuC29VrUuqWxvq6y6ceUcl7Auq7mlqyE/KtjdUapLDa9/TwD8edRuZ2ZPGwmkOaXl/41BVKpOJiXttZjucw7LYeoXqyCGimXL/0d7Ny/jThEqQCfC2Bs1ZDAj1q3zdR8hdhd4l04/Ax1BT6Z/dJmhG+Or/u4dOHjZvHni6leyf453k2dgog2SRz2cNEw5w6WG5qRKohyqUh/Hy1YEkFk9OnpspJOpj0JDtQbUmbxr6WQ5XJrfbuXZk47BPJUA6y7Qm7nCgrUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(40470700004)(46966006)(36840700001)(6666004)(41300700001)(82310400005)(1076003)(426003)(336012)(47076005)(40480700001)(478600001)(36756003)(2616005)(83380400001)(36860700001)(7696005)(26005)(44832011)(5660300002)(8936002)(110136005)(86362001)(2906002)(316002)(54906003)(70586007)(40460700003)(16526019)(186003)(81166007)(356005)(70206006)(8676002)(4326008)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 22:08:17.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf0bd2-049a-40c4-2c3d-08da6c2eae41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output is currently split across two lines making it more
difficult to parse unless the newlines are removed between pins
or it's read in by a parser like Libreoffice Calc or Google docs.

To make it easier to follow to the naked eye in a terminal window:
* drop the newline in the middle of pin definitions
* shorten all output using unicode characters
* align all pipe delimitters
* output the same phrase even for disabled functions
  (but with a ∅ character)

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 114 +++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index b7f34352b5d4..14183b493954 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -203,8 +203,6 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
 	bool tmr_out_unit;
-	unsigned int time;
-	unsigned int unit;
 	bool tmr_large;
 
 	char *level_trig;
@@ -218,13 +216,14 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *pull_up_sel;
 	char *pull_up_enable;
 	char *pull_down_enable;
-	char *output_value;
+	char *orientation;
 	char *output_enable;
 	char debounce_value[40];
 	char *debounce_enable;
 
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
-		seq_printf(s, "GPIO bank%d\n", bank);
+		unsigned int time = 0;
+		unsigned int unit = 0;
 
 		switch (bank) {
 		case 0:
@@ -247,8 +246,9 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			/* Illegal bank number, ignore */
 			continue;
 		}
+		seq_printf(s, "GPIO bank%d\n", bank);
 		for (; i < pin_num; i++) {
-			seq_printf(s, "pin%d\t", i);
+			seq_printf(s, "📌%d\t", i);
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 			pin_reg = readl(gpio_dev->base + i * 4);
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
@@ -256,84 +256,91 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			if (pin_reg & BIT(INTERRUPT_ENABLE_OFF)) {
 				u8 level = (pin_reg >> ACTIVE_LEVEL_OFF) &
 						ACTIVE_LEVEL_MASK;
-				interrupt_enable = "interrupt is enabled|";
+				interrupt_enable = "+";
 
 				if (level == ACTIVE_LEVEL_HIGH)
-					active_level = "Active high|";
+					active_level = "↑";
 				else if (level == ACTIVE_LEVEL_LOW)
-					active_level = "Active low|";
+					active_level = "↓";
 				else if (!(pin_reg & BIT(LEVEL_TRIG_OFF)) &&
 					 level == ACTIVE_LEVEL_BOTH)
-					active_level = "Active on both|";
+					active_level = "b";
 				else
-					active_level = "Unknown Active level|";
+					active_level = "?";
 
 				if (pin_reg & BIT(LEVEL_TRIG_OFF))
-					level_trig = "Level trigger|";
+					level_trig = "level";
 				else
-					level_trig = "Edge trigger|";
+					level_trig = " edge";
 
 			} else {
-				interrupt_enable =
-					"interrupt is disabled|";
-				active_level = " ";
-				level_trig = " ";
+				interrupt_enable = "∅";
+				active_level = "∅";
+				level_trig = "    ∅";
 			}
 
 			if (pin_reg & BIT(INTERRUPT_MASK_OFF))
-				interrupt_mask =
-					"interrupt is unmasked|";
+				interrupt_mask = "-";
 			else
-				interrupt_mask =
-					"interrupt is masked|";
+				interrupt_mask = "+";
+			seq_printf(s, "int %s (🎭 %s)| active-%s| %s-🔫| ",
+				   interrupt_enable,
+				   interrupt_mask,
+				   active_level,
+				   level_trig);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S0I3))
-				wake_cntrl0 = "enable wakeup in S0i3 state|";
+				wake_cntrl0 = "+";
 			else
-				wake_cntrl0 = "disable wakeup in S0i3 state|";
+				wake_cntrl0 = "∅";
+			seq_printf(s, "S0i3 🌅 %s| ", wake_cntrl0);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S3))
-				wake_cntrl1 = "enable wakeup in S3 state|";
+				wake_cntrl1 = "+";
 			else
-				wake_cntrl1 = "disable wakeup in S3 state|";
+				wake_cntrl1 = "∅";
+			seq_printf(s, "S3 🌅 %s| ", wake_cntrl1);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S4))
-				wake_cntrl2 = "enable wakeup in S4/S5 state|";
+				wake_cntrl2 = "+";
 			else
-				wake_cntrl2 = "disable wakeup in S4/S5 state|";
+				wake_cntrl2 = "∅";
+			seq_printf(s, "S4/S5 🌅 %s| ", wake_cntrl2);
 
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
-				pull_up_enable = "pull-up is enabled|";
+				pull_up_enable = "+";
 				if (pin_reg & BIT(PULL_UP_SEL_OFF))
-					pull_up_sel = "8k pull-up|";
+					pull_up_sel = "8k";
 				else
-					pull_up_sel = "4k pull-up|";
+					pull_up_sel = "4k";
 			} else {
-				pull_up_enable = "pull-up is disabled|";
-				pull_up_sel = " ";
+				pull_up_enable = "∅";
+				pull_up_sel = "  ";
 			}
+			seq_printf(s, "pull-↑ %s (%s)| ",
+				   pull_up_enable,
+				   pull_up_sel);
 
 			if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF))
-				pull_down_enable = "pull-down is enabled|";
+				pull_down_enable = "+";
 			else
-				pull_down_enable = "Pull-down is disabled|";
+				pull_down_enable = "∅";
+			seq_printf(s, "pull-↓ %s| ", pull_down_enable);
 
 			if (pin_reg & BIT(OUTPUT_ENABLE_OFF)) {
-				pin_sts = " ";
-				output_enable = "output is enabled|";
+				pin_sts = "output";
 				if (pin_reg & BIT(OUTPUT_VALUE_OFF))
-					output_value = "output is high|";
+					orientation = "↑";
 				else
-					output_value = "output is low|";
+					orientation = "↓";
 			} else {
-				output_enable = "output is disabled|";
-				output_value = " ";
-
+				pin_sts = "input ";
 				if (pin_reg & BIT(PIN_STS_OFF))
-					pin_sts = "input is high|";
+					orientation = "↑";
 				else
-					pin_sts = "input is low|";
+					orientation = "↓";
 			}
+			seq_printf(s, "%s %s| ", pin_sts, orientation);
 
 			db_cntrl = (DB_CNTRl_MASK << DB_CNTRL_OFF) & pin_reg;
 			if (db_cntrl) {
@@ -352,27 +359,18 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 						unit = 61;
 				}
 				if ((DB_TYPE_REMOVE_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "debouncing filter (high and low) enabled|";
+					debounce_enable = "b +";
 				else if ((DB_TYPE_PRESERVE_LOW_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "debouncing filter (low) enabled|";
+					debounce_enable = "↓ +";
 				else
-					debounce_enable = "debouncing filter (high) enabled|";
+					debounce_enable = "↑ +";
 
-				snprintf(debounce_value, sizeof(debounce_value),
-					 "debouncing timeout is %u (us)|", time * unit);
 			} else {
-				debounce_enable = "debouncing filter disabled|";
-				snprintf(debounce_value, sizeof(debounce_value), " ");
+				debounce_enable = "  ∅";
 			}
-
-			seq_printf(s, "%s %s %s %s %s %s\n"
-				" %s %s %s %s %s %s %s %s %s 0x%x\n",
-				level_trig, active_level, interrupt_enable,
-				interrupt_mask, wake_cntrl0, wake_cntrl1,
-				wake_cntrl2, pin_sts, pull_up_sel,
-				pull_up_enable, pull_down_enable,
-				output_value, output_enable,
-				debounce_enable, debounce_value, pin_reg);
+			snprintf(debounce_value, sizeof(debounce_value), "%u", time * unit);
+			seq_printf(s, "debounce %s (⏰ %sus)| ", debounce_enable, debounce_value);
+			seq_printf(s, " 0x%x\n", pin_reg);
 		}
 	}
 }
-- 
2.34.1

