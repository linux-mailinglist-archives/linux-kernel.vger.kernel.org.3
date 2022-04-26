Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3F50EEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbiDZC1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242265AbiDZC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:27:39 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20057.outbound.protection.outlook.com [40.107.2.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3E4113C92;
        Mon, 25 Apr 2022 19:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCHz19dDLQs/B17t8OoYfAIJusZVIG2G2qc9sDsqqvkUILcNYmoAGRJVkahTEoll0oK2NIf0N6PacUx9ZEKH95OHIoQK4GZu5jBlItCOJIliPC3Q7Ct60tkzXTFD7HpNpQ2xpcwz6fipMkWTVSA9MCZswU7te6vMmfid20IYwpQHMZzuWMBLvk4pGTwBkfasNmOJvI+POAcA2OlWXfHDE9g8ka3wewXZ5+ZcuhkNvFL10FJypuSlArlkcelBjLBSkqeBPE+Q8X+L05lEITcrOcO+TzjYlpfxaqwiSwVPH31whHQbrSf1h0r/33lyqnZtESW60YcHVW4mDX7Ziz3WoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYGwNWuwXLx+0CAKdzUZMqI8mFF8LNVwFZ9uFpVGZlA=;
 b=aefZb3whv0bo6rzXgVv9EmOyLqeeMSC1DQFtVpv4GYqPRDmoiK/mK9LC3nghKaBkVMSVrgGWAf+HH+KEHSd2sodfN7rlt8RPxr/yY7fcS0zFnd1TWTu4w7R8ZMjNoAq/6dtNI6xWMR3s9Wyr2VI708jQnZ3yujo+YJEacGSAJaE4iOtegJcbrKyHOgmRp5v/VMSGyRm7OL93E7XuO77Q0cr8OCiqw0cmlTK5+3rRbJ0IWhjQJpMGlz+Zmu0i5ViF6QdRcxDjeM2Qh1G9Z970Ccv6fNQqLjodSRnL5sd/fqu9Pzdzay6KTZPHWTVv98BdqWVqgp+lERw6P5/S6nJxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYGwNWuwXLx+0CAKdzUZMqI8mFF8LNVwFZ9uFpVGZlA=;
 b=n76C7zSgCZx4MARXjVordR+QxFs5ttBVT/L2ooUCKr2RVH64YotrX4P7afqHeFrqX8nmEfI5icw3TH+9JyEaBcq7uK5tw1yXP7nZABK7EY45H2xg/zHM7EzWTW1+gAKZzsFUES0yn7E4YdscqGqkggIBp7NYLqAHMJVs1MTuY4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by VI1PR04MB6127.eurprd04.prod.outlook.com (2603:10a6:803:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 02:24:31 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:24:31 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 3/3 v5] spi: spidev: add MikcroBus socket to device tree compatibility list
Date:   Tue, 26 Apr 2022 10:24:13 +0800
Message-Id: <20220426022413.885092-3-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426022413.885092-1-jerry.huang@nxp.com>
References: <20220426022413.885092-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 337695f5-4722-48fe-4198-08da272be55b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6127:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6127E858EB6290C7ED524012FEFB9@VI1PR04MB6127.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnbL9bUs6GUVXpY44FkXX0wSi+72YuBn4xqECP/N34HK6Zf96uFyECWWjA8D4JQo4sFwntm5DXXWhNo+moj8wZ/1pADmMWUm97myEBhZORolH1Uk95Hnt1SUlyLRCgyqbElnVbmSJqUw79Ibo7B2+sO9Z33NWMiOII1QM7q94tsAMu81FPHWIRhOIgbhia/DK+Dg//W5aRQgjDcxQUIBog+gp5UCxvjkNV4/vqOxApwnrfUSb8NcF7Lcx/6dLYU3x7vCZoKHx2crG9//Auhe/5Eq3I0wI8vDn0C6FZB93+fhQMmSCWBtsuz9R2387r6w411R63xcIuTH9zXYZaENPb9oVccU9G1Vov8FA8ajjkaPeJyLSpIFcddTXJmulcVGSNnBnamcsgqAcTVBQ94xKGP9HUGeEfJfFLcVdCap6HBC0rKk5qbczexXx5I/Y2ktgo3Z6W2LctArQUBBSzrXrJF8if46kUqpNSkU3vVQqsPxjWCPodAYuXRcaDtun708hEj8DycoDGwhKmRfPwif2lXoegSgNc5hJQ9Dhkofj1qnzijPl4ypSBImlyR1niihJ4cvRYDweBP9v+jISSZkAW44FF0IghaBKRPgOq1dXHMd6UR+ZsVJMaQhh7HAIISCQwuiJtHDoaq1sjSXwXYNSRdc+N/HTHvyyjLOETwv7jdkjbeKltf9N/SXS2ZekF1nbFivIhQihVN7Ts3mDlUMXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(26005)(8936002)(316002)(86362001)(5660300002)(52116002)(6666004)(186003)(2616005)(36756003)(6506007)(1076003)(4744005)(38100700002)(2906002)(38350700002)(508600001)(6486002)(8676002)(4326008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zaN/pNuWAWmGaBn4paaK+37f9mYyyeIct8PcrcQsbnYH6SSmWHglvN7gm1zQ?=
 =?us-ascii?Q?A92VjyiTyzeNYYPXHRczX0lsipfyC+W/jhSPuoTuzrr8CwBqDpxtx3U0R7Q8?=
 =?us-ascii?Q?vBfsIOOUFDk6I2bCOXC5hQKHYKSFVfV3dor6XAZ7xfT7KNY+y7/RvnwVTzQC?=
 =?us-ascii?Q?GD1NUjry3z3Z0HBTsiZui6j4E2xilJRBisjCJF1dTDVHBXD4hWgdcTYPHZq3?=
 =?us-ascii?Q?0k7w5EWSywxjud6MgawxE4ycIzZdEwDX/bgmOjNY08zqmL4AqQGtDqCv7O/C?=
 =?us-ascii?Q?G4ni2Tg9Dpt6Q7bFX6Jkd97ba1qIfiUqDJLxkdb4lbvHgpxfr77WlJMmmNx4?=
 =?us-ascii?Q?G95aiuPiL0AZC63OmAbYycnvPA1YOLWODlMFqNFOiKRVsSOunX+X6kpWOXhE?=
 =?us-ascii?Q?GIYaxItEGOF9NFv8yejhy5kOZMSHCeJ87h6AkIQwiN+0MSB98VhjCDRtKITV?=
 =?us-ascii?Q?YvxdG+a6nHW2AKAyK9oTptT6IoOHCNu2iIhvtqIYb/V8RwXDViJYQbyJP5Ha?=
 =?us-ascii?Q?kXSs3e3XWW88D37mv5xwU9c2glG42KlNwgJemmjKreLc3zGu7m5wtnBX/4Cv?=
 =?us-ascii?Q?/UtoRyXhGavyr2p/u8aCCKuf6fyf8URCnpaGMmIqqNZWaHv1k/y1yDavcXZQ?=
 =?us-ascii?Q?kfEsZYA80UrGyck5gagDShN8h4pKQKRaW0TB98yyGXMEClm4nnCxXGEG69iT?=
 =?us-ascii?Q?2Y44Ymj2KTr9JGtQENDgQNw64KL/lAwY2Hz6I7xGlLAZ1oM9gXu3pjslpbuC?=
 =?us-ascii?Q?2X0hdcwjyb0OBD9igamYuxkyVHdODAEn0W+ceboQJ9jltKx+XErm0Rz5oWj8?=
 =?us-ascii?Q?HkGXjiAxHbjwo8oxwHHPgyZMCee6LsSJmxCZFKnq7Ql+WA++FxLEL/NRjagJ?=
 =?us-ascii?Q?XojOvtu20Q1S8z4VAeJnLBksRZq/fq8fG24VuJBLCNg9V5NOpenoch2Wr6VS?=
 =?us-ascii?Q?xABfxMS/AcKNEuQgm3CDZrq6qMtGIcxR0upuVSivdBSbYvtpGUh9I4dkxXBY?=
 =?us-ascii?Q?gq6pH3I+sXK/vRin0sqwaSb5lEXvtGf+z05dc28gDy5Y+/hG+w6HZblub0mR?=
 =?us-ascii?Q?Lbic3TjsfqnEHqiOVXv7JuKnoqbZi+wLzLQar224EMm37cKjzJFWnIqBBW6U?=
 =?us-ascii?Q?BpUnO2fq2Qz7vRU0sCvPt6aDjPwewwxvxQiew3ei5JcAGV/zjh3uaXprc6+x?=
 =?us-ascii?Q?etuRGp7gD0w3fxDjtalJsmUwuFvMQPNHO4p/fsHBuKQohE2zRU9Vwt6tpSp+?=
 =?us-ascii?Q?o+EVvwEnJK9bY88QQ6mzebZKa8hPY2TBI51HVy9VnrQysPuIIk0CDmrABlba?=
 =?us-ascii?Q?jSh8L0JGLj7EX+1v7lX4fRcpaTdYWXIhjmDt4TdfAIBqHc4wCA5HHQ7zO3F+?=
 =?us-ascii?Q?G9frlEJ4/OlypWBqIm/kkZ5rXqxs9mmbYYuAYDn8jkZvK7jCGujO2IFigt3t?=
 =?us-ascii?Q?k2Pp8WLT9lYrsYHnWkU/SwYOwCoVjJXyXf6IW6/EBEX5JM6NMSFUNf57rCfk?=
 =?us-ascii?Q?12nnggJWviZI3FV/SX2MVB7RgRcHjP5QbVguY9NQ0B2F3XnwLUOXjsc1kdIi?=
 =?us-ascii?Q?EkRPLaCUd28lG2F2ZCSBiIGD14pMIe+oONdLeL3cLwkFiuKB0e+OUshRZAWm?=
 =?us-ascii?Q?Az7+6DEHy9vShOcKb0IUYDnGYU0zyR1E+O4sBzLi+hAO+qB9I2drF6N19x4a?=
 =?us-ascii?Q?KIGAIvCvstesjnAdbQemUPr2YrZzST+3SLXsAgHldkE6hoQkCg2OQjS+23rH?=
 =?us-ascii?Q?3cd2wn5C1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337695f5-4722-48fe-4198-08da272be55b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 02:24:31.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry0vVnI3+vF5vmYck0+NrLNbpKnZJKn+fqAqDUIMOz9DUfII2Yh6vqAQwmwWXmW1/2UckfZZxvi4z+FCwOiT0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
changes in v5:
  - add compatible to spidev

 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 53a551714265..f9ecedd1dc23 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -703,6 +703,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "menlo,m53cpld" },
 	{ .compatible = "cisco,spi-petra" },
 	{ .compatible = "micron,spi-authenta" },
+	{ .compatible = "mikcroe,mikcroe-socket" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.25.1

