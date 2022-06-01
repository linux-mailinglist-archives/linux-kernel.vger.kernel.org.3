Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2453A0F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351307AbiFAJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351258AbiFAJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EB45AEFF;
        Wed,  1 Jun 2022 02:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB6E0+Py5mVPLYMRgM/YuX6vi9tdsBrZ47NF5Yi/SFyKh5KyY85CrjaPltx7hcxsxOYKNIrNVHdlWzostdXYFZmy+vDgGRT45SJvvTl28XnctWay+07vA+fIIL8pGLZVcQCbKPVoupYBrtIv0zJnV8vtdARc4nih8qEspMdHRsYDK0C8qr8r5UW+5p6aUv2ESnbKawO3CTVrPd6INfQc8Tyh16uW9onNf5wRqwy8BH2ul6kQwujPHGEO5cK3IhjTw707OMYdu8N56kQo8T6OFokSFsRzIzCULRmTCvVO5U5+Qs65cjvyFpJIWyvDgEvovG0HMDprDbvcdbAu6DqbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZI7qG5/515drLM7ZES47yjJNZpw9esD1lytih0Cg6s=;
 b=jdxxgNDEF4NjhIeCBwOlUzblL8qaRMlAFb48YOqLPMHVW1XFso8/jBgM8VdWvFDBwd/8Ku+LFCGNMp4Wp54lbR+TYKpiEO1qqBkjzlSxo3Jyffl3TI5/Qqlu8ot9RM03RFdrMWa5TTy5X+BIP88swH5hT2NhXXTfcc/8/yXoHrBVN4+0gI0PestzQ7gw+yIDio3E2TnNSOtOjwN77KYEoV2ZmRcYUx9zYZI5LKgXZDH1y7sf3AzslSsOhJRIMtj6wuXjHc/heS2PWrUPLBpBlfJYrFpkk07vDCAnMiParnAKp3kY99IJNNNt2xPIrFgBx9/eNdcSrjpweTfjgYkmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZI7qG5/515drLM7ZES47yjJNZpw9esD1lytih0Cg6s=;
 b=cqJM3+0BblI25BGjzVtO4Dkl2aHDix2ZWXt9xh1/3VFQanFenGkvk1jreuqdzpG6C7gTfXDO0ctiCdUnmSelDGz7lXuq2MhHiA0Q2kzsIxyNIP3s3PKuKWK8YwD7K4MSTW8rBpdM8aWfk++WpoxHGu2DTitQ86hWtCmscYwP/B8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:44:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/8] dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk ctrl
Date:   Wed,  1 Jun 2022 17:45:31 +0800
Message-Id: <20220601094537.3390127-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 720ba5a3-cc38-40da-fd99-08da43b34504
X-MS-TrafficTypeDiagnostic: AS4PR04MB9507:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS4PR04MB950735A0E3501AD7EF60ACEFC9DF9@AS4PR04MB9507.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMNDsa+aU/W1h399p76SNolLj0zOaL2Gdm06t6AM3Yt2L6FYYu3/SL2cGOTsNsa+wcrvSDGylCxRfdtPx8XNAVKeAuaGMXcw34dHSUnUmzHN968u/J0bFmg4y/jZEKqoqDUKhtp4mMnjtqzTNpblJs8WGxRN8Z75U3JYDXHz+3oVzvPuh0BHZINjKVJvRMx7eYc8LrnaaOW3k+nWJYsjz6N1oYL3hguHRL6tOx/Hvt7P4qWWiWgHAAkjc7xWm0iy2l54TsEhT5RHNK691tGPweXXdDpOjQEonHDQqBkpDYd6Yn0huFbFB2SIuZErgOKIHQSd9J6kGdeKaK0d+o6YIbvuGWSDGUfWk83xCsJf5CjdANjNHGH4yUg7oqN7pYQu09lJk4hQBDKp4djRpGjs4FtbhLt2QFcauoJuCuru6EBkyipjahY6ofa17oqaYjvFz3j8USEgXhvMimruCdJw97Lji4z05Pxi+cI2HCws6RvAcpywsl8CGGCMClBtZodFNarPHo2bd3xu4k34nAuOCVsIgQ4rk7mLvMRvH+UA0TnZ8uf360XOQor5hCHRuqjiMioiuZ0/StPoKyCN6a9ihKTinydf4ljNS0CtwOqZkw1vKNCtsDvwm4OrIzKlnXTSvIE7KCGK+8wbrX5sWW5pdfaK5kWnH9w0oG5wsuUXkVkvCt1rPTE7MhFkuPw9ixjjok3Qx1zSgTiLpCm7LLj7ArzsWWIxbmFP7h0UQ/IhdAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(921005)(6512007)(4744005)(6486002)(86362001)(5660300002)(52116002)(38350700002)(38100700002)(7416002)(6666004)(4326008)(66476007)(8676002)(66946007)(66556008)(26005)(6506007)(316002)(186003)(1076003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WqDDhniHDRjUSCvtB5emwl78pb5tHeLnZlxBNxEv2etOUps/7MbSaNyAySzH?=
 =?us-ascii?Q?QrDq1zrozQrcV5xJSUOgmdMopR84b69h0FMZlYAhfmPjdYtTbM1GS2U6iPhI?=
 =?us-ascii?Q?Aji8jK3jxyuWvCurGSaevPm+RVw1nj1r/Bh1alzT8xYNHSojBr56Wk725b6/?=
 =?us-ascii?Q?j8lgno4TT6dvkCONoGf0edzsZG8fl/bjtmFmKIssKlw+aStCh5g7MU2wwtMl?=
 =?us-ascii?Q?gx/5/WiCwj3R44kjYomwqkdnqM+yn2QXU4w+DqNPmubmMRrVXuuXzAwMICcj?=
 =?us-ascii?Q?c6wvPgBsTFYYvNHDrGR3BN1BXeOzNhcDqUbyT9lvQHeTuwQLRmXYfLpGMKi6?=
 =?us-ascii?Q?CtLr6yVW1zQP97pjfmcGuu1OdDGOvuoGY9D5umfd+ckGT6mr2EipmjJ68UQJ?=
 =?us-ascii?Q?4dpas/iek1tfMJEIZ2yz60/0+ti6J4Cq70dAwCDJDNgjFApsTs/DwXR+pZI+?=
 =?us-ascii?Q?NW19dkce3hLHMnmDtxWxJ0JpEzFhfl6ZJUI4Wl2djPKy0wt+0hokvYF4juES?=
 =?us-ascii?Q?M1TEkNXHRUdukxZlM8KWU2+eBIygqBOYCX1m+mgt39MEsbqVBD7ADakhMa+x?=
 =?us-ascii?Q?nalR9EdD1nG/7k5mB7Mx8BX53KJx3q/pi+fF/hyM5Ucgc9tocdFHjYS9vM/2?=
 =?us-ascii?Q?awQnNVuP2SVGmQVVOlVbzzPdfBDWbhm2lg8xQjJfcdHrkb+F0kYeYsPnC056?=
 =?us-ascii?Q?i4vGbDwUvFQD0pHte2exC0zCwglRz2bq0U4ZkcSQcfvWuAJllsBjqKV0TFsH?=
 =?us-ascii?Q?e19qCbXx/UiF6mfu90hmikwSd7vSFp5v4GAjWRTUN0z9W4YA1/v5KF9SxP4r?=
 =?us-ascii?Q?O4tazVYie0uS3DGjJyDghOuiSBkajcdpqH7ezD62BoqbPs218FixWu0C5/dD?=
 =?us-ascii?Q?izPlQMicClq3t1ZciN9sXcDxpg50SFIv5HnjbBbDZO4kEsDS7jBW98Wwxdhv?=
 =?us-ascii?Q?Wb8ikpC3H33SuWIC0lBNM+8dPYKRLlzm7BSpQIUgZgtU/i4qXLZurvR3OMc5?=
 =?us-ascii?Q?nCW2fCVHSQPLKW+P5SiGSLxtDbaAHR0Z1WRsTdy2MSBOU1Xlljmwje8OLazZ?=
 =?us-ascii?Q?2JytaHea+t56QxexpiBIUscyZ7oWWsq/IkRL1UeQk9Ly74kkS4WlJaDi3Z8F?=
 =?us-ascii?Q?Di1/dddGXHvnpY+EbA5FidmDZ75jYPtpJ1S8UZZ6LKKSAeb9RAs2QD2tYGl4?=
 =?us-ascii?Q?pLyYD9ow7rqHHI5FmqhETvBJeyXDdnN5DLNHX7CNAOIdier5Ft2qT6Zv000k?=
 =?us-ascii?Q?bz95Al7hbSsXML37Lo1AtnaRYaao0lpciRCQG7HUZ++FgO4bZeWQShP9teNR?=
 =?us-ascii?Q?aU+Fyd7XMKX0wCSfpPKnknYyvsdB25jg/I/CSFFSoODBB/LB4AiEBdKPmT5B?=
 =?us-ascii?Q?rJ5bDXc1McweWUQPIUJAFU3NPdOgZXxqM7TYj9jmIZ/bAyFDB//IFcURblQa?=
 =?us-ascii?Q?4WLsECWbxvq7duH6z4+FJU8yzGm+F5Dl56vpArrtHyE/retQ8n2eRd4bbwJF?=
 =?us-ascii?Q?9513MLICuhMs4rWolAKvpzi4Ejq1UA8frLeyriV9GrvNonvZm1wMuIQ37crj?=
 =?us-ascii?Q?7ciGwGGbAq4kx+EUaOX8fbRJ7pIZ5H+H/C9YPgW8v+Pbs8YSDs31HW1s03PN?=
 =?us-ascii?Q?9gJ4daZsaBaD12VS5uLtZxa3dyg0WUSWotRKHVpcuPpAcshwgkRTl2h/LkmI?=
 =?us-ascii?Q?YzQMpDkaPlLYeheJz5YcO39c5ZfhI/TbqATV8hR+eI9EP87OmIDCtvKv9aMO?=
 =?us-ascii?Q?tdK+4o4MTg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720ba5a3-cc38-40da-fd99-08da43b34504
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:06.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzYpbHzMLiXUiFYQHW4kP1I2TisZpJJkJxwggA6u0YdqrzpKIMdikwsLx50F81gRHh+2TF+XsfjQvdeIkzjA+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP hdmi blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
index 563e1d0e327f..1be4ce2a45e8 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
@@ -52,6 +52,15 @@ properties:
       - const: ref_266m
       - const: ref_24m
 
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    items:
+      - const: hrv
+      - const: lcdif-hdmi
+      - const: hdcp
+
 required:
   - compatible
   - reg
-- 
2.25.1

