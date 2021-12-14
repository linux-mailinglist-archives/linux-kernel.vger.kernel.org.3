Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AFA474215
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhLNMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:08:41 -0500
Received: from mail-db8eur05on2068.outbound.protection.outlook.com ([40.107.20.68]:38912
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233849AbhLNMIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:08:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW9YdWKtRm2g1EPK2dtsxHVFSUOYm8BOMXl72qBudbsYeserxazd5y8xwRkgiavHIkQygXVP3xPD4KPJF9cqBYjg7goOQ9tMwrnOjqA4UlbIPsHf6IE6jwpx8zoB1krfVMloWnz8Xyk/FHtffXRJKxGG77pbcPHW46GctLRSeHIqEGmu0dytaB0sX1IP2QlNKH1sBdXRogOSrX55/Ldr0FpKLPVrkcOvXP9vIkzWHTRUHg0xt38C2UG5ucfOCvHnyc0JwwEP9guYv6O5TiPYonXBk/56SV7FuTCCS68IApgAZzP0otISNsevbkq6bNCFIO9o+BAHwVkRENHnu3JFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6/AMoHSibpZRtRnmgGwhA+LNTp65Zu+uKhaSf+IcjM=;
 b=OeLxU2SS9DFCoFU5FnA6JnaR1/27cTV0TDZdtPM3XIkwae9FryK/SVZLX+gTFEJ8/X0zjkK2NM5YNq1XS9GsPtd1wTFhlkrDdoAW+fYbR9H1ODf+Vv0os3MJo96m7IFvbiLtuz7JfjkfZFkRQnexV7FgyzvWtz13/BB7CV77+kmmadyBRFrDGnxvxLquYLdF0zxFVgqt1UzXNT/Jy17z4TrEyz2KT+wFEyWt5HwG9wjxDRijmFveAYjoXDyX20EtNRUiC/Ue4johh2XIs0n3GJLGhv6VE65LuaqyRPL/0Qe5kNUcD0EfN6QWQorwJM66khA+z28rh68+Nv4v1shcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6/AMoHSibpZRtRnmgGwhA+LNTp65Zu+uKhaSf+IcjM=;
 b=HtwIQNwsNr8NLknIEoFHRh3PE+lqMiBr+TAuUSbx15JSgwcN059FVlld5qQzjSGSe7dJ9ibBEubPUpoXGykyEfIpHmlfYe6vuut0IzUxB9DsaINrDZGcJjDhzl0r+x/neqmZbqKzFTY5coEyd/aimYpHp0e910kuT28Qd5n8m6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 12:08:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 12:08:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] clocksource/drivers/imx-tpm: drop IRQF_IRQPOLL
Date:   Tue, 14 Dec 2021 20:07:34 +0800
Message-Id: <20211214120737.1611955-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 12:08:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9d24be-2bcb-4919-f3e7-08d9befa749c
X-MS-TrafficTypeDiagnostic: DU2PR04MB9194:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB9194F2A079E1D505DC0A5663C9759@DU2PR04MB9194.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eKGOol7BaPs7LTRhw/rDM86tRfN8/t8IYOL+DbOs+CvC1nCwQwa/iUfUOitfdnCDH4MSyh9GLFitfiVpFIuKRkLKzdLg5rcEenqKdfy8yAD6UxGwVUnuV7q9iDQ+mr2RHnn1ED58QfIfzx6/yszUFDDrdURhdf3azDKnrc3641h9pvJtgE2TSVL7h7KcmgNLeqEWYblmAfXTAm8IKudOtqvkzsMo1IQj1SBIIDs9wYsiQWY4/d2Y7K7FiURCNGZtTKDTS5J4EsOueK1p3b1RfXVS16rpHy2l6LLA52Pm4gcLn3UMCfMxebs17C8FrRllKYOUrcGHDrbos8HAjDQ3NnGxYBh/MAPu/SWId2e9oDdUV/jBm6a+ZnOsGRskYW/d2wJ9eIgqrSeFZas5gqzc1hlUDLM58MFKN4MNgT8x5S53zHFZqLLoMEGN7BnWoyITAKG0DUHwzx87uc0ahr44X0eptJ9p+bkl08IvjplzlZBXdSXefokvxDfTRjcZ6v4q2scRG7/vVz3U/syGWHTNg8IvA5MeLUJAUqT2qW3STlnCuavCsYyITKYCSKCmCtCHoxm8RroWxbF2/rVhVrCOxyFI4WEmrk4mWj73bbKiXOT8Pi6uH23lsHFN6xnjPpCHZ4IWGEYrWKlCQbraZvKn2UiS1+Gm943OA98F7KXs2NS/u5L/QMf8q/hN4s3Ei78vNu2QJnk9n56KuHphQdpew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(52116002)(6512007)(956004)(2616005)(66476007)(1076003)(508600001)(4744005)(5660300002)(316002)(38350700002)(38100700002)(66946007)(6486002)(2906002)(66556008)(26005)(83380400001)(8936002)(8676002)(4326008)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tXipDIQLS8+biRS4zgRQiWU3thdO+inml23+wPRyxwbzQEOHQonB4ZcBc5pa?=
 =?us-ascii?Q?GFxnQK0oDbNQCkPySnfARdEcgz1KcnCeuesgIGAKEnwDrpn8VgemX+EAOuxO?=
 =?us-ascii?Q?K8593FiMYoH8hXJZIDccfJJO++wTfXkMbwyLw4VVFiwfJUc4ydKwXs5KBGGX?=
 =?us-ascii?Q?KIifpFHFp36nxVS38KlFweBjJ4wrHBLUgGh1nDhzJd3+mALpQpgQWEP50ydj?=
 =?us-ascii?Q?/yHt+r/eMCMmEVhonZv8wlmUwbfBdhV5NwOILLwGaWC/FucGqVrkZ3+iG+SB?=
 =?us-ascii?Q?NC4uqc2Pg5rItCHRVXtE/hvpSOskua/aH8xJ/OVj/7GfOiPXYRjQ0uKxPajt?=
 =?us-ascii?Q?UAxrE1Eu7KaCr15qZCwFT00dn6Rj/2GFwVeSmTL2rAUhGRN1DBA8lEKd+Peu?=
 =?us-ascii?Q?EiJdbmzyEHDJGYAxP0L8gxqo+AI+g5dabueFE3sWxHFqA4do4oNp/NIVDMhJ?=
 =?us-ascii?Q?5pgEt8FjpB9Fse4jpnVqecvHJH+1UPAcaTb2s3szJFGcHlWh4z4cqg4sBSnd?=
 =?us-ascii?Q?HdPVeiLK7oRmfOk9gUi+DWJDtdmUNFXYtzynvel4YnKeTQNk7POuFGwVxMsa?=
 =?us-ascii?Q?7JvX7BvZFV/SkpnWvFRdYLmCdQndp8d/vBrH/B+KLRY07/Dy3KjhiWFczweK?=
 =?us-ascii?Q?SXv1ifNO3IJyb01KmhFfqG2zxjrD5OBj89tGshSYshNC+Z9Ng68y+AelMJGB?=
 =?us-ascii?Q?n2wYPT6Ki8jmsyeKbdyU25qgab7TB28EEVA8CVbrS6vNuVZ91hp8w57InitE?=
 =?us-ascii?Q?ZX+eaGh83atKjSV3oKJqpn3RAiC4k3ZF4Hn132Ig6t0mxXIG6dP9IFc0S3vk?=
 =?us-ascii?Q?gXmNoR8uC3sy/Fn7tYYlCzBEED4bG6z/UuyChP4JDRwbJpFr1ZuakDxzPaHj?=
 =?us-ascii?Q?rrvxhMsOSuJ7UYtoABHtJWNVp6Qn2ejI7eGPpERfFOCwlfEIBi96DXHUvoir?=
 =?us-ascii?Q?NosFhWjS5phEucbXZMlyk7Jvv32631H2nRXQ3g/GwchHc+r7l0V99GRTj3IW?=
 =?us-ascii?Q?D739uIAvx5MHCKs5NmOgyPFHmKxu8SQmsuvFfep4UC61VfA1Xd+8tZYWqABY?=
 =?us-ascii?Q?r6EK7uNuVbI68t4qNXdhB4j7NCoyt6+TrlIxkXpB96ujeWnPO4ln2AaP8fE6?=
 =?us-ascii?Q?qod2WQ1PICKsGj1BXTpC2VNBDtlnM1XrTq0HyoMP37ixQWFPH80fFJjZc2w6?=
 =?us-ascii?Q?P/JMZ3qBqJPdOMXpcikDnPanSuPSOxRlKrR6Z3zdr9H2Oe5b5H3cGR1DDHCs?=
 =?us-ascii?Q?461poyfbMX31ln59soEFZbC+7AsZ1QiNov+hhflTZUqWQJlF7dgAJ56RwgkG?=
 =?us-ascii?Q?2ncHvcBCkH00U7YpSrHkSfg+XRKRLZcp5uvGFIKjGh4JL5BaWYW2ljuVPSX2?=
 =?us-ascii?Q?WFGiuUYyYDq30bbS0WfWlFY7YE0TYHneR5rY8XIsS1CnVI0rpmP0+Ct4M9cG?=
 =?us-ascii?Q?26Xg7qt6K2xYADKW216KDmVtKkZ2KJ0wUIB/N97fvLCILQLd3CD2CuC646L1?=
 =?us-ascii?Q?n7UAOth3yM+ARayLyISStCx5oigd1sy+G0JfzjLyR3TZIfyRC5DWBYcTIKvl?=
 =?us-ascii?Q?8/bl3Cl9FLzzi2ceeEjykfbj+8Z+8h5L7Q6t3xE2a6/llJdBehXksISJJspV?=
 =?us-ascii?Q?6PmrGR0mg6wL5KJBfCZzZhg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9d24be-2bcb-4919-f3e7-08d9befa749c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:08:36.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLT0Bv2aaCOWwFGvX9+zY5ptyoIGXVG2emuZyKF5YVrmfy/pKi2YxWOfVofKkezdvEPZWlsNwXr8MKhV5VjXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per the Documentation,
IRQF_IRQPOLL is used for polling (only the interrupt that is registered
first in a shared interrupt is considered for performance reasons)
The TPM timer is not sharing interrupt with others, and pass irqpoll
not make sense for i.MX platform.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 2cdc077a39f5..2c0b0d4eba9e 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -137,7 +137,7 @@ static struct timer_of to_tpm = {
 	},
 	.of_irq = {
 		.handler		= tpm_timer_interrupt,
-		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+		.flags			= IRQF_TIMER,
 	},
 	.of_clk = {
 		.name = "per",
-- 
2.25.1

