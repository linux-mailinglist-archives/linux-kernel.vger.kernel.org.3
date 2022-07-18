Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3147578E80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiGRXy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGRXy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:54:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1F20BF1;
        Mon, 18 Jul 2022 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658188496; x=1689724496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+xCqNbbPWnhjdjIFrxV8b+OELo6GUpqLXayqwufp9i8=;
  b=lbfTRNsY19BWx1dPIIUx5hTaPLHLn1Xi7VHoV+pW3/Xvbc29OaZ528aE
   euF+Qh7CS3saWp6YCM+4m5D6LJgpf1sdwEkpeyNcB11JCrGRqpE8eFUdD
   Ad4ohUG4lxVSXPWwne3ZnsdRFYGDVRRmMmM7ZpLParXDN+MuPU7VSEahc
   Ut3SnlnSr6JsFtBAk9yswJ4JaYFQxmrqImtUjShmQJSdECu21eOsjGR0u
   IyhdZKZ0YZEKlqAEp61TAD7I25H8SPJJcCttNIdJaT+u2leD1gR+tjAFt
   Ow6G1/Jk5xjsb743Vd3qe5qWpHAUttNQHYMtovl4dcb8BCKM0aMIyFzk6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350311776"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="350311776"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 16:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="630109701"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2022 16:54:56 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 16:54:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 16:54:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Jul 2022 16:54:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Jul 2022 16:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PntBPB05BZTGmT00BEQWoHwNKeLW2YGteS/SzJbsBUsJVglWEI2oV/k9yhJno7oDUceLw+fPzXdVGqguxvFpPkCYkeknq+vtAoExD6WAR954zLFqoZU4ZxemnCnJ4f5OTDidYidb+fhS762GEdvTXaxVFr7J7qw3ox3SsrWZcF9qlq63aURxhsvdO25Jjs5P7mXz3zHeymgKaIi4ga60YnnD3TL6p2vPfqk1c8uKFsA7r4JUJJscpiqiQ7zXlFjej1aRrlD4gwvpz9uC7vMYDOZvgiBE2j4/sRCcGGCMiYN/M6VntcXpMDxAx7u/vRkbRPczQ7jwOOnxC1W9632HDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyKmvNAynovG+Gkk0Xofo/hA33tKpwQt1B6jErK8zpc=;
 b=n/1BPqNq7mTHManLdZR/ngTHP+8NlAQYowrsHG7kpG2bSgi7yV0IbO0y8Dpok35o7/DJ+YqNuT1Y8a0kgui3jxRewosOjGrTAdjoChr9N/ERTMvF2MwZtOxUxxUsLZlM+Mzsf9W2gC1jAo5i7YgiHjHAH+KSsCxfchIHr4KPatgWWvCE0WaG92U0Ia5VfkL78mer8UoN7NbeOChF8BsSwlhTm1j0lS8tX0GT1YOCP8vvkSnS4LLtLzdbWljwG175WuYdQoqEE0PsbU5+P+HW6Kn446bWBz49q65PQuNYYT2RWYwiXaK6hStupAwTOguZOTSooaH+t2PdlJqpp0W8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB2810.namprd11.prod.outlook.com (2603:10b6:5:ce::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 23:54:53 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 23:54:53 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for userspace
 execution
Thread-Topic: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for
 userspace execution
Thread-Index: AQHYmjrwROV6N5Vt90OEhOEhgOcQ0a2EP6gAgACFbBA=
Date:   Mon, 18 Jul 2022 23:54:53 +0000
Message-ID: <PH0PR11MB58805ADED62CE2AF94647967DA8C9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220718001610.263700-1-qiang1.zhang@intel.com>
 <20220718152132.GE1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220718152132.GE1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: fc162d5e-d22c-4e2f-4536-08da6918e92f
x-ms-traffictypediagnostic: DM6PR11MB2810:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V43k2rb5C7YpRi6V70ygA4udYxrE3nSuDOA641fBSTooQ3Ii9Z6N6Kxsw0/fUbQWoctZ3gBOudQ4s6WdQyhr0LqzfLSvoxwF7k2kAmSkbbRnr4N5ErzqKOgmnyTUzXWKlHSJanZagPPTiHGyajJE++t/EHjazNLzP0uINv+tCRiNbvtYbiH/UoZvyi/K30BUnXpdcxgSobnDbdtG25MH37KL36NCGH9s6/JbaQLA1hBLgeQ3hpSaZjyirDZ8sZNGNKdRxprjC3+UmdJbjdIotwkqxFXyiWLNCg/onesX1TalSp+WbfpOYcFDUkJRYp3l3ZvftYC/TPFhzrx66DKE6NfN6wFzp+lXzKqDi1yzseMaOhp3BzZyqxABVIZdb/S2uy9PBIRJaHGBK7PBdPBJOySLjb50aCkObAFeWKPPwenlHzr9MeRDTCcrG/8UHH7wEb93CWFwVYwUUumslD1O63kyi3sonoFblQHfPEvzmoHccJybdTjLjk92qcru0Liw0wH1TIrYrMQkTMLb4ITHXGSL338e7hB+NIZXk2eDw0G10gDF81ncn2KPqL5I9zF4N1DIc37gyupc0g5qohVn99T+W6lUzPjdV/oIkPKPcOu/MjYcSOfUuC2DOByw72GrANIvQulecdv/Fv+TKqNUyFZAjIDCUenp0o9DrAl53k+b5OEbVru90xaqbvrv5T+Z8o2AV7PCAwYanv/cnbAJtSh+PXA6foV7hImpo2Bb8XjW435Nh4Q7IQT5/ybWBkGV+QmPxsicbW10OnUDTEWCJzyJZwmk/XlWXD8o7M1+cp+rP7VhN+KOQpXo7yBMX15W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(396003)(39860400002)(52536014)(33656002)(8936002)(38070700005)(38100700002)(64756008)(66556008)(66446008)(66946007)(8676002)(4326008)(66476007)(76116006)(82960400001)(6506007)(54906003)(6916009)(7696005)(316002)(55016003)(186003)(41300700001)(83380400001)(26005)(9686003)(2906002)(122000001)(5660300002)(71200400001)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W5dJbqZxDlKZWDQ8mnRvq1oPFStTk7VUfR9hNv5uQ6d//m3ltG8i2UO7R0aw?=
 =?us-ascii?Q?U7SFmwts8a/Iwk3am9s39FMZ/KZt/bONEjAcw9HQ8rN7hIbSID59HDaFnrqu?=
 =?us-ascii?Q?hzCg9b7QWg9SrNEw1KoEEBcpq9WHWzfgtMXDn51BCIEqlv3vQ5SCh1zT7C3U?=
 =?us-ascii?Q?pKi5JEV+kVRzfFr63+s91XmmlyF0oxo0omESvz5fDMFKeAU9+vKKW8xFmHpt?=
 =?us-ascii?Q?s7vA2XMrQ1GxwXgpDhZFcoY2NHouQkt41c+OgU5+FHANwvV/FE8u2sDgINJy?=
 =?us-ascii?Q?h+8MmF8ralODXa/7wm9Bewb9XM2qf2StKlu+/DtEwaCV7qgGRx6CyClRmkxc?=
 =?us-ascii?Q?h+DxCtfXOGTA5+3O3rjIghKxOcq6Is9ueGD8LaiO7cp67eo8Qa8GnVeVERYr?=
 =?us-ascii?Q?dxZDoCQKSM/iFEO4vFhNRxwewgic7P7HMOIX9XXmRLBhKZrCiaK+3K4524P5?=
 =?us-ascii?Q?9lbgh1dds5qGmVJl/3hznL/lpW9o6HoqO6JMxrEPL/GghC1FdqFoHkRoqqXO?=
 =?us-ascii?Q?Y5amFbSBuXG+95WQM42kNrYewthywQ+hVMaSbLzxU0LGN87YpdI3UftXUe2k?=
 =?us-ascii?Q?gAfFEvXPp22h5YCvmSX8IyMM0JSxUMsgqlADwSnwAzfoZOA8QFX6rw5Lhu/A?=
 =?us-ascii?Q?DFIrO60RPvzBhSpeGNIVolvE2fVKjr4/Mv6lLho4o9GQ4zb3H24qMgTLcNGO?=
 =?us-ascii?Q?SXLU3SgxddVgdWy54vJy5XdxSelhJj3swth/UfI86hkLgh+x++y9bIpF0O7+?=
 =?us-ascii?Q?9EopXUpq4AiLdPXnKxf4ASF7wNpcJ/YjV61iGacLlKnUE0AzIP2nFUlCz4KN?=
 =?us-ascii?Q?QS8sk16lPjCqTFoyvdo0/KkJvdWRhEEfqyi3BpnFpmlPBE3YpNJnObbVjrUO?=
 =?us-ascii?Q?U1BKdwbuxzvIdsqrvQnHpqcXj5g3cio8kTAUz61sLDFWPJ51H9eUYxYcl+z1?=
 =?us-ascii?Q?XcZd6esIpV2zcr9AiFxFwPlzmy/5oHD9NJGEjFhXGApYXFwf+IkXy3kkXCxx?=
 =?us-ascii?Q?qEA0aXlznjH16NWGhaur9hZxelrpDpf7fvQscaWEF6JUl3FJx9fz/Uw8rTBL?=
 =?us-ascii?Q?PcQllcQ42J3ODrcSWl19OeuJLJW4Dof9UbVUVmgq1YS8YNilk/mBSTOjMmcK?=
 =?us-ascii?Q?CjSRdw7aW3eOGydCg94hDDlw9Sc4Sy8D9KIfUMEZaCTOYRHfxdK+f7labd0n?=
 =?us-ascii?Q?F31NfSkrwL5OND4CIGswgNd6H+hwyhIM/2KoVtZBwxBM9ud3czdr2AjGB18A?=
 =?us-ascii?Q?UKc+QqDEl3zimsZ/6iCR9YLPe+JlPONkUWhVKeNkH8Ysw1ExBYyvICl9Ys70?=
 =?us-ascii?Q?Lu2mdrm8vjV+MLM+NGKyDf4Tbu9ON0VlQV5SvFnn+cSL9Ypxa11soFSWFpJ4?=
 =?us-ascii?Q?apWULJQpVFV2i9EP/FZk/AaCPZqc7eg5tMz9PQ4H35r1a4BZvvsX4pXBxcue?=
 =?us-ascii?Q?swxi5n76Hfog29HSlg61TtTcwO1T6+dWSwnIPk1bphGhEsIbfKyBmxU7DEgF?=
 =?us-ascii?Q?MUBk3P7sFlSzHAc+v3o2lm7D1pYsG3yX2MS5irWbqK61u6QcIkWXKfOMOBJu?=
 =?us-ascii?Q?/hnXCiKHyzujwfba59eO17SrqVIX7JE6F6i/V7VB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc162d5e-d22c-4e2f-4536-08da6918e92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 23:54:53.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLGAVZnJQvib222aK8YkLBmiPqv7oJLtLw89NnpV2jtB8xZF+6bredI3iQ8Yb3QrYuuzJIFcMQRonRqlJkp3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2810
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:16:10AM +0800, Zqiang wrote:
> For RCU tasks trace, the userspace execution is also a valid quiescent
> state, if the task is in userspace, the ->trc_reader_nesting should be
> zero and if the ->trc_reader_special.b.need_qs is not set, set the
> tasks ->trc_reader_special.b.need_qs is TRC_NEED_QS_CHECKED, this cause
> grace-period kthread remove it from holdout list if it remains here.
>=20
> This commit add rcu_tasks_trace_qs() to rcu_flavor_sched_clock_irq()
> when the kernel built with no PREEMPT_RCU.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>The looks plausible to me, but can you tell me how this avoids the
>following sequence of events?
>
>o	CPU 0 takes a scheduling-clock interrupt.  Just before this
>	point CPU 0 was running in user context, thus as you say
>	should not be in an RCU Tasks quiescent state.
>
>o	CPU 0 enters an RCU Tasks Trace read-side critical section.
              =20
 if I understand correctly, you mean that CPU0 enters an RCU Tasks Trace
 read-side critical section in scheduling-clock interrupt context.

>
>o	CPU 1 starts a new RCU Tasks Trace grace period.

The grace period kthread will scan running tasks on each CPU,=20
The tasks currently running on CPU0 will be recorded in the holdout list.

>
>o	CPU 0 reaches the newly added rcu_note_voluntary_context_switch().

In this time, if CPU0 still in RCU Tasks Trace read-side critical section, =
the tasks
which running on CPU0 will insert CPU0 blocked list. when this tasks exit=20
RCU Tasks Trace read-side critical section, this task will remove from CPU0=
 block list.

Did I understand the scenario described above correctly?

Thanks
Zqiang

>
>	Except that the quiescent state implied by userspace execution
>	was before the new grace period, and thus does not apply to it.
>
>(Yes, I know, if this is a bug in this patch, the bug already exists
>due to the call in rcu_flavor_sched_clock_irq() for !PREEMPT kernels,
>but if this change is safe, it should be possible to explain why.)
>
>							Thanx, Paul
>
> ---
>  v1->v2:
>  Fix build error due to undeclared rcu_tasks_trace_qs(), note in no-PREEM=
PT_RCU
>  kernel, the RCU Tasks is replaced by RCU, so rcu_note_voluntary_context_=
switch()
>  only include rcu_tasks_trace_qs().
>=20
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 4152816dd29f..5fb0b2dd24fd 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -976,7 +976,7 @@ static void rcu_flavor_sched_clock_irq(int user)
>  		 * neither access nor modify, at least not while the
>  		 * corresponding CPU is online.
>  		 */
> -
> +		rcu_note_voluntary_context_switch(current);
>  		rcu_qs();
>  	}
>  }
> --=20
> 2.25.1
>=20
