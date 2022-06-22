Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7803C556F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377541AbiFVXed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377263AbiFVXeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:34:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89D12F3A6;
        Wed, 22 Jun 2022 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655940859; x=1687476859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i/oasiHhr1iwu9NHuWQvndpj2AuvBcSIFQhEP53zqd8=;
  b=fkp2pE/COUvnFnqkz+YoXukfDjRRfWZmLj02tUomBMRS4Xbw59Gg649b
   Q4wgi/O6aNKYBAYBFLg8VbTOgBBv4ABcOvTrAqBqvulXO7AI87SIrzgma
   qDh4oP+g1/QxImGq2j4snf8jG9gobJE3IsUoAKOIEClVSQ46Um/0pquH5
   fuLYaAfgv30DWPeosEqUPpGCKX3AwNewr+r9P2SyJv+apxN5Bvj8qzx5J
   hV3qAChNhnXzWajbU4yL+F125paKP5EYdYuXuG6dNgaG5jCNV7UJw2bYL
   bg8ZYhR4+EVGtBvFedg/GFVNAfERwx2LQoZIt0UUVGm7a+mWl3d90AtsL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344562901"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="344562901"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 16:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="715609486"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 16:34:19 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 16:34:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 16:34:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 16:34:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 16:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdNwpz+KbVSEIlaZ0sITOpf9Bf57Hqp9SQTY50K10Zr9UUM3P57qkCpVS22DzwCc6Ju/onre6zHWFh091Nq6NbTCcRX4U9RsbMSp4fE0JhiUP9+hGTKJqUHV3tjoLV/odGVcjlw/L8ZX6YPqwNjHmXr0YAKxhLKSqArp9KVL12QGXnKHUYHNDqMd7YYRqoJLz6gbD8DfOdsUQ14J9bbEPh6VkmtrC6pSZdjVz3OUXFBfdcQzCzSMdIVcqdVTrkMEk3XIlULqf88CaQX0ZSWiAVEtiL7l10ijoOOI1M3XDBGF1Qi0UIn3aK6lVxWuz9QsdDnHIjkL+S0HYJQsHmAVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7FJaeh/+dmXa6r3SNEGOK8w52AbxxDrQDV9r+19oy0=;
 b=JMhschQ5XQ26W4HIplfnujShOpZlNrEqfgPqZrmcB0NnAqWBBuAZxo4zwraS0dxP7eS++gvmzGdBGliRWtGxEp6L3J4TkI4W7W//LNkyL6w/6jIPFcqzY+W8d7XjUlf036+HEygJfctkVhOoDG9VJvcl3ln7Ie30N4V0asGYpz3ADxT7G0dKhG6fKmdiugI2379hHzK4Q9GQOHuIbEflROPELmLiiw33Fjxlinz9nxQ9Sqpm1W2qj5+H+3RzQF6bwWwuxQ4n1VcggxlJ3lUwWb+l9ewD6hKxcuOyvkNmX1U2qZe/jDEsnYY7jmKuDV0jWJTExN1PV2hE9Su9qzj/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL1PR11MB5400.namprd11.prod.outlook.com (2603:10b6:208:311::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 23:34:16 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%5]) with mapi id 15.20.5353.015; Wed, 22 Jun 2022
 23:34:16 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Thread-Topic: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Thread-Index: AQHYhiPvaZaZmWFjQEu0NBJYl75Ct61brf6AgABcGPA=
Date:   Wed, 22 Jun 2022 23:34:15 +0000
Message-ID: <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
 <YrNQpxjIiNpxwyQh@boqun-archlinux>
In-Reply-To: <YrNQpxjIiNpxwyQh@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2393baa1-39d8-4f37-3248-08da54a7b8a2
x-ms-traffictypediagnostic: BL1PR11MB5400:EE_
x-microsoft-antispam-prvs: <BL1PR11MB540050C8537E19C8CB41A268DAB29@BL1PR11MB5400.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WN6DwJgKgU61axndV6JwOhoAgxZClCM0O7D3dI3ErccYXDvOL4/kVPDNrXBcScHpsorZR6xcpJB6NdKmcSBZnm/qcelUXtn8TII52F3uDtWFzXBro2pMClA0qzbz7nBrzF3HBFZOxBlO4xu4xS/FhQdGtPdslrXWZYam4c3QXhc+U/Mo/zF3NQJAVxYJoqoqZcJ9Z5wiTcTB+GF6gEnKFStLOJXiN6j6A+a80LOr0s6u7ywN7PWV7+TD262QSDi05C7bJhZPWqj72BGB+LfNdrk/TcPMCQFL7oXj0Kp5k+vfPf3ZL7mIvcpQCcEOB2EMXXyKY+EZIvBePi1kQMUFIfBiwJX2JO3RXauI1BVxXrXShRhpFLdsthqEfYmNCzBbL9pkXNKz+l/yjXsWz5j6nymLt3O0U59skYV0CL+26JkQBF9pgdoyNr3RO6/oZndDJgDgGr0sUpoUQLIoul+1edRhGMNUKe9Gp6hCqgNv/A+PAw3cOoipzlz4n8sVsKMFRQyRfNdFbSi6q6uL83s3yWgKRsy/TnvZSyuTyGQLPp7ePgx9mN6P0kWg/yQh7tUVUbMSpqebG2C1xlMqDAuF2T9uZMiQTnUn/Yjd3/ztDuufZdLPRiVEFNIm3ytCLVlIC0/8t69DEfIvYsRCx8///jsAi5q/yb3PO5QHWKkpoMLCxDc4ACpKpCaauxA7jzhFLv/GlVtPZZ8IxP23nzR15SKWXmf2Ae7B4YBx+ihXKuhCej/e9SY3TKPz3Vd/ErzQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(136003)(346002)(376002)(5660300002)(66446008)(64756008)(66946007)(66476007)(66556008)(4326008)(8676002)(122000001)(76116006)(8936002)(2906002)(82960400001)(52536014)(71200400001)(6506007)(33656002)(478600001)(186003)(54906003)(38100700002)(110136005)(316002)(83380400001)(38070700005)(86362001)(55016003)(9686003)(26005)(7696005)(41300700001)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nctIwDtehNqKEDisR89JijRueenapFMny37Wy7eOs5sX2Dyr9vz96zS0F1+/?=
 =?us-ascii?Q?FgfedQ+l4ePD/0Z92AGTiL89N7ZCU2e1mfnWD0SSPT6HLgRxnLvsvzLlbDcS?=
 =?us-ascii?Q?qeUyCIrbdz/pEe9LqWYtA9ERjT8B0R5C+HT5OShsc2opmSOPDOl6pNugCSi8?=
 =?us-ascii?Q?n3WmK4c0ce9tgGqYwiRDnETnlisf0PKBRAnwM8vPetlGpfdW5hCTlzWAngiS?=
 =?us-ascii?Q?I80etXjx13na85nvTIU0TIIYOFfHoh3D/g2uf7PCSXeKLBtIBUox+9XImrAt?=
 =?us-ascii?Q?YTQOnTv4UmP9LdF7+00ZO0VDh/AP6/gPcbvAixWhIPSKUr1Tz0Xqp+Orh3M6?=
 =?us-ascii?Q?h1PtIilHJumoAMH7It8EPgMqupDyslIK2n5LzfEulaLgWw89WjnlBqev6gRX?=
 =?us-ascii?Q?M9IsPsek/Do7pwo9Ig1S6sTeyb6J1+gO4ErSJ5cjD0GFPvo7ROysz8q5UJe8?=
 =?us-ascii?Q?FJYhf2HH8ZtnXYe0IV7+yydwe6dft+P7L95rihb3ZbTfI5bF1qJclT99DzdW?=
 =?us-ascii?Q?gDUiIgZAwckBL0a9UTUo05OYDg+ewEqMW/a0d+cK8jlcazDzox6IzCAOMw42?=
 =?us-ascii?Q?5EZlML+ul+iGmeZoLSwjMVVvl33oO/q9+KHURzRPF5WusH0P9jSgOmPR9yPE?=
 =?us-ascii?Q?Ckx721yuQFMCcGGzlGzGU9tH6dhZll/ECBwp8ZWEiS4QI+dVvJyM8ScfVBye?=
 =?us-ascii?Q?ORXcFW8IdJqZ3tAi6HLNwOHiovJrO5vTiyJW2bVdz34M65FkzjpBEInQ1LW2?=
 =?us-ascii?Q?1bam8G1663xaBOqXesdOYftaR2P2M6rEXiVsrEzT/4iFS8VUPC1imASBgve9?=
 =?us-ascii?Q?YeCCTD7DpTyAPC6r9oyLurB741cgvQVYiWDH8+AhXMEboIuUCgw09Kc68LHC?=
 =?us-ascii?Q?0W/5vsLd87gLQZMoSf2Yp9AbK9ORx1+bSi8rIoJQvSKIJxA2ds2pHrM3TuvY?=
 =?us-ascii?Q?yENSya3JjiUTaL1qC2YF6U35yA65EX3bvfyoLvA4MprMlMb6kXbxGFtSY3ve?=
 =?us-ascii?Q?JhU3wgKuWP7ICGIj/DNkYCb5If0PvttuZ09KmqpM7TNbFlX1NyXtkbn9QA4G?=
 =?us-ascii?Q?HJKJvxSt6lAXTRTK0YzAoLBXqdEStK9yFQkgEUFZk86vRZWMNa7AXX47iw5a?=
 =?us-ascii?Q?RHAfgktutI4bTC0r8ng2YSyUrD8WwrDKtw+uK0bCynNcGNMyXc0BzO71zXxP?=
 =?us-ascii?Q?sVtCW/M2dX9tDqG4yeH4PWpThQ0/flbSqB0wcZc9LEivVlGjVaYNI2EfikaI?=
 =?us-ascii?Q?1s4YtTH8rXG8xZs1SpD0cSXY9R9A3P4ErlXeGWI9+BA6mQND69ApkPQeWXpo?=
 =?us-ascii?Q?XOykZUxVr/YqIt9mfxE8M+5BtBce8xdmuEaVApVdBi+XR8CT+rck6bEKBINH?=
 =?us-ascii?Q?AHyhgTaTs43CnTTsxaMnzDDonAROG0DSJ7uKVl01TQdRrTj9u3UpLsNMmnfN?=
 =?us-ascii?Q?6X0lCYRS55mcnc/BbtvNkwzygb6Hbvk/sMg6yKFJnQ3/pvhPk0TPOXJ+gYWp?=
 =?us-ascii?Q?gBgLkEl9OesfQjuEYWslO4TUI2jtFLR+W1ASAVJN5G4SVsyGWN7aovEAu3zN?=
 =?us-ascii?Q?Cu7ZuBCm/KBQFNHDac2LH7GgtC3sIvVStmqNhRbhm+vVaFxhd/HRM11LCeTZ?=
 =?us-ascii?Q?1sP6qcCv8XVv6ebCZyGfOS2toIm5YZ1sTy9b9kn496xVaU5QL2sxvaJHDNTT?=
 =?us-ascii?Q?1YL4TdfDyMehcLhsCK9Fh54lk8tse82dcYkVxWRSrSAXE5iolMG2xfCO8ffB?=
 =?us-ascii?Q?R2Y5LzXyTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2393baa1-39d8-4f37-3248-08da54a7b8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 23:34:15.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pajCUJvrQAe/ZOSkbaVoFpXhDHj6tX9Q4VRN2V+Anz2Z1ZWK6om+n+SMsTtpKvkgnUlFTvu/d2rlfg9/+LG9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> In CONFIG_PREEMPT=3Dn and CONFIG_PREEMPT_COUNT=3Dy kernel, after a exp
> grace period begins, if detected current CPU enters idle in
> rcu_exp_handler() IPI handler, will immediately report the exp QS of the
> current cpu, at this time, maybe not being in an RCU read-side critical
> section, but need wait until rcu-softirq or sched-clock irq or sched-swit=
ch
> occurs on current CPU to check and report exp QS.
>=20

>I think the idea is OK, however, this "optimization" is based on the
>implementation detail that rcu_read_lock() counts preempt_count when
>CONFIG_PREEMPT_COUNT=3Dy, right? It's a little bit dangerous because the
>preempt_count when CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn is most=
ly
>for debugging purposes IIUC, and in other words, _it could be gone_.
>

Yes, for CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn kernel
The rcu_read_lock/unlock are replaced by preempt_disbale/enable, and the=20
preempt-count is exists,  so can report exp QS when not being an  RCU=20
read-side critical(preempt_count & (PREEMPT_MASK | SOFTIRQ_MASK )return zer=
o).
in IPI handler.=20

For CONFIG_PREEMPT_COUNT=3Dn and CONFIG_PREEMPT=3Dn kernel,=20
The rcu_read_lock/unlock is just barrier().=20


So I add IS_ENABLED(CONFIG_PREEMPT_COUNT) check in code.

Of course, for CONFIG_PREEMPT_COUNT=3Dn  kernel, in RCU softirq, the=20
preempt-count is also checked

/* Report any deferred quiescent states if preemption enabled. */
 if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK)=
)) {
                 rcu_preempt_deferred_qs(current);

but the RCU softirq may not be triggered in time and reported exp QS, for
example a kernel loop exist on NO_HZ_FULL CPU

this change, It is to capture the exp QS state earlier and report it.


>Also I'm not aware of any but there could be someone assuming that RCU
>read-side critical sections can be formed without
>rcu_read_{lock,unlock}() in CONFIG_PREEMPT=3Dn kernel. For example, there
>might be "creative" code like the following:
>
>	void do_something_only_in_nonpreempt(void)
>	{
>		int *p;
>
>		// This function only gets called in PREEMPT=3Dn kernel,
>		// which means everywhere is a RCU read-side critical
>		// section, let's save some lines of code.
>
		rcu_read_lock();
>		p =3D rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
>		... // of course no schedule() here.
>		<access p>
                             rcu_read_unlock();
>	}
>

Usually access to pointers of type rcu needs to be protected.

Any thoughts?

>Again, I'm not aware of any existing code that does this but we need to
>be sure.
>
>Regards,
>Boqun
>
> This commit add a exp QS check in rcu_exp_handler(), when not being
> in an RCU read-side critical section, report exp QS earlier.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_exp.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index be667583a554..34f08267410f 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
>  {
>  	struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp =3D rdp->mynode;
> +	bool preempt_bh_disabled =3D
> +				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> =20
>  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
>  	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
>  		return;
> -	if (rcu_is_cpu_rrupt_from_idle()) {
> +	if (rcu_is_cpu_rrupt_from_idle() ||
> +			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {
>  		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
>  		return;
>  	}
> --=20
> 2.25.1
>=20
