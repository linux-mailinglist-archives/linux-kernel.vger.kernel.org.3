Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7F4664FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358467AbhLBOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:19:30 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:13287
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358455AbhLBOTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:19:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRaq85cg4Hz+5viXIP65k+h4xUX/7RKJihHlpr4FpmrH4xvO7ARx4zQ0504G9zASID6RE7H8zloU+lQ9rNPq3On0HnLY50g4BwSVqBbUC3acELRb3FddpsEhPY5T7e19FJyUkwOuzQSfsOFH2f2mlEs0fjV9SE46gZsQG7qBvj2hPZ7NRF0RL9m855w0PTvQ4V80WBDpWr+w41aZzzgB4/toeANcASzccmqxE0fMl64tncXKAFAG/x1HMvN/1iCkYzc7OWiByTG+E5tcElN5ECA7/DSGnM2BLoF4la8oZSf9h8zuZdJTtbIVohYV0BdB92fT6ZWCNkiLHfsfnQVkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJVu8C+ib77GuxlfQBaCHp+Qlr/3TbvGwCDlQhcOUYY=;
 b=Z+K4OwrnF1bbJO5TNGLLVKWMdI67V2ON7iI9gOdbBWnrpGSxLn2BdxPSXT03ACrHSRhe9TtzIBJv2huOk2KxzwDJE8SbbilWn1lJ0pU1wq/OOGYzghnpE4VXWvlAChzRzXMGTLyTUZRvtvAixYHcB5NmtowwvC3kLfznM8sHZXRrPuusQoDy8uskMojuIBJEpsipVaJAn8mhouhc9QksBVipnrCGea9IiR7nOka/qSiI5dr7z67rwdFTPONJc7/ATO/Ay4UeUBIUuo0FRB7sD8IWk8IexRWzqBCtvzqMzMZsT0aH6Ll4kxgwTQMztYTemxp/8J1l14HnbczPE7/0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJVu8C+ib77GuxlfQBaCHp+Qlr/3TbvGwCDlQhcOUYY=;
 b=iGrHlB5Q2FYRMLgDBZSehEqswV24DPXKZUwLgYD5LucxOvBRFc9j0CbMvUpQctZkx6O6VS0eVVLJUzLp4wSxSsIVVIgODVb59b/OrqKZRRVf1QcASBxTCDV5k47m7NnzawyLLNDbJacOSFjAGn1vPnV62mhKG7r7rr+BlRJx/H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:15:52 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802%3]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 14:15:52 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 3/4] arm64: dts: ls1028a-rdb: add aliases for the Ethernet ports
Date:   Thu,  2 Dec 2021 16:15:27 +0200
Message-Id: <20211202141528.2450169-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
References: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AM0PR01CA0110.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 14:15:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64484c59-9a4a-432c-0004-08d9b59e3f79
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3838:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3838A7E9F4B2508146E4C2C7E0699@VI1PR0402MB3838.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxTegPSyTjw+vlBcazEGTFyUYIC9ZKAvPI1J+XfTBrQ+4Iz0gt2UTirfgh+0ZLEatu1cddWFlyRS5xn9Lp73ptQLso25NdTnjqsPP7onRt7cBFxi9Vu33w1TSB1UvicrquFWG0KuBzIJJgok1LItcKr54OlQGStBuv0idIB6BnVBxGX//pVew/yPNN7hzHevjZMsG3Ccs9LOnKNNNHZXs3W8VvBz0j4gvSR3tqoaG4x746ofPQMqT7YokLAWn6FfzrMITMLIE/+XFa5xIPnisXlGCURbtsu1VLTaTFCeUKtMel+mEscIkElsuftY8ZeXg2vXm5oEZEHegiFlP//iSh/q90LtmzsIhMGJDvUzD5jkx+I+vyMuFoviauZP/MFDXf8qqsyUQoedj6ztUj6xOXXXADmZ+Vn+ynVsnCmSYe3y9qFLN3ExINFYo1/FQYtwQAbsanR88GlROtMEkwxrOpn1Nv9KxzNf+P4n9c9X/tK1KBAli4Bt94Hz3ggKh0DZNqJuGTe/tnoX3Gq75r06z7wA+U7CuHqtBSmzOq/DYgKtV9Zn52ULZi1aCoMU3ju7qpT9hNGkcacDxTRPdW7G9uvIM/iVOflvU9I3R50fH8hoC0rDxjF8DSPeqAZ0YJ4fZYMbVpwxUBnTwgEayv+jcwcbDFubc8LhXoMD0pcW2tqbDdX3tyHrz7+rmLMXijSpuY9q/UfT20KSUvbjNWr0eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(1076003)(6506007)(4744005)(38350700002)(6486002)(44832011)(6666004)(186003)(66946007)(52116002)(956004)(316002)(26005)(508600001)(8676002)(36756003)(6512007)(5660300002)(54906003)(38100700002)(2906002)(66476007)(2616005)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnzxRw+Ob0II52jqWpmg7XEsba9zS+v5Q6+RUhSibBVd5AnsXBZXEPljIdD+?=
 =?us-ascii?Q?kKoO3V2OlKeAgHJ296RMr1gmh3NwC3LPlD2xJm4g2L96nhLpZTBIUvG9yL5z?=
 =?us-ascii?Q?uDWQj0DqTwtMS5ACI59cCZHRywclKKmX/KVL97MF0dAJErpbAQ1EkumkmlNS?=
 =?us-ascii?Q?ukcu7rwj6KPJ43IzsqgAE4Ip2g4LO3ZN8SBw3P4j2Wr0L5j73UffJN6Y2NXi?=
 =?us-ascii?Q?BvGgOOapHHvxwFoDcVEzVAfJxrqbw78KBLbRGQXIjkaaXVe3nJ3LZ5DodFCc?=
 =?us-ascii?Q?qgQAsVjH3PrgePWJ2JYW1JzK8eI5r+0k0zE56krQaVq+Qw1u0d62wgnqTR9U?=
 =?us-ascii?Q?y12VXcGGBUC2MQDJLOGuzCm8mXQqoaD0n8x6uJMYRA40dX1QpV3d77LX0HG2?=
 =?us-ascii?Q?3HcJNeY1mXpq8H1GcyvhgdgX+7HBofGL4q0p5dl/w7crcaplZMzsBYS/O97I?=
 =?us-ascii?Q?SzE4sMsvMWLj5u3cPPK3wxUDnMyiQpiGCcZYVcyyNdeCbourMBxs8w78WyfN?=
 =?us-ascii?Q?ExyNyfIAcWtSIHf+E7bVO/hKYOxc1cHEptRxOgrBgTgJUNqP/Lp7Mnxx/9qd?=
 =?us-ascii?Q?NOsTUQ3mrL7O/P8EG1y0C0CLTfA7yiNSGzkRrOBs8EKgZgKMg4lQwjjFziou?=
 =?us-ascii?Q?1/vyViSCpcB3T8d0cyy8Fql4DGM7Z0zUSl2e+InsikH6PqW7HreWdOLHr4R7?=
 =?us-ascii?Q?b4NXqqRdVYFjevS8wkjh8dhjF/YKTfY3Xdukf73XdpMzfBZJpbwBBwsK1AZE?=
 =?us-ascii?Q?h82uw+BPMKx8zWVZwfp7lxmib5lLjh1DGsDktyS8UnQfJh0pW/8tgkKPVkZ+?=
 =?us-ascii?Q?B15tI/eE5zymqaPPI9DIzrHTKxG7RlFedofndQv120qVVaIf3L7aImNlZBgu?=
 =?us-ascii?Q?ERD6rL3is5lQ0TzVzrUL5C/cOzHvOnc8PPx/jDrvEBm2KsT0a7C/LgqbyFbU?=
 =?us-ascii?Q?deOMVxmQN3Av5bsKPhTnNeXtntAVoBfaEQE52peIy/7BMDpVkYICMQE+5St6?=
 =?us-ascii?Q?t+I9j3OPdIfFqi242Je8Jch67/hJlCz7X2L686npEtYZ3sm8mIW3El+bRa4+?=
 =?us-ascii?Q?xEQD/bP/0MsHL/brAfAIUMainQzPeEkuY/J7MlfSoIxv5aTJZbssin/xf1sT?=
 =?us-ascii?Q?Gx0aM2QOa4w7OplbMHEcgn0TJz+pU038DI251DOE5lB2vpzja0Z3jPgYG3x+?=
 =?us-ascii?Q?TpkkV0iq8BDvDjQy4+bQ6lkIC8XYhGDYS6EGGNO/NSx/VeaRg65teEslnmKC?=
 =?us-ascii?Q?FUepNDykCo9IkGVZ5zBbaD/Mv8MQWbL3w7sXgsSMsFdL8XwJtO0g/A8KAjEG?=
 =?us-ascii?Q?1QNmfxFp2GP4f7Loj8csNp7LRne60oi12JVAYDW4KhJgPlPJKvjyZyPDTG8a?=
 =?us-ascii?Q?eqpTOGOcEsKLhz0diJOidG8jiHh4kpHk6TImJJPcjeXhROUXz5PBaPP+hIVv?=
 =?us-ascii?Q?+aZEofBDuyeAqaCSrxawHwXPsy4zr3qBwUkMu+dptAaNk3P9RJGFsFtPXK3m?=
 =?us-ascii?Q?vgu2dvzwp2wJ8EUMH0x/Pr+L/ojNff7Wf0e8lxgJm4a0Yp/Wzb47yIh8/GwJ?=
 =?us-ascii?Q?7QebSzVveKNvgjUTKAm4OSA9dMiUzIZQgHUpbbzQojak+Qs1iYrResZWtx7H?=
 =?us-ascii?Q?CrdUa2Kcc1G+Vj6irvFwfVM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64484c59-9a4a-432c-0004-08d9b59e3f79
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 14:15:52.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcB+uTwPR0X/xg+0xBxAfANUqd0+aSZzybyJCAXfBDtMqaDC/nxJ1LS2pn30mq5g+KOazYMEQ87SnYR33Rsl9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used by U-Boot, and are required for keeping the device trees
in sync.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 7e3faa78c706..79d7e7cf5403 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -23,6 +23,12 @@ aliases {
 		mmc1 = &esdhc1;
 		rtc1 = &ftm_alarm0;
 		spi0 = &fspi;
+		ethernet0 = &enetc_port0;
+		ethernet1 = &enetc_port2;
+		ethernet2 = &mscc_felix_port0;
+		ethernet3 = &mscc_felix_port1;
+		ethernet4 = &mscc_felix_port2;
+		ethernet5 = &mscc_felix_port3;
 	};
 
 	chosen {
-- 
2.25.1

