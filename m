Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5283533C66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiEYMLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiEYMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DF3E5C0;
        Wed, 25 May 2022 05:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jtd8Xtz4wPmDs1608J5CT9W58CHuD+5j9a/Iv/eWqfn6TsIyI8PpPRCvEyA58qzkj08Ngh3b9GgSSIQshwsofRIuaXAwLPO/3hpi4ieujcFFaqOt82TMwL9tZLqpfjQHlxd0YlZsNvNT0piZqe5N3/Kl376A3xCiWM0kKG3TtS7DlbtwSA916USfQJwXLHzKUy1EVIey0ISFEtPuBSHZX23l4LYhGGAFQs5fqW3z5oIvMzjfXvrp2JJQ2xQI/ypdE/FRAInEnqdUdFP2P+y5N4yxZmTJuK/QtCybBsYoxn6C5gBwWd/XivPqg5gO4KU9y703WApffMqsSaKtRbKJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj2M01/0Y2o6YjgGwfDHehSIFfIF217JHB18zjNQIHM=;
 b=A8gkHjHpxQ04/E76syR6dZW9uIR+V9yj3nMnBtiaLxGdEfpx+Td3u9OsUZnJZBTEpI8K3ItrRbYd2Dvn9ddO0gG1YWgEQj+nBS6N/y0k3OBQ7QPQB8V78Hvbby8jHen3F2w4a6pea8AdxdzBIZbDvgFNO3KgW3tggpSaHdBCH1SICLt0l74ai0P92fkrspC0yMU1VgI2YSh7a+joKDm+cIZ/XXVGKK5RShI5ZMxeSiAQsX8e04or2M5Tqcpwb0sEjR1utRL5ywP+ZZk9OrrbzuNiDwzpRwGEm70vHpmrpBEjwqBP8hBCCLwZhpnky6jlkDCTvksUAcMGRDFwfFmCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj2M01/0Y2o6YjgGwfDHehSIFfIF217JHB18zjNQIHM=;
 b=GLLzUT/rUyE8zcjkPJz2nv0HPje0Z1qWC+R4muypnqVKlO5dcuXimx/RN/3xSrKc1GyIu5wVlyjpFvlLmJBZ3rFOaQQDzbsDT4CQ0QkiIj94PrE4J6t+Ri48LSCHKI0wusEi6ppzvhS6cwfxdoTr/ZOxOIcGom33mVlCgWojdVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:55 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:55 +0000
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
Subject: [PATCH v2 06/12] irqchip: mips-gic: Multi-cluster support
Date:   Wed, 25 May 2022 14:10:24 +0200
Message-Id: <20220525121030.16054-7-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b3ef36-ff9e-4c0b-2e26-08da3e479e06
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB785905EF64F9B7FF094FA14CEFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4z7y1MJ1N9/b1shjMeypN5z6TiVQhNWyiaSMOfQcvaFxON2EWcEfObWOb6a3kFRTPW1w0J0I9qw9E4GwN6Y+XgNhHwubXOeQiskofqgAO5ebP5n3rrb3c3+c64iqcj6QFHbU3xdvdtnQB5sH77bXj70HklwFfdubdyP0K+g4tOXlidzWT1/Mpw2hqnS5FzHUzlaA8zEiEKBlWA2gTFn/e84ctfs4F/UuUUO0TrIC2qVC2ENaAIBd06x8H9GN3PTZpCBjN3v/GXDTUpZ7q1edQUuTIbF+h8VtSFWirvnhPZ+s4BqBmqLPHeAVevfKakCKaOOM4/t+TN2+cXT5ivkKayqdoP9dl2sFZWGUPgfxJAyK0PVR2xfn25fyk01J12/uI+fffQP3G2obWzmzjRMVUwwS22AEZIJ6PYYkcCTwbaLxBz84YEs4mvv/szzkcSVkUNwMCMPrk58hsHGy6jTZ/rYFvf7VUn+azC24oyJ7U7jDqKOiV6519yPLh0zTEWLaLOjCOtezfLwUbglUI8s8jcPZa8p+k1SFfT2tbxv8uzWXNtN4u9QwHYo8H5uhVGJexdLh7O6fiD+te3rrugYnOiPQvl/S/FPZv3ik9puK7SqqxDKOJ72hQDdh8KoCk1ft8U4tFZkldPxxNDDDKe0f91jKpUnnI4jMDsFuyUYL8nysTccWmohJfhgKr56Nci98MtEQaRQZoER9hzKlBJhUXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(396003)(136003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(30864003)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FIYGFEDSnU06dGa/+h2nYamzpKyBK69t4E6wqf21YDyZLQMO8Cw/DezJqLY?=
 =?us-ascii?Q?s/lJGN3vRAfS91v83zrFqVSp9UBmzSKqxjGxxMTyKYuQ88GFsKwjdvotJGSC?=
 =?us-ascii?Q?pc+JoIsKB5nN6zLRZCf60T6DInx1NfP7tysa0+yha2BjLf/n8pcflF5wzhZ/?=
 =?us-ascii?Q?QJOktwc4OCSVds+UpO0LK7S/3kU3wqnryvOUvwkGqXsVYlQDg4Ij+ndAIHFf?=
 =?us-ascii?Q?PmJdfZvA+tOJd3riXJ90PlYL7zp7tT4ZExPAu0ycKsglAj0ymTYSrGjUgzcH?=
 =?us-ascii?Q?2fNcOHmHyqtkaDxZFeG/cdQtlkVJhaMJFA+37FkfUIy4DGCngLrlSHzGyJGB?=
 =?us-ascii?Q?SRWqWooQgY9HBMLytzUNiZ6ylZwZFQHgjKIkOG4+yhha/Tfu6luvlqpcfyoZ?=
 =?us-ascii?Q?uNb0Whm4XVnv9uGln9NolnkaimnmImj2B6FgoOAWvdFgfD6+iQwfGrws76zs?=
 =?us-ascii?Q?+S7I/+qy0qjihKzkW9YIvKLt4PgxUZeX4NR2n6cNwqnKqiAJtf/4Nce8vC/c?=
 =?us-ascii?Q?jGY39bBTmWu5AqSGr8xnxURKK4mPpTiNJrAf4/o7bfd1al8iWGJsdB/sN4fC?=
 =?us-ascii?Q?MpvH9OqVTsW0/SDSTIcdJ8kinyIacaK3op/a6zVeXZoT5+Hm1ab09UwWCHNA?=
 =?us-ascii?Q?eNtAn4ddi/DuBoLluc6dwdZxFwCmMS2N0C3dzWLO61PcXuI+99WStjuzSCJN?=
 =?us-ascii?Q?ovq91+LJCt0uB7W+a1lIKXd6+OkElwNrRbcQpiY3sWz1IcwwF9potnQzkUrf?=
 =?us-ascii?Q?Ej9cpsdIbTu8yJEhxl7TeVUKf2Iw1vSYb9NXCAWDIoHx8vvbE9n0GRK7YPza?=
 =?us-ascii?Q?mNtLv0sLwhG0ocvI1USH208u4WYlzIqDF0fRoLeAY8UkWWbfj760p0+E/AEt?=
 =?us-ascii?Q?+u8cBFmiBKkAwYVc+q1D+HDzy2KQv6riW8pbxQMAfunEEwZGsFFJTUrcjWBS?=
 =?us-ascii?Q?rV2MZVUERvV0UhK0Fx1vinYkFGuYzdzcqg+39oUFZtH1Eae1hkie6F8txyaY?=
 =?us-ascii?Q?8qWHSMT1pmxYmOEvmhR9BWWw6fkwiLs/walxvhPrUjaGH5sZKFRS6q2H8MxA?=
 =?us-ascii?Q?t4jrQgO50RR4g1YwTOktWQXlq/9R/PwKX0CnFldOUA0TA9GOZ9Yq5ptX54nj?=
 =?us-ascii?Q?JbfuvPs+MyH50ibLcHKRg6eXRmdN1qDJB/msxEyB0b13+5jMGPJMDUUS9sG3?=
 =?us-ascii?Q?UizvPES5YWOcfTX52qG4lCVxX6aC5JXElOApGudYB2jlmuGRyviFlu887tPf?=
 =?us-ascii?Q?uxmGhadUfvWPZFcrZt+L2E06OhT5JDe8pDtmV3ynEUpdh7JAqESypwl5WsYf?=
 =?us-ascii?Q?OxaM3pBZWdGo60xxLGtmLiUsfPgF9oqzWo/iXjOORuAF7jJiahlLGN6d22af?=
 =?us-ascii?Q?kEBI6N3AyrWb+zUno2AKI/P++zMf/B53cLUFiYtjKefVcfsnHSQo30QXOFbN?=
 =?us-ascii?Q?4Pw8wNxwQvt2QDj32Nap8XzpU2tYEMEc/+94P2RXsvQDNAmEwfOtjFKHm1Do?=
 =?us-ascii?Q?JvOTOXyo8sAd4XdFBMEMy+oq1B4tbp80TQKezXYoF+nL+F8WSOHP2xmSorr/?=
 =?us-ascii?Q?m6HvmSEzaD4PbOU5enGq4iLIPVlPd02aaIGZRdhV7FzQggVVVFEwbHnMtwLM?=
 =?us-ascii?Q?1iA7tJ9D8fyEyrggOJXp6Jrf8r+pTrJGTH8AxM1IqupEwh3aqXhcBD+Y57qc?=
 =?us-ascii?Q?Lt7N6XGJulOpr3EZb0si7jTZairAf5ttNV7QqH5ahdms9jy4wlEpqukvKEh1?=
 =?us-ascii?Q?t+2kmWekPzHcfLvCikPUZY70kh3FYzA=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b3ef36-ff9e-4c0b-2e26-08da3e479e06
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:54.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MHEAQWu/sGoV1K+vkiuZ126lo1DVyXHlaj0CB9w/LYmnM/AqtmW9zsHpSlolAZVyR5i/UhRPMxjQri2VzI8eiE8KIUba7FmUXrZSsYfwgM=
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

The MIPS I6500 CPU & CM (Coherence Manager) 3.5 introduce the concept of
multiple clusters to the system. In these systems each cluster contains
its own GIC, so the GIC isn't truly global any longer. We do have the
ability to access registers in the GICs of remote clusters using a
redirect register block much like the redirect register blocks provided
by the CM & CPC, and configured through the same GCR_REDIRECT register
that we our mips_cm_lock_other() abstraction builds upon.

It is expected that external interrupts are connected identically to all
clusters. That is, if we have a device providing an interrupt connected
to GIC interrupt pin 0 then it should be connected to pin 0 of every GIC
in the system. This simplifies things somewhat by allowing us for the
most part to treat the GIC as though it is still truly global, so long
as we take care to configure interrupts in the cluster that we want them
affine to.

This patch introduces support for such multi-cluster systems in the MIPS
GIC irqchip driver. We introduce a new gic_irq_lock_cluster() function
which allows us to either:

  1) Configure access to a GIC in a remote cluster via the redirect
     register block, using mips_cm_lock_other().

Or:

  2) Detect that the interrupt in question is affine to the local
     cluster and we should use plain old GIC register access to the GIC
     in the local cluster.

It is possible to access the local cluster's GIC registers via the
redirect block, but keeping the special case for them is both good for
performance (because we avoid the locking & indirection overhead of
using the redirect block) and necessary to maintain compatibility with
systems using CM revisions prior to 3.5 which don't support the redirect
block.

The gic_irq_lock_cluster() function relies upon an IRQs effective
affinity in order to discover which cluster the IRQ is affine to. In
order to track this & allow it to be updated at an appropriate point
during gic_set_affinity() we select the generic support for effective
affinity using CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK.

gic_set_affinity() is the one function which gains much complexity. It
now deconfigures routing to any VP(E), ie. CPU, on the old cluster when
moving affinity to a new cluster. Because we only configure an
interrupts trigger type in the cluster which it is affine to we call
gic_set_type() to configure that in the new cluster, after having
updated the effective affinity mask such that gic_irq_lock_cluster()
begins operating on the new cluster. Finally we map the interrupt to the
appropriate pin & VP(E) in the new cluster.

gic_shared_irq_domain_map() moves its update of the IRQs effective
affinity to before its use of gic_irq_lock_cluster(), in order to ensure
we operate on the cluster the IRQ is affine to.

The remaining changes are straightforward use of the
gic_irq_lock_cluster() function to select between local cluster & remote
cluster code-paths when configuring interrupts.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15edb9a6fcae..5f706b3a27aa 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -310,6 +310,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	select GENERIC_IRQ_IPI
 	select MIPS_CM
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index f692392666a2..45c9c660f2ef 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -124,6 +124,41 @@ static int __gic_with_next_online_cpu(int prev)
 	     (cpu) = __gic_with_next_online_cpu(cpu),	\
 	     (cpu) < nr_cpu_ids;)
 
+/**
+ * gic_irq_lock_cluster() - Lock redirect block access to IRQ's cluster
+ * @d: struct irq_data corresponding to the interrupt we're interested in
+ *
+ * Locks redirect register block access to the global register block of the GIC
+ * within the remote cluster that the IRQ corresponding to @d is affine to,
+ * returning true when this redirect block setup & locking has been performed.
+ *
+ * If @d is affine to the local cluster then no locking is performed and this
+ * function will return false, indicating to the caller that it should access
+ * the local clusters registers without the overhead of indirection through the
+ * redirect block.
+ *
+ * In summary, if this function returns true then the caller should access GIC
+ * registers using redirect register block accessors & then call
+ * mips_cm_unlock_other() when done. If this function returns false then the
+ * caller should trivially access GIC registers in the local cluster.
+ *
+ * Returns true if locking performed, else false.
+ */
+static bool gic_irq_lock_cluster(struct irq_data *d)
+{
+	unsigned int cpu, cl;
+
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
+	BUG_ON(cpu >= NR_CPUS);
+
+	cl = cpu_cluster(&cpu_data[cpu]);
+	if (cl == cpu_cluster(&current_cpu_data))
+		return false;
+
+	mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+	return true;
+}
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -170,7 +205,12 @@ static void gic_send_ipi(struct irq_data *d, unsigned int cpu)
 {
 	irq_hw_number_t hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(d));
 
-	write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(GIC_WEDGE_RW | hwirq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	}
 }
 
 int gic_get_c0_compare_int(void)
@@ -238,7 +278,13 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	write_gic_rmask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_rmask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_rmask(intr);
+	}
+
 	gic_clear_pcpu_masks(intr);
 }
 
@@ -247,7 +293,12 @@ static void gic_unmask_irq(struct irq_data *d)
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 	unsigned int cpu;
 
-	write_gic_smask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_smask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_smask(intr);
+	}
 
 	gic_clear_pcpu_masks(intr);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
@@ -258,7 +309,12 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	write_gic_wedge(irq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(irq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(irq);
+	}
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -298,9 +354,16 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		break;
 	}
 
-	change_gic_pol(irq, pol);
-	change_gic_trig(irq, trig);
-	change_gic_dual(irq, dual);
+	if (gic_irq_lock_cluster(d)) {
+		change_gic_redir_pol(irq, pol);
+		change_gic_redir_trig(irq, trig);
+		change_gic_redir_dual(irq, dual);
+		mips_cm_unlock_other();
+	} else {
+		change_gic_pol(irq, pol);
+		change_gic_trig(irq, trig);
+		change_gic_dual(irq, dual);
+	}
 
 	if (trig == GIC_TRIG_EDGE)
 		irq_set_chip_handler_name_locked(d, &gic_edge_irq_controller,
@@ -318,25 +381,72 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 			    bool force)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
+	unsigned int cpu, cl, old_cpu, old_cl;
 	unsigned long flags;
-	unsigned int cpu;
 
+	/*
+	 * The GIC specifies that we can only route an interrupt to one VP(E),
+	 * ie. CPU in Linux parlance, at a time. Therefore we always route to
+	 * the first online CPU in the mask.
+	 */
 	cpu = cpumask_first_and(cpumask, cpu_online_mask);
 	if (cpu >= NR_CPUS)
 		return -EINVAL;
 
-	/* Assumption : cpumask refers to a single CPU */
-	spin_lock_irqsave(&gic_lock, flags);
+	old_cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
+	old_cl = cpu_cluster(&cpu_data[old_cpu]);
+	cl = cpu_cluster(&cpu_data[cpu]);
 
-	/* Re-route this IRQ */
-	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+	spin_lock_irqsave(&gic_lock, flags);
 
-	/* Update the pcpu_masks */
-	gic_clear_pcpu_masks(irq);
-	if (read_gic_mask(irq))
-		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	/*
+	 * If we're moving affinity between clusters, stop routing the
+	 * interrupt to any VP(E) in the old cluster.
+	 */
+	if (cl != old_cl) {
+		if (gic_irq_lock_cluster(d)) {
+			write_gic_redir_map_vp(irq, 0);
+			mips_cm_unlock_other();
+		} else {
+			write_gic_map_vp(irq, 0);
+		}
+	}
 
+	/*
+	 * Update effective affinity - after this gic_irq_lock_cluster() will
+	 * begin operating on the new cluster.
+	 */
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	/*
+	 * If we're moving affinity between clusters, configure the interrupt
+	 * trigger type in the new cluster.
+	 */
+	if (cl != old_cl)
+		gic_set_type(d, irqd_get_trigger_type(d));
+
+	/* Route the interrupt to its new VP(E) */
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_map_pin(irq,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_redir_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(irq, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	}
+
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK;
@@ -488,11 +598,21 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	unsigned long flags;
 
 	data = irq_get_irq_data(virq);
+	irq_data_update_effective_affinity(data, cpumask_of(cpu));
 
 	spin_lock_irqsave(&gic_lock, flags);
-	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
-	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	irq_data_update_effective_affinity(data, cpumask_of(cpu));
+
+	/* Route the interrupt to its VP(E) */
+	if (gic_irq_lock_cluster(data)) {
+		write_gic_redir_map_pin(intr,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+	}
+
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
@@ -670,6 +790,9 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
 		if (ret)
 			goto error;
 
+		/* Set affinity to cpu.  */
+		irq_data_update_effective_affinity(irq_get_irq_data(virq + i),
+						   cpumask_of(cpu));
 		ret = irq_set_irq_type(virq + i, IRQ_TYPE_EDGE_RISING);
 		if (ret)
 			goto error;
-- 
2.17.1

