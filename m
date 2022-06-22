Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8605542D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349706AbiFVGPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350775AbiFVGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253C411F;
        Tue, 21 Jun 2022 23:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsrbuvzBa+K9BxHEWeod5fB9STFZk8NjR79rRIhU9Q2/L9q+7ZA7RaLW/M1kaRSU3WlYTNPWRH+tWk8PJbHJTnnSO4ErPJX6dcEEH0zgd8uZLJ9HAHBUOAG+tVS9jIK2Ca6zswball8vttfJErW7GEzirETacBsOf501up1bZlJrDIqSgFBh3WvjM6Gw3Xjfxxfv1IllDtOg6sEZ0M8BJrXTO5ayU75IclGXETMAfsRPGtzuMnF+6AsXsq7BQCA+s5xt+B/sQIUtTyrBxZEnCG8fb9JH9GRjQ+As0JPkWFvtyivUJc8F31FR9KHCXm6tPy7Y9BHrpg2sIz2UXkSXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VQOsgEeosu2J66TThbMa3JjmRNEmRPfcnh6oFSb4Xk=;
 b=KK3V7NKxJzV+2dVgG+rDaELii+My1D+eV8LLpW1cfNbaAC0H1Dhm1VdFK5l6x4lhTbrojlv+w2BlHqEwTTT5uHPzdBBdNw4KoXXH/PB+5qPbUZD5g3qyWS6od/72fdj1ehXUSnqmGWdJbPVrnFytlEK0UylbFzitjFIHXwaEnF74oX4SOl2JKHMmYjAaquGwMAUV4nqclEL74mJderJF/CxG0IVeT5MCvYrQEG9J8q2E+V52C9M+rJn6Ep3MPyjdMLEUatQCfRixy0y+uCsVAJRe2Q/QbqQeX+Dd8pDX4lXY3F5fZMKfjcZEmoI1DuLTh53h82PXrdcgGUmc7Bcr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VQOsgEeosu2J66TThbMa3JjmRNEmRPfcnh6oFSb4Xk=;
 b=c4YyScSwmhvc4PsoQ1YXnHS/jxUh1ARmhNuBsFr7UZaT9fCqPjD/rxp6vzNRGkY5In+NKAOFQx4yASJg/Smxsow8+NET4uRn2GhRCYQztqSomjWt+Fg4BK5iZrYHHme3FWgfdCh0/fILNkRsS/+FRmpEqLZtWWOoHAKmvCKi5vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 09/14] arm64: dts: imx8mp-evk: correct I2C3 pad settings
Date:   Wed, 22 Jun 2022 14:14:05 +0800
Message-Id: <20220622061410.853301-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88300880-f039-496b-f391-08da54164fb8
X-MS-TrafficTypeDiagnostic: AM6PR04MB5623:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR04MB56233D4E71BA2BB622515EB8C9B29@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiBcr0F3x127HQAvk2tGPP3TvJ8k0gVgfOPu0o4iRmBFPylh/q3cUI5QxxceiyKcGTay1zl3rUDbZ+e+pJjDbyCATV9+G83eGrle0q2zpMqgQ6uVjTz2LezY6pttzu96Zm4y07EQxFCpGcDc5crrG7ANAZl+2Q6p6H96y5bTphmOau7lH33gqgKo+SGP9lSSl0UysfTdLYcj7pIaHTqYPOT7N2P4ZD6z8vjEvWn+GpT7y3dinN8GdHsQ8o4ub5SouZFImNQiD7lySHbQQ/Sc5cAttJ3q+/w/VWZmRQSdoRqB6qzGx+Q1kSohii1/qxLI7CRRqOlAGKPzdTJX3jnlB4VyhjqPVeX60pgKUk8NkTU7mGzIGuk7mHjOQTfc0m5I1QdDuDe0k+1qTGM9wqUMSAn3tBDZ++NYteqQ7WtuIc9R/irw7qlV1G6L+h/oSKbneWnExjtkctH0m/mXPfVOPcH3IzTP+VDRa9WAsp8tTlprcc84Uioyw40IKj9KlOldUarrZTeVg5cU0KIBOXpE/HGs039BJv8RHt/J165Eae3n8ZmK6+PNK3S40RKWpb6HzKXkkPw3VmF3sCDJpZ2rQoLWr78XzGwWA0XHZ+yq1/bV7ceOazFdpvhY2D3zMH8eiJ0/JCaqfSZeNUtjjM/eN0PgH14jfcmOTIc0Z+V/cHXOxPE+fWxiOH6y19R19Zk7LdkN2q8TUke2Vj4bKsgMjfm+xYBzTyjqzGHnfXLD/A84japF80d9gxImIOrw9EoVFMNT6zsK+4ZWGR8cdU0a4fNvCloXc4MGJ6DRdS6SISM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(6512007)(66946007)(4326008)(6666004)(66556008)(8676002)(86362001)(316002)(6506007)(52116002)(66476007)(26005)(6486002)(478600001)(1076003)(38100700002)(2616005)(8936002)(41300700001)(38350700002)(186003)(5660300002)(2906002)(83380400001)(7416002)(4744005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?15ioxKw2mRVQSnizCUiXMrjNF+k/K+K2/y4gLdwGAJvjLy6CV5X1P4IxCTW+?=
 =?us-ascii?Q?jnF0m+btvf1vq/eS4oMEKqfC/S5BfM3cWDcTWm3+fwzj9i1yaFNEN4N5jinO?=
 =?us-ascii?Q?/gI/JSHT9LbKKGRk2ef/jLIVwlpoHDEDQXJnrn6eIOUBxFzi7YZdryYxxoKn?=
 =?us-ascii?Q?tA796igzKMw24g72ertYgx5vTs5Hiy1cYfxOV/PA++CzdCM6b1+77eKlhyEe?=
 =?us-ascii?Q?8ve2L2A8QkXMbZUuwU7Np7UzY4ynbdrIQN7Kg19ueIfsA2CPLDHH1o6/0m6C?=
 =?us-ascii?Q?Sm5g+/XI5CcJgEICKkAy8Vb7akcQU52wH3WTskOZgaEBFZ+St51giYG5qf0m?=
 =?us-ascii?Q?oG9gVXjdaWyC16zEyR44o66c3UGk/O8GypX8TS45pIOLRdQh3dmuARA4qJgh?=
 =?us-ascii?Q?0p4y/GWFcKGIV9BICXsadfWWjPIz9HrHq/UgQNoKGWn6g88BZFXhhdvz4zYe?=
 =?us-ascii?Q?qSTthu7mq6VKLpGLEPXSfkUBafVZrtQt+e95qkK1CAOIZckwuuGK7GsW9r0E?=
 =?us-ascii?Q?UmfMjsFQoBRu5o8aiXQ6ebnni+EA+hDjr3gSBYlwZgMdInwM9i+LzejCWfvD?=
 =?us-ascii?Q?+rK5fgq4hHeqEHpeZ0J6jmnuuSr1PtDqiMDBuIi+WjH9lBoo2Nv6Fmlytbz8?=
 =?us-ascii?Q?c8a9+NZtDOCWsEBkZkmQ3HgB2e3+adGGZrDXG3815C8oV3g6NAcLTKyD6dua?=
 =?us-ascii?Q?59WMQ0itxQrU1V9EJa/5gkXRRECG3GTZn4B31Pl8DOsk6QTTzJgZLaBC9UDv?=
 =?us-ascii?Q?3w6YYHpolvLEG9BnMsCTesNTw0hIOO6zGjqlwz6/s6mopneqeh6xCVARpwQr?=
 =?us-ascii?Q?fXaL4nQJ3wGwxN+SBd7vKfK8Q0bqtOWjDfCSv/9475z9qPulrZMZlehod70b?=
 =?us-ascii?Q?Ky2A+u1VZ1I31fmx8J6TdTFi89PVyvo7EiiOXILVbY9vxD0rzfeaMENApocW?=
 =?us-ascii?Q?v2Y/5AFnOEM/kZpHA+YA6DCYpAQf1RiOAkwtiOB6MRIt89qunYWwBM/vtHwb?=
 =?us-ascii?Q?FoEBqpzQxv/vLPi3dmL/MiSMTQASP6JR1RIiahAM1SKKyufGIx+ZLYduT9o5?=
 =?us-ascii?Q?uJwZWZ7toSPCf6DO7NzeL9E++ngYTBAj/317LdtJ9w+RkpR6gbDwk5p1XJ3/?=
 =?us-ascii?Q?+tLI3PoglOq56pxn+XjGEZPGAzwOo0ss4dVBRS5NGjemk0KtDeeejTuHUHQ5?=
 =?us-ascii?Q?GIleEQ+osULDrNbG6QcoFfbhd3+G3wek52IlH525/EjUboTWvdHSVHabShOu?=
 =?us-ascii?Q?NSwM0YQ036jC+4m0D5Gek+84rHd9BX8aUkVGNg+1c8OvwBjCJRBtmqW/0SMX?=
 =?us-ascii?Q?XDuLsJVpkmDdygyiubZmbuwFN9Is5QWVBlGsHla4TQFzLlkyV+6q2Q2VaagP?=
 =?us-ascii?Q?TRGiSYcPbutJyoFkR8oeTEPVNmbVEMwWRVQv5NeyUuSJ4GxPBc8Eg9R1XFB0?=
 =?us-ascii?Q?oTQYhDwH7dU/WBbpy2GNAwDBbh7pF2N1oZ2wWsjDr0VyiiGV0Xe3xXt8eKI1?=
 =?us-ascii?Q?bENDbzWK/J4OQ5Y0aeXxdFJaU3RrYTixbSZ81zACq3/EB7aTWSq0pvr55bZS?=
 =?us-ascii?Q?DUo1Mk8sKj8OpO0xF+V250TQdrr2GbTifBZS5wAyTMtRTG3wRUymH1XWWlJj?=
 =?us-ascii?Q?TQNy1EXHur7B0b0Xsk54Fdxg0Z7RFwpbzSofJGvrZJ7qAxJyIqoqcocsxtv8?=
 =?us-ascii?Q?AZce7uPq9m0qMAnVri3XLIp+DJRClDgvjtOHsNl/kAJ9dNBW0VP6syDcBd42?=
 =?us-ascii?Q?GyodG5i1PA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88300880-f039-496b-f391-08da54164fb8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:23.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEOkF8hi594JJVr4o5T/pKh97aqP++hW+YKKoc9LX1/SyhirHyQHOx5H2/CT8DQ62jK6wQDGlTBpO6kMlquavQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5623
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
 8  7   6   5   4   3  2 1  0
PE HYS PUE ODE FSEL X  DSE  X

Although function is not broken, we should not set reserved bit.

Fixes: 5e4a67ff7f69 ("arm64: dts: imx8mp-evk: Add i2c3 support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 510f10fc8e1f..fb11c03bc8b1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -490,8 +490,8 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
 		>;
 	};
 
-- 
2.25.1

