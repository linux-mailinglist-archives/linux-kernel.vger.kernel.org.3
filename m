Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590AF566334
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiGEGgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGEGgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:36:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093811143;
        Mon,  4 Jul 2022 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657002966; x=1688538966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cELUVh7ttuDMwL1tee0577yCkaEhhfQENzMmbMeDq8k=;
  b=zo2LoBaofKZH0E5iP5T1yPpzp6xlLzar1D/YJqU+4mIBEhZRUC1XLdFg
   l/BDHriHo2eLW/KAKcL3bFMyId5F6sFdfqCAPD3FNnYkCKzQgZ+d0C8c0
   1yh8xVZfGuvdYhSqUkAYL2XGBZ6Wt8MeNHKgznfyu0ZY3k0aHBN9n+1Gz
   g3EfOJDqehxIpxiKg6MXnMIx13HS1H6cu+HeefDtsq+sCOrYl0FYzFrPz
   6tpYJCJcm3/voC1WsYk10N6o4URnu2idF0FnOSuHHclpE6PkWPUK4CUsf
   LJY3v9uDmxUBJeVYYTYqduDp726yrsiQ/osZimm/NoCSW/2mLn8YX1GGc
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="166368630"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 23:36:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 23:36:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 23:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGiC36tiiyAi79WjdXdp9jL3JiAKKKzf7Gvkn/2Hjf1/r4QGZ36dgPe+Ay6r8OnfL4FrtMBBq6JvYIbqCOvvRLK3W38J6wRlgBWO8VFgUGXdlmGoLqjKGN+GQf8GQ6r/Kf6aZ69w07xyAwxEgodUewigqpT94rCJohmGhJOhGinCOE8sKPYvshroL0y6rMmjmItXJGblMAVmDMLPkeNT3ufzWPG6rfHZncLpzXWHDxYpZa6Nmrq0uIUSX2BO4oLza00Fda6Y+3+s6lVn0kCZOn+9ki+EtoCuC8qBAS5YrA2lxO3eLOAK3Bl5P95klnjidwr9xEeF7NYAGksFoAAtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAoBqxTB7x950xHWIiK0YZOSEIrNCd92s8V4aRlqrCE=;
 b=cmYwunxaFNQUHWyK5tg2666yNy9it4Wt+OZ+AxVLWa1a+UfE+8s04xlxBfV3kHrLZwg4bYAwOQi9HTPJ9beDpj+yh7oxfe0x36+lRNEHj6WfHD9Wz5cy/SMQ6s5gBmPwUVhPdaPOmzFZzeJY0q/nsuMqv6zSSmeaz5WDX5bGMlDlj6y1U0y79UChAU+9Ji05uZfvpKbf7IBHV8LS/rAV1R2DYE+umjuopYsvmVFazmq6o4l5KhjlugmjoBnpp9muvz+LzuuRuZgYmoXaF43addfpzrpfC6AecV4IYWZ0SHOhtXeGGb7CnaE8xj4eglixji7O1Egwb4bUYRV36IdoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAoBqxTB7x950xHWIiK0YZOSEIrNCd92s8V4aRlqrCE=;
 b=uEBO0/DdRzVyn3OolekXYLSSlnU0JSqdSA2zTZM2BiKfwfyShVfhmZ4BAx63bI6qOp/YiXneRp9wT8sySk9nseJ5hf42DbPSje68u0lm28OHdm541FMJWj6BJAbSICb81J9DMH+SrCQ7R+jej3C0GB1XOHH7gxJZtYcY0msb0O8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 06:36:01 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::e80a:618a:2b58:f2c9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::e80a:618a:2b58:f2c9%9]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 06:36:01 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <robh@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <Claudiu.Beznea@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYgktCiqqptpU+dEuWUcG+O1Oj/61ToBIAgASPMICADTTcAIAKCYeg
Date:   Tue, 5 Jul 2022 06:36:01 +0000
Message-ID: <SA2PR11MB487472B96E8B1FBC0B50424A92819@SA2PR11MB4874.namprd11.prod.outlook.com>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
 <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
 <1655474312.882258.1508989.nullmailer@robh.at.kernel.org>
 <CO1PR11MB48653378BAECD414F497D59592B09@CO1PR11MB4865.namprd11.prod.outlook.com>
 <20220628211638.GC963202-robh@kernel.org>
In-Reply-To: <20220628211638.GC963202-robh@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f5ce4a4-3496-46ee-784f-08da5e50a0cc
x-ms-traffictypediagnostic: BL1PR11MB5478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+XtNkbK0gaihwIzSt3E1afhiD+oKg/oH2Y+PlfilrLpdJ5I42G5/SVZe5DTBpmvFT+D/CmOcEdjGv5ho2uawyhszdl+K6je8Oji+igfBOXL/S4T0nw85qLl2d1nGw31nNRdUyN6cdn+PeO5UMI4qfNfdTOGm7S22UemU6OCU3cQBTy8nVjKux7UXhsRmYbzt2ZExOzzr8CgFZWFvi9j3R1WCe/AwGH2JyI3PGz+f7NGiywNz9l3IOYfu3VOYXwlt28xg3TmcWXBIbgeDxXlCmccB6cF9HmR2Nr7YMIdbnzyUzkdhBk2e6uxFiVuNv7WLvyl+zSGZ2ygOYUaySx74SY1kvRYK7w7fOFlCQ701XIHfEhmxatIeu+LuC6YWC7tbbCzAEsaifY7eCHKNevHmAooY1nXxdX24r2oUWM19ZX5Zv1p7hya0FhGMnllWEOzFcjeaBB28W8VbK7uSVzp/wJb5Xj/dWMNcXjJf2qo0Ljao1545fbVTS7XhQGBzyjWEbpPgf0EKsJWO+rbFZEKW8637XGB6lkW28cpJnhwzqMolu+hw52lykPk36Vu7Uc2qwZT9hDFMifXIwMN50LYwnyCC1qmhRQKQnLFjPEsVnoXWFV+ipimDeJbRrnbaqk3Roprf38gka1DTAs9Pn/CJnSMlYzUKrh9OHPGhdLGLePkNu5E6DSuGBKTsDXmvRT+NVHRvhEnw6mosUXupWbgyhbYI3HUGGQuqrcx3Y+8C5/nkTzKMHRr0/WRInWeiZYSCFxA2Jh0vs6AJcybZdwBjwRmyzVlM1S5wZtYKUUDQ7RyxCyd9OJj3bu82fhEm9gggADFp/++747LGjteQ3XZy8+cMySDUFWKXsaeh5inWbRJlzYpjpcG5paPqpetMCHY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(376002)(346002)(366004)(86362001)(6916009)(38100700002)(66476007)(66446008)(64756008)(41300700001)(4326008)(76116006)(54906003)(66556008)(8676002)(38070700005)(66946007)(83380400001)(107886003)(2906002)(5660300002)(26005)(186003)(478600001)(52536014)(7696005)(122000001)(6506007)(316002)(966005)(9686003)(71200400001)(8936002)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RJI1nUUaaVx69Od7DLDOW4uqVfbrr42h8WcYURh0ojKRk95yOSe7DNTKjNy/?=
 =?us-ascii?Q?I1TLkL3B/Did/2cXMBiokr0sYGF5IRcUO9b1uT7vZdxVc4tiJmy13Pm+glZL?=
 =?us-ascii?Q?i5j9UP6CCg7i1yJ8YJtXp38lTEfa7Ha8rlzHlxPkYJaSAUWS3SYIGJsi6TU9?=
 =?us-ascii?Q?bq6TFeT8NWm4/0ajPRroIs4A1Yy4lXo8O2ZUnw47dIvun+MZTaLDPmcpVE1R?=
 =?us-ascii?Q?tUb4rO0IfEawNy7dipwNg17Z5yb4bGEV9HlhoVrWf0kAvIjufsFVYT3UN4P+?=
 =?us-ascii?Q?byPZyxIovDjDYQGqkZBReO8PFNcs2LOdcsgvQ09iS6xi7PmqNRaM0C1pOsq/?=
 =?us-ascii?Q?lroLxgGa0j4v4z5V+QkUCLoNU4r1Jcb6S8nZVaC+Go4NUB4ouGgAlmpiaNyL?=
 =?us-ascii?Q?5eWjDGeOpymc06wwBHMc2SGpEdoY6A0JD/D0VUPY0LURxAQQEdBSRxWWd4q3?=
 =?us-ascii?Q?Hrte6H+zBiZjFnhsniRlG1iHSrk3Iq/Y36JethBA9icKl6uLEaV1L3z2SiVB?=
 =?us-ascii?Q?5Pd8gMSK7Z8e4euuiw+frgdZRtipXanKDCJw//ACBQ/bdlX2MVo33zH81xOB?=
 =?us-ascii?Q?a9yCAG5ye29K259kVuWUK+ZUvYperHivOppQxE+OVNd7mLbsRlmg945mUyFW?=
 =?us-ascii?Q?UA74IFUDbbceGCF4euXIX2JM6PFk9pT6JFjFetlkVJ5x0UX047xL5p7GxtO+?=
 =?us-ascii?Q?VD2h0Ji4XGxY4Vwj/o6un6/9MX4eQM11kMwbM9wkZiMmtj2yDPBTYaQ/w1XM?=
 =?us-ascii?Q?U75n4M1hnwKVjADS9mM10exn3uLwyPUZBVK+z2DFhRiZb9sIxajHeza0v3ao?=
 =?us-ascii?Q?b6EeeT3DDgzkuQUFnnU7wrT4QHi6Zm8dQz6NE2i3Af5/E56bOuV15wP7T42y?=
 =?us-ascii?Q?LAl2J2FJ8qXxUUkNF5bylu/Z9JhfvonEE3Irdlu3tuq9gOR71ygvQyXeoanV?=
 =?us-ascii?Q?yU4DWGuKXHGqco27wMxO3E0Ms+JCcDh0jtEOktm/q3DyygxsExFMudpeiUpK?=
 =?us-ascii?Q?WVH6PIKgWXFxUPL92mpHqAZK1w4uQ6D5w6bM8QjEE4QqpAtC1RYsv+fgQctA?=
 =?us-ascii?Q?WoTeLeDAQbrxmk4MJPlnCl66zLzvzrAZv6XqE6xouQp8IDvAlSKU9Ap5hZiH?=
 =?us-ascii?Q?n32pioAXmfLufvkQNF8TpAI/tql1HZTVS9/wDo1ztNsXN+g/SYFWchq+bGSw?=
 =?us-ascii?Q?t1EcrfMF/Q7B5mjctKoTOevNNUd0W6X+mUJktsCOGD6ziN/dGgwn/YO4CmSp?=
 =?us-ascii?Q?z6w22g5ct6cWa3F+/1ykwXrZU6t8EO+bgySvdniGDaulWu/5j9X5MScHfdOM?=
 =?us-ascii?Q?IairJ4V1FlBHwfWaLXlDzxfnTq8yoay1GoKI6z2qq/liqJPYwSrTANuip5B0?=
 =?us-ascii?Q?+gj4ZyVcm3rS3fYD/NI512ybn7FPe2Yo8XnZN+ouB5kYDk/imlBbqdj7kZIX?=
 =?us-ascii?Q?cINxEISDKNby4RCDqC03fIfII45NDtdEkes9y5lLG0l6sNf0kv8lk7a5dMBn?=
 =?us-ascii?Q?h7XoXql6tyvBGYwozjzx8WKzXgeVQwAcYo2yGBK8VTjhwTtDu2eYrdcMRGVf?=
 =?us-ascii?Q?O6KPsJyNBReiKKvIguqi0UUcS0eBZxa+SjFIjaRjz4QdQGf+sQc+MW7wTNNY?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5ce4a4-3496-46ee-784f-08da5e50a0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 06:36:01.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOUu9awJzni7esaZ1ggFLnBLL9Q3PUiLJ5mw2ls49BEBN0OYNtvE/BLbo5lWJ1ujh62jjTuGJ/AWN64No2iXFzF/YAeCgbFPVGKh6Og+ApkM2XbUm6BibOklkpWbYmd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5478
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Convert the Atmel flexcom device tree bindings to json schema.
> > > >
> > > > Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com=
>
> > > > ---
> > > > v3 -> v4:
> > > >  - Corrected format of enum used for compatible string.
> > > >
> > > > v2 -> v3:
> > > >  - used enum for compatible string.
> > > >  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
> > > >  - fixed dtschema errors.
> > > >
> > > > v1 -> v2:
> > > >  - Fix title.
> > > >
> > > >  .../bindings/mfd/atmel,flexcom.yaml           | 104 ++++++++++++++=
++++
> > > >  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -----------
> > > >  2 files changed, 104 insertions(+), 63 deletions(-)
> > > >  create mode 100644
> > > Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> > > flexcom.txt
> > > >
> > >
> > > Running 'make dtbs_check' with the schema in this patch gives the
> > > following warnings. Consider if they are expected or the schema is
> > > incorrect. These may not be new warnings.
> > >
> > > Note that it is not yet a requirement to have 0 warnings for dtbs_che=
ck.
> > > This will change in the future.
> > >
> > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > >
> > >
> > > flexcom@f0000000: spi@400:compatible:0: 'atmel,at91rm9200-spi' was
> > > expected
> > >         arch/arm/boot/dts/at91-sam9x60ek.dtb
> > >
> > > flexcom@f0000000: spi@400:compatible: ['microchip,sam9x60-spi',
> > > 'atmel,at91rm9200-spi'] is too long
> > >         arch/arm/boot/dts/at91-sam9x60ek.dtb
> >
> > These errors are expected because "microchip,sam9x60-spi" and
> "atmel,at91rm9200-spi"
> > are documented in Documentation/devicetree/bindings/spi/spi_atmel.txt.
> > which I added in description as
> > " description: See ../spi/spi_atmel.txt for details of SPI bindings."
>=20
> If that was still true, there would not be a warning because .txt files
> don't cause warnings. You've defined the SPI compatible here and that
> doesn't agree with the dts files. One of them is wrong.
>=20
> Normally, child nodes either just reference another schema or document
> everything locally. You've done a mixture which is not right. Presumably
> that was to avoid 'undocumented compatible' warnings. To fix that you
> either need to convert the SPI binding or don't use it in the example.
>=20
For now, I will remove the spi node from example and send my v6 patch serie=
s.
I will add it back once below patch is accepted:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220629125804.=
137099-1-sergiu.moga@microchip.com/
Please let me know your comments.=20

> Rob
