Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6539B5823D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiG0KHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiG0KG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:06:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BA62AE34;
        Wed, 27 Jul 2022 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658916411; x=1690452411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EMzRW7yREZufOj+i3DrO1lD9vgRVMxR4Exnm/adPxBs=;
  b=FVMqMqk5CfUh8J1GyKu2AWzBVzl1HQFrrVK0BPyEJOJ/0uS09ccGquKu
   jnkQSFQtAj5TpslofsUIKnPosUR0DAMkSA4G+B6G0zqgN58bkp+6o0aqS
   vGtN1VpQ6P0tTkyv9Bvh3oOFj6aABT/YnTbbkyqjbQM6ZZR/T1l5FQQvi
   MKQ1ZfyvhPn/2295M2T/uO2UsiQWVytFAJ0NWfIYkvVVwHxGaLTTzj0bg
   toarUE8w/+Nrsf+Al6PS2/vrbEIcTURkm1hH6zzmkVmVOynLlnM0+I83t
   yUI26RoFBdiEffTYYq5UmF9Si+BgGFgZDhUhygCtQyBT+brU6gsHAD/Wz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="374495527"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="374495527"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 03:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="628319378"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2022 03:06:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 03:06:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 03:06:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 03:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAQZqofZpxtfpzjvdbD1JD5VQvpJMosTOP7IG0fxXfr6fcEHLhh/ak2S4CojdcxjmgpoEXNaJce78zUquXvd5kgVY8xazsgN5Y6M8tWdkv2jIhgtZH3V2xciu5e1zKT8Oc4aXrj02IBq6vd7bFb0AIo7yZoLYdL4Nt6VWtNTRBJJpyCwwvH4ZuLHN+1HqeW6KCHqyTFI1M6rMulEXqOqFPjDHM6nb6jceTYyf0Jqba+JbFeie6As6DPGL11nQInNoGTiQ/RDJdufpWtN+DF0muRBEBk6pqV59iICbfyaKskzV+sAYCoO4F2U8F1/+kMi7GkLmjbRcld58V60nk0Qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw+CpKy1wkjO/QREd+F9YraPfxCjJ8L4MhdJNQUMG7k=;
 b=TUzlkkf4TtH/wvTtPV4Bx8ozg3JIjGHWu+0Bn3rToInlJF/eersKcjHONr0rRLiJBAKoTRgdneDKh7q/vM8qOzTIb/1I+B806VUYXQvdK9lare9povMJ6DWSb1P4Gp5sdVkE9NrLFhvGUJ6BBNn66ryqDp0RxzWemIe8c7730o58ppP/AusHistmn6lD57C+7V41rEfJAHAaphH7p8zsFmHvgHYnz8Qj5k3ELK4vX8oInenH3U96OcB+hOe0jsw2Uh9wm6qQGM+Vb+Zo0g7U6DK0czxH2Hjc0qmFogEfMBbVyDX0vl+s2MX+JmurBU1KBflJvvny3IPnVh+G1wH4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 10:06:47 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521%7]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 10:06:47 +0000
From:   "Cao, Bingbu" <bingbu.cao@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Tu, ShawnX" <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH v1 6/8] media: ov2740: Switch to use dev_err_probe()
Thread-Topic: [PATCH v1 6/8] media: ov2740: Switch to use dev_err_probe()
Thread-Index: AQHYoOgVZRiE1du5qUyV0ggsCc6Y3q2R/0Yg
Date:   Wed, 27 Jul 2022 10:06:47 +0000
Message-ID: <DM8PR11MB5653E201B8116E1F47FE759499979@DM8PR11MB5653.namprd11.prod.outlook.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220726120556.2881-6-andriy.shevchenko@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: 3e5a7df6-16cd-4046-0a4a-08da6fb7b77a
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3EBhZGMCJuzSIiyZLNn1a8lOMZHKoVaac876jVmE2gNlWx73/9yugx0KZb9bIrTokrWwaysjfLf/jD504Ns4g34K8feQB87ygbh2Wy0hqy6Qr35Rs/YCY6gvS/6KJLUFBa6hkbY1jz6aQsfrt5/vJehxyY62wkKUgEG9t+JAq8Y3lL3o1UhcS681upvZJqn2TfZYKdKwrKgrbq7o7yumS8XqOTNSX5/qGRr9zmyrqH3o47/MQvhT+ZNAsXde5YUu7UpiA4h9FZ/wSuab2rzcU8SUZ3UTY9xGyygp7lLcU0nF8IgwIxL7Il5ivinoWXjeD5De1EbmB2QdG8/F/CenK59G/DXWD1d8QHIeGv6UJET44uZqDuob7FVNrTnrn9wWXZ31cTwWNrYbawBzdmoY+5G8Zh949BmbpbrJNT/tuiZ1MjZ0ZuIlu+ISOC5dOmq0orpRcjhgsYN8RMphBSIecT251AH8pV1jTt34V7rWPo/ciJsRpZJ8WnOncpMhpsYgLnnF9Zgr8Dnn9tzy362I4s8vOMVJ5aP58/LMNEq3M9bhW3mAgIM8maj+jfIlyfDkviaUPvje6qxv6ZQduunvUlpMYaZ8+mi6x6f/yToiwetLXNDykfmU6uc/qpd4dG+kpED+jW/wCxcg7pSNj2LEHMUvUXXy13b+dSVhWOUm8Jth3Ha/YdlqGB1Diwq+HZH3fF9efvI0qXgPZ/0MhORjOUPNc45DGpgQDujgTzmhW7BSQNSmCWLCBv8FSFhQS7Zgkt02rK1QAR4rz5CsnZOn3iKsJKV2I3VzbG41VwhMCZ/BYTP7IfF7YjvBgLlAyuD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5653.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(376002)(136003)(9686003)(186003)(83380400001)(66446008)(54906003)(66946007)(4326008)(76116006)(66476007)(8676002)(110136005)(53546011)(6506007)(66556008)(64756008)(71200400001)(26005)(2906002)(55016003)(41300700001)(82960400001)(38070700005)(7696005)(38100700002)(122000001)(316002)(52536014)(478600001)(86362001)(33656002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PSKxTQmZc38Ii52A4evj3SjBQ1qnC5d63gX5JD6qhxzfCMxQTWvDadF+JgVw?=
 =?us-ascii?Q?PRZmO0o2ZSpPOOALk+BEEGetOt9UWWpUr0T7mCeQ/w8t9TT0TGQWMnIWJXfu?=
 =?us-ascii?Q?A4FnonccNAqhoxKd4TUQodIdDXucdt0Py1ktMOxIpsQ6vkB/jd34ARHZM4TE?=
 =?us-ascii?Q?0JU20hckI8FwcB6ASj/gUkxUDU+f+O+syt1cSGQz4Z4FfaOefZB9rX9lS5fV?=
 =?us-ascii?Q?/jobw4PNfpEC4Y+Vq+LqTmwe+BcATPodQ46iDn/INbP1HI5LHE2C1W/60KFj?=
 =?us-ascii?Q?1ivnD7CdJm+g3PPel4qQweA1todgZFbkF6bzCaIbReqgxcie/Zsnn0x0Xupu?=
 =?us-ascii?Q?BQE7V1gQQigwnrEwE2CPd+bgEvaFE5IfbthF1IpQCvHViderq5jOTz6sUqfk?=
 =?us-ascii?Q?p4pFn6VJXtdldBIle8wQWMF52a6BVmBpFxv8/mIBVZJ2e6oBQgKKLrFdl4jm?=
 =?us-ascii?Q?kTqpyy3e1i14ejxodr5O9sM0X3OFZHi6PnXtg+nTVfGfvgh19c1SkCw2W2GP?=
 =?us-ascii?Q?8WyCYWDL0UWmBh4fla1kOER+4vrIqm0Anl+WrbW91ITgmhNLajCiACNc4HL7?=
 =?us-ascii?Q?/lSl4ATUpfBxfFxoS5tsQVlVhlbMmE3dnQPDWPiEB9zEocO63X0zSgDDFVvc?=
 =?us-ascii?Q?DnZBu/ZXSWPJwIM1vSP7qudtOwUrWno1JzMCryuGRhFSYWRxmpv8YYQ6NmzC?=
 =?us-ascii?Q?ot5dM1NK5l7AMdSnwPEf6geJjKgdL0TPVPIMfJ6dDzfo5MedUshQaikMyzfV?=
 =?us-ascii?Q?5NqrjdydRUU8MUJRW4Q3CjoucK8M1anK2RYYI/CIabicxpaTj69LAr/w7Zfj?=
 =?us-ascii?Q?bxpRdMvmhe813vrYTqYf4vPCzT9Yk2BSyfq8D0hXKt5VeJ9MJiq2xXcgqSzM?=
 =?us-ascii?Q?JkmpzqgWq1JgoJu6q2ityn1qtTvHGwWoZJSmler84gDCVWlqSFx1OJVfhJaf?=
 =?us-ascii?Q?Z2kTco09259JR4drcfztFAcMAWhyd2SKbIOH9SSErJvPid0NsKwbqO+m5uCm?=
 =?us-ascii?Q?JPG5DHuqY4ggM3hAG1QqZkwDKGWQsiRuZH2X5JBpQhhvto3EC5c9ngUbeYXF?=
 =?us-ascii?Q?qgTv4UheVA1QaLuGoUE8u0JSrkDFd4lEAFVvEK1Ge14drkhO+PtLtOKS7j6x?=
 =?us-ascii?Q?1IH4mswVCiCUZ6nQUq8Z7e+8ESUkyt4Yq3c/QuD6+hBv4/UNX7S/ofBvdLZ9?=
 =?us-ascii?Q?qlY3J1w0OrpwVSrWywPmQddsxLhkIUGrxdHey5SQVQhHDi9SrKVHa4licsZ4?=
 =?us-ascii?Q?dzCA1X++UYoTtN5Eq2rv9pzgCpWIqN2cXahKxJpKJwJBSB9npVprDpRnrVJi?=
 =?us-ascii?Q?C/dJ+DO/9mGDXM56NjgBLsYFkHPbUCtOr0dhsMrFXt4Z0ZGRfyi6hi1ZnxRv?=
 =?us-ascii?Q?7+ZNcYHbkBV8pjSgeMBqvyYxmoZ7j2eln9y7X029ZbjN5EHuj6vVYXnEvJrn?=
 =?us-ascii?Q?Q3AIHMPX9bT2tvWe+0XgrIyBf/+fXbtthVc8OQzA97OlsmY3+K2K8wfS1SIE?=
 =?us-ascii?Q?FZeUy8oWz9hWl5kTH2iBn4NFyZvYz10yFRL3Vg0+HxS/4hJih403XXHcINHN?=
 =?us-ascii?Q?l1avDBVrFoAXHw+pJstlWB/JdtAHrnIn3iRivQ3s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5a7df6-16cd-4046-0a4a-08da6fb7b77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 10:06:47.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYflpVH6MonI2w3urgTFOmjWAgBixbKCw2jiy9HDCFZjzIXMkjsiIW918J8lM9DuKYcvoAi54vd2PNlm/c8D6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Subject: [PATCH v1 6/8] media: ov2740: Switch to use dev_err_probe()
>=20
> Switch to use dev_err_probe() to simpify error path and unify message
> template.
>=20
> While at it, add missed \n to the end of the messages.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/ov2740.c | 44 ++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c inde=
x
> 212190cb14e4..7271e3d011c9 100644
> --- a/drivers/media/i2c/ov2740.c
> +++ b/drivers/media/i2c/ov2740.c
> @@ -1013,10 +1013,10 @@ static int ov2740_check_hwcfg(struct device *dev)
>  	if (ret)
>  		return ret;
>=20
> -	if (mclk !=3D OV2740_MCLK) {
> -		dev_err(dev, "external clock %d is not supported", mclk);
> -		return -EINVAL;
> -	}
> +	if (mclk !=3D OV2740_MCLK)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "external clock %d is not supported\n",
> +				     mclk);
>=20
>  	ep =3D fwnode_graph_get_next_endpoint(fwnode, NULL);
>  	if (!ep)
> @@ -1028,15 +1028,14 @@ static int ov2740_check_hwcfg(struct device *dev)
>  		return ret;
>=20
>  	if (bus_cfg.bus.mipi_csi2.num_data_lanes !=3D OV2740_DATA_LANES) {
> -		dev_err(dev, "number of CSI2 data lanes %d is not supported",
> -			bus_cfg.bus.mipi_csi2.num_data_lanes);
> -		ret =3D -EINVAL;
> +		ret =3D dev_err_probe(dev, -EINVAL,
> +				    "number of CSI2 data lanes %d is not
> supported\n",
> +				    bus_cfg.bus.mipi_csi2.num_data_lanes);
>  		goto check_hwcfg_error;
>  	}
>=20
>  	if (!bus_cfg.nr_of_link_frequencies) {
> -		dev_err(dev, "no link frequencies defined");
> -		ret =3D -EINVAL;
> +		ret =3D dev_err_probe(dev, -EINVAL, "no link frequencies
> defined\n");
>  		goto check_hwcfg_error;
>  	}
>=20
> @@ -1048,9 +1047,9 @@ static int ov2740_check_hwcfg(struct device *dev)
>  		}
>=20
>  		if (j =3D=3D bus_cfg.nr_of_link_frequencies) {
> -			dev_err(dev, "no link frequency %lld supported",
> -				link_freq_menu_items[i]);
> -			ret =3D -EINVAL;
> +			ret =3D dev_err_probe(dev, -EINVAL,
> +					    "no link frequency %lld supported\n",
> +					    link_freq_menu_items[i]);
>  			goto check_hwcfg_error;
>  		}
>  	}
> @@ -1153,16 +1152,14 @@ static int ov2740_register_nvmem(struct i2c_clien=
t
> *client,
>=20
>  static int ov2740_probe(struct i2c_client *client)  {
> +	struct device *dev =3D &client->dev;
>  	struct ov2740 *ov2740;
>  	bool full_power;
>  	int ret;
>=20
>  	ret =3D ov2740_check_hwcfg(&client->dev);
> -	if (ret) {
> -		dev_err(&client->dev, "failed to check HW configuration: %d",
> -			ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to check HW
> configuration\n");
>=20
>  	ov2740 =3D devm_kzalloc(&client->dev, sizeof(*ov2740), GFP_KERNEL);
>  	if (!ov2740)
> @@ -1172,17 +1169,15 @@ static int ov2740_probe(struct i2c_client *client=
)
>  	full_power =3D acpi_dev_state_d0(&client->dev);
>  	if (full_power) {
>  		ret =3D ov2740_identify_module(ov2740);
> -		if (ret) {
> -			dev_err(&client->dev, "failed to find sensor: %d",
> ret);
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to find
> sensor\n");
>  	}
>=20
>  	mutex_init(&ov2740->mutex);
>  	ov2740->cur_mode =3D &supported_modes[0];
>  	ret =3D ov2740_init_controls(ov2740);
>  	if (ret) {
> -		dev_err(&client->dev, "failed to init controls: %d", ret);
> +		dev_err_probe(dev, ret, "failed to init controls\n");
>  		goto probe_error_v4l2_ctrl_handler_free;
>  	}
>=20
> @@ -1193,14 +1188,13 @@ static int ov2740_probe(struct i2c_client *client=
)
>  	ov2740->pad.flags =3D MEDIA_PAD_FL_SOURCE;
>  	ret =3D media_entity_pads_init(&ov2740->sd.entity, 1, &ov2740->pad);
>  	if (ret) {
> -		dev_err(&client->dev, "failed to init entity pads: %d", ret);
> +		dev_err_probe(dev, ret, "failed to init entity pads\n");
>  		goto probe_error_v4l2_ctrl_handler_free;
>  	}
>=20
>  	ret =3D v4l2_async_register_subdev_sensor(&ov2740->sd);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "failed to register V4L2 subdev: %d",
> -			ret);
> +		dev_err_probe(dev, ret, "failed to register V4L2 subdev\n");
>  		goto probe_error_media_entity_cleanup;
>  	}
>=20
> --
> 2.35.1

