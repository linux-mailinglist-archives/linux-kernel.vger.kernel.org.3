Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0F34ADBDC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379388AbiBHPAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379110AbiBHO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:45 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30042.outbound.protection.outlook.com [40.107.3.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347EC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3OTk3X/Ol+i+yhjgkS0fO//41Boswx+sheh0IhuvNnYraNt94baVYj5KEcxLLysdcXFGaJDpnSOxVLqBojoa9Of7TepsOt2DbQClNWGSNdB+5nQh0ZIImqxXi4QmsE03G7ovsy+dpE5kHniTuqKOkRX+KLrCAYYvGpXTRk71R74tuPxkTzO3kjzv9xzNBizKABWswoC6LaDdj9NBXT/YpwQe3fLr8m8lp20on7DJbCbB+7xnslt8pDStAG89G3/ZLOvd6qT+oSAfnGzCd8NnuWMPCgHdf7hGt7ENN5RMBpPuaMjMxcs9gMCSUTrUfFkRwiXaaX+wWUeBtviSQSlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3+UUk7P/HeWsYRBBgClihoYA38mPviFCIkotfl5XKc=;
 b=CQAqaNhwpaeEdC6osb+r8sRVtfFoaNZiPcKPok+AJCWReIvxqpf2a1+GpV7yUdfkgvUYSsHIGRQhNpnSFmBDHiJbO0PUYFo2GOXeA3fh1gq0hsVZdLFDojEaBjyP9YtYcYrAx+hXi3WkQHaCKzbbo3bdwwcDP89rlSYVMxObBnhTknGEAHch2iDKfwKPMq+RCObyh+2VSxfnmDm9GYS9FL2wztAOGWyI3rSKrZ9h6x0hj31jcTGcRrpAbgZGqtRD5rBPUCKsODBF+0qglVF+Q/gbQ0PfyMqR18fQVw2Oej5ZYpcx/Jhy+Wg8ZZN3Y4hvoVyx3vbOpS8MDeYMTGLzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3+UUk7P/HeWsYRBBgClihoYA38mPviFCIkotfl5XKc=;
 b=NW53n2gGlSH95WjCKktBE+sicJBmgFl1J/Fpdj/fJXaykGrVxiQu/Dqici4K83zU+1vlCRgkEIPWJ77D/+5UKWq5Pbk8bEXJrcovC5vjO9z+Vt/gQRzVS3iofIuEoP9tir52JciJ40Mx50cx5AHJBZxy34Cg0haGiPMqLMHyrtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by HE1PR04MB3018.eurprd04.prod.outlook.com (2603:10a6:7:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 14:59:42 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:59:42 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 4/6] bus: fsl-mc: check for null irq array
Date:   Tue,  8 Feb 2022 16:59:26 +0200
Message-Id: <20220208145928.12468-5-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcd9d908-8bb8-4a7f-dcc9-08d9eb13a2ff
X-MS-TrafficTypeDiagnostic: HE1PR04MB3018:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB3018E52A564A101B87263814EC2D9@HE1PR04MB3018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yG6LTDfYWvugyU3jGCNrxKjuGaAyIC2XzrttiPrf1qR2+eofuyHRbcjc/IshY9iuO/45UHHM+TizQEyjREl02rjpMzVaB8MP1Q4Z+OD8SmLeLTJJcld98f67AhOSH6ATC1EHccgGxi88B9WEpcO6EnrFrm2vE0YMO+cAgC548kN/9NS7DjlSr17kwY+nXYDg+N8LZOeVZkbxRqHOP30w/P2uMFv43co7rgt46zuq61qGxG7mSDEZ/gAuGiBuP4N190xcXeMDwpcPoM9Qzj05nTE8LslHKzaxZld5xVgPn70ikbJQrSLoJr3YBmK0NonRFrV5tP7LJ0KODgIt6TFEnDp618SINZ541wH7pdc0j0tPaAXp4NlH6buGRjrpr/igp+1UCKv1oaDvPwB/LRGAkqNLsC3VC1g9L5ew+HsCQWSGHFHuIEccbnNQNAhCieatwAjgn1dN7Z5o5bGh13zDFaloa+vg5S3RfHYOOBgEoTFiITP1MFqDpqO4SdCa8+10B5ATUVvM/LBORVyDja98kvPGYzSVZvFnE26uPHtSY32voWl4fL8UE1TewEUsa9li4QcF9g6EO7O9dUzoDeylVi0UwxMoXeDRzdmNeuSlmWzV8Yuiz/r2GQwmVSGyH7EUusmPSw5mTKtHPOcBhA7RXEkqa2TmKP6QhGV/omPVMjnbK5TV2/KdrfHDnYld/juI977WYY1l/hgZZOEcI/cdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6666004)(66476007)(316002)(9686003)(66556008)(508600001)(52116002)(4744005)(186003)(6506007)(2906002)(6512007)(1076003)(26005)(5660300002)(6486002)(8676002)(66946007)(4326008)(86362001)(36756003)(83380400001)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XpURDw7C0KEm6/9YuKzx3rW+ZYooivs7K3WiE20AgGqpc0CgyitpLE2Osgt?=
 =?us-ascii?Q?cxWKHb0SjIRgXh/998nV5hCeXAjUfNS52E44kpr2Pgf2MEoLtOjdVoRl+5j5?=
 =?us-ascii?Q?pvinVx4PUlTan+HmY+3KnWUJky7umbKcdVrV6wwzVaF+fUQIKNxD8H7A7P7F?=
 =?us-ascii?Q?/2Gnpb1TdMTt6XfOV0ZQgzXVdmuSbIopPhpigzq0sLV3WSS1hxSujzwz+ktW?=
 =?us-ascii?Q?OZQIn5WnYYKH/GFYyXOihY1ph2q/W+1SfPoR/LyZ0IOphCMmM+A9bFWajoht?=
 =?us-ascii?Q?QvD2ymlefRkQS3fmPqMOs80Eo3dzxNoYvwzo4EnLGSGf605xodEjSRPMrvUq?=
 =?us-ascii?Q?N6PkXb/G39gh0jB2vgLRzhpnztyI8Ij3viiRqKSRfrNPhljjNXzeWWzwSIZA?=
 =?us-ascii?Q?kk5vBx7WCahkPPZeVJdEHpybhfdqZnlMuhe1VcJ8fyAUB3d2kwwQ+LFNQuAq?=
 =?us-ascii?Q?2IXnOMUpJGgfHDMwJx7VSMbEvvkZKh+cjrxz7sgGpQ81Nt7bFAhsFv0HBDz/?=
 =?us-ascii?Q?zC/TxISunoO3AedFUdknf0Vsk5IPGTs5/NXOCF0jb45dj2AlHGJxTgvhe5rd?=
 =?us-ascii?Q?afYdGQQmdVFrw8WS7wLG+lkBt69+4226NgfOwUliMFIu6Qnmobmp9urFgN0y?=
 =?us-ascii?Q?bpgwy+W8vtTFmpR7QMqbi239OrKyeHy2WblPiYyYF42346rug85GfV5ZQLfV?=
 =?us-ascii?Q?R/WY9ZpbPWvFglm9xIGwsO3FLHQ9MEO24hUvMm1Z/aQg/B8fNTYTjOwGgOtx?=
 =?us-ascii?Q?PzR2vozJfuuwglAiaCXXSRVn4S+UFQ1JKLuGk9XOGMt9QLvNHv5nrP3EjtTf?=
 =?us-ascii?Q?WvSt9fndvRtcSFN91xzxx4DnTWHMZ/ngqhv8tu9qNuJJp105Y2UEF/8shGti?=
 =?us-ascii?Q?aI4NPuqc97eKVZQNZF7ekuNJwI3qe0GPjWTfn9UCKV5axhBCnS7Z3I629JEk?=
 =?us-ascii?Q?F2zW+Khh83G4S/X55tBzdpu61mYme2n2i1VyMyi86yyU9r2hSoEGw0Yf3ocv?=
 =?us-ascii?Q?UZ1wOcGNMviL0c+qFK7j5sz+5jcjmFXCQj8MNVp9fxIrgOkRzKJIgt+uPSXD?=
 =?us-ascii?Q?rM+vc1asuPH0jD+/nWDcxF71UjNjP5R11V/YNItqpZnykSgUjRcR8pzwet9o?=
 =?us-ascii?Q?E+uceXfAxsANb2k9hMvgJWVZ1uYML3464syibzaQvfoUhXdNlu/zE8h6n/Tk?=
 =?us-ascii?Q?4j9d678dM8LcxJ6iLN7gmJDSiogu9MnocxouhxtQXi85gYQZDjlW46wXUSpz?=
 =?us-ascii?Q?gnPebbbqSLcTr1fBzKGfbfQAEpG7EcUk1yTCAEHv3kWgv++Xt1vD3PcjbrJf?=
 =?us-ascii?Q?xMZaw2hZH5pgNpLmajdBpWZSV1Txjn2yE7EumSeOHsY5Rc3AGLYTFRppMxxl?=
 =?us-ascii?Q?JN0FkgXT2rsG+7LY9GVMX8IE8tD7zjsEaLmhvmgOo2w5B3IqqG2l7QamKSFI?=
 =?us-ascii?Q?m4GI3DeiuLvoHvjBFRu0WZHvYwVo/RCeV4I5PmA74xuqM9ogfuHMuXw9TdMG?=
 =?us-ascii?Q?nRKbAsiK8oBJ9WgwvD0ssGL90tfb82sM729gemMYaEw3UF6RYO+z4xl9oHuY?=
 =?us-ascii?Q?lpjBPEm/QwOemlMI2DoB+HUTR8XHe+dXX/N2Sbp1LDAUDzYx8g7RZigbanEv?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd9d908-8bb8-4a7f-dcc9-08d9eb13a2ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:59:42.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQDPiXpdRoWDE2SZQpUSyl7+jo+J9rXq6wzRBQt/vSh7mcSGgDn2BGOcCKZd5e538DveANctoHlGBPiPowrbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

In VFIO case, the irq array in the fsl_mc device is not initialized,
so given that in upcoming patches this code will also get called by
VFIO add a check for null in the irq teardown function.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 36681cf7c42e..8482c4fca835 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -767,7 +767,12 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
  */
 static void dprc_teardown_irq(struct fsl_mc_device *mc_dev)
 {
-	struct fsl_mc_device_irq *irq = mc_dev->irqs[0];
+	struct fsl_mc_device_irq *irq;
+
+	if (!mc_dev->irqs)
+		return;
+
+	irq = mc_dev->irqs[0];
 
 	(void)disable_dprc_irq(mc_dev);
 
-- 
2.17.1

