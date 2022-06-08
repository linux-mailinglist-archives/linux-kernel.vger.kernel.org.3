Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9B54280B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiFHHM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiFHG2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:28:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33053F33B0;
        Tue,  7 Jun 2022 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654669716; x=1686205716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bbCkQrZ8ITRpKhR/56fiNmo+UuF76BRlyJIYAanuCkw=;
  b=EwREPe3evRNDoaOlfGXfIGKCSY3f953VAwCuGMi93ynNjapyUqBoPZQI
   6KIfH6BjwfrWlQqDD2yi/8joqPJlT/mBgFdqQKNc6rTpAxtD5010wjqAm
   R3bOwiqiv0jKnie5QHAy01kDYEvtBPE33nU8I1S/2ClCHVpKpNYqAi8d+
   80578QHfjuyT0CIpQBkqxtk+fc17fdy1DoeVuHSE3h3F6mGstvYusrhz7
   vqp3rADBigEbAKWUIvggY5016XFQO6vSntTJ2E1k48SrTCXQi0eCq6Kby
   ihhXD7LWeE8o4We1PNwGbO6FJjSHtLm1Bn3nAOwBfB4t8PTtgf+Jmq+7V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340880278"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="340880278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="532972321"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2022 23:28:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 23:28:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 7 Jun 2022 23:28:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 7 Jun 2022 23:28:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FImTpY/5nvPd1ecRNdTwl/8xOkVeCndAySVSfAqwexxo6MLJr4LjF9L6TTLQQe+Zxz7gmc0a7Ul68lBTatKgJxdrCLlNwAheIG/Ixl6D8Ya8YHLHilmq2ltjpBrn6DxOS2DdQ2bUcdRRjfje0zP1wV3CbsleGFyCGfXkJJ4NtLOkrR/JA1tTd5cB7ynY821qHnS39oJIlgEdLSz61/4x+NIhMgfLRjmtxllbe2Cx+0QLmxT5mllIr3WivxRROWmb84JAQOISKXOe7T4mGr5rofPfteoGNn5izD+Mdf0rDk4sGbzSSAq+iq3UvCoTJBoPrloTgLrjt87nbaCar2oqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rWirw1uiXzHMa1V24yJCh+64mb4nd1RImCvVdQMUUE=;
 b=fuCPQJqGvm8dd7GHjQF1RWKIStVKJ/dE2F5elkdlHGWoeaPTGkbYgF+xrvOWkivhbfKoY9YVvdMH29Tey57WZOqAJ7I6TSisjO3zB5V60tH2zBOdFF1AuPkVmd+5oELzY+23Icc9mjKbq58qq/Uq8z/mr5Y1GZtY3lUO9Jj342mSH9xG33p4KtThyf62VNMgsf4pdjsAB66ycioXXRWBzS2UIhgS8E8XikXlBSt1M9zMD22pysDPcWROVUuitLhTTU88eahc02/XbhP3kDVzeOpOxBx3C54NIVnYFIwzZSzvvAstkTKI+js0K4b0o/9+kjQonysOIvoVp8Sw313Drg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 06:28:34 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 06:28:34 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list
 is empty
Thread-Topic: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Thread-Index: AQHYekOLcM/pjDOLHUOfGqJWFKxX8a1EH1EAgACISxCAAAiugIAAAQywgAA0YoCAAB/80A==
Date:   Wed, 8 Jun 2022 06:28:33 +0000
Message-ID: <PH0PR11MB58809FEA1314CF0A7AFAD2BEDAA49@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220607075057.909070-1-qiang1.zhang@intel.com>
 <20220607161620.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880551F642B1490CEFA65A8DAA49@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220608005513.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588014C2451C2E65E583924DDAA49@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220608040627.GL1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220608040627.GL1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 435690e2-2ff0-4d17-f0b2-08da49181cf8
x-ms-traffictypediagnostic: PH0PR11MB4855:EE_
x-microsoft-antispam-prvs: <PH0PR11MB4855AE4DD6EAC09EA7A06E57DAA49@PH0PR11MB4855.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xU13Kz4DsR8jBdGUgtN3avk7xPo/4DnzoncYKNJIRwoKVu4nzmEQ/GVyhPxRZ1iIkRREHuvA6uyjJc8Z7LbJP0e+n1mC3JfVGQXB18R67qLenJVYYJubPf7n2Dq0zIRAXyK/MjK4OK/5kspMBtWCVF83DXUbTY6xU79QJAP45wRCJ4nkYc2VIC9QPBAex+zZ1baQKg0cnTDiQsqdr7gHU/rjfzRqtYzHnl9CQ6xHnvPO8MObeWLtzm0nKHsz9fD974C4BnsGlwjvbTKQuDbnHPmsKs9CwV3l5Wly5F02x+jwEzB/ZjNbxuSfiv9adsN/8JDHHE/HFMjzpafySBnDXI3uzsm6qVd1ev3Rd0GgL21cL1HFoeUiVQ7BKHAoGPaufz2VquwWkoJwhXILHC+raTFCkoZEVv35jtDZzcqQcl3X+XjKMTXimGQVwyyCx40PVh0OpsgDuDzO/eIPF+a/VAQbw/b1YTvRZcMjjOEuCcPpmk4teSTQiaZVJ7d7s1u1U8PmiO47EMj1PYU14jImGqxngy9U5yFxFyvyU2VqSeVU4SLeWn+/tNJceNTY6DfTdI8RGJITKbId9ijm62y6XM9k6W+lUm+jXU+wESrqwuGm7rr1471pgxIXMpOlEmKsbYcJVN3HfQZmHcraONrvDqvmmuNl3erJOOSByyskBPZ0KhL/ap+9hPDMMW6h/+EPh+1wQzVqScYOXedTwthhhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(26005)(4326008)(76116006)(8676002)(64756008)(66556008)(66476007)(66946007)(66446008)(316002)(52536014)(9686003)(38100700002)(8936002)(86362001)(6916009)(71200400001)(38070700005)(66574015)(54906003)(55016003)(122000001)(508600001)(83380400001)(82960400001)(7696005)(2906002)(6506007)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKvJMYxUa4GNwi8pC+v3s7gVpEmL2LUSJBrSPG8NTf9EiwShyEgL+d52LEPj?=
 =?us-ascii?Q?A+qGXr/IcFk0ElIoqr50aKBwWHJTGP260UhxL8phTsWbYhy8fDEb6NKsxbIx?=
 =?us-ascii?Q?eTq5zJuE/twkxFpbs49nTEMQ5oynWGiUBeoEuoq2Zxlk4fW8RNijVMIP9VMm?=
 =?us-ascii?Q?xxvp9dlggTmlEswkOVA/R22YE3WYnrxNCoj8C+m+t4QPM6v49/oiNvP8IjCh?=
 =?us-ascii?Q?BXJ/4p1/fTlGeJiW3Dq5ygRzOItpCFnlhCYjn8NDQZAEeoWUPmOvz1hPoIZM?=
 =?us-ascii?Q?ePyyOisHw2AWtf+lWuk/IJB16I1rrWsjak5FMgP1Svrx6zlBjb2hQ5SbhsBS?=
 =?us-ascii?Q?9M5LTmZ/zASIdWnFyhwzKHKJvo8hYAJ+CknvW4I5w+tYr6IBQU5Dr8MesJ1i?=
 =?us-ascii?Q?8e2ma0C/1wkRkCT++3JzWTuGE7zdcxKdRwompeGZq3Li8byMwbWGf7nAK3kk?=
 =?us-ascii?Q?WqC1NTkvsJVfsG+RXWIJREA6bHAAiP0YNMaBrH0v5pOBIvT1rX/x0f92hbV9?=
 =?us-ascii?Q?XmnZWM8HnF6tUUK/6gRGkdVWUMF9jJDDthcXVpI/qOcuyniRY9N+3woUJIms?=
 =?us-ascii?Q?wsIYHDtTmvN8rnao0GFUuePzNGNRqv4YG5cohkSc5DnGNIy3gStZa4el3oek?=
 =?us-ascii?Q?pnU9kLRyg/8bhraFv/+Ec8WJOLvpJxoscgJmyCEnI/kjOWUqIj2B57j0Z/15?=
 =?us-ascii?Q?bBHctKGOuXTfp0jaUCAdkbrQ6bGXjV6wld2TEZKcX58+MJKfXi6KF0cIIf5n?=
 =?us-ascii?Q?uikt3JmL+jIc7Ebi4Rxz8HwnLiLiUgPIgdUa/+GtgOfm1ID9QcVxvXf/uE1f?=
 =?us-ascii?Q?62BJ3uEW5Z/pGIBy2bOY6W0X63k6jAIKyhildlBh42NRMygUhzD1VrJiV8/X?=
 =?us-ascii?Q?Lsd6MKWbKhII+nJPweGVvZHfU3MCvwvpY2Ex7f7tDY+YPmnet1pWoCf/2rO8?=
 =?us-ascii?Q?w1uBfqXtWvJKf9s1mJExYCwN0m+se/rvrZR89mo2fQ7FJmCf9znbqwhUztyD?=
 =?us-ascii?Q?kKWfXTTTfYmJZDsXVHUKS+eOioistYr7hP0Bs3Y/S5ozbIz5DWf8+i0ZEb8S?=
 =?us-ascii?Q?xGb+MIoUpYFJrhBqvV0Q5tE8AFH30XHFum7WF9nN6ZhODp328Tb4lTDwRdVA?=
 =?us-ascii?Q?RKIelDJLSxVaoO7+5m7XW5vja28IxIrJZvys2odOviAFQK26HTjuHg5v1LqY?=
 =?us-ascii?Q?N0vOfK0NAZZaMBoZjLdUTlRPsh3avF8pUUSw1laDSEJ3jPfnGJJQ3nBuRgPj?=
 =?us-ascii?Q?IKtxij0zQgiIyfizx3q0ilAqSZXYj0mj3B9/51G0drohGo/Wyt/D07jzds8h?=
 =?us-ascii?Q?QjIMBGsJbutViCUU6ZaCM2LBzoQHnGozzdtIj+eZho0e4yEwCFlhxsfqKcGW?=
 =?us-ascii?Q?5deeUHIex8mTLvijJ0LSmrwmwU5otQbIsaPKeoM1kaxVxUnm3DLVP4v3Kgxb?=
 =?us-ascii?Q?k6C7VEAq8tcWdKVaZtdTzoLYjyigcy5Bs3zW760pOitYIKf/RwESHyt8uw0V?=
 =?us-ascii?Q?N1JJ0kLNYlVXt76triefQq8Q2T8gMv4rB4WSEzVJF+SHq38CSSqvlxa0GBZ9?=
 =?us-ascii?Q?waIUzZ54d9t7vKUmx0VzQ+3FxIrrjsy8cAugh4yfB/wpRBH2V+RB0Ap/wV+2?=
 =?us-ascii?Q?kk/v0gK7NFd4THpX4N/ht8QcodTk2CVww4abV7mmCMWbzahDhwQSt8vEra0T?=
 =?us-ascii?Q?KekKNLowXPrwxwC/WtjUYGvfVIUclx4jRurFqOJA9kPZzXAYqFpmRJw53woS?=
 =?us-ascii?Q?WfNMdprKtw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435690e2-2ff0-4d17-f0b2-08da49181cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 06:28:33.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YaphI6BygzC9YO/o1FVC0am7A5TDWE5IPeJA43DtkAhFeXXUptWILIpoa9f7LQdbcI4qBRW0v1U1vOypzsRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 01:01:31AM +0000, Zhang, Qiang1 wrote:
> On Wed, Jun 08, 2022 at 12:41:28AM +0000, Zhang, Qiang1 wrote:
> > On Tue, Jun 07, 2022 at 03:50:57PM +0800, Zqiang wrote:
> > > Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog=20
> > > kthreads enter polling mode. however, due to only insert CPU's rdp=20
> > > which belong to rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's=20
> > > rdp served by rcuog kthread have been de-offloaded, these cause=20
> > > the 'nocb_head_rdp' list served by rcuog kthread is empty, when=20
> > > the 'nocb_head_rdp' is empty, the rcuog kthread in polling mode=20
> > > not actually do anything. fix it by exiting polling mode when the=20
> > > 'nocb_head_rdp'list is empty, otherwise entering polling mode.
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >This looks a bit more plausible, but what have you done to test this?
> >=20
> > Yes , I have only tested as follows and I added two trace events.
> >=20
> > +                      trace_rcu_nocb_wake(rcu_state.name, cpu,=20
> > + TPS("EnterNoPoll"));
> >                        =20
> > rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
> > +                       trace_rcu_nocb_wake(rcu_state.name, cpu,=20
> > + TPS("ExitNoPoll"));
> >=20
> > runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 4"=20
> > bootparams=3D"rcu_nocbs=3D2,3 rcutree.dump_tree=3D1 rcu_nocb_poll
> > rcutorture.nocbs_nthreads=3D4 rcutorture.test_boost=3D0" -d

Hi Paul, The test trace log is as follows:

         rcuog/0-19      [003] .....   169.400494: rcu_nocb_wake: rcu_preem=
pt 0 EnterNoPoll
         rcuog/0-19      [003] .....   172.592072: rcu_nocb_wake: rcu_preem=
pt 0 ExitNoPoll
         rcuog/2-36      [002] .....   173.553717: rcu_nocb_wake: rcu_preem=
pt 2 EnterNoPoll
         rcuog/2-36      [002] .....   173.750084: rcu_nocb_wake: rcu_preem=
pt 2 ExitNoPoll

Thanks
Zqiang

>=20
> >To exercise your change, could you please also add an appropriate value =
for the rcutorture.nocbs_nthreads kernel boot parameter?  Without that boot=
 parameter, your kernel will not actually offload or deoffload any CPUs.
>=20
> I have set ' rcutorture.nocbs_nthreads=3D4 ' in bootargs.
>
>I see it now, apologies for my confusion!
>
>							Thanx, Paul
>
> >An alternative approach is to run rcutorture scenario TREE01.
>=20
> I will also use TREE01 for testing
>=20
> Thanks
> Zqiang
>=20
> >
> >							Thanx, Paul
>=20
> > Thanks
> > Zqiang
> >=20
> > >
> > >							Thanx, Paul
> > >
> > > ---
> > >  v1->v2:
> > >  Move rcu_nocb_poll flags check from rdp_offload_toggle() to=20
> > > rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of=20
> > > rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set =20
> > > the rdp_gp->nocb_gp_sleep is not used.
> > >=20
> > >  kernel/rcu/tree_nocb.h | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index
> > > fa8e4f82e60c..2a52c9abc681 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -698,10 +698,14 @@ static void nocb_gp_wait(struct rcu_data *my_rd=
p)
> > >  				   TPS("WakeBypassIsDeferred"));
> > >  	}
> > >  	if (rcu_nocb_poll) {
> > > -		/* Polling, so trace if first poll in the series. */
> > > -		if (gotcbs)
> > > -			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> > > -		schedule_timeout_idle(1);
> > > +		if (list_empty(&my_rdp->nocb_head_rdp)) {
> > > +			rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
> > > +		} else {
> > > +			/* Polling, so trace if first poll in the series. */
> > > +			if (gotcbs)
> > > +				trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> > > +			schedule_timeout_idle(1);
> > > +		}
> > >  	} else if (!needwait_gp) {
> > >  		/* Wait for callbacks to appear. */
> > >  		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep")); @@
> > > -1030,7
> > > +1034,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
> > > =20
> > >  	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> > >  	if (rdp_gp->nocb_gp_kthread) {
> > > -		if (wake_gp)
> > > +		if (wake_gp || rcu_nocb_poll)
> > >  			wake_up_process(rdp_gp->nocb_gp_kthread);
> > > =20
> > >  		/*
> > > @@ -1152,7 +1156,7 @@ static long rcu_nocb_rdp_offload(void *arg)
> > >  	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
> > >  	 */
> > >  	wake_gp =3D rdp_offload_toggle(rdp, true, flags);
> > > -	if (wake_gp)
> > > +	if (wake_gp || rcu_nocb_poll)
> > >  		wake_up_process(rdp_gp->nocb_gp_kthread);
> > >  	swait_event_exclusive(rdp->nocb_state_wq,
> > >  			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB)=20
> > > &&
> > > --
> > > 2.25.1
> > >=20
