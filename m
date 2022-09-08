Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080645B1454
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIHGDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIHGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:02:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D9ECCD42;
        Wed,  7 Sep 2022 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662616974; x=1694152974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z58+gytqFbbS+taxeYg92QiGNKS7vC8iR26j2DnaWXA=;
  b=JcplznEbtiUibK5wqDBrGN9BhrctUgYg/7AEdTdqfhaYnt5QvgUs/p31
   aLF9P6PZt5VuuqT0fRLECIFRi+eDR9FFRIuOaQZ6Q+6MlBDhjILuxTkx5
   li9RyGwto7ZngQSthIe7A9iGK33jhCZ63EHaSOHHBCZoFGmyoUDCNkxA/
   yDYjmygof0knY5WO++0hFDdwRMS2xhcOKSwh3zeIrMz+X4JSFQiUYNdeg
   7gZ0JvAiqSXzUvfuysBjw13AaZVGA0gZNQFXihwyLvEELOimmC/qZ4H4p
   kRWwp75GAtJGMj1t5gVexVHV2uMjL5VTVF2rvdH4izQzoNynk18CjWBJM
   w==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="112682607"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:02:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:02:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 23:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI2ULjb9/lxjUTnio2S+eIe5yDa2bMlNQhlJoGSkdCK6zatXc2FmCk33a3lMKyMBkJbY+afn7uTtY1TAbhbdPEEUPacePJw0H8R9ay/y0/+xt/MAR0H1K1jCKN5dmFRDk4vzTHc9uOKGyRyPov5vrO90OWymtNSpZiDGpVgtbIuCSqxkVtDCfad1Ru/yx6s4+YTLsHL9wk91CxSrL4zaEqAUWDPAK/o8qS6QYtCoGsravO34GGPQcLrJPXeRJDrvMQgsz1y9loms8C33r6yuU8d4ZJb+ltX6CzYL0FB/8yBjMqYaDahhV1a0IZ2sbWypTF7EsI9TXWSLYxc/7ojGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX6E+M0F3JVPHdZdekMj9aTIztKesNW6I4Kr0GdTsJ8=;
 b=IuGasWb+FRnfybfPSo4JHQ8nNRsp/5XKqjtV+Wjid5NOis4NmhErMiu3LdxGH8POk1SCoO5ahTS+L/UOHAbFQBZV0vLNmKTUNpAwenRJ/ORcA3umwhDJuoD6bXQJPOZ+lX9n5v3KTrkjAt2RKWkROFN5rZqu7mie1Terfpjnux7q4K2fUPqibtkPt1Be58Q1h+m/lZDXV+IlvloKG5WGslmJbeWwPhcTN1JdplYPFjfgsoHCoNLW0u/2C/ZBjM5UOxYi62vG97QqCMNj+yoF1PNLf44tJ9YDSZzgB+Kk9W2cDe/zmmkhhibXsUihXzm6s52wzQ7LEHbegmFVbixzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX6E+M0F3JVPHdZdekMj9aTIztKesNW6I4Kr0GdTsJ8=;
 b=gQYpMDiqco2lGrzfWMWQitteckX+SNdkd9FNG0V5UDQXlEc3i3XXrQ5rEcrEcbr2n0y+3sIxYJrPdFfcxvWuoQCkFggzQc8nClswRkv8h7Em+hakL/PsaK2tGssapFzCSyqzgk5B0DMmbP/ereCer/6hwHn1HpmC76Fv323QEF4=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BY5PR11MB4119.namprd11.prod.outlook.com (2603:10b6:a03:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 06:02:39 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 06:02:38 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <weiyongjun@huaweicloud.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lkp@intel.com>
Subject: RE: [PATCH -next v2 3/5] misc: microchip: pci1xxxx: Make symbol
 'pci1xxxx_gpio_auxiliary_id_table' static
Thread-Topic: [PATCH -next v2 3/5] misc: microchip: pci1xxxx: Make symbol
 'pci1xxxx_gpio_auxiliary_id_table' static
Thread-Index: AQHYwsfkQ6J8AEcl1kq7sKKZmtEzUa3VCv6g
Date:   Thu, 8 Sep 2022 06:02:38 +0000
Message-ID: <BN8PR11MB3668F513326CAAA4BB8A32A9E9409@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220907145808.1789249-1-weiyongjun@huaweicloud.com>
 <20220907145808.1789249-3-weiyongjun@huaweicloud.com>
In-Reply-To: <20220907145808.1789249-3-weiyongjun@huaweicloud.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BY5PR11MB4119:EE_
x-ms-office365-filtering-correlation-id: 9f401693-f7ab-465b-cc6c-08da915fbbff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdhAcvHw7jLMKn7+fD/9FZ1k002uj29g/bsh589BsCkevmvTO0HukK7hrNYM2w0w6/VFGNqt79Kxt3GlzKZL/sQ/b/JOip0MoWmeGeawEbM4LCnzxjC+eGwBD3iMCLFhoxh1nHC6a/USpo9HuES6iMgqgIAeBOQ1Nv892+GQiRqtS0KaHuROTb7V40b2tMuZCFFXiXF/kF0ZTLXUZiCCDBdFoa5vADPMUKpw1tDJ4PwnyOIGb+j9ckl+zfISaHoFpBElQ8utyzT2emCW/fABEYcE8N/LV09X72JZFt5j3f8Mf/xCjCO7IaylN5nlEmrsMo2ANqatbhUQ/4jjkJO7BAKhh/NB+/MjZgqK11lwqL0HJjVP2fDAaRf/NS80i+qhF7WXA8InBm0+In7P+tQ52KPMAL7ncydqmIusMH3JF/+uMpJACW7d/cgCKYJm8F18CPYzXJQMqK2zOCkQ/vGGxFkLdtAEmnSHGbR16Z2khwApFVxL8czPCHFwiXj6JPeo8F/Js3ICZpKiR/J+ds6bvHfiIYplXUIf1JwHBIlJ01VIB64+/GN9/Af368YoXi76vAwGdefHS9WH+cGJoxiCHfTqbuAN/Uj3Z/NTKh+XDdqrEd+LFPHZ6Egf4IKdJJiqcbuprWXXU3Hgb10UoAwJe5hyIQU86iii5M7vQR8ezA9F78qoZG0pf+kXCi7+VoKziy+/Zp13V1k0uodXeNir5s7G25UIlKkOfpdN8HQymcx0qS+5+yRnXoikMNBVEawsZqYClT0JkHtpa8GRFOj2Jwo6U+sDzek8ewmRsim/PHR9uF0qF/CW/zOLQS8VbZoM1Ai32rrNmSwvY7ei3NZc714MdS5uWIdG4moNciJjzck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(366004)(376002)(478600001)(41300700001)(71200400001)(38100700002)(54906003)(316002)(110136005)(186003)(122000001)(83380400001)(38070700005)(6506007)(9686003)(53546011)(26005)(7696005)(2906002)(33656002)(55016003)(64756008)(8936002)(5660300002)(52536014)(66556008)(8676002)(86362001)(4326008)(66946007)(66446008)(76116006)(66476007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIlFP7feewHX1oUzw/nFwSrYKmSoZO5vLXcRN+rRlaPgOSDCpjgNh/XSS9lT?=
 =?us-ascii?Q?RPP8PrEIZURjl3A2vXbs+CUwi4QXFJuBEWid7a9C9FXCWyTFk+tP6VGNJhKE?=
 =?us-ascii?Q?fbHC7GwKQFvgpknT16DVnahg/vMg94hEq00GOYyS51QYetA+ZHa/LBNhdtSE?=
 =?us-ascii?Q?mtnCoHyqHWS4CtmUMBlt+qAHv1Nn1ulbb3MgpFrqCjk5helVY99ohyRpCXkY?=
 =?us-ascii?Q?LbeOCBevndUSauDTB3q2Og7YliR1JTkYYJ0oaGFimcJ2nFA7AVAC7ZGJaMoC?=
 =?us-ascii?Q?Gf6bbTohgkjkSk0aM4yoNefWM2XqHsuAwSIiRRAQJr6xR8KN88dU7bc6VGTM?=
 =?us-ascii?Q?HEv3ITBulMmLMOjibJM8ksqQwpF+5/ucLgE+rhVrXq+2XzEQlxaH4SuK3s+s?=
 =?us-ascii?Q?19SQ5tA+3WRLPvv3YvoAyhYXO5WYFJKRTSCNIMlhhUa7nlSNBNykx2O0CDvs?=
 =?us-ascii?Q?7TiV1Pgiqld4FMy8xAtLKSj3n/0fQDvaBn4/6VhaHCcnrc+azrHrePawMzbT?=
 =?us-ascii?Q?0aXzmU5uWvjXXsCPgQyo2uxhO9zaYr7v/864j9kr8N6NIoQsGOYpnzVS8obZ?=
 =?us-ascii?Q?veycpRfADRb2QXvNIRAHLpinEVUGcMGCc+uDhB+33HfbChcFOxMkJKyyWhH5?=
 =?us-ascii?Q?5DpJkKx4jwquwI7/Lhym59dY1f0QyZRiDaXluFrhenODiaQ1LWVUmaLuH5Wo?=
 =?us-ascii?Q?7ISduGiTgulS0VDwT/4RuB6emeq5RWuJzclA/GLVSwT6byF+N1XDEPJ7IXG7?=
 =?us-ascii?Q?V0Df0COS+BQqi7EUJkbS5pDHGBSUBwNofqjkeYodg5aH4ekD2ay2d8CaTzx7?=
 =?us-ascii?Q?SkoSDcLc91ju24FfAhCssiHAUvz9+Zd5pQXKlIFDDuKvNXppRSqwSygXRM/4?=
 =?us-ascii?Q?+qe2sX57NmShVlXELssHimVtrjiXNEMSHWReyOaQvuAQHOc/C9oaa+TmWRGi?=
 =?us-ascii?Q?3qece122Wa97DIBTiQbI97CQs9+8YClZGM5uzP3+9ak9zdFgcmY2jiZZcect?=
 =?us-ascii?Q?6WJR13sLuxCYTWPCnj69uDoVVKJp6YDblUyumKudum9MhYMYhJV6AxUXwY9c?=
 =?us-ascii?Q?Irs5lDHUq0Npsk6NRiO3Bbz3F9A2Dg2hW5Zse0qikRqNkM9G5vQ6DqCcXM57?=
 =?us-ascii?Q?WxX2vZahh2O1l34e7YeqrYs54R0j0DEeXwIZj0EXhr3/tMnXAGDKq+61W9SV?=
 =?us-ascii?Q?/ZXwiwnzb0BcR3yNGdH4SNybDS+2OveSg0LiTAxGvrHPgl8baIUnue3TdI/a?=
 =?us-ascii?Q?JFo9VnxrP7oueqRz/kak99XbhSqGM3RbJp2GnSszLZIT4GtopyQo2JOQyhas?=
 =?us-ascii?Q?vVG657Lc9/SD8YVEpffQ9r2HXpZEet7QULwqypGfkpY+XuVvPRjfQogBTaNs?=
 =?us-ascii?Q?kPb6AFUx9GSMxxHn6k7c6LfcLrzHH59eJ6pTr83YaQNuqP12vJv5Bm6U0Qm7?=
 =?us-ascii?Q?S1Tfb0GoTuZtKn2fcmhOUck8LAT9+O/sKbADHbSCKbq3UdZ4iIzQo3dA68Ws?=
 =?us-ascii?Q?DJFzqwNoU34ICK2oOigMyxL2xSDAhoGMxM5+hh7YfM+CI1YcuTwVajIdPTTi?=
 =?us-ascii?Q?sSaIcQXSI2AIbCBrikBDGX+HpqSUVA0z/vCgb5mNFreUPyHfcdpvq0yndscs?=
 =?us-ascii?Q?RBXbmG2YX5PQp+DmM1wjE0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f401693-f7ab-465b-cc6c-08da915fbbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:02:38.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H41oMO/G8D2jFDo3o9H96FbZei4v1BVbhJKEYmauUpY2lUh3yFiSUlyD2zB57ieO7keXomlK9tpPFmNtigUNyh5+bns3eqZkJ3slw7IkW0z8QyP4yovu6moBl4sNXMaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4119
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Wei Yongjun <weiyongjun@huaweicloud.com>
> Sent: Wednesday, September 7, 2022 8:28 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-gpio@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel test robot <lkp@intel.com>
> Subject: [PATCH -next v2 3/5] misc: microchip: pci1xxxx: Make symbol
> 'pci1xxxx_gpio_auxiliary_id_table' static
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> The sparse tool complains as follows:
>=20
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:409:34: warning:
>  symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Should it be
> static?
>=20
> This symbol is not used outside of mchp_pci1xxxx_gpio.c, so marks it stat=
ic.
>=20
> Fixes: 7d3e4d807df2 ("misc: microchip: pci1xxxx: load gpio driver for the=
 gpio controller auxiliary device enumerated by the auxiliary bus driver.")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

> ---
> v1 -> v2: add fixes tag and reported-by
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> index 47e6e87938ae..4f26871994ee 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> @@ -407,7 +407,7 @@ static int pci1xxxx_gpio_probe(struct auxiliary_devic=
e
> *aux_dev,
>=20
>  static SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops,
> pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
>=20
> -const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] =3D =
{
> +static const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table=
[] =3D {
>         {.name =3D "mchp_pci1xxxx_gp.gp_gpio"},
>         {}
>  };
> --
> 2.34.1

