Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A4566091
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiGEBN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGEBNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:13:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B781DE83;
        Mon,  4 Jul 2022 18:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8JEmhnw/XLG+rbP+2xgNPa1/AHxfd2XkcvRAqw89aKM76FWuhZhLHnGweorliYN2P9PnHAuz349ubh3FohF7G+KCJvh4R1+bzgEtZ6qF4e0oosP3bhdNvEXfDfUXfTSDlMMcSD8WmOK9KNVeQebGp6RThZ1eqE5Q7Nz3VThYVc9IUxJMfpXz9HcwvNHlO0/3jNVeRQ2LPzHA9nq2UMIReB1uG85em5EvzoBnwKNE91+8stTbqDcd6n/DufuL0qWLhNbGbfbOa8tDF6lYFfjh8vAJeTIUW/glBxHd5puTXkDflOEP9Xrcw7qDfy0p7dJFDp22Q9WJ6rrno6Vgb4ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOu05O4LPNwJdNIi00SmXbN2GkM0DgItVxF4qTyK0HY=;
 b=YeJCJIZp4LXxUAOJFtY/g46jgFxrRaqcVJZeNvxJlPGWpQ0TXrzxOUZ5+d0xhOCAFcAYSWCZcwu3kDhqKy8jStqXn1Sm8kXJgK4N0WAAdjitjaYJhnz6cTaQ/OT3z9DEst33cggl9cmbZfHG50VVt3pwvR1t+jza9/eU7UgsByU70EnecJTPdUrk0+UK+4o5hpjBSw5xohzAGH5kg9MKw8I0TnBuTzIb/As/pVnghSD6qbh/xmXkn+eARvRLrO5OTjiC+wgNO1b7zAf4yw6LAYrm9NTfN1/krt6dyCm4HqZ9bZmPyElKwb/s+/FOPJQfirGysS/sigRCWaMTa5XBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOu05O4LPNwJdNIi00SmXbN2GkM0DgItVxF4qTyK0HY=;
 b=GBbyiwdljHA+6vu4zSHSGUnyxlJTIv2+1H6BEs7MYqY7JMn2+jpiMvbbSoedZfa3ni1X8PYSHR/MlyfGHS6+04vE5DqQpk6WYojU3LxjUm6XnZJbe6SNgP5ZAaSQmpO4BenC5OXTIKGboERlmDMUOFv1TXrj95b2SQCqynvlhwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4365.eurprd04.prod.outlook.com (2603:10a6:803:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 01:13:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 01:13:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 1/2] remoteproc: introduce rproc features
Date:   Tue,  5 Jul 2022 09:15:26 +0800
Message-Id: <20220705011527.2849057-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a4e50e-aea0-49d8-ce1c-08da5e239d86
X-MS-TrafficTypeDiagnostic: VI1PR04MB4365:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnKaf2ejGha6NrqG0J1750MeI+pOgH4kpImf7zK5ONU9ZJ/bdoHzyUtRPBns6yADBT89y0LngM0OG8V1OCosmBCmaO99fSSy/NwQ6l93TGBwPe7do6yIRGYYs7OSt7FvXqusyRe7SGnCWAaJ6NYtBhFVe8OTQZkAaxfwgCIWy9yBV0Ak8AT5flIWXDGa4MNiVb4LUff9gj9nqLsIrK4by8nlH2/DQtu7rx/+qzNweq9kyWsyEUHGuj/YCWjbEsoOJYdwy4UvZ10BOMjN0ZEKgkTtLwDctT0k9iclkQgI7X6KjW7w/gZ4WdIDAUkP3yYW6EINHzf7JntC/PUjuqhLUhUKnXIPxUHjSMKBTeVa17eB/muQliDjGhsdBOPAgM3GIdFbyw/KPDfLbInefty1ws5wBLUcONDLTofv3XnOGW2zbZc0esKXljJLEP8aRUYVQtZr4z6C5s1UMrzhdNi2ULLYTJqIJ0INFtjibQlrL6+Lkp8kRqSGBK7ssqILsJsGZwm46lmvO9uCQZ/Jjy31bGVCkK88yEfTi2JdHgu4XrnEKNUrOuSofrddG9NqI9cmOMkTL4KUWp59oS/CASvGY1bJnf81jSmagRQROWJHod1k2ZPeAN2rLt6rPmLev8nediKWfz9VyHic2pUMNHDdYL1yIMrjhQeC49NtJ5BqArqounPtegOHFof1T4Gz0O6pW5pXXlJflZ/0UYp3rFGWa/S/lE2YXfsssc+Dh88wndYRSREnEMH3MAv6Obt8SuJHOJ6zjs5P1ignostcH4+wZpJkdGGriBrjoCHdHHlOgf1rjCwZdQeCJ8ehuX+HBrE2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(6666004)(52116002)(2616005)(6506007)(4326008)(66946007)(8676002)(66476007)(41300700001)(86362001)(6512007)(66556008)(26005)(6486002)(316002)(38350700002)(1076003)(478600001)(38100700002)(2906002)(8936002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAQlmWXsbuerkti93IkXNrqjEtbfi5ngYLH+DaEiHO9Vcmqjeg9nwzxhH+Qj?=
 =?us-ascii?Q?O0nwMwkX4em+VK4xJRxTHty/5GSWXFDuhpk0RxdOzKAh3fVuXnFJWwmmdZTp?=
 =?us-ascii?Q?30fX2nxmVZ8cJzOMyFOM8C/5i5o/kabUN5JXHWKiiyce90xlxOx+DU54VJlI?=
 =?us-ascii?Q?6uRNlNGP+YiZd5JhkgZnDE+O0TbUHwtONZRkzoxTn3+1tygYiOFiXDLs16ep?=
 =?us-ascii?Q?EGuUGUTZGBRqgxwHe5lO9M3AmVKbfKR2bsRF+JHu2xo9753GZ8qdxHOsyJb0?=
 =?us-ascii?Q?ce+HtjruvtUZ2/D+qm1CCE5GnYE3IicepxsIKq4XbIKxnngc+c8FuAqiUWJR?=
 =?us-ascii?Q?PmFbfSxng8Q/1qJRFsmoi7OndzBDonTZReQMqQZV36y5B+TXEcCa99Q+JHdI?=
 =?us-ascii?Q?o8h33DFHjPEdo1mcOGafkb3kwEH8FV+FA+0SSNJ0ykUM0SC0CWJ/+P1zjpNH?=
 =?us-ascii?Q?GhMKBQU+KfI7wqNdRAmZW7DjUW8IN2Y3eNsuE1lFN8CKtCkoZWn/QIG9tIcj?=
 =?us-ascii?Q?7/sYtyefM8/CSo8grXHR6VYpBjCvqTpX+MZneObt1rAHwtWrVi2fvYYOmXl3?=
 =?us-ascii?Q?0XJbkmDHI/GYV1yljWql/Rcpo+f0vZiNwgcqDGJcX+t4TEangDZJjQWZ8gbD?=
 =?us-ascii?Q?RVwJqQkxJMgsw7ARz4h9C7Exxc8LVCFVQEjc4lU1mVTZvH1mlNd9Jp2aH/hn?=
 =?us-ascii?Q?WGk00+47shWQlcEXi3tXl7nujriL6GCWdxfuMvIJMUWvxsHZE2G4tqHWVjde?=
 =?us-ascii?Q?JZh/Ys9AoK5SU6ZjWJrsR2Eq+O4+nrO4XyVodLLfz2DvI00lE1fjKUaYzkvt?=
 =?us-ascii?Q?dHWMqfOiw9fsiMqk2f3cEyGOrRDrCqXr4gwyZG6l9KG424ESyLdSY4M1iCV5?=
 =?us-ascii?Q?sv/FPvZzeZArRjJxncWdOhotxZXlPpT5FpwDa4NdBd7TN+eENdjKGCypFXvu?=
 =?us-ascii?Q?9l2MQy+QagvGlqeClxK/h2LFpOXmRYIwQsyGSPf78bd3u4Nh6Q5hdW/6JPaZ?=
 =?us-ascii?Q?5oKv4EZ4apYeYo17A7XxR7BxGWJcAu0hL4IrFN+n9WhHT/VuwXZCRVyu6h6L?=
 =?us-ascii?Q?JgDHQjF6IUlu6HlmC45fhKDfN0UXpPwguXjpMJ8cM16dyev49Cc79VSLiFIA?=
 =?us-ascii?Q?P2U1YTC19cX5XlFtZZOc+wQBZO1zSETOP47EGtVpo7crJl8LoN63dZLEVQuP?=
 =?us-ascii?Q?hCMMMa3veGuEXtfewrDffu4buBFqDXFGwjon+BWU55dtIMYhrnxO7qf3Q50C?=
 =?us-ascii?Q?WpX66c6v2o4hMGnGowTHGV5fcb5EqvYegt6l4RrbXWN76akt8L9JUaDfVZtl?=
 =?us-ascii?Q?Ly5+Doi2K3LZTaKCH60tpF79U4L3gxC6Ocf4UcBFi8/lpFvkGSoeusu4bPQV?=
 =?us-ascii?Q?Sh/OBQM1RdxdDxeANe1oB3n77B6jyMbo4y1UDo3JaKIAy0q4uHS5FDetIeiZ?=
 =?us-ascii?Q?4Jups5nm4UOy44C9DlcI+7Co8GljbCe3V6acuJieC7oaCB7dbkL/SXN7VPhz?=
 =?us-ascii?Q?l+SpJaDBcUtMSsbZtFMwHwtid0wE62xRhOxVzgBuSl6VHtXUORmME8ucnO02?=
 =?us-ascii?Q?PRDkzJwzKZIuDzdr0P/KMMPrL5xlkoO6y5IljEEd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a4e50e-aea0-49d8-ce1c-08da5e239d86
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 01:13:48.7788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG+2Qspcw2iQystJ0znZwWu8GJHc3rHLyg0Op2fJR71VHyKVdF72lluUy3FMMT6uqB3UuQDfNmOU9mqpfV8nQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4365
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
 - boot recovery with help from main processor
 - self recovery without help from main processor
 - iommu
 - etc

Introduce rproc features could simplify code to avoid adding more bool
flags

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_internal.h | 15 +++++++++++++++
 include/linux/remoteproc.h               | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

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
index aea79c77db0f..18869924e299 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -489,6 +489,20 @@ struct rproc_dump_segment {
 	loff_t offset;
 };
 
+/**
+ * enum rproc_features - features supported
+ *
+ * @RPROC_FEAT_ATTACH_ON_RECOVERY: The remote processor does not need help
+ *				   from Linux to recover, such as firmware
+ *				   loading. Linux just needs to attach after
+ *				   recovery.
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
@@ -530,6 +544,7 @@ struct rproc_dump_segment {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @features: indicate remoteproc features
  */
 struct rproc {
 	struct list_head node;
@@ -570,6 +585,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
 };
 
 /**
-- 
2.25.1

