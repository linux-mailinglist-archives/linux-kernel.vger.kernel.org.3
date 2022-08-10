Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB158E927
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiHJI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiHJI5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:57:43 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C56F563;
        Wed, 10 Aug 2022 01:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs4HPTZyH9Szzp7pLmeLB1Qmwar5lRaRuaLxK+b++XJDpcwDLpVNY3ZkyT9h25lveUevGXQhzenXNasbwEfZrL+6PeJ+n/vGuHqQapKu6EydNhUijfmT17kY3a3wPDAKj44NQlOTeQqv+oDFY+KyXOjBHk7ld2ue5wPJTkY38CJcQ+y+eExYSzE/ev3JQEfwUJNj8mxYovyw8NHDTKLUHwQtdMuLx8V9F0OH1znjKbxHWU+lOiDri1BtH4GEfgTTm4gEjgw/hC48gRyZ/H49acIiiTRz6TfPGUrSivBeXZ2E64ujWOotCirRilskJrRPfdECKNbF2DgmhGDrTJdivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAIHYmB3ML+yhlvzunM1jkCwgzQlvOOce7VssoQX+Ng=;
 b=ZViFT7SHgxus1aVaYYC1V9XquyAOOtqqIczSg84snbH49avSJAyxzNjCJjvo8ZBwK4H2KRtrs41VC3cT6OvJSAY+x7y4L/6HmFjcRvv950v8mc2gvIvHSJL36dNCnJHHXf7qtJL7ggQuN6h1g6+pwDExm+oMX50O4g0gGR6D2rOMXsgOzgrdUHpbvxw3ZAY9Y5sM2kYMi7UCZfTJvNpy+y4miNszTj3rq3Se4riSZauOV2+roamje/SHrvFQfE6Qo4RzQLGsfpjwIWOkX0PCqLst5jLhr6eY7ZNSdL56EFL34Cqhh2bRkUJ848fYkodyKkfMyhQnXEOUhxCTI2czhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAIHYmB3ML+yhlvzunM1jkCwgzQlvOOce7VssoQX+Ng=;
 b=CFPlH22YaqM6KXUAoxBVP1gzjuURA94vf7QgED55LdFUg7quiBO9toHlZ6PeQ8EoScGHKytmX6EYwCrzQoJG/TZlaDDWygacbUOZd4Z2wK+e0soJCDKLffOufbsJ+hk2fb31Pu67JEubCq0S67WbiCmKvvtZNT0jOUHCTJLNzy0=
Received: from OS3PR01MB8365.jpnprd01.prod.outlook.com (2603:1096:604:190::8)
 by OSAPR01MB1604.jpnprd01.prod.outlook.com (2603:1096:603:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 08:57:32 +0000
Received: from OS3PR01MB8365.jpnprd01.prod.outlook.com
 ([fe80::78d0:a753:ad4b:de89]) by OS3PR01MB8365.jpnprd01.prod.outlook.com
 ([fe80::78d0:a753:ad4b:de89%9]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 08:57:32 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: RE: [PATCH v2 21/26] thermal/drivers/da9062: Use generic
 thermal_zone_get_trip() function
Thread-Topic: [PATCH v2 21/26] thermal/drivers/da9062: Use generic
 thermal_zone_get_trip() function
Thread-Index: AQHYrDwnccF1ppINE0ulyWKwlJAPU62n1PwA
Date:   Wed, 10 Aug 2022 08:57:32 +0000
Message-ID: <OS3PR01MB8365D21416FB02034E8B214DC2659@OS3PR01MB8365.jpnprd01.prod.outlook.com>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
 <20220809220436.711020-22-daniel.lezcano@linaro.org>
In-Reply-To: <20220809220436.711020-22-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2886108-f10a-47fe-2c25-08da7aae5c9f
x-ms-traffictypediagnostic: OSAPR01MB1604:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Po7kTFi1DLS2mxtBxC44OMu46DlQ0KmWoWRMIz4I4KTiRMWAxHbDFB0ZFVQ16+mMLgwCp2Xi+DiYc86SON9QoZ/5cMiY7zqC9T9usU8Cb6pm6ZMhddl72x9nQMm552w2gRdLgHv1rQVXwjx510S+xqlCfltjboXsy78Dfiq0euwqH8reQ2FnSY4L13TbkCPztvqlxP8ZQnW1RUgD9N9/ISZjwMjjgW2lHNzzWP22CVYg2ojxD7nuCPlzN70ESR+l0BEoYi7DUI4UiDgdAlCg+7pcMovwmmdrG+90DewOXXqHS3c8Q9i13AP5yjImDxZsrui5dHuk9NV0HhVlsYPkkFNWN/Dg6Wpx87cPZD1LJ65B1m5xNC3R1ykCBlkk8Is7oFi6Hm8fu1Dm80dNb84izqWc4obFrsOUwwKUCCQTpjhWrVRAhelpOLWWtMvpPV8/iZBuBmhsfxRmjUJCmC2K8iJAyApAT4HGnr2eP2hNAcDTT4/bILrs9G3ZGGm+8DAk9jZx//z/2SYF/YQcwAv48uyw2Noa5e7gkPIfg4pU6pJD1VNgTGdF02DLf5fPqv9R6zVzTkzEug37lfwfW7JZTf4sfeJNlxSW/nbsqrTQJLbkJvPbK0OZ/Hppp+blZkqFcAOsP3qemVLxQj5EDrPGUQfVp1eSP9E1lSU2+tfeTgOGAuiqcxe1GERLXU3o+5lmPxMEgBMRcXvIxihkCgdyVD7RbIyp9HOxTy4c7IoFjRs2+Ew3ehhsu2JsBs3s2JQp5TclR97gRZgBStDo9sguyCr68WWiZGOtOj/NRIlVZFVqrkO2NCoi2lVlpCEKaAmHgf3xch7TH8f7Mo9M2YL6QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8365.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(26005)(2906002)(83380400001)(55016003)(53546011)(7696005)(6506007)(186003)(55236004)(41300700001)(9686003)(122000001)(38070700005)(5660300002)(64756008)(66476007)(8676002)(66556008)(4326008)(8936002)(54906003)(52536014)(66946007)(110136005)(38100700002)(33656002)(316002)(66446008)(478600001)(76116006)(71200400001)(86362001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1GruwB0g6hR7za3IWEofYItEK29d3vNrnpuy25jTR38Z0kRQvSZa6nonjgn?=
 =?us-ascii?Q?+UanF+CEu7018AD7E7E+nB+4fr5JeYIKvue74JREaBFALJOPQj/g5KzP0pE7?=
 =?us-ascii?Q?4YxXcgs+3b0oAdLvmno0H1tvjtw6ooHdRXztmG1fr8R3JkVos0w+CZSNNcyO?=
 =?us-ascii?Q?6Mr08sNe4QGAmBjT4yrRSpJ8VSfF4CetFBmGu8eaYXPGk5FZcHFIFaQwPSGq?=
 =?us-ascii?Q?ohHMptweywt1/uo7T7U6gRe5EJhsF2/vR/0Sspt35drzxJNO6dVoBNnsMJ+m?=
 =?us-ascii?Q?+X3rCjVQ5f2oDv3/y8ToYg8l6TxIKaXul3aOMMAY3XoaBoEIA8hjat1VnBmV?=
 =?us-ascii?Q?qTI8CJ6oJZXFCfUkrUhKbY9SfSWPglCjuU45U4ZnO6F92EVh7anqQAEGWViG?=
 =?us-ascii?Q?+FVKXg666t8zcZV+Z8AWQIovNw+4RY6m58URDZcKiLBwxm12xuPxWvOv0een?=
 =?us-ascii?Q?KgPbcKhwqdoRvUmMbLJ1a3XkNYU4jg3Ex1v3uCmnc+92VTgxFUb2riXYG4Z6?=
 =?us-ascii?Q?7dieZAUwDo7fC7meVSt5omVgPHKNe1zQRq+X2fBIoK2BsYAhzgt8LessPLeA?=
 =?us-ascii?Q?5FlDHpz4ZrKbxi5YPLy+g7ZsQDzmH1GOVN8NsJAxn4rY/hYy6XbCnzY0HLzm?=
 =?us-ascii?Q?ur377aRifgW7hs1WpsQUn9p9F3thkYpLm2LOMxge2gepT0vzTuxd21a/QOSk?=
 =?us-ascii?Q?oFwQFCjPZEfAVnfPmZ5QG7xLnhDUITJ/kO5DQ8pkalIU0NFQJmUAk46NtIqX?=
 =?us-ascii?Q?oXKrPNd/84VryeBJqH9W7wGBDNJDrc10prFPf/rC5/cbiKLB3t+MXQpVoSCO?=
 =?us-ascii?Q?SaUrd0jhDZb+RfrFbA5gVIbnKoSLcbQJ4HGjuWP1RD7ZumyH/SnUYoTv6lYD?=
 =?us-ascii?Q?mK3oWe0PTnZgt8NjkojDhjCKZRY/VZilbZL03LFdBDhCe45xwFP/oELJwClB?=
 =?us-ascii?Q?5QJlx0IZt2nSITDt53k6BF6abIpHW1no86J/XefStvcyvSavd02jDYagREra?=
 =?us-ascii?Q?ivnfjCkf/aCF5kzXU+6Cb/lOWLyJHmAQBYUBAvXiOkVX+idccziRMXqdBwP2?=
 =?us-ascii?Q?sfTV8e60M7M1/1ZNnc6JRmLGdyXQwsn48fbFWZju40EsxsnPBCxnJmzEAuIC?=
 =?us-ascii?Q?ZmZcAmPdKcePyBOnqCtKWTDHGFHLAArq+oA5GH2y0uffEJh2LWYj4Vkpxh2a?=
 =?us-ascii?Q?9yga9+ZYcjZjr+v3YdUGXC9m7egnCoH3RfX5cDtEIxeB8DuHlqkJcdHLCOUB?=
 =?us-ascii?Q?7CkfgkcgaITquv5nKsfBv4BGgQUKIu8OfdKoH15yk5aFMX63FFiWiYenFlYw?=
 =?us-ascii?Q?QLNtXEBoCgVGfU7o/vJAzGWLIPgHFVCE+MwLpn0+ccvR53m5pePMcRGo0XF3?=
 =?us-ascii?Q?GlbLwh4KHhYG+XPaPF4IOJ8TezCIq6mAW80rU5oWtJKz/5HSgjt0H7cZBx4t?=
 =?us-ascii?Q?GCYQWjZzjNI363oIRDQQH2iJt3q5tzJS+AcGoQFJN5JeKYEJlaDsNfswAUSu?=
 =?us-ascii?Q?g0zFk2Tt1aF0WkK3awQawE/7owM3fKGO+WSM0rso9Iawp0m6c5URK0n0zNCx?=
 =?us-ascii?Q?K6V6KKFqVxSCQDJrhM3Ifdo14EHv6rqJ3rja0pQ3hXPmxHYneQ61Bpit0GRI?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8365.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2886108-f10a-47fe-2c25-08da7aae5c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 08:57:32.3023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xzclfRjKYu3ol5YGpmdc1SKi1OGzhEP2LoY0IirIjEbRCtUl+FBwm0XFU/AkPvRVQMbC40fFa2g0lbA4hL6LosL9vWnIlaF3bclW2GdiUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1604
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 August 2022 23:05, Daniel Lezcano wrote:

> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
>=20
> Convert ops content logic into generic trip points and register them with=
 the
> thermal zone.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>

> ---
>  drivers/thermal/da9062-thermal.c | 52 +++++---------------------------
>  1 file changed, 8 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-
> thermal.c
> index 180edec34e07..1e163e90d6b6 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -120,44 +120,6 @@ static irqreturn_t da9062_thermal_irq_handler(int
> irq, void *data)
>  	return IRQ_HANDLED;
>  }
>=20
> -static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
> -					int trip,
> -					enum thermal_trip_type *type)
> -{
> -	struct da9062_thermal *thermal =3D z->devdata;
> -
> -	switch (trip) {
> -	case 0:
> -		*type =3D THERMAL_TRIP_HOT;
> -		break;
> -	default:
> -		dev_err(thermal->dev,
> -			"Driver does not support more than 1 trip-wire\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
> -					int trip,
> -					int *temp)
> -{
> -	struct da9062_thermal *thermal =3D z->devdata;
> -
> -	switch (trip) {
> -	case 0:
> -		*temp =3D DA9062_MILLI_CELSIUS(125);
> -		break;
> -	default:
> -		dev_err(thermal->dev,
> -			"Driver does not support more than 1 trip-wire\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static int da9062_thermal_get_temp(struct thermal_zone_device *z,
>  				   int *temp)
>  {
> @@ -172,8 +134,10 @@ static int da9062_thermal_get_temp(struct
> thermal_zone_device *z,
>=20
>  static struct thermal_zone_device_ops da9062_thermal_ops =3D {
>  	.get_temp	=3D da9062_thermal_get_temp,
> -	.get_trip_type	=3D da9062_thermal_get_trip_type,
> -	.get_trip_temp	=3D da9062_thermal_get_trip_temp,
> +};
> +
> +static struct thermal_trip trips[] =3D {
> +	{ .temperature =3D DA9062_MILLI_CELSIUS(125), .type =3D
> THERMAL_TRIP_HOT },
>  };
>=20
>  static const struct da9062_thermal_config da9062_config =3D {
> @@ -228,10 +192,10 @@ static int da9062_thermal_probe(struct
> platform_device *pdev)
>  	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
>  	mutex_init(&thermal->lock);
>=20
> -	thermal->zone =3D thermal_zone_device_register(thermal->config-
> >name,
> -					1, 0, thermal,
> -					&da9062_thermal_ops, NULL,
> pp_tmp,
> -					0);
> +	thermal->zone =3D thermal_zone_device_register_with_trips(thermal-
> >config->name,
> +								trips,
> ARRAY_SIZE(trips), 0, thermal,
> +
> 	&da9062_thermal_ops, NULL, pp_tmp,
> +								0);
>  	if (IS_ERR(thermal->zone)) {
>  		dev_err(&pdev->dev, "Cannot register thermal zone
> device\n");
>  		ret =3D PTR_ERR(thermal->zone);
> --
> 2.34.1

