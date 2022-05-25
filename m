Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DE2533C49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbiEYMK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiEYMKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:10:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B96326E7;
        Wed, 25 May 2022 05:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwgMrwCbGaMMHWGt4hrxDoddueDC/pQundjwZ87F+KYj6jwdmtoNgKz1lUG0/XXiOk0NR0hHK5m960XK1M+rFtD4Pw3PRS8lfzHX/tZu6TacgrsZwFZfRBxmDuORYa77EwpybzZEBJQNLe4bJ1tZnQVbga/2JUQqS56aBmDi2pws70UZjajPcJ8NH0cRHsEaX1pxxvGbfFtG6p4ka2XTOdyO1rC4N2Kq+sHuWS/CtYP4uBeVgqjbOiMe5ZnCvoYq0pCGy43qwwopgw2VaMShwRRiDEk/4cNXSE8y03IgGLIEtDJtYD5V95W6EKoAAu5Js1Fw2VXA3ruN0/Mq6QGnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/oWZ/jvCbIQLKlwtiAukqc4yINNXweiXNHqy43By3g=;
 b=LAz00SKQPGA0mo5hxZ3B/PPycL5GDp4lfRJGlTXJJSeXhUxF/QTEY3jhOYD8HU8d1hgfxv7dBiAN342qPP4mu2MlhOhJjYzwrbMFdvuewM7LnXSezeor4L72Zy/2k2BLpCDZMx0ELYix2L5do+XmxA6+OPBb4FxDQe+S2ksPiqXYSxJM0Jpo/XoOdMCr44PBaTAsWPXqY8IVRyewdlAoxYl/bScT4EChqaR35mAhXmvZV9G8sCWGeFjR75w0Fa5ze320G1KkiZOOnxneh0+rCLJkbfH37oXRQzgPXvo5kYmayfhpohhugB6Sv813ZYbpCAjSQoM4CX0OObIOgJrwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/oWZ/jvCbIQLKlwtiAukqc4yINNXweiXNHqy43By3g=;
 b=vT+v8fEvkZh8IfiAokdkvf3ycQl2tPEQoCV0+GcSFGk1Lv0evyKlyZK9bjQQQ7fBNIWdp0f3b79xncVssBsSSR1GcTDy3ZSW/1+LC/od6ULmXmyF8VwmsY4HkE7URSAmwPiyx0G4aLoTw98ml8OOUTCXddTkWA7AuI2SKHY8Huo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:50 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:50 +0000
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
Subject: [PATCH v2 01/12] MIPS: CPS: Add a couple of multi-cluster utility functions
Date:   Wed, 25 May 2022 14:10:19 +0200
Message-Id: <20220525121030.16054-2-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27d64dd-5084-4509-a430-08da3e479b89
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB78592DBADCB13BD74D220B37EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqwllonDIYK1TI39o0jQdqkw0pu1yWwScNTEkCP9Gk0a7clMzJrThdp1SSKdHiF0LS2+yGigdDwUkV8pJwPpM+Uccd1nObpaX9pGt/GbI0h2/9umk+5lO5pf3LGO/qnHsYjXEYDDiK9J4V6RPHgyhsKgIhgdzHn5nctIjraanWA/4TM0SOByqxNIWf6rJQ2my6uPQJTGiAY8U0U+IVzYOob1E4RnyZATFTwoApbORrFv1EzcVu9vXnqc3J7h2krb69qgRgF3LNKLLyH34hb7iP09nrOkwTpUlPVOPPlIBkAi4PuTaPp7djZXxObnPWkZuu8Cago+DhmvbjXBkUW5dMSGgulT388JneNDbVmb3KTeyv7B96zvw3nuaUHcyWwDIymJMOpzAAHjakIDIzA4TN6rNKHuDgI+BfKqKC4iiuxVBvRysfX18vG20i3RI3tdD0G4rKuGhElaibzh6QaBJzPQSw4rf4eltfKO8zHNeq+AkvjjmTbkRWh+mpGjSmx9+6mXaB2ASBkBEzr8QI4RF2v7tpQl5k391diFALfh4Tyu7y4QdfPWhS0oTirs4Ztk/kmU6nTEIcmj8zzZC8DWzBsD2T2/buH78dc1Jyh28UIzcCeiTSAHVWTiFTnWlMDKttG/j3v9m6dPPG0bCdtLLBdourPG2HQgcoInTVzYziPI5e9E/VrztZ9wp2TChEpHAWB4z3RVmUIZc+aTVGALgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(136003)(39830400003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iUk2ozzNV5HeC6PX0cticKjqx1Lm/KSiKIfZgECfbRUP078jma1/ZDNXuFLe?=
 =?us-ascii?Q?Qt0Rt3YBunJmE5PI+g2mKowIDQPiBkNmDNVlruuukSeUmhLYF9KkrGpXWyUr?=
 =?us-ascii?Q?ioCVuGPhX5fPK5PmFFnIgWcST3w31H68MvfDWrxxHvVfZfoQgaPfDnoDxqCA?=
 =?us-ascii?Q?6KyMIiNmkIf+RR4q+mfh84gDZpopuGsTk6TJOUTh2ZBOkUh/83vWCfMDAur0?=
 =?us-ascii?Q?VrHt+JNC+kz1dFeUX+jI4Jo7diSHqUbhBAOdlSSNlq03k4P7tKGdLljnPcrm?=
 =?us-ascii?Q?Kt+ZzmtRLmXYrM4TzZyxUgQeC07EQJ9tOHwC6lEVJcaZhuKAonpUMWJJOsa8?=
 =?us-ascii?Q?S5jM3PzHSWnhcLB/1Zslw9m1g8NQfcnu0l9fGIJQlQLmJbE7mja/9nuGggzO?=
 =?us-ascii?Q?wtU28ZUVcTcA8ZF7MgnYFh9wFbSrPxjl2XVxYSoTxJoBOQbNn1hN2qmbh5s+?=
 =?us-ascii?Q?tiyk91UTOsOOTxYRAC9z/cge6J2QbAzmzHT6Vp1qQmG1vQkBJuGvKTukf/rn?=
 =?us-ascii?Q?HUnJMGA446wj9bsPZKX+b+R9e0I/+Y0GARHx2FzLnuJYYb7AKOFtPLlUEIK9?=
 =?us-ascii?Q?ceKlmEFNSIf9Yc54xwMlT2brPimAZ4CzQL2QAcOPqK4aQrPPN+BBLhZvv795?=
 =?us-ascii?Q?YSDby4FaxSDeR7/bF2V2Zi2C3SAadj+lLu2fHRfu/gVxbuerncC8MIxEk8DB?=
 =?us-ascii?Q?u5Alqkk5n4o7+2C7E0CfqFhR2XtHp0lOfEhJTsoHJ5l3jjMfPe8fqL+sPYiI?=
 =?us-ascii?Q?3BVA6/AHiUiEoU1Nbxc2gr7RKs4eMLFaY5CsuKVZ3/0YftAQdcjV6JN2XA4X?=
 =?us-ascii?Q?8W6wBLubN348oRWhA8UxVX472nqeiBMN/sBGK5mKAA1Q6QP5qtGZQXZGAOyg?=
 =?us-ascii?Q?mGFFjtWDWz3L3xdu0sIp+pb0em3moM+5avjZYgYl3lgGWorv6JOpr45eDQoW?=
 =?us-ascii?Q?iXI8oqsl3x70zmuQXbqjKZn5j5I/d7LOOHZMBUVeXY5Qvhn4jEBwna81ScBA?=
 =?us-ascii?Q?L2SfVKo5lyHSNIuNtcffbqmgz2fuo6Sqf6hSRFVG8hTlybRRatZQBIDXck4L?=
 =?us-ascii?Q?zIGkQ+ZDVTjI2aY7ej0H3oX500JE8nzC2+1Rours2lIqN35ZpOgS4OSU6ixt?=
 =?us-ascii?Q?YZI3ZM7FQHTd2ADqw4PTJeaKJoEY7CllUoPdfa6KLnah0n3qe0Kpxit3zsrl?=
 =?us-ascii?Q?3uU1CpCY9dQZd95f5HbMjNiorifJmQk9leNcM63KkrRcZ5Lb2Z7iv6SPTFKr?=
 =?us-ascii?Q?RVddtJEsdFTGL7aTRPlhjCCnJekrrI+yS0D123Z5jUqmh+dwoDP34K8KDRzD?=
 =?us-ascii?Q?oyYC1f6RbkWMdxr3QwhGRCxbvKtRtstsPGXNEamqVWHEJx7vpQBkBqghyPXO?=
 =?us-ascii?Q?F1Y6T2tDsmQWQiW8n9qKK2yWNAnpxGUXJ0GHK9EZ9NfoV7Gl9aHKcXu8ieU0?=
 =?us-ascii?Q?a1WRRKgJ8ZQ7tbQMijjAke6yOXU77A+7umHCnrrISopRNJXPMYsSEnfNfS9W?=
 =?us-ascii?Q?619lwh+d8UbPd73RJnUH9S5HH+tmdAVUohaXwuMgX+IkWtD5JXz5bF9OaaC7?=
 =?us-ascii?Q?L3H+uoblfaX7EYwomEQvv/thDp0cQbmtX2X2fVNAeM2DIaQPDRbYeUrkTl6G?=
 =?us-ascii?Q?pC4B41eRsfV0xRzWjK+VeYdL+5QFhpcR/xQfnp2B57caglHPFn0a9lOSivYC?=
 =?us-ascii?Q?eWe7BPZTz8moKS7w1VZ5b6VTmyJNxE54nojwa5S7QpvR3j/6NtTjr4wDb4AV?=
 =?us-ascii?Q?g8ZrOIClNgqbUy5lIbKfrR+5LjkSsqM=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27d64dd-5084-4509-a430-08da3e479b89
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:50.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ3QCfr9iiUrJsD/1mM36jbwAvOHRoSYJj1FgWZgG+JQ0VaczWqcom0M9xn9ePQSABFttkVdbWiNIESXMwGf/39hZ7rzxLemIhaw28NbL3M=
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

This patch introduces a couple of utility functions which help later
patches with introducing support for multi-cluster systems.

 - mips_cps_multicluster_cpus() allows its caller to determine whether
   the system includes CPUs spread across multiple clusters. This is
   useful because in some cases behaviour can be more optimal taking
   this knowledge into account. The means by which we check this is
   dependent upon the way we probe CPUs & assign their numbers, so
   keeping this knowledge confined here in arch/mips/ seems appropriate.

 - mips_cps_first_online_in_cluster() allows its caller to determine
   whether it is running upon the first CPU online within its cluster.
   This information is useful in cases where some cluster-wide
   configuration may need to occur, but should not be repeated if
   another CPU in the cluster is already online. Similarly to the above
   this is determined based upon knowledge of CPU numbering so it makes
   sense to keep that knowledge in arch/mips/. The function is defined
   in mips-cm.c rather than in asm/mips-cps.h in order to allow us to
   use asm/cpu-info.h & linux/smp.h without encountering an include
   nightmare.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index c077e8d100f5..fa71cf3a25d7 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -228,4 +228,42 @@ static inline unsigned int mips_cps_numvps(unsigned int cluster, unsigned int co
 	return FIELD_GET(CM_GCR_Cx_CONFIG_PVPE, cfg + 1);
 }
 
+/**
+ * mips_cps_multicluster_cpus() - Detect whether CPUs are in multiple clusters
+ *
+ * Determine whether the system includes CPUs in multiple clusters - ie.
+ * whether we can treat the system as single or multi-cluster as far as CPUs
+ * are concerned. Note that this is slightly different to simply checking
+ * whether multiple clusters are present - it is possible for there to be
+ * clusters which contain no CPUs, which this function will effectively ignore.
+ *
+ * Returns true if CPUs are spread across multiple clusters, else false.
+ */
+static inline bool mips_cps_multicluster_cpus(void)
+{
+	unsigned int first_cl, last_cl;
+
+	/*
+	 * CPUs are numbered sequentially by cluster - ie. CPUs 0..X will be in
+	 * cluster 0, CPUs X+1..Y in cluster 1, CPUs Y+1..Z in cluster 2 etc.
+	 *
+	 * Thus we can detect multiple clusters trivially by checking whether
+	 * the first & last CPUs belong to the same cluster.
+	 */
+	first_cl = cpu_cluster(&boot_cpu_data);
+	last_cl = cpu_cluster(&cpu_data[nr_cpu_ids - 1]);
+	return first_cl != last_cl;
+}
+
+/**
+ * mips_cps_first_online_in_cluster() - Detect if CPU is first online in cluster
+ *
+ * Determine whether the local CPU is the first to be brought online in its
+ * cluster - that is, whether there are any other online CPUs in the local
+ * cluster.
+ *
+ * Returns true if this CPU is first online, else false.
+ */
+extern unsigned int mips_cps_first_online_in_cluster(void);
+
 #endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index b4f7d950c846..5b843c2ff077 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -513,3 +513,40 @@ void mips_cm_error_report(void)
 	/* reprime cause register */
 	write_gcr_error_cause(cm_error);
 }
+
+unsigned int mips_cps_first_online_in_cluster(void)
+{
+	unsigned int local_cl;
+	int i;
+
+	local_cl = cpu_cluster(&current_cpu_data);
+
+	/*
+	 * We rely upon knowledge that CPUs are numbered sequentially by
+	 * cluster - ie. CPUs 0..X will be in cluster 0, CPUs X+1..Y in cluster
+	 * 1, CPUs Y+1..Z in cluster 2 etc. This means that CPUs in the same
+	 * cluster will immediately precede or follow one another.
+	 *
+	 * First we scan backwards, until we find an online CPU in the cluster
+	 * or we move on to another cluster.
+	 */
+	for (i = smp_processor_id() - 1; i >= 0; i--) {
+		if (cpu_cluster(&cpu_data[i]) != local_cl)
+			break;
+		if (!cpu_online(i))
+			continue;
+		return false;
+	}
+
+	/* Then do the same for higher numbered CPUs */
+	for (i = smp_processor_id() + 1; i < nr_cpu_ids; i++) {
+		if (cpu_cluster(&cpu_data[i]) != local_cl)
+			break;
+		if (!cpu_online(i))
+			continue;
+		return false;
+	}
+
+	/* We found no online CPUs in the local cluster */
+	return true;
+}
-- 
2.17.1

