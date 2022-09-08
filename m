Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488EF5B1458
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIHGE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIHGE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:04:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539E1222;
        Wed,  7 Sep 2022 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662617061; x=1694153061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=COfWmF8nc/hmYS1nMPHHAcZImKPIyjTZZyCyLR4kxGc=;
  b=pAF+63r6f4LfE/9D59wxv52d8k1EntEQK8pksdziKzSTdW3uX4AfZzBd
   2bkA45POQthzfV9mxh1nDJhK4JDpdh62phPTizxOMzwTJ5AQw6NQ82O7k
   VY68kRZ06AyeSuTipe18hhNOplLu7h5YYeA0ShtYkOzGCSccZTW3Tcg6O
   D+EoGf4B6YR+2LDGtu6AxNcz0DGpbNY6BG21yBS8CGfmipfpkT4JCHT9I
   rAPc3fYxobQ+4pqiLFebnyMGYuiqAdmyvJ3Qmea8FJFDHyugZucg21ySp
   Iz5NFmWNExuVARuv0yFbxbaLYAQswpskJUFXxDf19oW+fC4kaUllcNUpq
   A==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="176149427"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:04:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:04:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 23:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxlkA2eA9LuHWoVaBpN8HrXg1g/uG6N9pqlf+AbXiDo9hkRQax1dZ6QszXh9pU1/NsfZ7D4I4xMANkwSfq5nBc3p85lOL/lHd19za9iE0gBRr9uWkH9yhmG32SlpqOJ+V6dA+JCmXGpG1IrPYknO9CCre8r9c1CqKkCp0XjipnvZOZaOcg4uW8BYmDTPZ1+W1+4EVULuS4QZ8OzJNClFEoo8bag743ApxLzG6Molzzd02p8wmzfCjH5ScPSZYJdRjsANmjeIYHeXKceIeiSpomb3Z/LItUmbRRbCrLodepZeIxqpxPXm4Lg3M7+shqEpE1KAEtS3INO5W7X9+1kw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWxrE8uwZXLMO60E3FIpBK422cRPu3QH8LZNIX3MWcM=;
 b=eugiTZwFGMtW7nXajIpgLDARNwG8mK42SpTxh/EQSFmlT1AMwi9DSfp5ch18nqs1hqpPpD0DZivwNk4LvcEE4UOf/QLK21CltGBWHx1lDHRFCnDqJbDEZz4K/RzttZ8iYXgz5uvlIvBAHz3NELNUant52/pRmtQefCy4+O+H0WQaVRV58kBsPpFadWRK9yMLG0bVl+adopg4IV8tS1NvtAFKKhlH56eNfZoNirRN6BESY/hhRqu+4arL009pp8A3csaU5p1Lf1CuPDAK1NNzPqwoPIb6sDoOdDWAldUTNqk/tNYvXGCYgs2OLFLnGKz49iDW1DCPFP5x8w76q8MWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWxrE8uwZXLMO60E3FIpBK422cRPu3QH8LZNIX3MWcM=;
 b=ZgQf2hMGzpWnByxMk/R8FWWBB++Poe64O0G+Ct/uoRz1PgSej/pdkOy3w+NYPDFBXjvza9gs6R3efLXMbS2NwTaYqHkGK2MJdqmmsIN/xop+65upfigOyCtqD+sPDAdhpic2q9hh9fHeJknULL9623OatrSRVNcmZ/FXDBkqtlM=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BYAPR11MB3063.namprd11.prod.outlook.com (2603:10b6:a03:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 06:04:09 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 06:04:08 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <weiyongjun@huaweicloud.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next v2 4/5] misc: microchip: pci1xxxx: Add missing
 MODULE_DEVICE_TABLE
Thread-Topic: [PATCH -next v2 4/5] misc: microchip: pci1xxxx: Add missing
 MODULE_DEVICE_TABLE
Thread-Index: AQHYwsfZPpR+viOTEk2GAx8LUIjsRK3VC8Wg
Date:   Thu, 8 Sep 2022 06:04:08 +0000
Message-ID: <BN8PR11MB366836E558A74D5A4A0C7239E9409@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220907145808.1789249-1-weiyongjun@huaweicloud.com>
 <20220907145808.1789249-4-weiyongjun@huaweicloud.com>
In-Reply-To: <20220907145808.1789249-4-weiyongjun@huaweicloud.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BYAPR11MB3063:EE_
x-ms-office365-filtering-correlation-id: 457b1227-9954-448f-0a19-08da915ff18c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OIcxb7tyiMBchjuplo5PEyqkBDdWa4vqL+LPIh3dQpEt3DT9Z2k2W47bZS8HNayX1jIAlDaegsfY2miyrTa6tvreR2T91JvqySPDwVzoRfmW+G0rV3xKk+0Y7FdxpeywBRrpvMdJatdWFa6qLuJWpmjsXT0egudLUHi78XfMJVU8nC6PNUDhS3KRWRftwZshWMIJ712qojeHJTYnLcjfQRMcVkCpwoOI0+ycm9iM9jc92mVfHbF4XLl77TO1yjj6umJ87KDvFkaJ3NRlmxmUMtNTtSGNQy9ZVPdDjpudRU7svgr0v6B+krtaXJNddvsyXvhpgxbHB4q4fs9Wp6kUbJaYwqtOCeTpANcirSZ236eJvthDhdBQgq7QLero7Wyhp8+njWtbuX162KVzruvPv9HmfTueJJPW0L7Y+SnHFcxALEL26k1rOhbA97ZS/ru3Vk4kaVOMW3hlPcjJpK+UjMIjpx+hLgdPGQR/FV8C6c+Ub8Eo3FbvQ1UwTzfvaOMtB4a7Wg3R+OGuY4CqkHLLI4qnuu3/M2sa6dRNeFOcFuQDTFUwUE4Zb8ueTCzgj98yTyw8TlTDke284GmNplAOPo2gsQn0+5MtCPw6S/ZJacuhhakyL1UFh4zz1h2UZ9a0djw0imn2ZFe1MiH1Gt5aNVQt5zojf2aKriL5gVWHkyEJcg+QNHQGLE92pxXgZZxdoBYEymv7h3UYqudgOeXaS9Bcj/sNJxNXfOwOrS7rijcT+nTAfzBkWcDKHP5+ePJXsILp+BGLFqDWRfzZuITWOACkJNIDbXYVyVf21YAxO8bfXXYX/qGKOcNh31Z3s4KhlwSDIXVhM4kPo+hy5cFu4tjlsrvOdHSohly9VflQYdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(136003)(346002)(54906003)(38100700002)(186003)(122000001)(316002)(55016003)(110136005)(38070700005)(8676002)(9686003)(26005)(41300700001)(83380400001)(66946007)(64756008)(52536014)(71200400001)(76116006)(4326008)(478600001)(66446008)(5660300002)(66556008)(33656002)(66476007)(2906002)(86362001)(8936002)(53546011)(7696005)(6506007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p4xzFdU0vb27YDngnIHVw+2N1IgxC7CCPvjhJgaex/DkHBuIjtBFX+UrI/ha?=
 =?us-ascii?Q?GIG+ulwf83R17DGssHF0334UJ2ouX6LPstcf9uWt4fFC5w7QE+zDiZXfoI7a?=
 =?us-ascii?Q?p+o8vkh12t3fXRSZzI2PzGzEDwvDfRnoSnzLS24Bd5SYTKRJhRXiV8R1oj3b?=
 =?us-ascii?Q?XR6EONsd6B/wuzHEca0T78ngFW5FJbwhJiBHAkMAhJZv+Rxvwv9RDb+xtpRP?=
 =?us-ascii?Q?tgXsEdtjgOsTg8fsEEKTAu0n8WNrpUYuNBezHaYr6O4qGO7v9lMGLo9CWEUQ?=
 =?us-ascii?Q?KQJppAxHSYXxBOsFlJrgNG+u39i0ppjbWkUC9lTU4uFkjSfxA+wnR0I9uxUy?=
 =?us-ascii?Q?6FxsFDIppt7qNiUWd7wUalMSjE8HRS/LyZFBZqFcAS8YbvWw9hYWcmskSvT/?=
 =?us-ascii?Q?4h8aD5JIU6AsIbYqjdyMR/ozDsvUk42KAOXpRZ8XuNG/j1oKzb7SLiOZcxX6?=
 =?us-ascii?Q?+FMZBgEaD4sdyaDS817FLBnUaOwOXzITpZoIQ2eTPNZV6Jip9nOx8tjCOMs+?=
 =?us-ascii?Q?kzvYx7AYf0CQesce0QUougR2viGUbzagiBAwblQ6Uqd/cgL6rD0yhapEu+8W?=
 =?us-ascii?Q?LdE2Xgs5vjY9/uXjDFwhG4WaNBto9qMzZsh0u013jIhdl9E/E3W4KZR2ashV?=
 =?us-ascii?Q?o2aDMQZzaLCzvX483wr9uYtdm7B4UxBen2Z8ym7mepRWvj83v5/xGbqhHMQL?=
 =?us-ascii?Q?gYM+KDs9qtgZ5WSMyWbAm3WY40Hxza6AuzkV8FPQryBmZqDEvxxWODFi9JKZ?=
 =?us-ascii?Q?MKfranBNP4IsxkhTyqSuvac7QZZPOSJzWlJLeK5A+ZZK896s2dU1phhlMwKm?=
 =?us-ascii?Q?i8ZLaN5Pp7B+n3a059pct2RbQCCSG7HoFbdVgGYOQJHoz5U7HlzjVpQj7ftt?=
 =?us-ascii?Q?Mk+1j3rt3Ch+j68eK++BqcFF6MYaLqToPWxlVbSEKFeC/6C2HBeFFJTSfAqA?=
 =?us-ascii?Q?S0wca5ZdcMnFLGiyX+h/H0DTpP2WV7YyBnS1VKVAIP0irgmoIqTfLP2cKDS3?=
 =?us-ascii?Q?MGkOyu2nET78xqR3H3phInbL2tA7wWl3PkDd+1X+xWClGIX5VCbP1K37RogM?=
 =?us-ascii?Q?uKbDjtlHPsYOCT2OMcA7dbhIZOSguABEz51EER4G8oClucdujYeJEtq3KaPk?=
 =?us-ascii?Q?eySxHvBvbhgKCjNFdSC5XJUL+3Bib+eWWC5n3ex3WCSZCcpKJl33SNGUwNxb?=
 =?us-ascii?Q?ZTwkLEbSb43xgcnL6OpfIwHgw/PeeAGpIU9b9ClhAzsWofew4GI89Ti3s730?=
 =?us-ascii?Q?knSlUTYvqLZWgYcnyqJf7w2zY/2ssmeKVuIG0XA0zHP1yAs4en01OJj3I2va?=
 =?us-ascii?Q?rP403nIhhiCqzXwEYGHE7nQhIcMq5971p47I/wvKiGpTeADUok0QZrpJF4SR?=
 =?us-ascii?Q?RchWzKDXgOBuvup8f5GrK4jOxliuF7YGWLgk3zE9Fj/HpJJ8yqwXXK/mlbsR?=
 =?us-ascii?Q?9S5mOXZNopOIVwbQ5V3lrpdc9SBYFx+40gEySQIDPvcmvWTCcFHnnCGon97F?=
 =?us-ascii?Q?93lnrLewrb0tNTvVFlrMO3H3n51F239xOyOZ2voXgqHimFHWyWJDdAFkPXZ7?=
 =?us-ascii?Q?AXRLjw9EN0jhNBomNRnfX2VM1fGpvRZLNOvN3ACCsAwQvq512+vgYQMV5+Iw?=
 =?us-ascii?Q?Vhwzu6jjcTg6ZUe8sMQzU54=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457b1227-9954-448f-0a19-08da915ff18c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:04:08.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmKQGTNfP3N5r3mlzEhYwD0/MRJqCWgSZXTSJjfQN1wlEhz5gAG+jWxWcfUcpnpHEpkiA2kdj1ScAVemfTvHAorQR8xepoJMpmfkerSmX27BCJSTXvy8goIzPdmEpXH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3063
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
> Subject: [PATCH -next v2 4/5] misc: microchip: pci1xxxx: Add missing
> MODULE_DEVICE_TABLE
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built as=
 an
> external module.
>=20
> Fixes: 7d3e4d807df2 ("misc: microchip: pci1xxxx: load gpio driver for the=
 gpio controller auxiliary device enumerated by the auxiliary bus driver.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

> ---
> v1 -> v2: add fixes tag
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> index 4f26871994ee..fa80a7788596 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> @@ -411,6 +411,7 @@ static const struct auxiliary_device_id
> pci1xxxx_gpio_auxiliary_id_table[] =3D {
>         {.name =3D "mchp_pci1xxxx_gp.gp_gpio"},
>         {}
>  };
> +MODULE_DEVICE_TABLE(auxiliary, pci1xxxx_gpio_auxiliary_id_table);
>=20
>  static struct auxiliary_driver pci1xxxx_gpio_driver =3D {
>         .driver =3D {
> --
> 2.34.1

