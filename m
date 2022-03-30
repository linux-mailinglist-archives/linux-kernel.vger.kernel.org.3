Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9894ECFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351637AbiC3WcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351631AbiC3WcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:32:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E675BD2E;
        Wed, 30 Mar 2022 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648679415; x=1680215415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1hjXhNlUoM7Td1SLAxqBXHecsiPXQhsws3g5k6/LUzk=;
  b=MFXiZN2pE9+slfR3bpwO/yAdnZpeJx3G36RZp0UydRnB0GQ6s4vj8dyf
   4fcwtoybuwiGJnLW3y/9m03SHDg28CG0vKCpUtQ50JnRO/bVcy4eEBfrD
   eCXJtw38Be5+5kIVakktej6lk1Gih4Kp6A46xV9OI4OjmlKC4dWeG+Qug
   8knNXRbQaFTTfqz3KFw6MPtLICT0A+38zHIpvlrP+qXKS46TJEAej5esV
   UHvDRAlxvu9A5gykoHBUgtPhXWtzAVKSXjb+ZCtS4+zdzvCbuJlXv1w9W
   yCHMYKBjH46FO4ySNh/Y30s8t5cGrx8jUaCrQbaRPbr9iXjEAx+S06tsz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259844941"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259844941"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="519976744"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2022 15:30:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 15:30:14 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 15:30:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 15:30:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 15:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dannNsc9tTVVIVN7BTaxfx+RXf1nrEo6txRA/2DozyOl0Im7tpFCLnz4PjCpMuNrjdil43V3KdTRXDXYRB3s7btQfQ12KjWrMSmtFLcr83WMHi4Gio3yw6086//7ZCcSSSM8aJeqJrMqAGbW7Il/cwQyiGlJGBI40YL9Uv1e/Eaj1RmL0ElT7IHndJd/EZCIOkLjdVH01wOzfEShmhzOtVS9EYwemrS3Ik7bsJFgnX5xL6UUN7//2ZfGrPHecmXvKnnkoUsWfCPsqpKbU0QV36LWuGdFizxFwGOivqiyg0ooNb/PR14WZrSC20JMJsG2eRveMDRSitWqkBo+tIsQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZX2Umr/i20GbPGMEcNOA8PL9Ia1c+IBaYYhZ2yCl+E=;
 b=RDloxKHYyPGwncTVvGsQPvEAadO3iT8V4djFvToMMujMju10v97TbwbDLMiYRxO7NmnIjLWBZb6HYpexPZgUgKOxmjvEPzImakgv0LpVY39DIOaUoYDsG/2NPrSRc5X1LtvemXIfS/SIN1WhibYe0zdbGA6FjsR3nMlC88UMtDeDl8YLyI0CGTW76jhinvj4xMbxDYhQVTzJ1RBSF1yaoponE9rYI+kPMj9j3upWOI+uu507KhPDAWXHjYATJI5tN8/c3bu46MHrow0jJb7Kr5d+WBAwA5JOgztWzRGo9bLMNi6qfkSm6oSmiflJzluyZct/3lNaCmQ9cjPEWxLGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN6PR11MB3198.namprd11.prod.outlook.com (2603:10b6:805:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 22:30:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54%7]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 22:30:11 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Thread-Topic: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Thread-Index: AQHYRCgbTB0vKm9Y50G6+1/r5OpdTqzYSg4AgAA0FUA=
Date:   Wed, 30 Mar 2022 22:30:11 +0000
Message-ID: <PH0PR11MB5880D6B11469266144C58032DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220330112014.2587148-1-qiang1.zhang@intel.com>
 <20220330190556.GL4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220330190556.GL4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 74125b27-5c18-45d3-6280-08da129cda50
x-ms-traffictypediagnostic: SN6PR11MB3198:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3198D15055B3D1ED82EC4099DA1F9@SN6PR11MB3198.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZoq6LAivUaS7PZMuNyvn2NQfMERmAPN4wsMOYL0DdNs4ATrBZ6erfK6/1tmFQSEIVx6jsfGjFlM2/hG67v2e3GFs4iurQWY8fAyLTkRAfLVBheXvxZ0fbvGvfcLKccPVQD/tz4cYtdsA6BHhWpemymTbUDA5wuE2qBr7MvDexylVE5XgINNPGEww2ZvQnlRbeHEs4mcIEhk+1snVU9NEaB0J1E5TygduYPZtMtLWb2ehmZYv4C+KKYDWGZaE+NA2rk+u3nYurq56jJHJFYhUQFGiShoXqZvDNrYs6yydQ3NoblJsTtYqV2Kl4sPus9nRnhwcd38UbXAp196zxcBmfWDyX/9ZuXx3qZTlGLHTRGir+LmFGfXQVet+xflKS8znn9oIGVOy1I3WSxG80lBfepGWPPY6FPb7yWWQ+Ic40tcgKP/T7/33DsUY2x6yJhoSXduglIa/x1Aa+816gxHRl7s8KkTVR2GAfl6LA1489JwjoHEy9SYy7j6cVKoc5jV9SZ3hy4z2bfi0Q6arW1KiojynvA6+mIHsjkrQloTZQ4HmqlqjVnrmqAWi9781DA03UgilWdrp+oDcRjFMTeQPTcZSL+RM7mklSPmspJ2/xOQ0RGs5ghV5Z1aLOODDf3PBiwjbBX3HVIMWFDYgCzseXnCf+CljiYvHo5rkWwttnjhBZeMAwywb0O4y3BUlwNcLwbk2DDn4j0VglvELcFnuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(66446008)(64756008)(66556008)(8676002)(5660300002)(52536014)(508600001)(66476007)(71200400001)(8936002)(4326008)(82960400001)(6916009)(26005)(316002)(76116006)(33656002)(9686003)(7696005)(122000001)(6506007)(66946007)(2906002)(83380400001)(186003)(38100700002)(54906003)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kXARLsn2X+rxkZ+BXUbzbE3dZOKd0SVXHT9puWJ2P6qBHai1BjDNYowgGZ0j?=
 =?us-ascii?Q?DIis4Q+ojJYIzB7n2Gk6H0qh8q2b26AXs8dcx6FUfCuMBUrXzVaYvklNjbD4?=
 =?us-ascii?Q?5gZPqSSeAjEXbfORPFAT123e0pikXOe4VEumhs2ZxwVG6+qQ5sOBfJmACUEz?=
 =?us-ascii?Q?X7+7tCBmI0T7xJNMEG2cYuPJY+NaOyZi7gFcVXuWoh/vCOqUzVEX80uq0U7r?=
 =?us-ascii?Q?QDwwVskXBlDM99bA34dpgl+xARvBh43y7lQnCvYIPbw4pN7IOl6QrI4LSqV8?=
 =?us-ascii?Q?YlKncCPgLfhpUvJBiqRVApLPmfEN/lc3fAgaZw44lee16l5YUQqUMyk/rhG+?=
 =?us-ascii?Q?MjMZNkurboCoIxjCZTnU5e0wfxXC3KiNtkkD5GdXRbeOFG0nyYnJru33mIaF?=
 =?us-ascii?Q?N6cBjEFsJk4qtbH3GbO1JihpabycF2fWewtkceHijzB7GXtgegw9cCm0tAyO?=
 =?us-ascii?Q?hKwKlYYK+u2HedJZgBojFfS4dvhXTsRJbYM5HuUSdBoeFLInssaVVs5tgEGe?=
 =?us-ascii?Q?SPL/jfccQ83aKhQlu1cxl6Fb/6NJDbIV9Ng1aE52ezVXWvz9ZsfZCrdWTAfd?=
 =?us-ascii?Q?8nLuOXoxeHEMJr9QKkjyp6AT3k0Uc6ULC/UXuynSZLHbKze5c1aLmyPrKP9M?=
 =?us-ascii?Q?cDCS41rC+tPpXWUO6dhcJTwiwe35q12+p0O87Pe/YIz6J6qA3ZPXAE9srFaK?=
 =?us-ascii?Q?5qPLKuTIVNe5zkjL2t7N63CmF6kph/VjFi3sh70jVLFBYjG8OVGf6tecOnCH?=
 =?us-ascii?Q?ZE9aF3whCjsgKd33z+ryISTrEFlddD2XNYbmdqeHfca+HxjSX7n6NYvlxwMq?=
 =?us-ascii?Q?BJr9zD0yJ7fUHCChl2SvGSLmjDTbAXW4bhDqXvquNxcGzJxGOjVN70bRoySB?=
 =?us-ascii?Q?WM2f3JOXLUBczqLnJKn2BKeqEc+sqBN9rYhqxIox7NNeJSQQm6oO4oqEm5xK?=
 =?us-ascii?Q?GZiF5Bk9gX7AdHNBnUkjRpL7LoAINL31B8jGJOgCrNl1o8qkvs1hYiS/maKG?=
 =?us-ascii?Q?dg2z9xvfvBuJakJGZtPVnHIhdcxbnFP3zNJm9DMVJt91J3LSfyKJ/MmiTz03?=
 =?us-ascii?Q?KFFs68QNGdAbMLrltFgRsOHumYJfRhJePmkigLEANLSHpWGIGEc+4Rb9dgmZ?=
 =?us-ascii?Q?eIFSHTixXxib4o6hX+K+eJ+7YDF0gBlApLyR8NRKRV79RLaZ0JFlDJAAlhH5?=
 =?us-ascii?Q?HH14RfbT6cW789kByWGUoVDE32oZxe9e9fWVyKqnBa7igSG65gzaPcMOklZy?=
 =?us-ascii?Q?ARL4rMaNjKzXWNC0AaBStbvmGwl1861p31FlMETRQrczlZBrzkDWTTfphWnM?=
 =?us-ascii?Q?VQAUDeZlOcEdN0F56SEh2c7dpKPCdR+hYtO8VEA+rO3WQvDZ5t84L2wl1q2W?=
 =?us-ascii?Q?UNCCO6WJtbRRUxqm2pLx6gUfIrDRTtV61VMRyWbYI0OgAUf/LTYjKeJQXM3p?=
 =?us-ascii?Q?ohZu2AAowLS91fXMRBsrYjYhQFi1VJCwfBHQwlRTX64T6B5uyo47Juuosphw?=
 =?us-ascii?Q?GM+c1NDgsO71Kbq6YZYuI2AAoYB9qb0zCvdK5s57y+NLpIby2P7b6bLqmajF?=
 =?us-ascii?Q?D5GXMbGI96MMYzeapl+VWeJzH8+krNqXnolzS5biv8waw7BSaO+r7utXUI1M?=
 =?us-ascii?Q?MBWZEVt39Y9GCZRc4kJBQMFSPbObEfeMswVIU6zvWlxClK70Fw3wjcfOGYJV?=
 =?us-ascii?Q?qONCapnzEWQ1uqKcL8kN0tkXodo3FtpUdYhiVVWwXPIq9k1200Fa6iiiGwn4?=
 =?us-ascii?Q?3alykGI2KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74125b27-5c18-45d3-6280-08da129cda50
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 22:30:11.2464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkY/A3puVNRGpV4W7pJbaTvzWBvaiBibDCrc3ByTUT7HqVGDVaOfihXVvDjo/1ShVvaidXQTUVGLsovI+e6CaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3198
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 30, 2022 at 07:20:14PM +0800, Zqiang wrote:
> When the trc_wait waitqueue timeout, the atomic variable=20
> trc_n_readers_need_end need to be checked again, perhaps the=20
> conditions have been established at this time, avoid invalid stall=20
> information output.
>
>But are you actually seeing this invalid stall information?  Either way, p=
lease seem my comments and question below.
>
>Please don't get me wrong, we do have similar checks for normal vanilla RC=
U stall warnings, for example, this statement in print_other_cpu_stall() in=
 kernel/rcu/tree_stall.h:
>
>	pr_err("INFO: Stall ended before state dump start\n");
>
>However, the approach used there did benefit from significant real-world e=
xperience with its absence.  ;-)
>
>							Thanx, Paul
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index=20
> 65d6e21a607a..b73a2b362d6b 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1544,7 +1544,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks=
 *rtp)
>  				trc_wait,
>  				atomic_read(&trc_n_readers_need_end) =3D=3D 0,
>  				READ_ONCE(rcu_task_stall_timeout));

>If I understand correctly, this patch is intended to handle a situation wh=
ere the wait_event_idle_exclusive_timeout() timed out, but where the value =
of trc_n_readers_need_end decreased to zero just at this point.

Yes,  this patch is intended to handle a situation.

>If so, please see my question below.  If not, please show me the exact seq=
uence of events leading up to the problem.

> -		if (ret)
> +		if (ret || !atomic_read(&trc_n_readers_need_end))
>  			break;  // Count reached zero.

>Couldn't the value of trc_n_readers_need_end decrease to zero right here, =
still resulting in invalid stall information?

The value of trc_n_readers_need_end decrease to zero right here, indicates =
that the current grace period has been completed.
Even if we go to print some task with condition 't->trc_reader_special.b.ne=
ed_qs' as true,  and these task  will not affect the current grace period. =
Is my understanding correct?

Thanks
Zqiang

>  		// Stall warning time, so make a list of the offenders.
>  		rcu_read_lock();
> --
> 2.25.1
>=20
