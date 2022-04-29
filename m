Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C620514936
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359124AbiD2M2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359060AbiD2M2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:28:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E69C90CE;
        Fri, 29 Apr 2022 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651235082; x=1682771082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WBeNJbnk+nYPnNLAhN6BWtp9lz/+LOiHKZF1y2QLDTE=;
  b=Byzvsbcp5l+rRA9G8dFoz/+lsEilTGa3dwXfNHRm918v620pR2CMm+KO
   JkBI95p91gHvAyii7psCEaP2Re3VbTcaNfuYBU/DjSsZA+xFcCgRC1QDl
   MyEsVmgWrAx0PIrYhbykVSinu+M/tMFsfnvCmidZmLAFqZtv1kk1wJF03
   ptw5uIwlqWg0+IC8N81FnRKUuFNxzQR1V7ZGKF0RL4bvuK3hXHzuFtrg9
   57R1KSDEVgrXtiPjzrg3TEgZrBnsiMIvge6DNAHLWldjs0zrNtHNRWBkO
   jKxu1M7YWpCRORcexf1OwUIVVZGLyMv7BeyC3SIDf3TskUuMW1kY+Mj9o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="254014487"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="254014487"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="597301968"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2022 05:24:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 05:24:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 05:24:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 29 Apr 2022 05:24:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 29 Apr 2022 05:24:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsWYYX3MqnKg+DlSmsWUUI+npI76XVFAutaM7Be8IqdtXPaNPgvD8rPCaVZe1+W5Wc7FFjHvM6b7jH8SWg8tDmSa8Dlwopa5/i+uCJBh8Pmajk9xrTm0JnhZj9EE6l+sf+U0GQ9LE8mV/VMKVvSDR65CXfOsHzM21s4rIcIfr7NeGze34DOBHLCFbw0HoKbf5gaMwt/I5t4GXJEHZTP0WV2lzeCkTP9OKlC0EeeFmriCFX5MbnH2847qI30xChFVAjsHdf4aV1UWhNS2l1kK+66++ZjPnBvlRCn+OkfZYvs9CsbRp20Tsilk+gQbkW4daZt1X03dYFKOMC79hrHoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCeryRei3+VrpJJZn1IJhoSB38DemNb5lbGQdvC0Ca4=;
 b=GzHfty+n/WAslpduX+G6Y4blEqni+UVIbLEEUIfINu44cnh2AeDn/SXvkoYjmNd9L7n1sm+c8r83wck8xJNK6tzjbPaLn95p6fkmQvM5jzj9tPRrlnxAR0ESlPaOju00ovR6Za6SkemIvzxL0w/GnKq/R5UvnZ54HWb4f3ipFMNdjTnmTu8CWaiSZV1rOq9nvLk+LvGvkunN1pkeTJIir2h3GoJL5B24xnLVckrsehCEUstzfCBVlm8A8h1H3a15O9UVqx2ONtT8X+o2eCx8oZ4lYEfs41UPjB+nCTHo1/lzhLSnJsLsRSakyhixfZGei/SLP6YLw9arPV/zTLoClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5813.namprd11.prod.outlook.com (2603:10b6:a03:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 12:24:39 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%8]) with mapi id 15.20.5186.021; Fri, 29 Apr 2022
 12:24:39 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>
Subject: RE: [PATCH v2] rcu: Add nocb_cb_kthread check to
 rcu_is_callbacks_kthread()
Thread-Topic: [PATCH v2] rcu: Add nocb_cb_kthread check to
 rcu_is_callbacks_kthread()
Thread-Index: AQHYWTteAMSEHqddYEaNU2h/OC67jK0FioWAgAFGIhA=
Date:   Fri, 29 Apr 2022 12:24:39 +0000
Message-ID: <PH0PR11MB5880DBC7E302EFA3A552B6ABDAFC9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220426070031.3759998-1-qiang1.zhang@intel.com>
 <20220428163913.GI1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220428163913.GI1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 3262dd17-2a4b-4f86-e19b-08da29db3b3d
x-ms-traffictypediagnostic: SJ0PR11MB5813:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB5813284645DEA0DC59F20480DAFC9@SJ0PR11MB5813.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQSC31ssOyykd5KELTthnSFstTvNbBtfnByb5QYbstv6Y3NKiSUTq1gy6NgIdYxMynocYPJWo4Z5lhu2k71Nc04N3b8od2jvnBD5rAV7H3Pck1nuUSXRQHd2TudcxCwU3vXo8Gj61F79lMX3cYTyrlckbIg2koSzVta5UfpI9U8mocMIzh9wgeVJM3ogw6QpC77/IxniUQHcrjMBJwCcY5JoI+NYxZ7i9wIxtv/fYl2pqjJ6HL9oNzgyLF6fqLxuEC+6zTqgG14SeDsyz4oKnJ+Geot6RvO0JlyK2RYgP3uwnLmrGNUThN5vk9TttprKU20/c6k1UhVTSQB1EyURwdYLIkI4hpp6bBhdhX2Sm/UJCmwkX6ZkK2RDvBi1VoogQ82/KAi3IP/RTxY7k2HXBbbPRnKyENW3Fz56l2XWGEo4tuikdXuBTPT7bk4bV6JDRp/B2uemFYEG+VHQJZ7oSBs4zvp9GGuQN3Z+JGNef0XUmHQvHgvpiJbHKdYWKxIpUl3qIIy9pcg22ntvwt4ZShWRbGVm+KqVzu+heQ3dUSBNjHnjFWbSSFQwIicwoqd35ZTSli1Fw8px6tbhR5DpxeqJ+GXu3DRBUr6SWiXVF24cTBS5mHFjrUKUQOTLCjKj7VgtDKU0RpCtMd41MNp8mnIJ3NyvpY/6iEYNYPrbFxDTcmTWp21Iw0MhE6hpNAVjdu2LfXy7nOvFfFfvrqeLVUvFvIv+Tx0pjE1zyeWyWOs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(86362001)(54906003)(33656002)(76116006)(52536014)(66574015)(71200400001)(8936002)(508600001)(2906002)(107886003)(55016003)(82960400001)(83380400001)(8676002)(186003)(5660300002)(4326008)(66946007)(64756008)(66556008)(66476007)(66446008)(6506007)(26005)(7696005)(316002)(9686003)(6916009)(38070700005)(38100700002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CCMyWDM/8729skj7k16frg6QxaiWZmTKm/epdE8hxGff4YUh0FTiemTHegyM?=
 =?us-ascii?Q?oIFzsIXeR3Ccb+1iEgI4kaOP4d/OdiYzG8OU3Q/6+RwdWUBW/ZT9xKMvNmtu?=
 =?us-ascii?Q?DoTXqczZ12rX+wfeoftHrAvC8jvdzCZCmaazw0jVMd6w1qQZ7atHe7lqSHZn?=
 =?us-ascii?Q?Kr85YgracAWxLAFNTx5qM3wP9jvGNeonHFxZ//wAYBjY87QxtcEQBA3qV1q8?=
 =?us-ascii?Q?QzhZciMEFiQmALuiPPu5Efv515P5A5M+iqNCtdmfWRY1jDh0s2RTYU8Uk6Eg?=
 =?us-ascii?Q?zWxqrzivJcO6yLqiyQXGEyYoxz33K+vJ7+uWExPbv0zvc3xtD2FvwZha4Sk1?=
 =?us-ascii?Q?366+6pxaAhkjTn7JOc1CavCu02Ea8JetYyiq/NHtoaIVMEEsOo+/CcfNUO5i?=
 =?us-ascii?Q?RcdfEyd5pV9Jq6OLuZ3qgmrM2UOS7NABZCK0u96QPErF1xggCl0ftipHVUGB?=
 =?us-ascii?Q?wBaEvPO5q7uOJnQqy0JJN7qcXkhlcCwmx4xdPf1HLkMsD5ir31IprH7Gea27?=
 =?us-ascii?Q?e0cVCKKmzKfIDee50pWw5NZu1/7jZXne63sailChvDrhuE9eQkmxGbJOm7i+?=
 =?us-ascii?Q?bQXFoV0dlknBMFYlCyKMhj2T5EsgNV39q2csymCkei7Fdw3z8kAP2rNTkdUP?=
 =?us-ascii?Q?KAKkmr1F2Vsiq1eHbPdEzQGrW3LYvoEDdU830G0jPxgG1ot2h5sYhBQfgbVr?=
 =?us-ascii?Q?dQ0iqek6dJuXx67AFpaZOmUrrSImaHDBwiHq05fJwbiS7w+lEPG6Au5FzYx7?=
 =?us-ascii?Q?Rhy06eY/Y8DTy4akDQfHvieTglH73tQd/HOObNoP10UXLjwHo62Iup8Pnk7O?=
 =?us-ascii?Q?pLY7m1KJ8vmUc+qHwJ5NJlsh49YuNVqKzDci8fEnoYKInVFOLJQBU9IKRGdW?=
 =?us-ascii?Q?VX3wEhtta1f3aDSbJ13UHa/M0NB56h4Y8pgVTlJ2aLxV3gC1dbcxoZpEZSM6?=
 =?us-ascii?Q?QQR214zu6I2Xic5ZSXvvvVbjB0kfiMTmgv8z6IWcTRb9nTS6PALxvV9P7lGT?=
 =?us-ascii?Q?QiRprSKAKjppbrjM9DqUeVH1DPHTUbHkR/QCuoZUjD+Yygj+Aodz6h9GpihR?=
 =?us-ascii?Q?4XupxZiv6ydWJa3ra99dUO4/cCZp7Icuf5DaOvdpSHtYODzLD1X83iztKMi+?=
 =?us-ascii?Q?mMVeIlOMte2gUFwzOb93VANiVEf7geNg5aTTceJL5b8l41mhzeCcD2COhpoN?=
 =?us-ascii?Q?0vy2/5m6wPXF2zczr7rhzXlNvcB2XY8oW5G0T947s1oFFzDOdvRmkK8kMJ3y?=
 =?us-ascii?Q?5inn8MpSWUkgj5KNBqBDXpwfkcUhRM+mtLNrahiKHhLHvagccOm/iqfg/GJn?=
 =?us-ascii?Q?fxwJhWBxUzAzkx5nrXrfLBBO5a8QEkyKJrWiO1yD/spXHPR50Od1oHsgkTKG?=
 =?us-ascii?Q?n2/w9hGFp7fVwszMBb8gaN33uH8286bpJ+cIZEEhbpdJC0KIYkLDcWYctUho?=
 =?us-ascii?Q?LIiUnWDVtEpXKZbdZfprMMTTArwafprNINhPGgtZm/gD2FMrF2KMSKF5S6cz?=
 =?us-ascii?Q?zo94YKy/fuAgOY5lPHzTca9/ysRKXnsfE/H7fi9b2iLZLiLukPALbAVI79kZ?=
 =?us-ascii?Q?n9L/vRnFBBeZrxLcB9DjZiGbZfVRTqelB1ZpOcqRr/hghEXE9RwkLoLbS6M3?=
 =?us-ascii?Q?YsJYej+TsZUyS4720PxKDD187Q94wV0kANZwTT9xNVwLv+08OQ3+/9bvsomL?=
 =?us-ascii?Q?I36rgN1yaiiBeqA+LVAwQPvF7YPfO+TebqF7Pl/7lCN5SnpQVg0q3/5NeufB?=
 =?us-ascii?Q?cIhMQS6M1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3262dd17-2a4b-4f86-e19b-08da29db3b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 12:24:39.4521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwMWKbkqJzlJ7+brq4hEufQ6xFV5CQS/wbDLV+WatYEcIFiX3QSUewfvRq5kTvFvD6Rnj3lzM2oSDEFSmjLjzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:00:31PM +0800, Zqiang wrote:
> At present, there are two situations which the rcu callback function=20
> be exectued in the kthreads, one is if the use_softirq is set to zero,=20
> the RCU_SOFTIRQ processing is carried out by the per-CPU rcuc=20
> kthreads, for non-offload rdp, the rdp's rcu callback function be=20
> exectued in rcuc kthreads. another one is if the rdp is set to=20
> offloaded, the rdp's rcu callback function be exectued in the rcuop kthre=
ads.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

>Good catch!
>
>From what I can see, this affects only tracing.  Or did I miss a use case?

Yes it is affects tracing, it was add make tracing info more accurate.

>
>Also, should the two definitions of rcu_is_callbacks_kthread() be merged?
>It looks like the current situation dates back to when the only time rcuc =
kthreads were created was in kernels built with CONFIG_RCU_BOOST=3Dy.
>If so, the definition of this function should move from tree_plugin.h to t=
ree.c.

Yes it should not depend on CONFIG_RCU_BOOST option.

>
>							Thanx, Paul

> ---
>  v1->v2:
>  fix compilation error when CONFIG_RCU_NOCB_CPU is no define
>=20
>  kernel/rcu/tree.c        |  4 ++--
>  kernel/rcu/tree.h        |  2 +-
>  kernel/rcu/tree_plugin.h | 12 +++++++++---
>  3 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index=20
> 5c587e00811c..9dc4c4e82db6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2610,7 +2610,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  		trace_rcu_batch_end(rcu_state.name, 0,
>  				    !rcu_segcblist_empty(&rdp->cblist),
>  				    need_resched(), is_idle_task(current),
> -				    rcu_is_callbacks_kthread());
> +				    rcu_is_callbacks_kthread(rdp));
>  		return;
>  	}
> =20
> @@ -2688,7 +2688,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	rcu_nocb_lock_irqsave(rdp, flags);
>  	rdp->n_cbs_invoked +=3D count;
>  	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
> -			    is_idle_task(current), rcu_is_callbacks_kthread());
> +			    is_idle_task(current), rcu_is_callbacks_kthread(rdp));
> =20
>  	/* Update counts and requeue any remaining callbacks. */
>  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl); diff --git=20
> a/kernel/rcu/tree.h b/kernel/rcu/tree.h index=20
> 996387962de3..3cdc18997a38 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -433,7 +433,7 @@ static void rcu_flavor_sched_clock_irq(int user); =20
> static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);  static=20
> void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags); =20
> static void rcu_preempt_boost_start_gp(struct rcu_node *rnp); -static=20
> bool rcu_is_callbacks_kthread(void);
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
>  static void rcu_cpu_kthread_setup(unsigned int cpu);  static void=20
> rcu_spawn_one_boost_kthread(struct rcu_node *rnp);  static bool=20
> rcu_preempt_has_tasks(struct rcu_node *rnp); diff --git=20
> a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index=20
> 971bb6a00ede..120bade40e02 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1155,9 +1155,15 @@ static void rcu_initiate_boost(struct rcu_node *rn=
p, unsigned long flags)
>   * Is the current CPU running the RCU-callbacks kthread?
>   * Caller must have preemption disabled.
>   */
> -static bool rcu_is_callbacks_kthread(void)
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
>  {
> -	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) =3D=3D current;
> +	bool ret;
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	ret =3D rdp->rcu_cpu_kthread_task =3D=3D current || rdp->nocb_cb_kthrea=
d=20
> +=3D=3D current; #else
> +	ret =3D rdp->rcu_cpu_kthread_task =3D=3D current; #endif
>
>The problem here is that the first part of that condition is duplicated.
>This is an accident waiting to happen when someone fixes one side of that =
#ifdef without also adjusting the other side.  One approach is to define a =
function that tests "nocb_cb_kthread =3D=3D current" in CONFIG_RCU_NOCB_CPU=
=3Dy kernels and just returns "false" otherwise.

Thanks for your suggestion, I will resend.

>
>Alternatively, you could make ->nocb_cb_kthread defined unconditionally, b=
ut left always NULL in CONFIG_RCU_NOCB_CPU=3Dn kernels.

> +	return ret;
>  }
> =20
>  #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY *=20
> HZ, 1000) @@ -1242,7 +1248,7 @@ static void rcu_initiate_boost(struct rcu=
_node *rnp, unsigned long flags)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);  }
> =20
> -static bool rcu_is_callbacks_kthread(void)
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
>  {
>  	return false;
>  }
> --
> 2.25.1
>=20
