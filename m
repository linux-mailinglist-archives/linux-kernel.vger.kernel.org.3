Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53BA533F69
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiEYOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiEYOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:43:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9003914B;
        Wed, 25 May 2022 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653489780; x=1685025780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CokPhFII2x83bfyjbLYMFZEQah4Xq5lbOQESoDzlkdA=;
  b=Ji/PRFeJ/B6ioMAFjtn4y8fFEL1KIaN2nGvTjP2itfdpVSFSMMe9vZ+Z
   4MhzuRaBJ6HFeDm8AnBtZzTGE90XBFXWvTJAdQJmTTu4CY1ivdbxlfMaI
   Uq98OHlm3N1YhTR13vjohJW7CbjUonFrAGVfGGoRqKrlF5XHLiu6kWVV3
   FXRY5Io3ZdAOQlDOrslpcMGsN9TMzBbb0zBr41fiI/oPdpB88AR6og4mB
   Wiyw8lHrhqX6U2LZXlHUf4TWvM1fyNA91bsouTRKcxsTX2T+9Hn2CAvAr
   3HE2llefhxwohuYuBwhCNjo0zzE+1dszmWdJ4AXlPHduNXitm2e7Yp3Lv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="273556237"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273556237"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 07:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="676891547"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2022 07:42:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 07:42:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 25 May 2022 07:42:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 25 May 2022 07:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy4pNY8i5AB6bIjYz7C382ckNfml+lTsSyKuB0qKOk/MndLagphZwijv2FAv2ltyLJT6FJct/wudqYlqrw9XHMs8NQMyY5jZJyUlkdXd3gZ4Dp81aVdJwEsfrw0T+F1mGYp6Z0El5nkEjRIG/yK3n7bw2jMXJMCxn4c2ppBBDn5ey0xLGAJ3068nR5MHegUJbqzdZt03TYIkJMvHtE2WurmUns/+SL2crR0XRWPgkvB9ERLMMhFgxZV1RwQISrR65lZO2i98PX1u+5iNWGGSIH2ndsU1U1LZJR9qCg9jGp16VewmlVVhU4f7UoVBtJe4R/14dMo77u08UXzNJKAsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjnrC4eNtNW/CFlfPHLpt6Lrk45gTPetutGAbSUFtmw=;
 b=f9uDChmRHgf+xm8ALvFo3QhnPzL9nqnfGrbQLVSgZONsgpzWK9sHdHa4+Up2R36jD3k/KixL7YOxugn3o1atbxu8b/JIeFXYt6kwtgmdW6K5rJdFz3rGuZ4DgpR6avJNl+3RtgoFp4/mV+kyR1oKkT3Pb8oRO70hg5pgPBI0Q5YqAzT2jnDTVBOrEzNlL3sJrSjpbqgHbVRyxOS8E9g3VmJhlsA0REkGyNJD7Q/13m9EfS4NzQWNYiNMYINJ+NcEscon4sJVwZls28ND9snuQZ3ZvU+FhMDYFR6898xnY8Je8PCvBgYPTIqJDgV3jJDL/p1ZUszTHAG0d41Or5Tbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 14:42:41 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%8]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 14:42:41 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add rnp->expmask output to show_rcu_gp_kthreads()
Thread-Topic: [PATCH] rcu: Add rnp->expmask output to show_rcu_gp_kthreads()
Thread-Index: AQHYb/JC2wviYb3eD0WoVIBYSpjWx60vCIGAgACYBACAAAnG8A==
Date:   Wed, 25 May 2022 14:42:41 +0000
Message-ID: <PH0PR11MB5880148BDBE32C355D63EC88DAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220525044503.2083630-1-qiang1.zhang@intel.com>
 <e531081f-4871-5292-6a31-782fa7228788@quicinc.com>
 <20220525140328.GV1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220525140328.GV1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 34292e5e-651e-41b8-698c-08da3e5cd279
x-ms-traffictypediagnostic: CO1PR11MB5042:EE_
x-microsoft-antispam-prvs: <CO1PR11MB50429429DDC3DAC3BE5678EADAD69@CO1PR11MB5042.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVctajOi9IazZMqvJXyd89NigJPGW2RQysssSTNwzmZ/Vj55/QSbbMC36D0yc5cNxezz9+iqFt6zb1cdt2M80ZY1BmnImwlaVj5cZHL7h5x6jAGNdD0nOLnqF6DX6f6Bh6QHNWO2iwpeg8UZds87q4FatMLPducDjRKdLPLZpnFwnHDL9Z5qJGUuHL31j7Q78myD6NbKqIRZKVy/CUFAPuwNUO0C1H6Z/KlVwkJJrEbc7vPqgzDyHz5PO/x0BqoUnre2aZmlP8r0d4JNrb9+MxltW2t6dYw2e94p8KmlDm2JHfQCM+0pRjAGTb+p+BzEBTpxsgP3hNvN661EGgMXitvIopahYNrDEABj8QQJiTVZWT2INH6ewMQnfDKAvYO+8T9op/IIYmqBeSu4oqaXYTxd91FxwFJELDxnOwUzO3mhR5JgM2qcEEE/hDXFPCs2hhvo4QZU2WWrWo6sRuIlmrJLWKYl1H4KO5gcUkw0rZdtLU7dlZV2CVLr+GBrV1M8Ye/d3kiswZ5kOnwiqh4Ae1IG0f4bVo983ZKpXmJR9Iq83o/61TpGmZbxxFDe3JAAmkrOvGItSg6E2jpx6en0LjAGP16MVzFU3+DuVGsuIUHw5sT3o5OEX/6gvHF2sFmnFIwiTgdaRZm5eFD/Ro97UHHDVtQvDXbUqTY5xf2ySPEph72bEtoaGH31QbFqTObq9ETa2PMPrn4sl9ZS/VXo6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(53546011)(26005)(83380400001)(9686003)(316002)(54906003)(33656002)(66446008)(66476007)(110136005)(52536014)(66556008)(76116006)(8676002)(64756008)(4326008)(186003)(66946007)(86362001)(82960400001)(71200400001)(122000001)(2906002)(38070700005)(38100700002)(7696005)(8936002)(6506007)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8xkVyAsxT98xpci6n9eHoK9CINuOupTpp/r6+jdRDio4CdtD5s+RGxViN80w?=
 =?us-ascii?Q?H1N4ThD+Ydn17fxsOLkdOi91uaWOXcWFFrxZHkxV1fKVgP/Dhr5Amqvjw1xz?=
 =?us-ascii?Q?i7Nq3rxlLS/P5Sfi+ui3g7MxWzCRazszED309JTf6iRMUpaE8loe2zeB/iXb?=
 =?us-ascii?Q?A7XE6BkyVq1auP6f6YMdnEqPQPp8TXWyAsc1qEIlzhBBdtebnNhr1/yH3T7g?=
 =?us-ascii?Q?iAcwH4rb3/NedQe4vknCzV1beMnHwyN/05XzBxQDqlLXZQpRuGkjiTghSpW4?=
 =?us-ascii?Q?mlOrO131FG5Aaq+XVph67tQTy9YB5ExTwma1oKxLQqAvn7E/IcX94cfyo/K0?=
 =?us-ascii?Q?8bgjSBlVGTyTdfrPSpmioOifztZYkDMnAC8v3yrl5uGiqO3hKxTU0wpdDV1n?=
 =?us-ascii?Q?A38mgB7mqq0LhFodCYGg9MUxzh4spVlgXD+E/MqVtuXWiwAmHmjJNfrUFRgl?=
 =?us-ascii?Q?UuhrVz7P6+pfKAn4bxLamQATk8b23CYkwkP5QOgH67BH4mHMxL4Bct1nS8R1?=
 =?us-ascii?Q?upw4qBl/i3nsq8eLHUlQIY5xyZhBiSqf/ULRzcIZMF69ZIakQRa41pg8b2wW?=
 =?us-ascii?Q?C5fbHs6UYqb4g1YEPVwvbdHI3aBTCaRusXMkVJzzrPq+AOkypDGJxz4b7LzO?=
 =?us-ascii?Q?Vy7iKip4dfYBWRdylouhax9tovjFZQssdVeyjqB5so0eikFqfdR/XLjr9MRN?=
 =?us-ascii?Q?F5vZ5F67mjLtAyXkMvyRaOuTnRg6vqvEZRgx1ChSdEi5H4naTvGwDUDuM0qB?=
 =?us-ascii?Q?TEtrKnouo/tH/p40szjzpxnDowi5OSlCu2sXFI+7KA9nJxqe6Fig5jq3kpDE?=
 =?us-ascii?Q?QtNBr9VKs9oQIiyyhsLyNi3j96FSsQZ1ztf/CzOja6smJ1UWjNwSrqOxqhcy?=
 =?us-ascii?Q?BPSCi+rrH3IQxFZpcZfi/zj+0NhMPYpwTkKWQdMeVXpXYtn1Cjco5IuFxMhd?=
 =?us-ascii?Q?Vf3ImTZkS7B9ak8twSIyo9mfQANO4ESW5OltOFnH9rCsWegPAS1i0WTv/r67?=
 =?us-ascii?Q?NqJA6wvluFsUbqjlJjInbCJZ1rHSsAbad5X0EfEiRGHFkPUPg/hdt+L+OM17?=
 =?us-ascii?Q?jSJJFUgEXlr9/KKqwNJts0Y0cuZPweZEFWVKM9bAhDuk4iPOUBVa/3ek7XPv?=
 =?us-ascii?Q?8gCYWn9tH62GEMFrefNDA4LCgxLn7KrLMIjjUtiD8FfbQ3uzhjMSPngWo9dr?=
 =?us-ascii?Q?NEKgIYM9dP2ODezDVvUzmpgh8etwX6z1VIQElNqAQl87toy1igTvEr4phXfm?=
 =?us-ascii?Q?XDjTtUJ4D6CQCv2YGQSz17UL97GyF1hgTNKo6y8Kv1Sgg/sOnPDRRH8STehv?=
 =?us-ascii?Q?TyTjwV96MtFu3aCceXeVG38Cy+peTAuXdhAk9SouCIFKr3IbNqDvnDOx1JPA?=
 =?us-ascii?Q?CMal/xrnlA3kHTmYS/IijxoC73Tz3H45QuRHgJeXvZJBmp8754EP0xj0sfh4?=
 =?us-ascii?Q?2BnvYE/DgGhAdrzl++WEv+dIFm6mL6RlOECFEUNuj9I1NtAYgYbQezE16eAL?=
 =?us-ascii?Q?QHFsveN+u3Ix20YVx2ww/H49GUtHa/RZlTjtl4nMXCNILRH0PBBI+2pKfr3R?=
 =?us-ascii?Q?JIJgkRJUSsiMVogcW2aXYNtic5vmc0cPf2HQ2knpXw5vTEa0udeaHAa7K5nf?=
 =?us-ascii?Q?C9j3Y7kdE0xVm/hpKxkksuK1ENv7P7lkgvaelycSwazszyhQJVktXdXDj/SY?=
 =?us-ascii?Q?TuGHunlN5s8NJdJ7avA+WJ4MxA68JRvYPH4LY21n47HJhFWrn/l1RtsuVQWJ?=
 =?us-ascii?Q?Hm8XsmlJGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34292e5e-651e-41b8-698c-08da3e5cd279
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 14:42:41.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+Dp7ZOzEMvwcKGV5VqP4bwMJoGBL/EJmqqaakpE1EAzRAmO7xbrlSNwZHcpfADIb0TLwtEPZ5F8J07vBAgRRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 25, 2022 at 10:29:23AM +0530, Mukesh Ojha wrote:
>=20
>=20
> On 5/25/2022 10:15 AM, Zqiang wrote:
> > Currently, for expedited rcu we only check 'rnp->exp_tasks', however=20
> > the 'rnp->exp_tasks' are not always exist for expedited grace period=20
> > that not end. this commit add 'rnp->expmask' condition.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
> Thanks !! for the patch.
> Commit log could require wordsmith from Paul :-)

>For Paul to wordsmith this commit log, he must first understand why this c=
hange is useful, keeping in mind that show_rcu_gp_kthreads() is invoked for=
 normal grace periods, but not for expedited ones.
>
>The point of ->exp_mask for debugging forward-progress issues for normal g=
race periods is to understand why tasks blocking the current normal grace p=
eriod are not yet being boosted (because the expedited grace period's boost=
ing takes precedence).  How do these additions help you?

Hi Paul

Oh sorry, I misunderstood, my previous understanding was only to get the st=
atus of the current grace period.
thank you for the explanation.

Thanks
Zqiang=20

>
>(Not saying that they cannot possibly help you.  I am instead saying that =
you must tell me how they have helped you guys.)
>
>							Thanx, Paul

> Reviewed-by: quic_mojha@quicinc.com
>=20
> -Mukesh
>=20
> > ---
> >   kernel/rcu/tree_stall.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index=20
> > 2464b0eccfd0..5c4df855f2ac 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -865,13 +865,15 @@ void show_rcu_gp_kthreads(void)
> >   	rcu_for_each_node_breadth_first(rnp) {
> >   		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq=
_needed)) &&
> >   		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp-=
>boost_tasks)) &&
> > -		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rn=
p->gp_tasks)))
> > +		    !data_race(READ_ONCE(rnp->expmask)) && !data_race(READ_ONCE(rnp-=
>exp_tasks)) &&
> > +			!data_race(READ_ONCE(rnp->gp_tasks)))
> >   			continue;
> > -		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask =
%#lx %c%c%c%c ->n_boosts %ld\n",
> > +		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld=20
> > +->qsmask %#lx ->expmask %#lx %c%c%c%c ->n_boosts %ld\n",
> >   			rnp->grplo, rnp->grphi,
> >   			(long)data_race(READ_ONCE(rnp->gp_seq)),
> >   			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
> >   			data_race(READ_ONCE(rnp->qsmask)),
> > +			data_race(READ_ONCE(rnp->expmask)),
> >   			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
> >   			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
> >   			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
