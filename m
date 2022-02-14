Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709704B40C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiBNE01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbiBNE0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:12 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41324F47F;
        Sun, 13 Feb 2022 20:26:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifo1XEsLVrL0rWadcKN1Fe1EXMbaDHUjGTUvYm2Td6QagKMCwT3NnW8wdzeYzVT9/WKoipudKBgOnWG9U5yLVxt64I1aru/332384jJSN+Qngp5N2/hH8dCETGFkcBzAYwLYeG5xRz9Yd/whywxzZxWVSzC6LSETsmtOeEOVVHKRLXJtDHdgF3Eth87BYZbzufP7CQ0dvTr4FhWfv4STv0Yb3xuFxbQTkOCxe/Ay1KqhZizFOn9XdFb3Sh/8uYSVnnXGVfKgVpwV0ZOo30ssKNn+CcxGvOehaVBWrj8ag3DNLUwZkCnlVNBPI67BI239WPue3D1ZkT3zNi6SjIgm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lt3iNPXKIzzi2xs+5EMghw6HXh2oB6hYycNYkBAYNo=;
 b=WUKvyI7KwGtvgjKXPIMdbGrP3e6IyYqsj4PCsaD3TwIEjzJWRAqIosURABFLtc9qepBGOZXTgmFP64QfVsY7UaLEMoKLZNvkM3hIRbXDgu1AzD2gPZDfK4FQsq4ffnL3t7ha13n2IQQK+k5valoCm2MWKBtCRiqjsCihq2JWP+HVDn1xcg1ttF2dt3XIznWAv9knOTymcUrHa/Jo7+NidG2f4ZhGQa8R02wSzl6m3L+JDyKdPkWpc9hbFFKs2/LN8zt23CjYQOL1kc7uGgSC63XZVIuE3SpIVHnuL7tBYPKl31AGhBKvBVNkoSG7+5DVRxf5cgGPGohnkTaAXFIWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lt3iNPXKIzzi2xs+5EMghw6HXh2oB6hYycNYkBAYNo=;
 b=XDQj8vV0FbhttlBwFzUzer4rZcxaOcIR23ko11eO2cXUprTL6b3Jvh42XoTn100QOKLZretArJ3z58aBixDauItSm8lFRytQPh5AJxtvKcnr9oHN4W5H3EBE1LFyWdl6RnWSCEir4YvQWCt9pAAMRw9v+TM4rVxzSnXD8bId8Y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2451.apcprd04.prod.outlook.com (2603:1096:203:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 04:26:01 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:26:00 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 04/10] arch: arm: dts: bletchley: update fmc configurations
Date:   Mon, 14 Feb 2022 12:25:32 +0800
Message-Id: <20220214042538.12132-5-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d140c8a-f11f-4880-5851-08d9ef7219c5
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB24515CC5136F6677C7026AA28E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRB3AdixcgqNeeGqvEyh3nG7czf208DZa6Um8w8y4g2e4X7pci8P4StbXlkYChwxMdcaxj0wOVACtnIXk+88mvjpgPOX06J2A1E40JWBF1ZVUlmpCOUHdvXbI/SNz9AMdGNoOSV7qr0D+lQrcbZQdgzbPZ44qCo2D0J4P4frYF8tB4NE4QSvkCnSH6c9mlzRs3Ns8A9eFEXfpLeL1cNlUe+He1lFrARis7m3nBWRq0KGqFiD/pmLu9ZfeUaXTp1sU6LnDXBEMGGv8Lasx/stuinpHFu+7Z2NWUI9Dl1gCjVCMX47DPJzR3gL07paJlS/5x11W/vper9Kxzdze+Jnqr/U0Tf6TbkagNCs9KWJwt2JXH+m8axZHjPPZv9e7dyF5ZEMoWwgJvCYtX1InGUozToXiBKCtqJhfcbaKkTsjtdq8/YXcecCiz/xWSDp1Pp1dqqvAFR9syj8OcdjhiF+WyBzJcU1K6oSIBW9HMwXg5fiSqCjgvvPakNRTCNU72CzBmS9SKcRy2CeV+O9yafPMcEVwoFQNAw3y/o/fv1Ieq7sCb94O8KqtzUNzqMVLUtFm/4sokBWCVbi49QehHJAFpqmAqfvLqplZ2Igw63ro18B/5p3DvgnlH5C4xnBxXq3U1h174BA5izXHoju4HKmrzVnE6NULhmfXdw1ZZn8bB2hrM66GrzKtsnbGO5dV8AswlMyOWUZ4bf0DvjYcF9VZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(4744005)(38100700002)(38350700002)(6486002)(4326008)(8676002)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?khyfGgg6RvQTsJ/Jq/J1jx85zEE9UVYU2T2Ej3XNNbQVLWsJCdTwQTrh4Mdv?=
 =?us-ascii?Q?nSsR0rewCLEda+EurFAQ4KvK0JyNpCUYyMDCLH0xex/DuJD91F3x77Td5H3c?=
 =?us-ascii?Q?tg525S6IwuRvGLkKcocYQX3Jd73Mf0iiZ+38pgQFxqh0Zflcd3qKFjHbpj/0?=
 =?us-ascii?Q?xv0whPdh+HQ06SpN0F/UQUDFjbnIXJYHf7ggW6hoIgRNjS0FHGMgMy9kua8G?=
 =?us-ascii?Q?nHjsnzwmMlu3KonlIsuoV57xMHuMnkjrbCegXqU56tOUDQLQAqS0bmbQflUm?=
 =?us-ascii?Q?T6Eg/bpj1O9FRDe3DX9NYsjT8F6sgqInDkaie8NmmlyFEQM+SVzfkpuCJBbv?=
 =?us-ascii?Q?wPDWe9sFBtofNevN00SE/9mLSPT3EmTquCWKOkSqRowNg4tdAIcHRcCj8mUh?=
 =?us-ascii?Q?kYV2uwKwt+24VPyC/JY1Y5K2cdbJkjoirUt6+VK7lRMh+XzwcAKJlOodBYQT?=
 =?us-ascii?Q?a4Ct+iCQhl2FLH+DkdmgKkU6EbiRQiL9LC9cPT8FRkgW2vDElezc7HMyi5Hm?=
 =?us-ascii?Q?Lq4oD5uJzWb21n8OpAj5KxgyN1jucru707xsP/jGTPpzK3DDpXotChZbG/Gr?=
 =?us-ascii?Q?2oDkZof4uUeXe8+XPAgswKP8jx2l6o16Trbgmm2sU+LarWDp279v+vSqPkoa?=
 =?us-ascii?Q?be4EorBTEs0AHImrp8iT+1mt447G3cE3B/vWHQ8wqihMjQ0URT56UUQ1dHLS?=
 =?us-ascii?Q?1BiZCzQ139fKWRMkegfCgKGIzDBsekvsAlEUiImnekAxNw1cW2U2eJdJVuyP?=
 =?us-ascii?Q?KbBkbvdMaypqb0TT9tAMQmcNUoCOKWIFcC0SUlkYYg494ZGl027sXeyrJTqq?=
 =?us-ascii?Q?LBCHcEoGjEV5opgS7hoLt8BzLN3iArLfBiVLbRtH45Q8ilhYYIc+u5O85tVT?=
 =?us-ascii?Q?zO0OE3vhZa8IU0PJQT7w8uuqrjPB1H6RROL6bABGDFN6qHKcu8Z/buHiJ+LI?=
 =?us-ascii?Q?hyJzZxj8769iQ3QyAMPH/jPmKdgk/Nubxpimz2JxtuwfQTRuJ5UFKYD5k6u8?=
 =?us-ascii?Q?w9IwSXAFzsliReycjaIOv9Wp6B/NlUqB2GYkvX5NGo/dYgLEYVty1+q8hPGE?=
 =?us-ascii?Q?rThcWPES4rXopsw4s/RzVmpYe3JI3oGiiRw6RqyrfP3T6AJwra4Zm7x36DGC?=
 =?us-ascii?Q?z3ijy79hp6gpIbK3ek4j7En3KZpYIq2JhfQ4xPbcDyrm5NJNkNyrnDz80NXA?=
 =?us-ascii?Q?jXOC6HZxZ2cPFYoLg+O3z7Inj5EJpfSoW9Cqv8hJicBLHwbYADWS/Nz0B5CA?=
 =?us-ascii?Q?e9KFr31+pjiArigYr7fxeFpHNu3cJ8oINEKJ2Hfx8bSjhiTut6r1RnB7Yxkw?=
 =?us-ascii?Q?8cr+NZkbbm0Y2d03IaVUkI/H9jr4C4sQhwVKxLQKUza75qvcAm24sYVJ/yZ9?=
 =?us-ascii?Q?KM98KQtrUtzvMwsGwpCSFcRevwulyCr6dKiXv5EKfGs6sk06luENGMflbuZ7?=
 =?us-ascii?Q?u1ZIYs67u/zmIaLcNxwvGHipFaUX8Tbwaslvn6RBzJ3xXFZuUqNPBmLrLLp9?=
 =?us-ascii?Q?aTya84mNVp71FJ+sFcVzOPMi2gvyne1WawpPUBo5u/xvN0LO4DLwe8qsX9+y?=
 =?us-ascii?Q?Wda1zEjldxIt9uqriE6SgQx1X0fYjWKDGj14GW0XQm6c+BStMVhZJFbV192Q?=
 =?us-ascii?Q?5FIBTZYi8XLwNbLHV7xcQeg=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d140c8a-f11f-4880-5851-08d9ef7219c5
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:25:58.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQBhUc5XXdCLj9QY3Z41Z2Op3dqFCKAqyb72RdD2L+qDSx3t3hDzr8FEw+vkEvTkb7HOtytQWBf4t8vZ2PuOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add flash1 in fmc to support dual flash module

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index fc0690ccdb0a..b01f1e7adb81 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -217,6 +217,12 @@
 		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-128.dtsi"
 	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "flash1";
+		spi-max-frequency = <50000000>;
+	};
 };
 
 &spi2 {
-- 
2.17.1

