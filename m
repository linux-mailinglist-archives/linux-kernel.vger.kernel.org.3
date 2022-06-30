Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1756261E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiF3Wcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiF3Wce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:32:34 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993157232;
        Thu, 30 Jun 2022 15:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/vFADvXRLvrNZEP9dgGouOaQYpcxmsZMZJOOD7h6ZQqhMq+VZUsFnlWbeD3wnqA7r3IzQ6HlIjaOAwpQ2PEbjtJuuv/33QbixyKYhDTK9cpfMfiquReJoAmlE7c31/TLNAZbq5pWD+ax3DoTcvjp50AkeWunq+20Ob8MuBnMPMvWu9VUH7m5IKgq5jyE3Uk/iMf440tMHeKYJNEKPgoisQOPkeBDRsShcPrNssw1SNpkX+UGO0AMXp5kwNeRgpzx6Br91nxUocgoGrp5Lxlken22LTXHO4GnO/gfdC+A/TEhYbfS4bU3aVb5ayqtsGsZiA4j+wLE9Am65qGNgGGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAHJZKlp/9XBDZ+81D/puY9xJm4XOK40nHHVEOOUwhM=;
 b=JOPSNSLDup38GwELGgY36rfWKGMTfwKuHHFkizXrI2BmNWlAlQ3gnCHyHitpr7WUa4Fl3JtJu+6cKVWrCg+mWWmEfnOtAfbMAKenW2gVN1ywYhJRocS/Q5DorhpEIx+lVV2upbuFBQqH9fDTuaKTFTrw60+y8LxEDoWh4vaq5Scwr2gRu+1c2ITK9zlcOqGT79CG6hMODl5gHCyms4eaP6qYedAhlweSEBC5WdnOmmhmmS1R5X2dykg1vS36VyvD97pU7HDjStcbiaKZBXhLxIfKtnVFtQ2X3W2jKXpN6WtcUU8BHLmqEcqpHqZ+GJINejqk3pD3xxdv7BLrT4FOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAHJZKlp/9XBDZ+81D/puY9xJm4XOK40nHHVEOOUwhM=;
 b=DNJm5lPAD+TTYzkASKS7dYPmEZjI5x+EjqPQaTmnCvNWp4/dEWUn2gDLWOcxRC5+qU87OdqfDqSf3HuqxEh8SHk8gbHqdjvq52MOPmnJ1wjJEQiupNNYojHQoHDejzDhuunrq0ecaQb9n1qsNXOjSBs5F9ZeaESlebkAPVFHyk3Mb5Y7GabZ174nAqBHL5ZzGmcjH1+fOSP+2S7lKtcjEvXTv1+7bqPaCTlqq5i5tw4/6fgV2J9KgMtaM7n9vItW+vXXxeV+5sP3RJjDs4cAiegqg68T9qrSfs6svALEJWnpAZpl4bn6uWifl2mI9cfyAfMM2bPRnrSQjcmQE1Mr4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB8PR03MB5884.eurprd03.prod.outlook.com (2603:10a6:10:e3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 22:32:31 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 22:32:31 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4 3/4] ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
Date:   Thu, 30 Jun 2022 18:32:06 -0400
Message-Id: <20220630223207.1687329-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220630223207.1687329-1-sean.anderson@seco.com>
References: <20220630223207.1687329-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3240e647-62ae-4aff-4974-08da5ae86be3
X-MS-TrafficTypeDiagnostic: DB8PR03MB5884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUiLGzaxEusFIjfPYb2tZ7scK9tfO1Di0vg+8Brqp3sBSuydkTMVYvk3npxTwOIRZ+sjCCCQuDZRFDA55p8l6WpRO9OyKqLZtZXP+k/JY3DRZI/4jeJP6riWV5Jnz+5RMxlzTZPcDFI4/qVU3maoFoBn4CUjndYQzSsZbdGBQ7c2GtFdZqRPthgVdvV4tFwY/p2lfGIh+Da9ZUkb3qMNi/0kDBkje+RGDbaW6ueQ4zXYe7RGjO6yP8Lj/qqHt6V0h+Ed9YSb0agTTnDvPmDovmOk/fSr4Dk6KOZ52XzTjm2n1YuxrTn15CBpk4cBuPn/K9h0jxV5llurnM3vllVzFPxy8eZhI4yXAKDrztuTnPGS7hW3ggzpmsJ2AS34jdlbzSCpk8wSmUTv2IRT6o0anWo6FzoE9PgNMvkF2UVVz0hcxDCZj2L3s2whryMx5kGpUalqpboZHO0o9CuOiq2HgEAPUaD27O9/64yG11V0mNNqn0gLhT3NSUrmXTPZjn2iB/nRS2257e3Rj91YCk95EYITYUMXlaL7GoZdmBPYOzU4LTwZ1kjn3lk2V8Ko/H634Hq/Po8sUfljDRWeMsixGAxd0LwfM4+Q3GulyRKraMPvYvkuX7qHrbPZJMfkv37MdyjlkDtk1VlMTuUT9GzfTvmF+6gpD7KnsdaJ2hcfqODpexhjy0P/5rCQqKpYGJyaaMtqY1bi78oGPxsUYRpEEcTmMw8gZtOqrll54tnUnzYN8Rkrym0bAD9Lavk86YR8KedqiVC9Vfjsp9YiiQRMxN0gd4Y1npHBVUe+6pNMKneeLW3RDyfMmFJHGzVAEuJR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(366004)(376002)(396003)(346002)(107886003)(38100700002)(66476007)(52116002)(316002)(86362001)(1076003)(8676002)(6666004)(4326008)(6506007)(26005)(5660300002)(6486002)(38350700002)(66556008)(44832011)(478600001)(4744005)(66946007)(2616005)(2906002)(41300700001)(36756003)(54906003)(8936002)(186003)(83380400001)(6512007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsrX0EFd3cStsonYbp57wzPrx5ckfvOrszpnqkymDuTlROvpIuXUMLAJ+LKY?=
 =?us-ascii?Q?+r0pdPFK8y+JqrS/ig0EMTqeCl5KLMEGymtF4GzPv+agFfYjwQUeCDYZ7sfd?=
 =?us-ascii?Q?OQk2D3JuArVi6ygL8bTrE2FBrXCuJIdEy69Xsw8x3hzq2hynj1xP8Y8g+RJY?=
 =?us-ascii?Q?5fcXvCtdBoP5J5MCjKBeliAeV1CngaNNqsPQin+ECVC0LBKOSJP57zCPjmFB?=
 =?us-ascii?Q?7ctiRGXMYRZcq+82XNvGIlu5Rkkc6q8Q6D0uXnxJCtPXMPcP4BGaXKl13sTk?=
 =?us-ascii?Q?LGjn0KtlkBt9n/lc5N2HLi79L8Zue7QlJSelFEazuNHVGxi2IKDD2h8ELtUm?=
 =?us-ascii?Q?j/9PZnte1QT4TC8/gHzoV5AOa1uJIYQoEMLBbz9S/hs4+BZIo4ydRsaVKVfo?=
 =?us-ascii?Q?TwfOgeSUz8YAYkanBXe+R+Q0ZFXr/nB13TPpDe9w0Cr0DLFLGF/RVioagJuC?=
 =?us-ascii?Q?1SgZ/BDd/EXzpYV2aLYjdysab/MQIiBwrzoO1flhZiGsKTKpRpw4Am7S36NA?=
 =?us-ascii?Q?ew10MKolr4V5apXIIUXgiHPdI1gvcpJFxKFIWb0PZwQ1tV0JoCj+zrOl/6fU?=
 =?us-ascii?Q?/v3NsT3sdC8jaN6+lludKOxQvDh5l/5ARp9wKQm/kb2qBC0EgT6MpVrAKtYZ?=
 =?us-ascii?Q?2tRZWFKthdJzqavIAkIWYiuQttXIg8pKR/h6gcXqu905CjtjLRF0VQTKo9gW?=
 =?us-ascii?Q?25HzPgIHU0mYPZyMX1Gu27P2SxUWqq/8uVmGsgpE1B8wJpUrGRomxekaK9Ny?=
 =?us-ascii?Q?CRnhBKevl1AD/9bIy6L2z3vyRD733zqJyIbC8wZmWryiSElYOWhw2nq3LZvD?=
 =?us-ascii?Q?m6W0fOxgtQ2V/WPgnVcFSb1B0R36o5iAzVFKlgt5hlRTfwR9wjTHJYVEeheo?=
 =?us-ascii?Q?/PVvTNm29Cyzt5tdEMOO7ZebmYVel+yKV1qjkiyGJk0j1UliCUXY4uk2ZPxn?=
 =?us-ascii?Q?TgtEvEVQ9G6JsDqjge3x2gPdvHQg4hFzteUp2aZgJRnX+5pUBrnPBJNIJH9v?=
 =?us-ascii?Q?iYiIuxSbQtybnJSJ7Vme/dmqXaJzd7EJgFvxZwC5UlnC0i2QW+8IgVdMssAz?=
 =?us-ascii?Q?PEU9zo96yhwxwcDaGdxa9xGCwmwpaWuW/AXXy46/mBxWVNAhCYscERubLrSJ?=
 =?us-ascii?Q?RGBRGNsUS04wCPfmJjlIx76m0pn2hKWVAHwQo2OZdV6g1F5cWtrmPZ7TD9lw?=
 =?us-ascii?Q?U+IMqhm6tj4ic/BEhURbZfd0sP9DafPhm4m562uxhCXdE9F/Rwzam3Iv0+Ef?=
 =?us-ascii?Q?YtvYPDAsqVIDhu5gHyidL6FXSaaQ22voGKUJtqzvnzXR9aSpxOxKnMNRZRPW?=
 =?us-ascii?Q?uBZK+DaU5ysvOU6qcjJ1SzBuchG2Gv5I8F8a9ftMXFU0nUQPNTlWjHy9iaEu?=
 =?us-ascii?Q?s/0cv3Km2GpbW5LbHWGwnPcHMseOel9T6Nsx1hONxEid5t4vZHa20EgALhby?=
 =?us-ascii?Q?N3AyQn2grDEHig858e7RtrDgthV/PwAt4VghfLP8/Z5wuYHx/yWmq8/xCmwT?=
 =?us-ascii?Q?v8miw+mxIoMwRGFvVaj/xh9prO6my4Z6awT4PDRRV2cTvsWSd9wNNrkEA9Ht?=
 =?us-ascii?Q?vtqjP29JIZFvI0eVzE54KiUC4dsXAnu1twMLkYmonyh0udZXENvqp2yOLGJV?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3240e647-62ae-4aff-4974-08da5ae86be3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:32:31.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt7d62CDFFpsK9lVWCuhOnUmrLRJF8/W8q/6FeiUMAbk5J8KFD78rj3o8Gbbo4/PvWIIRVLhBGgirIT/lyjPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an appropriate SFP binding for Trust Architecture 2.1 devices.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v4:
- New

 arch/arm/boot/dts/ls1021a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 6c88be2a7e8e..fa761620f073 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -129,6 +129,13 @@ ifc: memory-controller@1530000 {
 			status = "disabled";
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen 4 3>;
+			clock-names = "sfp";
+		};
+
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1021a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x1000>;
-- 
2.35.1.1320.gc452695387.dirty

