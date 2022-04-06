Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE664F64B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiDFQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiDFQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:07:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1215810CF36;
        Tue,  5 Apr 2022 21:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649220117; x=1680756117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u09UX1cpftFlDy+04/8/MBoFJokE196Rc05lVOYWpk8=;
  b=L+XUUApL9XUrHol0gK5rHzMCgyF+QF6TPQ80nJOra4pp8XaqPsrqyQVy
   x8ZtJT6uYTzi9wAk2z+ykb5bINH+8yasBJVwRxWJELyDtKyO2THLnIwm+
   ORxUIBiieNiuDrMTVeH1P/VFKfAUeGJ9/xYaSH+kezboJa5Njm5I5roFJ
   ktNyxui44yJ2Isxz97BYAHYRYHRTmmqxavbGIOT+D/E0M4Uy7ebLXQB87
   m7HJ7CReIen0prXE5OJFElV4x2TU9/VtQsX0vZFvPnfX7kocY3DK5K4ed
   OwFxQ9JGMn5KGZaUWnwvmadLF4hXcxYhtXL6DSu0+lhv3/8TcHJ22rp66
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324119942"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="324119942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 21:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="697221694"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2022 21:41:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 21:41:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 21:41:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 21:41:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 21:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCVhFPpNjrcZ0A6WK7Fakd4A3LZbDiASBID01190mxFfZLUVbCzl4FoesfaF23Bwed4L5BR3rFq4AVz5jwYa+9GairWLHOgI+ZF72bY7OoHR+lv3quutMOUAvBVleDQg/x6HnqOz4Mnq//S2BDgDVHvwxWnNu6c6B6qf5CTQZ7Y2UAVoZzFghcR0rKTr4DUMGtB+GftG7OC9B/SUiMeeclAR8Fm+xObzn4xvLztcL6llBuvpgky4dJssIm/9Gv/bSIowc26FCVwOOp9NxDHhCehi8X/h90zZyX0QFMGndjfAgqdhPPhv3PAOEvXGEEWppcXQt7pd8PpG9y+bH9svZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQYr+FCBhBQAdzZj79Sc2QCE7ib6vwE1DNrYMPZwJ/g=;
 b=TL/f3LYJn2Vr0OhrmDEzw241tXcfnn6ErZ0/Fcaei2t6IDeOE3vvgWUwXwiE+QTxflCboClu6GFbBB8IYTb5Nza1BKSapG+XGY/xPsJIGe9aISndxXGBo92NMGWyIqO2COhTO9EGYyCx7JkX4wmqw0ziO6YYtwDsiuOdQbzll5CYqny6Os/DhKExikfngD50ZscMGnP3bMI43uAIp+3sjsk78QxFwq196VL3bhOyCWFwksUkEj/g7OfHAfTQkYd0pOxZZ/oPgc/3+g0UMmvUEqOdMP3/KCaD2XcvhwIEOyeuWfOj/rZ1OL2vFbmG6CEdd1EQeBcuHQDzfkHP4nOc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM5PR11MB1657.namprd11.prod.outlook.com (2603:10b6:4:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 04:41:46 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 04:41:46 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw
 on PREEMPT_RT kernel
Thread-Topic: [PATCH] rcu: Use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw
 on PREEMPT_RT kernel
Thread-Index: AQHYRyIUb1aC3TohkEGqUigSyiIkjazeVbAAgAP8uAA=
Date:   Wed, 6 Apr 2022 04:41:46 +0000
Message-ID: <PH0PR11MB58802019D7B5F23CEACE2D69DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220403061440.2762522-1-qiang1.zhang@intel.com>
 <20220403154626.GO4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220403154626.GO4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: e5a7724f-dfe0-4ee2-6bec-08da1787c201
x-ms-traffictypediagnostic: DM5PR11MB1657:EE_
x-microsoft-antispam-prvs: <DM5PR11MB165788B1BDC7AAC871DE3564DAE79@DM5PR11MB1657.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxFx8nSt1vF+e6IZ+8QzjSnwI4jHtHLqNux6+eGRjU5aFB1OooWsLyRBS9CRq0d0wV1dwaCNUywsOdHGB8hROJvJPGmknrzUCEUNPNqleGD6yzfPcYSzQ3hsy7N6vRJbwVST3Ou08k4fU1EhEzkxGviMmFZXuq8VclI9UWH+tA0oEFfER8iuciiPx5FGBYPBvST7XYwvy2P5d93rSFY1V6yS1ckc7E/q7BbO/I4s7fXKaUUlKO1QAO9sZmE+a1cICBavJTcS0WeQZ/HfMsxv2phs6XvwfnM/UCxg3ohdrFu/3giiS4fIDd0KU+EmUlT0hPWDOc2V/hQBqdtE+iWNvyORHcD72y8ETIEIDHQDeaovIvYZLMMGqhT6b2x9823o93WsoYZPobD85efAZv0VAXu3uDdw2OVwTe3Dho22nWoRuy2m4EaQATxM+V49hkTejLa3SafpaNoQ8NbPtFYNLVsDfZT30BnrCi0QLbNNUP3NR4s8DxOlwK4gFyLcy1b03Oi96iMHQbOood8iDbfq4nwny5Z9xTsBttx1kwP6jZ8cPwIkC3DtENwaNUPiu7xopy1BT7+A7be8gHqeLfvV4eI9lI6v6M5xrGWiAG8vlNrxt3MlIAipKXwJBuRGzqrY2x4pyNB/RbMAwK8fYqXnPoH1CiEcclSIoaarwEiW8gQo3K5/G4LdTnK7lHGfncXT+mIxP7j/Y5Oevy0PGPSqKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66574015)(6506007)(52536014)(26005)(186003)(508600001)(33656002)(86362001)(2906002)(7696005)(66946007)(5660300002)(4326008)(66556008)(66446008)(66476007)(83380400001)(64756008)(76116006)(316002)(122000001)(82960400001)(38100700002)(71200400001)(9686003)(55016003)(54906003)(8936002)(38070700005)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NhEIP9IgXGQwEmHJWFVaN2idkNkJzgmwa3O15zvLOT16P40hYkr1ncPGWFIM?=
 =?us-ascii?Q?bfhVPlpXdkuPTqhFGti0i7xIFYmPNtyIiWQOj5F1Y4hXxCr0ibT6yuCKLxA4?=
 =?us-ascii?Q?gJUMsSExPKtwMMgvdKzq7GynZ8K4NeSvWrGvlALFo5rxyTlO1ADPjx4fvgeW?=
 =?us-ascii?Q?553+WHzlGlXK+P4P0fN+34C13Kje6i/cdUAJwEVrA36yRmSJ9OxQnRXLrxhL?=
 =?us-ascii?Q?dLdipOhg/1fh1XwIwuBky9DoLUKjhEvZInXAGUDPb2A0dfJbQVCmvIPuFZ0i?=
 =?us-ascii?Q?FZVQXbwQy8ARNGAModoOreMbBLm+gPKRMvIJ4gaYseCrUOD7W+tkbFky5rch?=
 =?us-ascii?Q?PGgiquhl3iZ2ip0b2zdniP8QdgKTdeqNhxZ3tvRIfZ9mMnTV5yDCBUt8dgoL?=
 =?us-ascii?Q?FbQapXH31G9Xka87yauFxVS1NHxfM2ms6liRM1ArdPp/zEbvfKfZgWxFy0XW?=
 =?us-ascii?Q?WlY0JeiXgo4M3NDin7zghrYQ9ZXgjKXNoTUJBdmUT5M7/x1EOt/gOMTY40rf?=
 =?us-ascii?Q?06iBrbeUqJRaV6V1bgp+LOZIvXs1xhEcuAYMZmrd75G3zmhzPUZewvLz4+mM?=
 =?us-ascii?Q?IVSEYVspAdZ8ePBwf+21t03saVUrIjjzGuHXvynccom0KGLpyKWVdhMsf84v?=
 =?us-ascii?Q?6NYLbeQRy3oDKtp3q+28kHEVp8sqwmrxXTxbYMHjA4bqThQwPQhC+Wr1rS9B?=
 =?us-ascii?Q?Wwx5PqH/2q94X7NgJZh9nZEqiP/NRR7ZAMZ95y2pcq737poU3a7qZR47ZDgR?=
 =?us-ascii?Q?fTRflvl2YQ3VWvYdfWuk5+kufA2Qc9kuwJoQ6sObLLLyIC8LklYnKUXqtIK3?=
 =?us-ascii?Q?HSXzWZwYc13Y6dhs1AC78u31o104u3uiVr0tajm0uWlqi/7W0XCwt6NQXXtA?=
 =?us-ascii?Q?R18kuFVgm0cqHMj4MM4mcFi8nmYFWbZFy4s5RiVqBia1cP5CVN8mXUvyuy04?=
 =?us-ascii?Q?/QX0ivkrX5+QI1mxHqi49oZNfig+Dnc6S55itV1vGPNnU3oG8feHK2vB5Hmj?=
 =?us-ascii?Q?F7pP/m1WrmZyg1w7udNa+nN9bw70tHHzFGyzMGpiflx81jcpbHVgckHixMLg?=
 =?us-ascii?Q?QN1gf9dEcFf5B+8Q2oKnDRIsZy70FGLsTFdgRcwDrUfs2lLBmYJVrBQw14i2?=
 =?us-ascii?Q?ubnYRxJ78sm0RRrLPnBH/OReTHxtsi+Hn45Kt5WWEmXng5I4I+iFe8kE9v+n?=
 =?us-ascii?Q?N28Ktx55J7wZY3Ay651zO1n/YsgRaF6yjQmM+j5uFEnKwDkZ51p0d9yWzXKe?=
 =?us-ascii?Q?S22gFcGrQnhe6YLIALWjNn76II/R5tl09nn5gGbvA8ybqEOXTtjSpagrYyOJ?=
 =?us-ascii?Q?gjzaq2gbWeQxuC7Le4Ye30c8n4//MXVjDKdKlgtSVSI/EbmfGma/x0SLrJN4?=
 =?us-ascii?Q?1NVWfNp7cX0yK1Cyc2jHIFT2KIj2ocgCifon+CJvuootjojdgmul4rHfG8Kq?=
 =?us-ascii?Q?y4GUZPSpGCClqXnSA8S/e+YzYuSlAT8a5FRawRn2jFgdKOy3ldX1XkYbp57c?=
 =?us-ascii?Q?weCJ2zSocVSvMROiU3ey1XDXvboLAh594ursAzsRIXmGHxfWY+GHZcmZtQ4s?=
 =?us-ascii?Q?6ivrA6Qj1wMyP2GHtXGXKaBeAACH/N71rH8Gyipc/gSfJtVIXsS1kObku7BW?=
 =?us-ascii?Q?1giDJ/z3tKCFEWLfJiEfmeTGd3+8/3taCwVqsxzfnlm3/emhplGjIUmRjE/i?=
 =?us-ascii?Q?BuMu+G2Ta1HrUfbi/QIlu8wiawTYKQiuShCX98U8EQsWYoX+ptbvignDLV05?=
 =?us-ascii?Q?h3nhh1dD+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a7724f-dfe0-4ee2-6bec-08da1787c201
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 04:41:46.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9FsRgOPh0npzjCVfEbq3FwPqAt0rd6DvFgJVvGpgvRr01Hty8vXFJGtG6Ce80lCQeDjZ2I1eoGleqDfKl4UgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1657
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


On Sun, Apr 03, 2022 at 02:14:40PM +0800, Zqiang wrote:
> On non-PREEMPT_RT kernel, the init_irq_work() make the defer_qs_iw=20
> irq-work execute in interrupt context. however, on PREEMPT_RT kernel,=20
> the
> init_irq_work() make defer_qs_iq irq-work execute in rt-fifo irq_work=20
> kthreads. when system booting, and the CONFIG_RCU_STRICT_GRACE_PERIOD=20
> is enabled, there are a lot of defer_qs_iw irq-work to be processed in=20
> rt-fifo irq_work kthreads, it occupies boot CPU for long time and=20
> cause other kthread cannot get the boot CPU, the boot process occurs=20
> hang. use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw irq-work, can=20
> ensure the defer_qs_iw irq-work always execute in interrupt context,=20
> whether PREEMPT_RT or non PREEMPT_RT kernel.

This is a much better justification of the need for a change, thank you!

>But it looks like I need to clarify a sentence in my previous email.
>
>Please note that you were using the debugging RCU_STRICT_GRACE_PERIOD Kcon=
fig option, so this is a potential problem as opposed to an immediate bug. =
 Yes, we must fix bugs, but it is also very important to avoid harming othe=
r workloads, which are after all the vast majority of the uses of the Linux=
 kernel.
>
>And a major purpose of things like RCU_STRICT_GRACE_PERIOD is to give us a=
dvanced warning of bugs so that we can fix them properly, without hurting o=
ther workloads.
>
>So, does this patch guarantee exactly the same performance and scalability=
 as before for !PREEMPT_RT systems?  If so, please add an explanation to th=
e commit log.
>
>Otherwise, please adjust the code to provide this guarantee.

Thanks, I have been adjusted code and resend v2.

Thanks
Zqiang

>
>							Thanx, Paul

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index=20
> 3037c2536e1f..cf7bd28af8ef 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_struc=
t *t)
>  			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> +				rdp->defer_qs_iw =3D=20
> +IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
>  				rdp->defer_qs_iw_pending =3D true;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
> --
> 2.25.1
>=20
