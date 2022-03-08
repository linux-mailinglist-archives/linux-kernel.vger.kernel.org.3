Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6546A4D18F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbiCHNSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347176AbiCHNSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:18:08 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E6948E75;
        Tue,  8 Mar 2022 05:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQqVUQZTYV5oOOsrJmI2CHIEmhlHjAHeMVqU2SmiObtOgGXOg/DbSgwixbIqZvldT/Kx2TleIoKXrIgXFKNkponxN9004r3Zvdb7Iz3Qj1Uc11L3IbPsMxyYN9wUeoMCECds0BpEXM2nVr4Mp/IlcFxBwFpFqHgfgCIsjkSA4MrzeQxfnlhqDZBGSdr9McJETFXH+LONeWlqIkVAjX5YVXo2a+M20s2E8+A/fFH0NfbufCQwIeb1Y/CeqA/oeeEJC72i57vsJgFN89b8sA8aDTa7XI16HkC+IbCzi6OuK5HYEhOUi82IIMtbVGgOx8HCNYhNJWkB1Rtx1rNnbwcjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpIn00TEzOeuqv1SGCj4edaQ8eXI5u/akvN31wF1dDc=;
 b=Y7BGY2Ty1lyiYgcJLz2tCgQsPYeoJ/N5w4bndPKEk/f9HfoZuKgOXuaEsER0WF2k6JbA4mebDAyY+LIjqkEPBYH2tZBbh1S3pvO7jekpl782/cj86yXU8Or5e0FVDFZba9sJN4MX1axqHyhNAyie0fjBYCYNjtqiGP947S+8KwagUtgssLi2Ii/RXD+znMbXpO9eFtR3MAazn/f7qGQFjK4gPHDfrQkn69irwS6jcxIk/gsIqJaQHBgMM9HFJ8mU6Iq0MoMSjTqcq/cJXq2ZdVTUmW8ZK+ZX7Is+PlEvaLwLBzheV/NplVj7uafm8ROGCLUBM9R33Js9hQ0z77LqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpIn00TEzOeuqv1SGCj4edaQ8eXI5u/akvN31wF1dDc=;
 b=d0lsQQT5CURsnswMHAqoKkV9B+daMd9gpZME4PjDHcebF2ise3lxUV+xUk59S/mpa/T7ltVMtkDQsnUXvQWcvJuYH/j6VPNf2jC6bBlAOwiqc6PvGHfyClqFJsW5oDNyUSz2JHbK0a6MclzPinziUos8T18nZNBfXg2zL5J3km8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by AM0PR0402MB3635.eurprd04.prod.outlook.com
 (2603:10a6:208:a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 13:17:08 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::a1ae:e74c:cadb:efb8]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::a1ae:e74c:cadb:efb8%12]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:17:08 +0000
From:   Mirela Rabulea <mirela.rabulea@oss.nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        dan.carpenter@oracle.com, ming.qian@nxp.com
Cc:     linux-media@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        robert.chiras@nxp.com
Subject: [PATCH] media: imx-jpeg: Fix potential array out of bounds in queue_setup
Date:   Tue,  8 Mar 2022 15:16:57 +0200
Message-Id: <20220308131657.1722495-1-mirela.rabulea@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b3173e-5cf4-4a2b-9250-08da0105f296
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3635:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB36353E39EF45FAA99C8BB8ACCE099@AM0PR0402MB3635.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FrNavQjw9oZRtAj0sPzXwxUiYFej6Hz8oYg0wKIwuYOZzIpTpxVd/9h7DKANIbGjwPota4vbTb+IjRtpi2eXoRKxfQcOLxI/KDjGO1rfT2ZhXC6o2dVA6XMORQHaSZ90Z80mXwy+Ox32R5JB9WhaeLpeHVqtoNS+c58KFA8fr7EPPj+Wbi/Ho7/IpeR/MPzimU6DFxYnPrKrbkjBSYH4Ig+B1FzbDq4OJjNBicWW5n6fHj21F1FX9uLIK+rTZmgTGX/OJikGLuvUhO4O2QrwdC9m1/YmcwKGYKMnT00rIYfWN8kKtXQhm6qT1tuTStBnfQxRPngZ8Z0iXcP0nAJOqcf6TBhgQ9xiaJ9mnP97uPslJLAk4lfxl+JeDC2C1JapGa30jHah9829e0x3PbpeKW0/abDqARNwJleT2bkY0o9LqGqvFTFz9tU7XHz/f0GiFWt1jTakOu2MnEcgHzJjJjaKgESBsHiVnioRViLq2Ln89IIF6lVav6evROkzTWM26A6W61ObKDHYTBX2aa50/up26mwxDPl/UPesvR6StG0K0UVzI9rqOyA3tTN+I/XD6OwXCdxLb4BZcIKmTRGthLXreCNfoIBcqXd8StjSFc2UtmzJb6XaSvr8JNBcc0SXZiK6lwEjZftb39305U3gtYp4A0ob0ykDedvGMTDZe5MQezjpX0z6/92Ry4AEMfjuK2jcc3YULV9/Q8hYMNnHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38350700002)(26005)(1076003)(66946007)(66556008)(86362001)(8676002)(2616005)(38100700002)(4326008)(498600001)(2906002)(66476007)(6486002)(83380400001)(6506007)(8936002)(6512007)(6666004)(52116002)(44832011)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTk1X7xj4dser2MEhubJrrh2lXFe3wCxw9Wv12oTCTxV1l+Lc1DK1WmNbQY3?=
 =?us-ascii?Q?LckMG/kb8Ee+Sr2Qrrr0B7Pfipxxg1SCbXuzK8mWabkWsASkxLoUE7Ff7GnM?=
 =?us-ascii?Q?kkehkTU0Q3f1/hjrJ5UjssSXqa22mr/090gIHT0Y+Ln7qFRzKgoHICbaqd+R?=
 =?us-ascii?Q?RYxRjpesA5fNufrhPUcPPmEFHKnQMJ6qEHFik81LSP5q4Fydxu4fgu/o1Ooy?=
 =?us-ascii?Q?9y09nLYZdb6rt4dTFTCZFL74ODqD+aJUnUOhWMEgVlTJUe/gK6eqFcAMnruX?=
 =?us-ascii?Q?h3Mi8mICLyaBj5pwS47rZvQy84nOU9rXLahywxlXufLitWma1nayhtoXGF72?=
 =?us-ascii?Q?VRWBo27NuxGqHSVqgXihVpMK1qJ86j6XJ5JkLPJ/vduHTc3RcvOOJRoYaY+a?=
 =?us-ascii?Q?7T1wOIBGwXEHdST0xE8hWvZXKMweJmcG5T5lLDHbR1wfjOCr7DC1ta6PYhEQ?=
 =?us-ascii?Q?5Ar61PG7zsmp3ox0ku7shsPEd6baxzUpooM+b+/btyaxz7uoF0xi8l78JOH5?=
 =?us-ascii?Q?Kg3J+wOAjmx9/zK1SABCyLWbCeRzve7QgGggGnDYotOJo/R5KcMK3y+pfhgf?=
 =?us-ascii?Q?tU/AElSLdlK21sx87rSlaz7vZPZJpYPVvEydqgBzdL2KO00Y7h7tBFX8AZWZ?=
 =?us-ascii?Q?9R6DWkaN6cZ7JNkf+Bi6SN8lJyunHtwprAU3c6hpIWTcF4Lwy8GZlO3Zm9Vr?=
 =?us-ascii?Q?wwGd+RALHiaQIejahuWEq1Ac1ubrmcUz2W3D8WyUnVmfWX8GyCeC1h4BdqN+?=
 =?us-ascii?Q?c7OqojLiQMW5dE6xCeGlntRm28G1aYiq8wUOtBWxJp93uYQhUQGdd9KHvMLb?=
 =?us-ascii?Q?fkpsE00QIXEPenUdJju/kEIPaemrX5w71dNo77KDLp0CEfcvQlVWymfYOLUh?=
 =?us-ascii?Q?l2XOYSEyvTe8YM+K072mduP0AkF5VzEtw0HIUvbDyrFjRBmxZFyrjq1eSNgF?=
 =?us-ascii?Q?/ZVb5n3dxCy73WouVa/JZa1w9XTm8+NToaOMlsBBkaFDZdC1WbAj/BnOcGqI?=
 =?us-ascii?Q?6d7lCIG4JdwvFUXn/WBxmjwF/Rrl3lVM7mB4SeuqvJ/7CFUP+0uFVgLt9H7i?=
 =?us-ascii?Q?r3fARKaYipW6URTwK9weXmRbIROvdCNEZatw2rH/0k3PULKbfEex2pmBsJsX?=
 =?us-ascii?Q?t5o18js53tPJree84+Hj7vmwYZw0lVLfE4MEN7MPvb45DLXBNZPZ9f7Bllmj?=
 =?us-ascii?Q?zM65EfiIqKUBeTMWNf9BaP+GUV8E11oWna0SS1b8/ijPxlCpCYuYZH+zEU4+?=
 =?us-ascii?Q?lBAqoQ8DlLbXyozOcZkQ6dnwn0aNZ1cSzAhjSK8TIwMegghJsVxAEs0bIf1o?=
 =?us-ascii?Q?spRKcvvaqfVW1pZBO0Uo3urS+S8whQfmUy6y3ziCFlUyHEVfXgr2bMszzbHF?=
 =?us-ascii?Q?Ret/QmCjdelmw1Xin3oG1IihZfdr4Ej3/Fk1bBZ6mnyENxl4/+6XnMJApaqA?=
 =?us-ascii?Q?cSn+dwXhxuLwnkioxMmtDjXgChASp6fM0PbRgpPBRPEKE6veAbkTPxAzWnzv?=
 =?us-ascii?Q?QuW21TsPzHJqJiRvKEBXwUEtnsh+5AmSUmpg0QoqGsjf1SiFYGh3L5qadUAf?=
 =?us-ascii?Q?fqSEnYluvklPK2e1pyDTmjm2c2Mm8Xp39bkDzadwZMs9BulRKO1jGxLJCrZx?=
 =?us-ascii?Q?dkl/H3srFMFnRS0PSEsvUZY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b3173e-5cf4-4a2b-9250-08da0105f296
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:17:08.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmRSGuY9lKbK0UecmC0Ph57v+KowhADbi59Jf0UcyIefnbMV8BQg2a29mp9NIV15X0Xf+uOmmKOtZg38ed8vEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3635
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning in mxc_jpeg_queue_setup, check *nplanes against
current format:

drivers/media/platform/imx-jpeg/mxc-jpeg.c:1070
mxc_jpeg_queue_setup()
         warn: potential user controlled iterator 'i' (array size 2 vs 7)

Signed-off-by: Mirela Rabulea <mirela.rabulea@oss.nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index fed762491379..f4819168c85d 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -1066,6 +1066,8 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 
 	/* Handle CREATE_BUFS situation - *nplanes != 0 */
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->colplanes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++) {
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
-- 
2.25.1

