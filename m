Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8155D921
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbiF1BxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbiF1BxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:53:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5AA1BF;
        Mon, 27 Jun 2022 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656381191; x=1687917191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T+QBXsNydxKhPTvXdUJAouaSAUNWoJeEutWm8XRD9PI=;
  b=jE26WONyVLmivWpvHlCdRu/TJJjMuiJ0ZTOLNC13Pw272hAfxSQZJ9sa
   DOfuzVyLgQb3qSEpMc6UTwYZj/Fxoivqbs8a2SXxWir3PfNVOjCNn2s57
   sXHyU39yQ5Sdn7vaplR1ehAvmKDuZ5GLXqXkelqM31sn9zlgoCdCg7qpL
   2m4mvythtr4k6c40YG0m0UqqKgLTb35nvqxUflJNHVHdShPoeb0piv2sH
   29pHdjLtrfwMzoICdfDYh/+HrZHxFQhZgJliRuex0e0LVEIQhxkkkwS/9
   T3+EDPEErpkjWlN0g+jna58iN1izuR+wvcTwxdRssONn0qLge+dsHbilE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367920025"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367920025"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646685272"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2022 18:52:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 18:52:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 18:52:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 18:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU8EMOGU+afGHyUZ7qC/z+Lvr18q+Tm1Cz3GvJMJ680kLlw4mFPP24YVKKx3d8QrHQ6iVoF4lxSaziYl7Q15OWxBd+tl6vRGgCpZ6g99I/wsD668fXoR8+pWV6kP2PqyrE3R150ZL3P0f8MA0/2FjYOT7cKavX+mHlmShCp5B7ZN3u9MXMOKjCzhLZ+os5haR3FQpJX3yfyBkKuTWJgrWFU/ds3Lv+74OYMse3wdIgMiOazPgKo/wmbJFvG84OkePMLqzygb1ai512a4fTU0WmgWW2pl3GifzyKii4nyqgjIMNhWuPeG6uVCI9C4En92q5Yqn5ImhxaReOuP5wU2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78xX5ByX4CBpZnPQlQRv2h+QcwJuVanMO7pbLpDEmqo=;
 b=FDRoHF6kVv2r9SFYhYskS3j0flxKI+pLCtS5QfbHpM+lQ87dk5xTiv/cxWVDaGWqPhvxM14MNaKieSeOPWqLAH1zIFdCm6zJa4YzZYEe8XLOkDvxo60v5ybTx00zUS/ELF0oReih5PZPWcwaGQLDN4NBjd0e2fo9v4dhLCtGINPqxmd+W0CRSQR3vMeI8i7P3lpsMjQ121vAQjYXg+bIdpPkmp0CTGdv6nrtH921J4uE+CMO05fOabp2NvxHL/N3rw8iRjndereOuXonzS7yCUzeEx8Gog3thTVdk0mFG9P33UYuBBMgcxyGdg56dxjbT0tCU5mAANl9lAXfQVUTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL0PR11MB3458.namprd11.prod.outlook.com (2603:10b6:208:6a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 01:52:49 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%6]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 01:52:49 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Topic: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Index: AQHYhQ20/x4TmjWtSEepVJie126Nl61cGSeggAezNQCAADNyMIAABWIAgAAApwCAABMMIA==
Date:   Tue, 28 Jun 2022 01:52:49 +0000
Message-ID: <PH0PR11MB5880EBF5E1DD2C08FA3D2600DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220621012412.2724457-1-qiang1.zhang@intel.com>
 <PH0PR11MB588005D38E08891423310EBBDAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220627211658.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B496CB57A804B95977A9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220628004022.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880C30FB7101CE64485EAF9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880C30FB7101CE64485EAF9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 4db4a7e8-2a42-459f-89b6-08da58a8e819
x-ms-traffictypediagnostic: BL0PR11MB3458:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iX5hm9g3FG+r6/vUb8rP7Sw984Q4OP2/UcLocd0lw+vxuwfDotnJ8coqj5Q4CLjq7J5yjZcKnOtxNL8lGRkh+a+BO0fbEnSDV/yT9qdG7g0GqmqoPCKiu/YXZ59Y8F7qGuav7uxmZpSheW4KT0VVkfoJ1SAySOcS0BlvTnofGRR7fDqlUqRIDmFQYeofFGaDPD4c4nXUTtpcAmS+P/2NqXbNlz0KFNJhLrGIz2ZH5zZaG0bZ5GmhFymmtuKik+K/WZ8kEEIYPdbG+rG96V9Trtlfj7lRwc/vcv3e6/bt423EReJvZ+9On3Hj2NVRlg3v47vXHlUR2zJpmxPkhqPLR7psj0JbDdlvyaI4Vwy5sSh+lsA9a7cZnG7sinY6hdaNrUj36O6SJXgx6gFyu64PZcfYOhEhep3Wb22LIGOkr+oQrrPtU6P5P3ICXsn3E8z+AHldGstj6zCUL/0/GtD4+0ski2tet0oq1hu1e2+cNnE9+8uI8qoDtK0NSr8TCkE9jRv4rRhijRxoeOgbrV2/PKgu18Kad3gVV+nhL5dxqFJA6Nchy96/Ysy2c91K4054tiOnD6YGJl1Ur40Eak5sub3sDirflC9TpbvOJlnPKIoPITgfJGMaSGmxN6NscW04e5FcPGte3nRqZnRhMrnm46vUaYbifDDo/xzggzrQfg+x7GFoSEck6A9ubDHUmoVoF1iQIBjliYCFvvtjlJeWMyb5J3jBIJsSzoIju0mVbCpvOe7gLwWxlh6ZAkLCfSmQzishBrr85rEcZa4FTVkgDdvVw3wNyPVjIGgFVW0UOmk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(39860400002)(396003)(110136005)(54906003)(38070700005)(38100700002)(2940100002)(55016003)(82960400001)(83380400001)(122000001)(316002)(4326008)(52536014)(66476007)(41300700001)(71200400001)(186003)(66946007)(66556008)(2906002)(9686003)(8676002)(76116006)(8936002)(5660300002)(33656002)(478600001)(64756008)(26005)(6506007)(66446008)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/JRzcY3ZSbirAlgAH+4c9/eBGdBqE4T133x3BD3NiR+XQYbSOf+kvtpJ7mqh?=
 =?us-ascii?Q?NShbv2vXP6DmKPZu1Px4BJjwjm1LvEc8g7zZRvbdJxsyJPKggRWnMc2zGa1D?=
 =?us-ascii?Q?l/8OAO7JvMYO2AYxgdnLh+dmMEAP5573K5X3j4qCQeCXyjEFdQhNo4FZQq00?=
 =?us-ascii?Q?prd9UcKTky0wrt1CHKe7TnoemCt/tQRBT8s0v/EEFJNzxV8EJ1pmrgbCJ2ks?=
 =?us-ascii?Q?XVTAQWjFubXEB2AJ28/64KO197SZzlOkVCGBtmB4RczljfC4H07q68DSLwcL?=
 =?us-ascii?Q?7VsoJTBgOHfq838B4Qu2XBKvfGU2dceKES/5pp4CHzU8iVu2zwuyokQk9tWv?=
 =?us-ascii?Q?j48E1w1RGacbCwNWHt13xU3ARCmaas082XSvsKLGvdMaxk4cLGrinDmxHUoK?=
 =?us-ascii?Q?XupgrsItqhVKtTmIPqnQaaqZl4ihWMc3CMxpdsH0FUkteiDGqPPndKcGc4my?=
 =?us-ascii?Q?3F2OEPPmRN0BX8V6rEssHsMMMEiJnWCYNNupMwg2I6Z9mAhbDHvjueo1Piv5?=
 =?us-ascii?Q?OgVcrH5GGKss5MQrpkmhy39Js+g7fvd/u3tWm6Xe/+epJPaiWdz5Vh6zYpSV?=
 =?us-ascii?Q?bFspBdv2WO/Kq0kMjFYWevcr2Cq3rZcdOv2dyTywkczCu7DhsYZLTbv4VZ5S?=
 =?us-ascii?Q?eTpU2zDmOGpjKVcJpDqY9GsoCPnTPr+x6WnBMXF2iCS7RBPuZhKR0ryzi56n?=
 =?us-ascii?Q?dDpMchGJ2rC5AiTzycSzSznpgTr+hpBwhWk9Pyc7MUwT7/V0HXGVi00zOMst?=
 =?us-ascii?Q?hglsdqoQdUF0DIVfAviUuVAYxhjJKnnI1r+rhMetPB9ONc2HLxDTkAlA2GI9?=
 =?us-ascii?Q?bxI0C3YKmRVMnqS3kFKdpbxiPJY+DmWEp5NnDBgmCfszohozXT33NA1e1Ky0?=
 =?us-ascii?Q?ksySjhmvouqTWudm076Kt/K5QjwedU4tuzK66wSRGdaAIvoh44y/k7XK/b6s?=
 =?us-ascii?Q?1c5XNyWmHRYRS2mBWyRriPjnaiPAxWH5EMx2wnCJGY2xP14jENbIinRf0Z2N?=
 =?us-ascii?Q?J2wkXJ4dJqi9qHT1aCj0RcWn9z/9bQYYbjkq6PKYRxMTOIVnWmgYovqLci19?=
 =?us-ascii?Q?1llHt5QCsFRbXEgIc6lYhSMrIllcaD1aY26aeZnVSHU+qx7rzMsbnvW+ZlY5?=
 =?us-ascii?Q?h5CTigSmgcYSWRa+pqBFTQv1qjWJysztC59Jk0fqKzyqdXQmlRjB0A/h1EQG?=
 =?us-ascii?Q?kHPhrR3A/MExzULM2sFygOcqumo6NeLJC9IjoqHM+4hdPdauWy5s/Osg9iEa?=
 =?us-ascii?Q?8NKvA+iRQKygodZnQr7O5e6NM4t3DnhK7t0OSbMZkaeg/hfRZ2xihzpEewBG?=
 =?us-ascii?Q?uuhkdrKE31aXlq6iPMuN42SeEm4o7ElrcPgtm0mjrTbq4UIn8x+EOfzz81tv?=
 =?us-ascii?Q?Qx/GQxzK4tOOtlP4B9CZOMzXA0CRlm0oCrmB8qNbbPfHlXCuQscxNVfyr10Z?=
 =?us-ascii?Q?kVz/1lb0OVwjs/jd9gukevzr+uqpKCpDwjwpEaaTppqE0BUILECnxrtvC6/I?=
 =?us-ascii?Q?3y2ZOfydWjU43NakKwu7iMlQKLxjJakoY/2PIXWbIViO1I2Koh+TrcU/HaF7?=
 =?us-ascii?Q?qS0luAqUMT3N2nnXSlGHpJOKBqkiiTYBoWrbhV3i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db4a7e8-2a42-459f-89b6-08da58a8e819
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 01:52:49.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXrC4nZKInzhapN1Lxhf5juE6X4NROaM797H2S8/0KPfmiUYQs6Df6sLwJamdatbidk2ZJwUgZM8fCQ5anfy4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3458
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:31:12AM +0000, Zhang, Qiang1 wrote:
> >=20
> > Add Cc=20
> >=20
> > Currently, the sync_sched_exp_online_cleanup() is invoked in
> > cpuhp per-cpu kthreads when CPU is going online, so the CPU id
> > obtained by get_cpu() should always be equal to the CPU id of
> > the passed parameter, that is to say, the smp_call_function_single()
> > never be invoked, if be invoked, there may be problem with cpu-hotplug,
> > this commit add WARN_ON_ONCE() to remind everyone.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree_exp.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index be667583a554..ae8dcfd4486c 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -865,6 +865,8 @@ static void sync_sched_exp_online_cleanup(int cpu)
> >  		put_cpu();
> >  		return;
> >  	}
> > +
> > +	WARN_ON_ONCE(my_cpu !=3D cpu);
>=20
> >If we are going to add this sort of warning, why not instead add it
> >to rcutree_online_cpu()?
> >
> >The reason the warning has not been present is the prospect of concurren=
t
> >onlining at boot time, which might have rcutree_online_cpu() invoked
> >from CPU 0 for multiple CPUs at boot.  However, the for_each_online_cpu(=
)
> >loop has recently been removed from rcu_init().
>=20
> The rcutree_online_cpu() is always invoked in per-cpu cpuhp kthreads,=20
> and even if it is called directly through the for_each_online_cpu() loop =
in
> rcu_init(), since the rcu_init() takes precedence over smp initialization=
,
> only the CPU0 is online at this time, still only called on CPU0.
>
>And sync_sched_exp_online_cleanup() is only ever invoked from
>rcutree_online_cpu(), correct?
>

Yes, currently the sync_sched_exp_online_cleanup() is only invoked from rcu=
tree_online_cpu ().
(Sorry, wrong wording in previous email.)

Thanks
Zqiang

>
>							Thanx, Paul

> Thanks
> Zqiang
>=20
> >
> >But I would like to hear what others think.  Would such a warning
> >significantly help debugging?
> >
> >							Thanx, Paul
> >
> >  	/* Quiescent state needed on some other CPU, send IPI. */
> >  	ret =3D smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> >  	put_cpu();
> > --=20
> > 2.25.1
> >=20
