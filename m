Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C561572E45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiGMGgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiGMGfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC40D64D1;
        Tue, 12 Jul 2022 23:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8a38Dy5sPT+YARZ+joHt4Hy0glmbR/PxTPCaKu/6+cxUdcezlwMB3DsVeZGFXWijye4EyvRPjQNB6/HeLNxpivu+0odzkshlL7AR8DpyiFWhvLXE9XZV3oae71QJX3T8ufwglR1bdhBq9R1yyIFD2G+VPbuoxfx9ne8QgyE9OaMjACeuwaio5S5jmVgihuyQ/jjl7TEUsH9STHF6YSZzXAehDQIk4hy/3wuZN5WEqblB6b195RaSVLZs8fdjQ0DpdhcXaToirO8oUwuH94ehbWM0lwhtiJ0BREHGkrjAbGl/l70P18IfLcw3zNxC+ZCt1gDWcgjT4Rx5F3X3vGbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AorRxksbXeVxubLoSc+lsLswoLaLtAUA5dm1bM1U1k=;
 b=luNijI34Ot1L2yOOU9UqquaKnASDbUuhcqtOuIm7DXpSUZ07rDjcQ2v7vxne1XdJlN6Y1CZketmd6YHFuBfNHZJNs6ohusqrGn6u3MKR0kNak2y6rtF7+4qd/tHEG3vxErhafiKNmZtpnUqHpfE4SU8GV+dkEzuK82gLA2XUTzbTmKsRFmhz9hMxuC1s6vP0eKK/vVP+ChFjlpZ/C1YxHINgljzctleYmpr0Lr2qaQGCX/fPHt/ItRxAjaqyEvM4qNK+hkbMcD1eZjL0rvPycgSdYhsvfkD0fFUwoDQnAOJPKjxp5GV20FZismzjb9QXQPC9yBMjTiZcF4xP9u5KcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AorRxksbXeVxubLoSc+lsLswoLaLtAUA5dm1bM1U1k=;
 b=lgj/0nl5/K9bT3Jhw6DArea3KjBYGTtMereAZnOGGyOpSxMxjlxL50KcFBumA3WFzP1+1krL3ofqFKMjBhnX2DAx9VQDlEh+svFPJ+8AX6sJZFWk2ue2X4+lXi8FwCLnPSBsVfsbUVufeC1Ocbi5krmlafdrhYCyNqXW+T8Y2Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6026.eurprd04.prod.outlook.com (2603:10a6:10:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:35:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:35:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/6] arm64: dts: imx8mp: add vpu pgc nodes
Date:   Wed, 13 Jul 2022 14:36:52 +0800
Message-Id: <20220713063653.2584488-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6534d065-0fa6-4cf4-3496-08da6499e9fb
X-MS-TrafficTypeDiagnostic: DBBPR04MB6026:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DppdGnpaq5N+gkx9NMBrgf7mzvp2M6eDr69XdjTq7pqxCd4SCrxubHuuIkx266UZAp9+8Lxo9/TzZH5X3SbNLkKmzck3Do3pcZFRuOp9fDtomuziqkocMsOlI4HcPHehVdX7yuGO1WZX217J9xogK2fQZkOuh0oRUcAkob8A6IOd9ewAKDVq0KaxKrWYokmv5PW0yv7hBsYr20dP1+Mr1ZKouS93sF/U3VQmTH1WMwPS8Sv3FnYEG/ryftIfkvZMewxD59eVd7iG3pwqX+vYEm5MuOLt016+Sp7gXnlODxol5kN9a5CCIK9u8zCb/dZV8isNMMP0pdaMYCxGJLK/XzaIDWORQY+LFDpUNXJ2Dl1VHTxDFic/7HF021a4CPxvyu8cU0hst2PupfM3fTpgbRKM3JJoBrOPXwys9WN3cPCTIR71VI6Oiwv0Gy20qI/1Ybc8JdghIzt80j5IbgtCviybI4/rp1JQuV/kVH0bdEmX78Kw0JAPUpt6YPPYhFthAJZmtgesV+e2IPWWXZWibSe7/7vAV1bfrcVaq4QzQvUzhp/Jv4sZZPHbt0cze1MJWb1PxX6QqYhUJ9dz4yU41Va7fcp/lRfkMFpd8uJ4ZsPTdEH6neUsm1ocHcrxx2+giEWC0f4isxtFGwKDLmdGxs0tiNDH2r5zWWH72LhFMwsdqcu6hWwUjJuWRCeHpEIZJ6YUsmb5GXd7JzoB3z7itPAT6v1gdRXmCKuqw5e3nxgJ/6m9vBN6Ki+Zhk+QNy/ROKDZVv+CvBPIsRdbCE4WZ7jQ5SMGR9duVa7A0k3tFY+6BOeXwxORV06cSsZ8AhiltjuBdgIqgXqvXF5jU8JhGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(6486002)(2906002)(83380400001)(186003)(6506007)(1076003)(41300700001)(38350700002)(4326008)(8936002)(86362001)(52116002)(8676002)(66476007)(66556008)(26005)(6512007)(66946007)(316002)(478600001)(5660300002)(7416002)(2616005)(6666004)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eLp9VW4zE7BaBhpZHV0my2PibeKlueXREz6bjxP5eFFKRxT7tOD0pJWPK5Ie?=
 =?us-ascii?Q?Zn7M9GuIrWopzyLBAy5dQLjwWLojxDmcvQXub+037NoRCyOI6dPFE6fpnqOJ?=
 =?us-ascii?Q?WZfXWqW6q6qWDapmbG06dZCPkMZDZU8ku6PRji7nv7BwOqojPHXsx5dAdgIL?=
 =?us-ascii?Q?2XhKQIknl174CWwCsmPnyDYvU7QWw5rsZnmvdY0alA7hR04vLPcu+RHdOSxx?=
 =?us-ascii?Q?EXMwHxDXoGBsZVuFpU4CweiZXkp7NN0xN1tr2w6azQfof9bEOPPuOzzIuYhu?=
 =?us-ascii?Q?g68h7nr9p9BrC5QNokUZhqotng5BdKV7dFiD69aXGLMEkI5LSHRvJLSyfOKD?=
 =?us-ascii?Q?s3J3iC/P9nvUsC7eIcFzQyn5XAoC35pYQ6SRJlQKBj+6zTzbCvtX0yZvWD6+?=
 =?us-ascii?Q?9dklA1mkARbNrQcr5iTiUA8u11fr8jDthaRpsc7SNx6zYEGKSZ6AqIplaI5S?=
 =?us-ascii?Q?rUortuS/w2F5vyu2MwvqUMUFGFgH8jEZ30gDTUFc7DzulJAeGcvRBFJt/RxD?=
 =?us-ascii?Q?fkdwpkjWxkvKU/YJCmUpvAPD93cN52vavtTeYrYntZSs+VcVgo7m0b5+bFNu?=
 =?us-ascii?Q?X77LZXXPgijqQMQWc+ZFSxwlQKw1mAD+tGeTGADC21S2mNTtGczZkYJLpMKD?=
 =?us-ascii?Q?G+7PFosmVwxtZrhVArgUvZlu2In3SDtNRcjEBOyhi8T/W8578rqoJrjIA/ia?=
 =?us-ascii?Q?Xz2nqBBijlA/weEt9oxSg29lORFq8R3xhmjoFs2CF34Puk9dvhC4Rgkj1RRg?=
 =?us-ascii?Q?q66uELundzk9MPF06+whIB6sCwkrBeXr0CPGOHKV0Y/OwJRpoMTYi6Ddx/MF?=
 =?us-ascii?Q?00K5EG37q4QvJaEHDH2msRPtZ+MycUyMN8xKk6/tUvnGYtx1B56Tf8Q5T2fL?=
 =?us-ascii?Q?EUkfbimqn95y/QafRqs7ocgif+2comHx1ZMwkkaBu9eF53qSGkM5xRHEQ+VS?=
 =?us-ascii?Q?Rcnmug1QW9CNWRG07ItYLzFgyVrOKOm7PZiBeNwQoLUOC17qOQ81MNazXr98?=
 =?us-ascii?Q?RvVFspjK3bW1SaVnstSabzYmLlKnJV01jBhCBTqX6sW5gqCn3NRkSmtfYZ4T?=
 =?us-ascii?Q?02BdQ3LaXSQnid4yh2rlWAPal23Ybic/N9OO9YHN8zNcBHWvTiOZdECxdfMK?=
 =?us-ascii?Q?grPaiJWBtRZ5Rsd2cG4LqTeVCTsEvYV/X7C0+oj1d/zuyWqjN1i1UpijXAR4?=
 =?us-ascii?Q?mrd26cimk5n8eOi/MqyGAvp9kWjkeh2WRQEq3Irg9o2uIb4joHDgmqy13F6l?=
 =?us-ascii?Q?klNmVg/CyjxFfbOBiAQnaxyH6K8pST98sUBikjgdaeP+bR32I+zxK0/eXUmg?=
 =?us-ascii?Q?g5dOTSkaJc2dBRGdfIl15VuBHpa2eP8a2BFoPic7AhjDsiSZiTFnAAt0inMf?=
 =?us-ascii?Q?O/JHKCvmIeAcmEVOxLgY6KjJrMISfuQKpDdapVz5Z4ukODrmhrryTFDWWKH2?=
 =?us-ascii?Q?ZEWEgBASnmHSVcLCDuFM0gAwy4mlYby3MywfeRN+lxTLni8AAfaHoc3waXUG?=
 =?us-ascii?Q?6TBDL7vHdvtAiW9C8RjkZMNvlkQk50nWiUJMWoQCWQ/ZxTAzTHeMd9wBZyNO?=
 =?us-ascii?Q?9Bo/U0m/nHxRU0rXErde7F9ymvbL05CZo9zu+1WV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6534d065-0fa6-4cf4-3496-08da6499e9fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:35:44.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjFCbUjPDjMsYmhm1I9qnCYPN5AfJXJSMH/ns5MWQpjch1j2lBNk8Xx/0ej7ir195EAKSbhcbJUZGd+kkTV0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP PGC nodes for vpu, which are used to supply power for VPU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0b165f98a82c..34af983b0210 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -598,6 +598,33 @@ pgc_ispdwp: power-domain@18 {
 						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
 						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
 					};
+
+					pgc_vpumix: power-domain@19 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
+						clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
+					};
+
+					pgc_vpu_g1: power-domain@20 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
+						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
+					};
+
+					pgc_vpu_g2: power-domain@21 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
+						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+					};
+
+					pgc_vpu_vc8000e: power-domain@22 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
+						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.25.1

