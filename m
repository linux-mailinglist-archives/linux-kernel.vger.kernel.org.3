Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4C54C015
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbiFODTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346030AbiFODTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:19:07 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00042.outbound.protection.outlook.com [40.107.0.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670673DA4D;
        Tue, 14 Jun 2022 20:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noT3gBsEqXV5q/t5F2qTlMWvy+Lz2Gl/MVAU64NQVDGOpTl07gL1fThGMNN+rTmxgFFDs2lz95Q/w3HGU5L9b8qoHOvg1CMj3tPdP89w0VZD/gQDQs7tEXa/+S2yaQxqZ/ASP2ZsSInUMC6aEvTX/SdVjLYOA5E+m74paaR8lKsr0OQ3MyHLiIwGn2UZGtnNaYxPbDHlGtrgpObcMyLKeQJaJ8j3mNNe/Qv+wX5WnzDu71+nSUlAXD26nVbC2Pn85L2yz2WlBSISeKiixNbG5EFpIl25WPOkjKtriv+dmEVnAAVO+7Rf3f1wsV7dUlS56dycF+wq1ILPcOFv+fsatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0A3dvZmo0wb7QtLTcsiGhTA7NxPx0OfxPIUEQfQAL0=;
 b=QP/BLGExHbu+XPlnJuL/6+hvPrcnSLhkOcRv8+rDrxfY8w7r/0ODbJAaLKEo4YaDgk0tj8kZQ5F3w+r4erHT2N9VLbaBm1OtbVqOpXepi29EkeRhro5xMgA5Xhw6QkcBS4Xer/0iP8NoMmDUxcFXyGatnoBSZudxYYQCa8xzKzRVDGD6oruQe2bhiSyCDlNZ0aEKl4IViPS4m5B07qXLc0/wL2hh17zdLaXSLcLTb7oIisqUWjC7GRoSHBUDV7ezPECUti7vEnQz7I3/uJgpG5rysEpmAshlXOEdlkCwETISkL7/GovjvJ7gHXpqst/DyHHFu8YwrX9/IOfUIqnQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0A3dvZmo0wb7QtLTcsiGhTA7NxPx0OfxPIUEQfQAL0=;
 b=XFfi/h+W+AdjgXokCCCAhLeh3jH59nqwXAz/KkPjz4d/eEKfqtdzo2183zUeeObPZ/Tyf0DfWegQVcaOZJYDfIMLZ6PraRgEbS5T6PGkEg+7syBsxXbf+pcgfupRd2LsmOB4XOwLfcftCWBq0FiNo5ExwTh2Yos65RNqM2p8Vzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 03:19:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Wed, 15 Jun 2022
 03:19:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 1/2] remoteproc: introduce rproc features
Date:   Wed, 15 Jun 2022 11:20:47 +0800
Message-Id: <20220615032048.465486-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615032048.465486-1-peng.fan@oss.nxp.com>
References: <20220615032048.465486-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7154d4b7-7c2c-4cde-7b0f-08da4e7dcccc
X-MS-TrafficTypeDiagnostic: AS8PR04MB8817:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8817A99890EE87A29FC190B2C9AD9@AS8PR04MB8817.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvSNj9ogTq9Rt7x5NnHcItphPhm4kMVRXlvyMaxKuL9+n00+KfZkrVq8X1UzJGKDG2SCWnE+AcNQtTCqgdAWSoNjYQuJdF2yQDo0ejfN4Ev/yN2NoQyjR1rJGiZJQ8nLwCNAmoiSWhN49o+CMKWCvKPumKwddCMN9TNbx+NC7Byn6CtR5R5uh3krIbOUObcvnZbxZX/ov1E243aE7Iq6o+ZEWePUp0Nz+T2eW3OdMeb9uUeqkXYMF6EWTuGn27TAs5df4nKA6YSYVRbhV9zjdzoHxsbjYUsMtDABry1JT4jVAlSNfYn0Y+qHKhseiXWrX+cSeiXZ2992iWGCWKari5gtfBZ3ZeIAmZqjl8wN6GzjHIqMPMXeOcTJbv7j1EHRoHfpv6SfST58qZrc/YBiTQJXkkOuuqMnHqE+g3z1kJzCRXqU/Dn6Kizc69wgsR+95j7fUfLN6cKIFErKNYn9iW3RTxNxFflrhEwMt9bwg+iDWttIEi5n/7gKsrHCp32jEMow/GNDHofFiNcXRV0btire2ZmkEp4dlBis2sXgqROlpjJBQ5yp5uVLnP/XDE2CVLXMZcJa3pq64Pw5mhi7XoiPbgqKEr14ov/7k2u0Ot6eqyPQajLOlzL7rh/TrW/EqPp1Cb5nReOqnpZWExBiaoHBJTDFoTX854BddoplmYVf8pWzyYoSdOPut/c+DSjG6kfwrsck9xlMXBSi5hIxKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(2906002)(6666004)(86362001)(52116002)(6506007)(6512007)(38350700002)(26005)(6486002)(508600001)(8936002)(5660300002)(2616005)(1076003)(186003)(316002)(66476007)(4326008)(8676002)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KIJVXBLtdBC3wcwtyZrDPKmfAXQxFCI/EoXfJOi39e8/IJcGS+z6Y15tKaBF?=
 =?us-ascii?Q?M0XJrArSZW1cazAXqt3cTYgYVJgjb8fgXjYU38vMs1nwBkpwx3pxXby6lymE?=
 =?us-ascii?Q?aG9dWdCYjCbVRyKDzPRhgdZi/iOZRreBEIe2Fi90mRMDbY0mqTlmj1UP8xXV?=
 =?us-ascii?Q?wj3DXBE+ESoH/fwpASWrlzz932TWKv2seP7Htedf37h/8jUZDbHNpr3GAWF/?=
 =?us-ascii?Q?GlNzAm16gQjb4ZDfQFSn0tk0CM6PLcEmYIajSzfGVRfhmsqRiPVpKoXxwNBz?=
 =?us-ascii?Q?Ub7gNy/GZuIalEUrOhf/5wT02yapMUEGvgaQE7EKN24U32N6Vh6N6k1qBxQu?=
 =?us-ascii?Q?kcbZzEXMj92wyGiKUexs6YozIFB8HiCe8sOO54ibI0Vl0rlo6p2B1vnRU6K7?=
 =?us-ascii?Q?THxQ0QcXfTDRZPviZdqizArIxV+Z7fXAvNFZdeW9q72UDBvz3ec5osFZxUo+?=
 =?us-ascii?Q?GGdstMZfZoaGNQ5uAhAEITZp9iT5NSMpmcUrmKVRaTnZJx+t9CXxd0wzbfzz?=
 =?us-ascii?Q?tE1nOjzXdesZEdzJbfW01gt5Kok+QL8o2gFBbaeb9OrrIFmH7MMhBgn73Pr6?=
 =?us-ascii?Q?cZHTFOR401HtE0WqL2mDwXmZo1AsKxxWnNEmGwf/xMo0kOALcloUbA4pSx4Q?=
 =?us-ascii?Q?7ZExuxhWvRx93h36seFNDwiHUT0MjtE6YvvF67di7G7f0vpT2pcuQhgQx2d7?=
 =?us-ascii?Q?1A/ON+66Nra4UyFniBcQH81vd3BaTR/s9I1tTHKXF1Q1voihaVpmzLiUdKRs?=
 =?us-ascii?Q?13vXFesFW4fz3TJRMhviu1L4k0l8OzNxGDca4/mmsXkbBaPw4QHXZd/Fu5X0?=
 =?us-ascii?Q?Dp7oK46u52+bX0wSHwh0XfZeqsgSK2u7ayyZwrDNgNsMuo6YqD53jxrUIqhR?=
 =?us-ascii?Q?7BkVy4Yk0Vdov70/lGpSxyL2J/jAFA+3doWfF+Odj8LJ/lr8PeHNys4ANuSc?=
 =?us-ascii?Q?oRYBYTcR+OuAJ77Ppo8ZFJ36RoRNLDaCFp598lmCi0fKZwdwUXX93keazHfr?=
 =?us-ascii?Q?1M7WwJIi1NeO4e/MR9JjsYAkcM6pNNOFUtKDFJe7N/hUcKkhz1//OzNHNu72?=
 =?us-ascii?Q?ObDEt3l5ZlwseoUlLJnOQfHiBvn2xoPUVTdnJxgWonlJsR3ETjCqgo0f0Xud?=
 =?us-ascii?Q?+h4RFDBat7UsTqgSwVMwlodXewOzYe+vyH1HWw1dOBQtJzydOBuwGVscBMP0?=
 =?us-ascii?Q?6Cg00/1uI1lI6+5BnO7n6oKP+mpkDJFoGbkQPped37tFXYEu8xJr0UozZhDx?=
 =?us-ascii?Q?TuOxa4BiZwmIDD0GS1y8VuzQ7ADVk4KxF1E42ZVX+aqmRVujbpW8xShNghVI?=
 =?us-ascii?Q?JJYiAjCtaUOUb3mqnPaCStILG5dpmpubUZ2yRB/Vn1MoE9YZYNL3KLv8c6ql?=
 =?us-ascii?Q?q/aj4MEhiqvqg89wFNxmrpqKMgBD2kVvfe70B2kRC6FVuGvIFWm+K4WMCMU+?=
 =?us-ascii?Q?j0CoeIAFNB75miKvDe39J7WX7snwAgfG/QoWXrLyzH2GuWfzpCPerGRAfsDU?=
 =?us-ascii?Q?t8qi0V6lB7ghGVrin+qt7SC7RI1iJEigt46WyFnLl50HlErR5J4aJA2wRewm?=
 =?us-ascii?Q?T09AjkPVClE7gIAqNUKQlHLTrdl6HKw87hcRG5SsKqVc0viANHw+JTwvN7OS?=
 =?us-ascii?Q?MR6r0g2GMTm+mRTuQ8pChl8rnHiUjPbY1SIF09UQkWHh/S4BcKDMBjTgm66n?=
 =?us-ascii?Q?x7zSst5NDlIZvwNqAgawQMAxPXgCZnHVEXuprD2jwNnQUEJMK34+bW0yTNnL?=
 =?us-ascii?Q?gUJiBpOdWA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7154d4b7-7c2c-4cde-7b0f-08da4e7dcccc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 03:19:04.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnE4tBYRJvkbEat61NJr8d2iIExtflnQ4/HnbAvWP+h+dm9CWgNMf9Bu9pExeGKVensMHXhdws/hpZM15PdMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

remote processor may support:
 - firmware recovery with help from main processor
 - self recovery without help from main processor
 - iommu
 - etc

Introduce rproc features could simplify code to avoid adding more bool
flags

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_internal.h | 15 +++++++++++++++
 include/linux/remoteproc.h               | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 72d4d3d7d94d..82247cb5d0c2 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -24,6 +24,21 @@ struct rproc_debug_trace {
 	struct rproc_mem_entry trace_mem;
 };
 
+static inline bool rproc_has_feature(struct rproc *rproc, unsigned int feature)
+{
+	return test_bit(feature, rproc->features);
+}
+
+static inline int rproc_set_feature(struct rproc *rproc, unsigned int feature)
+{
+	if (feature >= RPROC_MAX_FEATURES)
+		return -EINVAL;
+
+	set_bit(feature, rproc->features);
+
+	return 0;
+}
+
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7c943f0a2fc4..96b65e7affda 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -489,6 +489,19 @@ struct rproc_dump_segment {
 	loff_t offset;
 };
 
+/**
+ * enum rproc_features - features supported
+ *
+ * @RPROC_FEAT_ATTACH_ON_RECOVERY: remote processor no need help from Linux
+ *                                 to recover, such as firmware loading.
+ *                                 Linux just need to attach after recovery.
+ */
+
+enum rproc_features {
+	RPROC_FEAT_ATTACH_ON_RECOVERY,
+	RPROC_MAX_FEATURES,
+};
+
 /**
  * struct rproc - represents a physical remote processor device
  * @node: list node of this rproc object
@@ -530,6 +543,7 @@ struct rproc_dump_segment {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @features: indicate remoteproc features
  */
 struct rproc {
 	struct list_head node;
@@ -570,6 +584,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
 };
 
 /**
-- 
2.25.1

