Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5B4EE54E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbiDAAZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiDAAZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:25:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5613BAD1;
        Thu, 31 Mar 2022 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648772602; x=1680308602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n2Alk5fNyeC3BVo66sI44UHsqp9QFQU/SwWdvL6ICKM=;
  b=medEyD/m6xg0oWyc35fWtLUJ4wejbmi/DZ4hGRj/W7sF0cnzVTmJBi+Y
   WQTCnogotybRUk7q1ZijB+RGX7n+Jl0MxrwIeKmS5Aebfng/uFbJB++jU
   q2bVDcRWTJUewjN+a97n+GOygje5QWNjddwkok5RpiX92BdvUdCH6FRT1
   47tulOLC8bqhB0RZDSojkqmTQww/rZTx/QCuQNdf/rLxUymaxjdr5BN7P
   V4v7i/97PO0XtWHPCqwJwfOJdMH5PuVX5ly0jENv7YOz5L9PbSRuN4LrX
   MX622DmoRPWb+l7JKnCEZWtTH+zObdZYi4yKOVwgs69WdRlIPgIF4xGj3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="323177301"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="323177301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 17:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="695698789"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2022 17:23:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 17:23:20 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 17:23:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 31 Mar 2022 17:23:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 31 Mar 2022 17:23:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do3nbsZsMdBcCsXfuThc80VRgX33gakG0OvqqOKqkq67jxJE3mOgPvzi4869atvWxk7w1jbFfxgHgToO+6MtF5ho2O4lNIW4TfjZRV+5BZCagxS/sc8eoPliMs9HJK5cwLofjc/gSSEXnc6iQ7uIE65eEmZZ2Bd6v1Jn+Hv3NxXVinuI4M/DVl1O7RbfuWPSpc2AHHgYUdNPhG9iqVQAc/BLZzwqPproguuh+eW2HTWiMrQKZIP8T1H5eIDv+AiJdALrj/zWJ/cZqmehoxu3z0jhBmve0Xjh8Yr8Q4sRy7KBmpihOI9Jwr6Aw24TbLrogPtQR9nK75eJofv3fk6xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYVWapkR4ORRLSYbAeXQ1dHJJ17ID1ei9xOuJ/WSkX0=;
 b=KIsvPaGp5DETAh+dq95/iBLTgT7k2DArm4/B7/cXTZNu6aHbwbKRzU3jHD5lIlWRX6Ky6HVEok9qqZcGOIkwybB6JH7dCf/2rE9HDeapWXSQipBgH/Yq8OqNm+DEUWE0JG6MvluqbF0ccJshexPIVBkvveV1dmjuv9eUZd/U1+hypJ/BwpF/KqpRaY6FNvv7LYAvsoALdRMQrxOKPHqCcQOFVPVdZw9dbEd1TmQXEi8sNolGKW6NIBWq75bKsXCrUHX99lF3vdPvbdzyzz5OpE/f4BHTqgVvka9dqGfGWGY7VAP3aikM52dRAB4mx4/YlW00Mq5LbbzBd6gDUAU0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Fri, 1 Apr
 2022 00:23:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3%7]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 00:23:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Thread-Topic: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Thread-Index: AQHYRCgbTB0vKm9Y50G6+1/r5OpdTqzYSg4AgAA0FUCAADoYEIABKWoAgABS7dA=
Date:   Fri, 1 Apr 2022 00:23:18 +0000
Message-ID: <PH0PR11MB58806F59248B6FE5FE7FFAE3DAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220330112014.2587148-1-qiang1.zhang@intel.com>
 <20220330190556.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880D6B11469266144C58032DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <MW5PR11MB58585FA7332315F46FA36CD0DAE19@MW5PR11MB5858.namprd11.prod.outlook.com>
 <20220331192446.GW4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220331192446.GW4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: c198132c-6e5f-4486-f116-08da1375d26b
x-ms-traffictypediagnostic: BN9PR11MB5241:EE_
x-microsoft-antispam-prvs: <BN9PR11MB5241880D4909ED7458C8F423DAE09@BN9PR11MB5241.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aneLVRRH3//gLp7y6xyjeu0DLQjhoJp6uGDDk6X8EnxUhac3KQeA2TsnWD//FMOBiaS1bxZHz3xlgnza3UkVlvoasmNbaOsYtf69nNH55h5KmhUqzozE2gG+kCySKeJecolzEILSWD8KeQKFuWG8DiUKIQvMAR2lJ9RJqunqSeoxggtZS8RJ3Dg7pxIpkGvRQlLQ8F40tqmG0Z75IfxRAZBqeVFH/UUSiVpnvoKtZ2RP9ldwyRWc43/Pp1iDO1iKikZEEApZpCVyPBzwHoaV7Ws7e13+LMngkty5G4tabf30Ct7i3am87QvmLugilrQo87PxtNGTKsQTf8UwuOOMNvZfZcG9qMrE2p9xdGvoO5+TjDmwmr9XRqCzLbP5EQXiRJM1jByJRSJbg4YQwjphma4dw3ZHIEHbMdrCWO+xnDodDfiYuYJX7TpPsaOdLUV3TwEIZyuYItQK2OQC6uUVOwtfpfCU8E47+L4sV8dth8chxrYIBtrzExVfqQh+/RELFIHWD7OTYk/V+Rz+8hY80hspGZx9d2Edwv0rCY6Rx46QcOvgDbHmFmuSC97CAJI07PCbchFatr8MH/i7LFbzapPBbrb7bFnSL8uU8BS6ScmyEryZcxPPmMuN7gozTbWfzM8rz/eovOflp1Hgl9dc/xrYMZoukGmr34a1kFHlMgw1C0O5cOGFeNCrt2o3cUbq2fIK6jKOnWCvezmDHL5OQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(9686003)(38100700002)(6916009)(54906003)(2906002)(7696005)(55016003)(122000001)(82960400001)(52536014)(76116006)(66556008)(64756008)(66446008)(33656002)(66476007)(38070700005)(71200400001)(83380400001)(5660300002)(508600001)(8676002)(4326008)(66946007)(86362001)(6506007)(26005)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c5Vk16aaWWhxVYI+gjngN6gbU6HAo3jKuItwI5Ne2FjI08fBGeqRO2I+kznx?=
 =?us-ascii?Q?SujCVTnwdTFjgBhUYHsetLI8wI6IsJyb/pEtQnPc8SwrduAajkz4Y4iNDe23?=
 =?us-ascii?Q?3s05ixcUnfBNCDja3yNKuJC/I53OTR3sF8tJSjvgd/Zrm+IRKiv8xhGJCDun?=
 =?us-ascii?Q?T4cY5R0oIknGHwPz9OiA+1XBX6YuwztyWg8zTuY/1AcBLzYr5oPcIzU+qiqc?=
 =?us-ascii?Q?acyRi9K1/oVYjlmD3iAUnAg17bzuF6BoEvg6sJZ+NCTUNo5Cug3C2PaTbHZ4?=
 =?us-ascii?Q?0tOBMP+0hlP2J968NdT3k4jMjTu/ZFxQ1ZoHP8ewGm4qWgq3fRfPH/5DbPAo?=
 =?us-ascii?Q?ArhSTXvepGimTFK4wYBIyNFMGXenJWbKz2NSQzqAkVM/G1JO9greS6R5nWh1?=
 =?us-ascii?Q?cvJIuKETLaEwoJHbZqFtNOp4tgsVVZdiLxYYjfiU4FPvSXQGqwOCdxgf2qxP?=
 =?us-ascii?Q?qJ9FOTIP47/JPEEl46trmB75E0UuPo0Ur5EQVJ60+75tatYmQwWGgtZ0xswz?=
 =?us-ascii?Q?w8Ha81O0vDfVZh57GrLoc6aqV0jnM41IrKdz3abdOh8YWFaQec5Wny1U0v3M?=
 =?us-ascii?Q?sedF1kYIqBUPl7H+ruy0+ICXZpgeGqPIXnbBmdG6Jb9VdHnt8BHHSsM37p5J?=
 =?us-ascii?Q?OSZ+3xzJ1UZaghIcTiGbndtMOIUb4CCoLitpPNCgPAfmLi466QeibhxxiAUy?=
 =?us-ascii?Q?bNkz7HrCWE9a8GXXtVDWI1pd+1zHtAAeOQ/GxfYiTwsWN8itP7Ssi8AM8FtM?=
 =?us-ascii?Q?M0Aycp9kSD00MjlIpJD4XtQA/LmJ3G44NiDuLQGcg/3Qaq1E6PoXWXUzznCL?=
 =?us-ascii?Q?9LX9ImvFAqn/nUaLy0JHnmFWKDGjHfJB5yOBn9hcBjPmxOVmvAfHls9bPTd2?=
 =?us-ascii?Q?7Akuy1WeNtcZo8SdXzP3eARZc4tIb/pZIdkTMPYZE9x9cL+cjlAmrfXAezfW?=
 =?us-ascii?Q?CJkrEhjAoUmepjyn9uEe58vyUKXU2IGnNFoc39w8y4rhAfVLeTeuf1+xlyys?=
 =?us-ascii?Q?vLoYHkkkk3hmgIpr0EH1OgytxmEbcTbjGK3crajK6+s2QrVz+8PWtW9aTwie?=
 =?us-ascii?Q?FYA3c86Or8ipsjIa1JOFAB4ilv5UI6hIhx0jYdphzd7+OHlT+snwHSQzWntG?=
 =?us-ascii?Q?2NRiODT0echd9K2DET/c/mfOzuIMB6/gkZK/zgBLoqVrXdQAJE+auhtJAMDj?=
 =?us-ascii?Q?EBOote1bj5RUnhd/S3SLx5dFP05n1Y7ry36Drn3j1IEiR6XbHBtOFo8Q+moZ?=
 =?us-ascii?Q?KcAqcL7PEMEJi7CLecUylSd8YkXg8yC4i015YZ67xSBVa/oOjVy+hU4gQb7Z?=
 =?us-ascii?Q?JDX5UBhlJOeZKipSwFFb+iKZbHmswgMI7BDzKVoKw/jgjqwZCjqXLHdV/lYs?=
 =?us-ascii?Q?zCHyMKvbxXGXIYgaLuVRsR1ZmuW6gE+SmOxfpI6VbhSam7C+v5nB0Hqtle5J?=
 =?us-ascii?Q?4DY++DP34tDJ2IbPbd2mpdN+GHbg8UDmi657soa2EM/BJM3HCobLa5ROtJiH?=
 =?us-ascii?Q?/Y4SiQYmwRhvTNj32jDD5wNWNTRwyKA0paUzW79UsFoKfvv7J6bU8sPMVe4n?=
 =?us-ascii?Q?TK+UeUAczLm3EDObdUcl/JswVzjFbn7c8O6jk11xjrDgBSlaIy23ptiJW9k4?=
 =?us-ascii?Q?dGir8hXw45IiFb9mO6O9laWIpHourEZ8AjUSjbQujwg8srv+qaimeujgQlGw?=
 =?us-ascii?Q?2CDCcEmO049PlRcdx3foXQEC4y5K8Sl6fVZsf7PfoWsXD66QwrDPDPqsSS+p?=
 =?us-ascii?Q?9ZQhybt7GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c198132c-6e5f-4486-f116-08da1375d26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 00:23:18.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSnpdmTrCLvlzUFUlx0oiORYc1XOfz7IQEVRpTTdxoIN9T27rf4U9/nd5crbkJeWDa5nVY4v8Y1vxMenyndVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 02:03:26AM +0000, Zhang, Qiang1 wrote:
>=20
> On Wed, Mar 30, 2022 at 07:20:14PM +0800, Zqiang wrote:
> > When the trc_wait waitqueue timeout, the atomic variable=20
> > trc_n_readers_need_end need to be checked again, perhaps the=20
> > conditions have been established at this time, avoid invalid stall=20
> > information output.
> >
> >But are you actually seeing this invalid stall information?  Either way,=
 please seem my comments and question below.
> >
> >Please don't get me wrong, we do have similar checks for normal vanilla =
RCU stall warnings, for example, this statement in print_other_cpu_stall() =
in kernel/rcu/tree_stall.h:
> >
> >	pr_err("INFO: Stall ended before state dump start\n");
> >
> >However, the approach used there did benefit from significant=20
> >real-world experience with its absence.  ;-)
> >
> >							Thanx, Paul
> >
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tasks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index=20
> > 65d6e21a607a..b73a2b362d6b 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1544,7 +1544,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tas=
ks *rtp)
> >  				trc_wait,
> >  				atomic_read(&trc_n_readers_need_end) =3D=3D 0,
> >  				READ_ONCE(rcu_task_stall_timeout));
>=20
> >If I understand correctly, this patch is intended to handle a situation =
where the wait_event_idle_exclusive_timeout() timed out, but where the valu=
e of trc_n_readers_need_end decreased to zero just at this point.
> >>
> >>Yes,  this patch is intended to handle a situation.
>=20
> >If so, please see my question below.  If not, please show me the exact s=
equence of events leading up to the problem.
>=20
> > -		if (ret)
> > +		if (ret || !atomic_read(&trc_n_readers_need_end))
> >  			break;  // Count reached zero.
>=20
> >Couldn't the value of trc_n_readers_need_end decrease to zero right here=
, still resulting in invalid stall information?
> >
> >>The value of trc_n_readers_need_end decrease to zero right here, indica=
tes that the current grace period has been completed.
> >>Even if we go to print some task with condition 't->trc_reader_special.=
b.need_qs' as true,  and these task  will not affect the current grace peri=
od. Is my understanding correct?
> >>
>=20
> Is my commit  information not clear? Is this description more clearly
>=20
> When the wait_event_idle_exclusive_timeout() timed out, if the value=20
> of trc_n_readers_need_end  decrease to zero just at this point this=20
> indicates that the current grace period is just completed at this=20
> point, direct break  and  avoid printing stall information.

>Lack of clarity is not the problem.  The problem is instead lack of justif=
ication.  My questions were intended to help you understand how best to jus=
tify this sort of change, and also to help you determine on your own whethe=
r or not future changes can be justified.
>
>Please keep in mind that we reach that code when the grace period has been=
 stalled for ten full -minutes-.  If the system has 64 CPUs, this means tha=
t the interarrival rate of decrements to trc_n_readers_need_end is roughly =
0.1 per second.  The time between the wakeup-timeout test of trc_n_readers_=
need_end and the "if (ret)" will normally be small numbers of microseconds,=
 let's say ten of them.  The probability of this change making any differen=
ce is therefore on the order of one in a million.
>
>And the next step is to traverse the entire tasks list, which could take q=
uite a few milliseconds.  So there is is something like 1000 times more lik=
ely that the value of trc_n_readers_need_end will change in that loop than =
before the "if (ret)" check.
>
>Therefore, I am having a very hard time believing that this change is wort=
hwhile.
>
>My turn.  Is this explanation clear?  ;-)

Thanks, this explanation was very detailed.

>
>							Thanx, Paul

> >>Thanks
> >>Zqiang
>=20
> >  		// Stall warning time, so make a list of the offenders.
> >  		rcu_read_lock();
> > --
> > 2.25.1
> >=20
