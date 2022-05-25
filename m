Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78360533C68
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiEYMLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiEYMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0764705D;
        Wed, 25 May 2022 05:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUdj2Wtx5mhR9iO8wJGu6OTHw0RVUURUOXXV9YmWmrvvGI9eW/e4l16ek1bCQLztnBwlilKfeDprMnVAis6i8Dnq8aoOLgqO98Ccl7hpFU9l0dyAACg9sPUxZ6AE4msQ9r/noRQKCvlpfamPJITDx6mHuwcRlOQQ+2bX8RQ1K4YDvVIJczEfxMhwX/k24bo5Lf2r2tDlLFYIgwkatLJvg7IwODN/1To2Q8tHQF7mbGxIDQDyAD8mva8Dn1S+WV+Er6E/52/I/VB2vep0omaIfCP95qoeYY801cUtczvYx7POyIsxRcash7Noy0kA5WIQ7IP1NTuloA8gkEe3mBAy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBNx3ZFNgDR2q4qCeIKfyifemJaS8Pk5MHpQ+ZzuJQw=;
 b=SAY/7GZAs6UYF6gSgMYlv7xFXKoZ8Ym9+BEJLVU797IET15aOGBWdGnqB/KYAekzNX08sUfBQspKo1x7z8yTBRJONIa4UwyTPiEXBxjzqaE9Z80g1U2kRmkY3GnxKfP/kY79WsAVOWmjSEmW1oTV30msSTz8bNyoFPHr2tyM+yspR8e48EsAzZ4p6ktBdQH8Js2KPwPRqLlG+fWfrK0Ps41AolYGpC4a9D5Fojbxm7ZCDOAKyEwmpsqi5oehF8WLjsQBbCL3GJNUAYaao0e49nEG25K0wngrMPFsdcf4fdWmFOFX36nwvyonqHarKyUShH+j3FE8JJkIFWnrYgGMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBNx3ZFNgDR2q4qCeIKfyifemJaS8Pk5MHpQ+ZzuJQw=;
 b=eMxYFdsbpqdnoXxop73p5vMy4hTxwp3/rnkT5iXEeTWBOIL2FxWd1D8ws6PXLleIc6A9ADBBzECsxp7FeXM6iyEUM5H1tBJX6v1XPm1U982yO4WVJJ3Pm3LozjkL9SPnXlq1pMjQkZ24nG8acoYUUuDMPsUNr+dEuMVXt5/gRig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:56 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:56 +0000
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
Subject: [PATCH v2 07/12] clocksource: mips-gic-timer: Always use cluster 0 counter as clocksource
Date:   Wed, 25 May 2022 14:10:25 +0200
Message-Id: <20220525121030.16054-8-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42273378-62a5-437b-8abd-08da3e479e65
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB78597D2F444109979F6F6F28EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZkdy9QBhP73JFPw6ugDKIijJE8hoPgU/NFOqCs4EO8OI4k7RFnSvsFmEbnPx0cCkdhFEkEa52uNGGPVDI73Rw/tr+5HueJR5DDITGdwWpniETijBEMg6dk8mxMu0RuutsF8BgO1fz07Hinb8vbwJNqHt3eBSpwlTVz1yQWhy9GR/2HhUW93GxxPCZLlkrN4LVvbZpWhFEekrH+nNCtSSHsi7p1Safwu8jW83ax4UHUoar2jgKtiRq2pjYbcwvQNnCj2VgrXE4ullHZ2V0bGoLq+bf1/L8SfdhFpwx8AeaIw5Aia9i8bpd7A+tAu5r3la/fyVUcuFnVNTUTJyQbna3OHub12LWlgk2oRi/RzhpP+XJ5wsf4tKW9AqUaaN5VDnEipZPBFU83YPY9KOiqWHrNPEe5dN/V13rExiOtwdwpFWx90oOT/yIUpawAYIX+Y6b4ru0GczWzRSej/8p+61jbIs8mzkPXFBQGbY0yopqyVwsR6/V3QbXPky2kYGty3TBIveKU61faRKKwdP6HyvSq9ohvS6WPEfQ4NnyoXffBCavMbjIVbCvtUhF3Nx6Ifg6TC/mpQ++HOrJrYGuDra2ZLRluggALpB8GesPOrNean6dUma2i50WUxNc8LwfpyZSDdJyJmUf9h0887mJhasWAO5z4wwlFasYOlCwpGNFjzXLmJF2CKUizkWkW3EhDk0kJy3TTb+3I8XOP4M9+PMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(396003)(136003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EaGecUmoUeDtLPxDP4PA6X3TwCgacAklvydvGZZ67PF30P6Iko83tTm3sEuI?=
 =?us-ascii?Q?pRGSL1OiJCQIYqymlJZaJRCNn2PLrb10dqJruW6FkPJetO2df/wHw9w9HgT2?=
 =?us-ascii?Q?70HpG4Nt+788mhSywro32Mq6mdy2HSTlqeviYAq3u8NBFNczefJE04phH+cr?=
 =?us-ascii?Q?CYYk4AGkIKPjpCzmgu3vMbqWQatSuptZGPtSVvOpRm/f8MtWLIrdr1R/m18H?=
 =?us-ascii?Q?+Ls8jvw+rJJXPB+MfgPUKV400dGPHQC2KHTpMKk/PzjLcq9MQyewuFH2j3o8?=
 =?us-ascii?Q?RYLG51T6cKrUON7OVGCxKw6X2MU59YnjR8PU1I8RMBZ4JLCheqAfTQXQpxEP?=
 =?us-ascii?Q?Gkzedevq9vf0JASAvGOGmNLL6QSnLMLkasrG/hjybwWLdhB4cyxwloIEnDc7?=
 =?us-ascii?Q?XODG/153dNL5CBH7il8n9KjnAEO+/YchhN2D9yrNIoYHG8B30xeYiWIWXDni?=
 =?us-ascii?Q?nxzDw8WTon0MBSjpkDDmHBkJ49w5DrN42KVBiwpIssP1zPKQe94Acfi+2wny?=
 =?us-ascii?Q?vMA5wL3AcCSqGUzHZNL3bw0r1bZx48ruo1qK4bZrKvZbKmkhaYmi5fGGtovi?=
 =?us-ascii?Q?vxJKXR5kM+XahqEeylu57uB1U8pBygHil2gHvL4TvCRd/ir50lFOrENatl98?=
 =?us-ascii?Q?kdWCBBS8PGmBNe2wDomSAXdQa/WBCf7a88CyypWYHFleFKzixuLg22liLN3w?=
 =?us-ascii?Q?ynKkmuzbRvH6BbU1ZE0Up8E2Koo50ibsy2ghRvKktKSB1O/VMVirFBHL/4aD?=
 =?us-ascii?Q?HqRSthLxs5yllTwC9LuV/auH7tTjRmeikGX2CshQ3XbakmdtTnJ/121NlZle?=
 =?us-ascii?Q?uBTNolv6zTBNCfxwZIaxbTWXFI9Crit6wKAb3aqfXqtea4Z9Y52OCQzlxCDd?=
 =?us-ascii?Q?dfkc0AiTHCbza67z/cNYsvkkt75A9Rkk71D6y/H3jHO0QC/w+XaieJH4iB55?=
 =?us-ascii?Q?16vd98FdMEvgF952T/WBDv2Ln65z64asMXF+jvCXY586hjs0gAsvRf2YnRCL?=
 =?us-ascii?Q?Njrrnt0AawW1OtUskmHCCOzlQ+TUnD4CGbJvrSoUN91jnmS/DwTrrsxS6n0N?=
 =?us-ascii?Q?ERgJlapmwSA3R2x3Vz2zap69S/qcilx4kV5fyojoFf/VQnUfXjaxJljzvL7I?=
 =?us-ascii?Q?gtgdTqaodlp4wQmpe0elAGilqopdIuzGK3fT1X9yI+9mzMIj7xc/HmPNov9J?=
 =?us-ascii?Q?iBPABb8cOLir4pZC9SH7kDKCN+tiBoE8rlRHfQeHcccO66irp4RGrPNMVlPn?=
 =?us-ascii?Q?WSO+GXjJF8IB/4ak/jm1mxYPiYD6xjYCjd2wWRsHEcl6mPmNUm2MKhxo5kbR?=
 =?us-ascii?Q?fazpkY+kTI/8u8Bx8gBlDD0jpFwwZILwfRKtQs1MT2cRD1bv0sNVJR51xkRd?=
 =?us-ascii?Q?Gk8VZgVCPPaZB64ZNIhW2NZ4s3A5LF7OCs1wtTJWFa014QKwfirFlsOiDDBJ?=
 =?us-ascii?Q?TDlwlgZ5HwmUBMuiVxjz1KtEnbS0vwEygIR67n0vTfLQlD4ueDrml57lnx3c?=
 =?us-ascii?Q?Y9G2N4yOwicoDVRCh9qxlV8JXdHqNftzn4Cyx/nQDfUYJ9VlijU8XLj+kpsI?=
 =?us-ascii?Q?RA3deUrYNCmc23L10Aq2wV120hb1luEZKTSKPGEigkS3pFbl+dPDHB1L32ZU?=
 =?us-ascii?Q?wzteevOsh46l+r8FDIdFu3dPT3Sk+Ga46Z81RhMOWMGziTrmAqdGqhGmfds4?=
 =?us-ascii?Q?CqWC8zDUIQ+tjG2c8IzVo7vvDpQOAjqoU9V6GmOT4pq9vynBgyV/085+81kg?=
 =?us-ascii?Q?/rTbN39a+nnRXNNkciQH3GTYQjWObOs=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42273378-62a5-437b-8abd-08da3e479e65
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:54.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zz/7qd/BQ2M2x1cnWRAxJJHRZlmm4mZNMM42uk6kHnB3x91C7jA6UGqze+HfGRNJBTgf1e5lg32oa/5+R8Dgoob8xaT9i1bTMeR5pXu4sDs=
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

In a multi-cluster MIPS system we have multiple GICs - one in each
cluster - each of which has its own independent counter. The counters in
each GIC are not synchronised in any way, so they can drift relative to
one another through the lifetime of the system. This is problematic for
a clocksource which ought to be global.

Avoid problems by always accessing cluster 0's counter, using
cross-cluster register access. This adds overhead so we only do so on
systems where we actually have CPUs present in multiple clusters.
For now, be extra conservative and don't use gic counter for vdso or
sched_clock in this case.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index be4175f415ba..6632d314a2c0 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -170,6 +170,37 @@ static u64 gic_hpt_read(struct clocksource *cs)
 	return gic_read_count();
 }
 
+static u64 gic_hpt_read_multicluster(struct clocksource *cs)
+{
+	unsigned int hi, hi2, lo;
+	u64 count;
+
+	mips_cm_lock_other(0, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+	if (mips_cm_is64) {
+		count = read_gic_redir_counter();
+		goto out;
+	}
+
+	hi = read_gic_redir_counter_32h();
+	while (true) {
+		lo = read_gic_redir_counter_32l();
+
+		/* If hi didn't change then lo didn't wrap & we're done */
+		hi2 = read_gic_redir_counter_32h();
+		if (hi2 == hi)
+			break;
+
+		/* Otherwise, repeat with the latest hi value */
+		hi = hi2;
+	}
+
+	count = (((u64)hi) << 32) + lo;
+out:
+	mips_cm_unlock_other();
+	return count;
+}
+
 static struct clocksource gic_clocksource = {
 	.name			= "GIC",
 	.read			= gic_hpt_read,
@@ -204,6 +235,11 @@ static int __init __gic_clocksource_init(void)
 	/* Calculate a somewhat reasonable rating value. */
 	gic_clocksource.rating = 200 + gic_frequency / 10000000;
 
+	if (mips_cps_multicluster_cpus()) {
+		gic_clocksource.read = &gic_hpt_read_multicluster;
+		gic_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
+	}
+
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
 		pr_warn("Unable to register clocksource\n");
@@ -262,7 +298,8 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	 * stable CPU frequency or on the platforms with CM3 and CPU frequency
 	 * change performed by the CPC core clocks divider.
 	 */
-	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
+	if ((mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) &&
+	     !mips_cps_multicluster_cpus()) {
 		sched_clock_register(mips_cm_is64 ?
 				     gic_read_count_64 : gic_read_count_2x32,
 				     64, gic_frequency);
-- 
2.17.1

