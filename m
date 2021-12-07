Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29246B5E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhLGI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:29:45 -0500
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:11631
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232630AbhLGI33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:29:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsFdkq7eSRPWU7hhnEOna1rblQxgw5MRjd7fckRPeXpa5oEHBYhYzIF+ltbpiMFK2YKA+K+77V5opKar3XyP3mI//o8MxhNgZSWuK0cT0pnIYfmiMefzBgMAVRiFyWhc4ZAOdrlChMnJolkOUwQ9o0OG1xDWKfaWeL71ZfCoz9qE3AWh8GWp/9IVJ1OQMudBvIHd9FrO6MpwDxqA5gOP/foXhjh1HhSTeWQCFYqg90a6zwvkcAj0C+Qcj7vEWmg99JbBh0eHV+AoivFU+OZC228wdK1RJOrrQcYoA1ZNhBZ4wzgyGEiqxBJkpCYvfF6wHpA9A3bTdI5jIR3DWfujfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=ATTfjRr4kvqUJQBuZmwEiim8GFT9Ks+zdfyP1R27vEdwBql31PSBVGuQKnpvhAK3L/FW1V5MQEvmKO6PKFtEGAa7B0zJpECGQq7DNiRK1E3jo/3aIIDeJqOOz3XktCO4uI5XvlcotiZUIqsF6/trIcDgW8k7WxQVCWPoKTo8xUqXOCVhEsFdh+WCiO+2yPsQGOUyRvb4au8s9M25XtVBRvs/U9uw0enb/aFrPbJz7sC7/gAX8pogSUZXWBv13C5ViV8NgKZw4CVn3ybKzt3ZcImIA3D4U7M7UFwSY96nnlVbuor1NuFxQ5cGKjkC6lYqBYevC+F/R3NfpJqOhZs3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=JRFf26fu1iPxxsEUg49M6QLlmduvnhIY0SH2obAgKr253J5ROUTRisGPJKtuPbrZ32sLGVXvPOeexkhCh1ickO1ArmdUbQcY6PXxAXlymQ02J8idbgHUdSNtFIyZT6o8PpaoGt+Hg/5BxxUEQsetHVxEuvE28ZL6Y0oQdn7LXLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 08:25:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:25:53 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v14 12/13] firmware: imx: scu-pd: imx8q: add vpu mu resources
Date:   Tue,  7 Dec 2021 16:24:27 +0800
Message-Id: <8e9bffb068f449e26c0efc9c86bcf0441926a7ed.1638865027.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:25:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb31d6c4-2803-47d0-ccdc-08d9b95b2edc
X-MS-TrafficTypeDiagnostic: AS8PR04MB8200:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB820044D32ED57CF72588DD35E76E9@AS8PR04MB8200.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csYMUuj4lfziEN050wSflIZh3YJRBWF5+9TYIkLXoMWVIHPoxMwYZVQwDqWZ75PcsDPwAeQ9Zfsznjn4hjjGVlcKuZzGmUKbQ20Iir2NNqC3rW7hA+AIYFacaRDjO6O82tuute8z76ncKMMFpl/bCgRtD9hf7n+blcRplSd13XDGmbzJv3zAJu07B5gCu+RjwxNRSeG95+DfAYHl7qX8SGqbzQy2O4V4nnDCFIJboqbER4iTead9ECiPvlAsZUrwhXLX93/cT7iDakcgiw+E4/Avm+Aw7M3N2XrtaF7bYmF/s0yFOoVd51Lg/UXQyyejnipBynz4MtIbwZi/YvOuWJoD54zE7vCZqQliWXP2OeDUZ+gLBGJ8/dMWkCKysL/Vjt6w29KvIszmMcO6JL9kqYbfgJpewmvQAwDUDfpqmIiE/OOJJuL1thelLTJ+qEu3XUCVNhALDg2F0c9biA7Ogdx2q99Jl19f9/GdSkcYZQvcR0pDz21Onq2t6k03+sslZxxdx4XBr60iBcT2RV8+AM6Dr7RSY+gk3tG4gYnGPDVe6vVby8YgytPPMPDZ3a0SM0vBZCUsKkXwVMJeJIEnZZWIwsA279EBPt4nLrMb0uoHEGIfu8vdCy9ae5/scd13BMRe4/HkFKk6Ncr8TAS5S2YNziwnsu5BWe/SoSmofi/DcXviJeCU3qKislKO+u0e6LaTgtD19QSYNzmFgJA63QGNRdtCbAGP9DJhk17ehsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4326008)(8936002)(6666004)(66946007)(8676002)(66556008)(38350700002)(6486002)(38100700002)(36756003)(2906002)(316002)(52116002)(5660300002)(7416002)(4744005)(44832011)(2616005)(508600001)(956004)(186003)(86362001)(7696005)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/62+MACb7YDquMnt+rIz7QOn0gdR12liWBRoiF908avi6NpdhSm3HU+/5iJ3?=
 =?us-ascii?Q?VZXtda2O39BplYrt3yCnrAjkS04xHzdUhOAwpIH9zgvzYFzfoXeMo8twQlEb?=
 =?us-ascii?Q?QfvjMtM+pR69BAS2++s6vIAwD9ThDwgDtTiDGTz3nEx4c5WxTOscBidj06ca?=
 =?us-ascii?Q?X+FfUbJIATkFve9/PGMpe37GsQN6pOyRLTKqclVIBR6KuKHenG+KjlQa+9bE?=
 =?us-ascii?Q?MUxSpqulm5RTCnlGPFJixyR6GaV9u9K0/VNrDiPTKduW1D31FJzACO3YGM7p?=
 =?us-ascii?Q?kNCOOiV3+eaCnGCwOAhNmvkUX4PGkNgdoAzObNwdkSVn9MWcNFRlchGrurhv?=
 =?us-ascii?Q?WAIRfFsBNAAGHMEIn/kzXhiNWZB3IrsPJIqe5BqKEcrHpdBKnqCo789i658N?=
 =?us-ascii?Q?7G9c7DkZd4dlKRtcTFm6AGepjVlWA0PVwN4gHIdPZecgeklSqX8K3Ym6MHtz?=
 =?us-ascii?Q?3j3FhA2N1fTKKQR8hIkDra7mQ9VxC99jBXIXwHjHPXL8N+1v3HgFd4N6iiBr?=
 =?us-ascii?Q?gaUAmm6uPPZRsEHg5KsgFluF+vjO6BeJxxxKFxZt3QeNhIMfIvx0W7c7zuiH?=
 =?us-ascii?Q?WC+lPvTACY2MG5WcKhSvfrH/WHCc9FFXXsKrlHqSzG4sYDaD4WHSDR+y0oE0?=
 =?us-ascii?Q?lhYsYTImAPqgMscSZclfF9/lgmK2RhDPG6NbtFh9vXVe4FFkdO4EswMlKmCW?=
 =?us-ascii?Q?6nMz6lsAtRWiRQ4ZpUAgRFXlCCLk3ErOWV6xrcX12i4mfWI2iFbzvoue3EKa?=
 =?us-ascii?Q?2Ou5hH+zcnJocyS0XsjjCuGj8m5Gkt0cCDramaCd9tAqB5Lz5/fmfhhKyBJd?=
 =?us-ascii?Q?nb5PwxGVzvfVnSObVS9ofcvbgi49NFWg/3/Y6HhAyJnSIbu+GyEK2qRMqoKg?=
 =?us-ascii?Q?9QpLi5yLu/Dem0tPHEwpb3rP6MBWg0XPc2TqIWDltqiXWoToWAe8WJJ1dUMa?=
 =?us-ascii?Q?4q3PQg68m9ha0Qg9nuxW23GRJUALRzOQ/+us6STkDdZ5VNjelp/4Wz11MNRh?=
 =?us-ascii?Q?vt/ERf/cekaDQygFWB3YxXVC1EZ7wdwR8X7drSfpUtJU3qNXofZXQ9R2Vnu7?=
 =?us-ascii?Q?y7oa2v1pbbE7dbw01QjHCXoBN2UCpLXILxoctXxO0B4lrpM1/VyiYo7HdGtT?=
 =?us-ascii?Q?os0FTASHh3HouPFbgZ3RiDWLomHON6VMDFkLpstZ4d+9gw9qq0YT7htSadiQ?=
 =?us-ascii?Q?gBw6rXJJg8hVfu137DGyv8jgrqSueVEYP2iIrAkrVggeu3zYXkezM2k285kT?=
 =?us-ascii?Q?Ynbmzaf+qG4E0xkGN6gqNO19N5igdFk80IBdYPB48VCQdU1B3DboR/c/5ADj?=
 =?us-ascii?Q?KVIA6maO1RC4dLAQoU4RkxWeofMxJSCM0P5B/vLnMt3xUoBOTjzyeWsAkNaY?=
 =?us-ascii?Q?ejYVBHowQnJJ/ptlae9v8Thmuv8NIOQirZczmV83LIaKBvRPk9rax3JQjc3I?=
 =?us-ascii?Q?oxTfASH3D6Q4ZNeJJQdiVkQ19jlLKGfzrKRFZuUU1qD4t6g6O7YjjkN55v7a?=
 =?us-ascii?Q?9RKC1Z/2b5kahBkTBhanODa1lFstQGcWoNmS4E9Ww+uN4u7JgY7ArMqAVn1H?=
 =?us-ascii?Q?vtPKeuTr0wG8MirUur9q1dqiosqmuPPez/8mfkvyKVZRmakGi46zfQKkvKVK?=
 =?us-ascii?Q?0I8FjZosEgDAzOz30T4sgu0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb31d6c4-2803-47d0-ccdc-08d9b95b2edc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:25:53.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CSG7SlApP9ZUQ3SEV5GGNeIVkSmpfvDme1UF87GJyY6Tsnx1kHcv76mlOhStXc3bmNC9+hqEzT3gYYnqG6alA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
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

