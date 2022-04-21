Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941150AB44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442408AbiDUWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442409AbiDUWPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:15:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EF4EF55
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:12:32 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23LK2EB7019054
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:12:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G6rlygQZPrpBjvB65Kbu9kY1rlCgvxyLiiFozge986E=;
 b=QBjGcimjRu89+ihM2082TXPj3rDpaYenEWxhUTHu4t+Uef2rgSPb26O1xou5MttsefqU
 ZutMLOBbw9ph7v14CkrI2EZwwVbP/LsbyZqQxgOId5Na4vceIxRPI+PzxXYGKdYW2MmH
 6ut6XrOZIHkVop6LISVlqfAQ2vSJQe4yL/8= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fkc2v9p48-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/rCTj1kc24pXjgsdIRbcDswt06NPNOgkMLV0FTdzLqbbXKNdkE2Bvj3q2G4U92KQ06LezBquQeKjZTlI1miGWnufDulYdLFclHU27mJMED6Ir02p78pVtbOqAuPWhYySt+ffNU0uJpPBLqZ+Oh+XFy3cpRQzGse/nefXsuo7Ke7CjsjdI4kgZn/cnwmcHV/wlttNzn3+665fzyuCK8Ptf7zgjgFhHZLS21M8R2fA8t/LuF5IezGMiinc19La9Oq7/6A7CM6zKZ9Dew9P0PIR8VnQBTY/cGgyx4qf8b6qONo/GFniX/BJXh51jndxedMevqVziHuSYLwUb+wP942sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6rlygQZPrpBjvB65Kbu9kY1rlCgvxyLiiFozge986E=;
 b=DB3rDlAUuKsIGOaYUHYIaBwSGh1U2PC4JBHw8hFd7RbPrKFTkJU/D/KsEiHqXp2CDaDtUGA+i28nEx17yhYF3yFFALKjgETfG809nXp45a+BHtEs9xMmKf4F0fSHJlIKa6R6KR+1zhZQwd75wPhJOaLoNucfwFFVFLKtoWk/8GNHuE2H0EgAM67+Izz4a9RhxSYloIevLtcjnFIUzeME3SYpyJzBWZwIvHLenXx3NnL60n+fVrgJeC+szxlx8Tz/8opCw9a+TGgGZkXMofTlAt7kreplaAnJDTgIMUrk03e8EsTCpyfqain1+E+8kA0FQxcMojTSLxsdScJ/coKLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BN8PR15MB3043.namprd15.prod.outlook.com (2603:10b6:408:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 22:12:25 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 22:12:25 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH] sched/tracing: append prev_state to tp args instead
Thread-Topic: [PATCH] sched/tracing: append prev_state to tp args instead
Thread-Index: AQHYVczhnUORkDZpQkKGkRu2ddUCjg==
Date:   Thu, 21 Apr 2022 22:12:25 +0000
Message-ID: <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8be1eec0-6a97-4747-6160-08da23e403ef
x-ms-traffictypediagnostic: BN8PR15MB3043:EE_
x-microsoft-antispam-prvs: <BN8PR15MB304330ABB99CB8FD9A1F36B2C1F49@BN8PR15MB3043.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5k9VcZnldMmy6846i4gd6/RMZSF6/SB/brczL+s3AfyTe4wXAIm8PxTOTjAoiTxQd6Rx9+mwDrei7SzEV/HLmAuI3r1BJy255q6hs4rb1cJgI0I/6r6vxu2UdufeLgsm7glmDihp7cFQ18xs8RaD6A4nd/seNXwJrx2Dq3TYv/z2FaPEMv3iZobb7q0nbuLeimg3DkvYNBVA0nLKv3CtH0QCyC7/R4bc7bS8WOMlUTUhb7y2JyhIWPHehkW9QNYne5Rg9ZeZB6uyh/VpGjs4dZqtgSS0+WDTTmWKscn1AcCMXx6fY0HL8AV7suUiUrDEijaQdum/JVt5Z/QF+ZWTRo9cwkbwBWMois5TN5YUquoXYjX9iDwIeELL8oKKHsJKszcdz3dC5h8H8kVTs7nqBkl6S7jtPzXNJdx9HjUjBlffmzR3ep+YcpvVWFamqApRalHjuMt69vWS4/LsY5JkICb9Df6nUSDRO9ZBr+3re5Znij2x1l9EagmBpu4DoDlU8hJOEArjRr6aSflpJgPzi/U8mCpeA3Y7mq1zdFNVR/DsSpvjssfDC/EngQmuHeF3lLOSUhnuVVA2dGrJf9/Qa5KAN/E3zLRiaoLn/3uzd7ztqgcSP3WiCma9xpi9lXh6rgv1+KNh381PpX+OFk9/90eOjGu2i/XAPDYZNmf9ycxcT1BJViYrbIQnO5RRIbcRZkfiJJJzxCAkkdE8Lh1g8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(66446008)(2616005)(6506007)(6916009)(66946007)(316002)(66476007)(54906003)(66556008)(91956017)(4326008)(36756003)(8676002)(76116006)(64756008)(71200400001)(6486002)(83380400001)(38100700002)(5660300002)(38070700005)(6512007)(186003)(86362001)(8936002)(122000001)(2906002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?06XMO6KRMvrhQdgfryLP/t1T6GaOPr8qQKqq1XlxYczGr/GKxfIdg+uKko?=
 =?iso-8859-1?Q?rsWY3LN1qXFYUUOfLR66IrpOeMzDQUJKW/AGQ0pttoQ+hoVa0CmXA4gDbT?=
 =?iso-8859-1?Q?B6QMPSiJ35l6gIwLOLCzSJyhfckZIS5fHRj2kkZfJbWN0lYMnd/mvo3e1l?=
 =?iso-8859-1?Q?MVJ5dE/i5WKpFj2iS3BOgHTRjTlxE/SVeRA9lP0gqjsryxubwOXMDoGZdI?=
 =?iso-8859-1?Q?E/nIvSrbSuoKOsXNRY7ByV7lBkVXygc8WGHog/WdpkDvWYWZ+dpn2eRepY?=
 =?iso-8859-1?Q?vSY0nM97aeLwYxPVjkMFCI94pJT/QIRINtlvNv5yOya/HZqKHNLSn9NeFQ?=
 =?iso-8859-1?Q?pbvJnJU36l3AFdQHXrftbTRCbCsXhVm5aR1mmTIONN7Iti4kNh5DV14a1e?=
 =?iso-8859-1?Q?lV6gN0dJ15fOSXBwHi1KOs817C/8eWliHkZrJVInps6g2VTVhT3pVCO/yw?=
 =?iso-8859-1?Q?xM/uW6zq45BnxCKhaB506+UDK85pdFnQDFxNxDGP9usBBmACCnHe9JtA8Y?=
 =?iso-8859-1?Q?Lp6j6vo+OSii6OGUHgyVJE79sBVPCOgWT5jS4Xrx08JUNH77OjWVE5liIG?=
 =?iso-8859-1?Q?n4BeYdWFt2eJutkiMbvVNbhjprlTc+soQZWz+x9TlOK4Hgyg01j+aZxCcb?=
 =?iso-8859-1?Q?kgDDklMq/w/Kdgqk8VGpSnXO63rZBW2EPcrA6RPKwFWv1CuWc1hBYKG31g?=
 =?iso-8859-1?Q?JYh3UTIrWFjQXCBm/0GjnSiDvQAJ7j4CA4HKX5rIp4xzr2NL84illkH6N8?=
 =?iso-8859-1?Q?5lPUcaycYn3AVMtIg2Tb2U8y/+CQgf5XS4Chwv809LmsbN9W7GBFIp/ZC3?=
 =?iso-8859-1?Q?wKZgOgLXCLZjpQ7L6NDGBTsBwMR0X87+BGMa4oiLWioZHQX7nrKOUw4OKq?=
 =?iso-8859-1?Q?7IcVhWBExFci83LUHjoYAHmFPWJHf89bN7W8czn8fvCZvGAGmi485l4R3G?=
 =?iso-8859-1?Q?Yrvhid5CW/q6TY3ATp/db+SJTd7kynK3YlThYLU1rbm+6NL+XF0YQ1VyQh?=
 =?iso-8859-1?Q?K8PLe4RBjDhFBNs3bfnEPE5GSnS5j6unI/Bh2tFyRtyVjjFepnf3ifoctU?=
 =?iso-8859-1?Q?vKX128AsVjFoD8YWs0hSrNOC//yDqR0w2H/WijJOug7bMnG1U/iF5g5Xy7?=
 =?iso-8859-1?Q?kKpF5HGz3SEUPo5gh6Wcfrc6k24+Jo3UnE9UHor67S9tU/wNVe2niKSokU?=
 =?iso-8859-1?Q?Wr2jyxx865Z8w5q1znRs1D1yC5SBiXpFGuqql7lBKPr8iZSKoBILmk8fW3?=
 =?iso-8859-1?Q?Hw0mxI/F4S+tT5Ay6j8cWpdPonK49PuTHBQtUAtZ+lHQvc4fqSKeD+w4NN?=
 =?iso-8859-1?Q?3UMtfAXuG/gC3C+N8o3T+FFVw0ykXta3UntItw6J3GnxM6toIlTEgjr/qF?=
 =?iso-8859-1?Q?dbl6HIB6OQ0CtKrWzkGr2aLu5apBH2nO41rJPl38Dme7re/b9CjCp2Xm/6?=
 =?iso-8859-1?Q?/nr/kXFeZGMfN/YwhABHmig6Fk8tjp0sdYbPYvirDiqQxAuaC8vLMXL6/h?=
 =?iso-8859-1?Q?DcwXUG/a0lAfouk9lZBrj2t7rgNSweMLV72woGeQrPvpNSMg/Ri1Smcc/W?=
 =?iso-8859-1?Q?QsMBRty/rLra10CwLSurqCfsxzbcTgVnXMQeuqyP6ropqpQ2BnQ1ZvkNL6?=
 =?iso-8859-1?Q?LBWoIpYz9tf2p5CM0fZmxM/jAF69RBSEyiqH7ypgnQDsRHSkq0e/ROu0mm?=
 =?iso-8859-1?Q?GW1PKX/GaOmhVH7D99d1QrdHlfy8JONIJgE4yigF9L6vXvRC6GJ8eJpVla?=
 =?iso-8859-1?Q?toLu02VRqrfv0zpRtM4XfSzD7PcuapxBGTWkhwpAKgZhpv5djKvbhWiCLu?=
 =?iso-8859-1?Q?EdndLOLU3k3nKVuMWq/VA2Q1LTtfn2J+6DJfZuJWxz2v0Ngk/nhQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be1eec0-6a97-4747-6160-08da23e403ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 22:12:25.1569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3rfh5Mb9xlBUwkmF/J//Lqx1UtCUl/RgTN8QmbciZqrVzFlEFA9zgsYw1RuKrJq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3043
X-Proofpoint-GUID: JzQMESgWyQ1TDdAcw_oh7ztBGEgH39ys
X-Proofpoint-ORIG-GUID: JzQMESgWyQ1TDdAcw_oh7ztBGEgH39ys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_05,2022-04-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

While working on bpf tooling, we noticed that the sched_switch tracepoint
signature recently changed in an incompatible manner. This affects the
runqslower tools in the kernel tree, as well as multiple libbpf tools in io=
visor/bcc.

It would be a fair amount of churn to fix all these tools, not to mention a=
ny
non-public tools people may be using. If you are open to it, here's a
description and a patch that moves the new argument to the end,
so existing tools can continue working without change (the new argument
just won't be extracted in existing programs):

Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
sched_switch event, 2022-01-20) added a new prev_state argument to the
sched_switch tracepoint, before the prev task_struct pointer.

This reordering of arguments broke BPF programs that use the raw
tracepoint (e.g. tp_btf programs). The type of the second argument has
changed and existing programs that assume a task_struct* argument
(e.g. for bpf_task_storage or member access) will now fail to verify.

If we instead append the new argument to the end, all existing programs
will continue to work and can conditionally extract the prev_state
argument on supported kernel versions.

Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting sc=
hed_switch event, 2022-01-20)
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/trace/events/sched.h      | 6 +++---
 kernel/sched/core.c               | 2 +-
 kernel/trace/fgraph.c             | 4 ++--
 kernel/trace/ftrace.c             | 4 ++--
 kernel/trace/trace_events.c       | 8 ++++----
 kernel/trace/trace_osnoise.c      | 4 ++--
 kernel/trace/trace_sched_switch.c | 4 ++--
 kernel/trace/trace_sched_wakeup.c | 4 ++--
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 65e786756321..fbb99a61f714 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -222,11 +222,11 @@ static inline long __trace_sched_switch_state(bool pr=
eempt,
 TRACE_EVENT(sched_switch,

 	TP_PROTO(bool preempt,
-		 unsigned int prev_state,
 		 struct task_struct *prev,
-		 struct task_struct *next),
+		 struct task_struct *next,
+		 unsigned int prev_state),

-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),

 	TP_STRUCT__entry(
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..d58c0389eb23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6382,7 +6382,7 @@ static void __sched notrace __schedule(unsigned int s=
ched_mode)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));

-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev_state, prev, next)=
;
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state)=
;

 		/* Also unlocks the rq: */
 		rq =3D context_switch(rq, prev, next, &rf);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8f4fb328133a..a7e84c8543cb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -404,9 +404,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_st=
ack **ret_stack_list)

 static void
 ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
-				unsigned int prev_state,
 				struct task_struct *prev,
-				struct task_struct *next)
+				struct task_struct *next,
+				unsigned int prev_state)
 {
 	unsigned long long timestamp;
 	int index;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e7263..af899b058c8d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7420,9 +7420,9 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *=
ops)

 static void
 ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
-				     unsigned int prev_state,
 				     struct task_struct *prev,
-				     struct task_struct *next)
+				     struct task_struct *next,
+				     unsigned int prev_state)
 {
 	struct trace_array *tr =3D data;
 	struct trace_pid_list *pid_list;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..f97de82d1342 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -773,9 +773,9 @@ void trace_event_follow_fork(struct trace_array *tr, bo=
ol enable)

 static void
 event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
-					unsigned int prev_state,
 					struct task_struct *prev,
-					struct task_struct *next)
+					struct task_struct *next,
+					unsigned int prev_state)
 {
 	struct trace_array *tr =3D data;
 	struct trace_pid_list *no_pid_list;
@@ -799,9 +799,9 @@ event_filter_pid_sched_switch_probe_pre(void *data, boo=
l preempt,

 static void
 event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
-					 unsigned int prev_state,
 					 struct task_struct *prev,
-					 struct task_struct *next)
+					 struct task_struct *next,
+					 unsigned int prev_state)
 {
 	struct trace_array *tr =3D data;
 	struct trace_pid_list *no_pid_list;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e9ae1f33a7f0..afb92e2f0aea 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1168,9 +1168,9 @@ thread_exit(struct osnoise_variables *osn_var, struct=
 task_struct *t)
  */
 static void
 trace_sched_switch_callback(void *data, bool preempt,
-			    unsigned int prev_state,
 			    struct task_struct *p,
-			    struct task_struct *n)
+			    struct task_struct *n,
+			    unsigned int prev_state)
 {
 	struct osnoise_variables *osn_var =3D this_cpu_osn_var();

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_s=
witch.c
index 45796d8bd4b2..c9ffdcfe622e 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -22,8 +22,8 @@ static DEFINE_MUTEX(sched_register_mutex);

 static void
 probe_sched_switch(void *ignore, bool preempt,
-		   unsigned int prev_state,
-		   struct task_struct *prev, struct task_struct *next)
+		   struct task_struct *prev, struct task_struct *next,
+		   unsigned int prev_state)
 {
 	int flags;

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_w=
akeup.c
index 46429f9a96fa..330aee1c1a49 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -426,8 +426,8 @@ tracing_sched_wakeup_trace(struct trace_array *tr,

 static void notrace
 probe_wakeup_sched_switch(void *ignore, bool preempt,
-			  unsigned int prev_state,
-			  struct task_struct *prev, struct task_struct *next)
+			  struct task_struct *prev, struct task_struct *next,
+			  unsigned int prev_state)
 {
 	struct trace_array_cpu *data;
 	u64 T0, T1, delta;
--
2.35.1=
