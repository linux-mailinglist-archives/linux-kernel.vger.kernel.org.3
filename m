Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7A47FACB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhL0Htb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:49:31 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:15936
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235519AbhL0Ht0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:49:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq0zS6cLwpi4/xMGu3LDEZOSjSLsl0N+QVLvbmVtKnKrd1tJYO+6NVMyX+M9T6aeZqiwBevVaM8LjexK9gbaNOT6c1gBjwgjMkHeQC+BmBspIyQZmMg7lpqqnYRUpr9cKOXbMhq428tDBavrDf/TBHMLOMeB1HhWemtkrDB5QeKHtl9klph9DwOngRDQRPk0zj1YRL+OB0DtAe6/RXbmq+AjPZ2HyXP28vCdrzqwnt6x+grpRIlIH3pw5LX99IH51NCLJ4FfjVwPTDScvAYdgMZXX/S4DRtPmyB3eCw66Sqgez1CGkxf6wwP5+0wR5wdUGJteqCuQQXCt+mgjz69lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUfVU8ZlO1kArJwBMnFVhJEZ/Nog01cUdi63xgM03LM=;
 b=cJLIumQPiMZKWyoH6wmywf+VsynxiQ6VAI1vdO6wka/y3OTygsVE9dM7cghwZ8GtRvihWi0nQYwZyTbjgN++NJjp5CK2UOotpoGQdgKvFVKrNzVPYkF5dSy1oMwH4++hwRic1P5bfCpUUF4JcYpE3Q85Ku+bwavWq1b624FOrnvGLGzBWA+by/hziQHweXHQplU/vTHIf+J5WBsYoKGFbbRpAO2NB1r81n2GuRDwze4XKR8rpGadNdr/r7qN1VfsxEFIaYiNCT1EyuGqszBCjuk7iw9UwcNJVjTssayryRQEAIB5cRbVNBfBgqzGLGfpwER8TsJND68fIafna/JyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUfVU8ZlO1kArJwBMnFVhJEZ/Nog01cUdi63xgM03LM=;
 b=dOioepdAZYOyKXixHaUjPrpEgjC0dFnCTLdqi7cYuyVIUSun1iLHp0Sz86sVstv27dqA9JYW9IhgDOwevcoZ9BCStRFwf11jAXHoMdcG3MYdyoyNF3OIsoFj2Yve4kWR/Z9fOStQ6Dejp2SdYkygeJsWZfWJd6psBRZHaUUadwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com (2603:10a6:803:dd::27)
 by VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 07:49:23 +0000
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748]) by VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:49:23 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/8] i3c: master: svc: separate err, fifo and disable interrupt of reset function
Date:   Mon, 27 Dec 2021 15:45:24 +0800
Message-Id: <20211227074529.1660398-4-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To VI1PR04MB5631.eurprd04.prod.outlook.com
 (2603:10a6:803:dd::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0fad1f3-5cac-4420-fc1f-08d9c90d6632
X-MS-TrafficTypeDiagnostic: VI1PR04MB5629:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5629BC9640F78359006A3BBBF3429@VI1PR04MB5629.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWhFOpj7Ho0j/VkGoXxJf18/P9F1WERRFY3qY3ShXvLV3DVFptNkOitzdXc2MkvAb9YTIPYQxeCgRchdUw/NMQAtYM3cvRiGxn8bhgHQS0qUZ1LjzYqB2mxV2Qq8/6bNfoy9HcL7hEu/MtPTCxdmZVsh19hK7vY3pXHJ2YmabXtYqyhaURNCJrhG0f5JCkMmzQhhFNPrL7NeA/5n7PfRoNvSWhaNxo9Q74nCQleOkfDxsvwPGsepNaQXdsgm6nNpMOXdi+5aUyFDVwU8eEH7VHXk9dEYFkO91AxWD8RYy7R4UF+8tACgULIymmKcuTCD0gfp2dkXep8KnBnzFxIf9rycBADM65Z8VruQ+WDYh1UzYcR9F8Pi2HhzL8dKs4TAE6r1xKAER6egnChWJbnpDQb6nOOKlQnURPEt+8oYY4Ijp5RPZCUWw2SdgGMBdxRAvgAbakd00HjD6FNKDR3ylJZdtmhUBXdX+ZxpYf7oaOPz68re4G+dmQJ+DmW2Qy8ICzOb/SDG7Wm6DrnrU6QHXJ0uPbe25YqchYPVfQ5otccvG2hWFKafUtZpONH8vR828QNyRy6OQF+wN0Vekj/4odHteCrwA0o4YsEBIp1q2RYPwkj9hK+FQicYQ6tSge+WmyHYRTVAzZOSwwbSXAXSOQlVWAALjBVcTeVKA0s8nBXRFJZAf1Xo2dR+KLDlD+ZxCyJWte0/uFIdlyhHRjT1Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5631.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(2906002)(6916009)(83380400001)(86362001)(36756003)(66556008)(6486002)(66476007)(66946007)(8936002)(52116002)(4326008)(38350700002)(38100700002)(2616005)(186003)(508600001)(8676002)(6512007)(1076003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BHqXBnXz9cEHZLDpohxSedwFWHP7cwZFm+6ETDeEnQPSFxjT94nhAc31b4eU?=
 =?us-ascii?Q?GFcju7919M8RS63+u2bHthXR9IZVkQQm58JbzpE8ZbDFilaTN43As3/Jo2Wk?=
 =?us-ascii?Q?n+XlyhkVR3odATOhTDoDHCMpspwUd2lIsmyFqiNnienRKhBSmcVj0Cyz4T3N?=
 =?us-ascii?Q?Xv/F5+y7EOLpVoP+0MEA8g/nhj+Jhou9XweXT6GmnOp3dRJqvKCsZCgIb5hL?=
 =?us-ascii?Q?6KBmkdyNuyZxrnNk2HImlmt/gyEUZp9wXdMANAUkvuEWhVUg+U9IvaACnZSZ?=
 =?us-ascii?Q?4Nn+EyniRoF7bpDGeXy8TZSaD1wsH16Z1NqebpEQFv5vQLiMGfdDdxWUgWKZ?=
 =?us-ascii?Q?Xlpg9CsUW+jaIl3gQ1BlPdOq+LI0xR/rWrk1zuPlB8yAYVPtakvo0l39aJo+?=
 =?us-ascii?Q?NDXdJYq4jrv51RIoqIr0Vhi2L6U+Sdo357oI8sJE4IlsVrd5PSA6HbcAdR28?=
 =?us-ascii?Q?LeQbHtg965APPMuTL4dDVZ95s49YTrsbKzhMainMwHMj77yCSxBpwKFdfNcl?=
 =?us-ascii?Q?VTj+QQ1DFf6T9z8uuzFjM8n/kjxeCQN+UAmt2aeIoOV/Cg24YFhnP1B8uQyX?=
 =?us-ascii?Q?PW346x3bGQKMv30B/70UR4iwmIiZ/YFDAqVOSSK9/f04n/4RgI7nZU2SF7jF?=
 =?us-ascii?Q?uzb6ph6MxnLlbthFACHd2JZUQ5fks4oQ90qrPJd7U1tpUaKmQJlR1SA6yhF7?=
 =?us-ascii?Q?yQhiPy8t7i5NeHcpcwhs2d9LxVzANaWsc8jYebLvaxGuD4JoZ4dMK68xFKS5?=
 =?us-ascii?Q?5mkwQtQnbaHtbPwTKx8ZysKsFxDRLYOrN98yIkKvq1Z63oEoOVGylOTzMpJB?=
 =?us-ascii?Q?OPgBlbzis7om/pJYMsMSnZPD+LiCRwDAUoxiyBWRy7y4rh2AdnjWURReioA5?=
 =?us-ascii?Q?qg1QiN/fAOfYxqHD+FWMi5Ime03zn4pm3ylNCHqqHt3uAdU0TgooPjQhj512?=
 =?us-ascii?Q?xP4V/vRzDJwaKSjKQBq8RtfQA8dIPmFaLJ0imFl8fLGlildgfBpomc1oA9Hi?=
 =?us-ascii?Q?i+GGemDzz9P/w6RPn8SewXhnMzKR1RCCH9Ez82iRbjoGMmagg4PP+R5ANIj8?=
 =?us-ascii?Q?NP7Ggz1J/K9vY3fVVnfz+GgqOU2xfWOm385UKkeRmDckBKBwGk/vtSbDcTWI?=
 =?us-ascii?Q?ECljoz9zKCHiU11YZ/E8hsp64iZr30qM2wRMyLff6BVT2crzHHv+DoHZZBCH?=
 =?us-ascii?Q?YbKLi2oIudeUmPZBICdoR1Dt+M7wxQnlBNB4IF0y0gkDwaX/LALH2eQXHrsy?=
 =?us-ascii?Q?DiFytxQrUqsjdzPdCwtmg1D3Pv3HwJtDfJgSBWsSAKBTrQNH7Dn2p6mXw223?=
 =?us-ascii?Q?h95WUp2+ctjf32c7fKrmqVj7HQFtPHm5Qs0fIi+yGlbMJUdFGmfgU+sPHoTH?=
 =?us-ascii?Q?4nnPQdVJ/9u5aXJnCsm9WRz4ji5Z4+zTQii3VXseJOmHQY17m9axoVL3JBHy?=
 =?us-ascii?Q?O9p9k8e2mJxe27Z4BGayOfDN5oCahTY7Ph4l3nohrP+dEs7k/Xvzd4WgZnEM?=
 =?us-ascii?Q?tLgEalXa0Tl1QLyyt1q6Ih5XTvQn5SzAf79KiTTozmGc3kezPAe7s+b4paZ4?=
 =?us-ascii?Q?GEO88cQExIz66DzHsgdSCn3TlHNOtt9GMpJYv7Iw2IgIRcgJsHu0yCEFuOE6?=
 =?us-ascii?Q?9R33DxxlOoSaH8FKgxSBDUs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fad1f3-5cac-4420-fc1f-08d9c90d6632
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5631.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:49:23.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5s0oqZXuM1DJA9NOCowG5JyHBz7Z4/j6QjdFjW2GsW+lMNz+yPEuhveHSBtL+ex4g2j6ARXus/VqFlig/XMQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5629
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes only need to reset err and fifo regs, so split the origin
reset function to three functions.
Put them at the top of the file, to let more functions can call them.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V5:
 - add Miquel's reviewed tag
---
 drivers/i3c/master/svc-i3c-master.c | 59 +++++++++++++++++------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 47c02a60cf62..4e69c691253d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -236,6 +236,40 @@ static void svc_i3c_master_disable_interrupts(struct svc_i3c_master *master)
 	writel(mask, master->regs + SVC_I3C_MINTCLR);
 }
 
+static void svc_i3c_master_clear_merrwarn(struct svc_i3c_master *master)
+{
+	/* Clear pending warnings */
+	writel(readl(master->regs + SVC_I3C_MERRWARN),
+	       master->regs + SVC_I3C_MERRWARN);
+}
+
+static void svc_i3c_master_flush_fifo(struct svc_i3c_master *master)
+{
+	/* Flush FIFOs */
+	writel(SVC_I3C_MDATACTRL_FLUSHTB | SVC_I3C_MDATACTRL_FLUSHRB,
+	       master->regs + SVC_I3C_MDATACTRL);
+}
+
+static void svc_i3c_master_reset_fifo_trigger(struct svc_i3c_master *master)
+{
+	u32 reg;
+
+	/* Set RX and TX tigger levels, flush FIFOs */
+	reg = SVC_I3C_MDATACTRL_FLUSHTB |
+	      SVC_I3C_MDATACTRL_FLUSHRB |
+	      SVC_I3C_MDATACTRL_UNLOCK_TRIG |
+	      SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL |
+	      SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY;
+	writel(reg, master->regs + SVC_I3C_MDATACTRL);
+}
+
+static void svc_i3c_master_reset(struct svc_i3c_master *master)
+{
+	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_reset_fifo_trigger(master);
+	svc_i3c_master_disable_interrupts(master);
+}
+
 static inline struct svc_i3c_master *
 to_svc_i3c_master(struct i3c_master_controller *master)
 {
@@ -279,12 +313,6 @@ static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 	udelay(1);
 }
 
-static void svc_i3c_master_clear_merrwarn(struct svc_i3c_master *master)
-{
-	writel(readl(master->regs + SVC_I3C_MERRWARN),
-	       master->regs + SVC_I3C_MERRWARN);
-}
-
 static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 				     struct i3c_dev_desc *dev)
 {
@@ -1334,25 +1362,6 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.disable_ibi = svc_i3c_master_disable_ibi,
 };
 
-static void svc_i3c_master_reset(struct svc_i3c_master *master)
-{
-	u32 reg;
-
-	/* Clear pending warnings */
-	writel(readl(master->regs + SVC_I3C_MERRWARN),
-	       master->regs + SVC_I3C_MERRWARN);
-
-	/* Set RX and TX tigger levels, flush FIFOs */
-	reg = SVC_I3C_MDATACTRL_FLUSHTB |
-	      SVC_I3C_MDATACTRL_FLUSHRB |
-	      SVC_I3C_MDATACTRL_UNLOCK_TRIG |
-	      SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL |
-	      SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY;
-	writel(reg, master->regs + SVC_I3C_MDATACTRL);
-
-	svc_i3c_master_disable_interrupts(master);
-}
-
 static int svc_i3c_master_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.25.1

