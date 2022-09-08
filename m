Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282115B1487
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiIHGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:16:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CE3B08AB;
        Wed,  7 Sep 2022 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662617796; x=1694153796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K4lA7oWKtDqjiZ+U7ZlWOtn4qUcV89zEccB0ki4nK+k=;
  b=F+FxxBTpGyP1pWDqnQpVFc9fVHQMfG04xhJVrMfeER5ubTcnV5N3eVYP
   QdU6FvsIMjogt1jePiYq5iuN87Pi8gwoELOUKgrXLdEcB1cBYcqH+HtYI
   IN+09T/4UtIMqsVF0ooz90kCDRLfv9EBhS3oNJx5bTHU1DX/wnr7OPc27
   Jh35q5XolQOmlTpFjYDolCYsmqOmhdE6jHZuOd0XBVPoQpsCawZ/FNJWp
   e05cBC2FoytJ1Ey0fkHFl03yiIhnKBp14z5TKtSQ+z1FgzdFSrMLFCYDF
   BRnkTeWlLgAmCXFw3PpFiWF8Lu1o1Qy2fUUFYQcsiDzLmJHHm/MZ9fukP
   g==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="189921321"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:16:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:16:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 23:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zcbl+vO77o9/LPGvalngC8Fj8MwhgATKtSv2JKfxEOJI7WAucn7Pv7XugaWFACZ5byZXSG3VU9vszu23WVUCKa9cHux6VIqYOSwtVOkw5Y534VeGzkj4pnyhQ/8hFHHbzDrUOhS6QLxu+eals9CVE698jnlsqNYCBBSdBlgq61aZlf51Iu2l3C7Dn+4tsH6rWhww+CpShEEaz5MGutcvflJleMfheuCaG4HLsJcNUs1uooXJ/dlUDExDV9O6juho7LaJOiVsya2VdkDItFRTThXI8axyIwHcsTuIgo1Z1FndT/fN5a3C6HlfzsxHK04v+1P83bLYg4F8jYnBuNMxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuOjG3R8zn+wrdyjiG/6cMnA6Fcr74ueVavKRjRsSk8=;
 b=RlXksekqMoN9DssGGr2bX1pMNJu4045IZSSh/hlNNtvn3Rd+77rt+31L9h9HRwHJsLcUOnfNU9Hqip5autvI6Ci4aF6yTsMpPcR9mIhYdhVtEHuIdlww71quTha8Ar+gFinj/Ut/vG6UOZxvM4Z/ukBCRieb45WU7Mpjs8VhXOWz8pDRIqP32c7iPh94sDVqE67tIoNmBZrO/LbYtkEFNG970XmEGIU+Ki2j/L4DFQPrtxsdG/mB5/B8Z1X/5J3dpNcBEtOTwAtGyvEIYzgTbUzd0oCN07G/iEq4d6yMvirgyJDDVJJduZ/AJta7mtI5mPw+MrPi/AC8qyr9lyuOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuOjG3R8zn+wrdyjiG/6cMnA6Fcr74ueVavKRjRsSk8=;
 b=kOtaID/DzM4VI3Yr7k/1N1Di5OWLkwLWva/y9srD9cW5tTNjlj6x1NUpFDmbg8wISRIo5E7LFY+Hjx+pOOeBq4wxnP9weBOrX8AIEcYD6zbYrTOYCJVHLEefe0sKb0+UpXIxa6xExHe/3Tfeo1E8x6ltFs9vs7f1L56ltgwKzO8=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by CH2PR11MB4440.namprd11.prod.outlook.com (2603:10b6:610:48::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 06:16:25 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 06:16:24 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <weiyongjun@huaweicloud.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next v2 5/5] misc: microchip: pci1xxxx: use
 module_auxiliary_driver
Thread-Topic: [PATCH -next v2 5/5] misc: microchip: pci1xxxx: use
 module_auxiliary_driver
Thread-Index: AQHYwsfZfRni+0Ehb0+ISLIO7/D6eq3VDGVw
Date:   Thu, 8 Sep 2022 06:16:24 +0000
Message-ID: <BN8PR11MB366875590A4F506A398B3FCDE9409@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220907145808.1789249-1-weiyongjun@huaweicloud.com>
 <20220907145808.1789249-5-weiyongjun@huaweicloud.com>
In-Reply-To: <20220907145808.1789249-5-weiyongjun@huaweicloud.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|CH2PR11MB4440:EE_
x-ms-office365-filtering-correlation-id: 9c2e5f73-d3f5-4ee2-a558-08da9161a860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNDOFQwzXob+1UyfMa+VdwCK4rzeiI69gx/ctszfaYfwrp5q2ugAzn5rYKPNOOchc/JsXOHc3c8XrPcLD4JZpKX8uzEC5GxoKWyMj6UyHJ/0eOuqo6t6KrOsMIdfc78nD2IauGqgSst2l1RcWjIjVQeiRReomcPZv7mK8fZo+VgvGXAsetadrUMZM9ew34ySVW7Na+u+pDZSgta2tgxYR7yMxjlD+9zDJvqX6DTnS0MbbqiJAHhSMuoYGnqHzO4iG8pYtgQ3EhKO9qOG1HY8ZdrhQvW/uh9gPzThpOSP8qsKsnQnTLgnD4jeTQGIbWxRTOUOGweP2g+xskCvfET4bts28cpF/KfvTPGA0Sqzp1CDZLEE1NokxU1nDwmoGmLQG+YzQ7T/b6w2HGsK+ici9Nx+d1YxV1MQRrjkNBTG7t4ffbYDBWop063aWMKXP0HnD8AyLd/gJTwvj0Bq6JccA+AlGlcrVl3tZPmJ9TnE9MeWUvrmt2YPqNVRGAIOpWGh477vQNIkzWK5k16vX6HkIa/o8g8W2WcNMeOxyNu/5aPE059xUIsQUrkDUHMROS1pHSOqOPezLAsdBz3kBToBg/yeaK/abPZ3+emezBSUXCjpncsaT7euwXxaJhihCk8o1qJ+2w/xhBBvHeDw2FrbwObyADMbcwOpaOD6yAlP6K3RkLYJ8pcQ0O91vzmtrZeMlqiSttsUmduHYYflM17uGepdY5ws9rdqy2ZW4M6Xkk2h/ZfxqUgu9duuLvsHRqI6METTP6juPAdUwEdViKdFw1C3LWg1FYZIJXDCk2ZMUttAPdheM6OGvJSixYkN9D9OOTQOF6TbXAy5KCDYUzJo1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(52536014)(83380400001)(186003)(76116006)(38100700002)(122000001)(8936002)(5660300002)(7696005)(64756008)(66476007)(66446008)(66556008)(66946007)(2906002)(55016003)(478600001)(26005)(9686003)(6506007)(8676002)(33656002)(110136005)(71200400001)(4326008)(41300700001)(38070700005)(54906003)(86362001)(316002)(53546011)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o53gn52UWf3wXVhDpZ/8iV+5GDPZ0MeMR1gh49fkv+48jayhIHI8zKQ+4UeD?=
 =?us-ascii?Q?E9j0lxh8+6dtzGrR0GBz+MQeFoicGQ6b8MK7Mu92Bs5R8T+vdqgX6NVxSbBj?=
 =?us-ascii?Q?mX+2PRzuUoxY6QF3fqcGmGRmHuixMsMAlpyMYrUuaHdEyXwHi80YIeLuCkYF?=
 =?us-ascii?Q?V99us842SdaKqfDdQ976ji2grGiyLYsOJ1q/r0GwW3ESHL4Mec3AcMJPYr0g?=
 =?us-ascii?Q?fywEmnZYnnwtpJkxc2eLNr4TfJkUKw2/wamMeamtxM2xXPC6XX4WUMJzVRIB?=
 =?us-ascii?Q?7vBkMAM/YLpON5+akPzUZ4JOHWpCdDEweKIGdKNidl4BGTLhg2tr5zdNOKcm?=
 =?us-ascii?Q?WvgRvm8aVkGWTYsEJx1YkYJU4kiHtb67PlhWpKV2FjFZOXeJGSbGHFF6v9Sc?=
 =?us-ascii?Q?s2w7py46PGhJsXXoSd/LyBJhcYMe+GiAaL6Lxhkw2JUmfDuWaiqZ7PcMH2+i?=
 =?us-ascii?Q?A1KUtNROzSTiDD7lKTZtZ7ko0X7a83jzDdaZBlQvg+YzWBNoeBVZbe+t8WE9?=
 =?us-ascii?Q?Zz+fMbp2ckOz49LzU1mH/65/ekT3rJoKQswXtuqZl90shHm7z0IG2kH1Cneb?=
 =?us-ascii?Q?6iGc8k/LquG3uecBwrBCFaE/wMb3wCs1yaO1T5wnMTlXGpfXrpKZgWGw6EzU?=
 =?us-ascii?Q?wZDV/BvhrctO0zjj1YMuoi4l3lmiut4VLtxBdujfVir6qBZBwOh2dkCOXivI?=
 =?us-ascii?Q?46V6d5TIwKMlNCutkUpDm/t0vkCDq6I76gAQ7yr+bjhNbbVdeRzoG+6GVaz/?=
 =?us-ascii?Q?k6Pr78u5WX49BFfCUaXDe36JyMfNmEJjrZc6erbLoX6I9fbA7xg+1+ckcUt4?=
 =?us-ascii?Q?MYQT6hqqSwR0eJKfSoF5taRsqQAZ50kTNM9upiZCJxe0CvKZj+I+x2lBBnMY?=
 =?us-ascii?Q?vbtOZasS/Si9i6LktBBviKxqXpjaZEEtxS/kTe0bDy86zgOSw2dBnPVaIzaG?=
 =?us-ascii?Q?OP73OxAUJLev6vSoEJeKTfYcYW28iXKiAw4rw5TN/7MdAaOnvtE7fBObj8PX?=
 =?us-ascii?Q?FiXQN5rdJcDXu7qijKfgXuYtbgAaXQAUQhJ5d91Bo6omD4jfWUluVSaiL3eJ?=
 =?us-ascii?Q?RrZQ2kl2xr1cRRJf0x6/Ph2GMz8Io4quzsuWqxgJgs5u6yFLUi0PdX9KB58h?=
 =?us-ascii?Q?6/K27bL+9sdpNBbW5KI/Z7yJ51ojt4iTorJmMqgwrcM6bDt9r1J6kgXXqGym?=
 =?us-ascii?Q?cE5SUeZ9GVK4wkd6osD/RblnUDpbFnO03fjZGiZDAAIZBOuvFzP51iMECikf?=
 =?us-ascii?Q?bD79wWaNsJc8Hfi/SN2TgxEE00KxQSYatycvz5bM2Jl+bGV22rOLyCIixjw8?=
 =?us-ascii?Q?FZetFmmorGrhHWtS0LUhmICXEj1VsMzBHGri2r7y3JV6/j+f65J5nFPezi1+?=
 =?us-ascii?Q?jRwUww9dLucet0huwTmbDAFMWZOXSwH975FWjXvKnu4Cp/2hITmUmyQV7s7E?=
 =?us-ascii?Q?XQrresUxrkHBjgjAnx4xlaWASyBHgHGUtdNwCSM7tuvngEMCkCCSF7eRFTh8?=
 =?us-ascii?Q?yvKWopIjg9BJfYfk/jDeh5TqxxT/HK1GwLLdyoOmEv/nnPeAWQIFZpMlHhbo?=
 =?us-ascii?Q?RFzcW/GCRqFpxoJp1oIoyJf1o5UxUCsHDJoPJ3azysSobC11I6rqaIufZXUO?=
 =?us-ascii?Q?sftfRL9b36E8D+mB2mJrs7c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2e5f73-d3f5-4ee2-a558-08da9161a860
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:16:24.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7Z36R6n/EACoIHghpY5PpvzJVxQnqoZglhJ/7HEQgdzgl3ewZNNiL6qyTyFWHPlSBBnIIxkFqQVca8B1AxGnv95qymu7ILiFWRCC94fBemncvlNteFE7MizkuQ3M5Nd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4440
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
> linux-kernel@vger.kernel.org
> Subject: [PATCH -next v2 5/5] misc: microchip: pci1xxxx: use
> module_auxiliary_driver
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> Use the module_auxiliary_driver() macro to make the code simpler by
> eliminating module_init and module_exit calls.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Fixes: 7d3e4d807df2 ("misc: microchip: pci1xxxx: load gpio driver for the g=
pio controller auxiliary device enumerated by the auxiliary bus driver.")

Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> index fa80a7788596..9cc771c604ed 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> @@ -421,19 +421,7 @@ static struct auxiliary_driver pci1xxxx_gpio_driver =
=3D {
>         .probe =3D pci1xxxx_gpio_probe,
>         .id_table =3D pci1xxxx_gpio_auxiliary_id_table  };
> -
> -static int __init pci1xxxx_gpio_driver_init(void) -{
> -       return auxiliary_driver_register(&pci1xxxx_gpio_driver);
> -}
> -
> -static void __exit pci1xxxx_gpio_driver_exit(void) -{
> -       auxiliary_driver_unregister(&pci1xxxx_gpio_driver);
> -}
> -
> -module_init(pci1xxxx_gpio_driver_init);
> -module_exit(pci1xxxx_gpio_driver_exit);
> +module_auxiliary_driver(pci1xxxx_gpio_driver);
>=20
>  MODULE_DESCRIPTION("Microchip Technology Inc. PCI1xxxx GPIO
> controller");  MODULE_AUTHOR("Kumaravel Thiagarajan
> <kumaravel.thiagarajan@microchip.com>");
> --
> 2.34.1

