Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97754523C73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbiEKS2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbiEKS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:28:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12829666AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:28:43 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BF76rg004989
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:28:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tw2v+z3WvpFXRNRb+a754VVZknR1mlKYjWJKuFrxMto=;
 b=DPFnllONxsSpx5ySd118vE2VcDisCYG9K+rvHqUffSVuqmOR7xIovH1fiVnMuTSdBf23
 Ew0oR7uF1jTh/llmUgKYOIUbqLsuVE+/fwgib9LmVD6sop/N5SEWz6WPvkR/Xv1h0t5n
 RvJhOqT2SRuk2lJnxcPYsaBhl1uoCo+YiAI= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fymp4kn8h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrQRfDbeqywW7dYPIGEbaNyUFohe+Ok7XZf4xzmDV6v2netz2xnkBMtuQw53bFiMo6HAaRjF9UawSSmCfN1hwjIeOYRFYybL0T/ldh5iUNN5ZRFDBqS3HUPSd9+ThqAHCVUrtp0EJUDnxY39IK/FvFFLkbb/fcxymrSBFml/xtDp+/UAFzJBPgjtQijqEu1oLEOKpjf83mWNiq+Fs4zLbSPeakVwE+uxZFEDChHTh4kYHMO8Me13gj4UEz/P7t0a3Eb9Oox/0xP2/MFqOD/bYOa0zVfDu3MFQ0Bhzg7ByEOP5o5vmzaBG2rvrHc+ZYQ80DDzxKmqdaV5FMoyb+UTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw2v+z3WvpFXRNRb+a754VVZknR1mlKYjWJKuFrxMto=;
 b=fTkYUsZmZaSFZjxAp1pZWo0tgO8qnSk6K/VKuqoexeC0DFO8YeQAqvoTHb8NqcEySiAvQEhYXzcHO4N7OhIHHTmLvra9LpM+kH9+00u2/jaGvBTEnNmAiadKfZaX5MCYD4KYE7wbr5usABp/CdzJyMTCPnjTS3xCKSz4nYw8OBYby1EX9J1KzbUBdl1An217BZJ9RZr+rjILViAHCOICYfXhWWkdoUFREkPiotajTTrxV332JT4yftTeMsPpQ3/c9FI3hhskvuUP6Uca29TJ0Wz3dVR+bzdJOOLfkkRCWk458ryctgZzFPdwmKSLm6I2CgL/qKfxnCgOC8cJJAFhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2760.namprd15.prod.outlook.com (2603:10b6:a03:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 18:28:36 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 18:28:36 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        Delyan Kratunov <delyank@fb.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "legion@kernel.org" <legion@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: [PATCH v2] sched/tracing: append prev_state to tp args instead
Thread-Topic: [PATCH v2] sched/tracing: append prev_state to tp args instead
Thread-Index: AQHYZWTtal611vJ4QUO/kiVgC1hiQg==
Date:   Wed, 11 May 2022 18:28:36 +0000
Message-ID: <c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com>
References: <20220510082940.GA100765@worktop.programming.kicks-ass.net>
In-Reply-To: <20220510082940.GA100765@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af07cb9b-3b56-49f4-dedd-08da337c1004
x-ms-traffictypediagnostic: BYAPR15MB2760:EE_
x-microsoft-antispam-prvs: <BYAPR15MB27606793B87AEA57C594D71DC1C89@BYAPR15MB2760.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxH9glTkPEi2lofwpUyghYnyRJDI4/1BWI7+3jsSbRBsFL5j8s9e4MADp619OZ9v6QKLYdKYx3Hvd329lvWzUfbSbICBVv6CfHF8F1e0aMbvzMlKRM2/bVEwevKTp4DW5pnDeYwBy2uPkzQmJm7//xB2j4MLT9ZZDrrqv1Oqq3EE4J2h9kg5Ohjqq5QuYWXbxFS9EIlSQfkvptbS6EuY4oa2lWo2R7S9XbjvSIdU3dViRd8lYSC2tPzpOf5+/dON+Aj5OJSOMIkrVN4q5UqI6atiz7E0oYRr5s0M8rEYLHEsKWOeCWwIppsq57CcorhPZn64jibXFEbPc6cqwq3JY06LWOl9tHm5zSl69j++BXy+7miUWLEFSzzUWXd+cSkkXI25BrUms8j0YQ6LBZbNt+UQqdcABnFA4A7qnYHXFrHiJw7ZYhtHOP6GiN+qIl5GSyQzG5wy3vmlEESngFAUAWWtRVXXMp5mF/nv7ObVJt2hziqhyMXFWATgCxifyZyt+Ki93wtZa824HOitQFp+Ly29AuAyIUeueY6/MDnA9mYDLu5OVurTSWjmuyInF/O6OAtHVjH5A3flpjHa6Cuh2GdMKETIRUNYu0P7to1AxNsA+yMOpb1Z/i6OEjl++ih90uRfGMpkpEEHoa9ClbbQE2/nK1EA0/kGnhuS7B8RNr/KqZyTQlQZjhZbdiKxhrvuwlUTcp167r+ZqK/dtWFNCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66556008)(66476007)(66946007)(122000001)(76116006)(66446008)(4326008)(316002)(7416002)(6916009)(54906003)(5660300002)(8936002)(86362001)(83380400001)(6486002)(508600001)(38100700002)(71200400001)(2906002)(38070700005)(6506007)(186003)(6512007)(26005)(36756003)(2616005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QaMh2O3GTBaqmLAehDLI7QpUnAkV0EUPM41HDsBWqryKB+zEZOo9wl4j8X?=
 =?iso-8859-1?Q?UDTjKGK5YZJRCE7SF9l/rLfjqz6XiNYHRcLvzfmt3YOicyR4qx+TWebGod?=
 =?iso-8859-1?Q?H//f5olX1wby5SQtWKYLpX5/6PYGqAZ781EWnIlPnPGlbN459krkw0eU8l?=
 =?iso-8859-1?Q?nV3eJspvwkbIakRiNmMiQB/5+DiJMzWyGN+M4Je/M7bbIb3PTVP0S5Wl1E?=
 =?iso-8859-1?Q?brassqaO0/THLhAtT6xIHvBxMVuRPXzGUYorjLxIAdBrpd28ICOUXEanG7?=
 =?iso-8859-1?Q?NB5/UI74uFgFFmxvY6pTykZFeuD4iBG0cK9f6xmThstCcl3h1eLrTb/ZQT?=
 =?iso-8859-1?Q?oBheoPW3RKKNRzoBG6q5mNps4XzXVXhiNsQd22vgdfuekZHkd4/RxTN1co?=
 =?iso-8859-1?Q?H4WJHagoCbHCEiJE5F/yjvfKSZcZb/zHIBvt14zAA6XJj+ua4okSStKU7Q?=
 =?iso-8859-1?Q?Ee3VzkeC0JXvY6ra11pUtXxDMZV422OGxQF8jPakUaUWO+gXigS6ChhPwS?=
 =?iso-8859-1?Q?DHrgHQCftxzgV16k/x2gGHz8snhF5uqNtMUy+lUtXmzYltB+BpEl1xdlhs?=
 =?iso-8859-1?Q?DglaVTvOO6tDMVU3ZfQn6dhkgnDLA5kWyMvKFZzmofnXTYvTLRZ6p8v/8k?=
 =?iso-8859-1?Q?ufLOwZEAiR6ZhSryYiBG5uT8IVwNqags/VIchVfzdj4EZ0W5/ZGuZi/6dQ?=
 =?iso-8859-1?Q?6niAx71Hu6gFAFs7iT0ygRFEijMPIqiIRCa3e7II3S7Jvje/PRrF/eI8mD?=
 =?iso-8859-1?Q?CEpIHLbpO11cIMuFOMdwHHat75ILLrMohY1z1iWZqGw4hLzkHdSviEcair?=
 =?iso-8859-1?Q?qIgVHMGuHPWUCm0lan0nuHC02uCF4Jq31/twZ+rLgnO/r8hWhA3stQpYRh?=
 =?iso-8859-1?Q?pIm0qptt1jnplQvIdHq6/2uSxwLVnPPAp72L2EK62KrcUzjIRNt0IhY6pB?=
 =?iso-8859-1?Q?DITiM1XONJUv6j/BuCmqvfvimsNj1ZXGOIXtp/+GWrd8ZX37xsllLJtPYX?=
 =?iso-8859-1?Q?HH0GRzEc9zuJqX3q7C5EEoMJdM8sQhIPeXrGC4EPV0HtCGw53ld8/1S76n?=
 =?iso-8859-1?Q?cwOGJ1rhntQmYw9iR7p7DCFCD065Vb0Bnz71utQppmeBLlq7UiyM6i3Yuo?=
 =?iso-8859-1?Q?qhnO4Sp0t7LiE5MV2xRXTN7BRekiWvYOb2neGUSkDfQ8hTi02yxppjfo7Z?=
 =?iso-8859-1?Q?/F3ZYHj8WdSKzlrhFsCA8loBMI1ELj5Ll2P3J43USNo4LxUz6wFOTo+lWw?=
 =?iso-8859-1?Q?hkmqpG3aH0qn+89vuaRlxIKJOsQIBe5IgFSTh7LZgTadz+Jj7ReFYgPVHq?=
 =?iso-8859-1?Q?eq2mfQgDYCc8RsVrshriVgQd96bYUkWYNIDUIeO1fDyi+g1frRkuNBlcGa?=
 =?iso-8859-1?Q?Glv6AMvDO2iOOcvc1Sb54N4c9yqJqvXT77maZ6nXFGcMfZpidttuQdN44H?=
 =?iso-8859-1?Q?KpiuIgB5hueRKYGmmPbWg+vaFUhXRrfmrdPz93qEQ4On3YTVaFBpsvYP3l?=
 =?iso-8859-1?Q?4BY+CKPmcIy8RTXlLDhjcvDKAjSciRqQ+dvR+eEehKapeGP/DnFB516/e9?=
 =?iso-8859-1?Q?9xgLgoSLYxReh86pIqE1Ct0LzSx1LjMEzszEKhkd6ydAGS8vRODUD4UBnG?=
 =?iso-8859-1?Q?KtPewIrnFUlwmiHAcXacVuNmhj5xkf9geW+s/CLxsY9CFyC1MCX82LwFoR?=
 =?iso-8859-1?Q?R+T2UMAf0b1pPg7u/vCvnZB5Nc0YsNy7rdcGCAwmffYpHnapWZ/5P1UP0K?=
 =?iso-8859-1?Q?E0/HPsEk8lItUEMnw0QI7JdTFg/tS6ya6k4xMAvpe+anJgxHjwqAb3jhAR?=
 =?iso-8859-1?Q?AyIOQqXRPA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af07cb9b-3b56-49f4-dedd-08da337c1004
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 18:28:36.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBuQ3YGlIWOiFHPgZCyuJS3XLYiWV61wY8c3GeZ8/Tkz3U5O5JH4rXuIFcqqEqaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2760
X-Proofpoint-GUID: ynYag_5U96WjF1KsJdm36jHIv0GP2h2z
X-Proofpoint-ORIG-GUID: ynYag_5U96WjF1KsJdm36jHIv0GP2h2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
sched_switch event, 2022-01-20) added a new prev_state argument to the
sched_switch tracepoint, before the prev task_struct pointer.

This reordering of arguments broke BPF programs that use the raw
tracepoint (e.g. tp_btf programs). The type of the second argument has
changed and existing programs that assume a task_struct* argument
(e.g. for bpf_task_storage access) will now fail to verify.

If we instead append the new argument to the end, all existing programs
would continue to work and can conditionally extract the prev_state
argument on supported kernel versions.

Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting sc=
hed_switch event, 2022-01-20)
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
v1 -> v2:
Convert trace_events sample as well.

Sorry about that Peter and thanks for taking it in, it's much appreciated!=
=20

 include/trace/events/sched.h              | 6 +++---
 kernel/sched/core.c                       | 2 +-
 kernel/trace/fgraph.c                     | 4 ++--
 kernel/trace/ftrace.c                     | 4 ++--
 kernel/trace/trace_events.c               | 8 ++++----
 kernel/trace/trace_osnoise.c              | 4 ++--
 kernel/trace/trace_sched_switch.c         | 4 ++--
 kernel/trace/trace_sched_wakeup.c         | 4 ++--
 samples/trace_events/trace_custom_sched.h | 6 +++---
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 65e786756321..fbb99a61f714 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -222,11 +222,11 @@ static inline long __trace_sched_switch_state(bool pr=
eempt,
 TRACE_EVENT(sched_switch,
=20
 	TP_PROTO(bool preempt,
-		 unsigned int prev_state,
 		 struct task_struct *prev,
-		 struct task_struct *next),
+		 struct task_struct *next,
+		 unsigned int prev_state),
=20
-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),
=20
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
=20
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev_state, prev, next)=
;
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state)=
;
=20
 		/* Also unlocks the rq: */
 		rq =3D context_switch(rq, prev, next, &rf);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8f4fb328133a..a7e84c8543cb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -404,9 +404,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_st=
ack **ret_stack_list)
=20
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
=20
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
=20
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
=20
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
=20
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_s=
witch.c
index 45796d8bd4b2..c9ffdcfe622e 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -22,8 +22,8 @@ static DEFINE_MUTEX(sched_register_mutex);
=20
 static void
 probe_sched_switch(void *ignore, bool preempt,
-		   unsigned int prev_state,
-		   struct task_struct *prev, struct task_struct *next)
+		   struct task_struct *prev, struct task_struct *next,
+		   unsigned int prev_state)
 {
 	int flags;
=20
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_w=
akeup.c
index 46429f9a96fa..330aee1c1a49 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -426,8 +426,8 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
=20
 static void notrace
 probe_wakeup_sched_switch(void *ignore, bool preempt,
-			  unsigned int prev_state,
-			  struct task_struct *prev, struct task_struct *next)
+			  struct task_struct *prev, struct task_struct *next,
+			  unsigned int prev_state)
 {
 	struct trace_array_cpu *data;
 	u64 T0, T1, delta;
diff --git a/samples/trace_events/trace_custom_sched.h b/samples/trace_even=
ts/trace_custom_sched.h
index 9fdd8e7c2a45..951388334a3f 100644
--- a/samples/trace_events/trace_custom_sched.h
+++ b/samples/trace_events/trace_custom_sched.h
@@ -25,11 +25,11 @@ TRACE_CUSTOM_EVENT(sched_switch,
 	 * that the custom event is using.
 	 */
 	TP_PROTO(bool preempt,
-		 unsigned int prev_state,
 		 struct task_struct *prev,
-		 struct task_struct *next),
+		 struct task_struct *next,
+		 unsigned int prev_state),
=20
-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),
=20
 	/*
 	 * The next fields are where the customization happens.
--=20
2.35.3
