Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87B5A7CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiHaMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiHaMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:03:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D83D2B2C;
        Wed, 31 Aug 2022 05:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJquTHqNkI/UCKDBLU5GPaxMEShA/7k1OvrUZzTswoE6M2qE9FBmRkJ7LAwlI4E6+JZMtnMw/qwFZRhWNnMMptcfo1lwQpKnkINbANMFMBgvrmeAyFrAlIkh+P25Smi2ceiJ/eTRBTCXicWlhhrPGHuYMmHHHH9fPKDtPVZeFVnAz3boDiSmaw94OALTV3eWL9EHygqhQGS+hrmMBZcHrBerjnMPd0m3YA84viAr30IrwakgNtK+v5UCLgGEenDNZtVgwi5PJhlEKcC5YAvoprUSVoe1VzZPqNw8TtjK+2eokzl7tAPrT/qabaPvxgmy4TiFm4R6K+LCeqIGn/RMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiRhXkHOvvv1kdXBJq4Lk+X7KvTh9/CLEG6wND8Yr6M=;
 b=VYGp7orYwwVbSXFMM9o8snmQ72kR6mJrZ8MaEGenJMgxNOVYCV7ubxD6ShkL7XGPONVGY1scYawVS+yso+5KcpF/VTbVw4W+vsiIoCCUNV0pKoL2IaaeTQAIJdDawo74B0nEGiPdE/P7eEiJhmjJWHHqVhEPPFub79aAtN/ELdQxgbms2h64+5gviqL9urNVrMziLSM0BRO3N6snCH1JDCrW6owv5YYpbqEqI1mlTnElTZIWVV7+VcklfmMmx+zNLGeejKUMFgWi5o9qhw+74uMTVgkvqYpbETOFFwsNJIuHiM2s3JOnxzG4xQiXngWkoKO8Il3NWt+Y5CgO69A6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiRhXkHOvvv1kdXBJq4Lk+X7KvTh9/CLEG6wND8Yr6M=;
 b=C6CZj1lmh/ZWbgBvhhTDijeqVwl3NgTkW+KKx1e3XQqsLFIjKxRhq77W5uHAGFChMmOcRISpY6cjenNu1LyPaNvSW5aI+E9E15NgMYaZ/d39/n57GbNvTvjFjz5UjAa34GJ2RpkX+YkFBrc/LgCh+fv1V3KVFbfpMfd7c1YmEffyBQdpBxNXGkL3niInNF/KHmIdFqNQhDFgjLfLWWMiRLul149aBAOB1Z970LSkVpIglZCDs+z6vklGhq/NxH7fnd6705sSinDuV65X6cAAnh0TZqGA9dsKF7I+vQFk6cI24tia/7b108ysXbYvWuw8kXx5pOVr9AC9BHqq+F2hlw==
Received: from DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 12:03:13 +0000
Received: from DM6PR12MB4074.namprd12.prod.outlook.com
 ([fe80::cd94:755d:c244:f9ad]) by DM6PR12MB4074.namprd12.prod.outlook.com
 ([fe80::cd94:755d:c244:f9ad%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 12:03:13 +0000
From:   Michael Shych <michaelsh@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the hwmon-staging tree
Thread-Topic: linux-next: build failure after merge of the hwmon-staging tree
Thread-Index: AQHYvMh3SDoIXhMV6EuI27Q2jQ1X6a3I6S2w
Date:   Wed, 31 Aug 2022 12:03:13 +0000
Message-ID: <DM6PR12MB4074E31172FC1ECE2F42428DD4789@DM6PR12MB4074.namprd12.prod.outlook.com>
References: <20220831093010.10ce62a0@canb.auug.org.au>
In-Reply-To: <20220831093010.10ce62a0@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fd070d2-7171-4611-10be-08da8b48c810
x-ms-traffictypediagnostic: DM6PR12MB4122:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lG2C4z1sd4CFP0IlQOl6zUp89sGceZbeuF4NCjmJ/7JGIfCvJAdfrGuc9sP5k8iJzEFARbFt42wNhsFOPg1xRYgr2z1107Ufd9lmCrkgGJ6BpQerTWdnb1kb1dA0C0O7HdWEZ91WyWT+yOqbUYYJSGDnBYScblO/UMR4vSuU33uRDITVIGwVcjlYVbgXWInnMJbtiRWBozOF6u44wKGHKdaoT6sfUPXRjiekM6WJwWEJghj3suiUA59Zh4HwCzNfNSFVKhIyTOvky8bD4m1sOtQRZKtQhQdGiNYkeYOtARpOXoWoLz6Ru3OrI/zYuILOIMRBEN8JzhC3egktStz2ilRo4zAqehiUIhfUjZcpKCQJ/054kXPXoCy2wAPnloHNENQvxkOzKJAjY+CoWk2Hi4YIbvQt83pPiNI9cl5E8caW9K+tRXvmrj27bqyW8hbvbtuhCdC0cF6OOCVUbe67kZIpTysBJLyQm8yhVRiv/B1jIKlhU01N3ZldIzTo9hcNMcTkZWg9m7i6p1ViYBZFzaqT6ur8CvE8c1UqoM27pTcW4pZ3bw/KW3xZ6GFbC4OvVWe6iLNxayIwUhJ8WefRGENROSlfGVN0bbsCb7kyZZzIe9ZhM5T+liPthbU8taKIwlQUt5ckTko72BoqRdqq/z82wHJQj+jLTBL9m9RHoPIeA55QqH5Yodmho86c48t1nULlxOjD1jf2m3d8qz+EzJ9VJhMcSKad0FTLnIcBL/nHTWRmT+g0Emw/aenTXnThpD20CbbTl5JECWAJYAclOrOx7VARgjJFaqNJ0VCTZ6laLvwGaCTJa7rA0wFuGP8ntgH+cZQszaxj2b3qUtaNdAc6w4tDsrTcNIRblxUFttE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4074.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(26005)(38100700002)(53546011)(6506007)(122000001)(2906002)(55016003)(7696005)(33656002)(66574015)(186003)(83380400001)(9686003)(52536014)(66446008)(66476007)(54906003)(966005)(4326008)(64756008)(66556008)(66946007)(76116006)(71200400001)(8676002)(110136005)(316002)(38070700005)(41300700001)(5660300002)(86362001)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Lcf2erP5dIicbIQMSbtTVDHG3zBTAmFM1cFn7SbWI9OaXiWZ4XFIAI1pIO?=
 =?iso-8859-1?Q?ndCkD/8Ce7Wp+AnH9V74PJeN6a+4gCsDW2K9Qj1VpfVpix41re+Ywh4UTu?=
 =?iso-8859-1?Q?Sd7R7OJ7nBZ4o5n9gx0HNaO8P+AON2tnsvgO20cjKjWJMukOrXwtMHMsl3?=
 =?iso-8859-1?Q?08mU6QT4IXJVwIHznbNRtPAwttpSNxL2Q3ZL2r9f5D5y3v9TvAZhFk8/Kb?=
 =?iso-8859-1?Q?H8JkjKTz9e9TT8FmBlDTolEGaNtENOY062rZRbxV6UMUhYIud8DWUj/Gwe?=
 =?iso-8859-1?Q?zkcjGSlUzDQhnIVeQaAyaV8GxD43//zsN1AfHXDHX7vM7hMFH2BJIlDpFt?=
 =?iso-8859-1?Q?FD0LunU21cJkVgWwCakXOwm7VwQqvFMGG3/ztNydu76ShnoYZ9kpv7eV2D?=
 =?iso-8859-1?Q?mnyfAiWB5qdkb5NLoilz0O0CMWO3nXGQIiqWo13X8A1myDiGFA+QGg5PXt?=
 =?iso-8859-1?Q?C6wmBOuVD45xV6muT9E9lk3ZbStbPqhYoJsWgGZ0Z4EXKt4gOzyY1MxL0p?=
 =?iso-8859-1?Q?ymdWiFXKZkUseYz0TSxIQAT6rip3uERKYapC4KWahNGfTjwD0fxhvfYMc+?=
 =?iso-8859-1?Q?xYopsUyuP2PriiUbhdP61WKgJKEkND/4cQkNFSSy95EiDLZVGlsGy6mIYu?=
 =?iso-8859-1?Q?2xhDJ9gYKSL/kwwP5ImHLyR2Z9ygyLSRF53wMXguSwo+df05DkHxJdFEIs?=
 =?iso-8859-1?Q?xPnnrozcJKNtmLjMnUL2+olaCrHD+z3hRJXiazTqsAzTdq94ryWxZHOciV?=
 =?iso-8859-1?Q?e7V2OH+LGZEOq81Nl5VEn/Fwbuq/XipS0MTlMy2uKw3ZePT/DV2EFTR2NX?=
 =?iso-8859-1?Q?2w97nbywvnIWQEaPnpxq98NRmBP6wD3gpk0RgHMhZ/ox8MA1yPmVMXG/FS?=
 =?iso-8859-1?Q?J4f01vGGGd1iJ1GglFjqQaXJbXE9bOnVMn3nKPWtdmWjJZRMiIremJqqCB?=
 =?iso-8859-1?Q?r9ngnMzcKRziy6WHeHMlnbASHUzWLHDMRHkB5pU5R/0Lu2BU//ohS/A/M8?=
 =?iso-8859-1?Q?qCeQWqru7QRPT1UgBrmhvcEcCNPQtOYAZxay8morQOvfX0NhiUt03FJCCB?=
 =?iso-8859-1?Q?xzOQauv7tMYoXeeGVp4ttDV69Ye6UraM4UeJPE7sYF1IyvX+45t+6JjWLT?=
 =?iso-8859-1?Q?qPQJ3Swn7LEr+pUDSvYapHtxWF8TccMNNbZKtRIETYTAPpMhXyVABjRNYA?=
 =?iso-8859-1?Q?Xyc3cv7m4I3t7dxrr2BFZnuyT+7P1KwPMJRZlPhuQzHxkdYMKOmZ1affjY?=
 =?iso-8859-1?Q?RYSDFIS6FbjMEmlIyq2fcmpWhyh/oI1yEY1DoFJrCe2qwloNTWMxbZ5cLs?=
 =?iso-8859-1?Q?tcny+pf11YNqFtT5LgjYnUkom5u9WPScwzQNjS6AooploJ1Duastm9uwrb?=
 =?iso-8859-1?Q?4OE0YTSG1Y4yQ+51w7qQ+aKl8/tgm2iyDx4nf5s9QwYGT6fxbEkraDTPIP?=
 =?iso-8859-1?Q?hPRvbMTxvlrgZYTfuoIkRqyBMf+T2dCNKr9uMv3DUtK6pbH+84OunWe9q/?=
 =?iso-8859-1?Q?kIqiQuwzZftpty1FDoCncvn4qkWY21wQovMTnJEl6ffBm02DGj4+dSFXym?=
 =?iso-8859-1?Q?D+SqKauU8uI562BLm0jBSdM8UrXhp5gnMNjgQmPVz5ww6f35ltgI70Xnh7?=
 =?iso-8859-1?Q?vqQj/J2UmA3gxJvTxiWjn9q+gc6Fgw3WyV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd070d2-7171-4611-10be-08da8b48c810
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 12:03:13.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USLyceX+E9XTmsPfU8XX9weDarkoap7OrBXE9aIeHFGjhSQoeEaef//Ft+XQPnFdFx+YTNMh5zdBuid1hFTYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Wednesday, August 31, 2022 2:30 AM
> To: Guenter Roeck <linux@roeck-us.net>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; Wolfram Sang
> <wsa@kernel.org>; Michael Shych <michaelsh@nvidia.com>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; Linux Next Mailing List <lin=
ux-
> next@vger.kernel.org>
> Subject: linux-next: build failure after merge of the hwmon-staging tree
>=20
> Hi all,
>=20
> After merging the hwmon-staging tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/hwmon/emc2305.c:615:21: error: initialization of 'void (*)(struct
> i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_client =
*)' [-
> Werror=3Dincompatible-pointer-types]
>   615 |         .remove   =3D emc2305_remove,
>       |                     ^~~~~~~~~~~~~~
> drivers/hwmon/emc2305.c:615:21: note: (near initialization for
> 'emc2305_driver.remove')
>=20
> Caused by commit
>=20
>   324745b64626 ("hwmon: (emc2305) add support for EMC2301/2/3/5 RPM-
> based PWM Fan Speed Controller.")
>=20
> interacting with commit
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from the i2c tree.
>=20
> From Uwe:
>=20
> > There is an immutable tag that can be merged into your tree to resolve
> > the conflict before you send your changes to Linux at
> >
> >	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> >i2c/make_remove_callback_void-immutable
>=20
> I have applied the following merge fix patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 31 Aug 2022 09:22:50 +1000
> Subject: [PATCH] hwmon: (emc2305) fix up for "i2c: Make remove callback
> return void"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Michael Shych <michaelsh@nvidia.com>
> ---
>  drivers/hwmon/emc2305.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c index
> 9f6546ea3d69..df4c5816f661 100644
> --- a/drivers/hwmon/emc2305.c
> +++ b/drivers/hwmon/emc2305.c
> @@ -597,13 +597,12 @@ static int emc2305_probe(struct i2c_client *client,
> const struct i2c_device_id *
>  	return 0;
>  }
>=20
> -static int emc2305_remove(struct i2c_client *client)
> +static void emc2305_remove(struct i2c_client *client)
>  {
>  	struct device *dev =3D &client->dev;
>=20
>  	if (IS_REACHABLE(CONFIG_THERMAL))
>  		emc2305_unset_tz(dev);
> -	return 0;
>  }
>=20
>  static struct i2c_driver emc2305_driver =3D {
> --
> 2.35.1
>=20
> --
> Cheers,
> Stephen Rothwell
