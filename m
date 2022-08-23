Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F99359EF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiHWXHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiHWXHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:07:40 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A2183B4;
        Tue, 23 Aug 2022 16:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+NJwr06a3KPqcr39r/hD13cWlUW7Erm/X8cp0kdQEJTqNKJ4QOWHQiHsGmmItEdFN7iEN6Y+FUfyH77VozWbYf/1aQ4uqXI8xSbn44W0Wmly8gjqXUCWDsGIOsn+UcHN2qPn09Bhfpe1biWau9tF+a0+WEu44U6jUAcXcY/24B1ooQwAKfSG8GXZV5YszZzzaihh96WRER5wQH/Rjep8wkyJSjk4i9dmwUtZAyISiRtRtxL0PdUwmdFRK5Ggzey6C7I6qnHL/oUx5ordTLWggkX4SmZhD4rJ/dB8KMK+Cw4a8NAYYB8vjy3ocNnOvYUPrsangNPeyOAhuvWesyUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP+qRhpiutXsV8/sePUjKE6QU9WjtOw99cHhNQDYJ+c=;
 b=lq8f96cPMFRCbic03zRqISB5DxRWyefU4oHtySE6qi49Hko5gCzmp2apDMPVa7mQAcDIAySa/2zy0Xbxpa+1SAdkzdM4+RxxPFz4l9s8qnX4eYIcDUP7haD29Cqt6cP13HIMWwBGu3W4kwYwLjmc+SDNv+UY33+E6L3cURWHegB+O+MYUhBS26NItv8LRX2whVUAoie3gfkiq7iszdfrvstPQ6k7tuLdcwoIeT310kd7FNt+djpb1iuSUw/BF2KldlMp5CjYihuhdPp8tkAVmEBKVMHdv8ZXh/INyPwIajW6VZcw3caWPqKrk/v/wXlAwXxDjco1cEo+PYQ15BsmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP+qRhpiutXsV8/sePUjKE6QU9WjtOw99cHhNQDYJ+c=;
 b=dU/GgL18rweRSbff1EI5PlRtysrXBShXY9tvIWKcHR1MZ2LRiX26ycOEKk87AmpbdUqJ0sp3fz8pSr7FXq7v592SJBuCJVidI/PaFcoM1laPFdWgkVru1fDmkXf9ZxETg1Wac1GNyIrdrVnBDQjQhFVd2L9liPpdAzNWniuQAk8=
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by DM5PR12MB2472.namprd12.prod.outlook.com (2603:10b6:4:b9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.24; Tue, 23 Aug
 2022 23:07:37 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::af) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Tue, 23 Aug 2022 23:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 23 Aug 2022 23:07:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 18:07:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Kent Gibson <warthog618@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: amd: Pick some different unicode symbols
Date:   Tue, 23 Aug 2022 18:07:52 -0500
Message-ID: <20220823230753.14799-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45943f8f-ad83-4d57-4e16-08da855c4511
X-MS-TrafficTypeDiagnostic: DM5PR12MB2472:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmhHGn2REikbgT49YCtESVbdThrNtf/pfHSyvLsHSB18C4InsLqB8KTYNwy4tfx4UHJtpC8h4PpL4efHCNtUM3A7wdLHZhictI1ukFJPa5xO1rj4KAdxx3mscN+0kI0pt5NAB3JBF7w1tWrooPzN5xo69iVdDfMu3rTVm/a0h/DmaX/vTOP9wiif+a30rJgOhJeXmzviIssa1SyqD+qzmKF0HqNjxeq2NMLEuiO/qoXo9vZ77Fcasj/859IYLO510QrMhuUdoxqqHbArrzdaLU+TBzNBOZ5oNYJ3fr5YVDatsYSHfqtf8ZAyCqqMshN/7ct4ixviZHXhUmLbXA3AyYjp7ZOW4y0DMeVvlGD1zWBvcnaPgEBIGGGpQBu9NfbFxHiQtkLcgihsuRW0ORpFEBNHp/5FRem+m70YtBHPh4kzkVbWgLCcQkwhykPSnxgw6tJACwNxK7O9kCd0QWSp9PihmLgdSphCKmHMwrIs+J1q2ty3d18IFbhcanMuq44f3m16qrDFzVDNbUqMq6ALncm/LlPkCEoqyvniwNw5ssGLhbdg8URweJQkpcI1JWV0K2k2lqCdhp6E12rpEmiFfim/3YD0hUKWjG28aF36yNxe8Z7gAH18dUv0tZB2K3MXSUDQ4CrHbq89SnKfH7Mq7QwWl7gIDjMhwbV6Ebsgzklp7bqY69mbnghEYf6mBVxHsd8pV47SgPt1O5+bBzp6/NjMOuyK9epQmSr/en0Pqm6+dwfd8epZ0BHQmKU0y+WYIGLvJQ32YW3bt+sGaUi7Ls5hwKPIPcEHKWUUlkvb220g6y3WlXWijZiLwOtkOUSX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(40470700004)(2906002)(44832011)(40480700001)(36756003)(54906003)(110136005)(82310400005)(316002)(5660300002)(8936002)(41300700001)(478600001)(70586007)(6666004)(70206006)(7696005)(26005)(81166007)(2616005)(356005)(86362001)(83380400001)(82740400003)(40460700003)(8676002)(4326008)(36860700001)(186003)(336012)(16526019)(47076005)(1076003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 23:07:36.7500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45943f8f-ad83-4d57-4e16-08da855c4511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feedback from Kent had showed some better selections for symbols to
use for pinctrl-amd debugfs output.  Adopt some of those instead.

Fixes: e8129a076a50 ("pinctrl: amd: Use unicode for debugfs output")
Suggested-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 4691a33bc374..fda41907c4f1 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -246,7 +246,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 		}
 		seq_printf(s, "GPIO bank%d\n", bank);
 		for (; i < pin_num; i++) {
-			seq_printf(s, "📌%d\t", i);
+			seq_printf(s, "#%d\t", i);
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 			pin_reg = readl(gpio_dev->base + i * 4);
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
@@ -278,32 +278,32 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			}
 
 			if (pin_reg & BIT(INTERRUPT_MASK_OFF))
-				interrupt_mask = "-";
+				interrupt_mask = "😛";
 			else
-				interrupt_mask = "+";
-			seq_printf(s, "int %s (🎭 %s)| active-%s| %s-🔫| ",
+				interrupt_mask = "😷";
+			seq_printf(s, "int %s (%s)| active-%s| %s-⚡| ",
 				   interrupt_enable,
 				   interrupt_mask,
 				   active_level,
 				   level_trig);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S0I3))
-				wake_cntrl0 = "+";
+				wake_cntrl0 = "⏰";
 			else
-				wake_cntrl0 = "∅";
-			seq_printf(s, "S0i3 🌅 %s| ", wake_cntrl0);
+				wake_cntrl0 = " ∅";
+			seq_printf(s, "S0i3 %s| ", wake_cntrl0);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S3))
-				wake_cntrl1 = "+";
+				wake_cntrl1 = "⏰";
 			else
-				wake_cntrl1 = "∅";
-			seq_printf(s, "S3 🌅 %s| ", wake_cntrl1);
+				wake_cntrl1 = " ∅";
+			seq_printf(s, "S3 %s| ", wake_cntrl1);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S4))
-				wake_cntrl2 = "+";
+				wake_cntrl2 = "⏰";
 			else
-				wake_cntrl2 = "∅";
-			seq_printf(s, "S4/S5 🌅 %s| ", wake_cntrl2);
+				wake_cntrl2 = " ∅";
+			seq_printf(s, "S4/S5 %s| ", wake_cntrl2);
 
 			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
 				pull_up_enable = "+";
@@ -367,7 +367,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 				debounce_enable = "  ∅";
 			}
 			snprintf(debounce_value, sizeof(debounce_value), "%u", time * unit);
-			seq_printf(s, "debounce %s (⏰ %sus)| ", debounce_enable, debounce_value);
+			seq_printf(s, "debounce %s (🕑 %sus)| ", debounce_enable, debounce_value);
 			seq_printf(s, " 0x%x\n", pin_reg);
 		}
 	}
-- 
2.34.1

