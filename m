Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC2A542436
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiFHD2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiFHD01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:26:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5781F77CC;
        Tue,  7 Jun 2022 17:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654648949; x=1686184949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E+3lgMWorKRwhWmocRwq6TC9uUTbW62VBShWgNxEO0o=;
  b=TQjbqs8D5PMxMKLCSM/THuC0TbQ1j+EgImKY7ohNb9/ZNeq7foHoNrJe
   tm7CV2XSuh5qs5ludCjKnfsjeM8sif9/GEXlg+CeIDSPE9n4PPGUTax0E
   y5TMTJea/TqN2CuxTgHgxpWJgDaGa0FvnEvywZ/hBwVA4GqXjuOCOcCeS
   v2ZOrkysUG6XRI/Zm2tiVJnhuivY5qI6gJrApRuf58NSTzQPG0cBRzj0Q
   WgzW7w51K16b7V+EUe2lRPvcJOJLq8jeyW2X57dtSfxjFL8+fNmqAoBIq
   nonyinLQz1Ym2PZnjFKYc1jEK5xm/5Q9kEv2rBhsh6PSS8xeOQgaNbIAY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="276807366"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="276807366"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 17:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584496143"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2022 17:41:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 17:41:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 7 Jun 2022 17:41:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 7 Jun 2022 17:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2hX0diUgzCUzD21/d7wxEhMHzGw5GPSXDIQ1UP+A5t+xtKIG5BUaZGBoQOQ7QV+wpyCnmlkc7ppRMq7DfZVTB4/PFev0JG9hznC0SZSYKOsdCKHdXl3jQSOkYz8+QqgYiU6GWXjy4x4yTsQZ9y/E5ubkg6G1Qim14OUvhqMJ0tlxmApg7D7wIEwnnEqdXrFidz86YoJ6FACsxM123ikHjCjD2bC3AzFnPoVBW6Z8EkNw8ZPZZjIte/duARDp6fQnr+gXAawVXWnfhHJ9W/8Kp0ia4Ery2RFkpQ2ALtdel38P29CM/ZhSu9Xj+76E2eE8CF4xoyWOYLyK0rN7VATqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3eo3uQgE/Qg3Ijj24KyeG7DWUVu5PPoKGwBm70o6jE=;
 b=k3EBFnF9849uJztf3U7OQsbdocLuqJAiQsvGjRxpnbKMpTHjhTRBkURNFTuo1weoe98mZR4Py79el8mFRkGFWYvBysLcUwPVtvHKFsqp2jaXsGjbV50/tAydfGhD0KSJo/PpBTtk4WIK7KvZkmNt01nbLukPVQ5U5MgtfRFAnOQjOpvGPMqLX+lodbgDVUjDzsyaX4OX+a/mLtN0kDXd5ND5xHenQK+NW+/fDXv93MyVUgf8gfq/gsNcbycavKCUgRwQ5ji8S6Ig/Yr2cvovX7nblQx4MPv1VyOG6x4BegGSpCUTC7kjjXeOS3NffJ3iv1CPqMjrQMk1G3scZEgErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO1PR11MB4866.namprd11.prod.outlook.com (2603:10b6:303:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 00:41:29 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 00:41:29 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list
 is empty
Thread-Topic: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Thread-Index: AQHYekOLcM/pjDOLHUOfGqJWFKxX8a1EH1EAgACISxA=
Date:   Wed, 8 Jun 2022 00:41:28 +0000
Message-ID: <PH0PR11MB5880551F642B1490CEFA65A8DAA49@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220607075057.909070-1-qiang1.zhang@intel.com>
 <20220607161620.GH1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220607161620.GH1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 6ec60214-16d5-4278-4e31-08da48e7a04b
x-ms-traffictypediagnostic: CO1PR11MB4866:EE_
x-microsoft-antispam-prvs: <CO1PR11MB48660AA352A325AF373C7AB3DAA49@CO1PR11MB4866.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L5XgC7EtevK2Yvd4N28KmQ6kEhKv4U2qDARAAW/bGl3Uqb9LDG5MeN8q23slGpQi6t8ZdYUCb11QBxZeg3XWnxt4VG+utHApcEVrN/y4oqha3YwN6yZY8qrRr/+lamtesMF5W0GtZYOi56/wOVFgzw/qy8gy+9X7K2450yJQC0gxj/ZPW/0kiHHVZgy32fNLiyufAe6PwKnsaHLf09l825cInovFu2vbVr4Sd1RrsB59Y5NVdgpDqdFhZ0P0aGmCNECVw2bbGwcbW5YV9TrZZ9Ut4eUtL9jCtilXg5dHojDn3gVBh3QCSPuGWN8dpAK1QD1uSFVEO4Ep+3B+jdjUOzzr1/d7bwvWPQ6W+Ob/JvNGBDrFdPJhJpdzYT1cKJkohse4aS3qHdae9YD9QyAiqSw/VJox3yqoCKu2ZG0spHhFLQz/SUVs4sHThkMTcSssbY1LX8/B8agtscGZeLwvOOmFQRCpCxMnkybUwn5NFBLN+4q4Br9otoRRpUeaG/nTE8z+0t3GLa/mBkP90kdel2chwQzTnETDZuq5D7nX9gyovPWhu0s5GdDs4FSpw7mFAlp9ko3JAIalpDTaWX8VZ7i6yruXUHasniP6QGs74hQoJePxPspP4nRhErwwXjCIVanWE4TO/PhZpJl23p+j6DfJ1nyXwlF/n6DRCqwCK1LlWNVzj0FIBk0z3NTO9FfLKXEsKm8cHHcNg1Wr7kqWFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66476007)(9686003)(38100700002)(5660300002)(186003)(6916009)(8936002)(82960400001)(52536014)(71200400001)(26005)(33656002)(8676002)(122000001)(86362001)(2906002)(4326008)(38070700005)(55016003)(83380400001)(66556008)(66446008)(66946007)(64756008)(508600001)(316002)(66574015)(54906003)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/hJXIqX4s/8e5BR35X9/5csN/7JYseCLGM8TrbLXk6wfpZr/ASXnfD+gUF28?=
 =?us-ascii?Q?Npf4aeUbKoJ1Bj22jFG7pGGms2WX5SoaPDntoYkCg35rVM8NvNnnljtd14SS?=
 =?us-ascii?Q?GIoXWxwhGMf+oW6K86T9GDXdYBEzFQ/Dj8D5pZZvnQ/v3u99Gz0iBd6vdm9N?=
 =?us-ascii?Q?OqMnsyxb04ys3BIeZ4NIiq388ApMYpbtB2f01Ou2oGO6L/i/yMx57FtYgQe6?=
 =?us-ascii?Q?4bKTvqtcc1hHuBqQnWV0vMA5TstK4xH2+15OrJJlwTMtsA51s01QqChjs5mm?=
 =?us-ascii?Q?C7laBULRCs5TVFB1LlatRPdmWXQ8kvxwbnSArt8iH1c1biiy8aD+oz9Zzqkj?=
 =?us-ascii?Q?szBF0/0K2ySqN6/eqR4KWmixUzQhOEk46UT+x+idv8KEM7hb2SyFg3BTBwmp?=
 =?us-ascii?Q?uQBbmo9Qg4Vc0jpvFNgJV4zAK7vJoz3M0Kok+jJ267d3vi/PAfiM+Xn5HNQ/?=
 =?us-ascii?Q?bnUvzoHbDAfDqXJECiVdKk0Pr/BbwEzisU10kQoSkgcRP/oDa4UgsvbPO62P?=
 =?us-ascii?Q?jkGRzG7eMRQk0zgOGsZWy0Yf3F7XNpnpSCuZMD0pc64EBWP2Xy+LJUnsqu1M?=
 =?us-ascii?Q?BTWECgSiKPGtw2BYJIFIK4LQb3jXz/T7bNUxfehKyjA2+5fYb1CPvVqxoPxF?=
 =?us-ascii?Q?TUlTm/Hcxr/AkngkoqLN9muJenfy1DBOgLC9OryzHfF6CUDVBWIsbU9eQ/6e?=
 =?us-ascii?Q?XeOU5FFOHJnHwTOCY97iHnpA9xb9h+VI0l5lhwzzzmXQrI7ypyDVZnh1y+cx?=
 =?us-ascii?Q?cIa/qooCA7cQ/CDXCp1HDMIUk9ydUoOggwAS+58PdlejR+n4Aa1bsB1FTwpq?=
 =?us-ascii?Q?xdbuo48iaXP4mDk1eLqIaBFydiSxvEfpMWHRApaM0jv/0KaNwXr0E+ge5Czh?=
 =?us-ascii?Q?LYv42NQdko6T2T7P6PsnC5F/IHeWk6h5yfSMNP0NAmrLN2MlqvSX4nZH1G8W?=
 =?us-ascii?Q?uugkD6VHNyyfrmt+B2JUV8t4AP83pbITu0P73aoTe8pRnsywYKvLaj99z3PQ?=
 =?us-ascii?Q?595Yn6jktEUaMUboZUdWn4LTtGub4uayiTSsJYEc29Pn0Nccwze6pJ1gH8gG?=
 =?us-ascii?Q?x4rlh811rWttrl+zubjsat4F0EJ0ANnsowbssz2iziqmx91zooPHqDhXFCaP?=
 =?us-ascii?Q?BbV3w34evEcnZ7gb0B/N27iEzDiYccWIuodhBJ3dr790kBqqmzRNZA2gwK/J?=
 =?us-ascii?Q?qG4fL8rj7aCSrPum/CbpPkJU5nf3NZPinoNaochhbSoSp1nJg+e++sfvFCQY?=
 =?us-ascii?Q?h9pOhzoQw2mqA2ea5SyxYslge1Oeg358sJQRf7kiypBM4qr0iVpWxoms226h?=
 =?us-ascii?Q?VZAPP+ECev7tOmRkk0t5+VSS55IQFSQMDrGKAHYncrasHnGbISztsW7V+MyM?=
 =?us-ascii?Q?nFvcdMjfHlqjKP2157qEUns9/Zzn35HmW6MkLkB/vm6Be6wb4hphzTURe591?=
 =?us-ascii?Q?ADuih+tHzV9hBjnZZxhPzmOfjqyI5J35EFqPbitiTS8l+qnhyYM0TJOd0pp0?=
 =?us-ascii?Q?GvXTnavglSueEwbTXx9EKxeppfwtuJB4nC9QaUpdtpmV4HKRiBGskMeQHsaQ?=
 =?us-ascii?Q?XGl0sA8ZsJwviQQrNb84sDZo2jJ2EfExgF7Pnaz3cI4up4tECAYOyileshAQ?=
 =?us-ascii?Q?RBcJfxHD8KaIJ9pbbC2Hq1/67Ilvj2N48hVKCsuVlTldkWOIZlkD14EpP36k?=
 =?us-ascii?Q?CBbd0ykao0LkBfBBgKD5Ydrw6nKvKxIL7DjlxEYn/VjmUjNEEiTxNUmJrGsC?=
 =?us-ascii?Q?3RWLJ49dLA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec60214-16d5-4278-4e31-08da48e7a04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 00:41:28.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQnuZuLVOMhwtOQSKd/SEuy/XHrwahynPyxYschbrKm0dkarwgSMOoTpt2FkHenB9ecztpAQNj6JBckBmosnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4866
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:50:57PM +0800, Zqiang wrote:
> Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog=20
> kthreads enter polling mode. however, due to only insert CPU's rdp=20
> which belong to rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp=20
> served by rcuog kthread have been de-offloaded, these cause the=20
> 'nocb_head_rdp' list served by rcuog kthread is empty, when the=20
> 'nocb_head_rdp' is empty, the rcuog kthread in polling mode not=20
> actually do anything. fix it by exiting polling mode when the=20
> 'nocb_head_rdp'list is empty, otherwise entering polling mode.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>This looks a bit more plausible, but what have you done to test this?

Yes , I have only tested as follows and I added two trace events.

+                      trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EnterN=
oPoll"));
                        rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
+                       trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("ExitN=
oPoll"));

runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 4" bootparams=3D"rcu=
_nocbs=3D2,3 rcutree.dump_tree=3D1 rcu_nocb_poll rcutorture.nocbs_nthreads=
=3D4 rcutorture.test_boost=3D0" -d

Thanks
Zqiang

>
>							Thanx, Paul
>
> ---
>  v1->v2:
>  Move rcu_nocb_poll flags check from rdp_offload_toggle() to =20
> rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of =20
> rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set  the=20
> rdp_gp->nocb_gp_sleep is not used.
>=20
>  kernel/rcu/tree_nocb.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index=20
> fa8e4f82e60c..2a52c9abc681 100644
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
> +			rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
> +		} else {
> +			/* Polling, so trace if first poll in the series. */
> +			if (gotcbs)
> +				trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> +			schedule_timeout_idle(1);
> +		}
>  	} else if (!needwait_gp) {
>  		/* Wait for callbacks to appear. */
>  		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep")); @@ -1030,7=20
> +1034,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
> =20
>  	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
>  	if (rdp_gp->nocb_gp_kthread) {
> -		if (wake_gp)
> +		if (wake_gp || rcu_nocb_poll)
>  			wake_up_process(rdp_gp->nocb_gp_kthread);
> =20
>  		/*
> @@ -1152,7 +1156,7 @@ static long rcu_nocb_rdp_offload(void *arg)
>  	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
>  	 */
>  	wake_gp =3D rdp_offload_toggle(rdp, true, flags);
> -	if (wake_gp)
> +	if (wake_gp || rcu_nocb_poll)
>  		wake_up_process(rdp_gp->nocb_gp_kthread);
>  	swait_event_exclusive(rdp->nocb_state_wq,
>  			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
> --
> 2.25.1
>=20
