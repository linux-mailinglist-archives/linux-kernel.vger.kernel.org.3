Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0201E4C58C6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 01:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiB0AWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 19:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiB0AWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 19:22:20 -0500
Received: from mx0a-00268f01.pphosted.com (mx0a-00268f01.pphosted.com [148.163.148.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F02BE226;
        Sat, 26 Feb 2022 16:21:44 -0800 (PST)
Received: from pps.filterd (m0105196.ppops.net [127.0.0.1])
        by mx0a-00268f01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21QMQCZ2029975;
        Sat, 26 Feb 2022 23:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equinix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pps202002;
 bh=AP8a0QprG0V1CEQps9XN2TyVh5PVbIzU8EH/+qLANwg=;
 b=DTqi5sMOSwFk3JxPRm+ECqTKerOdAib50v0EuNnM8YA6JwC5stl1AC3DecZuM3gA9ZIq
 M5QjVN2rAnQY4Umly+uFiBcdlZ78HldHBureiJygmIJcuBnS0NcVDneX0ETeQ8PAQ5zy
 lR9q6l9aGTI8JNMZUwq+220g93CpQUItiKWvmwUUJYZ07gPttjo/cm3czNoFUK3JYCbD
 su4w+OFpyB2uZId8EkbEllPR1Zx5qWRxTWtNg2rEW7InI4fw+8Rm6aPWQFIxgPtIt5bH
 GhmbpNOePyRmsxFfNCKBIhjtoi3Yo3Ce61k0uY73HPxGtXudo7cwTjdgPuG43YYuDi/F cQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0a-00268f01.pphosted.com (PPS) with ESMTPS id 3efbcda6dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Feb 2022 23:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yum5teUzE1uGDx9F0+YeIZG+fyoG1x0YNon22ARfpQLzZ+omxCXvPecvubGR4QJHRK4XVsy/+9serhFeBjmiH6IfBc8TON3QS0zdPkhknoW1XsIQTTrbbPwTqLYKv2Nu5kgLK20xtenP2g7TkZcSpE7lHQthSFQLg96cToOF90Chba1PmC0O8mN5XJMNoxyJ11H0RG8J9z2auGy86HhQB8dIDsvWJbzwHzi3oRUqaZqPUuWxhRplK5/2TDriOAW9odTe2JOwt4cp21/QYszkFZZ+CPfuzw41xxRpqQqCEjNcU7zdge2W05IKb7syGM4h4AhmmsP/tvSvsiMAO3zAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP8a0QprG0V1CEQps9XN2TyVh5PVbIzU8EH/+qLANwg=;
 b=Ba/3Nb8Hk9kVhIIDGeavGR17QQ6I0XvyQ9E4v1aQTxZ4HcbrUvgeZBbBYtG4SfdiBkHMj3O2wUZbC08U2L95tr7Q6P5ii1Uhi7gJYx2zWctGdDXlrO2Xb9el4l1QtIsvzjWfdA8ygaKN2jX6/SPSe6ioXnjiwoyCl4S8S1ZCBKY7I3Haug+naVQ3WZ0CbvVWNUc2P2RoOJ4gFBV841RoZAH8EKTMG/ntwucPZmgBVXn8NEupZZYAPPjBN+0C2nAX9pjSckAxKO7gw7jPwO7V2++8LH8j7HZ1WahERUgO+8j68MGMyxU5y8FOatkBgynaMTCDoTPjRH9IlcFObB4GoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=equinix.com; dmarc=pass action=none header.from=equinix.com;
 dkim=pass header.d=equinix.com; arc=none
Received: from DM8PR04MB8007.namprd04.prod.outlook.com (2603:10b6:5:314::20)
 by BN0PR04MB8125.namprd04.prod.outlook.com (2603:10b6:408:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Sat, 26 Feb
 2022 23:42:21 +0000
Received: from DM8PR04MB8007.namprd04.prod.outlook.com
 ([fe80::42f:1f1b:3a9b:b4a3]) by DM8PR04MB8007.namprd04.prod.outlook.com
 ([fe80::42f:1f1b:3a9b:b4a3%4]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 23:42:21 +0000
From:   Zev Weiss <zweiss@equinix.com>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v1 1/1] drivers/hwmon/pmbus: Add mutex to regulator ops
Thread-Topic: [PATCH v1 1/1] drivers/hwmon/pmbus: Add mutex to regulator ops
Thread-Index: AQHYK2po2MlpoGQR/EqdsknvVjVpMqymfigA
Date:   Sat, 26 Feb 2022 23:42:21 +0000
Message-ID: <20220226234220.GV5754@packtop>
References: <b991506bcbf665f7af185945f70bf9d5cf04637c.1645804976.git.sylv@sylv.io>
In-Reply-To: <b991506bcbf665f7af185945f70bf9d5cf04637c.1645804976.git.sylv@sylv.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a747326-05b1-4df2-612c-08d9f981a1ef
x-ms-traffictypediagnostic: BN0PR04MB8125:EE_
x-microsoft-antispam-prvs: <BN0PR04MB812592C6580B5BEA5781CBAEC33F9@BN0PR04MB8125.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yVhG9aBCkxzl8mcCdqglf+PrUOPRVgfw0x8rn6hFbGVB+lpqwvjjz5gX7oeh2NohzyuvUSR/rKeOVDY8Pl2xVEenCrC46ay6ZRx7URVkqOawK7BJMQUMSJ1YZrpU9WKqj9Fhyonp0ff+tuLUvBa1XaRHOqVm3rdEtfKJrDquSYfbRlhV/NS+FKV/IQkXCWvyXUNGdgDroLBxbPQ3dmYks9PwBW2/wSFhf+yyLWYFknyYQi+FiYlYI5n6UrGwsKJBh8kTidUIkE56If0r6cXQnWoAJVm+KGK1mqSbftkAPBk58UL1+QBnp4w5V9bEtLti+Fy4KxYuTa2gmgQAdhmI6ra8+/mlUc6AcBMZ2GgVrhlhPu9I4bZTMgR9K0HYn3kMvgtJdw6Oefp5JqthoB8rK5frwIvMbXS2RjnJL5WAID+TBcG60H1eljm7PVlMwAh3bmZKGMxcmczuiJOLQrEMMFol5Rp4xr6yYu6EH7jZ2rEER9gnTDer7OqlHNwmUMaGQeykFwa4mA1TY9vK3QTOPYB9SNZCzgXxawH+vFpk5yKBS0BN5dNyfCr9Ms/+HtomH+mEUt/bfoiU+mnLBodDf6S+kXSJdcyHLkVhLKLc3WJxV8Ojqbb5agMCAhdkmwzwJQasfZq9RkUMQVSQCG9ZWmTz2nVje1HVZPU39/sDXb6Mn93Ma8Y4F6/8zZMMITtV6ivyI/VRaRqfIWNCJJPcXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8007.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(316002)(8936002)(6916009)(54906003)(83380400001)(26005)(186003)(1076003)(66476007)(76116006)(91956017)(66946007)(38070700005)(66556008)(66446008)(86362001)(5660300002)(64756008)(8676002)(4326008)(38100700002)(33656002)(122000001)(2906002)(6512007)(6506007)(71200400001)(9686003)(6486002)(33716001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0IMUlmVkRhMxf7RMO4QptSginYI1NyELg5FKLmHN0xYk3Dd6AoYYxGwrOdB?=
 =?us-ascii?Q?KYWrgPHl5D52TUrxdT32ncuuuDsHo1Fz5vnYUltMMJ3Za/fCYhyJJ0yYsaZe?=
 =?us-ascii?Q?ksjhgmRTEEhhP/DC1cAplM3KVTIWM19p+WQGzoaT71jHs9rB/Jk0tMpl3m3p?=
 =?us-ascii?Q?DwhRHL/F9frxX/VUDGAugURnGLc0KY/t3q1G/fmo2LNOHJn8X+Ld1qcJxJo2?=
 =?us-ascii?Q?DGZ+FNgUVjZB1k497IAB5CfzJTpHr9RURx+3coXNNe+nKgzqTyZrDLIIv65G?=
 =?us-ascii?Q?DLgj9t8mVkheOQpRMAARrWLVjhCH+hzb+eByWwGi9uCs4eBr+ZoBnXIcyCtC?=
 =?us-ascii?Q?SFe9IFl65aUZRbQvKuCjlND1OnumdBZT3ppyth6HLRcvuQzY2idegmvmTl5S?=
 =?us-ascii?Q?WP0AOnfBY3mBzGW/Vib9MaWIMC6gcYRpvcYS6NWEzffgF5mv+dBSiaUaGZfC?=
 =?us-ascii?Q?2YsHIiYOuVvYN4yB+lbulgVw5N+C+AtFEjtFntiGHHqctna5e4ghC8HCi5aZ?=
 =?us-ascii?Q?NBEj2qR7+gOGQVRSQ5IT0kOO108csAM3YmQ+yJdw9EeSnuptbmPliS7O8sBY?=
 =?us-ascii?Q?xa8E9oh3IH+Rtg86aHsUQdkLvnTt5H2Y/KNfHqhNUITm5BAhnTYDjwNpqvoo?=
 =?us-ascii?Q?uKyQaOQC8bKLlEz6M4orCbllydi56jTxG0MTtahtRM6FapRXEWVuAesdmW/n?=
 =?us-ascii?Q?aEw1tFlajqAw7yRT/vBwAdaLu2erp31+uviknHcWR/oiqDVEoxZpJyxHfuZT?=
 =?us-ascii?Q?YJfd1uRsOMv1RvAFlfxAxgzreUCTiZgb/4EP6/y09wd0NUdF7+lVNHh8RhKJ?=
 =?us-ascii?Q?kyDxQ7s77eJWMOR9F09cuPXB6gOoE0GE49jy9Dw+igIOFiWIb2iTKGVQFIZC?=
 =?us-ascii?Q?ujlzlA+nk+hM87WGGqoerXsnAjc6Uy2B+BDO20TdWBKsUnoOBc490WEnBw/6?=
 =?us-ascii?Q?jrO95O4QDTso0sKv+PnFX4wUAoBOcXPQOMp+OvfEDQkJuKYxXhZbcN1p5zLR?=
 =?us-ascii?Q?Zv8cFcfwfvZYjjKHBRWSqFlQcu5TDDqB9500mp0HmwOARZOJt0eNNEuNY41X?=
 =?us-ascii?Q?NApLcz1Sj3Fl+pTNeBo8bAaZtJWhXJ/wu5k5VdfZG+1J+k1jABM1RYhz9U90?=
 =?us-ascii?Q?+oDSwtsrtzNu/lmyKZqOYVow2ELSKEPo5EDdOjSxzMy6pFdV3nKsU75C4gLx?=
 =?us-ascii?Q?BQ/gSoY5W1jKCm2ZgtHpOoRJx0mt+ceMOsy0/jrnUKrq6+Ly3jj6EufXTUhr?=
 =?us-ascii?Q?7btgz7AbDNuk3lqpdfoeSUv8oj9+ffGxgnOEpTOFj21L41Sl25Iy/XdHQzQd?=
 =?us-ascii?Q?G5IW+xF6KaRcZ0fgkI03wOYEWwuM/6ElN6jO18Na9qVlfRfRMcQpPi7FRCAO?=
 =?us-ascii?Q?ntYqaAcQ4tyggogj2lNEZowk2P81JbxIHiuBUBAv0EyPJSdas6up8zvI/GQh?=
 =?us-ascii?Q?/vuh8zOJEeXRezPG7/5uerNEztag1tKaz+t2rBP2bl25wiEB3OatW8RHyeVQ?=
 =?us-ascii?Q?YDPtAxD/le6yUJh9RhxzUjyoAQjnN1XWqyuymdA8mlTQHrBXzm0RgfOc2pAs?=
 =?us-ascii?Q?5SDgoalfAxwNJf3BBP4bf2cxUOy24jZH8U0Q8u0ZFopLs+MH0nTRM5XTmhXN?=
 =?us-ascii?Q?6Dm4C/YdV/Le1KkahVUYzlM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73E3868561C98B439A6A5C826AEC7EDA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: equinix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a747326-05b1-4df2-612c-08d9f981a1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 23:42:21.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72adb271-2fc7-4afe-a5ee-9de6a59f6bfb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEcCjda71kN3dF5yvl35/dYc8bDgjdCaVHDFqJXt5Z4l12m+8q4gJsb01ONDb4/0+pU+ZZLotCUr5UGlum3CMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8125
X-Proofpoint-GUID: SbVzkCh3vM-l7E3VmgD3qRBYYgRpwVIk
X-Proofpoint-ORIG-GUID: SbVzkCh3vM-l7E3VmgD3qRBYYgRpwVIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-26_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=733
 priorityscore=1501 clxscore=1011 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202260169
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:06:09AM PST, Marcello Sylvester Bauer wrote:
>From: Patrick Rudolph <patrick.rudolph@9elements.com>
>
>On PMBUS devices with multiple pages, the regulator ops need to be
>protected with the update mutex. This prevents accidentally changing
>the page in a separate thread while operating on the PMBUS_OPERATION
>register.
>
>Tested on Infineon xdpe11280 while a separate thread polls for sensor
>data.
>
>Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>---
> drivers/hwmon/pmbus/pmbus_core.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_=
core.c
>index 776ee2237be2..f79930162256 100644
>--- a/drivers/hwmon/pmbus/pmbus_core.c
>+++ b/drivers/hwmon/pmbus/pmbus_core.c
>@@ -2386,10 +2386,14 @@ static int pmbus_regulator_is_enabled(struct regul=
ator_dev *rdev)
> {
> 	struct device *dev =3D rdev_get_dev(rdev);
> 	struct i2c_client *client =3D to_i2c_client(dev->parent);
>+	struct pmbus_data *data =3D i2c_get_clientdata(client);
> 	u8 page =3D rdev_get_id(rdev);
> 	int ret;
>
>+	mutex_lock(&data->update_lock);
> 	ret =3D pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>+	mutex_unlock(&data->update_lock);
>+
> 	if (ret < 0)
> 		return ret;
>
>@@ -2400,11 +2404,17 @@ static int _pmbus_regulator_on_off(struct regulato=
r_dev *rdev, bool enable)
> {
> 	struct device *dev =3D rdev_get_dev(rdev);
> 	struct i2c_client *client =3D to_i2c_client(dev->parent);
>+	struct pmbus_data *data =3D i2c_get_clientdata(client);
> 	u8 page =3D rdev_get_id(rdev);
>+	int ret;
>
>-	return pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>-				      PB_OPERATION_CONTROL_ON,
>-				      enable ? PB_OPERATION_CONTROL_ON : 0);
>+	mutex_lock(&data->update_lock);
>+	ret =3D pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>+				     PB_OPERATION_CONTROL_ON,
>+				     enable ? PB_OPERATION_CONTROL_ON : 0);
>+	mutex_unlock(&data->update_lock);
>+
>+	return ret;
> }
>
> static int pmbus_regulator_enable(struct regulator_dev *rdev)
>--=20
>2.35.1
>
>

Looks like this doesn't cover pmbus_regulator_get_error_flags(), which
was added recently -- perhaps rebase onto hwmon-next?


Zev
