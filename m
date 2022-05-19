Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5869752DD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiESSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244121AbiESSv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A5C3465B;
        Thu, 19 May 2022 11:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEG214gZtbuUye7sO4JLgVakZyebNG8zH3jKQp9/n1SLO+CEtcpG5RF1PikS5wFcuR3HV+G5Cs+VwfED2acJ7Q955DfFCicl9N48nDZO6PkdjSsAmgJD1Sb3G2eu1V0wgzuO6gd/Og3kLQPz8+cG2bQKRPh9mh+lttQhl1S3FS0FFjEBlng+oaJgOENKTIdkDnq8fnVlYO99XfYbJ7WOjpiX5kl8HRMBGS00tLJghb1fItGXqc7JKMsXBIRBx610a//9Ms33lxdeW1GFAM1Dm5izmHIn7sMS5/vJLPU0KE3A9q2C3xHqC7mVss1N17qXJYxZt7xyYFk3XwN+nGP5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2ekeCoROagX7INoXe7XmnWgHrxBkecTYOdDQfpPIPU=;
 b=SYeDLCjTSORhon6AOTzS+gmxDSTObDTFloYZwLnf31LBidAL9dCbyagGnUYE07OOpPrqdy8Xwa8XnH6XcUItd3rHBYdWm17urFQa2QcCDrSZlZkW3eO7GxQaJeQqf4PBk+8LC7IKUYQ/ook6adcJNUkHBkK0rXhQmL1QmjYOS8AjYnjlUIn8imOCe0fnMntXr7mIOCzxGtzoQJ0Ohu1iCpYhO4jc/06z/+P4CRYVhz2ly9BWt+yT43yTdQnW9MeQjnPBchKkKfje2u0gruE6YHUcdrX0mOl9ov+0rzaGLPI7S/BbkfvOKz/otrls4Cbh883vONTWAAy5VTxDfouiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2ekeCoROagX7INoXe7XmnWgHrxBkecTYOdDQfpPIPU=;
 b=tzD97stX6S4R7kseMto6ckvHfcKZL3C6pIvaXQEGBSd7khrgGb+A2H/vhzMl/Xvazjwrvl8RIwSFCYoZkBop63mN1qjNBrgDZr+H/GW8Eyi0+SIDv7OOCNA9VuH9pCXUiTmQGUec7p5eS46H2tEeC3jFThYA3eKxz1suyFQgBQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:47 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:47 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Burton <paulburton@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Chao-ying Fu <cfu@wavecomp.com>
Subject: [PATCH 06/12] irqchip: mips-gic: Multi-cluster support
Date:   Thu, 19 May 2022 20:51:19 +0200
Message-Id: <20220519185125.11686-7-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 187b9e7f-39dd-405d-4c61-08da39c89f84
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB25464AC810EBAAD6F5BE6A4AEFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcgCnkVPUKy5ZAI8vQATQe+2tddydSp99WTFO6l8WWjiA3Fse8WsN8xZVKNJvemetkro8pjk0s0QIzJFYxBadf53sOadW95AM8XKntK31RZVwficxblh1zwUoykHyiTx7pSz3Ux6gSQhiMR4euyJgAEFwu+X/Vm5T7peY28TJS/T9WfQRz4kYt87oVj0X5p0z9WmWen7XG4JXaofcFnZItfrA1z3kIwjbwWB+u6ANvhEcM0uwxuaNcniw7K+yl5wj+Cm8TwWmGz4Nsr6hrt4s9CO2GzOlrenB0p0hYyfZHGwcSXP7dylK01kp09ySsD4KXLJO69h6rXQ9ZJlAcz60L+hry0q3SUpNvDFCyDczvbvGkbOva/KbOCiCOuzA0z3ByftVbn0G3v7mQE60JVJtKGHXkl2148sum9rMeSmcAc2RyRTfK/UfZcEta6cp8wM4vmsmIGXDJk/6pnQJrufpDBQiWFBJRApCSkkU9LBTqUiLTLyUjF8yFxKWzk0sx1gID0tS+PLgVPAlmVgRQ/e15wg3W+iDWo4aX2DmdUCmOAW5g+wKOF978zvF7NKkEPqCgCnwsHHCDSTSo8VR9ywVhpyvof6Pv0mZsu16fD1c4BoEPXouRKZD74HVP252h7zVS5ITsMVqJLJHmudAjKYmwayyN+jgNiDfae/nRcoiRExI0A8qhQ1hc7kEt1JlTpnKMPOKm1DiLTznkmOUebtbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(30864003)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlG646rYEMAkg+5hXfA9zMGYz09+8ewseNvxMfgfMwsbnQCWCGLK/DbHJIPD?=
 =?us-ascii?Q?F/9j4R8Qi55FZpg1XhnS1Pxzpcb1PRXMZZ0LDy8Qk/ZzNCgrkD1Qvpn/feFZ?=
 =?us-ascii?Q?KuNmcNCpgqjuRGgetWtj820u+PEmrH0F5bTLrpAuMHTqSoYZLl0H3seZDsGl?=
 =?us-ascii?Q?AcwS93zIhHeUUVscx01iWn/RbBzumYFvU8sV57YqLgo9G1fvQL7LUKJE4z38?=
 =?us-ascii?Q?9qReiwOwZwIjPX1qeo4Q69b5QtkpESLPIjaUJ0UWKec2gi/MyhPGzUAg1+bl?=
 =?us-ascii?Q?kEBj+zoaxykkBHAyuW20y76U7AjrGUXTCc+tNfRCA5hhHmJfhkjCNpVBqE9l?=
 =?us-ascii?Q?zpODNO1eckg0jaW3JFi8kQcwqfIZs3lGBg/GTDm3s30mBSc5Sf83eBmbtOMX?=
 =?us-ascii?Q?IR1smz7KdS/9oXrze15ZyjmRV4E4wjBJcRA+kRzKgflf+1AIUhFkLR5y7BPn?=
 =?us-ascii?Q?mbECsvtRXHTLovOgQeWpFMnfmmA04tEizvTz5eK668YeRPhezqZ8Dz34EZBL?=
 =?us-ascii?Q?DyYzcN0vgcRsOu904zOsY/cvCebavft2lfNqRvhqMgsJXPle0lmBLGBqpxg6?=
 =?us-ascii?Q?7dpod9SldhqZVAgUhW6uI+E49JKjWGaIY/ZDHE2jU4M1jF9orHRfJ5Lbf94Y?=
 =?us-ascii?Q?geH8GrSMqPXl889O9Vx+S6DDjcxo7rkjKnDaR3qIpI2JgkMTDDtx+5ixPH1F?=
 =?us-ascii?Q?5orVj8Y8SwhLzfpSn13apiGji1QcDd2XKzyOyue/MSmnY4+wDygTD6dX+Le7?=
 =?us-ascii?Q?ym4H0MJE/1TeiieKJRxuW2heAdNpYySu0fHPancRX2XNB+Zo7l6nUF8YHB9u?=
 =?us-ascii?Q?RodXE+0ILISx2QkhKgoUghp/EsIWsLvmf3Rm0CKBcaWxWsVcjZRnz+KIdKDR?=
 =?us-ascii?Q?4rebPna2LZEWm/Q5IEU9peDGw3ordM3Jlw8qIENov+Gl2EyTvWiXGw5qbQjF?=
 =?us-ascii?Q?l2gbUc2c46+XCq6zcUNZDYFFQLNQuxQRH1Va+u2viAAGQPAGcT9dQ+/Sv32/?=
 =?us-ascii?Q?bcpTrzSnVz1+u9cz29/Cke4yPwdLg09jljt8GLRL8ZcNH3GWmEZ4ailBRHTo?=
 =?us-ascii?Q?1nKCHI963WQS6ihIQWtca1bPn2IM45j/OE5GHphGNc6mo+pk0xH55ishSx82?=
 =?us-ascii?Q?0x0M+9OJP2rRXNIwSezZXgdNNsubF6ICnekVRlKSoKqrzq7pPj4+fdzWwyn2?=
 =?us-ascii?Q?KPh2FEeio/BAw6VILW+eKVRyfQaOrbVZd3Sh+/DV7KvDtFaaU2cBFp2iiTM/?=
 =?us-ascii?Q?Ev/KDvEomdGxbcZ07ApJQHzsftSBlFj6yjP2DZVlPV/24xtIupaZBn9u3iNn?=
 =?us-ascii?Q?PcVPj06/oc9eQpCtWvtCM93I4cXQw7hFCKebJQ1NAbv1LpLgmc7pGeAnojMw?=
 =?us-ascii?Q?g+dtD/g2o33wZyRbJcgfMttS7k36jkJWciDBKw7cCHHa0FoVrsGuAZC4DM+f?=
 =?us-ascii?Q?iL3pEU7sJH2dL0AVQ71IHVavqtNsXYB8f9Y2gYoWaRgQeiNWRZb8vtiE10Xu?=
 =?us-ascii?Q?Q7CwmC8eNLuFzDTJhJU8Y+x4w7n4TBso+n8lOm9/i13tyFXrt52MaD8+oyn5?=
 =?us-ascii?Q?q8TrjWh/erkSRBKP1TBe1MqPmaDMN7GbI1DwCtSEtAia2Gl0FJrI/yG8bGyv?=
 =?us-ascii?Q?CB4krAU4ZHV7HIdKDlFBuLsdb3hwCbDzqFp9op5UeksNpPjnN2e6sF/GbGgH?=
 =?us-ascii?Q?YFBaiIKbaBlNgu2S7moWIUeUjiGogQ+HO+CyYDcOh2nkX0NYsRFA4SecxRD3?=
 =?us-ascii?Q?dn1wYrxpfD0mAXEi+yiJM/0uzQh9dn4=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187b9e7f-39dd-405d-4c61-08da39c89f84
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:46.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk2W505u4Vc0RRgjbrRy9gtfGahrHUoUr/iGJ6smVz0rGPl9wgmVjHUihXzVpmvJ7s6wQ0jvBGqLYo8/QrnQNK3ix79MH8zftxcDAfLxVzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0301MB2546
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

