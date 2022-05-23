Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E543530A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiEWH1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiEWH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:26:53 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019247AD1;
        Mon, 23 May 2022 00:23:03 -0700 (PDT)
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24MHmCuX022425;
        Sun, 22 May 2022 23:37:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=RBnszdSDMgdIlZM1Mzjru/X5vF4drmy9svjiXjbsUQY=;
 b=uavZXA+uYjGTDzfaPk5z+X1E4e6t0f+C23prjixwb/dTKTxfGgKW4zapOzsLcAs/CTl/
 8BhcJxTCvkwW1e+KrZ1CjNSvjn1hatYjaBzgI2Ok75zLKif14rMm0XuVp9827tdK73db
 QmEHQk360u1GwsC2oqVL5BRij2AbP5JOxzihnLUvidKvRkl3dcAy/Mnhj5mqonHXxKon
 xVEIGXdxH2WE/2GKkfE02M9jSThac4UbKQDh0nstocX7LxZgNleh4aihznfkyLi52war
 64vKPpjdqkuizW5TOV55HHZQbaLh1RaveufwCShjXNK3Cqr3/h3PbP+ZOHEza8ivVCQG qQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3g6ydejgwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 23:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOi+rCxchXsnwoyi3op7HjhN9KAvfcDsUfpoTw7SYGxboNT2HbqNQIjOBF9et3+kLWkUzBfMoSdj049FBoVyJlyUu5GiiOTOy1nM3pSnptrefwyS1sThlzWPD6+Kjqr0iaC76w2ZEeah9/rP8NIrzlYWP+7KqbwEmaA/qI6sekapmQOJcg1B2FsheGZ/U63Tt9FkdcciE73x3XehC2UYkgYD1rdpvQEj1OoSIAhWP2ezvKeRpNFiWS6L/YhaijCV/A90+Mui8zWskG7FgetAqaT4LObSjWw3nY3GDfqTikvl3InKGCu3y76kp9Ckjx+JsvXiPdxtj0qjHGZ18H4k5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBnszdSDMgdIlZM1Mzjru/X5vF4drmy9svjiXjbsUQY=;
 b=aZNw2G9U4g0H7MIyt4EVoF5wjdBTAW7gSgIi3LT5Uq9W43QJB/hYQ+BvCy6kD7+CN6BuCvpSqaRRVGjN036JdUU+9sD11X4wA3g+NnOe/BW1IRnv8qogK0Lhv0Coffie8ZxwkK0qniw3x/qrei12HKptAbGj1oWTwJEMLYtU7T+GCK6RrEatgE3qPOjwrSBANJURdC4fjyeMJH+ARoyVWpYhY3avezlm0Qr/79o7xqbwFaeEaLQyOeZninPCAU7fDFs4Fl6QHKnTtAuPEcaNwx1HGHw0T2eIrLU9EfJzj4YlwroX/oXDm4ME4B4bGc1bBqUbaRvN7C7ah5nBE0rJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by DM6PR02MB5945.namprd02.prod.outlook.com (2603:10b6:5:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 06:37:31 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3%5]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 06:37:31 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com,
        mtosatti@redhat.com
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH] cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink
Date:   Mon, 23 May 2022 06:35:43 +0000
Message-Id: <20220523063543.99335-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.9.3
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:510:f::8) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec84cbc-829d-404b-d564-08da3c86b677
X-MS-TrafficTypeDiagnostic: DM6PR02MB5945:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB59458E5E6D0B433ADB57F64C80D49@DM6PR02MB5945.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NcqijOFYzDIXTiD3t/bwbVK8xfQ40JYiEcmet7OKKT2dO63UukunTEBoS7CycAMirfee7cb/2pKicKnm39t9KCTHBUul4+6l2AryTiAwHxMXdOuIl+SC9eWVpGYAJ8IqgGrIO6RZPgCp739ThiqJHCTswIYM+r+t2nWBrYTZTEjvrGmDWWxitpLdb8taIxFh3jYNOT5p2bT9UxuB6rtKF4qwKnWJL0mzEGvf2CQy4k4OvmRdC2hoAVbWwn9MgBuFsIRAGkkoqv8O5yMOcgrAbZJtoh5U2bEJcbHAxFvFJh+g3ZSz5o05sedd7G2WjT4V90PEgKd2TAPNBgdmQ9J5P1F7mt3E0baZZdoYwWg+V1fQ5Z6/JVnZIEuLHrTsPYcDkFENZFaXbof33lPLSsgnESfTicUo0lmjyTfTIDARsl5gJ9TZNWLJXjMc08nqISp6Qm4dCEXiLgA+yaPTBXfPs87L/Moqo+EgILYFr9WABOkG+5KYN5a8rWR8Ld5sOPpyMiPdrPjKoBWLzc4uXCVHoOWDJTMPvltZRTkxizy6wU38n75IBA+kSluoXzKp6jCmJS3a+r2cGyF4pp8Z9uS5DP11gCOWLFyubmQnSCm5X2z9J7v9VSs4Yyv3pCGnQWyLl0mKXoCJaQhKennj++WFatsU8V5XsWsikV2tEb0+X5dBRwBcQiS+xh6bv47FpeGx1MwPin/uD7cwjdSSb1r4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(36756003)(316002)(44832011)(38350700002)(6666004)(6486002)(508600001)(8676002)(4326008)(83380400001)(8936002)(86362001)(66556008)(186003)(52116002)(38100700002)(26005)(2616005)(66946007)(6506007)(66476007)(1076003)(6512007)(2906002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+kClSS9u5g8AiZVflNZG4kDeXx1ntiCuLvqQ64TEVnHcTsIIWGXlN6feQGN?=
 =?us-ascii?Q?dBlSg+kSizUUjp+uDk2ze8rBiDKVY0dwnfyCNc7f3hssCxsQJUzdQuR90SeX?=
 =?us-ascii?Q?b1X9vEwsOQ2JOXEcWc8Xizp0zQai/5EGbhOe4+YDncqCn+WXY1vOy0+vMZDE?=
 =?us-ascii?Q?QC3Vs/el6LiLDu5cox2JldtxepjXNCsKy2uoaeuOtuCvrstLFgSV1dC0+sNf?=
 =?us-ascii?Q?XRGgc/xn56gFoQ++5ApqiTwtn9rZWtSj0r0vUE1UrNcFddiw8//7N1CkwTlx?=
 =?us-ascii?Q?vwfu0dZqSXwlsTQzFdmZiWV87sLv96d6QB23L9CaLSnwgf2MFkX5czo9tJWT?=
 =?us-ascii?Q?POcCl/GTYvgxN8dwJr/D980mOsCjOTUzs1oJUlTqC/8mGq7w3jVqSdJk882q?=
 =?us-ascii?Q?LHUfPAIRsfrKiDjgowH5Vlgv1BlWZeMwj95y5fX7HOpHW594umZlL8O0uuju?=
 =?us-ascii?Q?Xi57eNMgK3sBmsj87wzX2wpIR2lkD/W4iMzAcocxPeMdy3AgwtvZNFHK87OA?=
 =?us-ascii?Q?r99YPmzt52Iy5Ek8Eb8Ayl72rCcYwuKT85HbejoTdnoAU7YrH36cbx/7amYJ?=
 =?us-ascii?Q?s0r5RZa+v0OLPrhi8xMCyxJ2FAagg9/stw/et+5lc7eJbWlFBCnDrX0aRAZg?=
 =?us-ascii?Q?E4+7rUkTlTU6PblAeQDya+axQ67YSQwa5qvymuScUIZSKgRigBsQQymCq4LQ?=
 =?us-ascii?Q?4DYoeWQcBX00nimUm8PDNhHvEyrvAwi82b54L+zxovYryKunOukKiTmXiEdy?=
 =?us-ascii?Q?Ff5rzvvBPaiDfjIbRVR3AIPzM1KcmEfBttZ81NPflLU9z86tKOFQWO7XOYIM?=
 =?us-ascii?Q?laXe4fYFrZVRsrUTpBI00J8HJoUeeYgZR0se1uyDd+OpzKhv0LPVLTxGY2tJ?=
 =?us-ascii?Q?jk5QFlE1hKq7/CoMb8jbuDcHAQxxSmkib9khcEKngQyAMLcq7+83Dx0c2nbC?=
 =?us-ascii?Q?aujvkYf9DYWS/6H0uiJOID/ClTEsORXQdzQijEUdCCM/H+hkg1Ls4+R94LOz?=
 =?us-ascii?Q?qt6fgejCrU68wdit8FPbCM/tF0eT+VOygE71RNhVoxNXU24UB3WXxGmNQcOC?=
 =?us-ascii?Q?XKhwcS+I0takoZhFtWynXtjrjCTKvtCbX5NiRB/14qFg4O6h7L606t2OkeA8?=
 =?us-ascii?Q?gWoUsG2NK8UuRleWjcyo+SM1YjwjN/oL7tWiKgHgfQtNnRI+D5Dqlm7banTZ?=
 =?us-ascii?Q?IM+dBIQyyx9uhDETEouSClBU8F3KFro+bQnfwKSl7j+4aQMXNBffVr+Ln4/u?=
 =?us-ascii?Q?VV8pW5XmcizwUBuw2cTXPsnjI5NZRS1EdMPMRUQ5mXR6xGkkIzqGjygB8f75?=
 =?us-ascii?Q?EL2aKpSGY5gWW0v5a2JfHaJ9NVEHlX/4qiRV1RUOh15I1wyE5uBy+YdaYYXe?=
 =?us-ascii?Q?mwQzbgt67uSTZPjm15WaJgreh/F71Pz0VChbOuNFw0on4+ykMdNx+h6P8JUX?=
 =?us-ascii?Q?J1M2Z89o++mALmkdLpzfQ+/1i6woh4qiz4vvaQbMEvwPnIJbgZCgRynpcEU/?=
 =?us-ascii?Q?l4OeB+hSb7nBfs+6M/O1hiWl42VSownpuB0iW5t3SNNLIVKXQPQVsmIuLxBN?=
 =?us-ascii?Q?ygBsy4yQf+3zoLUMAtSJLuOc1xtPlg56A6xNRouQBB9VefFMyVmCOgzBaiFS?=
 =?us-ascii?Q?HrxjlRQJQfvOvfyIVkQ5i5plG6L3I+cWp9oQ0rZdLyDwNzppWaq3q8DCFIGf?=
 =?us-ascii?Q?CTT7TCiKl+p1hV1KQFDGjZMw8u8HIQG5QJ/YxVDvM5twEM0RucI26ZTFtWBG?=
 =?us-ascii?Q?7WxoSZARTgiVbi361bPynDfpveK/TH4=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec84cbc-829d-404b-d564-08da3c86b677
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:37:31.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhrsOmqm57XSDH81Dl0r5IrnB0MEPh29TGseTQ5z0u6jegfOuwFf63hvIhK55/quehN+VJk87oKRPbg6mM+G001XNN9GrOFyAnP6bxTaOZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5945
X-Proofpoint-ORIG-GUID: 5_2iAuj3b-Q567gwABcfvlw8IgeFYOMB
X-Proofpoint-GUID: 5_2iAuj3b-Q567gwABcfvlw8IgeFYOMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_01,2022-05-20_02,2022-02-23_01
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
 drivers/cpuidle/governors/haltpoll.c |  7 +++++-
 include/trace/events/power.h         | 33 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index cb2a96eafc02..9a6eca41a484 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/kvm_para.h>
+#include <trace/events/power.h>
 
 static unsigned int guest_halt_poll_ns __read_mostly = 200000;
 module_param(guest_halt_poll_ns, uint, 0644);
@@ -77,13 +78,14 @@ static int haltpoll_select(struct cpuidle_driver *drv,
 
 static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 {
-	unsigned int val;
+	unsigned int val, old;
 
 	/* Grow cpu_halt_poll_us if
 	 * cpu_halt_poll_us < block_ns < guest_halt_poll_us
 	 */
 	if (block_ns > dev->poll_limit_ns && block_ns <= guest_halt_poll_ns) {
 		val = dev->poll_limit_ns * guest_halt_poll_grow;
+		old = val;
 
 		if (val < guest_halt_poll_grow_start)
 			val = guest_halt_poll_grow_start;
@@ -91,16 +93,19 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 			val = guest_halt_poll_ns;
 
 		dev->poll_limit_ns = val;
+		trace_guest_halt_poll_ns_grow(smp_processor_id(), val, old);
 	} else if (block_ns > guest_halt_poll_ns &&
 		   guest_halt_poll_allow_shrink) {
 		unsigned int shrink = guest_halt_poll_shrink;
 
 		val = dev->poll_limit_ns;
+		old = val;
 		if (shrink == 0)
 			val = 0;
 		else
 			val /= shrink;
 		dev->poll_limit_ns = val;
+		trace_guest_halt_poll_ns_shrink(smp_processor_id(), val, old);
 	}
 }
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..db065af9c3c0 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -500,6 +500,39 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+TRACE_EVENT(guest_halt_poll_ns,
+
+	TP_PROTO(bool grow, unsigned int cpu_id,
+		 unsigned int new, unsigned int old),
+
+	TP_ARGS(grow, cpu_id, new, old),
+
+	TP_STRUCT__entry(
+		__field(bool, grow)
+		__field(unsigned int, cpu_id)
+		__field(unsigned int, new)
+		__field(unsigned int, old)
+	),
+
+	TP_fast_assign(
+		__entry->grow   = grow;
+		__entry->cpu_id = cpu_id;
+		__entry->new    = new;
+		__entry->old    = old;
+	),
+
+	TP_printk("cpu %u: halt_poll_ns %u (%s %u)",
+		__entry->cpu_id,
+		__entry->new,
+		__entry->grow ? "grow" : "shrink",
+		__entry->old)
+);
+
+#define trace_guest_halt_poll_ns_grow(cpu_id, new, old) \
+	trace_guest_halt_poll_ns(true, cpu_id, new, old)
+#define trace_guest_halt_poll_ns_shrink(cpu_id, new, old) \
+	trace_guest_halt_poll_ns(false, cpu_id, new, old)
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.36.1

