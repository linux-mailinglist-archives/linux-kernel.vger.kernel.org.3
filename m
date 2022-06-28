Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5098A55C17B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiF1Edb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiF1EdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:33:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5D75F89;
        Mon, 27 Jun 2022 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656390788; x=1687926788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bkW0OhpUT0LpS1LN2FGDJqvIuZbDDjfoTsnpZKOsXuk=;
  b=UcYKh30H3x0P7K5tV8dd07WgcFCZ+OTZEQZan7vmZfsZYSAi44Y3s/cZ
   Vmvj7hbA2GkZn0jclNBx1/yWQvcaGdHL5cBhp+4YkGGrCmt+9g9QJ22lo
   SI3WMcSu1jowVznxeeuWvVqa4lae6ifqmDY78VTJYyt1NLjQ0UUd3MR49
   RXOizVfdeUpSzyRpbHwyYhFov8xyCpR/PT30g7WCA3p1f5gQBG8nkBGKG
   a3Goz0gOE2DY0umMlJpBCcr7aHcwaU3rU4vbmMuHi98rW7epv8LmKGgO1
   ZuF1Ns/UDytqABDR0iOy1Q4TSgwZicPory+2NqGQnmFK2LyAdbBGmQeTs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280390866"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="280390866"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646733862"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2022 21:33:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 21:33:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 21:33:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 21:33:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 21:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jelQCsMG949/doSxY11rSl8KuunV4l9sSk24ESE9Rz+gtpGkQNnRGv/B01EO4yAATw2cOtR1aOZru+UwOAmuDWzmUAYS4nGSsr/64uIc+1B9b0n+8JuqNfoYNaJiWLD+MifR7dBQxYUwcCGaN8RZDCZ6Y0UaW+DSdrSXr18aAmXtTpSP/07D4lq/ZSPCeQ625UALCosyMZ2YjEkppW4GFf86L+SwpieWSdrQ4MyaIY5ThLK8JM/7XG20Yv1MpZ4U4wDq6lHoWS3lDKvVNyMTAQ/zBHdjsLTBWW+W+V5jrjREtQL2VSn6m88z+a8ms1lkYJDtFur9gcEfOj7xJ0UCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/SBO72sIiJLMOcm8TbskcTV0EwWj9wUfJHv7BPtYY8=;
 b=FBY7xtv0k2EMFIu4Oq5AqV3zq6DcajB5/CFxHaVskm1JFwh8tF9A5Bd2t3JWy1Zz/HkUwVDXcgpG+Bf324KvL6hh1Bpaa1P4GYqYVDAcf7iJCmhv94pJ258pRV067B+lGr06OI7NsDzofyIApfPi6OoF1baGYZFeCW47HgePdL0xvNYH9R5FcBV0NfhHruAHw8ay7+o61GyxpFfFKL7z4/pH1BKpT/NvtRNmN2pc3+IYDjuxftEJIPPP0LUVwWv8LpiUeetkvIhg2l3bbkZl1UvG+cqP/AMImVEf+KTFCfEZLsEepp5pjDNbkuUNeWRVVRN1uShcZBf7wZFmx2HFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 04:32:59 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%6]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 04:32:58 +0000
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
Thread-Index: AQHYhiPvaZaZmWFjQEu0NBJYl75Ct61brf6AgABcGPCAABuJgIAAHHMAgAAOiNCAB4CAgIAAaaRQ
Date:   Tue, 28 Jun 2022 04:32:58 +0000
Message-ID: <PH0PR11MB5880C49AE26E587A029B43E3DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
 <YrNQpxjIiNpxwyQh@boqun-archlinux>
 <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220623003409.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrPM3ub+BGukLi+l@boqun-archlinux>
 <PH0PR11MB58800BA38E0691E2FB3AF552DAB59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220627214143.GP1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220627214143.GP1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: bbad398e-4ca9-40a8-bb10-08da58bf478e
x-ms-traffictypediagnostic: SA2PR11MB5084:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwYg/LrvtnCq6yPupajwa9cS1zx81oTiYW+AJEomPOhipvwzXtdhwnSGSg4x2XH1SqyljtNJ6WIE02GsWLvap8pt/UsRnczE1KUurgvVO8CzzwBYQmmJku1iV6cGFOqt57yCnPqC1xTfn6zIBITbWvCrG5nCXoLEY7Ux6WMRbbiMFesjvZLk8US4PeaoZs/QQ4pcf+1sffMNhMiaZuup52uj2qtNDJ676BR7tolo+kDmpNDoU9f03Y3PL/r+NJDdmxOKL/eEYYQXyt6EPJ7wstHNnKWWGDDwd3RrEAHmlkLM3WMMbO0PsuKne+d0uF88BJzA0m6ai3M2im2aj7TwhRkQu8GMXhmnbZSdIUERuQtb2+RVcJBYKBwyZHqtp4JxBZ7ntudlaI9GH7zPEgXTx8MFtBCudITXYFawoCjIo3ozk+mJildV/w3c/GwGJaaDavf9IeslbP93EaSi85Pr3of/QzbcOxuQmOyG95FjdDujwEmOgAb1mTRG39ITgKtgRv9QT0Ev6EB/tTb6BCn0AC37tEnDmuPdc5J3XKqyINA3IYjX7LgDCmgR/O+CnwYsujn0ZMBl+QAFViS/H7OiMiYmQMqWRZwhxNe0DMVHGSfu078LCBSFIo5g+HURniXFIBbWqFR5IPy50T1J75UbjgfXvGZoB6c3oHTdDhTscARGvr9+u/TE9ny+7J4KZaCPUOS/J+dnHn4EfKDQIuyXzaj/wDS+n6sp5MBGDaI930SrYAJsdPlaNqa1Bo37A+1nJlh9Fd25hqAYueieYfO7dmQ1u2cyUD2FgvR41F4pp7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(366004)(136003)(2906002)(55016003)(30864003)(86362001)(41300700001)(478600001)(76116006)(6506007)(38100700002)(66574015)(52536014)(64756008)(66476007)(66446008)(8676002)(4326008)(26005)(9686003)(66556008)(8936002)(5660300002)(122000001)(7696005)(71200400001)(6916009)(316002)(186003)(33656002)(82960400001)(54906003)(38070700005)(83380400001)(66946007)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dPGpNzdlrWtpwxKTAWnIOTtNLmd3FMfHCF8NHipWKgaaVUjvhuEUIUGqcnB?=
 =?us-ascii?Q?9jAaciYdxGfZJcYq+9/Lt0uHG3QcQBiWVoxw3QZvx6aH04rqTBh/ODWnJQ4L?=
 =?us-ascii?Q?DqAoDzN6i47NULlN2JhJ7o0whoo8+8qhYjrwTeeX9ZxWoIyDwNPw7qEYX8J5?=
 =?us-ascii?Q?IbBDk4TSQqAHknfhOi2qgxFBQD7h4r3R5naFnrivNzpKG6L0ms2nMOTrk5iD?=
 =?us-ascii?Q?CsHLMIXmjPr9igCCM0C9hnZoGED3laUbFx3fLCxLTezoBYpn/CGF3WzLdKU1?=
 =?us-ascii?Q?1AkQHmxJB79u5V4jaksQEro+Mhz6Zgf12yAEFok7pAgiDg9KiciUwX9e1uN2?=
 =?us-ascii?Q?76ZCT5aY2871yLYrHKtYRMDA6Oxo6Kkz4KMs1JOlblMh/A2DBqsJyTRxXNLC?=
 =?us-ascii?Q?uyFa0du5cevVJJNH0z8+wihIDrnHDtXoMUCkxlZvBZXCnsZtD4ppHhirX+0s?=
 =?us-ascii?Q?fmq1rfjdeeNA7wZAxOND4lhCYC9IIOg55o40pePsmDKPXi7Ce3XWjNIUegj4?=
 =?us-ascii?Q?O4mq1bPWBM0EndvUYfGexrFVFc3Eu+VKuR7G4dWY20LXlhn6O1TkisoSjE86?=
 =?us-ascii?Q?iSgHKbv/kZHUCAhm7Y75OH0HkiDtW0QynMD390tDRC2Xj2Lzg7Q44bqwZTJI?=
 =?us-ascii?Q?Hfj4DoefYYLu9XyVGu8Z/L5IOluuw0BUxULh97bISOINBIpWPZCXo9j+R8Pw?=
 =?us-ascii?Q?yJY3q1nFgRgTQFYJMRdFT8cAx24xJp2BbsYASql711iCqF2zIS3Dsz79kxpZ?=
 =?us-ascii?Q?awoTZ45OiaJLqExYYWjiBqRO3TLwXDOy0pOXd/9D5T138vdl41oZyel0FpzV?=
 =?us-ascii?Q?omaNGiWSSnTWNhceJxTX/a+gYi4xh0ofqjptEnmgQGGC1vfod8IN+MXg9mO7?=
 =?us-ascii?Q?d40OLHsJ1jPCEaiVoFWepraQFZBiskDV/WcRlIEwslaneqz2+3zLEF0TNgyJ?=
 =?us-ascii?Q?mYNjuc8xjgWdpeyFutgkVTGJHAIcfk5qrWMeqYEcihxVmE8ZSg0gd1/O24wJ?=
 =?us-ascii?Q?8X03AM/UQz4PHw9vMDpoDw4Yu0/k+4OoWaG1SAYRuZFkpd0Po3WjQdiCN4cs?=
 =?us-ascii?Q?fw+Z6bRVaRw25qO6ptA5geTN7VozSnq6YusM8/qx/Ymv0W48ia8Abtc9I3wr?=
 =?us-ascii?Q?Eh/sJvm1bC6G6cZJ4cllRi8K3Aa0bj4EcH1QvmdY8sTbUnTuaZaj7R97OUD5?=
 =?us-ascii?Q?WEpfhEbXtrHO/5RwAG/yx28iB02CPoWWs5ZapzDdPZdC3w4AMvwNq3rJZZZJ?=
 =?us-ascii?Q?WUsvMSlaK6EtD7bNsQtx18+iRvuRnFFz+VuJskCgpgXhqef8t302Bq0NOb6W?=
 =?us-ascii?Q?a8+VoG44ssUHgDSBJuoIkqkO6tmaPbi1SFqXzQpHa1p7lAxJsASMDS7J5OGk?=
 =?us-ascii?Q?hf8o/mTfqwzwzzcDgVFEL5hrmmuLOF8cNsmVdAdammzoaRvCG7nIZaq7V8Hi?=
 =?us-ascii?Q?RCQuqSVF1MneH/AqrmFkPaJuBgBzJ7eMasmFsWLKSHkHDj+PFgngCfOrzke5?=
 =?us-ascii?Q?BNjQujbMFLE4tlG3GgXZ8ShMGC5NG60f3Qwrg/bRsoeSpyiNqJMu2Z3liCQm?=
 =?us-ascii?Q?qdyrPFeLALptNes3CY3s57bKGCEAMsg9yMFCIKgw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbad398e-4ca9-40a8-bb10-08da58bf478e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 04:32:58.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZH1wiC2Uck5fOWOC3PKqNJaQjjQZQQU60ekayNqBieKekeNqaPg8BnUWgO4kD2MXU9gPU3FMyNL56hAwoqgiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
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

On Thu, Jun 23, 2022 at 03:23:19AM +0000, Zhang, Qiang1 wrote:
> On Wed, Jun 22, 2022 at 05:34:09PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 22, 2022 at 11:34:15PM +0000, Zhang, Qiang1 wrote:
> > >=20
> > > On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> > > > In CONFIG_PREEMPT=3Dn and CONFIG_PREEMPT_COUNT=3Dy kernel, after a =
exp
> > > > grace period begins, if detected current CPU enters idle in
> > > > rcu_exp_handler() IPI handler, will immediately report the exp QS o=
f the
> > > > current cpu, at this time, maybe not being in an RCU read-side crit=
ical
> > > > section, but need wait until rcu-softirq or sched-clock irq or sche=
d-switch
> > > > occurs on current CPU to check and report exp QS.
> > > >=20
> > >=20
> > > >I think the idea is OK, however, this "optimization" is based on the
> > > >implementation detail that rcu_read_lock() counts preempt_count when
> > > >CONFIG_PREEMPT_COUNT=3Dy, right? It's a little bit dangerous because=
 the
> > > >preempt_count when CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn i=
s mostly
> > > >for debugging purposes IIUC, and in other words, _it could be gone_.
> > > >
> > >=20
> > > Yes, for CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn kernel
> > > The rcu_read_lock/unlock are replaced by preempt_disbale/enable, and =
the=20
> > > preempt-count is exists,  so can report exp QS when not being an  RCU=
=20
> > > read-side critical(preempt_count & (PREEMPT_MASK | SOFTIRQ_MASK )retu=
rn zero).
> > > in IPI handler.=20
> > >=20
> > > For CONFIG_PREEMPT_COUNT=3Dn and CONFIG_PREEMPT=3Dn kernel,=20
> > > The rcu_read_lock/unlock is just barrier().=20
> > >=20
> > >=20
> > > So I add IS_ENABLED(CONFIG_PREEMPT_COUNT) check in code.
> > >=20
> > > Of course, for CONFIG_PREEMPT_COUNT=3Dn  kernel, in RCU softirq, the=
=20
> > > preempt-count is also checked
> > >=20
> > > /* Report any deferred quiescent states if preemption enabled. */
> > >  if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT=
_MASK))) {
> > >                  rcu_preempt_deferred_qs(current);
> > >=20
> > > but the RCU softirq may not be triggered in time and reported exp QS,=
 for
> > > example a kernel loop exist on NO_HZ_FULL CPU
> > >=20
> > > this change, It is to capture the exp QS state earlier and report it.
> > >=20
> > >=20
> > > >Also I'm not aware of any but there could be someone assuming that R=
CU
> > > >read-side critical sections can be formed without
> > > >rcu_read_{lock,unlock}() in CONFIG_PREEMPT=3Dn kernel. For example, =
there
> > > >might be "creative" code like the following:
> > > >
> > > >	void do_something_only_in_nonpreempt(void)
> > > >	{
> > > >		int *p;
> > > >
> > > >		// This function only gets called in PREEMPT=3Dn kernel,
> > > >		// which means everywhere is a RCU read-side critical
> > > >		// section, let's save some lines of code.
> > > >
> > > 		rcu_read_lock();
> > > >		p =3D rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
> > > >		... // of course no schedule() here.
> > > >		<access p>
> > >                              rcu_read_unlock();
> > > >	}
> > > >
> > >=20
> > > Usually access to pointers of type rcu needs to be protected.
>=20
> Yes, _ususally_ they are, but what about the special cases? Because
> in PREEMPT=3Dn kernel, almost everywhere is a RCU read-side critical
> section, some one might have been "creative" enough to omit these
> rcu_read_lock() and rcu_read_unlock().
>=20
> >=20
> > Indeed, lockdep would normally complain about this sort of thing.
> > But in kernels built with (say) CONFIG_PREEMPT_NONE=3Dy but without
> > CONFIG_PREEMPT_COUNT=3DN, can lockdep really tell the difference?
> >=20
>=20
> >Actually with the rcu_dereference_check() above, lockdep cannot detect
> >even CONFIG_PREEMPT_COUNT=3Dy, that rcu_dereference_check() basically sa=
ys
> >"I know I'm in a read-side critical section if it's a non-preempt
> >kernel, so don't bother to check". ;-)
>=20
> > > Any thoughts?
> >=20
> > It would be good to have some performance data on this change to expedi=
ted
> > grace periods.  It is adding code, so it needs some real motivation.
>=20
> I used rcuscale to test it, and  count the average time of writer-duratio=
n
>=20
> no applied patch(org.txt)
> writer avg  time  29690.39     29670.78     29770.65       29423.25
>=20
> applied patch(new.txt)
> writer avg time 28989.99       29003.54      29281.39       28986.58
>=20
> or Is there a better way to test?

>If I understand your measurments correctly, you are getting about a 2%
>improvement in expedited grace-period latency in !PREEMPT kernels.
>Do we have a situation for which that 2% improvement is important?

To be honest, it will also be affected by the work scheduling delay. Indeed=
,=20
my current test results are not very good, but it is beneficial to detect t=
he
QS state in advance and report it in time. of course, I will do more tests =
in
the future

>We would be taking some risk due to the issues Boqun points out or we
>would be adding some complexity to avoid those issues.  So this

As for the code similar to the above scenario proposed by Boqun,=20
it is true that lockdep will not complain, I do not deny that someone
will write this way.

If there really is such a situation as Boqun mentioned, There is also=20
a risk in the following code segment in PREEMPT=3Dn and PREEMPT_COUNT=3Dy

        /* Report any deferred quiescent states if preemption enabled. */
        if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMP=
T_MASK)))
                rcu_preempt_deferred_qs(current);


Thanks
Zqiang

>2% has a definite cost associated with it.
>
>What am I missing here?
>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
>=20
> >Agreed.
> >
> >Regards,
> >Boqun
>=20
> > So, does this change make a system-level difference in (say) expedited
> > RCU grace-period latency, and if so, under what conditions?
> >=20
> > 						Thanx, Paul
> >=20
> > > >Again, I'm not aware of any existing code that does this but we need=
 to
> > > >be sure.
> > > >
> > > >Regards,
> > > >Boqun
> > > >
> > > > This commit add a exp QS check in rcu_exp_handler(), when not being
> > > > in an RCU read-side critical section, report exp QS earlier.
> > > >=20
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > ---
> > > >  kernel/rcu/tree_exp.h | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index be667583a554..34f08267410f 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
> > > >  {
> > > >  	struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> > > >  	struct rcu_node *rnp =3D rdp->mynode;
> > > > +	bool preempt_bh_disabled =3D
> > > > +				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> > > > =20
> > > >  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> > > >  	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
> > > >  		return;
> > > > -	if (rcu_is_cpu_rrupt_from_idle()) {
> > > > +	if (rcu_is_cpu_rrupt_from_idle() ||
> > > > +			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {
> > > >  		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
> > > >  		return;
> > > >  	}
> > > > --=20
> > > > 2.25.1
> > > >=20

> [   28.907109] rcu-scale: rcu_scale_writer 3 has 100 measurements
> [   28.907133] rcu-scale: rcu_scale_writer 0 has 100 measurements
> [   28.907135] rcu-scale: rcu_scale_writer 1 has 100 measurements
> [   28.907138] rcu-scale: rcu_scale_writer 2 has 100 measurements
> [   28.917241] Dumping ftrace buffer:
> [   28.917256]    (ftrace buffer empty)
> [   28.917261] rcu-scale: Test complete
> [   49.336302] rcu-scale:!!! All grace periods expedited, no normal ones =
to measure!
> [   49.336329] rcu-torture: Stopping rcu_scale_reader task
> [   49.336340] rcu-torture: rcu_scale_reader is stopping
> [   49.336351] rcu-torture: Stopping rcu_scale_reader task
> [   49.336361] rcu-torture: rcu_scale_reader is stopping
> [   49.336370] rcu-torture: Stopping rcu_scale_reader task
> [   49.336405] rcu-torture: rcu_scale_reader is stopping
> [   49.336426] rcu-torture: Stopping rcu_scale_reader task
> [   49.336432] rcu-torture: rcu_scale_reader is stopping
> [   49.336443] rcu-torture: Stopping rcu_scale_writer task
> [   49.336450] rcu-torture: rcu_scale_writer is stopping
> [   49.336458] rcu-scale: writer 0 gps: 102
> [   49.336460] rcu-torture: Stopping rcu_scale_writer task
> [   49.336465] rcu-torture: rcu_scale_writer is stopping
> [   49.336517] rcu-scale: writer 1 gps: 102
> [   49.336519] rcu-torture: Stopping rcu_scale_writer task
> [   49.336524] rcu-torture: rcu_scale_writer is stopping
> [   49.336532] rcu-scale: writer 2 gps: 101
> [   49.336533] rcu-torture: Stopping rcu_scale_writer task
> [   49.336539] rcu-torture: rcu_scale_writer is stopping
> [   49.336546] rcu-scale: writer 3 gps: 102
> [   49.336548] rcu-scale: start: 28841772292 end: 28844718545 duration: 2=
946253 gps: 407 batches: 2
> [   49.336550] rcu-scale:    0 writer-duration:     0 25552
> [   49.339264] rcu-scale:    0 writer-duration:     1 42012
> [   49.339274] rcu-scale:    0 writer-duration:     2 24377
> [   49.339280] rcu-scale:    0 writer-duration:     3 34458
> [   49.339299] rcu-scale:    0 writer-duration:     4 27007
> [   49.339305] rcu-scale:    0 writer-duration:     5 36494
> [   49.339310] rcu-scale:    0 writer-duration:     6 24278
> [   49.339315] rcu-scale:    0 writer-duration:     7 29383
> [   49.339321] rcu-scale:    0 writer-duration:     8 26494
> [   49.339326] rcu-scale:    0 writer-duration:     9 35430
> [   49.339331] rcu-scale:    0 writer-duration:    10 23986
> [   49.339337] rcu-scale:    0 writer-duration:    11 28663
> [   49.339342] rcu-scale:    0 writer-duration:    12 26329
> [   49.339347] rcu-scale:    0 writer-duration:    13 35645
> [   49.339353] rcu-scale:    0 writer-duration:    14 23761
> [   49.339358] rcu-scale:    0 writer-duration:    15 28889
> [   49.339364] rcu-scale:    0 writer-duration:    16 26519
> [   49.339369] rcu-scale:    0 writer-duration:    17 35863
> [   49.339374] rcu-scale:    0 writer-duration:    18 23984
> [   49.339380] rcu-scale:    0 writer-duration:    19 28618
> [   49.339385] rcu-scale:    0 writer-duration:    20 26547
> [   49.339390] rcu-scale:    0 writer-duration:    21 35515
> [   49.339395] rcu-scale:    0 writer-duration:    22 23913
> [   49.339400] rcu-scale:    0 writer-duration:    23 28510
> [   49.339405] rcu-scale:    0 writer-duration:    24 26746
> [   49.339410] rcu-scale:    0 writer-duration:    25 35670
> [   49.339416] rcu-scale:    0 writer-duration:    26 23963
> [   49.339421] rcu-scale:    0 writer-duration:    27 28561
> [   49.339427] rcu-scale:    0 writer-duration:    28 26380
> [   49.339432] rcu-scale:    0 writer-duration:    29 36039
> [   49.339438] rcu-scale:    0 writer-duration:    30 24215
> [   49.339443] rcu-scale:    0 writer-duration:    31 28891
> [   49.339449] rcu-scale:    0 writer-duration:    32 26578
> [   49.339454] rcu-scale:    0 writer-duration:    33 40498
> [   49.339459] rcu-scale:    0 writer-duration:    34 24245
> [   49.339464] rcu-scale:    0 writer-duration:    35 29465
> [   49.339469] rcu-scale:    0 writer-duration:    36 26946
> [   49.339475] rcu-scale:    0 writer-duration:    37 35955
> [   49.339480] rcu-scale:    0 writer-duration:    38 24059
> [   49.339486] rcu-scale:    0 writer-duration:    39 28795
> [   49.339491] rcu-scale:    0 writer-duration:    40 26536
> [   49.339496] rcu-scale:    0 writer-duration:    41 35879
> [   49.339501] rcu-scale:    0 writer-duration:    42 24181
> [   49.339506] rcu-scale:    0 writer-duration:    43 28639
> [   49.339512] rcu-scale:    0 writer-duration:    44 26546
> [   49.339517] rcu-scale:    0 writer-duration:    45 35884
> [   49.339522] rcu-scale:    0 writer-duration:    46 23986
> [   49.339527] rcu-scale:    0 writer-duration:    47 28668
> [   49.339532] rcu-scale:    0 writer-duration:    48 26454
> [   49.339537] rcu-scale:    0 writer-duration:    49 35772
> [   49.339542] rcu-scale:    0 writer-duration:    50 23942
> [   49.339547] rcu-scale:    0 writer-duration:    51 28803
> [   49.339553] rcu-scale:    0 writer-duration:    52 26545
> [   49.339558] rcu-scale:    0 writer-duration:    53 35615
> [   49.339563] rcu-scale:    0 writer-duration:    54 23569
> [   49.339568] rcu-scale:    0 writer-duration:    55 28427
> [   49.339573] rcu-scale:    0 writer-duration:    56 26489
> [   49.339578] rcu-scale:    0 writer-duration:    57 35516
> [   49.339584] rcu-scale:    0 writer-duration:    58 23722
> [   49.339589] rcu-scale:    0 writer-duration:    59 28435
> [   49.339594] rcu-scale:    0 writer-duration:    60 26401
> [   49.339599] rcu-scale:    0 writer-duration:    61 35488
> [   49.339604] rcu-scale:    0 writer-duration:    62 23855
> [   49.339610] rcu-scale:    0 writer-duration:    63 28583
> [   49.339615] rcu-scale:    0 writer-duration:    64 26629
> [   49.339620] rcu-scale:    0 writer-duration:    65 36168
> [   49.339625] rcu-scale:    0 writer-duration:    66 24191
> [   49.339630] rcu-scale:    0 writer-duration:    67 28802
> [   49.339635] rcu-scale:    0 writer-duration:    68 32436
> [   49.339640] rcu-scale:    0 writer-duration:    69 38444
> [   49.339646] rcu-scale:    0 writer-duration:    70 24417
> [   49.339651] rcu-scale:    0 writer-duration:    71 29128
> [   49.339656] rcu-scale:    0 writer-duration:    72 26480
> [   49.339661] rcu-scale:    0 writer-duration:    73 35881
> [   49.339666] rcu-scale:    0 writer-duration:    74 24123
> [   49.339671] rcu-scale:    0 writer-duration:    75 28735
> [   49.339676] rcu-scale:    0 writer-duration:    76 26359
> [   49.339681] rcu-scale:    0 writer-duration:    77 35715
> [   49.339687] rcu-scale:    0 writer-duration:    78 24092
> [   49.339692] rcu-scale:    0 writer-duration:    79 28716
> [   49.339698] rcu-scale:    0 writer-duration:    80 26448
> [   49.339703] rcu-scale:    0 writer-duration:    81 35935
> [   49.339708] rcu-scale:    0 writer-duration:    82 23966
> [   49.339713] rcu-scale:    0 writer-duration:    83 28552
> [   49.339718] rcu-scale:    0 writer-duration:    84 26487
> [   49.339723] rcu-scale:    0 writer-duration:    85 35490
> [   49.339729] rcu-scale:    0 writer-duration:    86 23976
> [   49.339734] rcu-scale:    0 writer-duration:    87 28679
> [   49.339740] rcu-scale:    0 writer-duration:    88 26525
> [   49.339745] rcu-scale:    0 writer-duration:    89 35764
> [   49.339750] rcu-scale:    0 writer-duration:    90 24050
> [   49.339756] rcu-scale:    0 writer-duration:    91 28777
> [   49.339761] rcu-scale:    0 writer-duration:    92 26412
> [   49.339767] rcu-scale:    0 writer-duration:    93 35707
> [   49.339772] rcu-scale:    0 writer-duration:    94 23913
> [   49.339777] rcu-scale:    0 writer-duration:    95 28450
> [   49.339782] rcu-scale:    0 writer-duration:    96 26665
> [   49.339788] rcu-scale:    0 writer-duration:    97 35636
> [   49.339793] rcu-scale:    0 writer-duration:    98 23953
> [   49.339798] rcu-scale:    0 writer-duration:    99 28466
> [   49.339804] rcu-scale:    0 writer-duration:   100 26654
> [   49.341227] rcu-scale:    0 writer-duration:   101 225635
>=20
>=20
>=20
>=20
> [   49.341246] rcu-scale:    1 writer-duration:     0 27277
> [   49.343227] rcu-scale:    1 writer-duration:     1 34458
> [   49.343236] rcu-scale:    1 writer-duration:     2 27340
> [   49.343242] rcu-scale:    1 writer-duration:     3 41758
> [   49.343248] rcu-scale:    1 writer-duration:     4 24161
> [   49.343254] rcu-scale:    1 writer-duration:     5 29250
> [   49.343260] rcu-scale:    1 writer-duration:     6 26996
> [   49.343266] rcu-scale:    1 writer-duration:     7 36482
> [   49.343272] rcu-scale:    1 writer-duration:     8 23782
> [   49.343277] rcu-scale:    1 writer-duration:     9 28433
> [   49.343283] rcu-scale:    1 writer-duration:    10 26577
> [   49.343289] rcu-scale:    1 writer-duration:    11 35616
> [   49.343295] rcu-scale:    1 writer-duration:    12 23821
> [   49.343301] rcu-scale:    1 writer-duration:    13 28678
> [   49.343307] rcu-scale:    1 writer-duration:    14 26517
> [   49.343313] rcu-scale:    1 writer-duration:    15 35548
> [   49.343319] rcu-scale:    1 writer-duration:    16 24196
> [   49.343325] rcu-scale:    1 writer-duration:    17 28626
> [   49.343332] rcu-scale:    1 writer-duration:    18 26772
> [   49.343338] rcu-scale:    1 writer-duration:    19 35539
> [   49.343344] rcu-scale:    1 writer-duration:    20 23897
> [   49.343350] rcu-scale:    1 writer-duration:    21 28635
> [   49.343356] rcu-scale:    1 writer-duration:    22 26453
> [   49.343362] rcu-scale:    1 writer-duration:    23 35416
> [   49.343368] rcu-scale:    1 writer-duration:    24 24096
> [   49.343373] rcu-scale:    1 writer-duration:    25 28733
> [   49.343379] rcu-scale:    1 writer-duration:    26 26538
> [   49.343385] rcu-scale:    1 writer-duration:    27 35590
> [   49.343390] rcu-scale:    1 writer-duration:    28 23739
> [   49.343396] rcu-scale:    1 writer-duration:    29 29450
> [   49.343402] rcu-scale:    1 writer-duration:    30 26452
> [   49.343408] rcu-scale:    1 writer-duration:    31 35807
> [   49.343413] rcu-scale:    1 writer-duration:    32 24145
> [   49.343419] rcu-scale:    1 writer-duration:    33 33452
> [   49.343425] rcu-scale:    1 writer-duration:    34 26767
> [   49.343431] rcu-scale:    1 writer-duration:    35 36677
> [   49.343438] rcu-scale:    1 writer-duration:    36 24102
> [   49.343444] rcu-scale:    1 writer-duration:    37 28937
> [   49.343449] rcu-scale:    1 writer-duration:    38 26622
> [   49.343454] rcu-scale:    1 writer-duration:    39 35903
> [   49.343460] rcu-scale:    1 writer-duration:    40 23956
> [   49.343465] rcu-scale:    1 writer-duration:    41 28684
> [   49.343470] rcu-scale:    1 writer-duration:    42 26901
> [   49.343475] rcu-scale:    1 writer-duration:    43 35717
> [   49.343480] rcu-scale:    1 writer-duration:    44 23957
> [   49.343485] rcu-scale:    1 writer-duration:    45 28780
> [   49.343490] rcu-scale:    1 writer-duration:    46 26747
> [   49.343495] rcu-scale:    1 writer-duration:    47 35538
> [   49.343501] rcu-scale:    1 writer-duration:    48 23963
> [   49.343506] rcu-scale:    1 writer-duration:    49 28727
> [   49.343511] rcu-scale:    1 writer-duration:    50 26519
> [   49.343516] rcu-scale:    1 writer-duration:    51 35733
> [   49.343521] rcu-scale:    1 writer-duration:    52 24098
> [   49.343527] rcu-scale:    1 writer-duration:    53 28557
> [   49.343532] rcu-scale:    1 writer-duration:    54 26208
> [   49.343537] rcu-scale:    1 writer-duration:    55 35315
> [   49.343543] rcu-scale:    1 writer-duration:    56 23932
> [   49.343548] rcu-scale:    1 writer-duration:    57 28507
> [   49.343553] rcu-scale:    1 writer-duration:    58 26443
> [   49.343559] rcu-scale:    1 writer-duration:    59 35306
> [   49.343564] rcu-scale:    1 writer-duration:    60 23868
> [   49.343570] rcu-scale:    1 writer-duration:    61 28606
> [   49.343575] rcu-scale:    1 writer-duration:    62 26308
> [   49.343580] rcu-scale:    1 writer-duration:    63 35693
> [   49.343586] rcu-scale:    1 writer-duration:    64 23934
> [   49.343591] rcu-scale:    1 writer-duration:    65 29456
> [   49.343596] rcu-scale:    1 writer-duration:    66 26600
> [   49.343602] rcu-scale:    1 writer-duration:    67 35682
> [   49.343607] rcu-scale:    1 writer-duration:    68 29849
> [   49.343612] rcu-scale:    1 writer-duration:    69 31555
> [   49.343618] rcu-scale:    1 writer-duration:    70 26942
> [   49.343623] rcu-scale:    1 writer-duration:    71 36037
> [   49.343629] rcu-scale:    1 writer-duration:    72 23965
> [   49.343634] rcu-scale:    1 writer-duration:    73 28811
> [   49.343640] rcu-scale:    1 writer-duration:    74 26734
> [   49.343645] rcu-scale:    1 writer-duration:    75 35712
> [   49.343650] rcu-scale:    1 writer-duration:    76 23845
> [   49.343656] rcu-scale:    1 writer-duration:    77 28619
> [   49.343661] rcu-scale:    1 writer-duration:    78 26637
> [   49.343666] rcu-scale:    1 writer-duration:    79 35773
> [   49.343672] rcu-scale:    1 writer-duration:    80 23910
> [   49.343677] rcu-scale:    1 writer-duration:    81 28873
> [   49.343682] rcu-scale:    1 writer-duration:    82 26581
> [   49.343688] rcu-scale:    1 writer-duration:    83 35517
> [   49.343694] rcu-scale:    1 writer-duration:    84 23928
> [   49.343699] rcu-scale:    1 writer-duration:    85 28565
> [   49.343704] rcu-scale:    1 writer-duration:    86 26464
> [   49.343710] rcu-scale:    1 writer-duration:    87 35715
> [   49.343715] rcu-scale:    1 writer-duration:    88 23968
> [   49.343721] rcu-scale:    1 writer-duration:    89 28784
> [   49.343726] rcu-scale:    1 writer-duration:    90 26576
> [   49.343731] rcu-scale:    1 writer-duration:    91 35800
> [   49.343737] rcu-scale:    1 writer-duration:    92 23918
> [   49.343742] rcu-scale:    1 writer-duration:    93 28487
> [   49.343747] rcu-scale:    1 writer-duration:    94 26491
> [   49.343753] rcu-scale:    1 writer-duration:    95 35565
> [   49.343758] rcu-scale:    1 writer-duration:    96 24092
> [   49.343763] rcu-scale:    1 writer-duration:    97 28469
> [   49.343768] rcu-scale:    1 writer-duration:    98 26865
> [   49.343774] rcu-scale:    1 writer-duration:    99 35343
> [   49.343779] rcu-scale:    1 writer-duration:   100 23995
> [   49.345221] rcu-scale:    1 writer-duration:   101 60524
>=20
>=20
>=20
> [   49.345235] rcu-scale:    2 writer-duration:     0 56581
> [   49.347314] rcu-scale:    2 writer-duration:     1 32281
> [   49.347329] rcu-scale:    2 writer-duration:     2 29516
> [   49.347336] rcu-scale:    2 writer-duration:     3 29979
> [   49.347342] rcu-scale:    2 writer-duration:     4 36232
> [   49.347348] rcu-scale:    2 writer-duration:     5 26878
> [   49.347354] rcu-scale:    2 writer-duration:     6 29099
> [   49.347359] rcu-scale:    2 writer-duration:     7 24890
> [   49.347365] rcu-scale:    2 writer-duration:     8 35614
> [   49.347371] rcu-scale:    2 writer-duration:     9 26166
> [   49.347377] rcu-scale:    2 writer-duration:    10 28552
> [   49.347384] rcu-scale:    2 writer-duration:    11 24335
> [   49.347390] rcu-scale:    2 writer-duration:    12 35614
> [   49.347396] rcu-scale:    2 writer-duration:    13 25978
> [   49.347402] rcu-scale:    2 writer-duration:    14 28541
> [   49.347408] rcu-scale:    2 writer-duration:    15 24634
> [   49.347413] rcu-scale:    2 writer-duration:    16 35640
> [   49.347419] rcu-scale:    2 writer-duration:    17 26235
> [   49.347425] rcu-scale:    2 writer-duration:    18 28782
> [   49.347431] rcu-scale:    2 writer-duration:    19 24288
> [   49.347437] rcu-scale:    2 writer-duration:    20 35649
> [   49.347442] rcu-scale:    2 writer-duration:    21 25989
> [   49.347448] rcu-scale:    2 writer-duration:    22 28527
> [   49.347454] rcu-scale:    2 writer-duration:    23 24150
> [   49.347460] rcu-scale:    2 writer-duration:    24 35960
> [   49.347465] rcu-scale:    2 writer-duration:    25 26133
> [   49.347471] rcu-scale:    2 writer-duration:    26 28714
> [   49.347477] rcu-scale:    2 writer-duration:    27 24192
> [   49.347482] rcu-scale:    2 writer-duration:    28 35545
> [   49.347488] rcu-scale:    2 writer-duration:    29 26893
> [   49.347494] rcu-scale:    2 writer-duration:    30 28621
> [   49.347499] rcu-scale:    2 writer-duration:    31 24453
> [   49.347505] rcu-scale:    2 writer-duration:    32 35750
> [   49.347510] rcu-scale:    2 writer-duration:    33 31021
> [   49.347516] rcu-scale:    2 writer-duration:    34 29061
> [   49.347522] rcu-scale:    2 writer-duration:    35 25015
> [   49.347528] rcu-scale:    2 writer-duration:    36 36107
> [   49.347534] rcu-scale:    2 writer-duration:    37 26370
> [   49.347540] rcu-scale:    2 writer-duration:    38 28888
> [   49.347546] rcu-scale:    2 writer-duration:    39 24418
> [   49.347552] rcu-scale:    2 writer-duration:    40 35675
> [   49.347558] rcu-scale:    2 writer-duration:    41 26284
> [   49.347564] rcu-scale:    2 writer-duration:    42 28924
> [   49.347570] rcu-scale:    2 writer-duration:    43 24244
> [   49.347576] rcu-scale:    2 writer-duration:    44 35835
> [   49.347582] rcu-scale:    2 writer-duration:    45 26194
> [   49.347587] rcu-scale:    2 writer-duration:    46 29080
> [   49.347593] rcu-scale:    2 writer-duration:    47 24185
> [   49.347599] rcu-scale:    2 writer-duration:    48 35543
> [   49.347605] rcu-scale:    2 writer-duration:    49 26122
> [   49.347610] rcu-scale:    2 writer-duration:    50 28822
> [   49.347616] rcu-scale:    2 writer-duration:    51 24285
> [   49.347622] rcu-scale:    2 writer-duration:    52 35720
> [   49.347627] rcu-scale:    2 writer-duration:    53 26063
> [   49.347633] rcu-scale:    2 writer-duration:    54 28508
> [   49.347639] rcu-scale:    2 writer-duration:    55 24019
> [   49.347645] rcu-scale:    2 writer-duration:    56 35499
> [   49.347651] rcu-scale:    2 writer-duration:    57 26079
> [   49.347657] rcu-scale:    2 writer-duration:    58 28502
> [   49.347663] rcu-scale:    2 writer-duration:    59 24016
> [   49.347668] rcu-scale:    2 writer-duration:    60 35515
> [   49.347673] rcu-scale:    2 writer-duration:    61 26095
> [   49.347677] rcu-scale:    2 writer-duration:    62 28602
> [   49.347681] rcu-scale:    2 writer-duration:    63 24246
> [   49.347686] rcu-scale:    2 writer-duration:    64 35675
> [   49.347690] rcu-scale:    2 writer-duration:    65 26761
> [   49.347694] rcu-scale:    2 writer-duration:    66 28833
> [   49.347699] rcu-scale:    2 writer-duration:    67 24524
> [   49.347703] rcu-scale:    2 writer-duration:    68 43780
> [   49.347707] rcu-scale:    2 writer-duration:    69 26612
> [   49.347712] rcu-scale:    2 writer-duration:    70 29290
> [   49.347716] rcu-scale:    2 writer-duration:    71 24670
> [   49.347720] rcu-scale:    2 writer-duration:    72 35526
> [   49.347725] rcu-scale:    2 writer-duration:    73 26393
> [   49.347729] rcu-scale:    2 writer-duration:    74 28967
> [   49.347733] rcu-scale:    2 writer-duration:    75 24125
> [   49.347738] rcu-scale:    2 writer-duration:    76 35713
> [   49.347742] rcu-scale:    2 writer-duration:    77 26062
> [   49.347746] rcu-scale:    2 writer-duration:    78 28888
> [   49.347751] rcu-scale:    2 writer-duration:    79 24344
> [   49.347755] rcu-scale:    2 writer-duration:    80 35858
> [   49.347760] rcu-scale:    2 writer-duration:    81 26330
> [   49.347764] rcu-scale:    2 writer-duration:    82 28661
> [   49.347769] rcu-scale:    2 writer-duration:    83 24180
> [   49.347773] rcu-scale:    2 writer-duration:    84 35464
> [   49.347778] rcu-scale:    2 writer-duration:    85 25886
> [   49.347782] rcu-scale:    2 writer-duration:    86 28916
> [   49.347786] rcu-scale:    2 writer-duration:    87 24149
> [   49.347791] rcu-scale:    2 writer-duration:    88 35860
> [   49.347795] rcu-scale:    2 writer-duration:    89 26100
> [   49.347800] rcu-scale:    2 writer-duration:    90 28999
> [   49.347804] rcu-scale:    2 writer-duration:    91 24105
> [   49.347809] rcu-scale:    2 writer-duration:    92 35720
> [   49.347813] rcu-scale:    2 writer-duration:    93 26093
> [   49.347817] rcu-scale:    2 writer-duration:    94 28729
> [   49.347822] rcu-scale:    2 writer-duration:    95 24063
> [   49.347826] rcu-scale:    2 writer-duration:    96 35819
> [   49.347831] rcu-scale:    2 writer-duration:    97 26119
> [   49.347835] rcu-scale:    2 writer-duration:    98 28648
> [   49.347840] rcu-scale:    2 writer-duration:    99 24175
> [   49.347844] rcu-scale:    2 writer-duration:   100 34035
>=20
>=20
>=20
>=20
> [   49.349299] rcu-scale:    3 writer-duration:     0 26939
> [   49.351268] rcu-scale:    3 writer-duration:     1 27152
> [   49.351277] rcu-scale:    3 writer-duration:     2 30299
> [   49.351281] rcu-scale:    3 writer-duration:     3 36662
> [   49.351284] rcu-scale:    3 writer-duration:     4 31847
> [   49.351287] rcu-scale:    3 writer-duration:     5 29203
> [   49.351290] rcu-scale:    3 writer-duration:     6 24861
> [   49.351294] rcu-scale:    3 writer-duration:     7 36222
> [   49.351297] rcu-scale:    3 writer-duration:     8 26790
> [   49.351300] rcu-scale:    3 writer-duration:     9 28626
> [   49.351303] rcu-scale:    3 writer-duration:    10 24007
> [   49.351307] rcu-scale:    3 writer-duration:    11 35765
> [   49.351310] rcu-scale:    3 writer-duration:    12 26226
> [   49.351314] rcu-scale:    3 writer-duration:    13 28495
> [   49.351317] rcu-scale:    3 writer-duration:    14 24188
> [   49.351321] rcu-scale:    3 writer-duration:    15 35686
> [   49.351324] rcu-scale:    3 writer-duration:    16 26290
> [   49.351327] rcu-scale:    3 writer-duration:    17 28740
> [   49.351331] rcu-scale:    3 writer-duration:    18 24201
> [   49.351334] rcu-scale:    3 writer-duration:    19 36000
> [   49.351337] rcu-scale:    3 writer-duration:    20 25995
> [   49.351341] rcu-scale:    3 writer-duration:    21 28649
> [   49.351344] rcu-scale:    3 writer-duration:    22 24081
> [   49.351348] rcu-scale:    3 writer-duration:    23 35718
> [   49.351351] rcu-scale:    3 writer-duration:    24 26077
> [   49.351354] rcu-scale:    3 writer-duration:    25 28773
> [   49.351357] rcu-scale:    3 writer-duration:    26 24280
> [   49.351360] rcu-scale:    3 writer-duration:    27 35767
> [   49.351364] rcu-scale:    3 writer-duration:    28 25956
> [   49.351367] rcu-scale:    3 writer-duration:    29 28632
> [   49.351370] rcu-scale:    3 writer-duration:    30 24996
> [   49.351374] rcu-scale:    3 writer-duration:    31 35673
> [   49.351377] rcu-scale:    3 writer-duration:    32 26217
> [   49.351380] rcu-scale:    3 writer-duration:    33 28855
> [   49.351383] rcu-scale:    3 writer-duration:    34 28655
> [   49.351387] rcu-scale:    3 writer-duration:    35 36525
> [   49.351390] rcu-scale:    3 writer-duration:    36 27052
> [   49.351394] rcu-scale:    3 writer-duration:    37 28841
> [   49.351397] rcu-scale:    3 writer-duration:    38 24600
> [   49.351400] rcu-scale:    3 writer-duration:    39 35743
> [   49.351404] rcu-scale:    3 writer-duration:    40 26391
> [   49.351407] rcu-scale:    3 writer-duration:    41 28642
> [   49.351410] rcu-scale:    3 writer-duration:    42 24334
> [   49.351413] rcu-scale:    3 writer-duration:    43 36152
> [   49.351417] rcu-scale:    3 writer-duration:    44 26133
> [   49.351420] rcu-scale:    3 writer-duration:    45 28732
> [   49.351423] rcu-scale:    3 writer-duration:    46 24235
> [   49.351426] rcu-scale:    3 writer-duration:    47 36069
> [   49.351429] rcu-scale:    3 writer-duration:    48 25993
> [   49.351433] rcu-scale:    3 writer-duration:    49 28658
> [   49.351436] rcu-scale:    3 writer-duration:    50 24225
> [   49.351439] rcu-scale:    3 writer-duration:    51 35909
> [   49.351442] rcu-scale:    3 writer-duration:    52 26176
> [   49.351446] rcu-scale:    3 writer-duration:    53 28702
> [   49.351449] rcu-scale:    3 writer-duration:    54 24169
> [   49.351453] rcu-scale:    3 writer-duration:    55 35462
> [   49.351456] rcu-scale:    3 writer-duration:    56 25771
> [   49.351459] rcu-scale:    3 writer-duration:    57 28677
> [   49.351462] rcu-scale:    3 writer-duration:    58 24089
> [   49.351466] rcu-scale:    3 writer-duration:    59 35538
> [   49.351469] rcu-scale:    3 writer-duration:    60 25785
> [   49.351472] rcu-scale:    3 writer-duration:    61 28669
> [   49.351475] rcu-scale:    3 writer-duration:    62 24075
> [   49.351478] rcu-scale:    3 writer-duration:    63 35720
> [   49.351482] rcu-scale:    3 writer-duration:    64 26017
> [   49.351485] rcu-scale:    3 writer-duration:    65 28726
> [   49.351488] rcu-scale:    3 writer-duration:    66 24990
> [   49.351491] rcu-scale:    3 writer-duration:    67 35814
> [   49.351494] rcu-scale:    3 writer-duration:    68 26215
> [   49.351498] rcu-scale:    3 writer-duration:    69 34468
> [   49.351501] rcu-scale:    3 writer-duration:    70 27200
> [   49.351504] rcu-scale:    3 writer-duration:    71 36288
> [   49.351507] rcu-scale:    3 writer-duration:    72 26445
> [   49.351511] rcu-scale:    3 writer-duration:    73 28593
> [   49.351514] rcu-scale:    3 writer-duration:    74 24317
> [   49.351517] rcu-scale:    3 writer-duration:    75 36153
> [   49.351521] rcu-scale:    3 writer-duration:    76 26164
> [   49.351524] rcu-scale:    3 writer-duration:    77 28523
> [   49.351527] rcu-scale:    3 writer-duration:    78 24252
> [   49.351530] rcu-scale:    3 writer-duration:    79 35939
> [   49.351533] rcu-scale:    3 writer-duration:    80 26058
> [   49.351536] rcu-scale:    3 writer-duration:    81 28892
> [   49.351540] rcu-scale:    3 writer-duration:    82 24342
> [   49.351543] rcu-scale:    3 writer-duration:    83 35751
> [   49.351546] rcu-scale:    3 writer-duration:    84 25932
> [   49.351549] rcu-scale:    3 writer-duration:    85 28682
> [   49.351552] rcu-scale:    3 writer-duration:    86 24086
> [   49.351555] rcu-scale:    3 writer-duration:    87 35791
> [   49.351559] rcu-scale:    3 writer-duration:    88 26189
> [   49.351562] rcu-scale:    3 writer-duration:    89 28754
> [   49.351565] rcu-scale:    3 writer-duration:    90 24250
> [   49.351568] rcu-scale:    3 writer-duration:    91 35768
> [   49.351572] rcu-scale:    3 writer-duration:    92 26160
> [   49.351575] rcu-scale:    3 writer-duration:    93 28896
> [   49.351578] rcu-scale:    3 writer-duration:    94 24020
> [   49.351581] rcu-scale:    3 writer-duration:    95 35727
> [   49.351584] rcu-scale:    3 writer-duration:    96 26099
> [   49.351587] rcu-scale:    3 writer-duration:    97 28768
> [   49.351590] rcu-scale:    3 writer-duration:    98 24011
> [   49.351593] rcu-scale:    3 writer-duration:    99 35786
> [   49.351597] rcu-scale:    3 writer-duration:   100 25989
> [   49.353257] rcu-scale:    3 writer-duration:   101 46411
>=20
>=20

> [   47.850402] rcu-scale: rcu_scale_writer 3 has 100 measurements
> [   47.850427] rcu-scale: rcu_scale_writer 0 has 100 measurements
> [   47.850429] rcu-scale: rcu_scale_writer 1 has 100 measurements
> [   47.850432] rcu-scale: rcu_scale_writer 2 has 100 measurements
> [   47.861470] Dumping ftrace buffer:
> [   47.861486]    (ftrace buffer empty)
> [   47.861491] rcu-scale: Test complete
> [   63.668029] rcu-scale:!!! All grace periods expedited, no normal ones =
to measure!
> [   63.668051] rcu-torture: Stopping rcu_scale_reader task
> [   63.668074] rcu-torture: rcu_scale_reader is stopping
> [   63.668089] rcu-torture: Stopping rcu_scale_reader task
> [   63.668138] rcu-torture: rcu_scale_reader is stopping
> [   63.668151] rcu-torture: Stopping rcu_scale_reader task
> [   63.668191] rcu-torture: rcu_scale_reader is stopping
> [   63.668204] rcu-torture: Stopping rcu_scale_reader task
> [   63.668209] rcu-torture: rcu_scale_reader is stopping
> [   63.668231] rcu-torture: Stopping rcu_scale_writer task
> [   63.668241] rcu-torture: rcu_scale_writer is stopping
> [   63.668249] rcu-scale: writer 0 gps: 102
> [   63.668251] rcu-torture: Stopping rcu_scale_writer task
> [   63.668260] rcu-torture: rcu_scale_writer is stopping
> [   63.668268] rcu-scale: writer 1 gps: 102
> [   63.668270] rcu-torture: Stopping rcu_scale_writer task
> [   63.668279] rcu-torture: rcu_scale_writer is stopping
> [   63.668287] rcu-scale: writer 2 gps: 101
> [   63.668288] rcu-torture: Stopping rcu_scale_writer task
> [   63.668293] rcu-torture: rcu_scale_writer is stopping
> [   63.668310] rcu-scale: writer 3 gps: 102
> [   63.668311] rcu-scale: start: 47784890510 end: 47787901801 duration: 3=
011291 gps: 407 batches: 2
> [   63.668314] rcu-scale:    0 writer-duration:     0 55830
> [   63.669543] rcu-scale:    0 writer-duration:     1 40421
> [   63.669546] rcu-scale:    0 writer-duration:     2 25268
> [   63.669548] rcu-scale:    0 writer-duration:     3 32703
> [   63.669549] rcu-scale:    0 writer-duration:     4 28624
> [   63.669550] rcu-scale:    0 writer-duration:     5 36967
> [   63.669551] rcu-scale:    0 writer-duration:     6 24686
> [   63.669552] rcu-scale:    0 writer-duration:     7 29598
> [   63.669554] rcu-scale:    0 writer-duration:     8 27026
> [   63.669555] rcu-scale:    0 writer-duration:     9 38789
> [   63.669556] rcu-scale:    0 writer-duration:    10 24398
> [   63.669557] rcu-scale:    0 writer-duration:    11 29562
> [   63.669559] rcu-scale:    0 writer-duration:    12 27348
> [   63.669560] rcu-scale:    0 writer-duration:    13 36315
> [   63.669561] rcu-scale:    0 writer-duration:    14 24233
> [   63.669562] rcu-scale:    0 writer-duration:    15 29035
> [   63.669564] rcu-scale:    0 writer-duration:    16 26754
> [   63.669606] rcu-scale:    0 writer-duration:    17 36272
> [   63.669608] rcu-scale:    0 writer-duration:    18 24237
> [   63.669609] rcu-scale:    0 writer-duration:    19 28834
> [   63.669610] rcu-scale:    0 writer-duration:    20 26993
> [   63.669611] rcu-scale:    0 writer-duration:    21 36432
> [   63.669612] rcu-scale:    0 writer-duration:    22 24178
> [   63.669614] rcu-scale:    0 writer-duration:    23 28838
> [   63.669615] rcu-scale:    0 writer-duration:    24 26733
> [   63.669616] rcu-scale:    0 writer-duration:    25 36087
> [   63.669617] rcu-scale:    0 writer-duration:    26 24237
> [   63.669618] rcu-scale:    0 writer-duration:    27 28656
> [   63.669620] rcu-scale:    0 writer-duration:    28 26921
> [   63.669621] rcu-scale:    0 writer-duration:    29 36423
> [   63.669622] rcu-scale:    0 writer-duration:    30 24201
> [   63.669623] rcu-scale:    0 writer-duration:    31 28748
> [   63.669625] rcu-scale:    0 writer-duration:    32 31925
> [   63.669626] rcu-scale:    0 writer-duration:    33 36673
> [   63.669627] rcu-scale:    0 writer-duration:    34 24630
> [   63.669628] rcu-scale:    0 writer-duration:    35 29033
> [   63.669629] rcu-scale:    0 writer-duration:    36 26761
> [   63.669631] rcu-scale:    0 writer-duration:    37 36495
> [   63.669632] rcu-scale:    0 writer-duration:    38 24209
> [   63.669633] rcu-scale:    0 writer-duration:    39 29468
> [   63.669634] rcu-scale:    0 writer-duration:    40 27137
> [   63.669635] rcu-scale:    0 writer-duration:    41 36193
> [   63.669637] rcu-scale:    0 writer-duration:    42 24531
> [   63.669638] rcu-scale:    0 writer-duration:    43 29113
> [   63.669639] rcu-scale:    0 writer-duration:    44 26915
> [   63.669640] rcu-scale:    0 writer-duration:    45 36394
> [   63.669642] rcu-scale:    0 writer-duration:    46 24247
> [   63.669643] rcu-scale:    0 writer-duration:    47 28823
> [   63.669644] rcu-scale:    0 writer-duration:    48 27029
> [   63.669645] rcu-scale:    0 writer-duration:    49 36042
> [   63.669646] rcu-scale:    0 writer-duration:    50 24164
> [   63.669648] rcu-scale:    0 writer-duration:    51 28972
> [   63.669649] rcu-scale:    0 writer-duration:    52 26858
> [   63.669650] rcu-scale:    0 writer-duration:    53 36319
> [   63.669651] rcu-scale:    0 writer-duration:    54 24233
> [   63.669652] rcu-scale:    0 writer-duration:    55 28986
> [   63.669654] rcu-scale:    0 writer-duration:    56 26895
> [   63.669655] rcu-scale:    0 writer-duration:    57 36213
> [   63.669656] rcu-scale:    0 writer-duration:    58 24156
> [   63.669657] rcu-scale:    0 writer-duration:    59 28859
> [   63.669658] rcu-scale:    0 writer-duration:    60 26917
> [   63.669660] rcu-scale:    0 writer-duration:    61 36174
> [   63.669661] rcu-scale:    0 writer-duration:    62 24237
> [   63.669662] rcu-scale:    0 writer-duration:    63 28873
> [   63.669663] rcu-scale:    0 writer-duration:    64 27045
> [   63.669664] rcu-scale:    0 writer-duration:    65 36167
> [   63.669666] rcu-scale:    0 writer-duration:    66 29556
> [   63.669667] rcu-scale:    0 writer-duration:    67 28900
> [   63.669668] rcu-scale:    0 writer-duration:    68 27072
> [   63.669669] rcu-scale:    0 writer-duration:    69 36733
> [   63.669670] rcu-scale:    0 writer-duration:    70 24327
> [   63.669672] rcu-scale:    0 writer-duration:    71 28842
> [   63.669673] rcu-scale:    0 writer-duration:    72 27027
> [   63.669674] rcu-scale:    0 writer-duration:    73 36228
> [   63.669675] rcu-scale:    0 writer-duration:    74 24137
> [   63.669677] rcu-scale:    0 writer-duration:    75 29924
> [   63.669678] rcu-scale:    0 writer-duration:    76 26775
> [   63.669679] rcu-scale:    0 writer-duration:    77 36300
> [   63.669680] rcu-scale:    0 writer-duration:    78 24547
> [   63.669681] rcu-scale:    0 writer-duration:    79 28852
> [   63.669683] rcu-scale:    0 writer-duration:    80 26945
> [   63.669684] rcu-scale:    0 writer-duration:    81 36127
> [   63.669685] rcu-scale:    0 writer-duration:    82 24373
> [   63.669686] rcu-scale:    0 writer-duration:    83 28853
> [   63.669687] rcu-scale:    0 writer-duration:    84 26652
> [   63.669689] rcu-scale:    0 writer-duration:    85 35952
> [   63.669690] rcu-scale:    0 writer-duration:    86 24379
> [   63.669691] rcu-scale:    0 writer-duration:    87 28948
> [   63.669692] rcu-scale:    0 writer-duration:    88 26958
> [   63.669693] rcu-scale:    0 writer-duration:    89 36302
> [   63.669695] rcu-scale:    0 writer-duration:    90 24181
> [   63.669696] rcu-scale:    0 writer-duration:    91 29120
> [   63.669697] rcu-scale:    0 writer-duration:    92 27032
> [   63.669698] rcu-scale:    0 writer-duration:    93 36083
> [   63.669699] rcu-scale:    0 writer-duration:    94 24248
> [   63.669701] rcu-scale:    0 writer-duration:    95 29205
> [   63.669702] rcu-scale:    0 writer-duration:    96 26577
> [   63.669703] rcu-scale:    0 writer-duration:    97 36187
> [   63.669704] rcu-scale:    0 writer-duration:    98 24472
> [   63.669705] rcu-scale:    0 writer-duration:    99 28883
> [   63.669707] rcu-scale:    0 writer-duration:   100 31999
> [   63.671532] rcu-scale:    0 writer-duration:   101 48271
>=20
>=20
> [   63.671556] rcu-scale:    1 writer-duration:     0 53537
> [   63.673442] rcu-scale:    1 writer-duration:     1 33311
> [   63.673451] rcu-scale:    1 writer-duration:     2 28033
> [   63.673457] rcu-scale:    1 writer-duration:     3 40200
> [   63.673464] rcu-scale:    1 writer-duration:     4 25479
> [   63.673470] rcu-scale:    1 writer-duration:     5 29908
> [   63.673475] rcu-scale:    1 writer-duration:     6 27336
> [   63.673481] rcu-scale:    1 writer-duration:     7 36948
> [   63.673487] rcu-scale:    1 writer-duration:     8 24216
> [   63.673494] rcu-scale:    1 writer-duration:     9 31639
> [   63.673499] rcu-scale:    1 writer-duration:    10 27175
> [   63.673506] rcu-scale:    1 writer-duration:    11 36695
> [   63.673512] rcu-scale:    1 writer-duration:    12 24609
> [   63.673518] rcu-scale:    1 writer-duration:    13 29140
> [   63.673524] rcu-scale:    1 writer-duration:    14 26955
> [   63.673530] rcu-scale:    1 writer-duration:    15 36122
> [   63.673535] rcu-scale:    1 writer-duration:    16 24236
> [   63.673541] rcu-scale:    1 writer-duration:    17 29137
> [   63.673546] rcu-scale:    1 writer-duration:    18 26766
> [   63.673552] rcu-scale:    1 writer-duration:    19 36207
> [   63.673558] rcu-scale:    1 writer-duration:    20 24215
> [   63.673563] rcu-scale:    1 writer-duration:    21 29239
> [   63.673569] rcu-scale:    1 writer-duration:    22 26866
> [   63.673575] rcu-scale:    1 writer-duration:    23 36054
> [   63.673581] rcu-scale:    1 writer-duration:    24 24012
> [   63.673586] rcu-scale:    1 writer-duration:    25 28914
> [   63.673592] rcu-scale:    1 writer-duration:    26 26891
> [   63.673597] rcu-scale:    1 writer-duration:    27 36102
> [   63.673603] rcu-scale:    1 writer-duration:    28 24039
> [   63.673609] rcu-scale:    1 writer-duration:    29 29125
> [   63.673614] rcu-scale:    1 writer-duration:    30 26926
> [   63.673620] rcu-scale:    1 writer-duration:    31 40754
> [   63.673625] rcu-scale:    1 writer-duration:    32 24519
> [   63.673631] rcu-scale:    1 writer-duration:    33 29397
> [   63.673637] rcu-scale:    1 writer-duration:    34 27267
> [   63.673642] rcu-scale:    1 writer-duration:    35 36358
> [   63.673648] rcu-scale:    1 writer-duration:    36 24007
> [   63.673654] rcu-scale:    1 writer-duration:    37 29326
> [   63.673659] rcu-scale:    1 writer-duration:    38 26854
> [   63.673665] rcu-scale:    1 writer-duration:    39 36625
> [   63.673671] rcu-scale:    1 writer-duration:    40 24437
> [   63.673676] rcu-scale:    1 writer-duration:    41 29314
> [   63.673682] rcu-scale:    1 writer-duration:    42 26955
> [   63.673688] rcu-scale:    1 writer-duration:    43 36415
> [   63.673693] rcu-scale:    1 writer-duration:    44 24098
> [   63.673699] rcu-scale:    1 writer-duration:    45 29216
> [   63.673705] rcu-scale:    1 writer-duration:    46 26904
> [   63.673710] rcu-scale:    1 writer-duration:    47 36286
> [   63.673716] rcu-scale:    1 writer-duration:    48 24127
> [   63.673722] rcu-scale:    1 writer-duration:    49 28887
> [   63.673727] rcu-scale:    1 writer-duration:    50 26894
> [   63.673733] rcu-scale:    1 writer-duration:    51 36145
> [   63.673739] rcu-scale:    1 writer-duration:    52 24238
> [   63.673745] rcu-scale:    1 writer-duration:    53 29136
> [   63.673750] rcu-scale:    1 writer-duration:    54 26895
> [   63.673756] rcu-scale:    1 writer-duration:    55 36087
> [   63.673761] rcu-scale:    1 writer-duration:    56 24215
> [   63.673767] rcu-scale:    1 writer-duration:    57 29034
> [   63.673773] rcu-scale:    1 writer-duration:    58 26817
> [   63.673778] rcu-scale:    1 writer-duration:    59 36069
> [   63.673784] rcu-scale:    1 writer-duration:    60 24255
> [   63.673790] rcu-scale:    1 writer-duration:    61 29004
> [   63.673795] rcu-scale:    1 writer-duration:    62 26878
> [   63.673801] rcu-scale:    1 writer-duration:    63 36186
> [   63.673806] rcu-scale:    1 writer-duration:    64 24355
> [   63.673812] rcu-scale:    1 writer-duration:    65 28884
> [   63.673818] rcu-scale:    1 writer-duration:    66 32061
> [   63.673823] rcu-scale:    1 writer-duration:    67 36261
> [   63.673829] rcu-scale:    1 writer-duration:    68 24453
> [   63.673835] rcu-scale:    1 writer-duration:    69 29508
> [   63.673840] rcu-scale:    1 writer-duration:    70 27004
> [   63.673846] rcu-scale:    1 writer-duration:    71 36240
> [   63.673851] rcu-scale:    1 writer-duration:    72 23958
> [   63.673857] rcu-scale:    1 writer-duration:    73 29276
> [   63.673863] rcu-scale:    1 writer-duration:    74 26793
> [   63.673868] rcu-scale:    1 writer-duration:    75 36779
> [   63.673874] rcu-scale:    1 writer-duration:    76 24462
> [   63.673880] rcu-scale:    1 writer-duration:    77 29156
> [   63.673885] rcu-scale:    1 writer-duration:    78 27128
> [   63.673891] rcu-scale:    1 writer-duration:    79 36182
> [   63.673896] rcu-scale:    1 writer-duration:    80 24073
> [   63.673902] rcu-scale:    1 writer-duration:    81 28955
> [   63.673908] rcu-scale:    1 writer-duration:    82 27009
> [   63.673914] rcu-scale:    1 writer-duration:    83 36169
> [   63.673919] rcu-scale:    1 writer-duration:    84 23906
> [   63.673925] rcu-scale:    1 writer-duration:    85 28946
> [   63.673931] rcu-scale:    1 writer-duration:    86 26866
> [   63.673937] rcu-scale:    1 writer-duration:    87 36249
> [   63.673942] rcu-scale:    1 writer-duration:    88 24096
> [   63.673948] rcu-scale:    1 writer-duration:    89 29290
> [   63.673954] rcu-scale:    1 writer-duration:    90 26844
> [   63.673959] rcu-scale:    1 writer-duration:    91 36353
> [   63.673965] rcu-scale:    1 writer-duration:    92 24166
> [   63.673971] rcu-scale:    1 writer-duration:    93 29072
> [   63.673976] rcu-scale:    1 writer-duration:    94 26862
> [   63.673982] rcu-scale:    1 writer-duration:    95 36348
> [   63.673988] rcu-scale:    1 writer-duration:    96 23907
> [   63.673993] rcu-scale:    1 writer-duration:    97 29122
> [   63.673999] rcu-scale:    1 writer-duration:    98 27072
> [   63.674004] rcu-scale:    1 writer-duration:    99 36188
> [   63.674010] rcu-scale:    1 writer-duration:   100 29125
> [   63.675441] rcu-scale:    1 writer-duration:   101 48063
>=20
>=20
>=20
> [   63.675458] rcu-scale:    2 writer-duration:     0 65839
> [   63.677455] rcu-scale:    2 writer-duration:     1 30102
> [   63.677470] rcu-scale:    2 writer-duration:     2 30481
> [   63.677477] rcu-scale:    2 writer-duration:     3 28129
> [   63.677483] rcu-scale:    2 writer-duration:     4 37897
> [   63.677489] rcu-scale:    2 writer-duration:     5 27420
> [   63.677496] rcu-scale:    2 writer-duration:     6 29475
> [   63.677501] rcu-scale:    2 writer-duration:     7 25128
> [   63.677507] rcu-scale:    2 writer-duration:     8 36449
> [   63.677512] rcu-scale:    2 writer-duration:     9 29093
> [   63.677518] rcu-scale:    2 writer-duration:    10 29369
> [   63.677524] rcu-scale:    2 writer-duration:    11 24938
> [   63.677530] rcu-scale:    2 writer-duration:    12 36634
> [   63.677535] rcu-scale:    2 writer-duration:    13 26628
> [   63.677541] rcu-scale:    2 writer-duration:    14 29116
> [   63.677547] rcu-scale:    2 writer-duration:    15 24320
> [   63.677552] rcu-scale:    2 writer-duration:    16 36351
> [   63.677558] rcu-scale:    2 writer-duration:    17 26613
> [   63.677564] rcu-scale:    2 writer-duration:    18 29039
> [   63.677570] rcu-scale:    2 writer-duration:    19 24353
> [   63.677575] rcu-scale:    2 writer-duration:    20 36335
> [   63.677581] rcu-scale:    2 writer-duration:    21 26706
> [   63.677587] rcu-scale:    2 writer-duration:    22 29200
> [   63.677592] rcu-scale:    2 writer-duration:    23 24211
> [   63.677598] rcu-scale:    2 writer-duration:    24 36036
> [   63.677604] rcu-scale:    2 writer-duration:    25 26464
> [   63.677610] rcu-scale:    2 writer-duration:    26 29181
> [   63.677616] rcu-scale:    2 writer-duration:    27 24021
> [   63.677621] rcu-scale:    2 writer-duration:    28 36169
> [   63.677627] rcu-scale:    2 writer-duration:    29 26697
> [   63.677633] rcu-scale:    2 writer-duration:    30 29213
> [   63.677638] rcu-scale:    2 writer-duration:    31 24181
> [   63.677644] rcu-scale:    2 writer-duration:    32 41287
> [   63.677650] rcu-scale:    2 writer-duration:    33 27016
> [   63.677656] rcu-scale:    2 writer-duration:    34 29455
> [   63.677662] rcu-scale:    2 writer-duration:    35 24571
> [   63.677667] rcu-scale:    2 writer-duration:    36 36144
> [   63.677673] rcu-scale:    2 writer-duration:    37 26673
> [   63.677678] rcu-scale:    2 writer-duration:    38 29031
> [   63.677684] rcu-scale:    2 writer-duration:    39 25127
> [   63.677690] rcu-scale:    2 writer-duration:    40 36453
> [   63.677695] rcu-scale:    2 writer-duration:    41 26455
> [   63.677701] rcu-scale:    2 writer-duration:    42 29460
> [   63.677707] rcu-scale:    2 writer-duration:    43 24698
> [   63.677712] rcu-scale:    2 writer-duration:    44 36093
> [   63.677718] rcu-scale:    2 writer-duration:    45 26573
> [   63.677723] rcu-scale:    2 writer-duration:    46 29157
> [   63.677729] rcu-scale:    2 writer-duration:    47 24356
> [   63.677735] rcu-scale:    2 writer-duration:    48 36504
> [   63.677741] rcu-scale:    2 writer-duration:    49 26157
> [   63.677746] rcu-scale:    2 writer-duration:    50 29103
> [   63.677752] rcu-scale:    2 writer-duration:    51 24577
> [   63.677758] rcu-scale:    2 writer-duration:    52 36218
> [   63.677763] rcu-scale:    2 writer-duration:    53 26553
> [   63.677769] rcu-scale:    2 writer-duration:    54 29224
> [   63.677775] rcu-scale:    2 writer-duration:    55 24290
> [   63.677780] rcu-scale:    2 writer-duration:    56 36322
> [   63.677786] rcu-scale:    2 writer-duration:    57 26509
> [   63.677792] rcu-scale:    2 writer-duration:    58 28951
> [   63.677797] rcu-scale:    2 writer-duration:    59 24316
> [   63.677803] rcu-scale:    2 writer-duration:    60 36402
> [   63.677809] rcu-scale:    2 writer-duration:    61 26453
> [   63.677814] rcu-scale:    2 writer-duration:    62 29023
> [   63.677820] rcu-scale:    2 writer-duration:    63 24538
> [   63.677826] rcu-scale:    2 writer-duration:    64 36279
> [   63.677831] rcu-scale:    2 writer-duration:    65 26277
> [   63.677837] rcu-scale:    2 writer-duration:    66 34442
> [   63.677843] rcu-scale:    2 writer-duration:    67 24564
> [   63.677849] rcu-scale:    2 writer-duration:    68 36429
> [   63.677855] rcu-scale:    2 writer-duration:    69 27018
> [   63.677861] rcu-scale:    2 writer-duration:    70 29207
> [   63.677866] rcu-scale:    2 writer-duration:    71 24488
> [   63.677872] rcu-scale:    2 writer-duration:    72 36187
> [   63.677878] rcu-scale:    2 writer-duration:    73 26564
> [   63.677883] rcu-scale:    2 writer-duration:    74 29127
> [   63.677889] rcu-scale:    2 writer-duration:    75 25213
> [   63.677894] rcu-scale:    2 writer-duration:    76 36202
> [   63.677900] rcu-scale:    2 writer-duration:    77 26709
> [   63.677905] rcu-scale:    2 writer-duration:    78 29292
> [   63.677911] rcu-scale:    2 writer-duration:    79 24338
> [   63.677917] rcu-scale:    2 writer-duration:    80 36322
> [   63.677922] rcu-scale:    2 writer-duration:    81 26289
> [   63.677928] rcu-scale:    2 writer-duration:    82 29386
> [   63.677934] rcu-scale:    2 writer-duration:    83 24300
> [   63.677939] rcu-scale:    2 writer-duration:    84 36011
> [   63.677945] rcu-scale:    2 writer-duration:    85 26219
> [   63.677951] rcu-scale:    2 writer-duration:    86 29250
> [   63.677957] rcu-scale:    2 writer-duration:    87 24484
> [   63.677963] rcu-scale:    2 writer-duration:    88 36254
> [   63.677969] rcu-scale:    2 writer-duration:    89 26631
> [   63.677975] rcu-scale:    2 writer-duration:    90 29105
> [   63.677980] rcu-scale:    2 writer-duration:    91 24502
> [   63.677986] rcu-scale:    2 writer-duration:    92 36409
> [   63.677992] rcu-scale:    2 writer-duration:    93 26414
> [   63.677997] rcu-scale:    2 writer-duration:    94 29130
> [   63.678003] rcu-scale:    2 writer-duration:    95 24586
> [   63.678009] rcu-scale:    2 writer-duration:    96 36159
> [   63.678014] rcu-scale:    2 writer-duration:    97 26263
> [   63.678021] rcu-scale:    2 writer-duration:    98 29479
> [   63.678027] rcu-scale:    2 writer-duration:    99 24352
> [   63.678032] rcu-scale:    2 writer-duration:   100 39478
>=20
>=20
>=20
>=20
> [   63.679533] rcu-scale:    3 writer-duration:     0 31164
> [   63.681440] rcu-scale:    3 writer-duration:     1 31690
> [   63.681451] rcu-scale:    3 writer-duration:     2 28398
> [   63.681457] rcu-scale:    3 writer-duration:     3 37524
> [   63.681462] rcu-scale:    3 writer-duration:     4 30331
> [   63.681468] rcu-scale:    3 writer-duration:     5 30588
> [   63.681473] rcu-scale:    3 writer-duration:     6 25430
> [   63.681479] rcu-scale:    3 writer-duration:     7 36628
> [   63.681485] rcu-scale:    3 writer-duration:     8 27195
> [   63.681490] rcu-scale:    3 writer-duration:     9 29267
> [   63.681496] rcu-scale:    3 writer-duration:    10 26967
> [   63.681503] rcu-scale:    3 writer-duration:    11 36610
> [   63.681509] rcu-scale:    3 writer-duration:    12 27017
> [   63.681514] rcu-scale:    3 writer-duration:    13 29493
> [   63.681520] rcu-scale:    3 writer-duration:    14 24647
> [   63.681526] rcu-scale:    3 writer-duration:    15 36099
> [   63.681531] rcu-scale:    3 writer-duration:    16 26574
> [   63.681537] rcu-scale:    3 writer-duration:    17 28995
> [   63.681542] rcu-scale:    3 writer-duration:    18 24627
> [   63.681548] rcu-scale:    3 writer-duration:    19 36099
> [   63.681554] rcu-scale:    3 writer-duration:    20 26580
> [   63.681559] rcu-scale:    3 writer-duration:    21 29133
> [   63.681565] rcu-scale:    3 writer-duration:    22 24684
> [   63.681570] rcu-scale:    3 writer-duration:    23 36089
> [   63.681576] rcu-scale:    3 writer-duration:    24 26508
> [   63.681582] rcu-scale:    3 writer-duration:    25 28821
> [   63.681587] rcu-scale:    3 writer-duration:    26 24382
> [   63.681593] rcu-scale:    3 writer-duration:    27 36151
> [   63.681599] rcu-scale:    3 writer-duration:    28 26336
> [   63.681605] rcu-scale:    3 writer-duration:    29 28946
> [   63.681610] rcu-scale:    3 writer-duration:    30 24735
> [   63.681616] rcu-scale:    3 writer-duration:    31 36237
> [   63.681622] rcu-scale:    3 writer-duration:    32 26239
> [   63.681627] rcu-scale:    3 writer-duration:    33 34242
> [   63.681633] rcu-scale:    3 writer-duration:    34 24917
> [   63.681639] rcu-scale:    3 writer-duration:    35 36459
> [   63.681645] rcu-scale:    3 writer-duration:    36 26774
> [   63.681650] rcu-scale:    3 writer-duration:    37 28911
> [   63.681656] rcu-scale:    3 writer-duration:    38 24797
> [   63.681662] rcu-scale:    3 writer-duration:    39 36099
> [   63.681667] rcu-scale:    3 writer-duration:    40 27206
> [   63.681673] rcu-scale:    3 writer-duration:    41 29201
> [   63.681678] rcu-scale:    3 writer-duration:    42 24676
> [   63.681684] rcu-scale:    3 writer-duration:    43 36260
> [   63.681690] rcu-scale:    3 writer-duration:    44 26859
> [   63.681695] rcu-scale:    3 writer-duration:    45 29087
> [   63.681701] rcu-scale:    3 writer-duration:    46 24531
> [   63.681707] rcu-scale:    3 writer-duration:    47 36144
> [   63.681712] rcu-scale:    3 writer-duration:    48 26415
> [   63.681718] rcu-scale:    3 writer-duration:    49 29230
> [   63.681724] rcu-scale:    3 writer-duration:    50 24371
> [   63.681729] rcu-scale:    3 writer-duration:    51 36045
> [   63.681735] rcu-scale:    3 writer-duration:    52 26707
> [   63.681740] rcu-scale:    3 writer-duration:    53 29079
> [   63.681746] rcu-scale:    3 writer-duration:    54 24622
> [   63.681752] rcu-scale:    3 writer-duration:    55 36202
> [   63.681757] rcu-scale:    3 writer-duration:    56 26489
> [   63.681763] rcu-scale:    3 writer-duration:    57 29016
> [   63.681769] rcu-scale:    3 writer-duration:    58 24632
> [   63.681775] rcu-scale:    3 writer-duration:    59 35968
> [   63.681780] rcu-scale:    3 writer-duration:    60 26480
> [   63.681786] rcu-scale:    3 writer-duration:    61 29171
> [   63.681792] rcu-scale:    3 writer-duration:    62 24542
> [   63.681797] rcu-scale:    3 writer-duration:    63 35972
> [   63.681803] rcu-scale:    3 writer-duration:    64 26459
> [   63.681809] rcu-scale:    3 writer-duration:    65 29248
> [   63.681814] rcu-scale:    3 writer-duration:    66 24403
> [   63.681820] rcu-scale:    3 writer-duration:    67 41353
> [   63.681826] rcu-scale:    3 writer-duration:    68 26759
> [   63.681831] rcu-scale:    3 writer-duration:    69 29167
> [   63.681837] rcu-scale:    3 writer-duration:    70 25051
> [   63.681843] rcu-scale:    3 writer-duration:    71 36298
> [   63.681848] rcu-scale:    3 writer-duration:    72 26557
> [   63.681854] rcu-scale:    3 writer-duration:    73 28940
> [   63.681860] rcu-scale:    3 writer-duration:    74 24726
> [   63.681865] rcu-scale:    3 writer-duration:    75 36109
> [   63.681871] rcu-scale:    3 writer-duration:    76 27216
> [   63.681877] rcu-scale:    3 writer-duration:    77 29170
> [   63.681882] rcu-scale:    3 writer-duration:    78 24606
> [   63.681888] rcu-scale:    3 writer-duration:    79 36459
> [   63.681893] rcu-scale:    3 writer-duration:    80 26470
> [   63.681899] rcu-scale:    3 writer-duration:    81 28939
> [   63.681905] rcu-scale:    3 writer-duration:    82 24758
> [   63.681910] rcu-scale:    3 writer-duration:    83 36139
> [   63.681916] rcu-scale:    3 writer-duration:    84 26535
> [   63.681922] rcu-scale:    3 writer-duration:    85 28824
> [   63.681927] rcu-scale:    3 writer-duration:    86 24272
> [   63.681933] rcu-scale:    3 writer-duration:    87 36187
> [   63.681939] rcu-scale:    3 writer-duration:    88 26565
> [   63.681944] rcu-scale:    3 writer-duration:    89 29050
> [   63.681950] rcu-scale:    3 writer-duration:    90 24686
> [   63.681955] rcu-scale:    3 writer-duration:    91 36216
> [   63.681961] rcu-scale:    3 writer-duration:    92 26589
> [   63.681967] rcu-scale:    3 writer-duration:    93 29076
> [   63.681973] rcu-scale:    3 writer-duration:    94 24683
> [   63.681978] rcu-scale:    3 writer-duration:    95 36081
> [   63.681984] rcu-scale:    3 writer-duration:    96 26710
> [   63.681989] rcu-scale:    3 writer-duration:    97 28881
> [   63.681995] rcu-scale:    3 writer-duration:    98 24494
> [   63.682001] rcu-scale:    3 writer-duration:    99 36297
> [   63.682006] rcu-scale:    3 writer-duration:   100 26487
>=20
>=20
> [   63.683440] rcu-scale:    3 writer-duration:   101 48416

