Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83801502B78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354265AbiDOOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244459AbiDOOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:09:08 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED57D40935;
        Fri, 15 Apr 2022 07:06:39 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23FD7pc2014747;
        Fri, 15 Apr 2022 10:06:23 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3fb898f2s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 10:06:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAi5Cm2sIuk45acYa/EAWjA68ijqvPxhi84ulXxlBb5h1Ugfvt2TwC6EhmQ1XlHiuWIA7Kztpg74wlRzGDYQHyyEdlMTHyWXCJZ+NFl9+D5411Ppz6pXorcU1itM1dqvf6iyUi73bx4WLhQXDKRYMmABk2LJtkYcbCj60gJaC60yZFV6SC5UW0Zu3Yer0Hvq1twX2E9NkeisACSfpX9sSPsk4xvwy8SSEh9BTnnhS7oLIoG0kdnMZUnQisBIslsCeL85uWOzWFDbZEwaDqzeVEygg3WyO9byPAAc2TZ3rLSKJuVAGcI2Wv7L7rGy4BUlRjaL/02fZBAyZ75X7nbkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE5wUUJakdn3TX63uDxIzgviCTFYjXXeSiLhUIylOlk=;
 b=earXw4mfaGP8VxIejvtfEhFeNSXT//TWFxnQlZpQOU9DyXH6h9hUx0BZbV0+FxKnWkPJZ7Vt6TAqz4ww4rGBuetewyaqNusPMm5RLjK7eB1o2GLfT31Xa1Q3Qeu8Wh7X9P0MIJ2SzywSfrrip32AHb6hvgP3KfqBGALx/KthGYW3mVzSNnzuHBrj1HiLNfHHb3UE/Prwj7G1/FUMeoj1dKgItDTOG/iCLKMyVwE4MR5toCtvppxHtQQ9yLPJx6R1YAQRnmu4JZmit+CWd8FOYqdainagDdUS3Aai6yY7djiEE9N/wClIRHQBv79gS+wAqqqb+8/j6IfpDxLDhaL7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE5wUUJakdn3TX63uDxIzgviCTFYjXXeSiLhUIylOlk=;
 b=b9RI4fOgE/bLNuUw3xsdfyhjFLs5nfrvieqEr8gxJV5FnX+iB+HkgnBKLsbArslyeJKsSZX8jDqRTgNGJqQZgQOQy6KIF/QPsN5DH6oJlD3f3oel2JLH4VM/UXPASnQYMJVd4jKBd59ZvPECjnOxMIRV5RSfOxIqQsChA1Vtsw8=
Received: from BYAPR03MB4006.namprd03.prod.outlook.com (2603:10b6:a03:7f::10)
 by BY5PR03MB5080.namprd03.prod.outlook.com (2603:10b6:a03:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 14:06:20 +0000
Received: from BYAPR03MB4006.namprd03.prod.outlook.com
 ([fe80::28e5:4d3:8e19:d81e]) by BYAPR03MB4006.namprd03.prod.outlook.com
 ([fe80::28e5:4d3:8e19:d81e%7]) with mapi id 15.20.5144.029; Fri, 15 Apr 2022
 14:06:20 +0000
From:   "Ofluoglu, Atif" <Atif.Ofluoglu@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Ofluoglu, Atif" <Atif.Ofluoglu@analog.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCH] hwmon: (pmbus/max16601) Add MAX16602 support
Thread-Topic: [PATCH] hwmon: (pmbus/max16601) Add MAX16602 support
Thread-Index: AdhQ0TognjeSpzSPQjutLbQ6zJYKYw==
Date:   Fri, 15 Apr 2022 14:06:20 +0000
Message-ID: <BYAPR03MB40063CFD52C6D8831A8740AD8AEE9@BYAPR03MB4006.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c743700c-4c7a-4b48-7fea-08da1ee91e08
x-ms-traffictypediagnostic: BY5PR03MB5080:EE_
x-microsoft-antispam-prvs: <BY5PR03MB508005E4D9DE985D9DA27BC58AEE9@BY5PR03MB5080.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PzjKEV4AZRXME8aScMtIhBSJzYtjufffGI5hmlWO3oWmNzSWHMAtYOpmogknMGw6n5zC1WIbHRTyyk+UDLhu2KP6R5YoOS8Ybk9JjIV1JiO7opBTuaYZ2US3+ZGSA7iRt+V9Pk7WHtcgng0XYtWfB61gmya9mU92SFqzU6MaqGlsmDZwJFc2HXnxgK2481wnxQfXLyBQi/HE8DKrt81C5/efWozFKOdmN1Dqd4LJfFajKPdXtA+4eDvOBNbTQJqP0cI5zYNa4OyEYyJTfC4kIPt5X7Ktv/cMREgik05RLrpFsfQ8/cLaOrA5Fdu7lGxBozsN413+StlVOgy45BLwyLUQWezYJQXaX9IRQwr84S5SdmEUCiwPLf5O9GwjVVsUB9ZXKQrtn/RESWif6cRw895ENgOJeAHrpuYf05rodnF8gd73G5SORmKZyRxTiQIzyL8y+Gu7+uDNmDme7Q83XGNEGW0U4akwMtgNxVD0mEYowINw8304+kOBpt0/b7dQI89Fyuaz4l39Ohnh76KHwVklZsCz0RhWFZ7MJXc2gdPgxOSM5jEhSQyPqgJYqbCJxDdMaLgm/uerXbU3W2toCEJv6vgSSadn6apGs79PH7rEZBrsrAoHVFH7OP6P2ChlEAvSblZ5WDKlBYMK3rtqij/i5D/hQ8GZCccisRYyO6xIYUDmqriDuoAmhA0tNPP6aA6TBF6s8UOTL+3BuGICO9lPEwcoYj9Y1vQJ269OPDB+MuZL9laLjPjXBK5NnvR9bzhGIBtU8Pmmsp8HFHb0lNQVVDl6I7XDO4NLbwC0eq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4006.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(76116006)(316002)(6916009)(2906002)(86362001)(33656002)(83380400001)(53546011)(38070700005)(55016003)(71200400001)(38100700002)(52536014)(26005)(186003)(9686003)(122000001)(66476007)(64756008)(66556008)(508600001)(66946007)(66446008)(8676002)(4326008)(8936002)(966005)(5660300002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2qlD+Xs4tbyR4ERjVDZk+Aw/Okh5jpgyZqBWSx+atVGoXtaK6dSKK3yuVLK/?=
 =?us-ascii?Q?ZpM0YufJl4U8mnqEwUF7w1oLeL6oUQghoemuaua/dkGJAYSmxKH6E0/lnmof?=
 =?us-ascii?Q?fji2iB4EHAJehgd8P6WRwO+SGbI58VMdmXOjay/HwH6QUyzn0RsY5ygvxGoE?=
 =?us-ascii?Q?yn18AAFiYfV6Ml86yLLAOp34q06WwLLc2HkrnjtJFf7fOTYUiHmVR8v2C6UA?=
 =?us-ascii?Q?4IAiCydSL83EgoegMrfOP5TlMqFJBwBAPVR0qu4w/Rk/ToHBqcF1qxeP0wKu?=
 =?us-ascii?Q?qQV8Rz2wxWf6i5CmKynPHOlVbVbmv6CHsygoEwJv44POL9kkpRbnd8vpXSvP?=
 =?us-ascii?Q?M1KP2qQ/x8JWmN+72kP/oFFgqgxjrT0QwfYfiDengxthLp3I6f/Lnz9Dkqv+?=
 =?us-ascii?Q?p1p7KQLAl30djr2qkI9S81064fQvbrX68NC2mDRSHzlqe4r73h/3Yqw1jnBH?=
 =?us-ascii?Q?jwcmVxwimwXeKchO4ygyVn+u+II4P4Ju7Xj+ouHU73F54uqGm/l+DpBSuPzn?=
 =?us-ascii?Q?Izd3Gv3gKfjNE7oPheG4Fiy11qr1YPyxbAp3MRUDB6+41WrFhfr9pl647VWX?=
 =?us-ascii?Q?moBcI3Fr18ptT0UT/xcpdCpWadGgTPpGVi4ugZYKDysmmIjkYnTpcPCsdrdL?=
 =?us-ascii?Q?oslFd6IXrEtf0WtMTVgBCY3dbB+taZHcYv5XSv5HKBw3AHv7exjsrhbTn8NV?=
 =?us-ascii?Q?ArmhA9tw7bmXh36yp/RrxPFhqPbeI23a5UDAmWjCn+fNflu+zPrcpYhrf84/?=
 =?us-ascii?Q?2saeyIo52V0H/iLoYvXZZ3Qn08ECtMLeMjksPC69MMNVbTdBUxPldP4LHF+u?=
 =?us-ascii?Q?NfmCIce2QWfH3/f1FZzhKJddeKhyKyAAkkU9VyF/5RjlEeHD8uosjrZba9k5?=
 =?us-ascii?Q?ub1GGy0IKf9kS6hYNZGe/rIO+0hxR5vG/1NIV3tCbTgims2Iv4xEXtAhgWMo?=
 =?us-ascii?Q?wwUYvRBxNw7/p7yschh+9Oi4VMDflah6rftqlLyMdre+CyBs7PzIM11f6K9P?=
 =?us-ascii?Q?VmsTOUrIOE5E0lVCxljCC6cQ6K3kxJVK+nb26CHOIPFBGTfNWh5sxb9cNNYS?=
 =?us-ascii?Q?uUTM2qokPXNaIBHgszsKfgx+qa+7XTmFG2rw8OtF9htoP1PrHF8ooOf83MWS?=
 =?us-ascii?Q?RwqJsjLpbG3JRkn961vEJRMRbKG/7MYSBzt75hT7PFpT0ReuWwVZK1IkJp59?=
 =?us-ascii?Q?phxg5SIhs2io7Hppw7bPV8OPUOGzojJ16y1CMgc3WgmUPwOS8oAUv0P9CHNJ?=
 =?us-ascii?Q?CACpHcQUcoQI9a7OArkULN/SNuXZ5eWvsmtStSJYdA/gMVGXYyzayeBW6723?=
 =?us-ascii?Q?tD6X6ukjBTM0/VDuTTfMsnEQv8o4msskB5Rycvlvxt3Pp5cj3CHy27x73iCd?=
 =?us-ascii?Q?94zCbBJntlnaX+5WnbTvP1ehmiTyzj4XETUDhMaHpDjGvtPUDRYIuwuOVeCS?=
 =?us-ascii?Q?Lp4v91cxGTov6cN7xsbDmHJBxeh9SLQ2HT/R8LUV6cSN3MR7Tb0gfLos5J9V?=
 =?us-ascii?Q?U9oWNDGvk92BC4mrS5Pv+D+rcNihR2SgMHBkgnjIj63UAc18pLJoFqRNrhzG?=
 =?us-ascii?Q?kULnhQXHXh9BAMq7IGyBYLWjQ44lvwcq8O6RBmyDGanfT10i7XUnpj1yRRWE?=
 =?us-ascii?Q?oZ5JMjJojaMRAmX1RJpul9Y0Oo/ehWyr/EHzM0gOAMFdHdqacRYDwiTzRugV?=
 =?us-ascii?Q?Q9KBfCKQGjbZRo8yDlJEONO/ycbz9v0po2PM85LxyiI3+4gcNqm1PmNyBHL5?=
 =?us-ascii?Q?KYM5Ba/3QnuNZsSHLSHnjHOzLRc2QCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4006.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c743700c-4c7a-4b48-7fea-08da1ee91e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 14:06:20.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zA58jJgWF4LH1Gc3bdrGajKtGVr4HAO2PRMPdZwAJPS42Xpf2EW5WuPXGAoZQjVPhuxyVnVsEhvEhiplHbEcrYgG/aw/GarduzgEQp6DPfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5080
X-Proofpoint-ORIG-GUID: S3F8g_f1_zGjWyuBfgUnESUlUzRRphuc
X-Proofpoint-GUID: S3F8g_f1_zGjWyuBfgUnESUlUzRRphuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_05,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150084
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From e2a1f7d1a836188a9b284fc473af9118aa160ddb Mon Sep 17 00:00:00 2001
From: Atif Ofluoglu <mailto:atif.ofluoglu@maximintegrated.com>
Date: Fri, 15 Apr 2022 16:34:29 +0300
Subject: [PATCH] hwmon: (pmbus/max16601) Add MAX16602 support

Adding another MAX16602 chip support to MAX16601 driver
Tested with MAX16602 works as expected.

Signed-off-by: Atif Ofluoglu <mailto:atif.ofluoglu@maximintegrated.com>
---
 Documentation/hwmon/max16601.rst |  8 ++++++++
 drivers/hwmon/pmbus/Kconfig      |  4 ++--
 drivers/hwmon/pmbus/max16601.c   | 13 ++++++++-----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/max16601.rst b/Documentation/hwmon/max1660=
1.rst
index 92c0a7d7808c..6a4eef8efbaf 100644
--- a/Documentation/hwmon/max16601.rst
+++ b/Documentation/hwmon/max16601.rst
@@ -21,6 +21,14 @@ Supported chips:
=20
     Datasheet: Not published
=20
+  * Maxim MAX16602
+
+    Prefix: 'max16602'
+
+    Addresses scanned: -
+
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX16602.pdf
+
 Author: Guenter Roeck <mailto:linux@roeck-us.net>
=20
=20
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a2ea1d5a8765..53683d2d0fb2 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -228,10 +228,10 @@ config SENSORS_MAX16064
 	  be called max16064.
=20
 config SENSORS_MAX16601
-	tristate "Maxim MAX16508, MAX16601"
+	tristate "Maxim MAX16508, MAX16601, MAX16602"
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
-	  MAX16508 and MAX16601.
+	  MAX16508, MAX16601 and MAX16602.
=20
 	  This driver can also be built as a module. If so, the module will
 	  be called max16601.
diff --git a/drivers/hwmon/pmbus/max16601.c b/drivers/hwmon/pmbus/max16601.=
c
index 5a226a564776..b628405e6586 100644
--- a/drivers/hwmon/pmbus/max16601.c
+++ b/drivers/hwmon/pmbus/max16601.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Hardware monitoring driver for Maxim MAX16508 and MAX16601.
+ * Hardware monitoring driver for Maxim MAX16508, MAX16601 and MAX16602.
  *
  * Implementation notes:
  *
@@ -31,7 +31,7 @@
=20
 #include "pmbus.h"
=20
-enum chips { max16508, max16601 };
+enum chips { max16508, max16601, max16602 };
=20
 #define REG_DEFAULT_NUM_POP	0xc4
 #define REG_SETPT_DVID		0xd1
@@ -202,7 +202,7 @@ static int max16601_identify(struct i2c_client *client,
 	else
 		info->vrm_version[0] =3D vr12;
=20
-	if (data->id !=3D max16601)
+	if (data->id !=3D max16601 && data->id !=3D max16602)
 		return 0;
=20
 	reg =3D i2c_smbus_read_byte_data(client, REG_DEFAULT_NUM_POP);
@@ -264,6 +264,7 @@ static void max16601_remove(void *_data)
 static const struct i2c_device_id max16601_id[] =3D {
 	{"max16508", max16508},
 	{"max16601", max16601},
+	{"max16602", max16602},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, max16601_id);
@@ -280,13 +281,15 @@ static int max16601_get_id(struct i2c_client *client)
 		return -ENODEV;
=20
 	/*
-	 * PMBUS_IC_DEVICE_ID is expected to return "MAX16601y.xx"
-	 * or "MAX16500y.xx".
+	 * PMBUS_IC_DEVICE_ID is expected to return "MAX16601y.xx" or
+	 * MAX16602y.xx or "MAX16500y.xx".cdxxcccccccccc
 	 */
 	if (!strncmp(buf, "MAX16500", 8)) {
 		id =3D max16508;
 	} else if (!strncmp(buf, "MAX16601", 8)) {
 		id =3D max16601;
+	} else if (!strncmp(buf, "MAX16602", 8)) {
+		id =3D max16602;
 	} else {
 		buf[ret] =3D '\0';
 		dev_err(dev, "Unsupported chip '%s'\n", buf);
--=20
2.25.1

