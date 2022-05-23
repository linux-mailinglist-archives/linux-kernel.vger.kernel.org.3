Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA4531F70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiEWXx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiEWXxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:53:54 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF61B45067;
        Mon, 23 May 2022 16:53:53 -0700 (PDT)
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMBfTg017246;
        Mon, 23 May 2022 16:53:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=c6RSa6RU4tc7g6H4/qRzt3WFMLwVimVTKgJFckLNlyY=;
 b=BDKklnCDNGQ5G+0/jKC+zGrgkIJY0WP1RYnu/U+rsERDFq4j0x8pjzDDjlcq5wPb5zLJ
 qHQQJi2+Eh6hiwUkY9ocg/RJuWDbV/vi/Nt3D1ZODDs0lV9AQX+zXq2Cea6xbKSqDsLS
 1Tz4/RMPcTesc9DuXyjlRSTyTLWiwcVDfG2B8h5bG/ToDd32O0bgGCz92b/3LCiZGaDd
 ezbhcmIqShcbc7fvnTxFJESdLAfFDMummWARyiaPO6B059T83Khj8+sjDryjgK90dE3S
 MBWZeGirELXkp56m3Obj7SI7jaj+JI5WtH7UifD3n6Awe4dz3DwV1LOff/1CFKKF9g8E dA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3g6wm8vj18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 16:53:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neKzLr2Z3XP1HDVvqgAdH6ABLwUEGDinkichIRxo3wLcKTALD449/oebuPUjmI/qzGfEUavVmU/IP37HwCB1OV2PNbuJmqbLBQ8ECkUa/eXh5QFk5JeXjO+YsxzwQS8hpG6lpNF+JDdkFuGpyJtPVY37k1UEUhXujRPc3l2n4SSvKrGyFc4cMvVA6kTDZorslVnhV8ZzAv3dXqj9G70c/SwPAspYAapibFUYXEf+GyBljjQCwRWk0abhmz5fc3+ggKTwsiO0g7fLhVRZS5UMV+icDd7j+XmiJa7xGlitbYrnj93efpNOFkLDPi+rI3SsHlNQYkpGC3rEjnEpepxb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6RSa6RU4tc7g6H4/qRzt3WFMLwVimVTKgJFckLNlyY=;
 b=juFMcI1+xLF+KchlGOdJGdKsWzsRAWYecpw2u81Y3LqGkqV9k+WH5fsQlJ2CUxJjmLejTdnFRUfKlI/dt3kxEacLVznHMNoTxkpSYJ7biEEuWiSYQ3MnJnNHDfAu8eoLLfulQT8Zwoi2ZClLJQ+Z8uEjWejept2RRiOg4ASBJqrpsOXiDQeD4jzn2EQh92Hp7weq6GHOz6qDaLb6bt6Q+8kTp1YGnesuQCL+lcJqOXtgHi8cfOfF0whVBs8Bh+JU/Awg+gtJYnUVp9IvtkuJ5PydIT8jiHFhTKuPfJ/5cJWz/GdRJtCQKT4w/Q3OgDW1whfHO3ZC1RJGTcyqnWZpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by BN8PR02MB5891.namprd02.prod.outlook.com (2603:10b6:408:b8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 23:53:43 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3%5]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 23:53:42 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com,
        mtosatti@redhat.com
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2] cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink
Date:   Mon, 23 May 2022 23:53:32 +0000
Message-Id: <20220523235332.162966-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.9.3
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c63f468-62f9-4568-5174-08da3d17778d
X-MS-TrafficTypeDiagnostic: BN8PR02MB5891:EE_
X-Microsoft-Antispam-PRVS: <BN8PR02MB5891B7574E84C2736C9002E480D49@BN8PR02MB5891.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+b3SQu126NvYJoe9WOGAl/JUquDCRWHg5DKHutJlw4rcMlU2RaOci4EhTzStxJkPOnY2QlVrhePr3VDF6yQdRDGn41gwZS4rAuAqws0PHJVvu+1Db/uDJKVQyuqn6z/nZQGKF0LQVKcqM4o9Xd07bcpU/kEN0dOWwjJX3V7aLuDpQ+dSur5TgfG5hWug0QM9o3bi8LXKdt4vwt8fhE1aSFGcoQve43z4l2+rYHkRFPVtjMxcQwslsy3WbSztXgIrtCLSSFChfWzQvo8g+/sxRFBwKw0g3E36iF3Pyn45P6FBieOOBcL2dRDRXHiBgyf7oypSL5AYbGt+6EME6JR87fJp4o6Y+FVIwyPMKx74IHzlMWruvEAnR+b2gjklFgsHdhLKJtT0VoMbyT5G9dceBxf+r1gT88oC68vEdU1UHRpqY+USef9kwpP+7UWmrIyCWXir3AY8ES3gX6SANeIzNC6EKlCYY96US2ret6BHveIigiZKoqoxtAIMyy8GDGv7oEkyUhpKVLybL6KNeB/wPO1WndqMzulkkI1HWUfcklMdnU4m6xAF4Zy1X5Ct0KH7muDnLGKV0HBsynaLryfXsLeD7/VfrjkaDTLyjBeM/UT3j+2FcyX2xmB9wkyfvj3543KPmyYRRuOVPhnHF9Ketd9VB+X/CBB20fAXrFIBMd2HR2ZJMGOZo7FhCiKC6bH0WHHYcV12JqvzAHWqIFR4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(1076003)(66946007)(66556008)(66476007)(8936002)(316002)(26005)(4326008)(107886003)(83380400001)(5660300002)(6486002)(44832011)(186003)(86362001)(508600001)(2616005)(36756003)(2906002)(6512007)(38100700002)(38350700002)(52116002)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXCKOPA/T/ziaZY7plCnSuSYSZaI+RWmb3rWuvV7uMfCnb/DzAb2D3CLStAg?=
 =?us-ascii?Q?SgCOBveFBOnB4FHI4hW8tKQL4nh2vi4Coin7A7pt0iXlxYYOsZyjVtdQ3IeY?=
 =?us-ascii?Q?KCDjKbO+C/IFDRpmSCTQYjPWmXcid16RQvfQm9dyBlQWJo8P153YGdI9pFGv?=
 =?us-ascii?Q?K7sb5DTN14JjzwzoK62OJdUQzqsNrY0Z2Ex51VCPhJNZEuLyTBMN9zHCKUty?=
 =?us-ascii?Q?VPUpPMSHfngKL7RUzCfZzD8co1XbPZD/Y83bPZRMDsgfIDGytSotmy3UBP3a?=
 =?us-ascii?Q?t1D8AVFZDXY49RPRDwc9ZO5iGdYzxMS98JwOKduOMXf2K0f8aOccaNIIbJI3?=
 =?us-ascii?Q?oo+zvUasspqhQN7ZK/eoQAczPDuzDZ0wZqDT3W3G05Tq3qTNM27pb95ywW8N?=
 =?us-ascii?Q?iTMz8ndhAnxDjuh7SDd4eKbsew9cC5MlnbfqPPO99CEZfHyNsi0HO1jd3q0C?=
 =?us-ascii?Q?havL7Zh6/y8+UB7Folk3cmvmMOT6EK+t4hHKaxZUDBk7Jybc3lKzyVv0tG6C?=
 =?us-ascii?Q?z1etLiWz10PaaiWIkq2d3/p+21G7iAhDKmbkbeH0A/JJbBoPkul+w2Dqzcf/?=
 =?us-ascii?Q?5x6Gf+OHqbVQc6067K+8kVHD1S3O055nrfKKeI9qD/pvrIRM9TraU94+PoY5?=
 =?us-ascii?Q?i0nDUkKcTSghANJp6EwYKCXMb82Lygu41D9ViVpxx+oN4BqdNyW8QxXBYPRN?=
 =?us-ascii?Q?pQDrZzxmgrTT/n5HJiACbxaOFpejGf+rvuO+KyWTGR6LBA6LrubfVfZ1XhRk?=
 =?us-ascii?Q?bn13yPWhYECBzIWMA/hAEmS6L7T62qcFdEn9Rd4TmD6b5FVIqdb8OY0hfT6P?=
 =?us-ascii?Q?j/wuNDl4jU2lYsbWgV+ijWunRPpNpe7yPwjkQKMA1g6KXnVRmATEeUR7xQQq?=
 =?us-ascii?Q?yjojTGRvukPuYHno1N6JwQSbghPxAgL5uEaIaeBRv/hl95VwXPCEVUEY0xLi?=
 =?us-ascii?Q?3iluNpmUSoE+rJH59iMfK+94ZfVo1sE7XgvYpP/40f0bVe0lk+fN/IqViEqB?=
 =?us-ascii?Q?a0qcEyv9QjU9PPznHpYkhtGnU5RD7uHmEWRiPEm2UhCti7I8TDCyMQ3i9FSr?=
 =?us-ascii?Q?Hmy+nQDgY8cTgcg8vR3+nP2S+oOxQdiEqYjpDMF2JRYBeNpCmkkFQ/dAA5JY?=
 =?us-ascii?Q?qNt8EjfbuOkAvQDLFoii09jF1jHoC9r5Z4hA4HcLeux8AunY8GGCIC50Z+9D?=
 =?us-ascii?Q?M5B46Rhp/TqDavPaYcpaCIloAPU4X1uLDxT1LaqpcUtl8Oz2E/3XJ/EK68oo?=
 =?us-ascii?Q?X9bUZC9/5MUsX0U/1txidYPXoFfR7PXbPYMbCDK2i4skp8UHZE5oTlmwxbnt?=
 =?us-ascii?Q?RjFmeVnem7XcDTNRWfngRumw0qH/BLWOYuX4D48AF/x49sI4qjWoMChWjVm0?=
 =?us-ascii?Q?hwxW7c76qXNhLi4GUPzU8RKOGUxfriatp92NOkmrsJNG9wVW8+MFzNxZFEJo?=
 =?us-ascii?Q?JARYXq+f+Kob238HArID5JeR6T76pD2lshFRbTIjdUI0i0UNihVVoC032J4S?=
 =?us-ascii?Q?jCcCvwVQGPpBaYQX2binzdvL1HTVvot7kdnMOO8ILkFnO+vTlC+wtKlVhsfZ?=
 =?us-ascii?Q?qo+ZsLwGBEHkRjBOL5VQQmytuQ/DpGHLwX6gtA3nsv/mufzAS7/rKgCUmI/0?=
 =?us-ascii?Q?6cJiIEYRBm4KEuEXF8MHBeU1JJQnY+GMfuXXxEUwSF+/U713aisSaunbdqJg?=
 =?us-ascii?Q?ScpoI/DtWrbGJSS9TqkOXi1+BX+EQBc0gCrRbwisbxDT4fcJcYRMAjoUIGZ1?=
 =?us-ascii?Q?7iCa2iLtwA0C3lDhxymq2k9fYFsvRBk=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c63f468-62f9-4568-5174-08da3d17778d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 23:53:42.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQwMkVVuc8s63+Xa1ESTTBAnLTdQsQ3tcha2LLYKaiMrmQTgm4MO7PGj6uL7/5LeiMdTKE6JD/ZCChcHAoqE9lUJo3quwVUx31OymmJX7f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5891
X-Proofpoint-ORIG-GUID: kUxYqlZdpUbll1kyc3Ms-WwKqBsgzode
X-Proofpoint-GUID: kUxYqlZdpUbll1kyc3Ms-WwKqBsgzode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_10,2022-05-23_01,2022-02-23_01
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
 drivers/cpuidle/governors/haltpoll.c | 15 ++++++++-----
 include/trace/events/power.h         | 33 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index cb2a96eafc02..a5b6ad32956c 100644
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
+		trace_guest_halt_poll_ns_grow(smp_processor_id(), val, old);
 	} else if (block_ns > guest_halt_poll_ns &&
 		   guest_halt_poll_allow_shrink) {
 		unsigned int shrink = guest_halt_poll_shrink;
 
-		val = dev->poll_limit_ns;
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

