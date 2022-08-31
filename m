Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A175A77FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiHaHr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiHaHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:47:53 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10060.outbound.protection.outlook.com [40.107.1.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B139073925;
        Wed, 31 Aug 2022 00:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAar+bQyeysuze8bYDCqgGLvW7YKBEqmRGUwmMob1aTTrrhPnp/iBdQJXlrI/7k+60BzKAL6XitubzSi0Azcp2iZBHgz/hRy8a/QpMxC+ZMRttr61G1g8ePCWonEAlS26tBhH73/32fpRarm+8JConCrm3I3Dpij/hoanrPedN70nTIkvOQxFe2ZDmfesh68qgwA+Jrca71djLT3R8TviAApn+njnOQnSoALkY3K7OWUv4mrnC8SRnZhl/EjVmS+0FH33M0L10Bvq9cgI1B9kUShZabTQSBr8qEfsyDcX09y/T2nA5XOPQ5987tffrz1Tal+lepPXaww4qgzg5Bx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQPnm0cRjIP/SAAvxtZ58eU8MNiC1vLfhVz+f6Vq894=;
 b=NLIjvKwQxBs1mn9lxkImTt6Ln6IDW4JXUuwCkCdVPjGkxlkJrrV9UeSEzXJInBWEtdPrlX53KoYtfXryvcIAvElX0+N1m03WfQAryRW+sxoHzvg8cRua3qY1n/OJUJ+SAg+a72sA6LjEnsxCyfBOboywcx34d+asI0hCD8MCIXiVXv2qFLAt0z/ZhCXEGo6MR5w30axKgsrQv+e1aP8Dwd6nekqHke77AX9vfbYW3eUCZnDwbLtPyAm2WI8QJH4ro3cdrfcshUkYSjgyZh5QWKTW8po9M4wni1GUDuz2p7yZ8PYkl4aKQ0wn/aDa69GBdm+c3OK/e6n6yiD7lUqI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQPnm0cRjIP/SAAvxtZ58eU8MNiC1vLfhVz+f6Vq894=;
 b=e+Gqg8NKCXerq6EyJXe27FcnT/E5cJHpH+1lN+RKD+xJpL0BbVKytvoryaa2D/eJVFK3wqPBTBez5TGENsHmmEvujVnsuATgc5gRWbV0hldfaeS4+rZHsqQc6ocdLe6hwfpl76qiHR+BLg92hGPsJRB1LLs897gsJoAdB2qW5pE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8001.eurprd04.prod.outlook.com (2603:10a6:20b:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:47:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:47:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/8] arm64: dts: imx93: add several nodes
Date:   Wed, 31 Aug 2022 15:49:15 +0800
Message-Id: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4b25a47-6a49-4b69-9d5c-08da8b251944
X-MS-TrafficTypeDiagnostic: AM8PR04MB8001:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3NX4sfqGBABLxpnFU3JYsScB0hX2tAJW4nMDd3xuiA4TX5vHT4EO9jfbFbsa7gXFhp9v7P8oWDGjaCnMkfHeoUDym0bbzKrp5wxM/dKmXTgii8/p7VLDQ3g79mP5gsqjpV0yS0a8v9cPlvwzxackdUZl8sFivjfbZWhamuu1AaJrY5sHQPWuGfvKD6CetKWgu/SgMs3CGTAkUwQ/SL5oYQuTGP046baZXxD5D2CQa5ueyi0fmk21X8AmlbsBK4k1dj3xyJpmMb4Tehh1hX0orMheDcD0Qg6hGj1+ALHNjcEICz9zMzIKJ9hKcQvUbI3kd0e/D8KCyCCtIx76v3+vhTICZe7X3sd1UmpLi9U/UGS9VBNQ5qM98b7BgcXs0e6kX9F9yUlYvpCMh0+Z5HSXD1JZMFOcxnqwQ1hePIu2IrD8mDsKq4LFUj8fwozNiqqGQ+G1yHYwyRKh+9T4l7Kwhf3NDWYHWjN+myQwRBI6oOtb0GhN6hbTCGo5KtKHpJKqUDr9ee8u2kRSgm/R0EzpdoZzCxvHP6dbQCHBb8SYelxxE2YBodwZzXdIFy0wQVicY+8XUXXbZVNi/SCQyjWSmLRYuXFhEOjmBclkoBAyHmfgeImGTP9T9rDjinWHG/X7MoV4B4DNMXUODoGf60GbsybdF9vjovR6ghJ1cXvv+0wXyCQWyUm1nsZtpkSiwuEyocl9Zbh3EcGZ74andMFVdxWJEcZkbmy2m33sU7aFF73biy/dRDDO9rO6q+gEhHwGI5sOrt17K81r+wUdeDWlyDyfQKAFNxwOsvlSe97S/s90MA2mGpi/4cNMJXGIkzprhkVyeZom8SWy4tANHf/Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(83380400001)(2616005)(186003)(1076003)(6512007)(26005)(38100700002)(38350700002)(2906002)(52116002)(6506007)(316002)(6666004)(8936002)(5660300002)(66556008)(6486002)(4326008)(966005)(66476007)(8676002)(86362001)(41300700001)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdCbCn91dy5ZrJ3ymZpd9URtTgQo6gT8Xiao3r2pEGoAwyl148hfJynFBQp7?=
 =?us-ascii?Q?9DZFTV9pj4as47zR5oPwQcCmUZf3jHmZaIIi/HZX8DfOGTmxGnAMtEvX7AdN?=
 =?us-ascii?Q?ZXqMQHKqwljhTzMlZ3fYrai1lAq9KzgPnv5ne2XOmvBuwiXVrz/oVChbhL09?=
 =?us-ascii?Q?bCdPXbR2j6kIz4ZaA4EwnfirIp6D2mqWgTkIK47SjU1qpF8nLDFohD0I/o75?=
 =?us-ascii?Q?DjxWG2sQIHGJIfy6R4LK0VboB0cPXEckl94B76xrk0HHcGEy/tnNQDlvG3xY?=
 =?us-ascii?Q?yrA+SKhhhVspTISoh1IlhUBPWOhUSRazoxEYh/0A818C2ewcpgyXdrpJ/sLE?=
 =?us-ascii?Q?YnwrJKm6q5XXdqCEuHu9Tug8/4Vc05Z5gbQ1sCv89dLOgkVXmOkZzaEhp7Uc?=
 =?us-ascii?Q?LmWS27QQhrxgCR/1XNhRRf05/urc8GihR+J9Zt1VBjbHh7narjooRUZr0get?=
 =?us-ascii?Q?+75HNR3yjGVSvTfUKpCbYf05nilJ2fMaNHWVNDV71WYScQQ3TDDDXwesVs+s?=
 =?us-ascii?Q?Pm+IK030hmx9kyt6UIc2M82BYqD/+8MMlX11hghcwvgN+U9+A/TJf5SwUbQ0?=
 =?us-ascii?Q?vhRqqlOODe3w/fZgriKaRPyhnbsAL2O2maYdqMN5VGtrYgZk7VLMtJ/Yx1ql?=
 =?us-ascii?Q?lpN4HOgpM9A8RhroKf/LBJkwZXFgcIRzk0Ep/gbvt+RcMQcepN1gWUwcO+Kl?=
 =?us-ascii?Q?fxj3xMYTzdfdq9TnRlzGriokbUxWmsOxHkGcDY9CMwBVFPUFSGXncYctOVzp?=
 =?us-ascii?Q?mSTfw7CneqOE4jKmiP+DKePkOka0eU0uFkhQquENUV/hIw42PH36RoUPif+X?=
 =?us-ascii?Q?h7DAmw4dBUBQsWIFk+6aTaX4KeEzSYTSZZq1gg83m+ZK8VsTcT1JMihk4aJh?=
 =?us-ascii?Q?9Yk7V1ql6n35sHgIU0ZFNFqKv9+5Hrpbzb14ApPb3iT1wEB+EymqvkYcSEqG?=
 =?us-ascii?Q?0p8SLVJm5fuebm4nGgclVu/I75BtBDx4UTezj2mN+Qr1GgVg9WdFjhs+NRxF?=
 =?us-ascii?Q?LKa5hfkad4imbiXXM7pBlwwzsclXtJ4/fHTuH+N2D6WAmifCeXPTSEYT584r?=
 =?us-ascii?Q?y9LZLSltDXvx6YII0il29uenTP4571z95vNLbU/lkdqlNUg+VwCpIj+wgr0D?=
 =?us-ascii?Q?krGgjY5dPxAPVcQoCLQb4PgRGI/RDj8p58TZMflEJRQLfue1ewcWAMwT1HBp?=
 =?us-ascii?Q?TG1NNuUe5UJRite3yUEKc+S8tO2l5149IuZUYliJr+d4rENmT6sFN8mnTQbW?=
 =?us-ascii?Q?opoWC/7fwQ3VV3GZVpbE5d3X7MeylhLARxHsNvEianD5EwNGmqgrpJJKOV2o?=
 =?us-ascii?Q?xdIKcFUZPtNDobF9+lMVbu8fI4Mypu1+PedHV5UEsCczmgK0Fh27S3bozymu?=
 =?us-ascii?Q?zh5l0qaTFtUYondYt/m8oPT/3m9URHVk3mrOiqnNM5FsmYEcyuAk7Bzw2s8B?=
 =?us-ascii?Q?wav6mPDDcNPXPl34Pf4OBb3LZ5tH6ojX8Anuz9N0ru7ZG4G8CjePxFh7wJSj?=
 =?us-ascii?Q?p6MIBWkg8fdEZL0plBELY7jH/EYnL522d/tqu8rN8S1HCKtxpucaY2e7dt87?=
 =?us-ascii?Q?H+09uFLCF1OWF1YYDmWht4qvfewoEp6b0rSe6U2c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b25a47-6a49-4b69-9d5c-08da8b251944
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:47:48.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoiKx1FtuihHYsieUuuAqVK9p/uVNVzsM6pg0XwWANGsKFpPIa96n0ryfZdsjHFSlIeGP3nC5u4JUF+uK+/Y5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8001
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
 Add binding doc for aonmix/wakeupmix blk ctrl
 Update compatible in patch 5 according to binding doc
 The lpi2c binding doc has been accepted:
   https://lore.kernel.org/all/Yw3hfcQ2JV248GIo@shikoro/

V1:
Add S4MU, BLK CTRL, PMU, LPI2C, LPSPI nodes.
Add GPIO clk entry.
Correct SDHC clk entry
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220812074609.53131-1-peng.fan@oss.nxp.com/

Peng Fan (8):
  dt-bindings: soc: imx: add binding for i.MX9 syscon
  arm64: dts: imx93: correct SDHC clk entry
  arm64: dts: imx93: add gpio clk
  arm64: dts: imx93: add s4 mu node
  arm64: dts: imx93: add blk ctrl node
  arm64: dts: imx93: add a55 pmu
  arm64: dts: imx93: add lpi2c nodes
  arm64: dts: imx93: add lpspi nodes

 .../bindings/soc/imx/fsl,imx9-syscon.yaml     |  37 ++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 162 +++++++++++++++++-
 2 files changed, 193 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml

-- 
2.37.1

