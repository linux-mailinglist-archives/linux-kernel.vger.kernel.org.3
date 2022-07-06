Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC2567BC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiGFCGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiGFCGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:06:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11154193D3;
        Tue,  5 Jul 2022 19:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657073172; x=1688609172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yW1nbVnYIsRV3vlwxVLOZpUbPld+cE94MFV29C6K7CU=;
  b=BFQL4E/n8IMORXysGJaEtXKI2ZI+k+ccNNUJ66ZM49IlR0/aB+HmxqQI
   rJYWqkscprnx8nogEjVBmVbiJOC2audpKIfXSiLCFQQF9nxwVTamJTgbx
   Y/WV4qi5rXUdo4BMeuYLBifoYK1aFjCy38mEv/TchBkENPxRSUWaDgOuV
   pM1KYSchOh6XnUOK7K+oWmcliB3+tpVASbFjbZ4qAloUgviHT7PtoMEo5
   awY/B434mxfI7DBdkznXzaxIk0ueZiueLeGjee9QqF0yHIKcZ6UAd9AKs
   7P+EwDz+9ju6LwrIu7I09y9SYqtR7VXhl4D5kiIfbyJ2ZNulDGzdtS86+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266644965"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266644965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 19:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="919952854"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 19:06:10 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 19:06:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 19:06:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 19:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYcWVJG2lZbnldv16eRwRxHdae/omMGsVZSGLwaal0hZETpNeMfwSx6PqwARM/3D3YD1tN+kUbyLH6etbsFmlKoHcvyHsgwpSGxP72pjn67OXCDDh3OHZsRxiluVock34wQqvz4wKYmVAUwlvYN/BspRBzBloZLVePX4GX6mlpcUg0iI8VFVGTuxi0o4GmHXkyemnsM3tF6bH3AvQucrlmdBO/kzxBvSjzQ3kXHSOWV0p/+cV0yzNxl37kjWcDnYtvw0mTjrTVrZlfK3E/4eL9q0+W96Rc34GiLb2JaPlPEBZmeDTvlWe6QWWO/4Yfu6gxV84eyYCNV5i6Ykxvh1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by6BSEPcsuWthouicCwCtkeYWh8gqJyJMLtZRzq5HyA=;
 b=WOmF8uZTZmA3By0CS6hHiuj4CIb7hLGgI5XkpjPMUAOOiOnLKmPNutINblqLcfZuKwZc+lH+rxm4yInXFm2j/RA6NPzil3zjoilhpPqrsJLaz18yX/6QX5fDohK3v8b2Ozpfmd5vbc9KDf+BFv6dX+I62S15M9PhAOqZLKXEhm/zLiQiazftA8hcBobw+G+x8Hi1zPSv2j7d8/e89vIVj4zT/x3J3+7aJLhzirDevEwR/Lx2BcDIUBCqLAVjoQPPiaWHdwXrgsDfzqDMbJ8DcEWPjAPpdmu1xH+uNTGNEMSV2WqL3pP6ehjlGNJwHfHDubOPEVsZFxe5490ixzouqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 02:06:08 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%4]) with mapi id 15.20.5395.019; Wed, 6 Jul 2022
 02:06:08 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Boqun Feng <boqun.feng@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Thread-Topic: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Thread-Index: AQHYhiPvaZaZmWFjQEu0NBJYl75Ct61brf6AgABcGPCAABuJgIAAHHMAgAAOiNCAB4CAgIAAaaRQgAv/3YCAAHHlIA==
Date:   Wed, 6 Jul 2022 02:06:08 +0000
Message-ID: <PH0PR11MB58802CD4DFF62E426A5B36D9DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
 <YrNQpxjIiNpxwyQh@boqun-archlinux>
 <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220623003409.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrPM3ub+BGukLi+l@boqun-archlinux>
 <PH0PR11MB58800BA38E0691E2FB3AF552DAB59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220627214143.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880C49AE26E587A029B43E3DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220705191427.GE1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220705191427.GE1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 3e7272d6-6feb-424a-6de2-08da5ef4175e
x-ms-traffictypediagnostic: PH7PR11MB6545:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ZXILfiYlPdCLM5NLsd3jWEHsw/TCctlslc6zVgqantBCa7ZWP2p6EztX6XKM/Esut45tgNl3waQ+zzRIFbUXd2jVYhZuPSNUyAUW2pxu4JgDAi6RpPQAxsRS95Lu2YiSD1dJh52RC89RMAIDgon2PRE50w7VULXCjx6Ka/D6FU84j2Ax0BMFlRlLfUf7xJcm5z5fOe16esFGAlwSKQseR4XQYfsPgB7DpoYiEGblseBud84ZLelTIAnDGrAu2LoRKsEekknG6/XLpxg9hDThH4G538g8tpr/9iMA69JeVRL/+fCUPnyec/UHzgRx5TZkvwJt04LGEDYA9PDK4PjVUhnPSK4erl+JJqLv3YqKRQ1FeQf3XAGcXweR9WybNnl3WW5jwoILCu2DeLauKGJaQd9l0opPMUvmh2/CfBOakfXliuGu5rh1AhN6Ls84U3wdxjGO3e5/TDgAS5UEB7nrGesQ4nJfCdTSkOp2pU+MmdnK+wlsDFsil4r52o+8P8cjX0l8es81Gdmxmu2TqkjNcXSrYZhxXxNfgJnDf57w7jXr5fqo9l+6af+TRIbuIw1X8i/gpYmGj2zHA61lOd5IcsVLrs2OTF+X2aMqsYIXNvv84mbgBNH/uZz5a38+xcpngYhq/JWzJBsfLOhTioi9eQo58L9GnHPjf754neHUTSCym0CSg535IAaVhvYcb0Ve60ZZIIgRmOglfaKDSuuuTqQUsjxxL5PQ45/jCZfsfOWcUfHEZYf609u7UGhLGUkP6oDhWpsj1AN2rgdCPWkGwtPTI0f12kpPImLxR+exlvcIqG0+wBOKwtPtXM4e2VAjNhgtMs4QCPJuSQojIfj7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(52536014)(8936002)(5660300002)(66574015)(54906003)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(41300700001)(6916009)(316002)(71200400001)(186003)(38070700005)(26005)(9686003)(7696005)(6506007)(82960400001)(2906002)(122000001)(38100700002)(55016003)(966005)(33656002)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UBVJ66kC3hg6nW+G5byVpM8u8fXkHgFLP20AE+HHK/U4GJ4tOgKbZa9Wuo0+?=
 =?us-ascii?Q?teQwkYJs4q1vT/xJa5FQUZoJ98DVpn14sC6U4qAOLE6Dt8f1trQsr8YzHbdI?=
 =?us-ascii?Q?uLbtnzAXnd1trELgrn3Gz7U/1lLr8VhmhoorUo4sc09OpjI3xL5M9dZ8Kexq?=
 =?us-ascii?Q?5tzc4Ee3dK2iAm6JEVjdrhGFryXjOl3xv+tt32sUdadD5wGEQeZ1cGxgmqDN?=
 =?us-ascii?Q?Wj+C5L9AzNW9sVfOqHJZx6in77IIC50rwX3LVlFUAOSQil2bowTSnui8LL/b?=
 =?us-ascii?Q?5e78fSewma4GuQ7JEv9cMR8etRd3zsSLaE+gliLsmIIqsy9bMYfKYqpgYm00?=
 =?us-ascii?Q?UmdsB4CIGLMXwMxy8Emh2OZyAchYT5P1xIcs4D1tLVpwr1ZL6I152W8zWRgf?=
 =?us-ascii?Q?w4K7If6Irr41y8h7tPHR65LvS5ogvSUIPdsBwyU9dWmzCQs3SwTqeHsNrzRB?=
 =?us-ascii?Q?Ytvze981XgN/aMG7ZgJ3DAlxmNFwXl5yRHpNRTo/9A3FGM80kTd0Q7cXU3uv?=
 =?us-ascii?Q?LvWwexTnPd6O+s24jfDDRV3GSY5SMhuIRi0AoN2CQV1jNiENCIw88aw78f4x?=
 =?us-ascii?Q?UIUXDVz6VnxWQN7gDHVNhBlJEWjiHKrK8AC67AaFnEz8aa+4opPPtohYcLqG?=
 =?us-ascii?Q?ID8DiYe/UKQUOgB/OBRDqlqY3OzxTWKyO5wx44HvYXnNsGYz4rPkxQKIb2Fv?=
 =?us-ascii?Q?Cem8J2dReIXa32ARo6HX1qNNh6PocoWB6/vgGYhhAWu9eARcBRkMucQpbGmK?=
 =?us-ascii?Q?UfNSEFXO+3HEfvlEP7SEKnwmSL4aOikjg9tMsvRKa6NcLrQODRZURyWA3MS/?=
 =?us-ascii?Q?bB9flGzJ7zO2Lz6bG4gj3Ds++rwt8GvrMMmIoeOJd/aRyHd0uneWugDpRSbB?=
 =?us-ascii?Q?C9/SY88HeC15gFOdUegKZ9AEgF6lu+IEtLf+tWD4pDkrIs/zZ2Nk8wyxYmno?=
 =?us-ascii?Q?wnPSOPR1od40e3pb/Hv+BsnXL19hyMbdlUKIU3Bw6EpMHk7ZBXwSHSBkVcTS?=
 =?us-ascii?Q?t4SOM291O8KkKkQ/oypzWcAfZFV+ceruNiNZZxvRqsSqQoDnWkG+WPm9jz0y?=
 =?us-ascii?Q?MOzqzpn/3Ew0eW1k2vo7ClHpKcX/zc0G6HzXpRDo9O1FNGi7ruUyQixG7fAL?=
 =?us-ascii?Q?Ky7CGv+c35hKL6x+P+LyJgrsRLOV3qzeAE2kzaqrGgzUlOG5A7HU2CY4l0Ju?=
 =?us-ascii?Q?uqEXm3DQHK9iotzKyv0bPE2LiYnzM82l6MNkDmE3k5LN2fRL9jXSy9/yd8mC?=
 =?us-ascii?Q?tqUAgBeHII3RAZtJdM0T55bevKZjONlUV2sNv0qGAXeskZ1TqE4ek5D1rW9x?=
 =?us-ascii?Q?eJQefJ+Xgped7GQcqwUQ8XAsHtbjxDpiVaz4iT2SOxrhbxq4IbfxNiML6+Qk?=
 =?us-ascii?Q?gftoNMrePXYvLhLuRcMGMVPaRRaWs0CbRtVIQy1KxWEi2yWM2ZztsnTGTQb6?=
 =?us-ascii?Q?T4N2refRSqOzlieSTEkjbyVtlCb7bndu/hIxzZvXrVzLt5H/Esjf+fBwjzWU?=
 =?us-ascii?Q?+Czs54F3BQPEKwY/BhwcB1MiWMvrTIMBc7lzMNgpYaIUcaDaqX/b5oeE7p0d?=
 =?us-ascii?Q?/8y8BI5wGhlwmHvLFxfnaJksc33Fv95uRIGqoTni?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7272d6-6feb-424a-6de2-08da5ef4175e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 02:06:08.3129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ofYZBDlfDWGI4JYxwMpVA9rmaMiVNVlOhDAwHa5aDa8Wvgn4GzvY0eLUgEbpVnbIKyt4vaPKPcHCb2L9pg5jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:32:58AM +0000, Zhang, Qiang1 wrote:
> On Thu, Jun 23, 2022 at 03:23:19AM +0000, Zhang, Qiang1 wrote:
> > On Wed, Jun 22, 2022 at 05:34:09PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 22, 2022 at 11:34:15PM +0000, Zhang, Qiang1 wrote:
> > > >=20
> > > > On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> > > > > In CONFIG_PREEMPT=3Dn and CONFIG_PREEMPT_COUNT=3Dy kernel, after =
a exp
> > > > > grace period begins, if detected current CPU enters idle in
> > > > > rcu_exp_handler() IPI handler, will immediately report the exp QS=
 of the
> > > > > current cpu, at this time, maybe not being in an RCU read-side cr=
itical
> > > > > section, but need wait until rcu-softirq or sched-clock irq or sc=
hed-switch
> > > > > occurs on current CPU to check and report exp QS.
> > > > >=20
> > > >=20
> > > > >I think the idea is OK, however, this "optimization" is based on t=
he
> > > > >implementation detail that rcu_read_lock() counts preempt_count wh=
en
> > > > >CONFIG_PREEMPT_COUNT=3Dy, right? It's a little bit dangerous becau=
se the
> > > > >preempt_count when CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn=
 is mostly
> > > > >for debugging purposes IIUC, and in other words, _it could be gone=
_.
> > > > >
> > > >=20
> > > > Yes, for CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn kernel
> > > > The rcu_read_lock/unlock are replaced by preempt_disbale/enable, an=
d the=20
> > > > preempt-count is exists,  so can report exp QS when not being an  R=
CU=20
> > > > read-side critical(preempt_count & (PREEMPT_MASK | SOFTIRQ_MASK )re=
turn zero).
> > > > in IPI handler.=20
> > > >=20
> > > > For CONFIG_PREEMPT_COUNT=3Dn and CONFIG_PREEMPT=3Dn kernel,=20
> > > > The rcu_read_lock/unlock is just barrier().=20
> > > >=20
> > > >=20
> > > > So I add IS_ENABLED(CONFIG_PREEMPT_COUNT) check in code.
> > > >=20
> > > > Of course, for CONFIG_PREEMPT_COUNT=3Dn  kernel, in RCU softirq, th=
e=20
> > > > preempt-count is also checked
> > > >=20
> > > > /* Report any deferred quiescent states if preemption enabled. */
> > > >  if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEM=
PT_MASK))) {
> > > >                  rcu_preempt_deferred_qs(current);
> > > >=20
> > > > but the RCU softirq may not be triggered in time and reported exp Q=
S, for
> > > > example a kernel loop exist on NO_HZ_FULL CPU
> > > >=20
> > > > this change, It is to capture the exp QS state earlier and report i=
t.
> > > >=20
> > > >=20
> > > > >Also I'm not aware of any but there could be someone assuming that=
 RCU
> > > > >read-side critical sections can be formed without
> > > > >rcu_read_{lock,unlock}() in CONFIG_PREEMPT=3Dn kernel. For example=
, there
> > > > >might be "creative" code like the following:
> > > > >
> > > > >	void do_something_only_in_nonpreempt(void)
> > > > >	{
> > > > >		int *p;
> > > > >
> > > > >		// This function only gets called in PREEMPT=3Dn kernel,
> > > > >		// which means everywhere is a RCU read-side critical
> > > > >		// section, let's save some lines of code.
> > > > >
> > > > 		rcu_read_lock();
> > > > >		p =3D rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
> > > > >		... // of course no schedule() here.
> > > > >		<access p>
> > > >                              rcu_read_unlock();
> > > > >	}
> > > > >
> > > >=20
> > > > Usually access to pointers of type rcu needs to be protected.
> >=20
> > Yes, _ususally_ they are, but what about the special cases? Because
> > in PREEMPT=3Dn kernel, almost everywhere is a RCU read-side critical
> > section, some one might have been "creative" enough to omit these
> > rcu_read_lock() and rcu_read_unlock().
> >=20
> > >=20
> > > Indeed, lockdep would normally complain about this sort of thing.
> > > But in kernels built with (say) CONFIG_PREEMPT_NONE=3Dy but without
> > > CONFIG_PREEMPT_COUNT=3DN, can lockdep really tell the difference?
> > >=20
> >=20
> > >Actually with the rcu_dereference_check() above, lockdep cannot detect
> > >even CONFIG_PREEMPT_COUNT=3Dy, that rcu_dereference_check() basically =
says
> > >"I know I'm in a read-side critical section if it's a non-preempt
> > >kernel, so don't bother to check". ;-)
> >=20
> > > > Any thoughts?
> > >=20
> > > It would be good to have some performance data on this change to expe=
dited
> > > grace periods.  It is adding code, so it needs some real motivation.
> >=20
> > I used rcuscale to test it, and  count the average time of writer-durat=
ion
> >=20
> > no applied patch(org.txt)
> > writer avg  time  29690.39     29670.78     29770.65       29423.25
> >=20
> > applied patch(new.txt)
> > writer avg time 28989.99       29003.54      29281.39       28986.58
> >=20
> > or Is there a better way to test?
>=20
> >If I understand your measurments correctly, you are getting about a 2%
> >improvement in expedited grace-period latency in !PREEMPT kernels.
> >Do we have a situation for which that 2% improvement is important?
>=20
> To be honest, it will also be affected by the work scheduling delay. Inde=
ed,=20
> my current test results are not very good, but it is beneficial to detect=
 the
> QS state in advance and report it in time. of course, I will do more test=
s in
> the future
>=20
> >We would be taking some risk due to the issues Boqun points out or we
> >would be adding some complexity to avoid those issues.  So this
>=20
> As for the code similar to the above scenario proposed by Boqun,=20
> it is true that lockdep will not complain, I do not deny that someone
> will write this way.
>=20
> If there really is such a situation as Boqun mentioned, There is also=20
> a risk in the following code segment in PREEMPT=3Dn and PREEMPT_COUNT=3Dy
>=20
>         /* Report any deferred quiescent states if preemption enabled. */
>         if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREE=
MPT_MASK)))
>                 rcu_preempt_deferred_qs(current);
>
>Fair point.
>
>I have applied the commit shown below.  Does that look correct?

Thanks, This description is sufficient.

>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>commit 9db96a8acda6837e5d4cd6a1cd7323709810e418
>Author: Zqiang <qiang1.zhang@intel.com>
>Date:   Tue Jul 5 12:09:51 2022 -0700
>
>    rcu: Add QS check in rcu_exp_handler() for non-preemptible kernels
>   =20
>    Kernels built with CONFIG_PREEMPTION=3Dn and CONFIG_PREEMPT_COUNT=3Dy =
maintain
>    preempt_count() state.  Because such kernels map __rcu_read_lock()
>    and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
>    respectively, this allows the expedited grace period's !CONFIG_PREEMPT=
_RCU
>    version of the rcu_exp_handler() IPI handler function to use
>    preempt_count() to detect quiescent states.
>   =20
>    This preempt_count() usage might seem to risk failures due to
>    use of implicit RCU readers in portions of the kernel under #ifndef
>    CONFIG_PREEMPTION, except that rcu_core() already disallows such impli=
cit
>    RCU readers.  The moral of this story is that you must use explicit
>    read-side markings such as rcu_read_lock() or preempt_disable() even i=
f
>    the code knows that this kernel does not support preemption.
>   =20
>    This commit therefore adds a preempt_count()-based check for a quiesce=
nt
>    state in the !CONFIG_PREEMPT_RCU version of the rcu_exp_handler()
>    function for kernels built with CONFIG_PREEMPT_COUNT=3Dy, reporting an
>    immediate quiescent state when the interrupted code had both preemptio=
n
>    and softirqs enabled.
>   =20
>    This change results in about a 2% reduction in expedited grace-period
>    latency in kernels built with both CONFIG_PREEMPT_RCU=3Dn and
>    CONFIG_PREEMPT_COUNT=3Dy.
>   =20
>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>    Link: https://lore.kernel.org/all/20220622103549.2840087-1-qiang1.zhan=
g@intel.com/
>
>diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>index be667583a5547..b07998159d1fa 100644
>--- a/kernel/rcu/tree_exp.h
>+++ b/kernel/rcu/tree_exp.h
>@@ -828,11 +828,13 @@ static void rcu_exp_handler(void *unused)
> {
> 	struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> 	struct rcu_node *rnp =3D rdp->mynode;
>+	bool preempt_bh_enabled =3D !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_=
MASK));
>=20
> 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
> 		return;
>-	if (rcu_is_cpu_rrupt_from_idle()) {
>+	if (rcu_is_cpu_rrupt_from_idle() ||
>+	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) && preempt_bh_enabled)) {
> 		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
> 		return;
> 	}
