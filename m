Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D34FB557
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbiDKHwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245702AbiDKHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:52:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C720D3DA59;
        Mon, 11 Apr 2022 00:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4xfvQf3T7SfJ54xVh/qmz5Un2/lDVtS6u1ygH4aPcPdRoeTzn2iKMsOWibk+rv0nm0/LPQzbPjzUyrDCdUjGXbXuTG7LLRJqPTSiNaIWDGUJqliJJpGxSuLnMxQbGcRbJ1YfLj+dgXvPHJwn3cWa5eaD2ZqEh4nhFEd0RyjGUVqzRaxRvC0kJY7uKHUiu5jPHWaqKerTtCXXE9YG/Wy25jtD6FOIqcgb/rfP5QnCVidGL2s+2kR5tdFZez/J6XG4yxb21voErY0GTKD4mOvApDIv0uqWCvqnRwy5TrJHeEOSw4bErhUR2JIIC466rgEk2ybNZc6A3z0kN1uMHQdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYihFvriXn4Aqrq0a1TtveZmhwwpqmMojHU3S5fl1TA=;
 b=akQP0MJubVqheFuAUlgtFOoYwPBQr3BIKtb1rwscmRQwHP/WJpBhgt5sGceOddijBWO7QpckstWf23D93a1Yl8IgOQLfs8v9HsA3QYCfqayLtHmIn+CZBpP5NWWfWkTMpfB40WK5ztuvnMy5WNUMrmMEv3/3wC4qKXampilAWoHBTh2Eg4kROUWgmqPp0cPUVqDr6YshpSM1gR7SlP7OkZVtxKrNIxVFhVC9Kvxe8iPGWCBIBsqtbXeHBgZm3DFv2E8sNRIyeMsdtF12Dnh9pFUgVQH2i/CELMww/r4EsNBtzJ5TrjlCiabvPy6M2GIVCB4HDQnRB99VSxZqnPWxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYihFvriXn4Aqrq0a1TtveZmhwwpqmMojHU3S5fl1TA=;
 b=rOke4sdtuBcNy0uDvJEUKxtg07T0AWCL669J7bReQ2RIjuzx33pYsJCUzEy7weJmTKyFtlYYjJXj/OG+8JeTNhAwsawjM0C8128leK1g/Sk8xtIVGfMD9YUj4LgQnSOt0fUO6QN5aUvPMOlGFa0EG4nO9W4LcDc3XYIuJtgcLGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB3156.eurprd04.prod.outlook.com (2603:10a6:206:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Mon, 11 Apr
 2022 07:49:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 07:49:48 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: media: amphion: use hyphen in node name of vpu core
Date:   Mon, 11 Apr 2022 15:48:55 +0800
Message-Id: <20220411074855.25114-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b94e4b3-4095-4e02-2bc7-08da1b8fda2c
X-MS-TrafficTypeDiagnostic: AM5PR04MB3156:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB31563ADABF3E777AD2FBFE45E7EA9@AM5PR04MB3156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3vxzz1yf/YYxLRiMHkCHzv6Yp9pnmr4nGLdUDLbVx8vzy2rC6OxBCa4k+egUZ0MTBqNKc7yW5Hc46XX5iesEGTNNWDdNeyUZvDYzcE3zfZZndvTpsh/ivDqhCqWjGO3AKDVvIQzoAWLsTeByrvQzN7G4BZxMcNfjcH2y04h0VFF1079zm8O0/GAUP/OcpBPIbk87XyWmRmoV+rPgzovpKH0AHfE9GIwGSGvZRuF0mmUgR65mve9y2WExeQMJxgw3NBpagKTM6HbwucD5dTZOvfsOtOxQ9JgS9j9DZjKFfl9N3w5GJ+Y21ZDIJbaUSMFqpapXv7e8jm+9+xVflHaTAo/QhM1tmINoZCHIWQRvhxyj2M0FMOvJpRWO/IN+Zs/SHZAeZ9JvNb0GXtq07DxAPXCfAY9rBx8WyQTSTUEYSYSXUjEgzSlC0AYyXJITFd+lqxJmhD4YME3aEvx/3wSZdcm3eH40Igs5Xq6qe1BrktwVoVTRZQZ1QrC5ECXhktDh+Nx7/DNajLCY/S/QuvgVFxw1BdONd0q1hZellWnX/s+owOwPigWFLaorEwxqr5j1B2oeGdINFJtYs3VqHua3V0DuACO7pyxHYk4eviUcKEcDk1p2lR2BWxZuUf4AAs7/kPNT4XneiqvtqLPyC+MHnThg/EMWAYbXRy++LnCabirC/kVmUEpESpZnR7pArj3rYLG42kyv7/K+bJxUqjC1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(8936002)(44832011)(83380400001)(38100700002)(2906002)(26005)(316002)(186003)(2616005)(6512007)(5660300002)(52116002)(1076003)(86362001)(6486002)(6506007)(38350700002)(36756003)(508600001)(4326008)(7416002)(66946007)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXL4aB49qmf6fgtydJvgqq2QFZS+y9OhILJiLNmOmg5rxlyMNRzqgDEOYNgl?=
 =?us-ascii?Q?4qH/lBPTtlQjWLe/epTRPt5mxZX8R9p2k1vsZ9FA9/fe9yWLd2sXZvPcJNOH?=
 =?us-ascii?Q?XEm/8wBYZELPjUy4mNAhkM509CkMYTBfp/gEpruHtwQVXScFJ0LN83KDFqV0?=
 =?us-ascii?Q?0xLNOiVUFrzPH82pHK1/dcx8aL67jQffXp6UEf9FrIPcSYw7GmulDBrfBeUH?=
 =?us-ascii?Q?dgupyr7Kbqb5CwjxAS287f+WSeHCvG340Whj1rs6lCsuloW4OCimKlMk6C/N?=
 =?us-ascii?Q?VqRGZW38cXHXRG0uFYaBht7Wi2D88ekkptfH1PhJZtaipzMLnMbao8gALJ0I?=
 =?us-ascii?Q?tGXKoEE4hwnSzpY3cz2RMddVHLS1porajYAmON18/7VGuk6F3vzQZ9/2JafD?=
 =?us-ascii?Q?ehs+ExxUJu58CyLseYS/x8BpPkchTP8IKzr/zPFsOFEY+kfr6aHFxeMYvbnj?=
 =?us-ascii?Q?8QJ60IMz/rTzDaxrTyo4ZxwmeLJT3R46ndfugLonNWAVq2mkRDI0VmJLuIqf?=
 =?us-ascii?Q?Z2wzv3UwUNqbyo2JMaLKqZq/onPU4KhkmQ8jEgkaCHUTRsu4V9Xg4P/x4Rpq?=
 =?us-ascii?Q?jyYhXDgzKCfTgHpMxJjOdXWYvczRafY/eMoFFr5UI169FQKaJghKdGB26oDb?=
 =?us-ascii?Q?TpMS+vWl0kDdb1rvbgXLd/BGK6gsii1cOwa2vgEr8LhIwSykOqlINqZF1/QX?=
 =?us-ascii?Q?2mCXXq/FTPQlPrjNJNfP51BHYJD3mKnwEmitTp3Ey4Yb16tAOMl2GaCjsOEX?=
 =?us-ascii?Q?BLvJjqgjU59NrsM34Uu7Uacz3t2g6i7o82cA8LWzOl9rMaIQss+aqFByVeFx?=
 =?us-ascii?Q?awfF6XHORH7BqHWH9qaFFF3drm4n7EE1FSQ1XwD35N8jglsnsoJyj0E5T04T?=
 =?us-ascii?Q?S0G7JiV72RlOhNlr1PR+LuB4LefYp0D01v7zqwueqAkZkMUJsWo+dDuS7Kjr?=
 =?us-ascii?Q?Jvvy84TJ8TC8fY0FZUhtGgufSGPlbvW+kt3OBkKYQyQU39KFr7sZsCkx/Ewg?=
 =?us-ascii?Q?pj6fGzu/Sxe9PdyZVdytFBdD/1Dmbeqb8JgaZzCZ4CuuijpgV0jkOfeNmNv5?=
 =?us-ascii?Q?dNbs8Du6PSOjChi2zhOPMYO9jeJqqAkxKNZrMfNgGVKIyXUCY38mOb1LMEfe?=
 =?us-ascii?Q?KMYfqoUxflhDzJRiPpCv3aCbPycV3JepP1VUpNXL+oi+1dkKOpm15fn04XbY?=
 =?us-ascii?Q?x51mTEeo9eLpksoi3St+3egYxw8cifj4P3GCMyd414FcDx4XILUf/SI2Ap7e?=
 =?us-ascii?Q?rONkfVtJr1f2X4TEfL1rQWfevAtEOuIxuMczCgkxf6xgsta3x373SheQkOHy?=
 =?us-ascii?Q?SNC3fSVjWDMhulYOOXQxdFiEYtgNmlIWfmkeFffwoN43r3LPPEahcjbNlRr5?=
 =?us-ascii?Q?mUl4bjsFyXu26drnjEC833nYVNQb0KIorD9BUUFf4xjJvPH5acurjpUJK0G7?=
 =?us-ascii?Q?3PxSh2J8FTNwi76rtAb4E5bqHKiEUhx4OvamQKIWq4v0diqoBXD4RoTKH+8M?=
 =?us-ascii?Q?rL5pkbxeXNaZ2HSBN8RiPLCXBndy7lo+t0LHcNkPI08GSVmhoU4Uax7Sq+M0?=
 =?us-ascii?Q?uor6fS4kdkFDvS1TjCLAxcAvKtczNhf5xuyPM5bB8rxrGn7t0nL8lyK/2ulF?=
 =?us-ascii?Q?QjrTSHMq/+QQBmQjc1t1xjM0Q35zjR6JY2vXKIllkyAwGyjTjUz5F0nyIRjy?=
 =?us-ascii?Q?QAV+HuOQMNvxTHEfhwXH+yN6svbSQ/okLyfZjoTmmoM+mpd+3gqaZkAyO5Jj?=
 =?us-ascii?Q?qrEyXPSL8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b94e4b3-4095-4e02-2bc7-08da1b8fda2c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 07:49:48.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/DIOVGXUGgepWgdYwO7wxmKkwmnwdeTb8Mz5rxxSLXwozMM2aY6cXTCXYyaqRf2Q5O1Xj7kwYYghZ75/xQxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyphen is recommended in node name than underscore.
So change the node name from "vpu_core" to "vpu-core"

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/devicetree/bindings/media/amphion,vpu.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
index a9d80eaeeeb6..c0d83d755239 100644
--- a/Documentation/devicetree/bindings/media/amphion,vpu.yaml
+++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
@@ -47,7 +47,7 @@ patternProperties:
     $ref: ../mailbox/fsl,mu.yaml#
 
 
-  "^vpu_core@[0-9a-f]+$":
+  "^vpu-core@[0-9a-f]+$":
     description:
       Each core correspond a decoder or encoder, need to configure them
       separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8QXP SoC
@@ -143,7 +143,7 @@ examples:
         power-domains = <&pd IMX_SC_R_VPU_MU_2>;
       };
 
-      vpu_core0: vpu_core@2d080000 {
+      vpu_core0: vpu-core@2d080000 {
         compatible = "nxp,imx8q-vpu-decoder";
         reg = <0x2d080000 0x10000>;
         power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
@@ -154,7 +154,7 @@ examples:
         memory-region = <&decoder_boot>, <&decoder_rpc>;
       };
 
-      vpu_core1: vpu_core@2d090000 {
+      vpu_core1: vpu-core@2d090000 {
         compatible = "nxp,imx8q-vpu-encoder";
         reg = <0x2d090000 0x10000>;
         power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
@@ -165,7 +165,7 @@ examples:
         memory-region = <&encoder1_boot>, <&encoder1_rpc>;
       };
 
-      vpu_core2: vpu_core@2d0a0000 {
+      vpu_core2: vpu-core@2d0a0000 {
         reg = <0x2d0a0000 0x10000>;
         compatible = "nxp,imx8q-vpu-encoder";
         power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
-- 
2.35.1

