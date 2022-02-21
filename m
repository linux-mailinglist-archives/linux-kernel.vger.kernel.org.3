Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D74BD5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbiBUGNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:13:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345044AbiBUGMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:12:38 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20056.outbound.protection.outlook.com [40.107.2.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC2EA7;
        Sun, 20 Feb 2022 22:12:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exJWvT1IY+CV91hFTEG6qw6m5TVClo9vb6ZoJdz4YNICuxLSVO19jg8nYvUsdaYB3yZCThopzr3l9k6oAqZPmD/1HAhBl6bRm8EMdtIOhf9KRgOz0BDtmkNkzQOq3GLvRJB+yaOJXLPfj0jsQw/nafPIf+Hl6g0vYQliqYdWRNuh9Etli8deZUK2U1UF5Nxu9rqypnWo8zDTxs1Rza+dyxpixuVAO2keZpIu8JYmo9iImUmOjYh8lyyabInQA2RPHmHBQO0ia6DzyAW+VNxum/6Sg57A34Mj//W2XkhRMcmbiTCZta/Q6Exz7UgSpUS4OcZmrjAdm4XrN3Gulaq9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=kEpnemCALDKkVH++DZgYLJcTGP8UnBDo//GEzcaKZEkan8dntBKL8LklzlYLQyelG8HN/QcpC7tB3eHEacrphTa4nL61mXye+WocbH5saxqk0mfeJEq1pCloBWyLD4DIPqz85JepRC7piR15c+o76A1HxHab1rTcp/jr6B5lRUYa5NI9VKtvjWmsk7w30k9N7ls/AllD9uE/xRvVpV2b5ilu6vAqgblnZQneCQEVunkU533MgbsVcdLaeOUqyiFZRp/O2ydlGXK/6MGCRc04fH35vhjIL9TeOclZWlea5L2+bRcFZCgfxOzA0od5ApHvrpT6/UcE3+l9F16A2S1TjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=bnbY+AQeD8Rw16FkAQBFu9BpttJFV3w6RK0SvgrgHIba3Bi+WDrTIqZTZn1i4f/5LUHb2vr/RDo59+A/64MQddQG2iIFaU1RpZmI0sd1BnEyBUwkWFVXLjYXwza/m34J/idxhqZ+nLYFvWKxEt4xFkGjzPwR635tQw/8UlgjNYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:12:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 06:12:13 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 12/13] firmware: imx: scu-pd: imx8q: add vpu mu resources
Date:   Mon, 21 Feb 2022 14:10:31 +0800
Message-Id: <26ebeebb59714dcce4a3ca8c80b4083d74a0b997.1645422822.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645422822.git.ming.qian@nxp.com>
References: <cover.1645422822.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a48c6e-0433-489f-5640-08d9f5011a45
X-MS-TrafficTypeDiagnostic: PR3PR04MB7322:EE_
X-Microsoft-Antispam-PRVS: <PR3PR04MB73229345D8C11D4FFC33FEC7E73A9@PR3PR04MB7322.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uC1uizqI4HdKawsf8iSUZT2Z9hiJRVVMymRtU4Eg9kZrK8Vtuik7oJub4EP87av1qQ6Z3hOR4xhZuRkZN0lbHLo6JzSpr6sa2Uh14Ust1ALXGgpUHpvpnbUoUMfh6LDEez0BOmYCZtQOZNJxs+yEW/6/Yv6SpsBN3nVcMGWmxczd6UnzjHtwX+ruaeCJa8Vt2Pbud+lFGYKpus9yW7sgDBZLXNrK+4ZWlgKaJkzlz+eOchUPrQyql1LUSK4Uyk8QRK0eGTE03nBxRNpccxfcLM/yFGCDhHgudVV+sd4nK7ASJ95yRmAfcMATOnGluu3qO/WysvnMIDmPVMczPu1g+dFLOa744QaSLPoXBh2AFKRfNRCGyrqEY2ay0h/I3AkKHxKjLUCBPWUvAYtJNCs04sxVsVoRwTsdlwYtmMDLAPwS8cPdXm26/xT/tcXe4q8ZOzBhbUF2y0eN6/xOjKxbPoSPTvlKHFx9cWFvq2mQBDQ4W6zMSHLImjA2bTO0KYoXHQrFBihTJBG1c11Kcs2ZmnFTaSf8CEuwJ0pht2J/cXYJqIwXzj5jQj6DZxQTkxag33lLvMpmDSoqoTjjXBO4IJfTB5m9V1ML2JKxhraWIkiQe5Zy4w4h3mSytUrgUp6fMJsj19hpsHD1IfjKH2qf0TQ7xzPbaems67rGMKO3evmTq3VIMNKVQ0GPEQwT+BpnY8QTfE+dxzKCnHruPHpO1MEmtRXvwVgN8F0VhZ584c4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(66556008)(36756003)(44832011)(26005)(186003)(4744005)(2906002)(508600001)(316002)(86362001)(7416002)(5660300002)(38350700002)(38100700002)(8936002)(2616005)(4326008)(52116002)(8676002)(6666004)(6506007)(6486002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3cHoUVpL3d+uAQgSfjz9YbGKU0jWTtmKEqdcI/zyttTgCO6+nTGdGBNQYnYg?=
 =?us-ascii?Q?IjDnBGaOFcZo+5MoUwI6znu+/asbu7FFR6ZH77gDQi0/IKG/5umQzJXaJD86?=
 =?us-ascii?Q?b1nE5akJci+Cvc8gTUF27uRcNHDRBpftl1cNIEkOGOBcNagNAmfqhdGxMrPK?=
 =?us-ascii?Q?8cBxcg6WfTu58M+gZugSnOZzQMcRV2S/8RUKxRpv0nZ1i05YRvSee0gNWzka?=
 =?us-ascii?Q?L74lumx4YfVPHV0e6Js4LT8moeSwtzwb5x2rjBsJ7I9R4y5YdjB0x7N/0W/s?=
 =?us-ascii?Q?foIwHq14MMsJXnxONZmW7INqAsAkFbmFrGK3hkJr7KO/KiR/vqJU98s2RKyT?=
 =?us-ascii?Q?IYlt31blpeB2Tz6vmww6xxjfVqIFuodwDEskwhVUuB11uUq05ErzOsMchgh5?=
 =?us-ascii?Q?CV0V9zRvC+nsAQ3+3yJ7kgQMt+H8CPxOKpYm/ly+h0mVFv3VawON9aCY5G78?=
 =?us-ascii?Q?3DxnIlCUsj3hnrGOuVNLdJ2ami+zy8oif3qa02IKck3923cQ4Y4jBXXHH38w?=
 =?us-ascii?Q?dRvjQ1E0RMBXyB2GhPPF13dt8MI/5C4Owvi9bxgM7FOzeS/MscL+WWN+B8Yg?=
 =?us-ascii?Q?Ru7VTc2u+icqP2iBHU6WBcNSjicPCkhTRP9WB7+hi6a3X9xeb47dOK8enE6n?=
 =?us-ascii?Q?NyX9UdkIhzxe56DwmbM3tVjOQvl03NakhciBXWy9KF3x4Ljq9fYfJb/nYARq?=
 =?us-ascii?Q?rMmS1Ufp+ZAS4A3SYwn0LSClz3hOVoCfukAxg4qd+Sc7DHSa7ckRK+AGlKNK?=
 =?us-ascii?Q?zaBYEnr3PQxWmHN0ELp8LAeicmib6PCe7ENlMBzEr3M+WH1MUd+dU5LarJFW?=
 =?us-ascii?Q?C2vyHi1+HbzV7iVBobjglmoW7agOA/1ZJWCBhC0YVGUQhMAasuiuplOmfMKW?=
 =?us-ascii?Q?bQZe2ABQobtdhjNdiRGjawICVpRHXVTaK8fu7qKKcjYJowtIjpF4WY9SbYxK?=
 =?us-ascii?Q?lcc3r3gCkkkSwOJV2pTfz+SfB/OHP/68FZ3+yVQVJIeh40mqSRwIu5LMec3z?=
 =?us-ascii?Q?HIg9FsEJ856GozP8hR0DXLeBn2wg5HDo/4rFEkCOdfBxwe4grj+rFjKrd8WR?=
 =?us-ascii?Q?J5aufDo1ZmxWckOjmZC8kydj0Lp+wV0GGW/V6Xw76+YtonDYqKZewT9Qz8jL?=
 =?us-ascii?Q?1jLnXHu1WEjUoDxLebDr5PsVWdISRPriAt2vDTT/B5J8ffbejIsZE7tY3Fmd?=
 =?us-ascii?Q?WFEoPjjXE9KS2z/Q3VYUaMbvQDqwJ4vMSfpuOShSLi2FXKS98I7ikJedHUX+?=
 =?us-ascii?Q?IEEIaaQ2HLn2gLHxO/3Hd38ndF5ZLEOJBBc02Nr/RGIMHCxR7PThRvKClEn/?=
 =?us-ascii?Q?pStjRJwACN8ygGFeIJTAozcRqPkNQy9O0hkzjNnEXDBSrxqqgK+blRL9wLRO?=
 =?us-ascii?Q?cOxdkoBFCvEBlru4AdpM3bXwa05yfxVM1HpL7fPpSAlTCEp/GTDsem9Etqim?=
 =?us-ascii?Q?6cNVYakbj1eQaukxf9UY8IEwBo846YXptWCT8iUlbTXiQCscUcYNfJZ7HUFl?=
 =?us-ascii?Q?4QZr+TrWaGWglVt5L8nab7DGIz3SicidVZ6dPpL9o9jBfVXsOwSruK8GAR3J?=
 =?us-ascii?Q?Y4vFiofQTbTBAV+ObUPHmPC+o1Sl8I8vhsYt/T7fFPgqocL+uuC9/MMJ8XbC?=
 =?us-ascii?Q?LhUEfBw1KY93xxIY7UwSpvQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a48c6e-0433-489f-5640-08d9f5011a45
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:12:13.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCdpqqkqyk/P9CW9+gyxm1IWtnNjricAVwVvnMe/UOjDK3qu7TSJsrO+e7AgPtk/LqjogS/YbL9+DUCgTJeJog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the vpu core depends on the mu resources.
if they're missed, the vpu can't work.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index ff6569c4a53b..af3d057e6421 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -155,6 +155,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
 	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
 	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
+	{ "vpu-enc1", IMX_SC_R_VPU_ENC_1, 1, false, 0 },
+	{ "vpu-mu0", IMX_SC_R_VPU_MU_0, 1, false, 0 },
+	{ "vpu-mu1", IMX_SC_R_VPU_MU_1, 1, false, 0 },
+	{ "vpu-mu2", IMX_SC_R_VPU_MU_2, 1, false, 0 },
 
 	/* GPU SS */
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
-- 
2.33.0

