Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEB4AFFF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiBIWN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:13:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiBIWNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:13:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE8C0F8699
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:13:57 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KLRN6013540;
        Wed, 9 Feb 2022 22:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=unB/I1fPyvXPr+8NMUR3bbcuJroM6RlVC94jYXL1do0=;
 b=Qo0SkjuKubXTIiWqMn5uNRwy7OvVolQXecf2rP/ufv1A+QoVCjJj/uApp2rfaYwDfeGs
 SQg4EBooebv031lViE9FYnx4lqpoJnOoOxy9fe6qaoTZo89xBeqhIzWncWulOktzfoJm
 27sFTmUG5BEVz65G+3XnVFj2K4rvFMHO/FthAKL3kL3VKUtL3CzDIJHi4OUmxce8cJVI
 EPnfYdxChIpb7F3KBma9WZT7ILAZXrgRZcTnylGjzr3h17YhMUMATiLdlb2KggU6YfCi
 6NvWXtCsX4JVDCqCDmWsZVi5XhOsCAnK9pdTMg7Dh7mCKI4ds8qTCSbr9T+5G+9GgfZb tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sqw29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 22:13:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219LtaXR143421;
        Wed, 9 Feb 2022 22:13:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3020.oracle.com with ESMTP id 3e1h292prp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 22:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKtu9JUixS/1hpSab1GrLoC174E+qXt38Hq5TgPxPMMFYlJ82vIye9wE6+28ddsutFatgM6zjG2qX4vgPxjIaGGbA2qbOKoMF65GlRjrvHQWcwgwLYOswxpA9NgmR1jOMKlfPt282I/NCt1GfviTAbKYja5Mm4TARP/tipPBMP1BIL7S1xSFd2D21NcbOBIz8HvsJd39vrhQjIvVZNZxRi/58DciGv8yI4YTOkLZNz/Xl+Iy5Tm1csYDh7nJj5t7Zj0rKD3v7Oy/BirmRsMLt9xysn0xTfMjpxQJ7+Ve9UGYEg98BMzrRKnqWeRoKlgahujv/XxKRIkTwcy7ucJm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unB/I1fPyvXPr+8NMUR3bbcuJroM6RlVC94jYXL1do0=;
 b=hGYfpkGQxkg2N1jvMTWBBr/aiUNggkuA6MHQ4lyaB7hKLTw1NKubxNAYbd9VYjtrS7FaF5BI1mNohfxj/V7wk2RGhxuBhvIkWFsi783RAX2BLd6tMoO8YdcTv+hEjt8EOg0uadKUPF/B9QdgztjRCq5Bi2nw01RozMH/7Mx2/Ox8gDjbLYDf6OJIjxgoUoZjc/Lj+QJinifDpukQIXTmIgCNiW8ZItARDsZvqOYY0+nv3TwRDz8Yr/f5yDeTGhLFevNSv6oKxhs45sNoxAHsZLJ20UzmoFafCQ1n8bmwFHhoS50GceKDreck3+h09lJt8WjbnapIenSe4SCPKTTGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unB/I1fPyvXPr+8NMUR3bbcuJroM6RlVC94jYXL1do0=;
 b=K0lsreOMPZivHWPRWjGVdv7h5j+vP3GrJO7wPP94D2TKrAvvQfxEveApM5mFc0WRokVJMQwiBha0WDV5JyIYJ1ihuBNGNBd6L3lMm4pz0ghOjHkxwVA2MwWRPi/Hi622ZXwqTdceikHmNcJpTqTwOcMcF4wMbxASTqgocddom3M=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR1001MB2190.namprd10.prod.outlook.com (2603:10b6:301:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 22:13:24 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 22:13:24 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 1/1] sched: Use printk_deferred during __schedule()
Date:   Wed,  9 Feb 2022 14:13:19 -0800
Message-Id: <20220209221319.179648-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209221319.179648-1-stephen.s.brennan@oracle.com>
References: <20220209221319.179648-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b30c108-b7fd-4b3f-dad5-08d9ec1963d1
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2190:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB219067D315EB71FA2640D970DB2E9@MWHPR1001MB2190.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAThhddcfOA1GBJ/yuk5eFxI7mG1tlDMyN+4uupjWRyr82Bsntw7cXSoSQG10dU+jqnoK66L0un6CVw9Zh1llquDzAXwUci0O56/OUylP4BuyvXhjG20oSijcGyNfzCBEF/dgdlg3JLT27bEDpnBC1xSysSxXJaPqjpXigYGDx/oz0ayBUQsA7eKsjj+fozF+ZrRj8xaZ+TBjgQ+9ZxVnc/AXLaYB/NkooqDquPaFDLqQXZ/i/zT2lqOt1lCR4TScUyeSbVdVBoTIrrK6rNHe/aAsd9WzqkZ8k3sBB0fbzDUNHrYEmGwjtfqsHZwN6HdfdVH6qHcwWxi1/Ro0ErGKXFlw2B9j1PbBhXaR9KwsuugSQjseOgEy3i4YZ0DxUl6c3ajfw8h/jUMSXk74sew8VAwWILLBBq0sNChWqdNLs9PfzYwxeXbJwUursPTHwHIVRCCnsYbejSBv9Uoaw0giwQNNJlFVy0odCAZHyvUIETKMwgpa8pj2Ibx/5fSOfDkOAwg+m21VhAL5KegLyltnmQLIUU4Ox5+uB8pyItrIXApEYPugth0yAfyyD9QxPu0I/BCdnTdxwzaL9ZdcUaWqTG0N7LNMwCF1WJ/Nxzgm9zxJdARa8PQnvj+nsg0KRFYzf85p84ztdNNT7K5TtCApekoiQbJC5kJbbQeWmOPde7MLPqbelUZWsThEcSirRQjIxRerqvikv60jA8Mv4oN2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(66946007)(6666004)(316002)(508600001)(52116002)(66556008)(6512007)(6506007)(103116003)(1076003)(2906002)(186003)(26005)(6486002)(7416002)(4326008)(36756003)(83380400001)(8676002)(110136005)(54906003)(38350700002)(5660300002)(66476007)(8936002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMzXFZFj3vN5cksphGwnVnVMQVfF/XngF7tfzIk8zORLzfoqc4EKv98EadW3?=
 =?us-ascii?Q?yacyO7dp8yUdq3oBnS0kalyk8U0IR+Wod/sWSpMJBni+yinQm3uY1nGn806t?=
 =?us-ascii?Q?BT/SOHjnYJ5oKgHR/E63QKMyVisGvamMoCheMJuCAvSakefIwPBpIgGPP3ID?=
 =?us-ascii?Q?vo9PfjUeuXnPuqbu6X7+IQ+9v2ut+6OAF3eV99KwM+AMjKKMP1YKgZvPCcsx?=
 =?us-ascii?Q?if0Nq7GgHQXPQKN1+Gyi/Dxe/D4WocbkXEpgSNEWxMMlxI3+2txNAG3Kovef?=
 =?us-ascii?Q?iIe4JBJMNvRZQQQZ3qxYiyn8n3PZ/bnWPS33YTqfIRtp0agOv1Xg10+BmmJK?=
 =?us-ascii?Q?Gj4K0yDzuqhj4AICtIgP0S/nfw4qcXQyJ70Vfps1xNmWlsq3I3z/AnlfMFEf?=
 =?us-ascii?Q?KQ2qVricQaITsDWmCYgtb/WhGuoJOeJ41msxFZLJ7NR5xIFjQCjQ01FOuOlN?=
 =?us-ascii?Q?CQ3BnhM65ZufKwt1GyRdK1s11Xi1lxVR6BfkdM6Z6YWcKXiEpdS7aRJOF+dw?=
 =?us-ascii?Q?kDAYlUQNSaqAcuSNqKb0MP/7jo7C+YMtXMjigCpa2C/mFi7gSNfSI+HCmQNc?=
 =?us-ascii?Q?4VWGnRs/7UcrWBfGMdqnmeV53L4LQCgO0rhib3Y3eI9qJ0QLo5JzKj97Q+fM?=
 =?us-ascii?Q?Br5gcME+94Tc5UBIJZDcpGP59stto8dwqa6rCvHdpAEw9JcGlXxfUY0VhUDh?=
 =?us-ascii?Q?VV6rcGV3ApZfRBP0BfjZnZyPcCT+uJr24tlIAnT+oTpitk5zaK6jz6FGWynf?=
 =?us-ascii?Q?YSZyY9SQ0K9N5Na5MS024br0YXzu7u8hQaEsEMlEwPEK0NmqrNqm44ZeoGoO?=
 =?us-ascii?Q?kY6vYYq8xwjtUMy+YRa71FuHwI7V14H0GX3sO0pJfbso6ChmgygVlk20DUBE?=
 =?us-ascii?Q?iw3tcuTqpxnoEFDi0G/6ouegRKYYdGc+RTFCE9PpQ2fC8Hp5iVfh40rkY8YZ?=
 =?us-ascii?Q?QKKejOpEb72GTmfvKYcUgyaMJmWzB1kZxHGvgOl6rFQPgtuXxjldUETAHsHO?=
 =?us-ascii?Q?vlbl0Ev7KpII4ycHyXvJTmueyBri48kF9jI18D1VFweHD5jlAGRAl6v3W6vp?=
 =?us-ascii?Q?dP0W57xqplBg4V1Od+KYXKbQo6UM3ydVnj+MP8Anc+W8BdzzPXLUw9iVhWND?=
 =?us-ascii?Q?Tqxt6ltJvGNuRCj5tWer9dhUlRywNQNX9OwKKMVHnVmkFhI/t+wU4hd9d/Ek?=
 =?us-ascii?Q?sL506MoAGQaHBmF7oktNsthfzludIqoOVfi0bJaoLTfNFCrnEdTo3pbC6rOp?=
 =?us-ascii?Q?Mui/QBuGBRfxpsZUAz4n3TXG2ZPW4QiyYLqnoEMXHBUk/plwmV3KfcLcfSP/?=
 =?us-ascii?Q?k9M/vKMGzj745w3r5OE/JVwRhMaDKBI8JoXSQBGQVay9sgbtjEK4qLxrWG2a?=
 =?us-ascii?Q?ahpO0bY05X3sMnZ8YTBpqYnNvjzm9O8i/ophN+0KX95Os/ja2JcsPPT35slK?=
 =?us-ascii?Q?HyF3rXTVpV/TjJSqIg3OtFXOi9otU2Pq2TwPzp3kgDwEM7hy7KIUVd6km/6i?=
 =?us-ascii?Q?LnY24aRcA6Xur8Y4Eu7JDLiA2v5NWV0EmyHibK1Qhx1LjNa5mbB3j/Lwc94b?=
 =?us-ascii?Q?bTrSr0rfVxmdNF5XlBpCO/32WovKWqUH8D2mjIHJuu+TQdhaM86wJNPTKa4o?=
 =?us-ascii?Q?uSVFlAfFfQtfsOyYC0flTCJvCsM/N+d8JhcfRgjIyOpYn744AYl1ShtR1d7r?=
 =?us-ascii?Q?Dgl06Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b30c108-b7fd-4b3f-dad5-08d9ec1963d1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 22:13:24.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJN+eYxQDiG5dxtcmr5S7tgkKKnrgxS0mtJwMeKDaD+f0QuKKMVqx5yUcjNrpNUaLsPbREGfcZQoKWkv4dA37N5vQeSHzaijo7Ey0Aysl8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2190
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090115
X-Proofpoint-GUID: H73UDf5jTscNhUsVQmF1xloTtpNk3sN0
X-Proofpoint-ORIG-GUID: H73UDf5jTscNhUsVQmF1xloTtpNk3sN0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the rq lock is held and a printk occurs, some console drivers may
trigger a deadlock by calling into scheduler functions (e.g. scheduling
work). Though printk() is avoided in these contexts, there are some WARN
or WARN_ONCE statements which can trigger deadlocks during context
switch operations. These warnings should not trigger deadlocks. Use the
printk_deferred helper to ensure console drivers aren't called until
after the critical section is over.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 848eaa0efe0e..bc8afc3020a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4861,6 +4861,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
 	tick_nohz_task_switch();
+	printk_deferred_exit();
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
@@ -6208,6 +6209,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 */
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
+	printk_deferred_enter();
 
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
@@ -6298,6 +6300,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
+		printk_deferred_exit();
 		raw_spin_rq_unlock_irq(rq);
 	}
 }
-- 
2.30.2

