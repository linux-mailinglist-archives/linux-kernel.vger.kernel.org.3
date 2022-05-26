Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA00534767
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiEZAR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiEZARZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:17:25 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46D3666BA;
        Wed, 25 May 2022 17:17:24 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGi2Br009363;
        Wed, 25 May 2022 17:17:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=UgpZMzsiAsNse96ubsnkWGGYK7KNOuTMhFnpxoZnZQI=;
 b=w4TQKFW9KyEjS48B+6R6nM9REExm+S8dkSMv3YsvgxMKR9i0JNrszJeV4p5kYxDi+pQ1
 G1qMfwcz0/f+N20XtWucdkVeyfRjxnyAOQGIjvy39I67qRgoWeEsuJZd7rLPdQKgDyU0
 pBdZQOvPR9JWmRuvfJHBaNecMLaYDDTXJZI2SNUng8HWhou2+mOPf6283XlUkUPd1rrQ
 ZBtOWnet6beFF4fObU1/4wx5RSl52OEvOZqewd8oBiTONIuOpyD4W1YGu/7x0UgNFgJe
 /uL8aTvHqO95HpmffRKf3DE6MNuY5h/ggpyt+dYn9H655OC6gifl+KF4JAMC+OqZVZNg Yg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3g9jva1kjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 17:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU5/L3Y20qFYyQZcdyPFoqjNp7YoqGSpnt4Iz9fIlgqywCrL81csgxYrJDmAPerXeglyLFKB7qPD+RdVXVwvgb52klxyjfYA99OokHkpCR2ZBMi3O3/gFnOLvXxnDniDj5GIRtZonwMIOjcWLVtHKDap65lyzna3KZLA0zIZD/mrZPtJeYfriFY7+VU6zzpdmurYNrmOjBIQdwvURGnAAqLzxbsvWjxLgRZEf1zplWU5juA15WnP1jSOI+W4MvCwY4SHagxr6jvkKySfKwgqLZjCa8wwg44mTEnunv0y0YNEY/MiQykrYASCkvo+2nPLLWL9HEeEH5dAwnP2RZumeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgpZMzsiAsNse96ubsnkWGGYK7KNOuTMhFnpxoZnZQI=;
 b=mHIzGFfiEge4SlXpJykca9/jEz0ZMEhfYFuCF5hSvetXgdSeCpBRd8jRrvcrRCwk18Kp+W0ChD9S1UOMrvGwUBGQ17d4B/0qWYuVBO/Y2XlgoLRk7/u14C2IxatfkwPGbJ8Gmoa6AHMUg5oivlJijlixVBfm2+MNX5b2hh/igLWcoAD4WkB6/wHA8drFddkPkCWz826MBWbpE4JURNOlVmD4A7c7xb2GC8XJFI6FW/Pfyfp6xDYIMegboO2ZMDcRfUJZkmpQJhH8X2O0lC/Fey/syVx6gC7CK+/hrQG6mVgQHZNfD+KTqpBEz024ajzMD45Tjl5U7cyOI7t0IeHWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by CO1PR02MB8538.namprd02.prod.outlook.com (2603:10b6:303:159::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 00:17:13 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3%5]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 00:17:13 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com,
        mtosatti@redhat.com
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v3] cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink
Date:   Thu, 26 May 2022 00:16:59 +0000
Message-Id: <20220526001659.96786-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.9.3
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::16) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d71d03de-45dc-4df7-d526-08da3ead151c
X-MS-TrafficTypeDiagnostic: CO1PR02MB8538:EE_
X-Microsoft-Antispam-PRVS: <CO1PR02MB853866F322FFD2C3D35B554680D99@CO1PR02MB8538.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLkpb8T8MDgUHIlxtWnYgVfgbtKsZ0O21ZN/yQd9cTYVHq5PFoi0nevTmw2bH+I9UBngLHj6kkvPlfxknAIA30DdQEyZKPhgeCyd8ffT+8a14fm+EdjZCh5uNo2kuHFWVLhtYASnSmLbYKNIayCzMSYJ5J36aYstehJjPz/ctTSec/gSsTGycYivh02VYQouWXSQjlOAtRElTUk/aJ5iFtfewBe+wVvSORTHDdQlHDE39wDiZCrdT0f3J+4IwMu9aHdKb4Fdknt/xh+sm3TbZqTLg7XpX4a5IeLk8UjApduO15asg5Rx+s12ibLbvJq1n9QEVAlTxEVaGmcWrGErnUT1w5rvaDqVQiuhEXsxnmYhtb9wxLbUVZIkD3+oyoNNhP5vMvkX41T2UluVkdhtcG+WjjhrQrsmFeY4WUWDLjg3pcCWoUdJnmVO6Q0Tuzb4EaKXzcNmfvur8CqLPAoVOzoy1x5HhJq7gq3re0bEIciFjxB2Zg9QJVupv8gsKrv4+ja8xi9UEcBsWI0Elj2QMoJYrqjesjS8E7zkd4TEJr03UxuJ2gJp0Lkfv5fnSXHOzbM5TWJi5+FR4NanMUZxQ56Ie3YYTfSfkuPPBLBSqsbbOXL51qqUpsFUCHckIvZC+ibag7QBxzwCRJgXhOa8VNvU5cLyRlDdFMJ/ca27sscAZYNqH2PqDsmKhGT+omDvPXgOm9swpeE+TmbGirw6Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6666004)(8676002)(66476007)(44832011)(26005)(52116002)(5660300002)(186003)(83380400001)(6486002)(8936002)(508600001)(6506007)(2906002)(2616005)(316002)(38350700002)(38100700002)(36756003)(107886003)(6512007)(86362001)(4326008)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WLwFrbt9+4ocNtCmUuKEO4aamSiaWrK17PVsphgeNUnvn4NwyK2nG158iXju?=
 =?us-ascii?Q?f/3XXvuN6zGY6rabfgkne53iGMWyY5IFWlxoVBX9rhw1GZEi6UDrML1sfg1X?=
 =?us-ascii?Q?nlSMa4lsnZf9H2NKJVOf+/XYoFsK2ATvsHBZZW3EIdv/c4M0S+CxjXh2MYTb?=
 =?us-ascii?Q?pFB+PdZrdeDAM1ZwNj2JimnNPzQhbZAYBVHSUEnyMOg6pIJjY6G3e700wpE/?=
 =?us-ascii?Q?iOBKgvtQln3imMqB4hrP3F6I/ShPGYWRflCqRnlFxsunSNG020TA1B320J2g?=
 =?us-ascii?Q?9eTJs2ZnBhjvcvayXsJ6orqLRyjmIMe3UPlRSRGmKgYmHbrKJTuSitZZGRS3?=
 =?us-ascii?Q?X1iGFLI6VNMuEjwjaotPwH8gsbR22TgZA4F58pmUWWIZnIIhEnAfnGKZ7ly3?=
 =?us-ascii?Q?j0kzw1gJi1oJ0opVhzBNVMh4X4GyKg4p88EqQ9175JnSeAGj78axYLV+E6wZ?=
 =?us-ascii?Q?utZDlNEHNzVxL29JUVDhaGIUQ7x3pMWgFPrMxM171c41gLjON8uLINKFb1OO?=
 =?us-ascii?Q?h79MowjiK3d+7kevnSVrVWPr+UWqFLTlwxqUXdSIM9SToOzbvsi3LlOMfXW5?=
 =?us-ascii?Q?wcHjypEmLkETMIhvdXijag2wh/twUbt5RL8whicSdrKbIl9EuQWAF7CXMAt6?=
 =?us-ascii?Q?Cu8Aod30IB308KaJopzjbAEMR8W+jHVR+0Tiz1P++7ledjJ1YL3njdUTVCyL?=
 =?us-ascii?Q?rnLIPVTwyuiSyi4XgNGctSjkPCBwVOB5JByUQ0Oc3VmmOcPQ0bJTLqJEh2r2?=
 =?us-ascii?Q?U4akRlKQsbASKhjGysgDoj5NBS9/VZGGeASgyZf4/1AHGms0jfe9qmONgkpl?=
 =?us-ascii?Q?P8O48/WfEuycFW1Kqmy7y6xNoIKGQSdZ2qFnkaqDUk9AptOqFkDQMsV/ummH?=
 =?us-ascii?Q?HFqYcCs9fr/6fhQI5Hy/9pk/iFOOmw30etvsoEnfUq0TFDl9rJ8NmvScnCs+?=
 =?us-ascii?Q?oqFjSxE2A/jE/LZ76o9yhO8dmXpCjP+eHeLd266vWTTCTUavIfh9wgy9jXJ7?=
 =?us-ascii?Q?ifSf8Nkor8wQqWlMbrnyh4tcqbCQBbt1QXW81IxCQFH10dUpCRCMKNem3Pbp?=
 =?us-ascii?Q?iIOQupAVO5/hcGCr70I2uKjxIjer9YNVyePNJqp3XIdbqWPQCB8et0JCyo4r?=
 =?us-ascii?Q?Vog6VP4VixWJrgWx76kbujiJtaphUPmRzRqarUR1AzLvzJ8b3FjpT9HIv5s+?=
 =?us-ascii?Q?2rhKPBpyKXLJIh8vVm7gceR6MQ/49pF3hZ24jYCOrkhMcIMSOarZk8SYooPC?=
 =?us-ascii?Q?zfG3IoejpWkOWkrrHSRM34XuaQshLwvOH+ZgKAqg8L7vHbIgTTk9atcA1UGQ?=
 =?us-ascii?Q?8iD9dA5bcuMzq2tOKq58rEGaFbqGKhX8Jl8T4kW+JqUGpP58kIyDm59Mhtb9?=
 =?us-ascii?Q?q95JLnA/di/v05lx7q6I6dqh5spJ+REtpcHQOGMgdGN9rim6TAkVD7iBPuZm?=
 =?us-ascii?Q?cmxnF9LbGCJrSdZdQI8Fmhk15HMa7pIZfoQDAabZifnyRusPCGrTTK2HI9Cu?=
 =?us-ascii?Q?5S62+AJopCMi4qRPyDzLrGfiYQXygzsUAeL2Nvs3iDfJuG+Ae5GmYvvqeJL4?=
 =?us-ascii?Q?t8gXYatLZqKmKg563g+1GWGLYWsu5IHa7S3Hepq4rPJ4zw682Sp0EyKZ7KXB?=
 =?us-ascii?Q?tPzzygl/KEvu03vRWIubqUa5PXYUfHp3uSr0CGV7nzfQvY11AfH7q/qn5mtI?=
 =?us-ascii?Q?jk3hrVI5SrsKnM2RqYADZ+KW9GgsuqzLGhFs0DFrf3pbRV5hWS7q7WCC/cJ9?=
 =?us-ascii?Q?NHHpxieJlbJBe0snmBnrGOrSGgXoDmM=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71d03de-45dc-4df7-d526-08da3ead151c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 00:17:13.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZb5WeRyWmLiZzXSNVx2puxMQiDMJc7naiLq+JOMlsUfqfhyvraje+f3S6wJhzPWHp0Sut2d7zeLXsvpOVHya8Ml5rde+fDshEEsj69XvjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8538
X-Proofpoint-GUID: d5Tp9_PtFS1bqygjQUQp5MVmsOAxLZZf
X-Proofpoint-ORIG-GUID: d5Tp9_PtFS1bqygjQUQp5MVmsOAxLZZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_07,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace points as are implemented in KVM host halt polling.
This helps tune guest halt polling params.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 drivers/cpuidle/governors/haltpoll.c | 15 +++++++++-----
 include/trace/events/power.h         | 29 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index cb2a96eafc02..4c61ff8f460b 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/kvm_para.h>
+#include <trace/events/power.h>
 
 static unsigned int guest_halt_poll_ns __read_mostly = 200000;
 module_param(guest_halt_poll_ns, uint, 0644);
@@ -77,13 +78,16 @@ static int haltpoll_select(struct cpuidle_driver *drv,
 
 static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 {
-	unsigned int val;
+	unsigned int val, old;
 
-	/* Grow cpu_halt_poll_us if
-	 * cpu_halt_poll_us < block_ns < guest_halt_poll_us
+	val = dev->poll_limit_ns;
+	old = val;
+
+	/* Grow poll_limit_ns if
+	 * poll_limit_ns < block_ns < guest_halt_poll_ns
 	 */
 	if (block_ns > dev->poll_limit_ns && block_ns <= guest_halt_poll_ns) {
-		val = dev->poll_limit_ns * guest_halt_poll_grow;
+		val *= guest_halt_poll_grow;
 
 		if (val < guest_halt_poll_grow_start)
 			val = guest_halt_poll_grow_start;
@@ -91,16 +95,17 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 			val = guest_halt_poll_ns;
 
 		dev->poll_limit_ns = val;
+		trace_guest_halt_poll_ns_grow(val, old);
 	} else if (block_ns > guest_halt_poll_ns &&
 		   guest_halt_poll_allow_shrink) {
 		unsigned int shrink = guest_halt_poll_shrink;
 
-		val = dev->poll_limit_ns;
 		if (shrink == 0)
 			val = 0;
 		else
 			val /= shrink;
 		dev->poll_limit_ns = val;
+		trace_guest_halt_poll_ns_shrink(val, old);
 	}
 }
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..c708521e4ed5 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -500,6 +500,35 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+TRACE_EVENT(guest_halt_poll_ns,
+
+	TP_PROTO(bool grow, unsigned int new, unsigned int old),
+
+	TP_ARGS(grow, new, old),
+
+	TP_STRUCT__entry(
+		__field(bool, grow)
+		__field(unsigned int, new)
+		__field(unsigned int, old)
+	),
+
+	TP_fast_assign(
+		__entry->grow   = grow;
+		__entry->new    = new;
+		__entry->old    = old;
+	),
+
+	TP_printk("halt_poll_ns %u (%s %u)",
+		__entry->new,
+		__entry->grow ? "grow" : "shrink",
+		__entry->old)
+);
+
+#define trace_guest_halt_poll_ns_grow(new, old) \
+	trace_guest_halt_poll_ns(true, new, old)
+#define trace_guest_halt_poll_ns_shrink(new, old) \
+	trace_guest_halt_poll_ns(false, new, old)
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.36.1

