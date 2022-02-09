Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDC4AF5C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiBIPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiBIPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:53:23 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E2EC0613C9;
        Wed,  9 Feb 2022 07:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqNEAvDxW6RqbgeCHyAzfGbeMYayYxHaVqXW2t45VG8BxPFYzZ6c/SwF7aLsVT/lkGZLC/2H6EgcGaZDR4IDD8uCkOCwhJteQgdVQcZ4bhebQZODv7Tp+LM4b9eYAq0mrdPX/ISvJhe7rp1/SVvEjXejFAbqErqyu8qYgsUctoDXA0lCT95qZ0FBmRmdlTPaT8gm1dPwOx1aHGmgWF5gtFzRQh50xFi9Iwvy8ibsOJ8hdRwaVl+bGA0IqjSo9hIfpMdc4hf5Ai9MfOLQyoinDqpGXkDfTexSLvywnQOVvS1C4ae2U42R6KwJFHWRanE94km5UBAWYQRWRB70dy7+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYIAO0SzYjGet+T0sBUncayx21I2ft6T6PF24Z554Qo=;
 b=oLZZ2wtnB3W3/6qUI2NiT4iigs6QfkoGtuzMt1WnFpkL4JXzC75WhQLBcjag9auba4uuNeUBThBcK7NpFLvEQmEEPkDgtvJo/WYeq0bi6s1uC0QCVeK/hYFi6UM7YKZjoSiL5Znccl0XljOxGVzW6RVySnSJvRUN4AKQI6vCim4g1OUGavmF35JMRHhCkEvfCah4g8d7LiZ7Xh/fbo+x+cl9bD/FjV7b8F7f1sjEabQ7bAV8rlCyjKN2G7nm/wO5kdzizUgwsmH3/04yiKOq9t0BLBMSy7Lr4RE072EgNxyvRmc1Va2D5850ok0suyM0Vo/DmihzeWKl0ilZtClxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYIAO0SzYjGet+T0sBUncayx21I2ft6T6PF24Z554Qo=;
 b=Zkliwaly3rexy9tZDVTnrW733TFjNjWHVOSm9jX2BHG8+HYF/OUWLU+/9GN8PCepM54Mdve6hs9XWuzkZf9cNV+l6kqcyBXRg2BX/FqjufbMUT5b+0l54ZUPzQcfP5R8NbvFL0ACMsm+nzl/RUQjUordOM0ynQ/HfJZ9f2Q+i4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by HE1PR0902MB1852.eurprd09.prod.outlook.com (2603:10a6:3:ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:53:20 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d%7]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 15:53:20 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Oliver Graute <oliver.graute@kococonnector.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] arm64: dts: imx8qm: add compatible string for usdhc3
Date:   Wed,  9 Feb 2022 16:42:23 +0100
Message-Id: <20220209154223.15252-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::18) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 446d4b44-d0bd-4881-7c43-08d9ebe44b7d
X-MS-TrafficTypeDiagnostic: HE1PR0902MB1852:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0902MB18521BB493A9C9EDCB8A08FAEB2E9@HE1PR0902MB1852.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZFBWUtlHpWpTdkyLR1Xc7MDeIaQ46gPuhkyeKlq651fX3GYzX48RDZFTICXKXPVB70bCBS4l/gajKPwnTlqvdTn4OP9g+NDZy/bOX+alyK96LGWojJzDhZy8A261fUHN74ya08ODqwJ1npboNOr+7R7vmR3BmAlLmL6PlVtac4x5K9Kk1PnxWXGeGPlW0kMX8qxtHalFMtfzBOuDEMScK5MKCEscTu9DFtl8B10fBMq2BhCcnPZ0Wj8f3HcOl039Wv2hhAfxTshthSGAYPqdq2qJ4SpX/NeIrykdzWh+bT42JBVKr+6MxXLTqKJmY+ZGID0VlH3Sp+iCeJEf/qo3UDeqMtlJAOKrIO6xY+ACx3N6aKfLGMr/3ByXsLd2EXeM//U+QAjLedirMiXS7vOvPtNkhl1WdbyISzOh1BGQ1Oq+TRBfT62OmuaZI5HvpO3oV28Z2nSL1eFyghYwkf/jvcu/H8XLwLcsFbeqUp1+mMO+ox9gjw3ieeTB4d9f6vLB7t/3nDUA3ZA1djJoO8+TjHJtpwZ4a+rJuaVnadyKsuk2/5Ql+hVha08+eOCTZta16NU93j0SDGHyQLlY9zJYpExEk9IA2GOs4ePHlBVKjYx6VaVABgtDLO2HS8MFuxVBwNyaeHCYGXGrp4DluCxdeRcxgZ3xZrMxjsm29Qqd7AwKcHxFMHJ0n/TQhe/yriXnKt17EjTpl/luWEm5HDb6VRfhj/HzHPtoOkksClHFzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(366004)(39840400004)(376002)(346002)(38100700002)(54906003)(52116002)(6512007)(6506007)(6486002)(38350700002)(316002)(110136005)(26005)(8676002)(1076003)(66556008)(4744005)(5660300002)(7416002)(508600001)(66476007)(44832011)(36756003)(4326008)(8936002)(66946007)(186003)(86362001)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bra8TO9N1lH98+t5arFMO5w6bRWh6yDsiNS6abNuCMLELzSYvCcmxQv9Qpqk?=
 =?us-ascii?Q?pVGGyl2xA12P22UpTU/ZgOEnN3JQb1jTclRqtSvAyFV+NxfePVQXqBYPc4YX?=
 =?us-ascii?Q?HAnYNsAs8m6zArM/IGPA7aYARjexZbek07Hc0feiMQGs/RKCah7Y449jERVl?=
 =?us-ascii?Q?gD10dUQDWNNFGmYHVbgvANQkHZcjDRGG1Vps/jHZIn0JiPHAe+bZSqrtFBj0?=
 =?us-ascii?Q?JwipTMjIZpaFCmBRpaOAz4GymcycUDU6czgawtv+J3F+vo25emwv/ySTO9aE?=
 =?us-ascii?Q?yEGzzt+DObmMlY7JB5XCklG7PmUhSZJAG40sbsxWudmTfl5vPuthN2QWT5gj?=
 =?us-ascii?Q?Z2oSHpquoUNg3400KRxr1QP/ZPnscpXGqkmR+bi9azqQwqlmeRby9yRmX87U?=
 =?us-ascii?Q?vhvej+s/HGsrD0gamuXTRTuk6d184QaRB47LCuJs3x2JUnS1FRPsaVn301dQ?=
 =?us-ascii?Q?8rCqtoB8bvo6KgHa9bk/kZtL/8KVYGrntgd5u4Rb9FWxo2pivcahzshyiQLz?=
 =?us-ascii?Q?lkXjWbFvb6F8lSHZQv4Gk6o/IeHYRRqlK0kdAIKMQaFl3UrQ+Yqz2vwGNlX9?=
 =?us-ascii?Q?uAfPw5/CXF580+8ww9BnykpoE8Jka6IdQO3oHLuN46/OlQKBUN2hp9k6K8kU?=
 =?us-ascii?Q?hLFqUFosXwxP4lWYyC/ko6X9a+CV4CxtAgEUQ08uOSHSGbEdqHzJtdfZ0jWE?=
 =?us-ascii?Q?0071SiaScLTixH2UczPisKl0pW6Ho3WIP6LMfNLbk+b5v/bUTb4yTMsWYMgw?=
 =?us-ascii?Q?Yi+0aQBfHpFxuIZCOHsuFTROduruOjPjkR9//WNTRHUpsS3D9UDaO67iwdL0?=
 =?us-ascii?Q?V9GzE8FlCJboIW3JzAZvqW+esvzPZRUKfz6X1lkXFp/CxAS2dd5aV5AM7EfC?=
 =?us-ascii?Q?WkZ8ZU5uHfAmNKbOeFkwLawNra3p3+x6c1hPmT7ReRYo0JXcl/BPBkFc+f1m?=
 =?us-ascii?Q?YSfa7UujH7eSNKazpCuYX+aMFd7tZagj6DyM4CvONAVqfeDKqTk2dh41uIJZ?=
 =?us-ascii?Q?c3e5QQj3nABps29NF+y6OCtLfnIz4307Q6vDQ1yyl1wQP0hZlgbm+awEdWx4?=
 =?us-ascii?Q?nTfS256SO5Dhl74brOJnruH9EJB4yCZGG6UHCvrg2Jqmd85HlqLt2PJiq+Zi?=
 =?us-ascii?Q?Qk3XQyKliXBExrUy8k8CgiLzupHx1q5CSDLQwB4GnMZAGkGM31oZJJVcupoU?=
 =?us-ascii?Q?kB+4dYG/4ytUjPuN7xj+dTbCSWYENSAjScrP4dCVeKNOeEWozQq0PgTYwlDB?=
 =?us-ascii?Q?CvGhbbFkpEA/Ok5AnaYhUeF0uRQktvBBMl3DuuBk2MaSU8rb7Vg9Pb73OAef?=
 =?us-ascii?Q?ujR70JaVbEyJtJysBJdArjbQD6FEMOjwwnJTshLKcx9UxavbkrjeQZEub/+y?=
 =?us-ascii?Q?zBAjJ/iN/dxDGCad18ohCXZII4+5epaHqR8dHU1HsDHEUL7FyBNxfyT93/uB?=
 =?us-ascii?Q?+EB+eYVjAGeZ88JhXwq+q54BNXBSibsHaqERm4W0D05gqRJ7ejtrZNMaQ7d1?=
 =?us-ascii?Q?XiSXTuNJIys502mp4YSEVt1UbPxCGeQ0ucDHFdSfdRa10EI8NlPRsywMu+77?=
 =?us-ascii?Q?6mfhmQOx/82Q/raDCg5MeFJQUULGpPRMPUtz8HVG/eDpVONxJqHSSBBGV3mY?=
 =?us-ascii?Q?Y5Kp+i+QoD54DW422fk/GwxB9AOUdZNlhnYW9ksTVzWppWsxJzYDLJ5Jys5V?=
 =?us-ascii?Q?k+qNGA=3D=3D?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446d4b44-d0bd-4881-7c43-08d9ebe44b7d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:53:20.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie57JrMpwM++Wv/o8/yXqlVYKu1Ytt5cYBGnymY0DdNfHwl0bMUPXiqanQlypBaCq+sV2zzOC/24BjGoqDR7q3NMZo4seA8sFW2C/r4gfmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0902MB1852
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add compatible string for usdhc3

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
index 00ae820d5175..8c33edf0744f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -19,3 +19,7 @@
 &usdhc2 {
 	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
 };
+
+&usdhc3 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+};
-- 
2.17.1

