Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0DB48A673
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347372AbiAKDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:27 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:57732
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347496AbiAKDfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:35:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOrJSz4skjb7TzNCp7rsxYHn80XhWFKV36OKyn8NcsuCmtAvkLZCqsKtBpxNtAOODrKGM5XrYmggPrCCJn5IzYK/iNE7iZlPCwnN/G6YfaOSagd5pveyM2+n+c8JxOwCqyrw8ZbMiZE5upU1zAVanZNhXYRjsXXar6wBA2ecgite703+VFJtix920UhXnOIpWaIlhIDfer4S4mLTIFBc6zeKGaDNvXM88Dy5cZhUu6E5z9F2hYOjNHJXXq52eENIAuYwaMl9ft7aO9583IvpXTyTTZ0pT0Xl8t/R3jLpFR65gQrs2cOTijvWK6QiXG6L794o8Nr7ZqdVnQwuOfQAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PP/7/i1XXOoQxI41HcjSIQHuua8EfhEAcsiTyoT+Ny8=;
 b=PWysVUgOrjmEQNa/tAuuagft5mpdVFbfFIAu85m0UgkvPepV1hMtoF3nI1ghStdGLnKsKmRUicYuzkItaFANMjx4BGNOKhKqxYeACL74gaAskPheOM6PBfxzSmbQJptMv6hN5dfSahsNqm4poGyHmFD49HNS3qktU8Ha1tzL+fsWcX0C4+8IMtXFlC2CX9uasfC5G9j9W4wUgE9yBa8OygY9Zir+Wf71y/qMj4WMT1Mju14aPjavRXn6x5OWLp3JgTBZ1DTy8RcyujWlum/u2gxgn70FbIeS+7w3bXHEcTSDMrJPKmbIRW+lVXJnqdpNuM/3gxtTEs+BxfFv0We4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP/7/i1XXOoQxI41HcjSIQHuua8EfhEAcsiTyoT+Ny8=;
 b=BLihbl2tuDjSZ0R+NEmxMgyTaAgu65t38Zr7mvghTpc6y6WPWy9uH/AMaSalWW1pldWZlt41xFK78138CcZqX0X4mztEW8Rf7APUBKLFFVqxukpHgvd1GhjaHsY0WOORq6hoIu+ED8JQNNRAf211TZRHkRPs+JkYd624A8RXP8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/9] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Tue, 11 Jan 2022 11:33:30 +0800
Message-Id: <20220111033333.403448-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111033333.403448-1-peng.fan@oss.nxp.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8b6d64-1424-471b-545d-08d9d4b357be
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8725B671E1B0FD7E577BB858C9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3urP67l09sd8JMhwVW+Vy00q+1mVfsPNeOkbIe6QcSeaVZuwFmAgmK0KPBkn8ctmoSMroQWda0clkbsNdgyfCF2m/G4h6ek4n2imnG5DF7vLynHEs406LtlpmSplk1ykvmALZDYdZT294XJB2188SeriiyMNhW2tsi11y8u9i/HmegDPLS/FGo5F+6zDynbvrh9R2/yDQ+n0DtIaovPLHF2JP3mlfZKxnnl2vf7mFzCkzEWLgxqrgHuEE6mcq3ot0qHjhU/kGWkjZ/Hro4peC9iuTYpTV6em3XYzrqk0qQVmRfO0uj6H/zzV86RCppmFQ+l/sJYaFQjm7AJfUR/UB9fA9Z3N7kuJUotwAryVFwvOriHbFff7PoG6Wpv/FMyPkWSeo/HV809MU6n2JhnUQTh6tQnRL47DLvqGm8bvCSXWu4jSYjRISFyJkKaVQlTwmX1eABmBCTcYvEWh+uIcvI032RrH0oCbCgDJGluTMlOtPvkwI7UIWc7JiPELVFULB7btH3PNb6+HWdbsHut2zL+zEJAtLXako8r/29huizVVis7GbUcoq13RGBiCCHf2FjpNjupSMjAUOoUAXddPbWWu78D5wZgEJucJHZtw1+zRJfVp3BkG/1pitELWKCCL7dwRVx4BBzF+i1Il2GYbllKK49edOA16Dv1twKw9IJmSrqmVLvcADxBR+1XwDhAF+7GUM9t8b/68wRS7ShVwxpUNBlIHdpkRYAuGXZM2GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sls29Cu3SlphXr72HbOwPncZx/nV4YVeRa1cytvgRVxorK72pWwPFdFkom6a?=
 =?us-ascii?Q?SMGjWYUx5LUDkzExrmBVFzCCs9a/Me+UV3bosGEY4UVFK2IC/I1zdQY1eWs1?=
 =?us-ascii?Q?w8P7LTqgeXmmf18E2HsAEHUqn+yEupRov3qGo51GTMt3huB4tsjP75r3+7nI?=
 =?us-ascii?Q?LyJDOq1pps3AM2jtHu9VU/Z9XFUu7+QeXOQ9TRupPnC31mliI9pqltkl4iyA?=
 =?us-ascii?Q?r+rEwuUln1R3WaFmK8ePVbrF0yUPFKWeHDBZ9HwTVAPKxfFNVOkGvXG6Gx5m?=
 =?us-ascii?Q?3llDjhkcLKMryosMbhtwAtLnAjPYSd318nlrHidDIxfy+n7I4v82O+pCl1oH?=
 =?us-ascii?Q?BecXvHZ2DogQBCxs8Cme+7ru56aGAbnF9R2CRx6ZRpijZVd4H9zrbeKDqiLy?=
 =?us-ascii?Q?XXikLjQk2cIld1rmpDWmqZ2ESOPfvr0aunL/fFak/MU6psaKDAgczUbr5FPX?=
 =?us-ascii?Q?PGpiA9BB5IL9BRehGIfWSzDq0ZVuEDMgj7ruAncuVl3mqK5Zv14ch5djUN2F?=
 =?us-ascii?Q?biwem75JFYqd4DCWP+HLIkyS5iUGNcYSkTGhmY3IuL4syjZROwiEt1/P47zH?=
 =?us-ascii?Q?P9rmV/03IngzVej1AOgUX0Hsu2NViQXTOqG+PV5AuEDi8ZA5aAzL48ys0oHF?=
 =?us-ascii?Q?erbvfIdMDGG4AUZH9W+Pr5kHwei6MIL3RnTMCRQtEDuEJEp+DB7ba8Ea6uZp?=
 =?us-ascii?Q?GmBl93DtyZThlRqYyEFR/FBTAu35yntgsMZAo1L/fCZ0UsxNoB+snD6ti8jq?=
 =?us-ascii?Q?Iua+GpLs7OhZpgg8drt78iJcISjQBUHZ44cU2PoA2uOGRvzwATh3hSAc0SfF?=
 =?us-ascii?Q?F4ITQZWYYjlXIX79W6hmd0P2q0edZrIPVoPdOJGs1ETZfY6AsAonSjHtGhTV?=
 =?us-ascii?Q?+Lk7BE2n9JQ3sMt/aMi499JTAaZEe/l9aqRWGOE48LoNglTYUnJ+CWFwiKis?=
 =?us-ascii?Q?x0JO3QniHdoEQl0rxBO68KeFhoVAvMhBzjEmSzfOb2yjh+sUWC+RsLdTlGy4?=
 =?us-ascii?Q?bRuZXRb8hkZ0+w1WMQPgVh3pwU3WM7FeKub6HPrUV95PXgzy7gsfsYbX00Q+?=
 =?us-ascii?Q?rN69tGuVnmV7ATCNFLqo9frEHuBsChwcQastjTcQJcxa6atMuxCtkF2n2w5m?=
 =?us-ascii?Q?5xi+OHpsKgo87RnNCi5N8maY+CzRyw4v6LSbUp70WTMTxEt06rHkn/D+Z2zz?=
 =?us-ascii?Q?9gMjcbxvhNKnX1M7ubnlECijbPmiligJr5OlIE6RjqVnsJ3ErlX+nQV61B8J?=
 =?us-ascii?Q?e29uDFmjYhxdzc3rHL1OJm9cA4BQA0YBLrmV8Q65vr37bD0cTAx7VNb8Ja3O?=
 =?us-ascii?Q?I1A2ezJMS4SpAmzHfZYygg2yGxUkgJWWMVA5hdpfBSrGQ8Uljd0ULEzSfZJ1?=
 =?us-ascii?Q?p/pgeOm3TnvUMp8iBlLDi34y6uzm/VpZQ/5AUMhkEpuQiuNrTk39UomsBQNj?=
 =?us-ascii?Q?++LqVdNz57Nezs/fOv9CvtgKbvfK4tH/7pTIu5atrQunfcDa8PnBEZ81jCmn?=
 =?us-ascii?Q?rOcMA3pXkdnFy3Ap91wCKYzhnC0j2o3Wye+Sr+vQwaFOUxxkb20xfR+leCiY?=
 =?us-ascii?Q?bnhiW5psm8y97SOszAQZeOLINj5/rCkxpMj+cwzzgPFDoPmsyZc7YhhfOnFJ?=
 =?us-ascii?Q?3v5tTSjR8tJxa01/bbvJtRc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8b6d64-1424-471b-545d-08d9d4b357be
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:58.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BGzl+0sDh7TRMKjqMYDYTlvuOItrOpLhXshQ+izePp28f3EYW/s89Kyq/VGKj/HymRPrjCUEdYCjME8TVeoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
could only do IPC with M4, it could not start, stop, update image.

When M4 crash reboot, it could notify Linux, so Linux could prepare to
reattach to M4 after M4 recovery.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 96 ++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 0e99a3ca6fbc..5f04aea2f6a1 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -6,6 +6,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
@@ -59,6 +60,8 @@
 #define IMX_SIP_RPROC_STARTED		0x01
 #define IMX_SIP_RPROC_STOP		0x02
 
+#define	IMX_SC_IRQ_GROUP_REBOOTED	5
+
 /**
  * struct imx_rproc_mem - slim internal memory structure
  * @cpu_addr: MPU virtual address of the memory region
@@ -90,6 +93,23 @@ struct imx_rproc {
 	struct workqueue_struct		*workqueue;
 	void __iomem			*rsc_table;
 	bool				has_clk;
+	struct imx_sc_ipc		*ipc_handle;
+	struct notifier_block		proc_nb;
+	u32				rproc_pt;
+	u32				rsrc;
+};
+
+static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	{ 0x08000000, 0x08000000, 0x10000000, 0},
+	/* TCML/U */
+	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
+	/* OCRAM(Low 96KB) */
+	{ 0x21000000, 0x00100000, 0x00018000, 0},
+	/* OCRAM */
+	{ 0x21100000, 0x00100000, 0x00040000, 0},
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
@@ -236,6 +256,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
 	.method		= IMX_RPROC_NONE,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
+	.att		= imx_rproc_att_imx8qxp,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
+	.method		= IMX_RPROC_SCU_API,
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx7ulp = {
 	.att		= imx_rproc_att_imx7ulp,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx7ulp),
@@ -491,6 +517,11 @@ static int imx_rproc_attach(struct rproc *rproc)
 	return 0;
 }
 
+static int imx_rproc_detach(struct rproc *rproc)
+{
+	return 0;
+}
+
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 {
 	struct imx_rproc *priv = rproc->priv;
@@ -525,6 +556,7 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
+	.detach		= imx_rproc_detach,
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.kick		= imx_rproc_kick,
@@ -671,6 +703,22 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 	mbox_free_channel(priv->rx_ch);
 }
 
+static int imx_rproc_partition_notify(struct notifier_block *nb,
+				      unsigned long event, void *group)
+{
+	struct imx_rproc *priv = container_of(nb, struct imx_rproc, proc_nb);
+
+	/* Ignore other irqs */
+	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
+		return 0;
+
+	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
+
+	pr_info("Patition%d reset!\n", priv->rproc_pt);
+
+	return 0;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -680,6 +728,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 	struct arm_smccc_res res;
 	int ret;
 	u32 val;
+	u8 pt;
 
 	switch (dcfg->method) {
 	case IMX_RPROC_NONE:
@@ -690,6 +739,52 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		if (res.a0)
 			priv->rproc->state = RPROC_DETACHED;
 		return 0;
+	case IMX_RPROC_SCU_API:
+		ret = imx_scu_get_handle(&priv->ipc_handle);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32(dev->of_node, "rsrc-id", &priv->rsrc);
+		if (ret) {
+			dev_err(dev, "no rsrc-id\n");
+			return ret;
+		}
+
+		/*
+		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
+		 * and Linux could only do IPC with Mcore and nothing else.
+		 */
+		if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc)) {
+
+			priv->has_clk = false;
+			priv->rproc->self_recovery = true;
+			priv->rproc->state = RPROC_DETACHED;
+
+			/* Get partition id and enable irq in SCFW */
+			ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc, &pt);
+			if (ret) {
+				dev_err(dev, "not able to get resource owner\n");
+				return ret;
+			}
+
+			priv->rproc_pt = pt;
+			priv->proc_nb.notifier_call = imx_rproc_partition_notify;
+
+			ret = imx_scu_irq_register_notifier(&priv->proc_nb);
+			if (ret) {
+				dev_warn(dev, "register scu notifier failed.\n");
+				return ret;
+			}
+
+			ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
+						       BIT(priv->rproc_pt), true);
+			if (ret) {
+				imx_scu_irq_unregister_notifier(&priv->proc_nb);
+				dev_warn(dev, "Enable irq failed.\n");
+				return ret;
+			}
+		}
+
+		return 0;
 	default:
 		break;
 	}
@@ -847,6 +942,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
+	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{},
 };
-- 
2.25.1

