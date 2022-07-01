Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F0563043
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiGAJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGAJf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:35:26 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30046.outbound.protection.outlook.com [40.107.3.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676C7479B;
        Fri,  1 Jul 2022 02:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIBAd9KkkyrtPhaJGSSsZI2FX1/VMrKb5VxbfVBtHPsn6yOaojUjc06v4GFDfEjhRk5Q3slAQYeSdy4gy7s+lhjDW4/XkKqQDkzExjoiJFHcI6qOm25KQ6GRsl5PwrJmRzhQmQq5wEGqSip5wrhvYw+WkE54bFCTB8lawNsA1tS7B8N6GvGQ72WytLBe/hbLRd6ZHwpzA9VVrL5u/h+nK9tJSWCT2Fdb+Mul+ihojcAHOrGU6uUm70E9K6XQoIEk5iYx9okUYndw4u+n0aBlUOkpDkoeXNGQ0aPjlZuWcQ8n6ODb9dR/Jm0lA8SIs6UvWvFbD8ApoEmwUa2ePKe8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b58oRwSdZTUcN/KhQPHaohhJ6Pqd+I9wqlKOaVy4rKs=;
 b=Zzxq7e30s4vj0MPyiau8P4+mSdgmENESSJCnbledSgtb5n1BqnVJ9zka6b9gDqukAKHkpe4/sSWbwfdbJV80g3eUYGbsc1ayZdNnj+/ltr7BgUA2VD67t/j63fZ84rMZzZOwbwVXDdP4ARprXqRnaqdk5uPkdvqZAvk2T66s7x5gIvN8AR4R0RchBqyOcYxQFcyzM6TWD0BQbo+EeMyvyvvac9ZFxW56oMh5VD9GO2LmcbKT/KT8p9PvbdnewcNTk68Q+aEGK9RRZ1YRsh5ZnjQiGBHvx0iSx1aGvSlj5vZX+EsEUdYgVQleaDR5EDAuLpQYXg/FU/z5AmVxXPWy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b58oRwSdZTUcN/KhQPHaohhJ6Pqd+I9wqlKOaVy4rKs=;
 b=gAIiBuM/xhoJQ3cd/+jH/5d9thw52dCV6mO/dz262uGovZvTYjJg4zf096oJ6RfJMIWgAecEbT11N6XXq02wA5no0f1/doBp2oyTDm9s+OAEZ8L6ksIpzEolWP8aRofhSl3Qy3avQYjOoKyhAuXzVBS5gdNT0cTVyaQ6OeFMWk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4655.eurprd04.prod.outlook.com (2603:10a6:803:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:35:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 09:35:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 1/2] remoteproc: introduce rproc features
Date:   Fri,  1 Jul 2022 17:37:01 +0800
Message-Id: <20220701093702.265249-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701093702.265249-1-peng.fan@oss.nxp.com>
References: <20220701093702.265249-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b08fc44-6d57-48e8-b62a-08da5b4504bb
X-MS-TrafficTypeDiagnostic: VI1PR04MB4655:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7PvdXPtsltANv3itoMpukDDOHFJaXSNCethYXH3Y8uMXDc70ehFEBDvTEr+BRd89p4QTuAyNm3EDsFyORSpLZmKtm4ly05P8crJ1PpcYAakQwq3RoVRSxTf3G+1jHGHzc2K7HibRtNgtI4cxNYMNROtcLA5ZibSF9LAvx8ZD36assdck4udqdpouHiRvYDwGGBEijiWk23I84s34cNnioTr39BeEPMgKb0hS5uN6O98rnIyU8IMF3TUZUxsmqaidHM2hNV+bmEUGKUxNcPDlhpDGvYSoL5EQx26VPeaXjKERx2K18APvNQNqEo9r6OoSDVzHWvyrc1DAqiUf8lE6tOw8B4F0YzXNbOpDh9GAndhExRtI6SZaR4QpnitmwTdazblaQ3h5yEus1DcS9t45A3tSI66tDFJhnzVhdhywgk6JcrrAsrQ07rCBoHNIrXazasxvDobvf1+Bh7vlzXPvp64INL0IGfHiYZlE1tJmiblW/MJ3chyauLcdWPTl0CcebtCXdhiGtOkY2p1fo+d0l0SJj0nBgtJdTeeQgkAz6kHoay2kFR4rjFqHEfaUyL6SDJ8jc56HXpSBjBosKeYede5+upqsiz9Z1Wf2vdH5QFLmTwmeRL1SB04DdXjs+QSOgTFYYpcRTZJJwqQjC+gKqvlp8QYwB/lfswGn6QqEcv0vaPYUq2gZZaY3KN8hK0525yPggDy4sBMn65rScRBGTebH6Yu78ARbk7ofkYPwhSOCYANJIGFXnkd20eX5sIG9RrWXOQVoBtEflnDI20+dH+8d4eubYSNYArurLlpuHQ6O1y5YpWh6gPEt9zgxe5/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(1076003)(316002)(66556008)(66946007)(4326008)(66476007)(2616005)(86362001)(186003)(2906002)(8676002)(6512007)(8936002)(5660300002)(478600001)(26005)(6666004)(52116002)(6506007)(38350700002)(38100700002)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ej3qE/0FJvaQdWIy+/nHqPUg1xKsXND3S0MsRl4kQ4+vRMWa/VjH/lw/8W/R?=
 =?us-ascii?Q?sz0uLblxiivfReAA5U2GhojFz4m8myrfReyGx75eEF5DDYV4FBEy415uOB2i?=
 =?us-ascii?Q?Z3Uk6iauhSXV6SOyjkOHpxYyMjqPvHzA8C26fdhpXbNgna1EUq9R7YWfMJlM?=
 =?us-ascii?Q?EYzXcdQQS4cxRWD4n5o6f9uSFqbILZkbMUyeRTcRG35dMFs3koFcbusO3wkZ?=
 =?us-ascii?Q?wCQPMWWhEn7zCBo1+Id3KmnvIdSl+RfmjBXUcSyFZ3JpJWjNlL4PiihkqiIY?=
 =?us-ascii?Q?ffIn4edNtkFUPZyLkel3xoQbbRbY8ivSh9iQIEkn/wzNnfhwqcPzhOMCnGWz?=
 =?us-ascii?Q?pPryOkja91E2FlvR4wrskMasBNv4l72OWH4Cs1iKy4tzB4DQa9YT8LeJHF67?=
 =?us-ascii?Q?FnKZ+qerCNZC6GjXEHn3sF6ASgRl2zQK95+/0TjRtH30F9xgjarg0ywffEmI?=
 =?us-ascii?Q?NI5l+Y/Ki81dQdLpCpDL65dbGyBi33KZH+P3W8Dn/dM5RLRtBs/pBHx/HCL6?=
 =?us-ascii?Q?5HOsu902/GkpISW5qg0aX1lCXopMGLIi8OdY2JobaZwqN2r+edjOz3/qqPVJ?=
 =?us-ascii?Q?WzkmIW4FQ+nfxDMsMYxmbin3YsbaxEbnARE+DpAszdgtMkWfLiZMPR3FVFR8?=
 =?us-ascii?Q?OCmWGavEt1C/NThpnpD7tXfWZB9mfkP32dr27j1x7e7mlHY2nIZzsb6XnYMN?=
 =?us-ascii?Q?hUFIyOi0cjTzIKHv8XuTp+DiazsapwrUaayKRtJaBhzRLJlMlIG0T/39N35I?=
 =?us-ascii?Q?4iAPWIxzM32Z/LEP6EJhWxjgc3USoPK8syd/EgVW3wpSx261O0EEam/9W0vB?=
 =?us-ascii?Q?GST+3VVoqTlcVTKQo1ivo7TKLv/1HAwJbZcTlkLjIO1Dfp1X7ulYyct2pDt0?=
 =?us-ascii?Q?MDPAJrBjk7t7zWlEt1P4YitsrhFg2Mz3CzfLpxxeDn3VbZXtRkeMptkMijyb?=
 =?us-ascii?Q?RgQalqzY0qdUm00hBo6i5u1TIqdK+cukHJffiOtCEJbs4DYs+B5yrHBFTdXD?=
 =?us-ascii?Q?gCuVeFHRsTW/sTIu4T8DLEoyufmKSeOCrKzlGflK+C74hXzaCXrncADc2+m3?=
 =?us-ascii?Q?4SpVS7gqvpsp5EKqZVLU+iZycAAx8SzuPunNae4WSxQGSStg07zlnarvN7Ep?=
 =?us-ascii?Q?tZ7mRmiYJ8jvC3wIjn+fZR8ExYUr/U7SOhrRF1SkW5zIzqWdvVuq0TCDTOvM?=
 =?us-ascii?Q?0TyHiqVrXs1slK06HlovPemvi6O4nDidyL3BS3wESnhVJh61N+PkSJnywg5B?=
 =?us-ascii?Q?JtERpLAdvH+4ybl7D9LaiXxHyWafRNKi2c6mnMBQr13q872cDnCSrHUzCB4C?=
 =?us-ascii?Q?suztyAUnZp6sq1+n34Iassg8VUEUrEBbQkcCkL5Shhcb6/QjJWTheMusyZAj?=
 =?us-ascii?Q?9rsp9OQQs8n9m+KF/d+2oEMC6D8jrMmR2NNx0naQ2Y11r7blD9Dg6fhG+wxK?=
 =?us-ascii?Q?XTBTd4SzplVqE3Cm2vaYGWLG4tudTEUQsw5nnylRMXKPau/VcgIeg1lYRGUv?=
 =?us-ascii?Q?ywQMNy1eTpecxuh9nX+dlwYmpvStIDNDR5LNYjwcM7zMDcRBXjQHuGq54pHj?=
 =?us-ascii?Q?3nsXbkAJ6juuvYcT5mByq454jX1zb/GoTayGCu/f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b08fc44-6d57-48e8-b62a-08da5b4504bb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:35:21.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTdU7Q1ORa9WY7K36HAHOaGkUmEQC3kfoEEQaPvmBreyA9xCsbSrtO7PH5mbxROwkauAUUB2yJ9Qsid9jDx05w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4655
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
index aea79c77db0f..bbfb3affff32 100644
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

