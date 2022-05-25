Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70D0533C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbiEYMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiEYMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:10:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310843702C;
        Wed, 25 May 2022 05:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKTWcya2Lpc/jNIwexAgU7Kc6AX1vQLPUN7Ylkb5nmauwy7ql+vhey1mgAQg9wcy3cQSaFLLk7hoeONOYFBT9w4fzIY21qCmIqLd4xKzz8uEBdckCOmD/qQErCBXOrAgRNPMjze/4mghfL5nAehD6WZ9o6AzRfdvnFRWWDkMScppAr2fTiC1Rw0cFZ+v4z6Bv58OJoVrHU7DfZOu2XkWWSOd7qBs7kjnLyEv9b11YUrX2n/gAmr5/Nc0yXBOnfQRcHNmFUCzCaCpLjl03kRj8hzC+dVgyVoVwb66FjMm3dqFL37f4uihPxJGp6Ar7J2P/0uQRNDUpHcJbzrKfYn8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcKT2rGD41c87K2O1iRJ31V5GDwZK4XBCIPBZa2Bzec=;
 b=TlCMEIBXcpauiy2d1c1KMbUpCjo52ewByux/85IPTXsc3CwG41YvSxFIntcBXUmOb2oCIvOXJ/5zZgQ4yUaks4hqxRz47NAuQ1D0aEWdSXRPf/TQ21OjWR7F83CnChigUk3D6GF35im0ScapDptzpnYKVydj9SUOJ2KFpdXVWB1efuz96fbxBpE17jFIrmFL6bFwb8zNULn57Uj3xbrtvrkDN2TcRSMhzBaHcDTj1tdS3CV2Lpo7lLdlE92LpAnKvovuUtvRo/royc/fRwInkMWUD9Um4/lpyhTGPts9idXl226XOSxsMo7NQqAxVvpAeJlxLwrivKIh1wT0A7gyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcKT2rGD41c87K2O1iRJ31V5GDwZK4XBCIPBZa2Bzec=;
 b=NIZUTFpNysn/lkwET4an5l1rFwTJLFnyh34LWc7C7IQhtFL9xAS33KpVhq2qa7BAjJDobG3gXMwondARCWoYfsd0UIRXxuhQ109m8dI+Qjxd/yAdIw5Bn9DAFg9ZJp6JEJNdLn5nBGhrsr3MmHBKe5m6IXXnsPV5izTHWl1kAzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:52 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:52 +0000
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
Subject: [PATCH v2 04/12] irqchip: mips-gic: Support multi-cluster in gic_with_each_online_cpu()
Date:   Wed, 25 May 2022 14:10:22 +0200
Message-Id: <20220525121030.16054-5-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08553885-e854-4e3d-f188-08da3e479ce0
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB7859D901C8C81DE9851A8D67EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUDZu2cMilKV4e1EkNffPHiJq3G/CCah/VSqwC+nTUw/y3tb1zjQR8rKGtuOrXUIUEib5t72G1WgPSHyaZQ0MjwS35RLcYyJOFs9eNvngejNsi+qlZwJ1CbyMy/fSxXh2hS0hzxczwASQIX2IyqSUEoGsE0DnYaRVC8OB7c0fppo8XVpQBMPISQYQsvDD6HnAYmqiv6mzjvl73udpAtjl6guqiMm66AS4bJvChehxfTh6LuUDJRA6NOPj9oVgeDKMmrFUT26eLQR3yHH/fTYh2lj9RMTwwCQfD4/atoX0kZfZDC9cuIourTw+Bdanzq5U4hwI0+7DWg41dPpvyGsbTFlHo1yT1rySJRLjp8OHmlmeixryOZfx6VTIs70zBgnScN7Z8/ysvpR2qZ8r0Gi+AtTyTwZu9/4IXiKUQlojt0oJiJMwJaHac0dB7pnbTPdlCsT5NmNXY5MjdhJyViQRlgLFd8PZAcHfcUmAbGdcq99o80tQym1ygqnUuHbz8aN4CGAN9pviPLLVHw9EqmZtvg1jfNm3As9Q6PUPWSRppx+8XtQ+SfEubfWl21yykJOVG2etPBD6e+f/CIBOqEo+4+eMx44/iv3SEJWmgYf4IJxCoWNswZTKoasHsenKjf8GORTFPjEELfpPORJY2axLVF4muOpSXgSnVmK0SjXES3039eqC0ZoUY77VaxB9tZHvc4M/dB9+aMn9H8awIs1BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(396003)(136003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0K9VHDF6FpTfwGoCsg5siTT/GqFNEdbZugTz4gcTBd2YNggyVpjyIR4TzRFq?=
 =?us-ascii?Q?iyB9o1djySB0KwWcdntqRiq3ql1NC/QPSMMNsWBwSOFPWQGik0p+U6ErkYSA?=
 =?us-ascii?Q?GGMWK7GBoip3XWqhy4C7kLKwwjysg0P1n6Uh2iVYTWEFPU0khhGbls5NGW4P?=
 =?us-ascii?Q?tpH6w6ZlMDNj6WakvFGGFF/PFPX9vM1lrCrfOpkCs8+VryLZPYwQlGUCbgDQ?=
 =?us-ascii?Q?QzAQFq2RKQTl4Ic+MCBiOggzEM0BxcHlhIvfSuJOVSc7iS21PxXMWntSfN0r?=
 =?us-ascii?Q?kBdsBFDTT1dwqc3d/AIIlQTxdzqHY4YoWaRmOhQY1xclutJDBbUUX4hkx4XM?=
 =?us-ascii?Q?E6s8zKFZC8cF42Zi1tlspe+TStlO/Mt+E9QwpMpeEYpg/tw5rdInuBlUrSex?=
 =?us-ascii?Q?A+IML6K3f3FXcgPRTizvCt1TUERWPs4bcj4d9GBR7p0Q+ik6MfzmQfDvHh/Y?=
 =?us-ascii?Q?h3wCCO9bY8BJiUz/210VNijqWUiBMivmNJdBVR6X6JjZExwGsJ75MN2Ebic+?=
 =?us-ascii?Q?XvuS6UArgJeib36lJ/dp+j+yhVmN7+9qxv4pZnwupSbZ6EeTzLZ1ACM2vSZm?=
 =?us-ascii?Q?/ph7hoaVGwHm3oT/vd7gNZefkT+E7FmRWFkTkOMVoEnnsfpgsnX0WUrzAqCs?=
 =?us-ascii?Q?rUVINPNCagQZjZmUsKd+2rH/yXtV6zKgl+WCbfN0UrCiUgQedE1GrZaaTqf9?=
 =?us-ascii?Q?f9A/chiPdjYoPlsUZgCJgm6BBa2vf1H0ulK0WK1B9OovuwnA78A5EZ32P9Uf?=
 =?us-ascii?Q?iVkroXTFFkNXG6Iq7tC80TAAJjeC3w0vztYTYFPLNxcVYNpBCvHszcugMh3i?=
 =?us-ascii?Q?foNbDs26lvDqHs12w/sJVaZVAorKHkbfeQ1lcmGb+OkP4jz/7wNlDW0Kmxtr?=
 =?us-ascii?Q?HPgkx+uxuzNSN1fIcKc4uTT7Ibcop4R9q+x4/2l3gxUk4GYLSi/RUZPA+FA3?=
 =?us-ascii?Q?dHs4WmeO5aMMO88HfKbdYDiPdnRMeJcFT2AZAo6q75pSyNbA06nAqXHHJifl?=
 =?us-ascii?Q?dnt7BKN9TDbx67z2mXjeQNGgzGEu048ampjyhlVGuCKrbaLU29S3AJdA/tLi?=
 =?us-ascii?Q?qdlAHAbOfkjQy2n5MOR5D+NExde/FGeETzdzmgmwxd+Y1JAlVaRbo15bhBKq?=
 =?us-ascii?Q?+EzsSV/IsoUcMvD6dABPOaE/0/VASgA/PWZ2gJiJC+FvLnCSdlk5eOuqvjmM?=
 =?us-ascii?Q?lDIkythVhMZ6TR1HTaemEA6gehD1yRCFx1jnzgzeRUp92dyZOFvz/2kHNjtp?=
 =?us-ascii?Q?mMev3inQ+TahnvXyi3bYkfPSSvgMmCPxDmGJOaJ9LY7GgMKDInNpbVG3PV+4?=
 =?us-ascii?Q?fTXoK2aURseM1bM3t8899eRPgJMzg7haILeUYIEzcsdgTQO9RmqD1rD3ihpR?=
 =?us-ascii?Q?I4pEjeTCt7pevFaOIc3uL6dJwHYiRBvqiCdylfM933JNRWIKPdO44JD5gQ39?=
 =?us-ascii?Q?OTyzT7EoEiKI200ZfaVAk0N8KZ1Zzy2QyxVGupHDS3QrAGSsIXxYoowqHYph?=
 =?us-ascii?Q?f5on7rgjCdpnZ9EjzWr8cT/UQ80yqWwkfiYfSNyy3nRyTJO7nfJbhCEwKjyu?=
 =?us-ascii?Q?vX4j79PeGoYi5eLfzBiAt0RyNZzwLZI7edkKT0fAZw9idQr0Dz0gZWXXbpOY?=
 =?us-ascii?Q?HCqoDmpD16X0kTEL/3/abfc2VOiafkF9kxLVhno630YqaSgm/nEls6cc78Th?=
 =?us-ascii?Q?hH3EwGHOjk2HOOswxpOfJ8JvRkMCJkfdUrzv/MPcggMnMHUe74Lg1U2QyHYf?=
 =?us-ascii?Q?FDddNLJ0CenHArIuifEONmYVtjGgS6s=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08553885-e854-4e3d-f188-08da3e479ce0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:52.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Bx+8/xxVBNsTSOxOlQiiGCwo8JlB/jkgGf3GFHsJzGAyTgjw/cTVCvyEpDBLC+/j45yHpX1pNFmQme46LawHJmEs6OAjUWg3vfUduRFutY=
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

Introduce support for multi-cluster GIC register access in
__gic_with_next_online_cpu(), and therefore in its user
gic_with_each_online_cpu(). We access registers in remote clusters using
the CM's GCR_CL_REDIRECT register, and so here we delegate to
mips_cm_lock_other() in order to configure this access.

With this done, users of gic_with_each_online_cpu() gain support for
multi-cluster with no further changes.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 4872bebe24cf..89a3c6d04e09 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -69,6 +69,20 @@ static int __gic_with_next_online_cpu(int prev)
 {
 	unsigned int cpu;
 
+	/*
+	 * Unlock access to the previous CPU's GIC local register block.
+	 *
+	 * Delegate to the CM locking code in the multi-cluster case, since
+	 * other clusters can only be accessed using GCR_CL_REDIRECT.
+	 *
+	 * In the single cluster case we don't need to do anything; the caller
+	 * is responsible for maintaining gic_lock & nothing should be
+	 * expecting any particular value of GIC_VL_OTHER so we can leave it
+	 * as-is.
+	 */
+	if ((prev != -1) && mips_cps_multicluster_cpus())
+		mips_cm_unlock_other();
+
 	/* Discover the next online CPU */
 	cpu = cpumask_next(prev, cpu_online_mask);
 
@@ -79,10 +93,16 @@ static int __gic_with_next_online_cpu(int prev)
 	/*
 	 * Lock access to the next CPU's GIC local register block.
 	 *
+	 * Delegate to the CM locking code in the multi-cluster case, since
+	 * other clusters can only be accessed using GCR_CL_REDIRECT.
+	 *
 	 * In the single cluster case we simply set GIC_VL_OTHER. The caller
 	 * holds gic_lock so nothing can clobber the value we write.
 	 */
-	write_gic_vl_other(mips_cm_vp_id(cpu));
+	if (mips_cps_multicluster_cpus())
+		mips_cm_lock_other_cpu(cpu, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	else
+		write_gic_vl_other(mips_cm_vp_id(cpu));
 
 	return cpu;
 }
-- 
2.17.1

