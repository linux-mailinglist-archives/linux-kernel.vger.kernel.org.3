Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50C354512A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiFIPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiFIPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:45:17 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30074.outbound.protection.outlook.com [40.107.3.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E541F2C3;
        Thu,  9 Jun 2022 08:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knFHB2M/ClDWg7QhMPQaJti1yTF/laoPVFEiTjJet/A4cTPVo9J2nJY4WhnZcfMn8LB9Io28WemvREtMqW/4Mxj2GXOgbEI9bOLhVkYVjuUl5PnChzu5Yaxo5J+Nm+MK+D5Xfy6zSfnnTeCMb0GEZDzbTSSYJNvm/DDwn62ruDp9MOBFZeXvXS6rSHDm/hTivvXpb/4qsk2b0RwVPNhq9Sq1Dx29pJ5euzjNQATt8vi/GTxTGiwNcyWsjMpoHmuWdgY08Sgcbhdc9gXWoIUr1l0lR/r28SLIFTriw5M3q/eqHS+8FZn6zurMu4DmXYVhbLw8NsvvlhMf+CvVMr07gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYpAjb+TM9OIrrCxdhhGJzyUqmE1dsT43SVibzV366g=;
 b=O+/sBF5lwqd7N1v6pRUC1mVhUqAOp5M3IHKcWfaZ3VdgoEKgrW27L51JR4v5IUU/5gWCVipQhidcmYlS9fIMFIKb77Y+YX4ebwNoxZdeDH93SoH0VanZDyvE2HquEqqlWmO88xDcALk/hASIluikwfXWUpZn76dQcbwUIB+3PWDE2G/9FCUzHnFsfU0Vq9In2eFNtgKWTXDzt08cSdngHXb0z1QffLjKq2k6smQQxBKtfbWJTcK4V1PrwYH2oAayScIlBMaFizYI1LcvkbzMpDi2Wi7Wm0ppqkhaCOsVTKO/t85nlauRnYIbb7ELpOMmSXdh/OqMqRJ4yJOfl+a5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYpAjb+TM9OIrrCxdhhGJzyUqmE1dsT43SVibzV366g=;
 b=RxlFnnCS6tJizqwiGu5LWf7MKcv/OWRrISrDbgOmV5lwEdVm8CdZuCZSnj0YMg61x7IdwFZqF2cEIsM9soVxYPKkQ42aKCU2rMiNrZ2SstUiEIqQIzwXo03JfoKygEO6JbDn6r1wWOvkiMe/46sUrDTG1GzM+ugtuufco6acnSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB9PR04MB8283.eurprd04.prod.outlook.com (2603:10a6:10:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 15:45:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Thu, 9 Jun 2022
 15:45:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lznuaa@gmail.com
Subject: [PATCH 1/1] usb: cdns3: fix random warning message when driver load
Date:   Thu,  9 Jun 2022 10:44:56 -0500
Message-Id: <20220609154456.2871672-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 535ecd82-c25c-47bb-5834-08da4a2f0af4
X-MS-TrafficTypeDiagnostic: DB9PR04MB8283:EE_
X-Microsoft-Antispam-PRVS: <DB9PR04MB82835EEB437979BCA5D0B9EA88A79@DB9PR04MB8283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heQzvuOxr0k35OH/LAMmzvUGa+vKUFsRmeCWSCUZRlIOl3J0xSQSM5M3eDxYx5tsKMxwGHp1EEN4BhecpVgcQ/IncavhO8isbqlHyfxA+IF/9Gu5yjOnGU3R5BASIXEyG1E1JlryFMDSgxsb2CO9SS3rYvTUQ1FgDm5TFMKlBVdK+er0mpYZTOBEPu1EUael8hS+IsPA5RxBoAcMeiiSaArqu2KYAdsQ9OXo79wjx1SrBzoagrbDavCuGjiIesq9kVKEYOjbK3kKRs/NCrOiScikO7vdmRo1FUiwElXooMmI+PXTeHK9WzDsKAo/f8yEFMW89j1DGr9SESXf8xUh7i1f5cen41ergeC+Gsp76JadAAESYCyxVzTtlyB0WzpLnqAymOXbh1/i8c9c1yMH9Ge+b/SLeV9R+fCHwhgrHEz9cxuzhNEgQzNMSiDoNh/nno+phxgsD5xWoBIs9roDFISvMygc/DkgFRUN0wwYD2OEZVLVPCgfuOAxapmlAndHZWRSXmbSfT60g8SbJ7H8MA4cT6vJhJKQn4E7fPhXyNXndijFt0QLHtPTtBzsAZo9j3AmfrB73PmoSgLXqkPiBUJvHMywL+oAvopNUQUBdKO0IsOb2Tu+fvAMQhXQDNk9Z/6d9D1E0svgdSt0iPKC/rTgieKcnpEW+QvbMSGLQQrpV02pFxKm+gCAtlLb5WoVaZS7Y0q3c7TVqB85WoB1GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(66556008)(38350700002)(66946007)(66476007)(36756003)(8676002)(83380400001)(1076003)(2616005)(86362001)(5660300002)(6506007)(52116002)(2906002)(508600001)(186003)(6666004)(38100700002)(8936002)(6512007)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HQt4ne9gYSLPUQLchKoE1YyxT+0F4JwDtWDvTrP0AlcpLona68aCFwMSTTex?=
 =?us-ascii?Q?/OMnPjs7xgSwFHh5GJVzeh1t1gKYZTednRtgktQ/XgjkT9b/SQVdNQcxzrMo?=
 =?us-ascii?Q?QGPU+i1ZTDbyi7PFd8lSc93gDo65XggqmOoTVdwGrsQ78KF47sAgKQB7rJEm?=
 =?us-ascii?Q?c+5z6j3cOmqxHcRVPxqjcw8emJQSD5/q2xRSLvj1lvRoUyC/EcpZ3uGU/lD8?=
 =?us-ascii?Q?mwncRCH2ayr43g5zqQBtThPIkbLymURC46os/jsjQg2uM8R+znsugim+k0yB?=
 =?us-ascii?Q?UwJEGdk2PLG3yuV5k0iA/3VVX/LY95QOH+LH04F49kBpstvc30Nlpx1UAhKE?=
 =?us-ascii?Q?j5TKcUtnksYFryXwtp56yJ/mguDfvGFWLlcTVl2jRznEqHMV3csXcJqc+UZm?=
 =?us-ascii?Q?lTFyi/FE+rC1MmeIJjskqr7uQ/IbnXfHMDWb3yvuGWgTaFngmcmK8sNltXDx?=
 =?us-ascii?Q?IuQG+xrcuGO6upAafzYnp1GGuGSN0Iu70T0r7yM0+/1SntYjN2a0niR21wFP?=
 =?us-ascii?Q?UTrSLMPPwbxIoDBpH5d36tRz3rEkpDxcebt6ClVafPsDAaQZ8h1Yidv3iZbW?=
 =?us-ascii?Q?bW0jwhFLPl94vd1Ij57KjPDEr+rSITSGc5JeMGv/BmNNGl5unkgx2DQs1v7R?=
 =?us-ascii?Q?6I5h6UHkvZIYmLgkiyAJy8tlkuGiZjvybSjRsajrVoZzM5AmnB43UKO7dFSg?=
 =?us-ascii?Q?M6mXEwZcuYz7tx75u67EssNBId3dYqDV3y30L3j2bl0oYH2FVPYYRRMBQIjm?=
 =?us-ascii?Q?wWbleOfss6Y0Q5Nnb4LgHzSeMApNQK1AyBsLSnnWQIcN9ApORLj6qkrycIrE?=
 =?us-ascii?Q?FLSW/6QTfaXHAtk0IQ9msLHMFB9FO91kV6fKsbD0oKBycQmiXJ4BvfVl/o5M?=
 =?us-ascii?Q?llCDH1pyzOzhweQKe85cL8R5RTi1pMO+D7fMuZCO7WUHKltPlfOy8XkN2w/J?=
 =?us-ascii?Q?+0tG7G5xW68gUFtfBZN+4+BTeM+FA+FJEiV6nk8qrpYErler+OOtsCUoJwwf?=
 =?us-ascii?Q?C+yTQa2iACOCVGWh9l0MtY7zYBnnTXxWAoD0XrBnmdqDz3rERL5zCcbsiRms?=
 =?us-ascii?Q?r8sZGA38U+RnDqj3yve49OzyBPl+3wcrX8HOEfhOHQwPfiB+MjKIKcns4aSi?=
 =?us-ascii?Q?5fI40fy0+9nrimM5/wNQh4uhcYu7gUQE1F828biGPf/7Vu0tcFsc0jqdnT1l?=
 =?us-ascii?Q?TvLkAwtR6pefVsOTHsi2kUThfIluDhxI29guxgG37mLksRn9OE5npEYsqe/e?=
 =?us-ascii?Q?/WbUQRDNNwmOnMGywLBZmAFmqBNuNg9PKOMsAlMbgxIWa90kBkpz4aBedkiA?=
 =?us-ascii?Q?Mhvle12xzG5LRZMibIday90GMI3dJjesebxLbWqwHcqWHilHexbE+yKnZYqo?=
 =?us-ascii?Q?E0cOkTKTgxiBsWcEjNZS7Wgo/whkyFLv1xnrfebWM3Q+mCvfzMyxa/3jh1mv?=
 =?us-ascii?Q?fr57sdpkh1tKX04wheGf98IN0mgffzgVRAXO2nf3jmooZ5vcvwItcHNOUzIh?=
 =?us-ascii?Q?nq1ZhLSPSZeYOpUCZoUJlk7jyCnBfonOmoZZJvcCWtCVj9mmtAOIadUBmrSo?=
 =?us-ascii?Q?whwBCc8thCmVmGNZenIs8qcpvtRny5H37MgarQqPp+pOa4KIYx+J0DGBMcoW?=
 =?us-ascii?Q?c5GEcwPxJUCqRL+xZLNUg0vnqaS3+zUxgYIbA2edzgj/j8fCc42kwVbYmV1V?=
 =?us-ascii?Q?m4q6wwerAxJFfO4S3qsFINvqtNPg7FNpoZX/7KoUffhq53rYsCdBWXjICgJF?=
 =?us-ascii?Q?cuSdVY8uNA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535ecd82-c25c-47bb-5834-08da4a2f0af4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 15:45:13.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek8SqIFMCvADrzzrta2Cjdbfoy55FN+cdvQUKSaP20G3ejVqfivwjxHpq9p0cJ1gfQk82IEXcGfvIpoACuXXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning log:
[    4.141392] Unexpected gfp: 0x4 (GFP_DMA32). Fixing up to gfp: 0xa20 (GFP_ATOMIC). Fix your code!
[    4.150340] CPU: 1 PID: 175 Comm: 1-0050 Not tainted 5.15.5-00039-g2fd9ae1b568c #20
[    4.158010] Hardware name: Freescale i.MX8QXP MEK (DT)
[    4.163155] Call trace:
[    4.165600]  dump_backtrace+0x0/0x1b0
[    4.169286]  show_stack+0x18/0x68
[    4.172611]  dump_stack_lvl+0x68/0x84
[    4.176286]  dump_stack+0x18/0x34
[    4.179613]  kmalloc_fix_flags+0x60/0x88
[    4.183550]  new_slab+0x334/0x370
[    4.186878]  ___slab_alloc.part.108+0x4d4/0x748
[    4.191419]  __slab_alloc.isra.109+0x30/0x78
[    4.195702]  kmem_cache_alloc+0x40c/0x420
[    4.199725]  dma_pool_alloc+0xac/0x1f8
[    4.203486]  cdns3_allocate_trb_pool+0xb4/0xd0

pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
{
	...
	page = kmalloc(sizeof(*page), mem_flags);
	page->vaddr = dma_alloc_coherent(pool->dev, pool->allocation,
					 &page->dma, mem_flags);
	...
}

kmalloc was called with mem_flags, which is passed down in
cdns3_allocate_trb_pool() and have GFP_DMA32 flags.
kmall_fix_flags() report warning.

GFP_DMA32 is not useful at all. dma_alloc_coherent() will handle
DMA memory region correctly by pool->dev. GFP_DMA32 can be removed
safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 3a3f323d9ce79..1cc53b233de7d 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -220,7 +220,7 @@ int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
 
 	if (!priv_ep->trb_pool) {
 		priv_ep->trb_pool = dma_pool_alloc(priv_dev->eps_dma_pool,
-						   GFP_DMA32 | GFP_ATOMIC,
+						   GFP_ATOMIC,
 						   &priv_ep->trb_pool_dma);
 
 		if (!priv_ep->trb_pool)
-- 
2.35.1

