Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DB534F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbiEZMcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiEZMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:32:37 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C16397;
        Thu, 26 May 2022 05:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au23Re1VI+2nXfBk0TqthgCtRJa629aiRLMr5ClhwrGHLumUu7e/gNoVVPWmIEynFPH8RYptQFe2cqqNPnSCbDIzcVakv0wKE4Gv3WCeReYLsVuB6MEAP6DObnZr8ga/El95lTOEnF5aIBGFRPoRMsKtqUdO/wJKRjRXquvgPggtsVUQvgrU8d8cB1zaZQdoD5Ubrl3dMxhKYuWo5i/fUZp1cakXp2G44YS7suQ4JwueqNpiZXQtYnvqQpLip04e6T94CwO/YTvH92rqSVbyhnTF6FVM41IYFssNBLZ1kRscccnGRpzBMMqknMPFpDdTv/ngEkO5tPCTe2rVh9lCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTsS8MH7zLc3RPgm3EiNIVXLtI5A57tdYjhbYwOgEnk=;
 b=V4r7SgcwNgL8ghpA8bQhA6we/MZIZcEaZjmaNVZolypiLNAXqLtzmnuGBWKlKhxz0QszDirJSQkZdPoB7rKkClcyw9W3rKoQzpzeA08eAaGVOKD6c+2aUO4N167A5o9FVO0xajYhm8g7+pk0Su7RgPa0hAllq2rylevanUw6FDYr8lhm5XiWltJGYr4lNtlEtc9xP5z9ywdRl/iI8BaF5hWnDK0KkJVlDXiuCrzVaghzV18+ZYdyaWPlKaT/h+1PYV+bJ9EywAXMYDWl/LtjMrOwZgap4eWlOxvSkps7J+t+CuZYLir/dTPeczHaCXi01djLRQO+uaeFsg7Tn/p6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTsS8MH7zLc3RPgm3EiNIVXLtI5A57tdYjhbYwOgEnk=;
 b=T1e66SrxntQczzlKWBy5baQ5KbdCA4m0NbiXXDTxuNsZsV8f+ABJ9h+RgRNEWeom+vlg/aMjZOrNRlm9YpIxmwe/pA0aOGhOnU2yxt6RkO/fR8TbutJ4VvdY6LrBzOROTpRi6fjPviJYgd3q62lg+4nMNHIfhPXuSAvVuvZiWOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6515.eurprd04.prod.outlook.com (2603:10a6:208:16f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:32:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:32:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/7] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Thu, 26 May 2022 20:34:04 +0800
Message-Id: <20220526123411.270083-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5afd822-2efe-4b94-721c-08da3f13cd88
X-MS-TrafficTypeDiagnostic: AM0PR04MB6515:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6515D0E228AE3AE70732E048C9D99@AM0PR04MB6515.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SFybxUa67Ct44GMriLBgSkQsRyIz1nzDvtssmVNCI2s37gtQyt4qRebOiJZWsLE9wymM6mp2JGr+ELNxNF2seXwFoWyCFodfcN6y+xocndKRg0yoQ59Aw38NoJ2/SKR6Y32hITQ9r7gnQmRjZZ1iCjFW6/ptyQ4Un6xTGFqSykmekiiLOAeAxO/7cQBscnDnrYpyYzFdRqqVLsChyNVvaDDVv4kPWTKTiWuyVBhvxy/SQGfHyp1gx9JtQEHL6K5MKXZNZ8iMLaREylIwOjJVw5j77Iwn8b/wvVkcX3NdpPljEh0fQYICfomHsmnO+Pu4QXqMet3Etpik3qFG/9A3wLHAyW/MG5DIwIVl+XwmiS5jS1Wjvv1HKw1In8PXDYlSqEIvna1l2w+OVpIdFbQCj/VCrNMRsCeQODiXyAuhz67tuyrTOwurVFRyFnBGIqZ/qgkCZf/6/2QzxT9dSiDKWfErv/OPotb3FhOlflPCcx7CoWLzhHKoAXga5YkSjX/rVTmrsRqVikI23Sgcfoo3txpkc8Qhd7rY1FDZvvwH0BepwdTzHmlDC6uxHCA+AuaMJmc9ojBEVkhkwGSfjbJaP+7OxDX4KeqMLyX9/0IjAKki0NwB8KaK1NY94unzHPtLPIBYgy4FbDREc6jSVyxOX+0kBpgbAhXMBhCdWon57bxMdwcYK4zy2vkGUSZvRwKhmTlrnq96/xz0Fosfx9RqyhkPg46mpu31IXhbATQq8/AI20zi/Bsw4U9bmTyjSK2DC+PrRYYK0ELAk3QWBzpVpsJPmqQ/KT2OS1mk4O7SmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(52116002)(966005)(2616005)(6512007)(86362001)(26005)(38100700002)(38350700002)(6506007)(66946007)(66476007)(66556008)(4326008)(8676002)(6666004)(5660300002)(8936002)(7416002)(508600001)(2906002)(83380400001)(186003)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0bQuhBvV79g1gbXWMyzSFzUGoeFgwbB2xruEAWQzlaU3D9EzTeyzxvvlpQJ?=
 =?us-ascii?Q?5FwvWVf03t7RWYow9ygsHH6XFh6aqufliQxc4isikTVaApIuwNRgvh264f4h?=
 =?us-ascii?Q?y4f9shFJkjK0NWW/swU61Mjp1GzgVGVLcFT6prTjAf3jPaKDCx/h9jSdW8f/?=
 =?us-ascii?Q?3mLg3rduL8S4eC6fy3egHNgAzklFRS7gjHpnijjlH2L8VRVhQtgKbRhQe/J8?=
 =?us-ascii?Q?NVda/uBZOKRwhkwIqlo0bRo1Ib+votODFn85Xpp13KE+YKWyhH6eO5Py17SL?=
 =?us-ascii?Q?lz2F5iQLVjV0PugYpGHJPNSvDBdPU0rg/exrwbJmm2t2Uc6djh3Y497nBZsO?=
 =?us-ascii?Q?gCRDdIrrzs/Sqtf3y77UVhXBVIlzlfyregibtHGMNDzZcGGI5VDn8uECwbGe?=
 =?us-ascii?Q?xKRszVWrhMS6B0igXJjvbSlzOvMFMkFYXH6FvvdukgQwGTnztjJus0l9th64?=
 =?us-ascii?Q?YrkwDfNco1erB2y7KqqJ/jeRiQ+Z2Gy6fyE2qgkF4Dte5lJKAtP84zowe9ao?=
 =?us-ascii?Q?P3yNYPRqO5xEKeuHCQYQ0grjUlb7pr3Lj3tkmx8BejIc1V1DcZMmFBQmUEtn?=
 =?us-ascii?Q?QvaeQaQsFNb6HlCVclIZBkP3ey0MKgzt2g+P4XfgA4GgiT+g9Gv2Kn4oT7u0?=
 =?us-ascii?Q?klRuQUP5ToWCqjOWBVSWnsYR63omPA1oqJEuH/b69VmOdNzbqh2Aj3/oPOUy?=
 =?us-ascii?Q?yXjeHAMWyLT9wkCbohKP61CjeDD+/dAIGVKYPO45l0x/oJA4ENowfGvty/wv?=
 =?us-ascii?Q?mAceb4/VuEOC4Sfve8VAs/ZUBkQGN7LTAH/h3CvqGr1zZIYGYLszR1Ydj6R0?=
 =?us-ascii?Q?ImbUX77K7qovP7uYyfCxEpjdwJx5AjNj7ntWkqawOCTbjdsB05lCje/BZ7+y?=
 =?us-ascii?Q?NiroVpUNyTxOi4Z3vtiTw3rFgUnHQAhPWBi05hgi/SMTCLRq+OZazoIwz8GE?=
 =?us-ascii?Q?k/rZ+QDqb+a8c1Yk3Rksx2XGeQ/IM/Yw4cPbUAUebBGvhgc16erPx0fMMcvE?=
 =?us-ascii?Q?3qFHfwd9/RtfUKae0qWvcOBZYc7u3KDrxBv5LkhhBBc+jq2U0DD5wJj8xdqo?=
 =?us-ascii?Q?5HXLmgokN8a6KHa0a7BT/fPrqYanpq8Iokx1n5KKN8kcBNV/DVu+6DCN7pB3?=
 =?us-ascii?Q?IoospDHg2VaTprS5LVkPDn2nul/Ifc58WRr/YeSS7nlkQPYDdTjyomyRk4GH?=
 =?us-ascii?Q?Oxr0WrqpKLLCW032IXf1cBeXUy84qFNrIWDjpd7ezomzx9OVyRbdxFk39OIi?=
 =?us-ascii?Q?rDyUd9E/51VbXDjrrYJo82sFfxV0vWVPIWDtpeCgaiz417qpnCLLiR4vQlO0?=
 =?us-ascii?Q?pKuw+KPkNyJTkZowa5zQQdnNvlBofQoRoO/Zw4ATLaRoUD4jGY6tZqECS+/d?=
 =?us-ascii?Q?S+QWo04z/hQB2e/4ZMLpKWIFMFjr98T0kfC068k0lL1p4KNP1R4A8luhL9u4?=
 =?us-ascii?Q?CrKGrgfCSDdqONLmi9Gp7ck2a3XjlC2iYaam/Y1zADZnr44ChoFt8+kv5hZF?=
 =?us-ascii?Q?4CyXHsjhtWGW+uiRF1i3uQ1FG9rwBIusLiBYenKVuw7FwrFrOBDEvVnQbn/1?=
 =?us-ascii?Q?PnVHKzeXFjxmxOkeDQ27bu7xQ6gs/7g8BgCER8K4wC0GCkojUzkzJUU94Q3q?=
 =?us-ascii?Q?pD5uLZe+G2dTi8eJSZwmsi5pXLFKIMzyTwXEh6As92Fr7oImTwzbB+Dep7EK?=
 =?us-ascii?Q?VzeUuQEeEiwhvloye10o0DxhUpqX4t3ET8aC7JUG5jMdBvFJbFCJ85zVnF79?=
 =?us-ascii?Q?buKof6k3vw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5afd822-2efe-4b94-721c-08da3f13cd88
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:32:31.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM+Oxs52UFDXosT9KAcpJrSCZKUbIZ4Id2wlDKJgzfttnAOeZpyIHuIbff0fX7NI5DX0u49n7X57v+43KiDFAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
  yaml fix

This patchset is to support i.MX93 SRC and mediamix blk ctrl.
SRC functions as power domain provider as i.MX8M GPC.
mediamix blk ctrl is similar with i.MX8M blk ctrl, but much simplier from
software view.

Export of_clk_bulk_get_all for driver usage.

Add bindings and dts node

Based on:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220510124050.398891-1-peng.fan@oss.nxp.com/


Peng Fan (7):
  dt-bindings: soc: add i.MX93 SRC
  dt-bindings: soc: add i.MX93 mediamix blk ctrl
  clk: export of_clk_bulk_get_all
  soc: imx: add i.MX93 SRC power domain driver
  soc: imx: add i.MX93 media blk ctrl driver
  arm64: dts: imx93: add src node
  arm64: dts: imx93: add mediamix blk ctrl node

 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |  80 +++++
 .../bindings/soc/imx/fsl,imx93-src.yaml       |  96 +++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  38 ++
 drivers/clk/clk-bulk.c                        |   3 +-
 drivers/soc/imx/Kconfig                       |  10 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/imx93-blk-ctrl.c              | 333 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 271 ++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   |  17 +
 include/linux/clk.h                           |   2 +
 10 files changed, 850 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

-- 
2.25.1

