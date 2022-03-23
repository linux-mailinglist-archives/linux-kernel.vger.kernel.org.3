Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADB94E4CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbiCWGtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbiCWGt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:49:29 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CBBD5;
        Tue, 22 Mar 2022 23:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYz7BkiWAeAxIMC8aMXvi1fLlFKI8k/wf9KFBeNw+vQP0IVT/9wDdnVwZRVwTlNPcKSRi0egbniAXq4XDUyJArLIKj+AKWeSAadVXg3DOC/okgOV9BsvrzXmMg8aHOFvVSSrm/fKMfPIogd4IVX0eOQdVK1CIrsSktMmLjrAOdcnmHrPpm0hWU6Pet50KNgncbNdLl8sVHH2vxMcS+BpVFLtyaLR2UwtL5Uaj9b3NRbaOfUnRoNb5VuNKPFCjl6CoJHB6Q+3QD7YG0tINzqMT64NZd7dy3Ap320agiKyRCGfqfSQfn9WNcGloF5+FG/yAYD5IOziMTcTxA/b97ytWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpnGXM6ytYbbx3/45kmEsNBRBqknIJ4aIvOZlw1fkWM=;
 b=ZFU/M5RG3b69uUJOSLCq9TqRM6mzs5r5OM8d2Qb7UzTM6fxs9shprOAtYa68MZa86xYXs4ij7w2RoRaGRj7crAyJobIOlFum1NicPNs4Zx11yeViwxS8Ul/KlKeK/VOXjyrLvHJisSXOhkIFWjhiRZ/6NglCHTNOOVPh1TmQs4TIS3n3iXOtad8shWAo1fgG/A+cCNU3Sq03sQCcFmAvYEhtrnYj/OqNKHo2/sRiDzNDaWOyoT83B4SV9V4Hd+tmLEslNZ9qY+bwOcezLqTVylROHnqNzYA5rIwiAYaihVH7HY4xfqqcZXbuVIdGBEpZJgIHgnuHFrjWwUvXEHJxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpnGXM6ytYbbx3/45kmEsNBRBqknIJ4aIvOZlw1fkWM=;
 b=GRc2d3ZuDY2fu63P4qkH60Aw8GdY3tHDxj8eUPfmMVBggueYa76pgpqbJebzfEFA7XglABVxw3xsgVUuseI2BFvHxWEd7Z3wI9U5D4pwsWzNWFMjB+XZWZ8rfxQaeyH1hH9R02dE7Kw/Gi/8Rle+gh9MaTsURspSsp/lMpA0xDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7379.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 06:47:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 06:47:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, shengjiu.wang@nxp.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] remoteproc: elf_loader: skip segment with memsz as zero
Date:   Wed, 23 Mar 2022 14:49:43 +0800
Message-Id: <20220323064944.1351923-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
References: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7e8e48b-58b1-4150-e2c3-08da0c991029
X-MS-TrafficTypeDiagnostic: AM8PR04MB7379:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7379F607B32AB948BFDA96E2C9189@AM8PR04MB7379.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Er6RvoEIQRM3Gh4mM1pVfpVyNbPeUGbcunbA2zh+pzzvfcibz+X9SlztRIQ0w2liuyiORnp+H42ruPLEDZWulpcjbXXmDuoBmeGIUFf1kQa8SDaZmcQ6xIbRltVra8V0+QUFDb8TiqotEeWH1jxlPqYAuQDqpGzA8V2w5z2UnOT82X4etQL9GsbTArRzd522ygPbt/r0btocIzSzo05oAaIKIUhd67qBlC6gC28leYR6fle6A5vFPczeEezoqLy9LlcUWXSNVTuKZkBj6OlGyFl9A6RBow/CVpQeMtXlX/8aUC4Acl04Lv1GSBeZbvsFh7YzdLkiIwZ4ZXoAPsY6zSCABmjN6uTp2FqFOz8PIcVyC0KEAAuk/WtZMdoNtqE9ONyp0WRp07a+sMG0xnbxJdC5QMgyRjG3lX8yfzl4C4rWk/wrSpkZuO6KqAsg52N10K2PCrIScTGcGeEiOSl5GeAsNZyWg7R5OBRaR/987rpbf41LIOC61l1JVwZGZMX33WS9M99v4q93JTqmRWvG1cR+6FBzAUlmIZ5GXAvo3/uQPnBkctOzzBAxuZqWei/XshwbO6ptZq/eGAIwhBM7txQExVKYNkDO0y0jgRqpWRFtYeaMLSXBru6niz5Qeg/tFDn2ZINYqRzUp8yA7JqYXdJdcGQd58u1TcvvgVsLA0XGJgX9+V9+HPEGS7JjnseTsboT8iaYefgSTlevaHhTMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(52116002)(6506007)(4326008)(8676002)(66476007)(186003)(26005)(66556008)(2616005)(8936002)(6512007)(5660300002)(1076003)(38350700002)(66946007)(38100700002)(83380400001)(86362001)(6486002)(508600001)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TY7yhb6AvFJAqo4LBv52ygqMWO5o6mCwDa8FKq9JaA4HJCJQmyBdFs3SuwAq?=
 =?us-ascii?Q?jXROv1uHOI+adqVcwCjeY2y4Rl/kYNnWOxmotih11DUuF1ozuXrO1qUHDjwm?=
 =?us-ascii?Q?bxgiqGEbXY2zpS2zHxshhm4dCCIk2eD/t1BDq8blpNgeUOyFr6fTAHO+bcyu?=
 =?us-ascii?Q?a8nzYkMkwas75P3LOuGdbjsDYaRzUzFYDqrLffXnBRtohUZFCAQspzAddeGk?=
 =?us-ascii?Q?Oea0xQQ7r9epUn6Id79DcJ5RDjlDpaleIDiJlamlstCCUV0CLoTLmDNITKei?=
 =?us-ascii?Q?1o5oxcZ7+cTd1HJvGZQT/vHEhU5t7gQx9UiEoTuYWs9v6Zw/69JLISj5kcCw?=
 =?us-ascii?Q?DHfK29sPMt1kUs+8MeG2aXkG8VToMB1IzLQRd3trzILyRlZUeltJCbFJA3cq?=
 =?us-ascii?Q?ak0jvVmT0yaT3nI6U5PDRa35AU6m+ftOyuagQ0mMnsBFu27c1l0uHimaas7h?=
 =?us-ascii?Q?y8xffa9LUQ2+8DRAXPibIRlGjs90QZQXmf2zTpicUJNoF9td+37bxzQp1DGw?=
 =?us-ascii?Q?9hooFM81nCPs4ES4l+kQjKpGmNv3+cL9oj6+tK9WgWaktixM6dvEwrbhH7Vn?=
 =?us-ascii?Q?YhlX/jz4JQ/xR1ysSEBDU3J60blnWVj1Jwvl2GRqjh+/YK8o+LkFFob7cUD3?=
 =?us-ascii?Q?J/D7PqGZvxja5Zcuw6arM+u+Qik6qyIVLrlBLJh387Pld2WFt9XPuOf5LlZ8?=
 =?us-ascii?Q?WbYBTaeuc6I3E2YHCKc1UcnEEhxre5aZ1w3ErrLcyvweZjCMA0o3b/Udn8zf?=
 =?us-ascii?Q?uklczuBtQwvML2ZFZhxQIaUbk/M4IDsoiX/FPEFANths8ixrJ+78KONUq8o3?=
 =?us-ascii?Q?2bDzojRTNW6NA2C6GpA52Ce0PKThDEvXR4nIMLVGJfnM4FiuHf8fRfUVQ2KF?=
 =?us-ascii?Q?9Qcxj7DFR9f7pwIrMuSq36S1y2WaruIhJvy0a/dOEL/52lGy9sS2qO76xOUR?=
 =?us-ascii?Q?W3Hd24DFS+sTNv2NjQ9/OpLh3TuYbKG3ixzFm5bRTk0rj3C6HOYv0dtYD4P5?=
 =?us-ascii?Q?U5GL5ooXGXIIGt52rfjp26UTkms0eA18aSgdnF5+ZZEvqo5t8nIxPQjLXhnI?=
 =?us-ascii?Q?cdE36RqAurcV3NgwWNyrLF0inT4QxEjos/N5gbOAeQvRKjY6HEPQFHO3IJkA?=
 =?us-ascii?Q?fFWJdI0y2XFd0ztTlCb6AJe8sKvZQOOpnSnyXoNwoGoBtq/cg6Kn1S6z6IM/?=
 =?us-ascii?Q?wjxd3Yagu7TkE0UaDhI1KylIjOsMtaDams+ovkFX2qD6ooV5Adn0eQjXUGkH?=
 =?us-ascii?Q?/EqTmmn3B40O6uxg50sYKiQxA3p05fMGa4X/msBxkcDR/D/u2a1ZILCieZHa?=
 =?us-ascii?Q?jVDnAlPPgWSS+Iv5X5mPCDXlXg/kLvVYrupbznQZt+GnxLJqPKRWzolfAf5u?=
 =?us-ascii?Q?E+LKhlf0oBi8atfNGqlMqjvPIku0UAtbieMov92OZLLFb0Gib9CaJJgZAY5g?=
 =?us-ascii?Q?+LT4hkzpW9tr7VwLYH4LBiKWBGw1E0qg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e8e48b-58b1-4150-e2c3-08da0c991029
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 06:47:57.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAPk+kYNKKBfSzRT90Wl7bGoXNcVWAQfwgKx7b18DorRFyxaC6QXwHynEf6kQaIm8c/UJttibeD/yMA6mnt+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7379
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per elf specification,
p_filesz: This member gives the number of bytes in the file image of
the segment; it may be zero.
p_memsz: This member gives the number of bytes in the memory image
of the segment; it may be zero.

There is a case that i.MX DSP firmware has segment with PT_LOAD and
p_memsz/p_filesz set to zero. Such segment needs to be ignored,
otherwize rproc_da_to_va would report error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index d635d19a5aa8..cb77f9e4dc70 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -181,7 +181,14 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		bool is_iomem = false;
 		void *ptr;
 
-		if (type != PT_LOAD)
+		/*
+		 *  There is a case that with PT_LOAD type, the
+		 *  filesz = memsz = 0. If memsz = 0, rproc_da_to_va
+		 *  should return NULL ptr, then error is returned.
+		 *  So this case should be skipped from the loop.
+		 *  Add !memsz checking here.
+		 */
+		if (type != PT_LOAD || !memsz)
 			continue;
 
 		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
-- 
2.25.1

