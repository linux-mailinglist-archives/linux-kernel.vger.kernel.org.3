Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0A4C222E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiBXDM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiBXDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:12:35 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8BF9FB2;
        Wed, 23 Feb 2022 19:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnKZ1r8GVccAmAcoJhjjG47AJ+9hqifbDsgjtHFImMGyWsV+NDsrmifp36zY8zCEMqXwKykoYSi4zx0PLRfbXetjXROAnpkUS2W+mnzC8bQVybjbFHihL84P7CK/L522T002Qk17QjhZ4jRhHelnZBBYKZzsviHaQRWh3B8KedqpJnJU+NrneeLl6Q8++oy8bn5nr8PjdlD7Ah8Mt+FETyVi8B2rVL7pDOIk2BKHEAvAo1BjxUI6DdGZTiznHtRRcXrcXWajJO8JXpxtqmzDvHmBA3htXvX1wGbSgUW7awutFZkE7wu6elY3DyPwZXILAKxZNgd+L9w1SoEQcIrFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=UGBo5ID7p30+R40QL45pS9R1MkVvwQlfgkSekzEttigQQCFU/tKUktiXGpf5qF7rrIX2U/ICJQsfcqGUAUwb+Te1tauEXIzDJtczL6M62VFVNJ4ZUGRo+PG7fQeMjXshnngbAyjurZoBVxpZrzP9+THyMKTEiWEx3n4ivtubBkD4cStM1DBo0lXXps3nyZIfXggdD8eAlqCRzGvMtnRzaa5V5v9ZSmS88Kyq+m+nAeNECrGo3i1UZL33fZ4XmHTd9PQLh74b4QKxFELQXAnCs2lm2bkBcP2hfo6RF6rrVEVr/d12pUHvfTqiJE1IWYwCXjQ1iTmNRnJJlaHOr36pYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=PXQuyAVtQStELyTH/7E5ML5b3KKrdnnEebpaaauuY63aU7I0MiUDlzwqLw2f0jAZy8hx3maE1Xjbpc8fzPuwgiw/EYtuPczAWf9pdjRE4tvQNZvUOr1BkRtwQOMJ/aog4ZFc0W3Ufy1gGh7P5RDuIelAtD1YVZQ7xk/AXbgGJhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 03:11:50 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:11:50 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 12/15] firmware: imx: scu-pd: imx8q: add vpu mu resources
Date:   Thu, 24 Feb 2022 11:10:10 +0800
Message-Id: <ec521dc32f7a6706c9a4d8e7e04bc2477402116a.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645670589.git.ming.qian@nxp.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ee7c5f-6eea-4b0c-900e-08d9f7436667
X-MS-TrafficTypeDiagnostic: PA4PR04MB8013:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB801346C331960CB0A73AB793E73D9@PA4PR04MB8013.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Eqwvu8TycNUMmABtCNOlsgptriZ1MTYjc8R6rGe/fTcYLSg7E57NhSTOmIqVfWDOWYkvbUrnIffmL5AKeJ3x7INTuttJQe3YpoZ3LvqwHLJ0DEKTqgbuyzUAdhvN4AeSOr6fiSSF9foD16oln079EMzkNt+5mhuu0Hqy+pWojt29uOgw1ktWEPekG2rb4ul1n8tGngpv5gYrnh6lhf+CiKHn+ET0UshbV3FA3XFfseIXhy/Dzqk1ggr/86aQfdJDx3/XIkCrrtDhvOmEdbYBwCg/X2o9KC81IQeuAZ28SdLdFMbBNGjvUq8T7eRZrjOMLXqaoueGE/gOoZ19zbK/SSQuqC407M468UmF+JyACjKPKBhT4FuP0LF/Ti9756ix9FbNS6elEt/fVQqPEhsgCiwIToBpHDPHSmd0VnIO3qOgkKdJAvxJdQEhdUEMG7vtFSSYV0wjhQcSn5LObfahKZqvZC94gcZUXOlBn19m7eo1K7s2Hn9u+9/EkSyuy9Oxp9aObix9CuMpDCTfubKN9iBW4QGKYHm6kBEd6MQs6yfZ+eY5XLFBmHQnNt/qsclFIGT2sfU8wOR+hYCkLAUW7LAyJk9kAXbSEA4Z/gCVPaWMgT8xpkI0cgKaMfpIMTb3G+NjCn9lKhEQqZZuONBZF1TcZ2E19jCekhJLsZwfjVaooCaTDPTzfscIA5vgHBB5prtwIAH0pJDK3AgRlxOFqNkKtuyra87mR6hX+j0eAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(44832011)(6512007)(38100700002)(38350700002)(186003)(26005)(5660300002)(508600001)(6486002)(52116002)(6506007)(4744005)(86362001)(6666004)(7416002)(66946007)(8936002)(2906002)(8676002)(4326008)(66476007)(66556008)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Znado8OjaRP59+f1FnMxUF/gDNXtx4icm+m7QkCVMDigCb97MNdAHgDbBCdy?=
 =?us-ascii?Q?xZavLZUDQG5FJ+v1wR8bF2IgLBZd/UQpHe13GIjX8NdTQPHJvjIxmhBoB2rK?=
 =?us-ascii?Q?3QI7bqzVxXuB1ax/TJX3er9Bdsu33806gYfVheVUSxg8r05nNeEB1fj+EQe6?=
 =?us-ascii?Q?TVDt+rgE9qvX9GY/CN9OLURmHgTW+64MFRfxMMbXOhuP6IK1kiFpDUbtzfTN?=
 =?us-ascii?Q?fmCi2xYvscdwCxooXGP0g+3x5AGwGAkRNwezSOt7bTduK1llYE4zB52MPVSy?=
 =?us-ascii?Q?MElNCu6FigMbx2PUr3bSA6q/vSad6kj2hwFY2ysqfaiDQ6d7MrvZZ6Go7dT9?=
 =?us-ascii?Q?BbeT1JFELQmxW3+Wu4RHiY16skVBER8mzKfDhGlZuBMwq+LSKPhH7SPZOB9Q?=
 =?us-ascii?Q?7eFTRWRFMJQHXwoR5zcPgWP0mFrkkgI7DGRa6ar1lytOaJDtUAN8k1iIyJ0y?=
 =?us-ascii?Q?YLyxBCyGHw4HliQy3jZAmPdHrigbwTnTp9SgewvRr1vxoUzbK99R0BfjC4Q9?=
 =?us-ascii?Q?fF16Lm3r+W7U8Ga+fYRx19WjGqEUkN6oZ9HhHf6M87FNXXWlifzZm7zVJYT2?=
 =?us-ascii?Q?chyeCTElxM1ozefIHjKkQt6i7YS13XLYlz7+AGPea8/4THtQJGV7MDo4f6kd?=
 =?us-ascii?Q?CDl2vDZazi0CTxYOThyoN3XTn178qZB/TnAZUL8iUeZejr9L7OXWEukRRN9E?=
 =?us-ascii?Q?pEZOQPDusBVrZ5MQkDL0/ZVr1//DX1YliGG9CIg186qhA+mNLLs74L5lM5us?=
 =?us-ascii?Q?BvCZ8OIDiMuf6txQnMumZDFdz9p5L/2hR0pS/JkXHMA4EmFAy3IxYtLw+ThQ?=
 =?us-ascii?Q?/KumG5W4wtF029P3SUlgWNdl6sT2b7CDoShfTmcqYA1WOllcn21YK7NWM1hb?=
 =?us-ascii?Q?2blkuphd+e5mr8WzEtktjjTTSIzZdQxVnEEBthNfZCUx6D1EzBIPgihRXpZC?=
 =?us-ascii?Q?n7qYOBpWc3jtBa3thWGurg6hfFveRfiop2cmrPmV/SJJvB6TKFnErSgpy3LS?=
 =?us-ascii?Q?5/mWpYdl16CbIMQMEpYfs0ISKEjyMRhknILRaG2ET3aIm4Mye6w22LQ1etun?=
 =?us-ascii?Q?1SJR1zz1Lf+8DtHpnvMCTeLKMLaPj70Ll7RKbf29scZCLZBB/qWAmcklq+n/?=
 =?us-ascii?Q?KKaWDa0tj+E0QwQIS+vF7uiP2N/m2fm927nXxxiSbaXcKDkqpr7+wA4DgMdV?=
 =?us-ascii?Q?nU4rTWBzHdm5WnACXRHRlQKJtjg5FahFnjo0SttrdEJ4uVs1piNHYbSFBCfS?=
 =?us-ascii?Q?lMuKwUqa6D+RBi7FdE9Q/pWf3Ym8ddTgHTRh8seGwOBhzNCJkVqRdjayEfTE?=
 =?us-ascii?Q?oS9Jql45YDLynmFAqJZBEjpEuwONsY8uIq58beWGMnk/gLNGm0gJynkNIRut?=
 =?us-ascii?Q?clZaFd6svZUYj+8IAo6NKkRN8mFPJrdQqMS07F5kiodGi0K0LWHgEFfCjspG?=
 =?us-ascii?Q?3JEbsCPB5Py4+QUa92jMpk0AZI9QrFMSYkQdgl8CfUJPcZOfsocVuC2PSEd6?=
 =?us-ascii?Q?hO/m2I/WTrSq+h4voFidmiv3BSR9cWkLy8HUtgV6hQI/88OD+etxwD2+HqX0?=
 =?us-ascii?Q?UNK9+ymx0H2mkKZMQrpr4EmdUTfupn3yDnjI48+FicCTtv/GF5fIxyE8mOPT?=
 =?us-ascii?Q?on6q24LG3nvrHZ6UUCc/dSQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ee7c5f-6eea-4b0c-900e-08d9f7436667
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:11:50.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUIDMy70Uo3rt8zIwh4gVEkKveeU6reXtgpFaAC0cNin+etCy0uqRZrugOiEjusUBaiKxxqwZPeeoDFVR1LclA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
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

