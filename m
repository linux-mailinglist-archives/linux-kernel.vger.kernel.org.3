Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2548EF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbiANRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:10:15 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:64900
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243815AbiANRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:10:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNPb56yimcyWhsGdafwrx/bwgkoVX6qLgaRRsYATz2if0XZ3QyUgp0G2bsuj9u813NNjhlp9iFO+Zwk681/EW8MyPXjUzzDOgVSpHI6+dJsU+WatNCQJi1vTklJtbGWiwa8XNf2lF+wl9lRR2zX7eZ9Yg5L06Ts9GbjEere0PcbeNHR8b739GTeSnG1jAV2f7Oiwvi2dNKwADcUfHlBhQ8xTOmntYVg45zi4gTjU+Nb9Gz26XJwcOfatzrJEeRnWGknlTxRP6NW5RltINSMR3CJuRfz7HRsDlZk+mP+nJyR0OHK7nm0uXmiiU0mUbkeWN8DujX+PeF93Qj/GVA4qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJLgY1bmeSNOD6KWu7/eqTHNsxa8oy/EB20i1n5tRJw=;
 b=eVbls7VD+AKd9qaO+sQoXz2SFv/pREUUwrru+lC2UEUuCPWf3fAnh72zwl3lf34Lw7pNmvWTN95EMsAXy+C64DJ8op0LSW6IU+2I38Mm0UibNa87ogQIOBeW3rBf2TF3un5ks0F83B3buKNdW4eB1s/ADVbuvjKa+p/DfZG3HXSlMl0+rTId21v4DiKNtAhjNsE53kuUZ91RHlKKMDdvEIHQVBOaqmK1MvoioJqFu0ZqcaBbhEnQRRnaD+Mr7uDvsJp/2Sbe/KNEpZfOcOJl+RbI6QmEE7N+w26M7UyIIZWtMmIvE1BHUT7uGi8/FI1XYgPT8hCvQfOuozD2VTpSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJLgY1bmeSNOD6KWu7/eqTHNsxa8oy/EB20i1n5tRJw=;
 b=JccCUzu/OWwkB7ZYPhMiO19ZZV624ctaeqUMT6emtV8Uj7XqdWWe/vu2Pqj+PCOzHjKB+eVX+oOzm8I7cXtFroVoYGHaHgbvsj+SgEHmyzM39ik7w7gQe0hh7NmFIFmMakWyYcC9ZNI92onWA9QKIUPKb/6lto7VA/aHMfZ5I1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com (2603:10a6:208:d0::10)
 by AM9PR03MB7742.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 17:09:58 +0000
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8]) by AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8%5]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 17:09:58 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 4/4] usb: phy: generic: Disable vbus on removal
Date:   Fri, 14 Jan 2022 12:09:41 -0500
Message-Id: <20220114170941.800068-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114170941.800068-1-sean.anderson@seco.com>
References: <20220114170941.800068-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0072.prod.exchangelabs.com
 (2603:10b6:208:25::49) To AM0PR03MB4514.eurprd03.prod.outlook.com
 (2603:10a6:208:d0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb456975-0426-4e30-9175-08d9d780b134
X-MS-TrafficTypeDiagnostic: AM9PR03MB7742:EE_
X-Microsoft-Antispam-PRVS: <AM9PR03MB7742902CCF6DC2D879ACFAF396549@AM9PR03MB7742.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tJc6wDmG+dTxOLxJ0WpgPO23HJm2zNv++CxCSC9B81mxmVhi0q6Yd6Aa77GCK6jIaEYZE0adbibZANjhMGnAHtvog+dd9+E1wZxVedNBqMeB/FWXA30DEA4Sb10wgDr357Yvrw8m/YoV7WTqCLEZATJcc5vtmYttxoGN8SdZQ9/hEA1osf8oVbeFr0+EaZNj0FANdlQk5Fus0BhuPi49nDAJiHWkuo9GRRWbYsPH9N2nzr6MRL+RQqwdmnb26bOwLAfhpQhuwv4JCIWh8ptAub33TPcOqQ11EjBz/CDPe/hNHbLrWLMWhtGb2jS/IIj5yq7iXvq8W6gwqfTs83OuwadY0L0LQvpV6ygsIoPIRFI+88RraDz4QqjMVoBf3ELk+rwm212ExBDle2gg372enI43TElOhFnPjMABovkV+YKDwLjMKli8CjcuKZE/EmP+lh74uGZMxCrJCgaTNxhv2RotE+WZlHkQoiMTp6s+aODskUbACaA4ZRyDnSoP+s2lAXB9R0KrQI47Zs6rTPsYCzW6GQAu0yj9nCI6GCNlexUn4m14YoE+F7X9Bi95mtMv94EKUFfd690ZdtJ1UZ5YPbiGUVveW2DGHFWx5UP5VYX5nClS+qWqxFDaM+cdb3HBCpcPyqA8lZ5t7hD+Y8zm9s2rVue69HNMQx2hdLHXyIDgudlr/HIxXc1VXsF2dQ0LaP89s6x7L/w18MjfZGIXifTffVb6B20xmgK8b79wrrAIwGTX6gG3l1p3siO0aADVnvlhVVWWsGea71M2vWmcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB4514.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(316002)(186003)(2906002)(107886003)(508600001)(26005)(5660300002)(1076003)(2616005)(38100700002)(38350700002)(4744005)(6512007)(6486002)(4326008)(36756003)(66556008)(66476007)(8936002)(66946007)(6506007)(52116002)(6666004)(54906003)(8676002)(44832011)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/EhR1Y8j28LHX0eCGuZhFc5aIKTCnaJXaJyV3L9+/LCe0G3q5tqe7qnDyfe?=
 =?us-ascii?Q?53UEK9Bjv1HeZMdE6MgY71De84NHhJyaXTuCJShe2Y3RPhRZrpBpOyXIS1zS?=
 =?us-ascii?Q?GP9T57CHpTI5ijKAwEgoIOQ1OEvEbfSyMNoUqGNWs9mjNUMn2iIF8VsAMgm/?=
 =?us-ascii?Q?Efm/XGKrJPkPvbVI+8EC8JH4f9F8l3w9jSkw7Q8t5i5w4gcb6fAyvX5NwiWW?=
 =?us-ascii?Q?8shZceCpEpPBXiSMz13j3qQpVsUIFj3hVoUACvc8/KZRX2Ui29FVkIF2NyoX?=
 =?us-ascii?Q?mO8+tdHcMOIftrHBQv7lh71cI20u13bac5D39+n4id7f5eMLYl/JQjnuRGgp?=
 =?us-ascii?Q?HG0xWGwQ1PvtO5rlu3yoDLFTSFkVayk97vTmnziXdRouOeGiGSY08PG3E84D?=
 =?us-ascii?Q?v7FPo1Pi186gLL3qh44us6eVthFjmVGLhMtFqxsLuRP/pmnLxEF0q4M5WAlR?=
 =?us-ascii?Q?SOid3ANMi0K11OqibqkA9ul3Py77LNcVY6+1FYihmonB/sq/nXQ0tcgb5SvY?=
 =?us-ascii?Q?3sDy51DXdV5YhLfkeQfSmU05Ci0zxYYCdbcOYivRhtPMEjaNLfduXB9BhWHz?=
 =?us-ascii?Q?d2y8uUQ2RiyQsRQiu6t3Tdpp4IqjA1n0JXFAMyhB02ydJHU4MqLgNc2vRrXu?=
 =?us-ascii?Q?7iZDesk7feQ+A3f8fyhWvOK4sPOI2QZydBAkeb7kU1rC7H3yDf2nGh04Dw3b?=
 =?us-ascii?Q?dK6dfB243RTWGu4+Agam++J6kOO8Ea73FkkLPkZ/hRjm25dTkSldi26hPf2X?=
 =?us-ascii?Q?BmJd3Vyk8r+T3AvCN9lM+fmiaRz2p+AGpE9tSzQGI4mZFMBMDqZGKwbDa5sg?=
 =?us-ascii?Q?H7B24FXUhJVTO2qcg9Bdv4+1sEyAwNmAtFLLyiUCXEKsnfcld3s9kH67y7h3?=
 =?us-ascii?Q?k9XmrHKHIEW7x+FmpOY2or6tBbJI0XcGZwVrzWYWOjSeG5MTyP4H/UrIdjy9?=
 =?us-ascii?Q?FgEjvhocjH3/W9PRdTG6ulQKgAJVGVrnuN1kJ0SZIkmmHKOAO+LWwCWFTxOy?=
 =?us-ascii?Q?Uuj5caMnHi3uuUFBX8IMhjxu3tqLmh5QUrHci3qwgutidbxZSR+Gs7WnkEEi?=
 =?us-ascii?Q?/DnQAjjRMbqr6mWEDyPNeWTnjNtilUtizc1iJmxJ116mwvedTvGG6QZLHg8f?=
 =?us-ascii?Q?RqIvquj0qhIKPDdyB40paSKD41OY09zyenl3koOYcDknECYznpm8P4id6GCU?=
 =?us-ascii?Q?pkmKzQbsX0lVxQCG2hn25rG/rbkIcUxQU5IAFJA2TrMsIdcsHpZJMPOSwcxf?=
 =?us-ascii?Q?rysty5DN5ETe4QD2uAhGAUaf7jG9dtQxUFn4yajoRUqxNLUbOmDD6ExW65t2?=
 =?us-ascii?Q?+u3EQyiW+jFUKlFnBu9TJsapSyqOM8H5oFRqqnlRfE72X9GtUrKSHTpFTGkd?=
 =?us-ascii?Q?s9xRMqguo93MxfM1njAFhx78oqIMZy1YZ/xfy6q8SHEhlJwrkoCDQqrYVX1Y?=
 =?us-ascii?Q?oJrF0n76tx55V9w0R1K/UyVZbZ793djhblNjpYdctwiA2khx6nR+BjUxuLM7?=
 =?us-ascii?Q?E/+B76kKoMfvezI6mrlxgqrg6F3kAZIEiwU4/QIXTk817/7s3uF/aDBxH55v?=
 =?us-ascii?Q?HMtlicrM5f84vDSSvGv4iruKRtZ/PwXVx4WB/cWNXGHKZAagSzH8/8LbXIjn?=
 =?us-ascii?Q?BeAFeFzMp+eVsZ86U7zVvAw=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb456975-0426-4e30-9175-08d9d780b134
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4514.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 17:09:58.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Itu2jtuNspANGKT8+bDnQbAPan/yQoEsnz+kLsyPg11PJM8cpWWoGt8no891tr1qiHT+TzA+bBNAiX723onmpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we enabled vbus, we need to balance that with a disable.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/usb/phy/phy-generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 2c2553bc9b54..9fc3312d614a 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -328,6 +328,9 @@ static int usb_phy_generic_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&nop->phy);
 
+	if (nop->vbus_draw && nop->vbus_draw_enabled)
+		regulator_disable(nop->vbus_draw);
+
 	return 0;
 }
 
-- 
2.25.1

