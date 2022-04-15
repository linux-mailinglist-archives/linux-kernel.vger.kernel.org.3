Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0AF5020C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348984AbiDOC6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348968AbiDOC6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:58:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FDEB1A86
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649991367; x=1681527367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=omKK2LuCP88QqAQmn1Zr8y/2rQOO1a+13IJ589rfBGA=;
  b=fC9aRMlrdiCVD11/gn7pWiYk1rdNNIt/0QNyDWKmMxItz/3vThES218Z
   y5owzqalE/howRJIIwDKCdGyewPK02C2iQIu13fxU8iY5EEjawuLxAX7V
   df0oQyHKoyC6vYHS86F9ftyYeBdXwmoHLzodraGKrkMd8lCtrVxl4Rywy
   1OBncFoIONo5U+isTri3rQ5EQwMTAWiFtQANzoYKbsDcfuD7njCAH8nKa
   iXDCCQdCzQp+eLBaYLt6ErQCH82wMIXtwJSFekkLIjbssjmlqqgnR+Pmb
   B2/NmZLD2he9ejinQhDmTvkb8CiHs89jTJIu4Xb1l4XjdN4tJpZEcOQVI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="325985478"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="325985478"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="700899372"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 14 Apr 2022 19:56:06 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 19:56:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 19:56:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 19:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu3KbYcAkA3CtXu4ZcSmtMQ60qFZNsWlOHREN2KfEYP72pR18N+zgz9K1w4ib95Zaq08Q8ZgHxOg6bavkRA+dUji/9Pv1LYic2+TdcNehQUT0uBV3a6el7LNDKl2GP2B7ZEL3mcfLff2kD4iPX+FkM65YrXj0thWT2wRl0R5niZWoL3ZfeIFmeXKuNVPqA1lQztPTDzUC3x3+neMTsoY/JA0aLokX9Rmw8tJ4hfByVETMSz1lgcDDFBiQk/PqfiNedHAQlyTAoqmP0OxdbBLcHn8Tuj8iobI2hqdoAJ6t0wIOt4ZFumNs8ckNoyoXMehUCnspG4UKRbZPW/uUX8c/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5EGx6LNvjNBykSLRrFNBTCCc1Dj1iFyuGBCNjb9tcs=;
 b=lHdJ6bPRiR5VDlX64/vv7eLLNPvxHgvrq4WaITWEhImtnwSlt6PIXucr/vMRFKHAu2r9IsiadmyECi1h0N/aiJdy7D88Hpyc0TDeXXix1gtSdK3Eaa1t+4K0ogNnXZ+0GlME+HgcSj5SYopEw+sGxB7VIW/yQUhjKE9HD3BWjMp1ofEGgr7TesNtinoesI556D0UIjcTWciEyFEK9SeXJbOjxOAsE6pGoYp686Kz74wokVgAH1ZeJDyQLAxX1Elrn0lDRLQjEZuxF/cUMmp2w/ZZAEnWCNINYgrJ97RwwswksGVtya8u9QtLN7jFwWdh8U4dtC5IvVah7FXXqpDneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BY5PR11MB4134.namprd11.prod.outlook.com (2603:10b6:a03:18e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 02:56:03 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%7]) with mapi id 15.20.5144.029; Fri, 15 Apr 2022
 02:56:03 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] irq_work: Add event-tracing points for irq_work
Thread-Topic: [PATCH] irq_work: Add event-tracing points for irq_work
Thread-Index: AQHYT8pATG0NrCtQb021NYs63/f6NKzvJWsAgAEN6hA=
Date:   Fri, 15 Apr 2022 02:56:03 +0000
Message-ID: <PH0PR11MB5880057FA69287500580FEA3DAEE9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220414063829.2472251-1-qiang1.zhang@intel.com>
 <YlfqFJLau+7PlPJ3@hirez.programming.kicks-ass.net>
In-Reply-To: <YlfqFJLau+7PlPJ3@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a0a3421-d924-4fda-eab9-08da1e8b7aa4
x-ms-traffictypediagnostic: BY5PR11MB4134:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4134D86DFD12196607548C0FDAEE9@BY5PR11MB4134.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTnO6SdkBJzfqNi1Xv8LiRlDVGQmjmDtd5BFTQCVHzv++ibCoCewJXIbc6CfV3vAXvBeiv0G9Iro66S0f2OXocm+X4RcpxKLXaD4je5zsPsUHcyt0p5m2k5qQUHvqzro2a9Tb6qvOKU/hhAppYH1n9ozYqAESuxM5JgBprVG5HuOIWxz5K1NsvVEldW24BJtHo0kCcDjaHYorGO7vIfES2l7ftU+FfEPwFkdCYAkoFn9hVjAWan3XfC9Gvu9B6vd9lyNal2QzesQz2jp+gy12LKEOhNQiBzVkVWyMv+zf5HR/RVrrqUaTIZUr3nWGutg6sM0Mpa8ylwOna3QK3smoBf0E7DkTXVs2qXTuw0omHGZy7jBwCs8cbqGn6gXLFzc/i+l3r3knAYCZOfqEsVodCToew8pzRJPNVQv3uMqGtXRbRrnuEU6ENvs7JeGvFug24HDmWz1+jfhG8VTEhpsFmVRI3VoSXHmib3i21n8kX4cT2igZiirwnSAGqlEzeGSOHdmkUcBML1ej/0/+dTYLfb7byzq1zo0b3ub1iKAmqJkSQsH8skWfOywnHZ8CPVW+JmXc8z6Z51mK+PqLLlf0g53Yyh39t19GMPQXJHlIoRoKZKRR+Lp+tjUfznVCQKOkIeEZtsUJTkbTpXz/6+CnyLxXWCFkxAyKOCmDfP4eiqzDMIuHDWo1UT4L8HOeAhq1nUGp2JjVg5549T5Jbv13A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8676002)(4326008)(71200400001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(83380400001)(86362001)(2906002)(6506007)(7696005)(9686003)(52536014)(8936002)(26005)(186003)(5660300002)(33656002)(54906003)(6916009)(122000001)(82960400001)(316002)(38100700002)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jUVpDzjeKZkwo1AYeyBd3kJFz4BHB1YzkdabDdwh9GfPh7TWH8aqrhPfREVm?=
 =?us-ascii?Q?CEOn6FkyTw0p3jRoxueS37rjk9hfT4yT+VhUurr9+3dSi2YBDoWkRi8xtCtA?=
 =?us-ascii?Q?DAL3F8jXSC/oID6M57L+wV12GXN7gEHcuygVRIBLZgjbAlxx3mLnZpONGLPs?=
 =?us-ascii?Q?16QrLVgVcElNdVlhndHgI2Vq65Mh/ez8Bf2Rg1j5jZnaV9xqKlgbqHiANcpQ?=
 =?us-ascii?Q?fbgkMCvSSfNmnE5B5yjV6rVCaLehpqpQGuyGtI+3SC/UWFRQJR0H6okSur2l?=
 =?us-ascii?Q?rh5oRTkX5/esvxzoPtEFPf0RmyryikSZ8cgORX6YwA9kO/myew9SPXnjqrVW?=
 =?us-ascii?Q?EdXJgAymCrXktvdOWdPby1JCW53znH8C5ZeSkxmRe9EvxMJv1SW9F5OMwg16?=
 =?us-ascii?Q?Dvtngf7iXcWX2DU0Tbeajh7opn5+dEJ3eU13+DGRDjRDFGvM4Up6x1yRP8bY?=
 =?us-ascii?Q?BZRENX+TEcluSl39R3KMf6SP5vvDlSl68LtTB+RVddeK5YISveGFIQhEAA1W?=
 =?us-ascii?Q?UB2bEVT7SGn2owLyTPIfibLz6gqgF/nld7P33Im3X2qG3lqgigFdLbCqcvDg?=
 =?us-ascii?Q?lBpKJjNnuABcY87+bO3Nid27Ek7mFa+Fz5l6GJe9cMayXwkrLmhdwCdX6YEl?=
 =?us-ascii?Q?lxQyCjQpQolOlZM2V2OtY1XCXyfSevNIFjxIsFs5QvN7kjWvZTxkmECLFiy1?=
 =?us-ascii?Q?fGsYyAny1i25U4YCusxopl52vn5IHVoYFArqPho86JLxIitSGlTlSJO+75IM?=
 =?us-ascii?Q?Sk0A6PFond5fyveI0umxds4m0oDvgnCXqLVtiLvmUXQjBojqNhCCiSRlh/FF?=
 =?us-ascii?Q?6owoTV57aWRdJDC8hBudNiEsnDSgd8tmoyMKO3DjXooehlbOMCRWMMacxYEo?=
 =?us-ascii?Q?JGs+9UnKiOKbxZSlC1BzkXgbmo56STF2Dz+v/PtcHqzaVau8wNyrsWKw52E9?=
 =?us-ascii?Q?OXylbQixM4hcoig9Z7TQg6f46rneSeimntQwYTgcZuoGKW2HA/FVMkv5fKgC?=
 =?us-ascii?Q?VJ+kQUmSTljVy42PhQQeFndKWjZVb6uq2Or6htTxXpNH7sq44Rl9jz5LlPLO?=
 =?us-ascii?Q?nseWlMaH4MPDRcJtd3NnDOoUg/fstuzPRZDaN17TUmaXuQInpEEXctnSaCeP?=
 =?us-ascii?Q?xaL+HCm93nN6MV18ozePVtu3JG8AbiqelYK/7rpMwaNx5a9UvhVVFgoidG6J?=
 =?us-ascii?Q?G7SYYnkrGg4FtvjyWgulFj7eb5Lg/M8atMNBeoHvuUZU2jm43x5Nu7p2mDA3?=
 =?us-ascii?Q?l8KNVo4dY7MrPoQBJROjp6ZqtEtJCs52U1uafHV2Id9g6tVkDXQMFxwNNBIL?=
 =?us-ascii?Q?wUsoLySaljScqqzs3vUszh9gkDhOvcpvsWuxS7AwguOqYRlzgrUuIcDqSP/o?=
 =?us-ascii?Q?WzLWnDiKrh49L8aiPLTVH47WwbdXV0wjSToNaifR1EjDSuw+QG4xUrVht2Ze?=
 =?us-ascii?Q?CpbWefb7eToymRJpfV+862UIxPJD4P8DOSSvLEatKKFq49eTidfS4zGafa1B?=
 =?us-ascii?Q?1mQSq9MWYEpW9MABpsiwz+u8DJjxjVE3yEDc7s8Mec/GFYNLXoMtU96q7xJN?=
 =?us-ascii?Q?1s4CNucnK+3zfFnA4WFmlVdwpXQPXoUzxfeLwmOcIGlz3BOyRoiobXFai8oN?=
 =?us-ascii?Q?jx/fn5rxdrthXp8kua6XujZW2uKHWqWRTpO4zGh/LGn/Veg4kM8VVo1VcUOK?=
 =?us-ascii?Q?5jugYDiopAJyR4mFsNzIJPBx3mvy91yhC1vKSEQ6gZ8dW2tGGyCma+b1BYwg?=
 =?us-ascii?Q?WaV5X/SC6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0a3421-d924-4fda-eab9-08da1e8b7aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 02:56:03.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjSNx5G9MbDO4XZfCmEvMQNM1FDNjdoBiyvtcNE3Hc3DEWswLWuj233LNDwL5Tm1NbYHJ0mkqOWOnRWYH07R3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4134
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:38:29PM +0800, Zqiang wrote:
> Add irq_work_queue_on tracepoints allow tracing when and how a=20
> irq-work is queued, irq_work_execute_start/end tracepoints allow know=20
> when a irq-work is executed and the executed time.

Yeah, but why?=09

Tracing stacktrace help find where a irq-work is queued, and view whether a=
 irq-work
be executed  in irq context or task context,  if in task context, is it bec=
ause there are lots of
lazy irq-works executed in irq_work rt kthreads,  cause other fair task can=
 not get CPU,=20
for example, there is a problem in RCU which I find in testing
Enable RCU_STRICT_GRACE_PERIOD in preempt-rt, the system booting occur hang=
,=20
through add irq-work tracepoints find a lot of irq-work (rcu_preempt_deferr=
ed_qs_handler)
be executed in rt-fifo irq_work kthreads,  init kthreads  unable to obtain =
CPUs, cause hang.

=20
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c index=20
> 7afa40fe5cc4..edad992556d0 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -22,6 +22,9 @@
>  #include <asm/processor.h>
>  #include <linux/kasan.h>
> =20
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/irq_work.h>
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);  static=20
> DEFINE_PER_CPU(struct llist_head, lazy_list);  static=20
> DEFINE_PER_CPU(struct task_struct *, irq_workd); @@ -81,7 +84,9 @@=20
> static void __irq_work_queue_local(struct irq_work *work)
>  	bool rt_lazy_work =3D false;
>  	bool lazy_work =3D false;
>  	int work_flags;
> +	int cpu =3D smp_processor_id();
> =20
> +	trace_irq_work_queue_on(cpu, work);

That's not very nice, you made this function more expensive for no reason. =
And you violated coding style while doing it :/

You mean the trace_irq_work_queue_on() tracepoints should not be added in t=
his place ? or
replace this tracepoint with  trace_irq_work_queue_on(raw_smp_processor_id(=
), work) ?

Thanks,
Zqiang

>  	work_flags =3D atomic_read(&work->node.a_flags);
>  	if (work_flags & IRQ_WORK_LAZY)
>  		lazy_work =3D true;
> @@ -143,7 +148,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu=
)
>  	if (cpu !=3D smp_processor_id()) {
>  		/* Arch remote IPI send/receive backend aren't NMI safe */
>  		WARN_ON_ONCE(in_nmi());
> -
> +		trace_irq_work_queue_on(cpu, work);
>  		/*
>  		 * On PREEMPT_RT the items which are not marked as
>  		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work @@=20
> -208,7 +213,9 @@ void irq_work_single(void *arg)
>  	smp_mb();
> =20
>  	lockdep_irq_work_enter(flags);
> +	trace_irq_work_execute_start(work);
>  	work->func(work);
> +	trace_irq_work_execute_end(work);
>  	lockdep_irq_work_exit(flags);
> =20
>  	/*


