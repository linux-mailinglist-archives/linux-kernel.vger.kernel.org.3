Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8453F79C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbiFGHsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbiFGHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:48:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3F6A047;
        Tue,  7 Jun 2022 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654588129; x=1686124129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9EDHcurk/XwyJsjIhwutl0vBVMagZd1ffghnYWbBv0U=;
  b=iuGRJell8na6Gcldo9hqtIKertg5rOtCeff51qCLaQgouAIj3c4M9kYe
   RCAVJGdIlDRhH6sYsrrgIEzRiXEmSLKlukdEJY/Bd9L1kOKcxEl1WOEZ3
   KScPqIdV5pBjljKunLo0x38+C1HVn0bjyufGNMTJtrM2WsqqUCpTOWKWo
   s3VaaceUunmXzA1XV7Cd3+7ZjMAzp/oJna0cKQ4RZYXevSZyPmZiX+zeC
   aufbRZv/QZxGL5w4wFFN0+9qwMyGRrMWVuq7GM/QVK/ocizEcS60heGBm
   2QO+wT4oocRdhCyxifrLKhG6lS1SL5SBV/nvyjZ2JXSMOpZaXgq5uirhL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="302073298"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="302073298"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="906933822"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2022 00:48:48 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 00:48:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 7 Jun 2022 00:48:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 7 Jun 2022 00:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHjT5+gUcRvmjm6ciJT5xlZ1waRb6RhAepDJNGGkq7NOcnjcUXDs5WQdiYG8R7Svq0n01J6VGs21IPGGvIAsjqzf2rco7NEVTcDBh4Ol9o47VeNGxJ7uuqrN9/ylkAXb4QNYSGb3EzI4FpyU3iwQTxUT8gyTXk7Ypx16u2W25P6AwaXA4I3UbPNdcNdzSZXI7ss2UAP6Zr9x4JD+wk3j6WeKhH6ScQ/RMtdnB3CkDtykBMFzoLutuy8xC0bepVdAZ1EA4NL4aCZdEsR+fPeuJia6fy90MX4wWtp4tdhj8J0F42r2X96FPZVbzklHQE6z/Fab/hpo3MwbXH0YZJ0b8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTUBx44QMNujxxAncebyYnTn64ncfv/vlX24UPHW8uY=;
 b=PQMHrxaKFbrQh/PyJs3lTD17FXptUw+0T0a2ZtAEyBEeImkLNHmXOVL+ha92e4EPjoTVmG1l5R4XRW7mLqnx9YEGF2mfXUJy2IPbqv2w8DSVCFL4dcK9Us8515Dhey+R8Sgvbxm16y6YxVc3NzB3Rl6x4E6/FaKPRtgZRHVNIskeIGHXUaROivP0L/kAQOajkCz0R+DEoT+8rpuLSJ5f3BTWP1hCu8gNt7MlyMgcUCJni/wBFKBFgrHJYsdXH5ze0k/lYg9JCeWiLH0xZwj+CBDDoxchietUIBHlp3fH5Nq4/PDUT68bwAfuZPaXMWAU5TvXdm7B+crQ1qc7rbF1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 07:48:46 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 07:48:46 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list is
 empty
Thread-Topic: [PATCH] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list
 is empty
Thread-Index: AQHYeXI5H5YncmAjikSEu+RpfpipgK1DThGAgAA4QfA=
Date:   Tue, 7 Jun 2022 07:48:46 +0000
Message-ID: <PH0PR11MB588036820D594BA4FF814398DAA59@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220606065143.3159643-1-qiang1.zhang@intel.com>
 <20220607034133.GC1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220607034133.GC1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 2c8ff4c3-7af1-43c9-372a-08da485a273b
x-ms-traffictypediagnostic: DS0PR11MB6496:EE_
x-microsoft-antispam-prvs: <DS0PR11MB6496C8E10F0935E5F9D3DB59DAA59@DS0PR11MB6496.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inT/9XGhP6tPvz4A/vxBJfP+xBXu1ZAeFlvJMBGOPzKznNROOtT17htj17nPpt3XqTZ6pfO7pcNs2uOSu6OhC4OFB91/3irMzWjXPyAR3d9WQQDMBp9jkyfv4FROREbtUnygcQzc7WSTScVuU+6Xu5qOFcBiQsJw172zNNbHenk+3YQK1thW1zHmXz7C4pTqkPvHJgKOukGTcR0B4xr1TQ33mplYXQdXWkuj/DXnIbxKlV4XYtRen9HNKIZYFbw1QMRjBeugflHR8HPph+aU3MGeYd0lCAkZe5CiZJKoJeYKQaEqM/Mi0bfcs8F2ixJDtyQMhPeoNV0p9KP6L9rCxRmxJqBkHfxBUDfmI32VnXCrFoC3+KyNIqr3UStRu3tVLGQ1r5ZEDKTfROtupJ7+UwgRMPBYJNAVsorXJlURcsURSSTTh2y9Ix4AJWNXOqkC1gDLDB1nmctt9BBiKja+NNEwMvfRKeRtH6RZqwlGIlneHlhGP8Ydo5JNygKVnwOUApwmcVbuWQkZ3rnyHTDMUoEk47YLCVrbLx2pd9mAVES1xbVZqq/M1VJPguoC747rHFS8Ewj/tDph8GDrBOA9MlHm3+5qhLBQmPCCm+fkYu4XpWXBhb0DCangG4Z9QEuI/6Svvxc68Bb/lTZGx3/MM20CjNoBvyoOkf3qEBbPOKHWBtW6P9Jc0J4A/LKld0CmNUVUovtIK14RGHYLRm2PIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66446008)(38070700005)(4326008)(71200400001)(6916009)(54906003)(8676002)(52536014)(5660300002)(508600001)(86362001)(316002)(8936002)(66476007)(64756008)(66556008)(66946007)(66574015)(186003)(83380400001)(7696005)(55016003)(2906002)(6506007)(76116006)(122000001)(9686003)(26005)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YhRtK7TKaOjSS7elebjtR+uYlaMHkZcXJ4Q+MeIiPgZSrALE89HPCYQ6S3B1?=
 =?us-ascii?Q?Yos/0jHkF6fXoq92Q7l3qgQea12Ctb7I0aTbRngyVYAtOB+VLlt372D0cN4+?=
 =?us-ascii?Q?Dv0ZRq3O79DqLHXjFTMmYqxH92Pit4QHwNMB0fqxGfRA1HBhSduQFYaLgzBp?=
 =?us-ascii?Q?5BxdxYWQUxFiEq/vCxbHGRwJAWSfIKqKTzWKAPgB78z9GwP7F8kCDwQSgdjM?=
 =?us-ascii?Q?Ja214ktxjHo1xHKEff5/RKGdtQiXrT+kyvDQ76UQF24TJ4F5kfzM4cnEpmhn?=
 =?us-ascii?Q?CHFol4zQGY0gOrSRdxNEB5ZDVPPyFDYb0T3c2tD/hOiJJlviYbTpYKCysIed?=
 =?us-ascii?Q?7PZbfogulAO49LBFKQqxBJjIxB56f5HocNLSa2tvZcY5WnSVhrI+0y5p5gyB?=
 =?us-ascii?Q?L1r2cSbFDFWseQh+SOM+XWnSlm4ol38x1heu4Y66SC5gzWhH+NEy2HqVEAbI?=
 =?us-ascii?Q?cGhkQsNztB7YmrWest8egA22Ao+IkGzO1Qg1L0e9t+1jFQx6S5gdd/ljd4As?=
 =?us-ascii?Q?eBOhWfzLMKqfQxvOnYXBkQlNuLwQke57S53Hmvep33Jm+KJiyXGAxXLkoTMg?=
 =?us-ascii?Q?SmEOvSCrP4H5v3gxuuNtiuoRSvLJ1WdbxkKM3ikzuIDFNqpt18JKlyty9aVQ?=
 =?us-ascii?Q?uGdzJppGM0B+/VgiUgrwEYEqIJVZQYSTE2NZ+Pg9pzj5dVH+A5C7GvcMV4DE?=
 =?us-ascii?Q?DjrE2CwRXH5mx2XkkBw7gzbFrSysUH9Aa0NIhHQY0zYhS9ag/+Xuk6S9vOxr?=
 =?us-ascii?Q?RiJPoFkdRO1cN2Ukiowf/WgdJbxAUKtU683d3FhoQZFjSBJ897M9BvznAUml?=
 =?us-ascii?Q?44WIcYnGMbQVnNI2Ovk7G1YyqIMaD/FWrZsTtZm9e/ArllrN6Al3ERZ5Uksu?=
 =?us-ascii?Q?/p72UPv4ftxPva3YBWDTWPM39rraCATL8kwL56khxbNJG769+Cg3hIbkXehm?=
 =?us-ascii?Q?O4UwrDfKvNl/d2hcOmjOD8g1w+SvGSn9ysCYFyoT2Un+XpQrU87fYiqKO4Up?=
 =?us-ascii?Q?nxSBD6bQxsXlaFKwnDIxPIyhPm07lgm+S+Fq1pU4bhjiJbeH8di4I1dM1HBf?=
 =?us-ascii?Q?B/3jzrJFg3HRNHnIgDfgWB3CWEBI50wEkW8eNhfLGl42Y5YEFwBw7g7/mtiC?=
 =?us-ascii?Q?sru8wnfyvcyDFv+kvXwJwRYhS0YNFVMIPGbldbsI9MpeiCxf7sSkM6vH55f/?=
 =?us-ascii?Q?T5hHyR+AaLli+FjRJtdlhzGpEgMNV603141Ur95vHBrQN0ysW6ywlUDGNcJa?=
 =?us-ascii?Q?as1Rb7I8PFYXHcoTwabplwjoNaAhyqFXltSZWyEgNsV9U2FCHqoaCVafXunv?=
 =?us-ascii?Q?0j+dnFu+x/Mfl95jqOUzmWwXgqZ7Vl51XsJ29LsY8K11W0pEtYw668rom/lY?=
 =?us-ascii?Q?g5zKtspMNfylGD9HwxSH5m7CYPjId2hfKqxxTPw+MSo/sI7aGN/CeTmsRCC0?=
 =?us-ascii?Q?tKsvP8Rmd4qi6sHk5ATcuRAqo32Rcwdb6xsgNH2sV2e3E977seneqZxMdqnb?=
 =?us-ascii?Q?0rHbCZTMF242kIZXCcZr07LJpPbwwL3KTqqn3S4m0rteu2D7/1lWthBHINqU?=
 =?us-ascii?Q?GQDdgQO/6snuYbweMQBGuaQA6uiLLq5KbP2BBFPUjJa3+hKGNv9q7R62TqWS?=
 =?us-ascii?Q?2MBqYhmBLNfoRw1wSYwCgnuAvFn+F7mWuLBFkZdXn2MYE8u0+ayZP2JNfvrM?=
 =?us-ascii?Q?Qr7wlUX7WbErbEvchAezMBXBtUGpeitxfVX2i0shP8vJh4d94JZaFHAR9SGh?=
 =?us-ascii?Q?9+tyuYMqsg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8ff4c3-7af1-43c9-372a-08da485a273b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 07:48:46.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uD+jARXzGwZofxCOzzQajHZU/Z9H7tO+lg5j2xr5tOwt9YskYCNAg6Dn4OVjDMJ3XkG2EzS4r+3wn9EcHnC1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jun 06, 2022 at 02:51:43PM +0800, Zqiang wrote:
> Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog kthreads
> enter polling mode. however, due to only insert CPU's rdp which belong to
> rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp served by rcuog
> kthread have been de-offloaded, these cause the 'nocb_head_rdp' list
> served by rcuog kthread is empty, when the 'nocb_head_rdp' is empty,
> the rcuog kthread in polling mode not actually do anything. fix it by
> exiting polling mode when the 'nocb_head_rdp'list is empty, otherwise
> entering polling mode.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

>Looks promising!  A couple of questions below.

> ---
>  kernel/rcu/tree_nocb.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index fa8e4f82e60c..c25c3e3dd22d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -698,10 +698,14 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  				   TPS("WakeBypassIsDeferred"));
>  	}
>  	if (rcu_nocb_poll) {
> -		/* Polling, so trace if first poll in the series. */
> -		if (gotcbs)
> -			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> -		schedule_timeout_idle(1);
> +		if (list_empty(&my_rdp->nocb_head_rdp)) {

>Do we need to set rdp_gp->nocb_gp_sleep to true in here somewhere?

When rcu_nocb_poll is set,  the rdp_gp->nocb_gp_sleep flags is not used.

> +			rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
> +		} else {
> +			/* Polling, so trace if first poll in the series. */
> +			if (gotcbs)
> +				trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> +			schedule_timeout_idle(1);
> +		}
>  	} else if (!needwait_gp) {
>  		/* Wait for callbacks to appear. */
>  		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> @@ -980,7 +984,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>  	// Queue this rdp for add/del to/from the list to iterate on rcuog
>  	WRITE_ONCE(rdp_gp->nocb_toggling_rdp, rdp);
> -	if (rdp_gp->nocb_gp_sleep) {
> +	if (rcu_nocb_poll || rdp_gp->nocb_gp_sleep) {

>Is it the case that other than when (de-)offloading, the rcuog kthread
>is never awakened when rcu_nocb_poll is set?  If this is not the case,
>we would have spurious wakeups.  (I believe that rcu_nocb_poll suppresses
>those wakeups, but it would be good to check.)

When rcu_nocb_poll is set, only when (de-)offloading,  actively call=20
wake_up_process(rdp_gp->nocb_gp_kthread). in other cases=20
the __call_rcu_nocb_wake() will wakeup nocb_gp_kthread, but it met rcu_nocb=
_poll flags
directly return.=20
In do_nocb_deferred_wakeup(), although there is no rcu_nocb_poll check, but
rdp->nocb_defer_wakeup is always RCU_NOCB_WAKE_NOT, also directly return.

Due to rcu_nocb_poll is set,  the rdp_gp->nocb_gp_sleep flags  is not used,=
 and=20
Not should be set.  move rcu_nocb_poll  from rdp_offload_toggle() to rcu_no=
cb_rdp_offload/deoffload()

Thanks
Zqiang

>  		rdp_gp->nocb_gp_sleep =3D false;
>  		wake_gp =3D true;
>  	}
> --=20
> 2.25.1
>=20
