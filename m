Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFE51CE85
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387580AbiEFAoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiEFAo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:44:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A48229C8B;
        Thu,  5 May 2022 17:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651797646; x=1683333646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=le1HwX4aWhCPhxa6uZWgK4CQaRyn8B0z2l0RWK4g2+g=;
  b=Hpn1UU9WdoI3RW+kIuUrB1WH90I1754Qvvb/1d/oX2DdU2Xe0bFFPY+H
   9zXFYc6XBsqZHaK3K1nXXqCUbzpUUuoyKEqtyQrXmp4m4V0RShZyRCQl5
   y0MEGq1SRWaz7XeJyC0B0BaN1Uf1wrSmujaEG01Mo7cxnUxAI4ZfGCnr/
   GWvc0Ub3ewxvXGBYjUi1/EWoPGK9FB/LEASYJcjgO1jjAXspGCaEof7R8
   E4Fx5LGHDA8mWQiASCNbyA5CskriFaUXV379M6zwn34it5Sp4dzhKj4v0
   0jIO0kiivviEl1svnn3jkeWwJHk8OBo5bf8/S3v7kXabnTII5kcTk99uh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267904463"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267904463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 17:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="621561934"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2022 17:40:43 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 17:40:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 17:40:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 17:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLCd/U/Fjwlsh3sE5GUdOc+H0PAWRohd1qNptdPygUrtN9JzMYiA1hs7VFKeVnZPsESwWT9IXdiBe0YeYgkCrtZ9nL7OgJThJh1VeOxeOfYBBQeOpQ9eSFAV5DTMcpvzXhutQoOLt5BGIalnRHbSHL7YuumRcVgz03kvQ3hPnDlgbfjriXJ+o1+ZmnMVS217g+GiJfp6cEamAGrqCVydlf7qUbe8XojnKlEp15OSvd5km2/19X4X72dL0CTnmt5pdLinb3LCLvaRTB+DAvdf0SbMCPmZteg2uqPanhSPTKQ+uCcMoE7Mz6NNNg5TyDFVOdpn5KTdPcujE7NQOypq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cXMLKinvdok1vP/d/j/WjqX37JII/EklJ+zCdChAK4=;
 b=cp3/8Kldf4a0DRuAHV6nSkqwkxZaV1xW8I0igtyz36JOPc/S5P85UjSCsdnBblugUE/gXH/yT0gYGb1IUZYB6U7zYh4ct72r4xsHip6H7x/AvMFpMDlj1YUOcW1wOxSvU6EKzg+bOH6vlgWoliNMjHK3gI/zqmv6MC9/wfy0J3882D7ui+k+4hnrbxBmCQsv9WPduQHLVNiha6gF4EznfNDVv0cdLtGZAgK1p9bEwRzLPX95ww3bu92w+a5E4SLZy5qJJXh+khG1HsDeomjGdmTSM0Jgqqg9v/7R85UePWwhOS1wdAqd+AXhhlwCw44z5N1dbHePJnpP6jLtR1/2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN6PR11MB1330.namprd11.prod.outlook.com (2603:10b6:404:4a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 6 May
 2022 00:40:10 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%8]) with mapi id 15.20.5186.028; Fri, 6 May 2022
 00:40:09 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Thread-Topic: [PATCH] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Thread-Index: AQHYYJkonORSfrYVw02H56cLgBUTL60Qq84AgABKvvA=
Date:   Fri, 6 May 2022 00:40:09 +0000
Message-ID: <PH0PR11MB5880A25078A7D4DBAB1267C2DAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220505155236.1559619-1-qiang1.zhang@intel.com>
 <20220505192956.GX1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220505192956.GX1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: fda34cdf-84f5-4958-0512-08da2ef8f98b
x-ms-traffictypediagnostic: BN6PR11MB1330:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1330FA8A3C687BD9DCD66736DAC59@BN6PR11MB1330.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Po1dRFBjYgiZ9b7ZM1AUCelQ4AtqWriR/ny3RpuWorNSPd1qW+JOYZPQKspL9vE3lwEvJFxbKxG+bMVEL256cShL3lSgvsURf7k9QiKfSeVEIIq4+XoiXfmLU5bdwgR2UEYP+fGcXqwHHWU9Gb885TG4Rylo3/jagsR9o7f/Dj4PrEY3Qf3Qb7T43atZuXYP+A9b85gFQrLpl1brQpljKU/T+DcYv9ehZsGafVOsbDmAFgXqbR0nh95NmQMhE0Q56VnIYarfj22peMkcEt1yG84ucJ7wDsmzwgjuT3ttRudqkSEFCXNRJS2QbHDhBsPPG0oeGjj1gtkjuaiCBuZbcd7RpwyngU39rKR0sPmLBkeBKsP+UJ9Qa4zgye+AoXmRUlOCrOlTyAPvE7cEA2PFR2WVqvJ+KG53Z1OSFBTPcRo1fr1JL0r8wly7IQoQpgQReBt6Qj6afYSDDAjls098ZQacdfp9rfUnLHpojVJGW8OpeK7YHxl7wtusjfmvFbrFfSMyVo4IWSJ5E3lAuVmkJu1cTj4MjcKyoDlDNxsbgr5Jdsfei6LP6JmsnrZVBLiCUWaclZUMz1lYvZVY0iOePD/JVTlAThP3xaRAXa6yL6SwbdHUe3x7B3szlDXsAsbyUSsPtK8GEvyBVfpb9NPjI3zW42lt4mB5So9RfZpGS9816aalCL5ZuX4g2R4Yx7IwLEI6U5dhdyKXX7Kmo8tnuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(6916009)(122000001)(66946007)(38070700005)(26005)(66574015)(9686003)(76116006)(54906003)(86362001)(316002)(4326008)(186003)(8676002)(66476007)(66446008)(66556008)(64756008)(82960400001)(7696005)(71200400001)(52536014)(6506007)(2906002)(83380400001)(38100700002)(5660300002)(33656002)(8936002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+6R2oq1tT1JT2GrP2ho0JYJ1eqaTvrOZG1SpwBJ1dY4tHdUUjLNOEXevJsNr?=
 =?us-ascii?Q?ChJoWJIvfoOqCej3+pLiButczOIz0fk+wEOS8kzBqEHRal0BY7/mDH98pq0u?=
 =?us-ascii?Q?wS0tOrOFdeW6pMox6YfVJh/AUMijMViQmZeiJbRR9yttmMJqS0D/apfuYKOU?=
 =?us-ascii?Q?2SMi2YTXDlhJOjmY7ruieqnzURSgucVCwDx6vqLkzHcUOU7zqKpd5MAGyOcB?=
 =?us-ascii?Q?mXEip9kedRKmWrfsTuC8t0J/HfF+/6hixhSRSHFXkibFYAvHn2HD64DUWOFm?=
 =?us-ascii?Q?gvivEXZB6syqIExiZ289fBZQEp1NObpHpLSCbaiflUrndb5ZrG3YPGe2bpyD?=
 =?us-ascii?Q?YoLN+BVBAdSwUEWfOqb7l1HTdG5UFSMQ4HbcmhZIHw77IDh+bNt1bqkXN3yo?=
 =?us-ascii?Q?wqnJBLgE0xXxed5+Y3e0MQa1Sq7Qt+JaV1OTxgf/+5Dif5pL1RhQ61znqRzK?=
 =?us-ascii?Q?Cz7JhsHD3f73g/zEoxGL16RqtrEMB7CSlaQJePNX22btcnN2uQeDzHXEAjBw?=
 =?us-ascii?Q?ToXx1UPd9r0ME4Y1oekkoOw4KiV1X5R2+NZeJZPN/Edv0PuTullIIg/ODNmg?=
 =?us-ascii?Q?s08cZw9tX8iafgl4bzi6dEmdS7QMJVeMZkG2C8emcK90nJXhUj90gMOOQZgg?=
 =?us-ascii?Q?ADCThzbI06ggMmsJG3+fN5CMqFeucFR+ZSKq/ThWt46w7q9gG2Mp1kj5xfE3?=
 =?us-ascii?Q?v4wpGAymEKU7tI5Luoxq1JgkH5KfcybNailn6eg5MM7eaLZilzrHfRCyt/Xg?=
 =?us-ascii?Q?NhmaV6a4HW7Ry3dSLhtfeQwhqwfctdlHbzn6qtT4v//KyLdnsh7Bs56SADRT?=
 =?us-ascii?Q?swKrsBdF1u2zPy7Msrwzm5Ui3uOufnf8oSrQ5tSnx8lpf2/8IfSqH/pYoHcM?=
 =?us-ascii?Q?EPAs9lrsSL8OJfqW/Hq0RiEy5e4APTXJIhaACSNSw4X6JqbCfsbJBo8SzVy5?=
 =?us-ascii?Q?5VACZqwTQeorjhyipDBfk3tMmYc7Vn/gj4shuaTA5mU6bBUMzNoR/dN9pmfj?=
 =?us-ascii?Q?7l9x+NoFtDzjhV82LBXZTWDIhMJYzehxJJ/13UIn1dH8vUOvaP84PTk8zwy+?=
 =?us-ascii?Q?+Xd0+1LVNoXreV2T5tX8nw4g9zPhZpSNlmN4qozyy08EvwpjuKhjTcYuf0Dy?=
 =?us-ascii?Q?21fC5tDYFsRO8RLBDwkVoUQ6A9N/yS/VXuSQQ/+06hzwZkOpEbq9KQxZAefh?=
 =?us-ascii?Q?pNnD1bDXsb530kb0wmp0ItCKMca0K/jhWQdn4Kvybl7wzepDF37cd0MSBSWp?=
 =?us-ascii?Q?lNki6N4qgKxEkhaJ5CaDhyUXD1A0MHpHzBGbVgQcwWbTEya4mBDV6Y1CyGD3?=
 =?us-ascii?Q?iMsNUGNy1quKo90UCzrRRUKKENV3MbA2lV4+pRV0ADmyCXnN7Cxn0KxcfPUE?=
 =?us-ascii?Q?2fGL5wOwq1SBK0IF6h7NJ7TxhxeiXEbSGsNOWJIpCb45mkRnzt36Hr4A0dss?=
 =?us-ascii?Q?Uc87+CkSqhG1eIW9p/vJsQyWeszLT52TohtLUUOFMLhLxC5oYgBcabq000TA?=
 =?us-ascii?Q?hgFf/RaKesDOaWQfNo3bu1YopxMWCC/s5TTF8Jp5cRcHtN/rs1r6u6imUmwk?=
 =?us-ascii?Q?EnmCvQZlijIP+UDhCiWPfL75SieBU7R+L95XE1gY3Mj8opURKP0dPk4CTIy6?=
 =?us-ascii?Q?7WZvl4tUs5gOWp/FOgCfaoJwr/giqf27YHtLu9PqCHH512eu14lzj+oSkN6P?=
 =?us-ascii?Q?zo2MJsPhUNxTKAbVR/TrTYdXhLOaI7DWA5JUEM70BCdNx6cMtLl7bSKZ6cV6?=
 =?us-ascii?Q?JwSyRatRfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda34cdf-84f5-4958-0512-08da2ef8f98b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 00:40:09.9282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3OIc7K1TEOaOiaPDaH6RYqMG7HfujkmH5JrzmTEOYO9QTSQ6zgKsAQDeKZKiThHHBq9S+GOSTkfjfvfMbHWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1330
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:52:36PM +0800, Zqiang wrote:
> Currently, the rnp's cbovlmask is set in call_rcu(). when CPU going=20
> offline, the outgoing CPU's callbacks is migrated to target CPU, the=20
> number of callbacks on the my_rdp may be overloaded, if overload and=20
> there is no call_rcu() call on target CPU for a long time, the rnp's=20
> cbovldmask is not set in time. in order to fix this situation, add
> check_cb_ovld_locked() in rcutree_migrate_callbacks() to help CPU more=20
> quickly reach quiescent states.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

>Doesn't this get set right at the end of the current grace period?
>Given that there is a callback overload, there should be a grace period in=
 progress.
>
>See this code in rcu_gp_cleanup():
>
>		if (rcu_is_leaf_node(rnp))
>			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
>				rdp =3D per_cpu_ptr(&rcu_data, cpu);
>				check_cb_ovld_locked(rdp, rnp);
>			}
>
>So what am I missing here?  Or are you planning to remove the above code?

We only checked the overloaded rdp at the end of current grace period, for
my_rdp overloaded cause by migration callbacks to it,  if the my_rdp overlo=
aded,
and the my_rdp->mynode 's cbovldmask  is empty,  the my_rdp overloaded may =
be
not checked at end of the current grace period.

I have another question, why don't we call check_cb_ovld_locked() when rdp'=
s n_cbs decreases.
for example call check_cb_ovld_locked() in rcu_do_bacth(), not at the end o=
f grace period.

>
>If so, wouldn't you also need to clear the indication for the CPU that is =
going offline, being careful to handle the case where the two CPUs have dif=
ferent leaf rcu_node structures?

Yes the offline CPU need to clear.

Thanks,
Zqiang

>
>							Thanx, Paul
>
> ---
>  kernel/rcu/tree.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index=20
> 9dc4c4e82db6..bcc5876c9753 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4577,6 +4577,7 @@ void rcutree_migrate_callbacks(int cpu)
>  	needwake =3D needwake || rcu_advance_cbs(my_rnp, my_rdp);
>  	rcu_segcblist_disable(&rdp->cblist);
>  	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=3D=20
> !rcu_segcblist_n_cbs(&my_rdp->cblist));
> +	check_cb_ovld_locked(my_rdp, my_rnp);
>  	if (rcu_rdp_is_offloaded(my_rdp)) {
>  		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
>  		__call_rcu_nocb_wake(my_rdp, true, flags);
> --
> 2.25.1
>=20
