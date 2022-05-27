Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A9535739
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiE0AyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiE0AyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:54:11 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044CDE64D7;
        Thu, 26 May 2022 17:54:10 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QNlC8j005427;
        Thu, 26 May 2022 17:53:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=y1vkX5FlS6kgP087hNswMOi1jswqtSvtYU01+46eLTA=;
 b=1AQRMFmB4AOj0w8cIOLVJ5aehSQO/ajcSu9/c2e6LKo4yRQgV+iSncD9mR3UPOLaGbDA
 ArehR0695b1ogBr+UUuuZ7uy0KXigp/7zWubmIcNjdeNxqw1eqK5QXUU3Gh/DwD/qTbu
 hYZv1ZP1WewHa3RgpGnSrmCNNTgyWXRn5vD68hVU/AUeRzlWSyu+GmQrQHtCIKTbywxd
 uVOtzcsMwQE/jFBhq6jzSx6OsFDWsjRrOnR+O3bkdXhinK87N5KQRt284+aF9tkY7c6B
 Ei2IDYdokOJmsKVkrUZc+jxKscN06863shYXCz6lZEaqN3BZEAlxN8Pz8TWLlssNmHkX +w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ga566hvxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 17:53:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwQB2jaAEF3NUInQoXRTghRI9QuS69vQbcyMecKnePEvOGDf0NoUsmDrO2CX8FYO/O7h3/KG297VADAYoJ7TtpkviQZHY6I1NSqXf1cZqXjAeexrOBj5Yyl3tz+fB19M3GK0unx8ep/pKEGokhgL6Rd1OlRxlsIlJnkLMl9veVbjfXZV6pgSQevgTxNXksSokiBH3pZrIrorrATcWZ6L2/qHW1ZsgwnOfBQipd3y0SbD2Jr4Cm3T6A7Zo9Mgl9kfU8gAsY/fwYxpekLbkjFjn3IjTdWJCDI9/+wMTzaPpHkmbFB84AT9e9DUqqWNM4NjnmAys17lWAJ7mQqrfuNx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1vkX5FlS6kgP087hNswMOi1jswqtSvtYU01+46eLTA=;
 b=Q/96UDDjyyiPb7LyI9g4z84lid8LLDPxFAaYwqYwwZj42D42W7UvPfE1WeZDhu8RyO05pYDJ7ckG6L19k9kOJALsNJhFzgp5ynzVfarFX4GV2waTBi6r/PZwXTrjYm6lx39xfuyAyNSLVv7EZArhVb9cZxZi1fcGQHT90xYjrCqPnq7aZIw7b0Kjj0SfZF4wDYmOgguDGgUi58Fbcyifb0a2/aImqARrfGrjtKB8X3CUJjSXLpZJddcI6groCwQm//TBC0CDoQbVlKaGXsVtPu98WTLEpsznZHqRjppHpQlpPM/g+IbqNtTeA0axtRl88cHYMloNB+j+fGddvlY39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by DM4PR02MB8982.namprd02.prod.outlook.com (2603:10b6:8:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 00:53:55 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::7576:8a10:f7ae:9397]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::7576:8a10:f7ae:9397%6]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 00:53:55 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com,
        mtosatti@redhat.com
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v4] cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink
Date:   Fri, 27 May 2022 00:53:45 +0000
Message-Id: <20220527005345.189906-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.9.3
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce5551f-d2dd-4aad-b7e1-08da3f7b5fda
X-MS-TrafficTypeDiagnostic: DM4PR02MB8982:EE_
X-Microsoft-Antispam-PRVS: <DM4PR02MB8982C724A8163F8B7F91AC8D80D89@DM4PR02MB8982.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siI939nlZg2y5QhtatZ/Z7lKmQHQ7Yd/KSydZq0IDQbnVsloXX8MkfiJ1MvgYZLndSm/oYHOVieIcIAkQJCHxg2FjCjhng7mr4qQA/568RKTRdq4NQTBb1uBlQDuxcYuAgUF0f+qzTkkejhsGgGvFUpiJmC86rs0Ydq3d3XN4kYVuvMdwVTgdHhZINgsU/Bs9gvB3k0IKxfWqtmi8sDajq11nDNRXBQDASUpoht9NjUQe8ccKAuPFmoY7GapaszjBtlVHXxo/HwzAa8FpZOnblIIocwiRAEKYb+oFeYuUr9rLfxNFHIFUN2JXNKVoPr2w6L8aCRxnfuPJ1xo6QM2yzK9iZOvptQ9jBr9AowQZS802nQnUvUmWXFFyOapwRqk/Ji3dl2N89AlfXGbFuRiMYs4zFJM0k2TvAXZuoY36UzZS+VtMCpyzKsSXWpnM9YqXXT+ghZddrs3EqrRmhBxcd/ZgcjRzNNs3FW/Xr3kzGI8vsN+uqCZubvzaVWd7lSac3g/FS0Gddx2fUka6qjzmA8FkyW/TFfM4budHb72+DyHWCc1JMRlOiI1oJAU7OWAMFr7pO+KynTuYAGKlhXdTA8k59Gz1mm8Ud2mjvmzym8TNCWEmQgxL7zwB0yKh/LVOx7d9BQX/W4VjZnQXQN+feITTuOfzD6Zc1gnh99YK1o3Uik6q07YRfK2vgtD11qq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(1076003)(6666004)(6512007)(6506007)(2906002)(2616005)(5660300002)(52116002)(83380400001)(26005)(8676002)(66556008)(66946007)(4326008)(38100700002)(316002)(66476007)(6486002)(86362001)(38350700002)(36756003)(44832011)(107886003)(508600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wP4L+zDkL/k9GWLtF2Xu+PR1w7ol9MhqeKhh2wf21lNEhsGkt48rsI6TQ9a/?=
 =?us-ascii?Q?aZYYAq7w9B5GTeRR0wgYelvKF8LIN68kxeLLdPnCWynknk1mV/zIumtdIJpo?=
 =?us-ascii?Q?2YGCRuFWD2LEpmSabzXPt97IVOsSZsUlVoIbKjUjI7Ul0q3aj30Q5GdKvdQn?=
 =?us-ascii?Q?c59HxxXthuns5n8WJZ3iOF2lCPp7O2pK04+3xDFQTRDx6oYi72rKBxmtHKNp?=
 =?us-ascii?Q?NtxeZJWf9dlQi563HRLCXdNY2EX+WUYhnrEKHGFGHFoIMVovnc1/K/pEU5eQ?=
 =?us-ascii?Q?/5agNYhJ6+hGNCvTGC3K5yrEZXJyxZZv8YCvQsYZZKMszrRsYJiVjMOwi5zB?=
 =?us-ascii?Q?wdL0cxp+cGT1CfDBtIVXzCL87ptmhKQpzZp6dap5ANejHiZNKRu4EVsRiYci?=
 =?us-ascii?Q?4iCa72g5ouyR8keqagB3FJwih3dvwalpU5e/bHNB22I2q0Co8oHt35egFbEo?=
 =?us-ascii?Q?w2nCDEyopInlI0laBRGmt8Pwsl0cDf3VzWyPng28qjSJ5699UowuLcHOCct5?=
 =?us-ascii?Q?IRxc74zXscg/HkeuqPJ7m3jAvsI8j/8Cu5KgHOFX3z7stYFAkFpeIFrPcWGs?=
 =?us-ascii?Q?mnKVJBbIAZC/5ch2eGKp+1ds4z0yhWNAcxdphrHd4pTMr6Gn1Ycji8MtbK8l?=
 =?us-ascii?Q?thheieQ9bkIdllgkchAJAIzeJGe0wSfSpLVljurUf5eJidy+bWX+KC6ZhSQf?=
 =?us-ascii?Q?Y48apd5Ile0bTmpCOffCv5O5VAv1KwSWPZX8JJRQymjzNGtf0KclC7qF/4LE?=
 =?us-ascii?Q?zUQiVIe8C2faHmKkzy9MrKyuKYKyAP3f2c/ZsNZtCMT4n43WwbvSDfhkCK8V?=
 =?us-ascii?Q?rkg6d/N4VotzRhVmheG05PHazFXZlDFrIktS9iTMfUWcUF6ixgGQ1OWfiODS?=
 =?us-ascii?Q?Rydzfb5bBp5XyrXNyPqf3BRuTyDMqiRYHldTivjBMDWEPiz8lXl2M2dR+EEZ?=
 =?us-ascii?Q?eGaBUCiUanBGGuGBAYc5o6WfG/pSprMcUJLcwFzuWQw+vDRBQFGYwqi6aX8o?=
 =?us-ascii?Q?usbC6miwTcHuRPDaZrNokQIGc1hVSuSZf3woZnvxrU9veCbHiVd9htRKeR1Q?=
 =?us-ascii?Q?8iOo52kWvS8M7LVD22HQT8oGVUSLFkjkZXaqDUWIxHPC8O/j2m2o5F5FZjCE?=
 =?us-ascii?Q?p7CiLKpRMqfYYSBokWcbgwk3ND3WOiH3kRqvVyjHmC1tNTdAzqfF8Oz5FRBN?=
 =?us-ascii?Q?mMri6kHn0qgdIRoKAe3PjvDcB1E02nSGkYQz2OdbebEki3FEeutfFsLGoLER?=
 =?us-ascii?Q?dtI8oaNXH6fjPx2zrCBH57RS2IGs1Tpoc8hEwWRwSxxctXp43a3zlqYhiaRy?=
 =?us-ascii?Q?QSYWm9UtMNSPEpsnIVD/OLkTIg7vmvdPFmvM2LSM+oYzgOsUjLHp1LmpucvP?=
 =?us-ascii?Q?hRK8FKTWmE9XuzgYnPWXUiBZpnGr+3ySWBZ5L837DaIoe/TgphfOeIeblhgK?=
 =?us-ascii?Q?jAvpRIO56FkW4rfDuMT0hFGI42+tOI3Uh5ocU47no9xs9sOpNF1QT0V1eQTo?=
 =?us-ascii?Q?dA+XKSdrowLvostI3fVQC4r3svlsWUha9L8DyrdJwTQSp2qdNCY7q5kWVRr1?=
 =?us-ascii?Q?tZMJSCxBqL5Jene6ts42gA69mBrWm/29b0ZhnD87adnk82OwHNOzWBevGz++?=
 =?us-ascii?Q?pvwmbVu7prE1PErR/tbmR+Xp7TnbcCO/p3Q1E/ibnvyUD/NPqueWEjZdfRnK?=
 =?us-ascii?Q?kh49WIhf9fobMel+aZOzYNntmwqM6G1FuJSqwy/GRUcNPX95xa688pqjRzvy?=
 =?us-ascii?Q?x0uMMjgLnXApnPjxsj0jFXAvw8FoCH8=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce5551f-d2dd-4aad-b7e1-08da3f7b5fda
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 00:53:54.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivBDoLWfY6e4m7Ztp4GOkkEiDrcG8wLmvt4cD//mW4i/DYtuM6SvylueyqicxahpFdRI34B88gDe1/4HSqJhLQNtoXFbvfmnVM7LWRhdMwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8982
X-Proofpoint-GUID: APKy6j5gwdFqqnSkGztNAmHmLcsx27LU
X-Proofpoint-ORIG-GUID: APKy6j5gwdFqqnSkGztNAmHmLcsx27LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_12,2022-05-25_02,2022-02-23_01
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
 drivers/cpuidle/governors/haltpoll.c |  3 +++
 include/trace/events/power.h         | 29 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index cb2a96eafc02..1dff3a52917d 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/kvm_para.h>
+#include <trace/events/power.h>
 
 static unsigned int guest_halt_poll_ns __read_mostly = 200000;
 module_param(guest_halt_poll_ns, uint, 0644);
@@ -90,6 +91,7 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 		if (val > guest_halt_poll_ns)
 			val = guest_halt_poll_ns;
 
+		trace_guest_halt_poll_ns_grow(val, dev->poll_limit_ns);
 		dev->poll_limit_ns = val;
 	} else if (block_ns > guest_halt_poll_ns &&
 		   guest_halt_poll_allow_shrink) {
@@ -100,6 +102,7 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 			val = 0;
 		else
 			val /= shrink;
+		trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
 		dev->poll_limit_ns = val;
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

