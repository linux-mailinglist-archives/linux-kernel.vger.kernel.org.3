Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776D25B143B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIHF7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHF7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:59:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F8ADCC2;
        Wed,  7 Sep 2022 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662616758; x=1694152758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZGowQNTYMHVTn+7v/zjG2zM7l7P9JFeySR/aPP6cIUI=;
  b=p0m8zhIzxnNzq/WenVl3JRS0Dm9ealAALfCmk3uYkdvSMm8ui2A7lXDF
   BjIbC1lRjsP3PwAF/cAfgUfMsCwnx5HEXuFohs7kAb9BUO15b6ttkpiXL
   +j9c3PfKdJFEV0NzZ3EM5G00D8+BVIf1MZasUcPh6ze9neFvY89WK5Tz/
   IJ4mkGqzRf+fSBVUmO1IEcVtcfq14yZEFq9aelEChrgrJmvZ3jKafmmJu
   83IriC7ICMRxxJzhwWQCoPga77JIcVCGt1SBtWx0Wy7S/D08XL84HxUgM
   bZ42EEaBDGoMLSTee1uOaF0mH14s2TDkwhJaCa9sAjcviAVBqIUQGGlLS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="172894568"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 22:59:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 22:59:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 22:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbDinRz6XzJXMVcMzdTxQqBiV+TleqveVNd/30D7tm0LgwL1ZTmX7pYW318QyVrZD9EqEmPM534oev46Q/QVIUNdGfubUAocOfS2zrpEO9LObkpUYjozm00brfn5SEzn4NT4hGvVG7HQJbNmtSC9ZUFRSw3BWiyxXep2ZKgYQzz8VftyCja4eu39x0vlOa2hhsWBGNjE0BrBxHe3Rlx12t6zcLruz3CYUDnbzgTq0h1rbxS/M32nltjnLBmeKG7QswIlgAV+U7sN6D5OCsZhzpiv8LfovkDZg4XcxwvQohAT/F6WzKKhXZruY1arIDr6m1Wha9O3qA2Ku17FK4CJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTuFQUL/oCCF5rwtpc62uDaDOZmxavwe8InoRZOsIpg=;
 b=TTTfJNY0cJ4mrzuBGzGL1oacq5kQl4+5U8I+5G6mwOX7Fnddh7GfMzp/t9+j4qfuly9KzCVZSsUH2FF3b6vXXn92KXBHWXhqwhLUwyLXrhZfq30te03HRjt4xxShZliwRBs3LEgIdBlK0aqCmBaksIcLIAL4cdcU02foT1RuFVxG4LDBAELS98TZLRUfyXkf1mryBAczU+hIKB2wPLmcbh+zMQaetgNqg9Ys67bqvjulnjsOalDaBUooDg5SaVhIcsO2maF2Yg8JgPHsELX4ar39k7hx8tN/TzsWwbrfwUHLZpStowuqYjnsBA5LVs27+iGFugEofFgmdcj5FNymfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTuFQUL/oCCF5rwtpc62uDaDOZmxavwe8InoRZOsIpg=;
 b=m0etLAEAmIRUDjq1CDE+k44MNI/y8SzBzwT7O56H1kj7ubFEgNOEbnzO9OOfvksmipxBuA6kebmlEsJVs7wVVQ2i8DYf/9J3EI0kMjQjGDoiJUoDPtcxntOhrnDT8tKzs/h2tWR5mNIBEx7EXd6AsH96SDq2X7uiPMKKk6deumY=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BY5PR11MB4119.namprd11.prod.outlook.com (2603:10b6:a03:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 05:59:11 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 05:59:11 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <weiyongjun@huaweicloud.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next v2 2/5] misc: microchip: pci1xxxx: Fix missing
 spin_lock_init()
Thread-Topic: [PATCH -next v2 2/5] misc: microchip: pci1xxxx: Fix missing
 spin_lock_init()
Thread-Index: AQHYwsfa7PMhHkHaRUuCegivBl1ESK3VCitA
Date:   Thu, 8 Sep 2022 05:59:11 +0000
Message-ID: <BN8PR11MB36687E0E06862C7C89E26DD0E9409@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220907145808.1789249-1-weiyongjun@huaweicloud.com>
 <20220907145808.1789249-2-weiyongjun@huaweicloud.com>
In-Reply-To: <20220907145808.1789249-2-weiyongjun@huaweicloud.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BY5PR11MB4119:EE_
x-ms-office365-filtering-correlation-id: 4efddea2-ca28-4ae7-ff67-08da915f4093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ujQJ+np8o4pC9Qh301fIE1M6w9YGXPGpgig4Hq0N7WUDJdsIVzjE2TqLQZp5n+QZssYyypjgxi7d9YUSIKA6a3wPSmMI/AYm/orFmc9w0YYvwZ8lVX3l2wB1dms7ZJal7miqxX7GljJeUSOSP5kIctUeyvG0X36s32afavVCoLqvhANjOY5iNzGVjRnSFygijjviTzy2KF9f3fP2XuY66MLS6LHpilTIiT8KK8FLM3w3F/cwiyikcIct+TuCVGlEvzaNrxY+LjsKIpee99vapWCDpKP7LQs12IHgH5DQhoHnbEDEJ3xOxMPO1H5XnlJcVybrl8M8hI1f9XXI3L6IjRXxUp+o1UCKN5cBWM6Sge6vhJ+uRwaGUe88cHjqcvmxBXI2ftmbccN0NMIM6CLizqmERnuIWMGAh9wy+5sT07b3eOw3wGzBcibDgSqL2n8KffssYtCbIN4icsdHBykKCQOaUcZurdZmbWRhmo5KiQMQbQZK5Oy6RzylP+MQtiObk8idi39oLAwwV+rcy+U/4HvZ4hRVmY3oAp4Md+AqOah88D+Z5DihMsy5Hvyl5XsDAHXsavRjhoV7aFFdoDFprbmpN24vncAoHvQcjFVGHqNE0lqkHveG2azMcSdzpedCWRpu2Tw5FqmDXbFfwlp2lpWXBiRG07CajS6zqft/8C3pbEuIO0DXsOWd/lV56Kw79b3MEr3sM6NYT4ciljuD3bLZ+etg/j1wH0OuzG9FrATsTcle2xgFl62k7yk8fUU3v3jVh/e3Qw0+G13puHuafp9cMEFo6XKNOK97kuCrdvxoputmTEic54F7ms4GAQVvze0xts7UINC+5H1F2tF4mfvr/oldJFSF3stIA6ESgaY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(366004)(376002)(478600001)(41300700001)(71200400001)(38100700002)(54906003)(316002)(110136005)(186003)(122000001)(83380400001)(38070700005)(6506007)(9686003)(53546011)(26005)(7696005)(2906002)(33656002)(55016003)(64756008)(8936002)(5660300002)(52536014)(66556008)(8676002)(86362001)(4326008)(66946007)(66446008)(76116006)(66476007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qjpFRr1vXvm+4qYiXLoqGGmAioWB77oZpmZ10kUWeofEH5NJTPc2XxqfWkpc?=
 =?us-ascii?Q?InevehMbGunuA8DjbmgVh82RlRbNK/MDu/VD00bCdJa3uk9wmlnYOAPL5t7H?=
 =?us-ascii?Q?TAbbDQlvNsbsZAc2189MXwLDQIU62tuGcNpbQef6vZPH1KjOMLPcOhrBm7u7?=
 =?us-ascii?Q?pBRpKALGrPVaweL01uMmsNoYSMOz5GLkDfLPdgvyzax9lC9JxtpshHnBFZZm?=
 =?us-ascii?Q?s7E2SKIDW+cJqDU3QlqCIMVLqFc3d597GaHjh1FPE+hqbFyPt8oebF33L2a6?=
 =?us-ascii?Q?LK4SH4/aujaeI7ykZhwIuMv6ag8XOb40p0BhEkXkrJ0l9w5yEQDAqt8rWL+3?=
 =?us-ascii?Q?+C0vbjavfy+F4vfzTR9LjkKouiHOqW1XvN6JUJCSTZI4QqYd1CxaIuqBaWkg?=
 =?us-ascii?Q?SIJD5nOIB/38ePymdx4uhq1nAefb7nsxe8A7MH3QxHfFnF7R1jqGy6zrYhA2?=
 =?us-ascii?Q?nK2nq4NuqI7dR/bq6N5PC45tl7+STqb7/ZbG/Ku7/ZZKCEr5ZO720kc7T2Lm?=
 =?us-ascii?Q?zSfS5+8PcS3r7pYSqzhNxRXzT/29GA76c10KB6xXFUlYIAnwQeww+X8Ssc1r?=
 =?us-ascii?Q?ISzywu8RHDUSbIDt4GUCSHzLHTlAhgZy90tUgZAc1CgZiDR0dErDy4cclOA9?=
 =?us-ascii?Q?vH4/QlXUi26i36MTFF7dq+GNTiODJYt2OftAplkDZuQ6TJpHHOVmtgp8Cf9T?=
 =?us-ascii?Q?mNTpd3LHaxtsJXxpXN5L7QKsXAefmTP1pRBR9G0TJr/Sp3lJfRvmr3jw+dt/?=
 =?us-ascii?Q?DDYhms1pJQB114fI8FsV8awg2JC1ni2FrHKDHp1noY6Arhu3b1XyvKTafg2E?=
 =?us-ascii?Q?vathMe0LIyVWY40y3IvxzLxKySKT9/he33ljrbfklLHrOj70K9snIwFYSeGd?=
 =?us-ascii?Q?zIvUTZMeOoSv3UqW4XlhXiQ5b3VIzaLTMr2uy2+4GIflyNKSvpB6eKGsT5Rk?=
 =?us-ascii?Q?8Vys1NudT9YgrVCcvYmezVywwL4bw14k3MXa94ukfDKlMUihv9MzeIQ4q9Tz?=
 =?us-ascii?Q?gSSOp0T+CDsAPPDB4mcWzm07e4+iLZ626I/3U3Z5s6jcNdFPVoyEumRFZzva?=
 =?us-ascii?Q?3KjTFR30IraXBfMSQx9Dwu3E+S+i2ceE2/sTnW+WQgJ3ul4g2sE1H+w4ZcCo?=
 =?us-ascii?Q?0pFgazC80VWDBgcVdmZSeDb77BMNSSpJgUm22P0WuSEIJju6o5Hr12rj+V3m?=
 =?us-ascii?Q?yEjWLulC72Voy7/sWlp6aP6cVX/JGRq5ofIzkud30hJk5zPat+2mkE8Aposr?=
 =?us-ascii?Q?OIvFr9UJX/2CcX/TUdqaHmXW/58FtQelQRv19wjGiXoclE7RfG3d5i2B8QaW?=
 =?us-ascii?Q?x0CinpjyIxU6gZF3NtzSD/NyX8p2x34nvT0P6GJr43oGUI8q5/LQMons3fUZ?=
 =?us-ascii?Q?DQaL4ID5VzLdYundmmg5WvBKibdyHDM6Ac7EkRZtSp9Q626Ssdei6wPFyxm/?=
 =?us-ascii?Q?CdEiDO2bsRRbxWPxJGGKqMwDGN0MOswDjmoHyLT/7N5GXnoF0A7h9t/CYCPX?=
 =?us-ascii?Q?g1ZXHXT1soG8bnrSCazthFRfQCg8bdjBzHzvF5rMxb/3MxJDvmBtmEeBRuNM?=
 =?us-ascii?Q?bAgzig4PDLxLTqXRMiDvdu/wWuqxOqiE+oSZG3ISWcYQVnzj+LW64QLDAlRH?=
 =?us-ascii?Q?huH/4h9/81dU/Uc0t6IKNUY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efddea2-ca28-4ae7-ff67-08da915f4093
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 05:59:11.7395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHsc4v4QuXQmREfoAAh5dyVNTC6kzxISJ83szDfHqU9otqWIn2N8b9ziUxr/+dgdGxAeTzmn++okl08cBZz385qT+6uvJglzOeMNZ3a9+CdT56d3azgd7LSejTtpQid/
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
> linux-kernel@vger.kernel.org
> Subject: [PATCH -next v2 2/5] misc: microchip: pci1xxxx: Fix missing
> spin_lock_init()
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> The driver allocates the spinlock but not initialize it.
> Use spin_lock_init() on it to initialize it correctly.
>=20
> Fixes: 7d3e4d807df2 ("misc: microchip: pci1xxxx: load gpio driver for the=
 gpio controller auxiliary device enumerated by the auxiliary bus driver.")

Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: add fixes tag
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> index 230503cca2ff..47e6e87938ae 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> @@ -383,6 +383,7 @@ static int pci1xxxx_gpio_probe(struct auxiliary_devic=
e
> *aux_dev,
>         if (!priv)
>                 return -ENOMEM;
>=20
> +       spin_lock_init(&priv->lock);
>         priv->aux_dev =3D aux_dev;
>=20
>         if (!devm_request_mem_region(&aux_dev->dev, pdata->region_start,
> 0x800, aux_dev->name))
> --
> 2.34.1

