Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00A757410B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiGNBx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGNBx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:53:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9222B0D;
        Wed, 13 Jul 2022 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657763604; x=1689299604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bSLN425x38Pomk7qF+Or2nWkzTZJRZWrNrh/UKGbtWQ=;
  b=Io/NuxrBVzMjmd7Pe5EVy0bD5V6S9m2QbEuNjysMqAHVLW6u8rNeicYD
   RUf1X0azc+iguS7GwsFpCHpApWNQZR0hSLN1E/zCx9bRHA6eFfOoq3gI3
   JpSHexJSIfXh25yi6YbxBbPTz6TWd+ivjbsmelVquctOwYkWZjRoFk2bP
   eoHBDs8rujRnMMIprLW101t1iy+Dh61soTb6Bh/o9eAYGKdvZjFxKmrPk
   5cYtMilOqI78jySRzRNtDn/tRICTtQHm0wU7QYbTBMWgjOjwKYBulPV2S
   65SuZm3ynTrIlF0DWbGWthmQ4/kYn8zkSKmV+RC+LDW80b/67zpX9FaQ8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="311037433"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="311037433"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="599958352"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2022 18:53:23 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 18:53:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Jul 2022 18:53:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Jul 2022 18:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irluaxyfQCa6Z/xcMRlEzWAyFUYB+fZXjQLkSKxFPCih8PCkj7tD5Yr/qNIL1v1hydYneJkL9XuWjiueWIBp+5dU8a6mFw47Ei6kmvvxDXDIF9RFcWRnko2An7pPdgVhrqeJ3+a8cu4xgdR1JIQuNWiCD2DEpLAA67oCY5ThJlT4QX5zq0ADQQ4WMbSc5f8QOvxI2WC7Dzme2tqVpZdFOINVZY1vacBl0xeQZSYLKi0VjyHbge01f8p2XOocdsNYdRS7CHvIrwqgyemWeUxTuEOlI3eLlV4kh1wFKU7rik74l5yOLRQRcp3b/BULF0YzCnlnXPOWWmjn0+cCF+3QZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLC2y6QUEe96JguhPOwIae8X5DsIsGZUbtzx+dODKRI=;
 b=XuYMuKb+DdCWwzf1FyUE1PYJ/PbgexdUK4JlZhPGyfBWCapTlqzZR/FqqeRvAakbmTcrUEfJb/Bwa8hhX1lilkkDx2aFxC99WC7Jx3QL0NqDV5cBjLr1c2O0cO+7bJ2qPJ95BP3M/iQtXdMzgvJQGZ2S8MIbHLErwuOTwIHCfDXcWEQeJZ2rQb4eZUf+nf+Uw6sW4OJKJdRifmNgfKGJdzBowAn6UyCxGScY2Tn/9Ky0ZL5nFJYrNTgum6S1eDdtM+rmmmuMeCtM6WgMlJNTq7Y2DygROK6AJWx+92II9gUsMNn2wY1qJ5QiI+K9KLxtA1lSkvUnXn8fwKdGH1giaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 01:53:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%5]) with mapi id 15.20.5417.016; Thu, 14 Jul 2022
 01:53:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] rcu-tasks: Make synchronize_rcu_tasks_generic()
 no-ops on early booting
Thread-Topic: [PATCH 2/2] rcu-tasks: Make synchronize_rcu_tasks_generic()
 no-ops on early booting
Thread-Index: AQHYlckpO9C5eZ5WlUCBwcIpqAdj3q17AHOAgAIXAkA=
Date:   Thu, 14 Jul 2022 01:53:20 +0000
Message-ID: <PH0PR11MB588067B6DC5195CBE1DDA7BFDA889@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220712082606.3662616-1-qiang1.zhang@intel.com>
 <20220712082606.3662616-3-qiang1.zhang@intel.com>
 <20220712173709.GX1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220712173709.GX1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: fc6b8c8b-007f-4e91-af65-08da653ba0e1
x-ms-traffictypediagnostic: SA2PR11MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jw+SslpdbwOWtzWON4YVWg7UviM/YMt3c1Lqo4g22tNECD/0FK0HdI29I7sfWChVk09lnn0N1EgpdJnCOi5Q+7xWM19skAIGZzhJtm1GqA9bIwdOYyhtSUTqPT+g2S+of3kjD08PdEicvkAYfmKc0B7rsUKYZFSNm5zApy1Fee3hiHPUzKztQk0G255kzLqhD730Qv6EDb4CI8UwAIcbOzWdRGWR/9e4NvrtFKs84M7YkWKpo1tb+S9vWhpRk4iMlB2aemA3rwpExPyHWvD87luKBQzKz/5iVYbdBfNznuyfoPEN9BPZ1CU84z8hxCSJl2JMP4DtcIlBhpXigkrsrMgJ0llABHO2d1K153RlmEoEpZcmij+gc4xkUGAlyL59ldlqnhY/C2J86tD0rIwaK63oIrLOCIl7lQ23UMyPjHzFAZEXJg5nTL6DPWBaQZcqmNwnE4CwgUnUlebMOwcKSlRufO9Z18UaoK38sft3JzlHw8TEao8XANY/+m9aBJxqV4G8Tq2A43Mf+Cyl2ryIUEvijKeGcsGEvADGN8u+klOCjGboPnNAhJfpPvjFk7mObSA4m7KA7e6gfxStzMbFSyZWplJOP4VNr5szGu7FUozIEM7jKlgesxY/xd+7o4jdYw+PHaXKyy/RGcFc53JExIB2r4poUbBiF3e/8U6Dj5Moe7v4znWK/gYbeJiZk47OLmlr2j4nGKETY35140sx3RS3IXE5hZrl6nTRx2oPxU/u0+bcPFrFqqP0De1Tb1P/egRGdxfkoU9k6pE1aZjkKD27Jbb37S1PfQfXKDoLtWXNAsBbzoAUaVJMcOXR0FuqMIUYKya8yKj0idlCtqKBXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(346002)(396003)(136003)(2906002)(33656002)(9686003)(38070700005)(55016003)(83380400001)(6506007)(478600001)(8936002)(86362001)(8676002)(64756008)(186003)(66556008)(316002)(66446008)(66476007)(76116006)(7696005)(26005)(66946007)(4326008)(54906003)(71200400001)(41300700001)(52536014)(38100700002)(82960400001)(5660300002)(6916009)(122000001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZhWMrgR9kwBUUhyeVEe5PbhwfOn50EcWpGUu7CUZx4e0xDO8b9Vrl2nSIyQU?=
 =?us-ascii?Q?6S8DPSR74vEbRlVCvSYD1D3xvCbQD7+kTbUryw9AOMI1AxkSAv3Vz2z6WGG6?=
 =?us-ascii?Q?Eb7yMJHqOuGsXgtopHD9HiS1eO6/O7L3IfLi1X2qEORGlChHebqrYio9UOyA?=
 =?us-ascii?Q?ic7O7fID1l0I5mHBmDRNdGXq+nX55WUoPWI53S/jecuKncirABg0zTBydcvx?=
 =?us-ascii?Q?Q4eHjZbYSo4yYLMZfg9Et6S8NwQ58FGmKbVP6z3SguAfJB7v59EDI5GcSRTm?=
 =?us-ascii?Q?agLqL9ZQMrrGE0smAsYaNMye886qHm3OpxKQRiQEwGVAkjVlUXgzqhgXxmSU?=
 =?us-ascii?Q?hyNBPmRrv/NtdMSXlijo6wFYmC/CW5KWdfwargLpMJ/+6u4jGqXA+3CwwkcB?=
 =?us-ascii?Q?X5ESYvXFNhSySHyNtPoCgyZtgspWfAvvcTas0hN5ld/5O86kJ5cGoAuS0y39?=
 =?us-ascii?Q?Eo0P9ThyN5KU5Qd1l+xI/FoVF3is0NKiU4HroFW42bpW5jEGall2qSztOSFo?=
 =?us-ascii?Q?jc/3qwFEPfs3GjqwIywrDUuc1GBx1439WnMZ+3w27z3WX0jcMPJiKUzHb9CI?=
 =?us-ascii?Q?q+fvEA953wR2yBpYN86kGTRFwcGHZGGYa/cBXLgRSCl3KnbvnJk5WrFvU39B?=
 =?us-ascii?Q?RcLP0VmYJC3UiRDfnE6shxE86zi3XV0RlYYeqYXC/iy3whUaEw3GBqtjf/cc?=
 =?us-ascii?Q?UCBhBUhgiwv2pEMoDtgWmmhhRt+tmI5v0bf2g7J9bDsxRbPYO7YBRZL+t4z+?=
 =?us-ascii?Q?TTXLUt2xdFFLVth4IPPOm7FXhhn3fD/QKt7OXcoRTrxwjMB9vqNUOVGLFpcJ?=
 =?us-ascii?Q?OUnmIsgrp+MS96nDcX0ImshYW8CB+w1+eE74udO6CNu6rO+VftN+NGSuW5ZC?=
 =?us-ascii?Q?kJvYTGYMPKD1i7eESz+O2vg+CXO1+lEAdGHnTWri2lPZtInY+gelF90GUgL1?=
 =?us-ascii?Q?kl3safLAXqueRVKa1Xe10aIBHJw1lzrvU+FmYKs671kN9rk5wgbFwGgDf3uw?=
 =?us-ascii?Q?E0vz0zlOLyxlWe+rhESrXqbEKbzPxvBbGu0AbCf5/ElCgFZ+U3+nFvEAZqhL?=
 =?us-ascii?Q?1LL5XWGANeMFXri7AAIGvz37rF5ckDrFJ7wGw2T6Fz2JN/u4B4zMqOIkK6cR?=
 =?us-ascii?Q?on4s9xtD48jEDQQmA3aqAt8fyPMluYzQB13yNNIr/H0iw9O2sKkQVbCvU1Om?=
 =?us-ascii?Q?CPTywpHGlrUJtu0R1SXrqceQv/a+BTycwtp0tn2nNdsWRMRecR4FKrK7MjEy?=
 =?us-ascii?Q?H40syOfSbPiFjKLJgkoFyEbHCeqknzdXAzOuYHBOjglGWvyb3PnSQKlB0YhI?=
 =?us-ascii?Q?1Cr7MlkDgHpy6z2oVL35otFWspFoozHh7lL8fm+tv41e2l4u94KkMM2cVQPZ?=
 =?us-ascii?Q?mI+2yHQ4N9Azr0Rksts/UXFO8/+lioIHFhTPaVTYRqYEql83e2vI77rTuQOZ?=
 =?us-ascii?Q?j8IO0t1MgwcF20iETtRJTjixzi50mJqPDXA+uCwFM725OBqXiSOPxZpC9lJo?=
 =?us-ascii?Q?NK7a3ioKMhmbwb4Lxl1EyvdLUHfraobCouVnpkpMjk1WYiFKZeor9cVXwSPg?=
 =?us-ascii?Q?wca1zT+H8qJKFAsLXNOHMQEW7/naZsUhSCTH20iq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6b8c8b-007f-4e91-af65-08da653ba0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 01:53:20.2811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UViuDcVWNdPx7xqWJf9Ut8dSdRmS4YN+F/AOCHAwKx8OyoL+EOD4mlztzGYlL3LD5sZ+E0laUmOfTLxnLV0raw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jul 12, 2022 at 04:26:06PM +0800, Zqiang wrote:
> When the rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE and not
> yet converted to RCU_SCHEDULER_INIT, there is only idle task, any legal
> call synchronize_rcu_tasks_generic() is a quiescent state. this commit
> make synchronize_rcu_tasks_generic() no-ops when the rcu_scheduler_active
> variable is RCU_SCHEDULER_INACTIVE.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---

>It looks like this would be a good way to provide early boot access
>to synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), and
>synchronize_rcu_tasks_trace().
>
>But do we really need early boot access to these functions?  As in has
>the below WARN_ON() actually triggered?

when the rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE,
invoke synchronize_rcu_tasks_generic(), in addition to triggering a warning=
,=20
also need to make it return directly, if not, the rcu_tasks_one_gp() will b=
e
called directly, but due to the rtp structure's -> pregp_func is not initia=
lized,
A null pointer bug will appear.

But like said, I don't see the need to call synchronize_rcu_tasks_generic()=
 on=20
early booting.  maybe this change is  not necessary.

Thanks
Zqiang

>
>And if it has triggered, and in a context that means that these functions
>really are needed during early boot, how should the testing strategy
>change to test these at the relevant portions of the boot sequence?
>
>From what I know, hitting these during early boot would indicate that
>something was removing a trace during early boot, and I know of no way
>to make that happen.  Hence my skepticism.  ;-)
>
>But *if* this was really needed, this looks to be a reasonable way to
>implement it.
>
>							Thanx, Paul

>  kernel/rcu/tasks.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 469bf2a3b505..0237e765c28e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
>  {
>  	/* Complain if the scheduler has not started.  */
> -	WARN_ONCE(rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE,
> -			 "synchronize_rcu_tasks called too soon");
> +	if (WARN_ONCE(rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE,
> +			 "synchronize_rcu_tasks called too soon"))
> +		return;
> =20
>  	// If the grace-period kthread is running, use it.
>  	if (READ_ONCE(rtp->kthread_ptr)) {
> --=20
> 2.25.1
>=20
