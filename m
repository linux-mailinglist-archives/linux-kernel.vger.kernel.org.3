Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAB52DD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbiESSwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbiESSv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D85C74C;
        Thu, 19 May 2022 11:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0dGAVuO99yiWKLmvHFpjPrCUPdgfmdmhSRLJi5iz1kw9Vbz95xIVw1VjxYB9yUj0gxK8f7l0acUfDNdBksh+9D9n6Ke4yV9ahN5Uu2I5uQT0fGbAK/SMR39RvN+VEu4kqB9vk2Xz5VnbMsgkg2RMUOhu7Ik72CGSTKtRphD9lrnSPV4gYG0Cth45KYZYAz7h/STOeNbAMxKqy5hLLsfchFFfpvwPSUkB6sEDLVS+/5zymhmwZPsMkolzSKWFAlIk9mB0MrBA+hO14Wc2ycjtznhQmmXDcURWNVJ51Sfh/OoCJ5492FgkSc62llE4WfFjs8jnwY5alUtwkhDKKag/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUBoIGVEFRtb71Sxfb3Xgzxun/PlSmYOBaKowscQ25c=;
 b=giS7gC8w+5EiFI4GCQlV/j3nqFNkr1A3oQcIGojMqbOLu5PoA4gV3YcX8P4SAwtshB75jBSB/ZbRS+fIJ7Zd/H7xKGnrhluiWnmnZ8ysjWCTL4UTqP6cvp2lPtcun66GFqlFtOsEVdWRRupJqL3c3yhvZDcs3cINVXmCiT4pQ+z/RxTmB5X8VAIewdRcrDKjNE3lQc8a02JYoxFUJmqU+IFiSERGNJs2bHJjCOrMwefyTImLj2APtVj7eRm/JcMyv+wXPqPSaA0MY1cDy4UQZjcRiCz3EyNkUoCLiEjAyg5w+KqlcoBUqmGGB0yHI4NvM3X3wGKOY/X8LL1nNKBG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUBoIGVEFRtb71Sxfb3Xgzxun/PlSmYOBaKowscQ25c=;
 b=RC+ktpWKUNk+qR+/SyJsCGR33+tHmnKVDOcsOaSiwEHxm3kQG4RwJz/Z9hnZju0DpnR6W8bTGd953IiQ5Ds9FwruiKAK/LF1IV0gE9bHye1r5r8s22IiRoFZXiLR7SZdxK8+lprTUiN1OUdg6Ew9WfBtYiAI/WQircThGWO7fd4=
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
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao-ying Fu <cfu@wavecomp.com>
Subject: [PATCH 07/12] clocksource: mips-gic-timer: Always use cluster 0 counter as clocksource
Date:   Thu, 19 May 2022 20:51:20 +0200
Message-Id: <20220519185125.11686-8-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
References: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcf21b88-30e6-4b5a-9660-08da39c89fd0
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546C6A8A36BD55B42D3D043EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FoX+IWwRnoHi9IfCGth6qfNfm3enhwld/Rn4bx6q+Uv+HZujpgw1T8zPM7S22NkhBswV5jvSgykAxN0hEpa6h3ecmtc4UlbV8P6+LuL0/22nWOssKtCWH4lr3NUgnaBIgZJTGtXjG/tclUOMhnVQTm8+fUtAwRMAfTw+OTy7QWF8VOl4sWrBnW6XLOr7TmCqaGdwfS0pgAMhUrJBBw468TdKHzMoiez5S6madZYZmPjP+RFSO4u7YiwKdBJ35Oqy+8oFU7jhV3XFgg2TEeHmnhfMfrnFzuLZHAqIYqU3107lLZsUsrCm5frXqUSnl401d/qu7nP8TVHrWwjrLZT/+j06sDMLMdMeqkjTXwsiZ4JuKT2mpJZcQcSJH7CtTRof0v/y5xvaypjXHufXcieH4KJ1e06toYjZQdOx935UHM3TndP+yvGIKK6PtPcwsyx1UfHsPS7Qo4U9OuSByFRlA533Q30bNFRpn150j8JSn1QtC4w0vtWLWEyUeOKEnCVjj79C7CkFSdLUJ7DMZUOFmZSC1ust355E4sFS0h6ezgGcKA9dmJJOVJY6secXvZtNBKbPuaaSvzCkDV2aTt1h83vsLyVzgRoBB5VLwU1m/Un7TH3/7a1R9Sm1mpMZzYbaNm3x46ZW4ikncfyiAgSh/SEba+ZLV7TNj+duXaUG2FJlt4Vqb1/SoA7bI/VNTml4nRFK+NgdkWqdtBLW5EJKGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHCEOZP2XRLJmXmHPCx8oH6FIoKeCKZtOdw8KC+hMpfOaHuK55Qcl+CNdpjh?=
 =?us-ascii?Q?T+exm0/I7kUzPWQBAsB33BI3EtNBEy/BmgDaFgQEB1F1AXri3y1fAVdlBhki?=
 =?us-ascii?Q?gb21H3xNpZC/UpZedHOriMcCQBMWw9rRgQCaCCVcSXBG+7b+Sr3wZ0Zw96HU?=
 =?us-ascii?Q?uad8WGI5sUFrPrGNaCHos8FsLFLAazbiD6sDsQ4JKqVwtTp8alg/FShDEA3X?=
 =?us-ascii?Q?9qDZvcTTiiAe1n9lJYzYMz1ufLAi0nqRgLKhfj/fECsZUx+E0aNtFb58j/AA?=
 =?us-ascii?Q?5ZkD43dRPaaca2iY9TF6RHGnLR5yWGqQP3y5JAeubumw6J9c4cLPbYuCMK0P?=
 =?us-ascii?Q?plKTORaO7ea9p0WIITlDHOae+NJAUPE7WFn3+1u7sCn0Tc6Id9EdWYpeKjXS?=
 =?us-ascii?Q?72t8RXrMR8ZrWrfCwoyPAuSCtNQnbhkyaq8/b8TS2Jwr+NLmN96rHQh9ZGdE?=
 =?us-ascii?Q?KPD1XqhE4Dre5bUCGhGi5JcQWtoHgkpo1V2RgHzJ1Yn0XUr8sG/s7YLw7efZ?=
 =?us-ascii?Q?myJ+z1AqZmufD/C32yd5YbhyqTu1Jv/FXVoSKhwAtR8eVUco+hOOvrLy6ZsS?=
 =?us-ascii?Q?XUU1iS1vfWjGJMefFaGEZXWqzvDvlO39td/uE2BA3Qr1VEwaNBRTSdkYvX0H?=
 =?us-ascii?Q?NK/0CySax2ckn0/FsIZafsrJxpxcdyiuuy/wI1UUrEO3ZcsrlCZqgJSj/DkL?=
 =?us-ascii?Q?A8s0Du4RJxTbpnsDn3qdDHjv94TuFg+1TtcQxpDL//u8ZtRPOnlge7+oLZ/A?=
 =?us-ascii?Q?iRr0MLXxaVdan656EwCinRF7y31DQiSHzQRiHXUo7NFPc/H1l1Ki5FlRx7/S?=
 =?us-ascii?Q?bE22UroVf9Rr2yPZ1kJtAtj9DroTTW6OCRwV/zUxQD1sXVOoEfRqOBNCAIM8?=
 =?us-ascii?Q?FR9gGuzXJDXO9j8gv5PnzKFZOVBpBhzeBwWqpq+ArMqoOZn2c9EyR4N3fEED?=
 =?us-ascii?Q?D/6dWi4QOoXL40QF6Q2i9nodMpRp9YD6j/GrpURgo8A+5APzYGqzfN0bQEMH?=
 =?us-ascii?Q?jw/qAaj8ZAa7CFm7zEgh9TOoKL+dpZFPQncTDMQ/JJEu96z+1+AL3BRj0W2G?=
 =?us-ascii?Q?qFlCcYTtuUqftXkh5OXev1sXMVsy2i5nBY3/qTpJfiggpd9imslSrsoHeSwE?=
 =?us-ascii?Q?EbXnmnUse0OdvbkX9X3MkaIRNElaoLMl3ofC924Pv1ORs2pSZ67ZNBRnsGcM?=
 =?us-ascii?Q?UzJjUaQa3g4Qdtu15bd0GhJeiq95pqVfGOeiz8MujJHVU0GL7SvTLOOvEe5I?=
 =?us-ascii?Q?2edMtqz8ocbU/ERgMCfWbABQkTKex81uwyhUqRAZ9sccxieQ3wRP/mkwAnYQ?=
 =?us-ascii?Q?3L7dIqG8BvRXR6aH7Z9geRdEFo3wciPgKksPnppiKyLXF5hqwM3Q1cmxK8O3?=
 =?us-ascii?Q?+EKo+hriLadftSiGOk1pXKk7bkpyKdSi5WTjuANOpHkSvcqvgqMBT9V5DiO2?=
 =?us-ascii?Q?8h3rd2HROdNlFn1rkuoxdTnv5jGdeqlgaBo8N0FdGQfs7909mmuJko9plhdI?=
 =?us-ascii?Q?ZQ9Heu9TN4KZAbrPFH/PpSMOgpBuRj0AGwFKctm0h2Pw6oeX+woruMYgiplV?=
 =?us-ascii?Q?kJHLdCFSN7mkCX+0TupF9DLCn6wv92Pxljr4USum/xwBhxKRl5FBbvSCL/lP?=
 =?us-ascii?Q?SufCNKtlNGB35ggAVh+wlPrPDQ50XWa8dpKF/OSVqo2/d4SUuoiMz9jbTPwx?=
 =?us-ascii?Q?wpNOrNn4C0MSg150UNvVei7+NT+VQLGgEOnGW9mTHf0nBXX7j+94dFkHTeSw?=
 =?us-ascii?Q?dX4QJSL+p51uFsELdB6rCBWl9+/udCg=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf21b88-30e6-4b5a-9660-08da39c89fd0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:46.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnhtigU2oHcJ1rYlSmnlyziptTHHMsjzCwp2UkWnBygVPhWxGdmnqzs2wae5K2HscOu38zvofr2a2QfyokZm6wgzE0KPCJgoNMIaeqZEHgw=
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

