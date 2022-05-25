Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E220533C47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiEYMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiEYMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:10:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC3F338B3;
        Wed, 25 May 2022 05:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3gxi8GaW4o+RlxWVRZrikqbC8T7gTWRo6S1LJTebI/zTOCe2Q6PNF2KhmN9NzMYE9KTJeeemqZzrJNhZT5edZf/XZ0JvsJ/V5aMj8VeLilCYed0/IchoUvAFZvjA1aLdWBKS2xq73PG6oQzXB0G+7UZbVTzw+rZ5wUWRNDtZlbxGt+72IdFSJ2DgsJEvXmLSqyhUEh928vzCxH2MwAWQUvCRyRx7mnzkjOh+AKVzyNB1NkUoonjAGnkRTLG2ccZbA5e3/TJB1zV7UQvmccb91LnMsL6Wwo9kIrLkuxFf0Fq95JiSUEnm25TC9Rb/RMqVHh9L9JFUY5qnjY2XclAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTWYhpPYS6CMEy0ZX9YQLJHYOZXcpIBx5+X5MNQYed4=;
 b=S3K901Yv3a8XBJwJtO7masISFNeGmr730buTs+8CVt+NQRWOBTsFHz80cyBDcEdoED+AaTPsZTmZYkBQemv98h4QRzNdTE2zxDiHEGDdKLg/gFSYM3vSiJxz/YMwsTJjQamNwzQS7THKqxWcImGgRqTLGpe6yfipNG5+1EiKHToFc9WuFmuUw2PqUO6eFSvHX+SvtrS0MBL7gWwXhKgb4Jl3yxIXkjmGOS4K24JEgigoI8Z73YuaTubROe/WCIDadesO3eH3hpn8ksp12v1TVmtJTiZeoppzdLENPXN+MdH+aYE9K82b1Z97BXlHR2DlGOD57rYu6himaytDKdqovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTWYhpPYS6CMEy0ZX9YQLJHYOZXcpIBx5+X5MNQYed4=;
 b=li8xKhc/ILkSyMYqY6snHvYvJh4nF+JS4tVXNuWnWIaUsjDmTwGLubvj1LX/mA/8ebmxC5NKrPyTkX5RvXHosahSdh6qc3Z7O0Wr4cFv7QvTCviGEtk7u0adR9bf5Z0IzsoUhRPV9mJRwkKlI2OjcvPjH+hQ3UvT1zY+J2K2N9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:51 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:51 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Subject: [PATCH v2 03/12] irqchip: mips-gic: Introduce gic_with_each_online_cpu()
Date:   Wed, 25 May 2022 14:10:21 +0200
Message-Id: <20220525121030.16054-4-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d3f9628-bbb2-441a-d420-08da3e479c3e
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB78593BB34F20D63212BAAF15EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCRaqG5IZ/O7q1Zp/vN3xkzdmcIlzxo+IRaNzcL56NxV/tBabXdd+3QG59z4OqoH2gnLae7LVzY4AcHLXmgk8oaANlhqCfCCQLjEGQ/a9I6OXJZ1F+2AH+3vToihxiK+MuW5JfgJamLG9oHmjyuikwWJ4LRtbKmxRONQt08j5NvC+IAqyEVE6hSwpWG8tNWqhGC2q77P1N1MxXl1AXB+g9OQI4EZqRXQH48je7spkzSSZKle75kaCabD2gJPxF71Uo08mvL40iYaxk9AW0wiMwjB+JRRyY+/wYkoIIL8oj6GZME0CqDU6nnq7T3HH4mSzz3rUHGCNm7BXKX4zkPHl/nrslMmf1K50q5Xzd9VqylsDVSzq7qz8S9E/EN69WUW/NyZxD2B3qOX/iP7j7L8PBO9AXUUwBd6eGPsA1lj2qSIjj2eQ4iPN2ldcUv3gYfkzcQvanq3/bkQ6ck3rh06K89hxN7V1kWlx5S3t6JNjcb59WUxkJ1Ml3yMeJUzwurr2L2n9bDF3lk9MRvngf5/Lvn+1viQ/yQ6RTHq0oJhP5Y7be7bHv7InnAXxxz2wnQuHVkSIFCIbTJYDNoOemj9IfkvsACbjGbhatxC5bj804YeNxukZk6EyXuzwpZn8S5lXz7ymSmFJBcTA6qygGE/+9tCDnOFoMh3UZkAZy1x/+BqE1hp1dPRuQWY/v82G9F0pFjR3CNDoCxY7NnLEQVfTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(136003)(39830400003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4dXjUw2CzNK91TdbR7GXUUmDCxjcD7k0syb/3+Q16ZdXfEqQGzT99k7HCmV8?=
 =?us-ascii?Q?0nQb+2Yg8wjIIr9dvtH7XxVJqd4g6124RosfJ5Ui9LKYabXBQKvNLOwvETwz?=
 =?us-ascii?Q?/4nLIik+Ysynsc5Dr7lxzLTpKHEzDTgoj7kEEI6Ha5MUDbmpqgoW3hub4VXP?=
 =?us-ascii?Q?n8xhvhKIs6uZBF7lS5P0QkkxVYz/o/r0WECVDp/FYEZdtrPvepss2pXs3Xu0?=
 =?us-ascii?Q?tWiixPxeA6zAe9aBY2NeczpL//omFkQRX0EaxunUwgesyOl9dZCvTU0NZqEt?=
 =?us-ascii?Q?RGbt8XqvMK/jpQwKlKkdrdaxafdCTJd8Re8fae2Q+ZJf9ZYP90aSOQENEhmV?=
 =?us-ascii?Q?4MnUSj7OlKGPYckA3uW4Ej7z6opIVP1+58irpIy0oxi9vuT4lXaf7H0Ykq5D?=
 =?us-ascii?Q?b2jgEYxQ9hHHb7g57SaCtMgzga6eKvBFHxpE4T83VKxN71/uBsdpxo9h7b6s?=
 =?us-ascii?Q?qkIWYEFMm8iy23Z43EKnuJIkTxqybluP6XbPCxZe6L3zyWPuiPqSFRdqRb34?=
 =?us-ascii?Q?B25rzzSpkvmA9N5Bsg43Pu7TUKp9GESAGqdXqZVzpYYmD1gL4j1fFqPx5Red?=
 =?us-ascii?Q?YwTdO5G+B18jutXmbXNnHrw2wUeujL0c/jOuAh6ucdtyq2Qvek9Yr6R3ktou?=
 =?us-ascii?Q?+/E0mRx0sbpKvyLhXPt3jAfISI+vNBo0xuxMxEUJAfBL3KWj+JZC17vjYEfr?=
 =?us-ascii?Q?taN7pV8dmrWi2aUrk4dUp1FZY+7EVPYe8j6f1Ru/Bi0lL/5AiYCpINpb6AQQ?=
 =?us-ascii?Q?6Vd/fm9mMvFeMVeNNuNrlA1jIxIXj5tT2s3lhQxfzsodb1NjyGPYyRuQonqX?=
 =?us-ascii?Q?Sa0XsDJCap+BZ3q45MAlnBV1NHlELFd6zunK0JdO0coGKzJmP1dLqKKOoW1k?=
 =?us-ascii?Q?m30M2JM1mG63cnPhVQ53T3VLtEm4NKb127LZWfIK7gHQwTojN9N6UcTRxh++?=
 =?us-ascii?Q?tzXhwY/TnrwYF/d6BKt5tXZmY1Bx8Wc47NlcKtCdcoIl3llhSNTKMR42b5Yh?=
 =?us-ascii?Q?d5Y5zX+CWqs5dPZEwTN3s0Yd9MKh3VeTC5Fm/58zfppRtBq4rDUbZvuwMiec?=
 =?us-ascii?Q?V+NndgLQIKKM/oBVhmCqM4EskgMKpjZSWft4CPq5YoHLTsVhZ6lb6xXcZNpG?=
 =?us-ascii?Q?SjfMd07E/Nm6YNwbjNjFWViKvbzOIYuBFjXi4pqYQJ4wiippu62CkBzYHQbL?=
 =?us-ascii?Q?3MdABO2fyJ44/vJIVtrBLxnfKyyaDlGSSqO7k6BLW7g/PFIcF9NCeXOwDtCL?=
 =?us-ascii?Q?h0futGjxghFw0bikdJzmp6F1oRam80JvysKm+Yu7J49YF5xbKd0Cncyuxw2V?=
 =?us-ascii?Q?F5KVp/RzPjHrhZYlcnDzZql5J75KKaUWbVhHoiRzvahRMFo9nI2rbz+spdDX?=
 =?us-ascii?Q?ZA5x40Mws/fPuarPbr59FflGSKbBFdG4IJFHgMXsXwz+k9ipy1RXdNGOoi77?=
 =?us-ascii?Q?W+PP7l+pzPa14HHlh0bZMKYUq0iaU/eHIFacz2UWTjA4dz4loEPDWU4MsYgL?=
 =?us-ascii?Q?OnWNGTuTlPXVevGXdin52VHmb5dB7Vbncjp/r3QZijNL24XkttKzExuVEriR?=
 =?us-ascii?Q?oJZcymjdbk5yaqczc8LKLFx+KEWCiDh4H4cHco23wUAVpnOjf/pEkCaBKBf7?=
 =?us-ascii?Q?jCO6ZnFIV1XJLlwZrY+db/dMTJagYjPfC+SbV0VYLwOHd5CaBJu3H4HwfMwn?=
 =?us-ascii?Q?oWen3zdkqIdWCeAhlZMIaEtsPK/HuMs94aYcdCtNF9SCuHHpAvhlIsh3ceC7?=
 =?us-ascii?Q?ARKNnwbzEkJkCN0Ek2b1qsZmzpnq7MY=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3f9628-bbb2-441a-d420-08da3e479c3e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:51.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opIP3kUlevw0scumphav6/gVQaLnWuFJx4GV3cP9yB6OleBEeXJ5DLahiwaZs/rHYPd7DVPXDevCziC55wJ+WdTSXZb64QvjU6IhwtXJWb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

A few pieces of code in the MIPS GIC driver operate on the GIC local
register block for each online CPU, accessing each via the GIC's
other/redirect register block. This patch abstracts the process of
iterating over online CPUs & configuring the other/redirect region to
access their registers through a new gic_with_each_online_cpu() macro.

This simplifies users of the new macro slightly, and more importantly
prepares us for handling multi-cluster systems where the register
configuration will be done via the CM's GCR_CL_REDIRECT register. By
abstracting all other/redirect block configuration through this macro,
and the __gic_with_next_online_cpu() function which backs it, users will
trivially gain support for multi-cluster when it is implemented in
__gic_with_next_online_cpu().

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36267dd..4872bebe24cf 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -65,6 +65,45 @@ static struct gic_all_vpes_chip_data {
 	bool	mask;
 } gic_all_vpes_chip_data[GIC_NUM_LOCAL_INTRS];
 
+static int __gic_with_next_online_cpu(int prev)
+{
+	unsigned int cpu;
+
+	/* Discover the next online CPU */
+	cpu = cpumask_next(prev, cpu_online_mask);
+
+	/* If there isn't one, we're done */
+	if (cpu >= nr_cpu_ids)
+		return cpu;
+
+	/*
+	 * Lock access to the next CPU's GIC local register block.
+	 *
+	 * In the single cluster case we simply set GIC_VL_OTHER. The caller
+	 * holds gic_lock so nothing can clobber the value we write.
+	 */
+	write_gic_vl_other(mips_cm_vp_id(cpu));
+
+	return cpu;
+}
+
+/**
+ * gic_with_each_online_cpu() - Iterate over online CPUs, access local registers
+ * @cpu: An integer variable to hold the current CPU number
+ *
+ * Iterate over online CPUs & configure the other/redirect register region to
+ * access each CPUs GIC local register block, which can be accessed from the
+ * loop body using read_gic_vo_*() or write_gic_vo_*() accessor functions or
+ * their derivatives.
+ *
+ * The caller must hold gic_lock throughout the loop, such that GIC_VL_OTHER
+ * cannot be clobbered.
+ */
+#define gic_with_each_online_cpu(cpu)			\
+	for ((cpu) = __gic_with_next_online_cpu(-1);	\
+	     (cpu) = __gic_with_next_online_cpu(cpu),	\
+	     (cpu) < nr_cpu_ids;)
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -357,10 +396,8 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	cd->mask = false;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	gic_with_each_online_cpu(cpu)
 		write_gic_vo_rmask(BIT(intr));
-	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
 
@@ -375,10 +412,8 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	cd->mask = true;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	gic_with_each_online_cpu(cpu)
 		write_gic_vo_smask(BIT(intr));
-	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
 
@@ -532,10 +567,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		return -EPERM;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	gic_with_each_online_cpu(cpu)
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
-	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
-- 
2.17.1

