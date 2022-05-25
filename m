Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D547C533C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiEYMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbiEYMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93037BFE;
        Wed, 25 May 2022 05:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgFigp4Ltaa80PKN7OQgquI0Po0T0ab1ep8Dn3VcqfNkkl9fINmfhynz6IwZIoaLAjgLUJxwq7bVSlISi6VqA7U9rnf5U2C07gdUSD5ce/V70Csq5F4m7bwfWAvJFyJEpEGUerQrKIr6MkQ8V3M9huUsWijg30k0qG8Bp08081C5dDgrgGfF9fjWcHVfX56n5VS3j2Zm4w/CW5beia4GOdjRCea9Y8IJVMYze0t57/yzIehoIUuSO5QApG5Tkgi/ekcY9E0gvV2bf67IQcEEpP+MuwvsPvqTj4CQx9UlFmJWHtH/L0aUZuUsINlS1uTHiQXjMfd0b47wlU8nl2nzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25nUudV+xC8kr+exSg+5l5E2X7yNcXVJY9JBd7K2bmA=;
 b=hBc828gnvdLTYtxkMhLeayKHdXqIcjPLnnhlr9gvL9GF+wB+uNCeTWStMMQAPzJqJDPqe8d8DuHaSP3A00Cvj8Hg00pS5duAtF8sOZmhz24YVuCXqmX3a7VhOEJYeYlmPNfpbRJAZg5glJzVn3KFiVoPlzCXD3GUFek5qN7G5wJHAPyw5iMmeJHVKkr4y4mO5UIxBQ3YUMm5P6t+OTrJ3D4yGthpNcYZcr/9WIEemb/y9e0fjwnWjOhNzHO/zpLiRiyVhn8pCsoSpjpi8ZI6zlXQ1wU4Aey394Dw2q3tW+3GqlSQpMzlmjPOznkqYdAak96vAKuoLlXgL4vtWpMF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25nUudV+xC8kr+exSg+5l5E2X7yNcXVJY9JBd7K2bmA=;
 b=PbPBu6DOSspu7kkH5BJLX85ZDN32SJYxapLnTyZlW74jngAgUf7jeq3KWMCqo9/XfPUGXCfSVjwjsOAGpAMz6hfcGkoqPLsJDJaeodgxE1AEdclZSXXW82d/SOw4MwJtbgiTNjfuprGrJZRhdzUfsADnOaM4wAbjRxKlp9IkTLI=
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
Subject: [PATCH v2 05/12] irqchip: mips-gic: Setup defaults in each cluster
Date:   Wed, 25 May 2022 14:10:23 +0200
Message-Id: <20220525121030.16054-6-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 039eb4ac-a435-4a41-5ad5-08da3e479db0
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB78597D4DD09EA4038C53801BEFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uApgN61tI/oYuq2l/wGjxVpfGotMTzB/Ltn+czBs/4akeCwfs8jFsQ3LV3NFjz7EyhkvC5CyvntLTNIPKMEMJJYVwPJ+lz7zAdRi+F3wYi+NJg25omX8iyOa3SNMXkmhYuxED8GFtq10rgqVnP1OY95MDSu9RpTrTfhsYw5D6iJ0YyN/HwYsMrS4qNV2JYNmhYnEJwEKhvWSLklT4dsVV12Tiq31pyzVD62BsoHH3l2b3HqvasRm9jCqi84d7Bl8qLd/r3PetBbPOyUU7ZliqMdwl4Xx2D6IEQ+QoNsEupLgatpZFqQOr1yfRFI1wJmB7RHZl5KThA0MHQKsSxE6QM4iUz02FTgfsc0pirYKkCkncC0rnV4Hnk3hy/GjZtiOvIbJ6Ww0X6g9VqkOyFbwsHgPiM+7ev4f99tqsMxOl8IKB9PgxWZypIO4zL+v006KNaiWy5xdARqitgWrSrrxAsXZilHFfpeN4B5SchSbNz4MVfIa/+nrni7SNWobA6Ez3W3Sj9u0XIaqBx4tKwKbb3Iv0k4DG76OM5wGsK36fZh7uKztrVmxeUR6MpZrZrE1hSKNOS4LiuZC5m6v8Nj29KX/Q0Puf4xH+IPVFpDZWNxv3YGKf5qzIo7DDLCVfY0et/xI6XFWjMWZBhiYbu845vr50knVPBXC7ek7FArD37u1mLcMfpBMRJ4q4lOQ4BYIhhe5vzWwvLqQOsGMOKzwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(396003)(136003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlYHyZ1v1HwtfWIbgk4O0y6Nh9wX04waqdT1zP5YL7Ea5j5/PpHNCY1K9wX1?=
 =?us-ascii?Q?nFPhH1bqFEG7r9u0JVjaehudaAIq61/vbC4161RpMe/sFBGe6i6WAnRO2xMh?=
 =?us-ascii?Q?3euAj6HRegMx0VRWkWWpfkOD5NxTLmGSam0PinbqaOWVHbpFjWggG2BHR9ME?=
 =?us-ascii?Q?H3OtGfY0lms7imnucpKa/BufHdQcUMPbhMQG2dBas/RQOoZGNFqujK0aHWbb?=
 =?us-ascii?Q?UXQkp7oD+gtEkCerHOogc3p/fcMyYhm9YyuqlH+FPYOPv+Ti4fZhc7A3YMHV?=
 =?us-ascii?Q?QAVd0n2mGMjvOlPtwatMiTYXE1s/kuG/goQaFyrQ+BjRtCPlx7tdPCbgg1W/?=
 =?us-ascii?Q?nRpEVObEjw3vb5pXj5j+ZuN7YBCSMtToy1sIbKJbBxDJxJgQbpr2gI88GSFP?=
 =?us-ascii?Q?LULw1Yp9k+FguDvp+A0y9QJH2CyeimkLoaHX0lhedHolQ828Cwrqc6pY2CkS?=
 =?us-ascii?Q?c9Y5gY8BwmTgs/r2Z/AB8bZ/rX/kkh5HnY/FFbER/0IdRLhdDj78Uun80xgP?=
 =?us-ascii?Q?ZRvXxhK7+gQQRfH8zvXSR6aq71jlnqqr1CN6mxryY+ujeCOaghYCzKTW5RDO?=
 =?us-ascii?Q?E3cTxoIS9X6+RUoyQPunPrSdJ4SHxkqLo0mfv1n/UQQdr4cvip+usYpnh7rp?=
 =?us-ascii?Q?0tAEc5bpFpWY0oyWWdf9vND2VIHkg93QjGlSme0QmxFhggMljhZWQU0iHxh5?=
 =?us-ascii?Q?FHAIy/4l6jBRDCFTkIS/kpakjASrl1Poo8WLphNa7ieXe2YDAmtbKKFI+phh?=
 =?us-ascii?Q?QKEJn0unEy1LZ+peDkidTL+nr3lnVAhJyqzr/T+uVNPI8VJJhdCCgItkHdbv?=
 =?us-ascii?Q?gi+DDav4ZPmx9/2O+z7C4njvOEIeHpQ+taE8ozbEqDI649F4rvr32iy33pz+?=
 =?us-ascii?Q?9I/JOp1Wr1k70XY3eYzMMgvLfDaBXBlS8ZvH36L13OWWkdNiI4CgXBHmyB5E?=
 =?us-ascii?Q?urS4HU+/j2/YsqCcmZdL3y2XBS3+IaY2dFQo57yTkMUnhEbbJD24SF3ykAZD?=
 =?us-ascii?Q?NsE0ysHc3ApemVzqe92OigGbTnpUrJJhoCbWNW4i3RU6x0a0U0AEgIlZnx/M?=
 =?us-ascii?Q?m9Sb4dnc+nl7dmm/OX5Du5VttGZdbhC3DBYvzQGtsVRg+GQppB5HMgNQH1oN?=
 =?us-ascii?Q?SzfM/BDggwJKQ4A+9VGZdqPzeuuGz8uhnaOZ86w2MuXlYCB0gb/rYC++rQCO?=
 =?us-ascii?Q?PUF1AVeCgR5M/l3VBLo4F3wgzScPp54iSZMQjaRdFt3/H/oe7Mb9uUe32Vc7?=
 =?us-ascii?Q?H3MZ79Ojdo0E8g6vAQdzF5UzUNGChtJVx/PzZ3O1gtC41Mup4oyrWh1+1OQU?=
 =?us-ascii?Q?jrHmHkSWxYDPW70tRVzsFQySzF2c6iiLlrCrKiDF9u/m4wkdL2fXVIWoKYjH?=
 =?us-ascii?Q?as23csl5IJ4z5sZJzCzUBdzmhpD3ysfcQcivMhvnsqk2ys/6YU3wzsCFgz1A?=
 =?us-ascii?Q?qW5svJ2xn/5fWpAA/Kbyk85M2SC7bR03sKXu9wb1DVksMivfPiuadPZWSaQV?=
 =?us-ascii?Q?lxcZNIWOwXbxTSLthXR08b1TC51z1RYnS+HILByY3i9nGS1gCJ/VglO2NCs7?=
 =?us-ascii?Q?TWFicvETijK5p5HAjNQACy8yi0zMHBRT18/1QdwEvWXq9b4pc7gs/urDeHUV?=
 =?us-ascii?Q?F3pVyCAdweQAYeOF46+mUzuTxPAUi7cY4Vu/6H1CIfn5bOE6NaZuChn/Wghr?=
 =?us-ascii?Q?zNWZb2pUHc9MeaFa13i1sh341fJOXt8uXmDdI+p+K+eRcBMmw3+PDcSo2+Ls?=
 =?us-ascii?Q?DhcY0ECw1iNDmQJhPKTT8sCIjBFwTQk=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039eb4ac-a435-4a41-5ad5-08da3e479db0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:53.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFHHOhRT+y+o5TQPRncnXPjs4xbVq2zNhjHG5k0xHW6OeEJQKnqUHEjdMrPtXHShvUPyf/yy36waoKBnmwEVcWPNc01o7rEnGfyzV93nUWo=
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

From: Chao-ying Fu <cfu@wavecomp.com>

In multi-cluster MIPS I6500 systems we have a GIC per cluster. The
default shared interrupt setup that we configure in gic_of_init() will
only apply to the GIC in the cluster containing the boot CPU, leaving
the GICs of other clusters unconfigured. Similarly configure other
clusters here.

Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 89a3c6d04e09..f692392666a2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -741,7 +741,7 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis;
+	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis, cl, nclusters;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
@@ -860,11 +860,30 @@ static int __init gic_of_init(struct device_node *node,
 
 	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
-	/* Setup defaults */
-	for (i = 0; i < gic_shared_intrs; i++) {
-		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
-		change_gic_trig(i, GIC_TRIG_LEVEL);
-		write_gic_rmask(i);
+	/*
+	 * Initialise each cluster's GIC shared registers to sane default
+	 * values.
+	 * Otherwise, the IPI set up will be erased if we move code
+	 * to gic_cpu_startup for each cpu.
+	 */
+	nclusters = mips_cps_numclusters();
+	for (cl = 0; cl < nclusters; cl++) {
+		if (cl == cpu_cluster(&current_cpu_data)) {
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_trig(i, GIC_TRIG_LEVEL);
+				write_gic_rmask(i);
+			}
+		} else {
+			mips_cm_lock_other(cl, 0, 0,
+					   CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_redir_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_redir_trig(i, GIC_TRIG_LEVEL);
+				write_gic_redir_rmask(i);
+			}
+			mips_cm_unlock_other();
+		}
 	}
 
 	return cpuhp_setup_state(CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-- 
2.17.1

