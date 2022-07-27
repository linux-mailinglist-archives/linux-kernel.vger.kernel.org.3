Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E325F58237E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiG0JwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiG0JwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:52:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7871B797;
        Wed, 27 Jul 2022 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658915531; x=1690451531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oUCWTmBBWyF0we/z8cSLmOBAaRyNtxIHTapVjYTrg60=;
  b=ZAyBkVSb8H8OyhQ82+ZeeVg0KbzLCEZB8lg6jWaU+5v/KOOpTQU3jSaC
   rzYqN5c6MUECrBGwKORLPZpLMwU24PDzq/RsZ2ODMH4C4DF9DdLwYDn+s
   54bMSJqT/84QxbxT3lOW0Mgz5pGemR1wv8uL5xX+AxzZTC2WcHFGY8S6S
   QROeMFZAr81oKcJwJUSzhYQ1Kz8p5DEojs9ov/dOpcWVF5yYuR3pxmf6L
   woU/TV8rOv4Pkn79F0m3krFaSiJnHe5ePEgWXArSW0iXkPVlSagWcXuS2
   naBlpDMRz7o4DLRmDwCJAcahxytMLhW6soA/BYgv41RDvho/FRM6qrTu9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="374493120"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="374493120"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 02:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="668272176"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2022 02:52:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 02:52:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 02:52:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 02:52:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 02:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQc1ojr/oDmsUygdGWLyMkL4gvdrEjPjGsp9AVV7r67eAb+A/sJ+9q+qB0B1sENYQGZDXlIDcU83l/1KHJD256LZ9RkeqxHQAcRJMVRj6nHEuSAnIu1bn2WYgxllYLA+KOrfUxt1IC0GZ5eZpZo7Aabd6/ljq8xn+tizMHmD4Nfr9CxLA+OtLrnpIW5nvFSDb29A0O4ZMKB0N7qwsPO2Q4CXj93cidP2DSbcy8REm/Iv5FLTx05fllCm/dg2TWSxldRHXuSEYSdohU5C8TNAMhtNkuKdwf5LJ/n1K8Qg4qRgxIqO32dK1lgFXTQI09frCeLA1Srj/TSYYRMXptWR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcwybKhUH4QwZNL4JqO50ioOTkBjb03/GmMdlTa1FUI=;
 b=V401SiPqgs/0JKF+BT+fgLOgmF7OE0jed1FFzCxbKhn0BI7oopgCJs0m+iNwo8WJL4OXxuNayJ/n/ZxEMthcNkmZZ3k7MsBo4vpw7H8goUcd0ncCrp1Noo2C8ZuOGcu4WSpAyvEggj34JVqt4VbeSqaG7K5rJ+iWD2RoDxvEciWDOpn3fsWvT+SdWEGaTTIxHdUozXcH2dGgSgSX8RPktOvN5auAFhSJ6B4bo1ZhqIZ39sqo0w0fD/LxpfoSwEDGXNXw9TLtW0yYiwxVfHN49TPF0JX6a2O45nsU6Pz1szb0Ob/WYClFrBavB03I6JmHr19u4GIxjIC9/vJYUBA90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 BL0PR11MB3315.namprd11.prod.outlook.com (2603:10b6:208:6c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Wed, 27 Jul 2022 09:52:09 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521%7]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 09:52:09 +0000
From:   "Cao, Bingbu" <bingbu.cao@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Tu, ShawnX" <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH v1 2/8] media: ov2740: Replace voodoo coding with
 understandle flow
Thread-Topic: [PATCH v1 2/8] media: ov2740: Replace voodoo coding with
 understandle flow
Thread-Index: AQHYoOgS6EJ7U7sB80m4WsxYIgWSA62R+J8w
Date:   Wed, 27 Jul 2022 09:52:08 +0000
Message-ID: <DM8PR11MB5653E47793F38ADA5174BFF399979@DM8PR11MB5653.namprd11.prod.outlook.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220726120556.2881-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebfc38ce-c6d1-487a-026e-08da6fb5abdd
x-ms-traffictypediagnostic: BL0PR11MB3315:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xXwwEVUqK/T2HhDPylFUUJ9Rm+1y9S5aP7RU4OuCxklxHrEEirDYEW+Ahx6rrlM6ZH1/rXWeTzelpppKWYxQTwz87o8egt5kdPQUUyBAJkYXKcMbNFIGbFhm7lbc3Mmnl2BFzZjqpwf5Sv3ZsW7l7WKw9mmENWIpRj6n3zq4TO23PwcFymbTo2ApS7obDa1qL2xmnMaES6NttT55mInRyYH8L+q3wqPLppfgapUzC+vH3RvnoDC9G6XGsd2I+KIacUXrCGLiY40l9lf6FHXDrtaOZETmAbe9k7c5n2nzG4hdLJqfQd+yXWkbW0RYVZjyGPc77RfQDXTaKyiykHYjzp3UV7Bl8a8WyudCe4lwLr9q81rRAP93+3GXCE5WDd9nTGHBOwBizWtl5rCmXfOir25pvsFofd2ZfziNyfaZK9ZDOM8WtTi+SMXWXegsnq6QaIE2AZ6QivfJoLhGB7Tlkl8rFyrLus8h4lhBo6KRbKsFPK5gydXbAoKL0XVZ/vwWkQDEO+rXIKBAUlMKXehGEbihOS6EVOPtoNp70HFFSQvxPtrz2ajjW6WM3FBXHnBKn64LJpi0ENl0nIgYU8uewxl8vWPLt3/Dn5cUgSe1xKthktOrPQOj0huwbfP8/d+Grpl/ZfhiryCePqWiqygdtYyRhwqU4+AKIvZ4Dszdy9xlbqKIuTtgS9Ct1KPRaEvp5ThWtpQYVb43ziMLr86SukOAo//I2K7GsRZWgsdsJyxeUQF8lVRJF2nFMLrG3LYNUvrYXhVjHl3W1id83g1HQI4Sa37NHModuUVibt4DFZnDCq6zDqwsOmsY9A9L0eBR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5653.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(376002)(366004)(136003)(8676002)(4326008)(76116006)(66946007)(66556008)(66446008)(64756008)(110136005)(66476007)(82960400001)(55016003)(316002)(122000001)(54906003)(86362001)(478600001)(38100700002)(2906002)(52536014)(8936002)(71200400001)(38070700005)(5660300002)(41300700001)(26005)(9686003)(53546011)(83380400001)(33656002)(6506007)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2HwyQVmWCGDCNj4/KReCfRlAHlVqt/qDS+IZkwSKX4PJd2xxN6BDftjZU56d?=
 =?us-ascii?Q?cEcvngzYz7N+Az7i/FFp4i3faEnhLs640EHXQXEOQasf/Ye2xDa2dDDK+fD6?=
 =?us-ascii?Q?1ZUtjxFGpOuogVFkor8OeG5v+uCWgGUl3kQClMG59DwvnBjz1bk0Ir/ekDUk?=
 =?us-ascii?Q?5gnMBURwVRsxM31EPljTSZcKvoTm3V3e/ahTZ6qHF/cHSL5IJdGjLi4nkUZ2?=
 =?us-ascii?Q?GaTm9/YsAXKDktpK5Xg4EHM8bEU+bySuDwhloJDaaTO/6w2y0qu1ehzTkfKV?=
 =?us-ascii?Q?nCket/lvMvV8fCAk1hZ0jx6+DwBNP8GiYF21/Rl5xHDNyCBj6E/IIe0vWAOL?=
 =?us-ascii?Q?usSlq96FATtY4x2qAY/7+WHx0h7DRXv93WvPwlqvTVT5e1fFEb0Es+57qLhB?=
 =?us-ascii?Q?luqWT6F4dTPHEy8tTg5ZONgdJuGzPjd2VAeP0QvE44/avq9O0eFEjgxtHQr9?=
 =?us-ascii?Q?Yo2Xr0W8gTHtjPg8Jkp+cdg0A8AmIXp23VgWzyBD1LL1EJi6wLLTz93C1Yqc?=
 =?us-ascii?Q?pFfohW/dHYNygYwkcGuUv8tRPtnWMV5MPqOw3XTuOTWTzB3bdSzsGxZa1JMX?=
 =?us-ascii?Q?bqfkcTNu0S0BG6Skz28rqNDib4JLpF1OeUUMJ2XF7y16BQa9mPJmYd0mdSPH?=
 =?us-ascii?Q?Tve9wtVTzmR6COyhKDTHuVsn+O0YuuBFsUh9gnRntbNrBgISuckGNS8AMA3r?=
 =?us-ascii?Q?4Oe6DoPaQB6e2ONXEutezlVKNe9w7T5/g4D2kjLUxziWxyLNFt9YtSvvj1R5?=
 =?us-ascii?Q?s9D136bpN8xK1UH9vRtD7tW/fdjWWbLmzuh39rzmfgdwaKQ+8lOYKNJwKEbG?=
 =?us-ascii?Q?5hz0fPCJZrDqTuUy3LNwNs2PTROTiBjUnN7g1U0sCHLJ590juioiozcL/8aE?=
 =?us-ascii?Q?uxNTjHawdVxuW1HhIaZrnVwlS6/DAcj1i+AzazgRTQyPtG848M/c0hFZJ/ov?=
 =?us-ascii?Q?Kcjp1/Ouy0mgQ6yQJiOd1uJoUS74UpaD8z/cdHVoTTTf0HwqRkN/wwR5pIgo?=
 =?us-ascii?Q?U7erc3rKPqMasK/GoZ9C+qrQaAK1eiBAQG0GaUwSnFJByuYBOdXqmwLZ/kKa?=
 =?us-ascii?Q?NtVOtVRWMzX3FBkSj/i5fcfUY7+9vO+Q1M9dMMLULY1vn+T1RUa6BR2RDyxX?=
 =?us-ascii?Q?Xc6v4iySr1njGd0sCGcSVNQNQs9QrjJ0cV7MgJlCCQxvMNMqLh5+U7vqKztk?=
 =?us-ascii?Q?xh8iodwmEXQq97Z/KJ6PMg1650PPm0+hKxa0TwF1Eg2CkyURfu3KkXvi29Ne?=
 =?us-ascii?Q?rpV9aUYZdYiRR4P8s8B//IdoRZyHGSf8USRpMBda5bDdqnYHu/VlwW7p5zx/?=
 =?us-ascii?Q?3duHAIjIBfjyLwCbQ/XjeRV8fmxzn5O3BMY7TekKLSdySi0D1SbcgtNmU8SH?=
 =?us-ascii?Q?tAlRVTRmoLrI02exyp1f+/O7pVU7OkywCA9+izB8JDVMhi44WcD754dvQmi4?=
 =?us-ascii?Q?ZNpkupB/hY6XZDuBT30LTm9C4f4NcWGg3KC7VKSQ6JyYyTJMFkEhxX/eQ1FJ?=
 =?us-ascii?Q?OH1N5aBXfNb2B+N9n3j143rh9fArSXurvXjC4WyycxMpaq3CbUGn6uZhnFOr?=
 =?us-ascii?Q?6Ovg7FXFfa6gEP/5l80m08FQtWLWzLs0WiF56CoK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfc38ce-c6d1-487a-026e-08da6fb5abdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 09:52:08.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I0fva6YCiN/ohDkoBUBdTMR6rzCUR2aVDcvkFtq6D0NWZ9YsjQyVIordIt427S3Aca36COVEUkKDnMoTCn8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,=20

Thanks for your patch.

Although I am not familiar with the voodoo programming, it looks
good for me.

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

________________________
BRs, =20
Bingbu Cao=20

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, July 26, 2022 8:06 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Qiu, Tian Shu <tian.shu.qiu@intel.com>; Tu, ShawnX
> <shawnx.tu@intel.com>; Cao, Bingbu <bingbu.cao@intel.com>; Mauro Carvalho
> Chehab <mchehab@kernel.org>
> Subject: [PATCH v1 2/8] media: ov2740: Replace voodoo coding with
> understandle flow
>=20
> Besides not being understandable at the first glance, the code might
> provoke a compiler or a static analyser tool to warn about out-of-bound
> access (when len =3D=3D 0).
>=20
> Replace it with clear flow an understandable intention.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/ov2740.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c inde=
x
> c975db1bbe8c..81c0ab220339 100644
> --- a/drivers/media/i2c/ov2740.c
> +++ b/drivers/media/i2c/ov2740.c
> @@ -377,10 +377,10 @@ static int ov2740_read_reg(struct ov2740 *ov2740,
> u16 reg, u16 len, u32 *val)
>  	struct i2c_client *client =3D v4l2_get_subdevdata(&ov2740->sd);
>  	struct i2c_msg msgs[2];
>  	u8 addr_buf[2];
> -	u8 data_buf[4] =3D {0};
> +	u8 data_buf[4];
>  	int ret =3D 0;
>=20
> -	if (len > sizeof(data_buf))
> +	if (len > 4)
>  		return -EINVAL;
>=20
>  	put_unaligned_be16(reg, addr_buf);
> @@ -391,13 +391,22 @@ static int ov2740_read_reg(struct ov2740 *ov2740,
> u16 reg, u16 len, u32 *val)
>  	msgs[1].addr =3D client->addr;
>  	msgs[1].flags =3D I2C_M_RD;
>  	msgs[1].len =3D len;
> -	msgs[1].buf =3D &data_buf[sizeof(data_buf) - len];
> +	msgs[1].buf =3D data_buf;
>=20
>  	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>  	if (ret !=3D ARRAY_SIZE(msgs))
>  		return ret < 0 ? ret : -EIO;
>=20
> -	*val =3D get_unaligned_be32(data_buf);
> +	if (len =3D=3D 4)
> +		*val =3D get_unaligned_be32(data_buf);
> +	else if (len =3D=3D 3)
> +		*val =3D get_unaligned_be24(data_buf);
> +	else if (len =3D=3D 2)
> +		*val =3D get_unaligned_be16(data_buf);
> +	else if (len =3D=3D 1)
> +		*val =3D data_buf[0];
> +	else
> +		return -EINVAL;
>=20
>  	return 0;
>  }
> @@ -412,7 +421,16 @@ static int ov2740_write_reg(struct ov2740 *ov2740,
> u16 reg, u16 len, u32 val)
>  		return -EINVAL;
>=20
>  	put_unaligned_be16(reg, buf);
> -	put_unaligned_be32(val << 8 * (4 - len), buf + 2);
> +	if (len =3D=3D 4)
> +		put_unaligned_be32(val, buf + 2);
> +	else if (len =3D=3D 3)
> +		put_unaligned_be24(val, buf + 2);
> +	else if (len =3D=3D 2)
> +		put_unaligned_be16(val, buf + 2);
> +	else if (len =3D=3D 1)
> +		buf[2] =3D val;
> +	else
> +		return -EINVAL;
>=20
>  	ret =3D i2c_master_send(client, buf, len + 2);
>  	if (ret !=3D len + 2)
> --
> 2.35.1

