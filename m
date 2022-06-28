Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C374C55D590
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbiF1Apt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiF1Aph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:45:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0FB1C12A;
        Mon, 27 Jun 2022 17:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656377135; x=1687913135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5SzRtSeR8+fkKtkRwBiWXLdbTjqwet7+kYv14M9zT1Y=;
  b=coIMbR0AGg3Q/0zoNn+XKnE5UdR5aPXnmVXE1HgjNPwn4P04O5F5S8je
   JXiUL4xliFPc3L2kmDzhyal05K0egtyDcDFK9mTNfZdHXHn0H1Ff5pskM
   VK8l6QwTVB/ipgIzeD5I94FdbNOneyZCmC9XYl9wYvIV3uQ8sE9fOQSA0
   gFy4jHJ6V02Lc/FN60hRWlUNsWA+KYmx3hwPD/t22wSgZqZRgfVEd0lWH
   z6EhTsJ7TnCuEIp5+1X9oFx5fBhz5GCfVEjA82iAF25MCLivezh4Wjc6U
   2BCvvMs3GATW6pZm6/fx/eUTRWrLn8PW+QhWwsv/kkJd14OL0Puua7p61
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343286984"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343286984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 17:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692863109"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2022 17:45:34 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 17:45:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 17:45:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 17:45:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knGHxVNnqRtxuiordOKSq87A+/wLlGYlPtlH5GxFTJQyASANu7jK+DZYQnHYsqb0VixJozAVLtwWW+wBMoP3DUa3k8BmaxPGC6fiWuwfl8n3YUSHrCuCg6nMfdS0eNLfw2OClcJSjYMW5x0AKgi0poxUtigNGCaWvHu0UfpUAWy13rkU49NWG8V91EKzuzhV6lzDwX7gG/lg/HuW3WmqoOCGrnSenFbmCZHRNsanhN8+HPEh51iGU33aiqgvoBrYbNBiM7wbns2Aos+8RGL9Kc7iPWirQoJ+SBwaioDRrG7zDxME2fH8ZpoTGC2ft5wKaOKrNhOAX5t+0bSO7RMz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmHUuP0D6y5PZMK7LGoXpfBJWgLqQ5ck8k9d1oEe+2c=;
 b=T4T593pwNFklljIwAt+kIRzBt+Br/6O2Z2WWeibOCaN8R6z7fonJYNDbN+fhD/Me4+rxTgCgtt4M9jnuRmkPsxsKNvjtInkOCxYN0qMoDe7vPNmu11y/AAw/7NYoP7ta8epmkA+QeQZ1wAhZTyyTcPK+zciik+RU04qUO2faFeGCLx82huCLz3/+e5aoZwSSp0cMCLVAmraT8RNFt59/+sW3O2eVQgG8ejnjC6Ax8fuFFVvSRLd4YI1lQ3LYqrNSqQFsqqbrLs8v0fsiOUHbDvGanAHE9Qlwk8C6EeHkHuYuNS6Rdyl4c8BH/ZlzqnpmwUi/B+73q0Pe9QO69qwN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB3915.namprd11.prod.outlook.com (2603:10b6:5:19c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 00:45:32 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%6]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:45:32 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Topic: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Index: AQHYhQ20/x4TmjWtSEepVJie126Nl61cGSeggAezNQCAADNyMIAABWIAgAAApwA=
Date:   Tue, 28 Jun 2022 00:45:32 +0000
Message-ID: <PH0PR11MB5880C30FB7101CE64485EAF9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220621012412.2724457-1-qiang1.zhang@intel.com>
 <PH0PR11MB588005D38E08891423310EBBDAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220627211658.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B496CB57A804B95977A9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220628004022.GU1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220628004022.GU1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 9337334a-000f-47c4-089c-08da589f81ab
x-ms-traffictypediagnostic: DM6PR11MB3915:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0Vb9jsgY9mvwkM0i6ZTDH+7Ne57vCW4iIUMgiotytsagRgUyvzCd6TiqhNlt5shksqNmE/7N/Dx2nFzrZqqvkNNqts+uR4w1ZD+0qJijiydquiMCw8fNt/tZ64mKm/mXaMr6D6foDETIT34qsiPKeY/sgJvaHGc0GMiNaEHHdOjVkbBg/5OtlhICNlhttd09XKP163mnEC/GuXJPr5oCd2o22FfSU7lJlTitC0LXPr6o7xUrjB8LiEIL6hUuoujvplc07R5C5/7ypNoW4SVr2gaQ4VFrsFgyyg4pOpKwJBpt8YNwSHRLNSi0IXPCtjSl4pCKNyCW3ouj4HePf78I4L9BCanrkWKzBl/I6EmIcHk/7caFGhK3LvIhzxK6ZG0G3rWePpnmRA225SjWVyywdyjjQ+iFGwqfIv1t2HEBOoDLgww8+sMqj9k1hONdngd5mi76xQ0cX61qc5SmYJHYdB6kB2O05QtiA3CzgSmTuinLWIex12+hbIbf2HDs79RAiXaCtbpQj6g1G+rtsI0CA3kT6cCayvrHTq6x3zei5GNnx0v4rNnrxX2VMa5jia5Vx9qQpz8veNAxgO9kAU5PwdktglZQDHGGqgrBvwhWJ6otUCjbVeUKym9szBoI4CH5urILwZ6EuBtekXayUsIysCQs20TyEeO1wkkFfY8o9yms7eDoreaKRfLbXZaOgLJE258cw7MwrtRjQMlOvm0ZU3ivrfCyi3WPEMx7QfjY44vuyigVvyUWileYGp0bOF3v5tXNN81KO0LI/IvGhOMrihxcJmsfPRofbHE2Sr2TDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(366004)(396003)(39860400002)(52536014)(66556008)(186003)(41300700001)(86362001)(122000001)(5660300002)(7696005)(82960400001)(6506007)(8676002)(55016003)(8936002)(2906002)(478600001)(71200400001)(83380400001)(54906003)(9686003)(76116006)(66946007)(38070700005)(33656002)(6916009)(316002)(26005)(4326008)(64756008)(66446008)(38100700002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lk+4DPgrfJIctOlvTiSoJqsFWra+dQktlAjBWyonuiDu8NGy8Br0cCChxX3s?=
 =?us-ascii?Q?KsEo97V6hLmkkZsDYFTdr4EOwBRl1iIu8Nj6ibjh6tzz0quWK7ETPm9Fg340?=
 =?us-ascii?Q?f4UzTVP4rRJqxKI9mJ9MmKOStYqO5ZRVQtaHcanGr0gCs2sHEPnzr/nrzrJs?=
 =?us-ascii?Q?3yZIJ33lEs+X2oH3d5bCUZHdOd4WNeeGo4EfNqLP4gwDh3xiOAoVK/ITjYGp?=
 =?us-ascii?Q?uTW0QnrxjxH4XrkYMPHD0MIWBQlWzGdgNIMbVy3spu6PlRDWu+y94NuAo0IJ?=
 =?us-ascii?Q?gA4omOR1+/cLOG+62W8682rUWuO3xjcZaz5bnSTyEPXlqLZCP4lhtrfvxcpD?=
 =?us-ascii?Q?2TdlTSRv6KBFuDVQHnpDJlgmNjiA0fgdCqgfT4m0e7J5pYzeEIxFR2PU8X+6?=
 =?us-ascii?Q?FX1op/pc5gNL3Vwdhmx9oQCaNGen56GDd6xBVV43XvXtXUJLg+CSSZNTzvHG?=
 =?us-ascii?Q?VQ9nLy1Foar2ONKFB0CylLCBq5AhP+K7AnORRwwSNMQcHvsqQBk+Y3zaiVRI?=
 =?us-ascii?Q?1K49gsqT1e9s4i4PPLexiiEQqBbTjkTaN6oyM+1TQkaoUkdRxXdgWW7XK+EK?=
 =?us-ascii?Q?CxCe4uzGhAITiqLEQIloesgrbctBMzL3JnL4O7UTceN9DqRD0RyzHt2wgxnB?=
 =?us-ascii?Q?PEbQm4Y0o/6s5GJJKs+AE+5YRqOhFwWey2lN5EDl2YslG6hvmR4tAmMUCckM?=
 =?us-ascii?Q?sJzUUXyeM80BQgds84mFIyTTVgBA3DTYsUsch8v0GKTbrjOXRmUKbkHXvVxG?=
 =?us-ascii?Q?GPJHT/HvMOhNDECJmsLX5weOBCpY7T/bZ/k7oIBIyE0GADoeunBX1e1Ykma3?=
 =?us-ascii?Q?UZFdynudCwAb1kOmLxuovxuqz/GkfItZXmibt30anbH8uBs0llfyyrImTUsD?=
 =?us-ascii?Q?eXmsnTtm9zBfBSntHwZqK6npGciHkjfZ3oBnQsg4FkuQkJ1SbKAvDjAHhGqE?=
 =?us-ascii?Q?05PUHoinpU4oE1EolnC5U6FZxjEYZeZUNCVoD8Wi83K2AsLGO34xf6IS1cD5?=
 =?us-ascii?Q?M/0QcHDp39kwQumayITdR69fd43teX3aqobVyPa2m1whweBHsTFHyS8V3Ay0?=
 =?us-ascii?Q?pfCJ5JoyxqzPv8+zyX+ILdOFj7+Ry9WUtLgAys2ThVPoUjjWXBEa1zrLAec0?=
 =?us-ascii?Q?zKV+sHhEXfnY9nZnHzH27uhAKNZG/+bK9EN0to4IeQOE3lIExYsfa9KOHTws?=
 =?us-ascii?Q?XU+S3SLyuqbgSAoNGhr35L3enU3LlO/LNPpbgXenr8jB+d/v9nfbTj4Aii4O?=
 =?us-ascii?Q?Px0XkIaW/dX7Rh3J7wXt9UDwx614xraNqXezaB+inw6u4I8vEWNFkjNEFwYs?=
 =?us-ascii?Q?PlBYz6ZpdPon0gTIGrGQU7FGwCnjphkzz7xMghUNUGxPJD04WvuZllSfDvjE?=
 =?us-ascii?Q?H8Ek7RR0ExGjR+aBTFJ/CkhTfU20gYcu1tz9U31+qkDhvfTZb0SOLYuDFCLj?=
 =?us-ascii?Q?VNtZ+NIx0jXKPhfrFayZSY+z0xGeWWnc27Dy3dNZKOSscaCmWBxsw9akH5G+?=
 =?us-ascii?Q?o0VYdwLBuwLAuiWK63SbHo1w3B1RUF5GTLKYSfToSpRIZpPfD4EhOW2mkMNn?=
 =?us-ascii?Q?HuTbyzapcuVsz9SRoaP+7j5W+f94iLC/E8U24Y1K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9337334a-000f-47c4-089c-08da589f81ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:45:32.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjeNPBYN+cfKnhj6Z5/2/IwEXx3M6ShwSJhd17LCTdnpvHm/2NZ8rzK5JgaThYYS23UWu7f2ihWwWU/q8K12CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3915
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

Yes, currently the sync_sched_exp_online_cleanup() is only invoked from syn=
c_sched_exp_online_cleanup().

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
