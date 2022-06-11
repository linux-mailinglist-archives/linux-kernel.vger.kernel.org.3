Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63B6547228
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 07:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiFKFNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 01:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347980AbiFKFND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 01:13:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9943F271C;
        Fri, 10 Jun 2022 22:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654924382; x=1686460382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZKQHeQXLsCHd8winCjGb42Dzh/QXLG/BSJgTkUKeo3k=;
  b=a6uwhQxmBLyqrZF+BW3CzeLdmFEMYoQQ9IFGPxXfimiDA5D3gxIrtN3u
   Ydcub00I9FOyRnQ6Hi8xgzFObAndzY+7NuYr19nTWbaSqWmQg+nB0ubzY
   Ol6+Fc6dnSL/ejgBs+wzCCQZhunt9Bawk64W36nI2uRN2A8v7Df/3GS/Q
   JRBfYCL6BFznDSbyJD/wuf80XvEKv9HJsNqv/Bs+ys+DIFj9qXKKDU3Ym
   4M5sN0dD3FCe5UUyipWk1G8TdggnpZpOL3GC7AH3fos3QpeM/CxsYKfrL
   eRuBc15fmWShPToI7cwf2WmYoklN3nHZz4MtTgRhHnAz1zn0mT19xXz1g
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278953838"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="278953838"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 22:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="616791701"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2022 22:13:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 22:13:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 22:13:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 22:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCmtDjOgvx0Pc1ZfyHDioEXTAtlj+v77aXOH4wYaMMqEq4TH47NinX3AqkUxmdK5G1R+TVosNFfzDrjrKv8Yc/czIN8PwPs9pfupbJI+rUjx5/EFkuo6oDm9EMXCyQ9bZ3qpdlRvSiEOjwCSNZRM1um5+t8GIRzBOQiWpdNhAbTylk8SxL53npQ8SEE7uI3T87RLtIYNkVZK/zJrxe0noJzPfT6wpcUHDaLR8AAigpSh1F624CDVlD6or5lWtRBnq+qnqTKY0rZcs7rhjkdwNtXEyPN4vynCiXcZAgi4pXyqrQsnjRGABWKW/gebjCZP0aNO99WzmGL8N1M2L9oUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rYO+0stlDjnuSxZI37XcJmrI4Znaxxk7bvG+corRn0=;
 b=S7v70EVywizFDlBwQrI7a0MyWg/QJ25IGMr2RnS+uU87X0K2fwCaf2apGUhX1tolJyACWzu6r7gJOrmBmMpdEPE0RXrplsBQ8LRgq32+zgQ6VyGYZRQBGabuOxsRaGv31au0ZnT2h8FgW8JxyqYYdoQwovaZgo916Ws1Cs9bfl3u02DVP8bunYjLW3/4qaMT7Pb4OijWoJRxhg3j2xsLNEJ6lm2cgIoiCItpU7IdvCH9kOkPsed7VK6Qx3W05UXknSFbEPySx3a+8LXQDYxXVzlUjXUddrsIzidvCWhTyS9TLNaEyFxfFpitb9ndtyhJPXA4Uh44RkaKu+TPgJ4jgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN6PR1101MB2114.namprd11.prod.outlook.com (2603:10b6:405:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Sat, 11 Jun
 2022 05:12:54 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 05:12:54 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Remove unused trc_wait and holdouts
Thread-Topic: [PATCH] rcu-tasks: Remove unused trc_wait and holdouts
Thread-Index: AQHYfJUcbqLgXc0Mqkih46ww8iTtta1I+J6AgACx4cA=
Date:   Sat, 11 Jun 2022 05:12:54 +0000
Message-ID: <PH0PR11MB5880271642F637C44F06BA8DDAA99@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220610062228.2185104-1-qiang1.zhang@intel.com>
 <20220610183543.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220610183543.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 1b001b46-24ba-41dd-f49f-08da4b690a34
x-ms-traffictypediagnostic: BN6PR1101MB2114:EE_
x-microsoft-antispam-prvs: <BN6PR1101MB2114A026C7436D93C794FFA5DAA99@BN6PR1101MB2114.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKAL7JbLFzymTVgqtUT8NdQ+S3zJ1iGvvK0Rzd0G8Ik9ODO3PpPin8t1cwMva2KCr1KETL0W3TtfWBE8J6RaisrbKUKZIxf7zfEMr1BhEXiuYPdNozC2XNzCw1N1uXFmi7J1Dyr1g8MajScsTJeDmpSO6OZDVs1+6pf3YC63jY/b6ROAq469BdWBJI6ydeKoIGDnVINKWuQIgkF+0ga+/8PxrDi0zv1YrQAsP+UkQOOGr+muwsCFHIDqxZ9x3XjNNmI4dxO54WxW9x1Et7++mZzGpgMkTYMpy1ZV9hvkvZlrGdLso6858vHDW5MCfLiuzZ6HpqDUs4zaxMQ+QIsK8SrCqHpyRH3s1GZCO+Unuf//c2IkEWF2gfz+9WMohA4jTFysou7poOWuDiyFJGeg3FzvX/5uvWbMVd7fKj+TYVS/7qmm0ukdWCWwWeODt9D1QzSeI3thujilf4QrT2yhhNIsNZTr/qhDNIVvdsLOR1w+kjutdFaS8a19XkhMbKrKhlhzDRA3mN4MtoC/lSeJhooZLfmmLLzz5Ylg2P0NOWgy2LgFlSbm6mkpaoEspGNEM7C91nLjFOCXNaOAY0iMpYBtd7c3eSMs0vdjY6XMBtDtBmFsbKTTTSZ0dyFt1sZTbuAlkMoQ09DXWXXySTiP0KjitFWl5og0LrMCgaJ+IbpdpmoBF9Yo4wS+LGbAjR5cdQpMj7Tcw3DIIDhjGAz2zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(54906003)(38100700002)(186003)(9686003)(26005)(4326008)(66446008)(66476007)(66946007)(66556008)(8676002)(64756008)(76116006)(316002)(6916009)(71200400001)(52536014)(2906002)(86362001)(38070700005)(6506007)(122000001)(5660300002)(33656002)(508600001)(83380400001)(7696005)(8936002)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xo7JdckR8JrDh5RGccvvf6IAuodc+Ik3d9Ao12X7lmz4Td0LPITDVT37jEuu?=
 =?us-ascii?Q?WvCU6rXZiGoDt7/eXlwDtoHuQ81Q58SdDOQyoRe5TqyouIppDa7TxApgHmFN?=
 =?us-ascii?Q?/5zpnVKsi8qjYAjdoVnriAjEj0FvIaqTflFuf1DhOXXFS6uQlX0KZKV/+bxJ?=
 =?us-ascii?Q?6E4+DXuKmgxEDnC5l1f1XZhXglk3XMoxHhgvCGVVbmKpuyuebVn4HOoYefD1?=
 =?us-ascii?Q?EZXpvtGUSAQLmJMdFXWENVZelRyNkQRVwWbNm2vkDyIX3Twp9fc9uv6bPRnl?=
 =?us-ascii?Q?/iwrOJFSoh+yqIvp2zYLlkcFoVh7m0cfllWzFTDKRZEUV/VGGq4/KfRl/Vo8?=
 =?us-ascii?Q?x+WUQYP+/ub0vVhM9+bHbsxd6n9+d+uWvoQthMzN/gIDACwTiJpKIsDYefV3?=
 =?us-ascii?Q?LsbyofT657STxWJU2ATdX4Xp7tOalfMV2xj5cgmwhT9vpssy9Y1Ui8mKQMh0?=
 =?us-ascii?Q?53adhthaB2PVHxPMxD1yuvzuHN8pl/8IzLlHjjPh0gPvppKs2a5iRUfPSSkJ?=
 =?us-ascii?Q?AOrTNLT897uxt0tWQW/FFC2/+AbJcjCoiMdu8WgrVaQbEvPsEhdNpYYgL3Of?=
 =?us-ascii?Q?po6hw+WTZQKpQvztXjtqt7wuD3dyIhZJCI4rOKL95NAzB/ENWvqLCmB5utte?=
 =?us-ascii?Q?tqptpMf5LeSUboiN+rfrnyfCYYy4+K2LyUcILFFEq69QAIOjVa6ZVRjp0gXc?=
 =?us-ascii?Q?0GLZrzbPIu43mCvquPB3FnoKWDPd3GSnJVC8MY8w1Pk+zHXUU3Dt8OHSwiq4?=
 =?us-ascii?Q?QS/XfZgKFlaGiC86gRkno2r91PwX47vGIH0GrYw07kE5m+G2+XtpF4iKWaVx?=
 =?us-ascii?Q?0y/6NZPE+AISAPgx0S6AC2BZXEcd6cG8wigm9rDSzrqG+ODrMFwn0losLLbT?=
 =?us-ascii?Q?ft5P8geKoOMgWzjBBSXq5fhQfP2vPm7Jp3qrrtFdYWMq5LArci7rPq2QVOjz?=
 =?us-ascii?Q?t/E1VPVkKNCTnvPgdffmVt67GIsA0TCEgtttvBlrMfMWPyN+K7q3ZDnvCMzK?=
 =?us-ascii?Q?fy/4qLSmfwFJuYZT7ewFwyr1d+NoE4NHvewiVJy+3XJ8tJbRydT2XoPj6qmI?=
 =?us-ascii?Q?iTIZsHtXCA25hh1vtoogoNdCkNq9haWLvxPnuLdh7hFzmFavcthWx2zW+PRi?=
 =?us-ascii?Q?bnhTvG1GpvdwOiwYcywow05u52HnOdMdB5GReJ4UydgNZhNkr6FrWodA5nGt?=
 =?us-ascii?Q?E5uXgLn+FQyXFfXkZgFn0hRUxm91xgJDMrc2yi4C/5j/K/q28hUE1hxRos1y?=
 =?us-ascii?Q?IkHtUHL7MxT775LnZ8l14Hyrc67MAM6oV9ukgf7pkPvsLq9JwaR/ZA59cX+C?=
 =?us-ascii?Q?GsbF8oGKlq8NGo8nbXL6QrGiSMSMmNbjAEIhlwUCDl9cwT/nTeerO5KBR2mi?=
 =?us-ascii?Q?EdJLpl09alD+MbFXlLO/nIzHdfQgKfp/sbmr15BaS0gMEhchAnH1xXnClfZX?=
 =?us-ascii?Q?LnCW0DpEApLwFhRF7YYNi6e9hd0VHhJ9bYuHXM/LMhaxZyOsLvTJ3RHrdIPO?=
 =?us-ascii?Q?Mk95xvYdWLyvbU/6OFSYVZAHGfI1Wwk99RsG+h5RvCfmPTOG0nWiuVJzKytm?=
 =?us-ascii?Q?4J/k/CTHjGd2+dx+DYylGbh5I3IYxC+bz3EYyRqgO7LFfyQJgLUBdUFTrMtm?=
 =?us-ascii?Q?DkJh39sx4g1k03YaJ5U9Ij/hXtOnswrYJsjUwXbbbwtZY3XXyf08uLoP3JhJ?=
 =?us-ascii?Q?46VOpDH8L/WESkyvptk0cZehTUjRjAmdkHMLGJW5YYtJys63uoBL7npE+i8Z?=
 =?us-ascii?Q?Hmmg3sSIRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b001b46-24ba-41dd-f49f-08da4b690a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 05:12:54.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ulbe+/q6QcAVCQozlwWzyQzCWsPKt3WPy7qR2o3UptLk3LSJrvoonRKBSAMTD5yEJyqJ8lfpsJXpdM03O3g+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:22:28PM +0800, Zqiang wrote:
> Remove unused trc_wait waitqueue and local holdouts list.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Good eyes, thank you!  I will fold this into the original commit with attr=
ibution.

Thanks
Zqiang

>
>							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index=20
> 55e76db8b0d3..fcbd0ec33c86 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1190,8 +1190,6 @@ EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
> =20
>  #ifdef CONFIG_TASKS_TRACE_RCU
> =20
> -static DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
> -
>  // Record outstanding IPIs to each CPU.  No point in sending two...
>  static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
> =20
> @@ -1641,7 +1639,6 @@ static void rcu_tasks_trace_empty_fn(void=20
> *unused)  static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)  {
>  	int cpu;
> -	LIST_HEAD(holdouts);
> =20
>  	// Wait for any lingering IPI handlers to complete.  Note that
>  	// if a CPU has gone offline or transitioned to userspace in the
> --
> 2.25.1
>=20
