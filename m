Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7855550F01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiFTDoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiFTDoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:44:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D1AB1E8;
        Sun, 19 Jun 2022 20:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czlAYbO9eJhyLqar+5zpM39u07BT6p67rZ1lDMKYI5h8BcLOOHaMORh44K3U6uRsD/vrlb9V0BqmxmP6kM/luUxC5Aa3bUR5R+xvZK0EZW7YD44yC3v96xTrJY2wBP0ouL6XosHkKyJ1JvnyfHkL5krzlGyOymZCffqBgBjppuYNiyiHT3NzwsWB/DY1fr3QuxeNO4QdypC7hZKW+y/SOXjkKQ+6f1pOEKm7Kv4/jNJStSfQb9ZrmNZmMiX8TMK/jtZiRGr6qKMCMfSvpMxsNJa2vlK5t9SZq4NY2gHLImOslZmya08zEcn4HJErusyV/0fY6Od/HLbmbqLIr38wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yizgp67pNldag0XQAD19mh7rryGfiSb3vJKiopj3hEg=;
 b=nfmLzJxmobLTsp6TH+PX0ndtxyiD/B0Q1yibKPyd8EpuF0tnJvmWVHYlOxsOw/zCkW+P6cyXBNfC7H9nRamBFc6HFctWbT/iVnmRvDf/Z+Y0pWJN8tnLFE20AuvJ8VV7xb9bYflsjV2NCertpDiD5s2c9QmEwxvLulDCWVzzhFK19iCYK5Lk6GJ2mJt6D5f9+PsyUg2GYf39hkYfD7bN2StsAn/sZZXuB/IA/Lu/ig/XgSHLaPJpfv+th3gZzlcRfM9nBBc6R0HI7Jo3054CgNVMsGNieDScnS86WJsaPtd7tLb6kMkP5QWGi9L/0onWkwdXBK5RVR2zTFmvzCmiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yizgp67pNldag0XQAD19mh7rryGfiSb3vJKiopj3hEg=;
 b=o9Gv0VflWg7osDlH6Lt5aHElR2lFd8v2oJoMd5o7fBPlHvLvU0agagGRldRhTjUIfAYO2fFdvEIoUw0CRzYn2Eir5kmAxfkdRbMa4XQHIy2x1UVwPvnVoTJjXRTQlPBCjbnBRYOVSSHqlzK83vjKXoqvyGalcBQYT717UJmp9Uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB4664.eurprd04.prod.outlook.com (2603:10a6:20b:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 03:44:11 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:44:11 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 0/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Date:   Mon, 20 Jun 2022 11:45:30 +0800
Message-Id: <20220620034533.4108170-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf9cbbe-9024-4b80-46c7-08da526f2342
X-MS-TrafficTypeDiagnostic: AM6PR04MB4664:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4664A6B2CD13242E374AEF6598B09@AM6PR04MB4664.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVXKu3wkILYdmlQvzr+pg6HZMajjEhW3AjZHMbh56nc3T/xTB+Cwj035+DUkdCbESmyGNurGc8zXRori76BYSJe4YTw2tvSQR63/tiN1zmhfvTmHdQlN8T1cG4Ffr2lu1+1g/EwprbvlTsWSnjr5BhrLIR5uFpk0DnNhCU+SFT+edF+8af5hJ5yvojUnU+LlUKbUb1A7l+/bJtjG/EDjKbqlJ2VM1LEnZFGCZfc2CL1I8Tid/BFw9IdRfd6+mGnE4yj+fbZIqJ2n+4FvGWTbJPP+Ya586O0YEMYkyCzYP9G9P3FEPKjyhDJyCX/VzysQKo4lo6VpT8g6aPSpWgu9g0IaqL79bKvHWrYFx5SYceHtMCbCyqBHBB9PrVaoxPFmhJ7sRlYzY79Ck1PD8b7BqrcCed4BoI0WniPtjMHt5PXWCECB+KjoXdTO6gSA7ZkRerxZEq9wQTHq6muFAnuSHBfcNYEUHd+3D/7KSeDpwg8w8cLz44IxPRmYXLmfwHpC/dBk1d9iXDaiZLyBnwL+pWQiNi5QtmyGP/XIygnaSLz4OtTZ96IME5hB0B+ktnKUCplLcWmQmL/Z6AOFHt41ciKeKD547KZZD6sF6wU+YRPLbMnI9K2M9FHgH7mDRgC7P1Gk+0EJe30qVtjdxEK0o9arNCztJTxEfBt1WpTWeYQ3rVqJ6b0d2HFVcP2Ju5oYPpJCVxXYxvb99jCCKd4AEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(83380400001)(66476007)(66946007)(6486002)(8676002)(4326008)(316002)(478600001)(66556008)(86362001)(186003)(2616005)(6506007)(52116002)(1076003)(6512007)(6666004)(38350700002)(26005)(38100700002)(7416002)(5660300002)(2906002)(8936002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4mOQjAtC9p2YDklEzlk8at5saTRI8qvz3ibmqzeQxuXfmw93qTZ4pPWYebj?=
 =?us-ascii?Q?4LwzINIWTGV5Mddc03zMp56ajIMpvG4oF541v6VgRUEIbZkkpx7cc4FXaeIL?=
 =?us-ascii?Q?PXJoDddN1gYH4HKwG+6e9GpJxeBQoEEg/gZO72R8+XZ/PpXqa+YPtLATp6jh?=
 =?us-ascii?Q?nCDPv3VSCLEK8OIbplDQiiW7GT5n/NQouJ9jsYqahSTeoKjF1UOjAbJ4iTay?=
 =?us-ascii?Q?UM+Ze83i42R3XCezO2boESxoColNyRamhmVykRpn/rRxKBEsGFt2pkzLM7Pa?=
 =?us-ascii?Q?omWGXyLEwcMwQJSPNeE+JRgfb7Sw19L9Xtj2d2x9qmfPJMzYLGX0TFx9LhqA?=
 =?us-ascii?Q?BKBPcIocBaoeVkkI0u4tUiWe2VXD3fHwNVGyigOBEiIpnFbNEWupiUnUr0gV?=
 =?us-ascii?Q?e6CaDP+NWocMvSWqY4v9NnVf2/LOhx7IsFJwyKmBS1vpUoaF4rTDK4Npg1Dw?=
 =?us-ascii?Q?dLaCwSALLTFKJ2HYEkY6I0P9H4omwJQFHtz0iAA1uZKIBhmjiZGJvzpuyksf?=
 =?us-ascii?Q?wEV6SaWMy8d40Us0gVqGdB8bfP00WncPgesdl+B3dwzPr9xbwv+ATyS1ZoUH?=
 =?us-ascii?Q?qGS6jI5Q3kxxS3a6lg48GRT9d42vSYx5xxRVAlevTzlWg56LfqTxpUQ9a05G?=
 =?us-ascii?Q?fqXJWQtik0A/Ck8R9t51O5vkRfiUN69uOZvwdL1a3nalqRLVHYaaLrv0yK85?=
 =?us-ascii?Q?ji5E85m/yWj4EK7ThFrPNFltuCpI+QXDlfP3C4DLPFJrFprktkg9iBT768sF?=
 =?us-ascii?Q?T1RENXORy5McSCwTN2jPHVLwiBYW20r+Ee027zvIM9afE4poFA6mrwVKumLL?=
 =?us-ascii?Q?lGKQQd7KOXZNsa17SyrMeX8p/9piKdmDS6B//pzVfnaK8jqejHQJUBPEe7Eb?=
 =?us-ascii?Q?NxOCX3AedIPj2wCd73Lk/vSJ3fiTxe4zzNOk0PF70EGj48vfYZEHk950rbDZ?=
 =?us-ascii?Q?wjcj3wE7664uAxC5xPxGqO5VEQ88zicNlTRIfsq/Tm585Ae/of62qWvT13BG?=
 =?us-ascii?Q?w6OvBZzSalU8mz7p25i4Dv7DWFG5iba1EL6h8HUN2PKXZHIRKyBAqFZS8cMh?=
 =?us-ascii?Q?i+iYaTlcx0WwldQwbF2y5Z9XRWPBss2YQtwKnAjPuHt5IdDh7Wy0Ff7N7bKc?=
 =?us-ascii?Q?eNtW8rR0RS7pIVQT/K3PjZdcMspCtxWP9BRbLOidRnNe8yuVTb5luBWtvXz4?=
 =?us-ascii?Q?XK1WFfUeHXT1WiWNRWhsTY7aNWyDqbmn6iDVrfdknNu/Wsx68MjeoBMjazAV?=
 =?us-ascii?Q?ADWF32nmoXfzpBaY1dKuoF6PbAb18YRuMPk/IxSKdTuCZMfxgg2v7KWbrytP?=
 =?us-ascii?Q?0qDIdrkVE/Wd+RgJuruaX0EYfh+avv3o1Af0vlSCAsnSurSR5nkOTV6o5LjB?=
 =?us-ascii?Q?9iwd2yJUkYWBy26yugLl0UZDQP+iG7BzQYrNkKFGwga9h71Bh/c/om1Ih2SD?=
 =?us-ascii?Q?XnpPyGZ8cupfM6JMT1SWAQAMdgc7EBp65h3YreZZxtMJTGgfXRymbtAsCldU?=
 =?us-ascii?Q?u4mIWjpLy/RH66heyLTTkdeewLMWgo1yFsPtd3GWQx3woTPmdhidbqI4T6m+?=
 =?us-ascii?Q?0lcDzHYEXhz0f9sBaNmoIhY0kAL0R2IRFXVgurFyGZMOICokt9peRDSob2y3?=
 =?us-ascii?Q?iHJRRvFOhI6qsA+fdr1XZnGqq9RVAK1FF3XmePLsg2PZ4XF9eSGP/QXKE07f?=
 =?us-ascii?Q?Ra3CcG1XwuEQR+mJDGNxcmuNjg3KglfZhIAxpfgrbYXtuNNZk92n1Fkgo5kw?=
 =?us-ascii?Q?cfwM+hAtPg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf9cbbe-9024-4b80-46c7-08da526f2342
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:44:11.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw54ItY04PdMjC7JUKj1uC1fDZVBGgkrQsoN1+ABxn1EMHpmWM9BtJixwP8448R1xHreQadupOD8j86Vb6ZBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to add Freescale i.MX8qm LVDS PHY driver and dt-binding
support.

The PHY IP is from Mixel, Inc.
The PHY IP supports two LVDS PHYs, thus two LVDS channels.

Each LVDS PHY may work by itself to support a LVDS display device.

When two LVDS PHYs are enabled simultaneously, PHY configurations and reference
clock rate have to be the same since there is only one set of PHY registers.
In this case, the two LVDS PHYs are usually used to support a dual LVDS link
display device, one as master PHY and the other as slave PHY.

Patch 1/3 adds vendor prefix for the PHY IP vendor 'Mixel, Inc.'.
Patch 2/3 adds dt-binding for the PHY IP.
Patch 3/3 adds PHY driver support.

v1->v2:
* Document vendor prefix for the PHY IP vendor 'Mixel, Inc.'. (Krzysztof)
* Set fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum. (Krzysztof)
* Skip 'clock-names' property. (Krzysztof)
* Drop 'This patch' from commit messages. (Krzysztof)
* Make dev_err_probe() function calls as one-liners. (Krzysztof)
* Drop unnecessary debug messages. (Krzysztof)

Liu Ying (3):
  dt-bindings: vendor-prefixes: Add prefix for Mixel, Inc.
  dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
  phy: freescale: Add i.MX8qm Mixel LVDS PHY support

 .../bindings/phy/mixel,lvds-phy.yaml          |  61 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/phy/freescale/Kconfig                 |   9 +
 drivers/phy/freescale/Makefile                |   1 +
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 440 ++++++++++++++++++
 5 files changed, 513 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c

-- 
2.25.1

