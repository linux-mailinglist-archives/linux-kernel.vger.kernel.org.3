Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D02598156
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbiHRKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbiHRKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:11:31 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A11C9F756;
        Thu, 18 Aug 2022 03:11:30 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I8kAvn010145;
        Thu, 18 Aug 2022 06:11:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j0tdatdpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 06:11:20 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27I9qBmr012298;
        Thu, 18 Aug 2022 06:11:20 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j0tdatdp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 06:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0livc8bYMuUxeh34uNsj4Ggjr1iE+WpJY6VWm04MrTIYWgXlVs8lHAO4VIRLaxcj9fUVXAsu/WI03MKaWq4oobfAAoC4aLtvg1QzDCgzKRIfRZUoEFyMRi9+e+QlkoXMoK5hrTCSyarbDr3yDg14hQtP2r8pOZ3Gx48yPzvZOqK57XMryTlJCp/sRWd6yOik96cahu0pTIHYn6uJ0hwhWci0JjFOfLWXDv8LxqmMBeMF0VjrRGMDXd5NbAkI8u11T7n3NwhxTi8GYNOK4N686avhi86lQmaot+k1H9pBtOq0md3ZXKWq9Aljya+w+UKVjws5pi52d0aop2XZ/iKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2KdBe3XAf21d/hZqSg75jMkhE+KR9NX3ceya9F1UYA=;
 b=Yb7r5ZRQojFNYnc7EOZwSfrvXCE5WEdC9HzgyaJVFuULvXTZhpfN+g8IIMlCjyvcI5158qBnPBhKWuIw8N8X5SYK1yEwpKnmfODCzYxSCAT1FIw7R6+IiTiugH66DvmRgognZqgS+09FtqAHv5JV73FVjscyTsZbPDjJi05DR9Td5kxZXGvK7Rmt3+2+Z72Pszsui4b3HQWMb7DLXAAnt0VaQyndKakDA83fUmNWkxFfZiLdhxP6VvBjFzu4pKVS+zgi/mKXJjUbqUp1U4IQLqhiKcbLD5n5816cW5kYG3X2YXdr/5hcmNP94x2ek2H3LJgqNUektHXasFU5Lbw8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2KdBe3XAf21d/hZqSg75jMkhE+KR9NX3ceya9F1UYA=;
 b=XEfXDmQshxWryQnBpelPIPVxxSpqtho3QSxNl/QEy/zBQtnXAk07LhyNP6QxWRmoeM82DlVIcGlk9c2njk+Ua1AyIrjkOpVNPGvcVu2BIlax4uciS+MsEeiUyJHgd1AQ1psnehgWDzw7K68DtnRHS+jOcfJF5zb2xzfD6Lx7f5k=
Received: from SN6PR03MB3421.namprd03.prod.outlook.com (2603:10b6:805:47::31)
 by SJ0PR03MB5696.namprd03.prod.outlook.com (2603:10b6:a03:2d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 10:11:17 +0000
Received: from SN6PR03MB3421.namprd03.prod.outlook.com
 ([fe80::a5b5:a6d9:80dc:29c8]) by SN6PR03MB3421.namprd03.prod.outlook.com
 ([fe80::a5b5:a6d9:80dc:29c8%7]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 10:11:17 +0000
From:   "Mois, George" <George.Mois@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lucas.p.stankus@gmail.com" <lucas.p.stankus@gmail.com>
Subject: RE: [PATCH 2/2] drivers: iio: accel adxl312 and adxl314 support
Thread-Topic: [PATCH 2/2] drivers: iio: accel adxl312 and adxl314 support
Thread-Index: AQHYsVsM+qkXPLs3C0KNYBDAdeepra2xkQUAgALMWJA=
Date:   Thu, 18 Aug 2022 10:11:16 +0000
Message-ID: <SN6PR03MB3421435300309BCDD2D701EA946D9@SN6PR03MB3421.namprd03.prod.outlook.com>
References: <20220816102828.182345-1-george.mois@analog.com>
        <20220816102828.182345-3-george.mois@analog.com>
 <20220816150958.00002431@huawei.com>
In-Reply-To: <20220816150958.00002431@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7c78833-0542-48a6-2d61-08da8101fd39
x-ms-traffictypediagnostic: SJ0PR03MB5696:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88JCehWMx+v0vmOWsj6/eGFv99tqRh3M8Eaky72A2IiXB0uBXEjhLQPFn9n/p511SucWUEPcrACcIKC+qvochBX1ikYBFe/+sLVGuv1FIbGZNBKBv6OTco9uCF/9WZrw956neXkb3Sd2ePuBApsm9ddu894/mYw4l7mrDLPYuROMGnUtmeznDwxwKwYAHFyUpBnnBROabRweoezb+NWVZJn17F1o4ueM0EJDr4jy7VORtBtqero+fmfQQidA5eDsAtYa7TKYCVY1GN9GwuKmruh74PEPLy7Nf/UZNkGQPnpikHqvXVxGaltVReoe4rPnFxAeIrIZHIYA/fJDY8ps8Iqka8y3hoSljDb6GNFRIZaAPbmo0ATV9wNuimmP4P7wxi3w0x96NtPQlvYDtdKG/L/SQgcC4RAr5Ufi9cRJV11FFK3d1RCilBStL27mlRd1aLYmo4mWQsPgF23wgvhh2k3CHRxNznI6vdssnLVZ0GbbTz65abBA54FYnKG+YmDlbJ/uH2KO9vt8+x31QyHjrnjPIwVE5HfbX+7KQCpWWsX2MD29WgvOfHKfcym41++jtJ1znTCQaVDUdlaHr4c8j0SGnB58dR0rAPEhxYc+68IAYRA5B/WmErgllmdqF9zb1LCr3ae9+O/t6PRle8nO7dx8o1ZMO0uhKp0L93QLgeBvQ/oqCcf9h+5PQH6MiBYBQK1iG/NWxwoICzMu+sNJ3J998Aw4k9aIlb/WitItyVYptKN+vAbvaVX/CPcLaIprNjKDUIZE6hFLb/qqBuJGn0db3aDHF0qROwtWkpFBT6a8PrJtiqbLLpvGX7p+SCLeWxhAC/IJ+3B6K0RinXp9TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB3421.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(54906003)(6916009)(86362001)(316002)(66476007)(66446008)(64756008)(8676002)(4326008)(30864003)(66946007)(66556008)(76116006)(478600001)(966005)(5660300002)(8936002)(52536014)(38070700005)(2906002)(38100700002)(122000001)(41300700001)(83380400001)(71200400001)(7696005)(6506007)(55016003)(186003)(33656002)(9686003)(26005)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fr7JB1xTc1C3MyWAO+lDeHk+qlc3uNMhVHu2YxhlDhoy0hWaLdTyGrF0iXd0?=
 =?us-ascii?Q?Emru7wUkUdRALeYLegoyBmS6f7agBrfU/xkk9RCs8YjSaZX/7LCD9xKkGdxr?=
 =?us-ascii?Q?XLrusaGRAitxMostk2L528/KJgoPwFrUNcWrGB53sT2KEppCFwJbX6vhplyR?=
 =?us-ascii?Q?+O7OSDYSkQapTV65KRIg1cVP+LzB3Vc4JU7ad8tdZz1vLNKjiV5njwG+2sQh?=
 =?us-ascii?Q?13FyArPLtrIaF6HOJXtyJ+DhTjq4LJqhwdIL/tam72txqoiTSqO2quYwEArD?=
 =?us-ascii?Q?hHY9WqXF/J37j452+piAD7NhznjHIJU40k8Uhps8t7RD3cxfn7HpHSYqzXPY?=
 =?us-ascii?Q?/87igw5E44hmpXRKqcUnCyBDfBJtOyvPL7WrFjUjtQXWEa1R6pdpHyfoxL1a?=
 =?us-ascii?Q?2N4Vty0z/M1FnyLqcUJfepg6FfVepN8gKrux6MZDCnEAX7Mq1hJmtlfh/IEz?=
 =?us-ascii?Q?WA20YZDC4EAivZWh/7mBkMejyk23i28nyGiusgx9V4zKbXiPezxIxz1f3fpj?=
 =?us-ascii?Q?zAqFmoDkwKNKnHXTsa1da386p7f4+clZJzS6hMJkGtOxqqTFdguHdWkccj64?=
 =?us-ascii?Q?TGgORlazdxf0kWepRElbQbXVaG5JoHe244k7tckWPNxA0Dd8B+BU1mXIHtU+?=
 =?us-ascii?Q?fCmvmgtDtyrgB+gvnlroTBSts5wo/6YKWQN8unIjjogEcg6Y3OyRlYUGPN/C?=
 =?us-ascii?Q?7vrnTXRS6bIpJ8vEGi2Zyke/PCt/eOsDSU85vb02NislwUWz/mt1x1sPg9sm?=
 =?us-ascii?Q?L0ieCmoE2I7Fl6Ol/uNVqa5KV5QFKdHNq1qhtl/4ww1YD5aU9+UM6MBaYyKp?=
 =?us-ascii?Q?dIV6tB/XaBz2M/2h4kvjInirgbcj79wL3WjA0X2gvryNju7GSdc9fNfVRnt8?=
 =?us-ascii?Q?yuuB9ftVRWLw2BMMEpTKp2W7wPFZ+6gPZWdntLus43nMZv6liafTVdRZPChE?=
 =?us-ascii?Q?hOWXh0IrHr/ONDlZzsfbLMQtMAZC/b1rCD0SLqnTKO+a93yTwA2CRvkz4pPd?=
 =?us-ascii?Q?1KZ2vzzZMC7QMycru5RbPF5464xVHuGkX/JLJm0GkjpWklMZ2JeZaQnr84jH?=
 =?us-ascii?Q?hXiWFFbSx54A8DwDFnDtsiviOVN+h+LbrlSkfnLFyNDfwpD/tLbYcXI9R3Vy?=
 =?us-ascii?Q?iC4wPnOAkTuBpZDrUFvsis0Oscwmg5the5YMV7AjR68IL1MZLYAal9s2820T?=
 =?us-ascii?Q?R9tS3NHManxoT8VY8tw6/WGM/DZ4PqR5WYG5PreyAGOpnrMVeQYXJjQxc1qz?=
 =?us-ascii?Q?mso6IP1HYz7WigLokZfRFs5+tZKq5bZ84YHW5qDZtpduewshgD4G3dOJVKS7?=
 =?us-ascii?Q?deEqRIGpK/c+SYOCrJc192C4gS4qj4AVIHrLWkiPF2R4mvDuZQJLNGuM+vEC?=
 =?us-ascii?Q?eDHtNp4xyM6C0vbseAGrEZGUWm6MDttz3jwfQ0NJKlI9uUcVUKcfVhE0mwd6?=
 =?us-ascii?Q?vAUWCtCX0XMNpybTw7qU4G+7tNB9VUz5rXsOafCvKx2uxtEMc6SOcPX0QzGg?=
 =?us-ascii?Q?Ww9NlHTxfNwkark978aJchbT/FluTRm/LyQrsO0yGgH+UW1iSj2nBbc0WJLG?=
 =?us-ascii?Q?ZKQF1ojVEJhrccXsUP2q8H7O3cL2sOxeew753GS+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3421.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c78833-0542-48a6-2d61-08da8101fd39
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 10:11:16.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsrgGe1Xqa57WT1gOjVIjDgVZ4/PdVPitF2eOsf+204rMI/7F1oep/v510mADQmqhu+CLUVJKZocHX8qAZItwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5696
X-Proofpoint-GUID: 4e6cBooD0ILhi75skuLGZUXfBCNob3QF
X-Proofpoint-ORIG-GUID: OdblU2cZF_FzgnZsQmk4ekR06HsXKJUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208180034
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for your review!

Regards,
George
>=20
> On Tue, 16 Aug 2022 13:28:28 +0300
> George Mois <george.mois@analog.com> wrote:
>=20
> > ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
> > with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
> > respectively.
> >
> > Implement support for ADXL312 and ADXL314 by extending the ADXL313
> > driver.
> >
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/ADXL312.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/ADXL314.pdf
> >
> > Signed-off-by: George Mois <george.mois@analog.com>
>=20
> Hi George,
>=20
> Various comments inline.
>=20
> Thanks,
>=20
> Jonathan
> > ---
> >  drivers/iio/accel/adxl313.h      |  15 ++-
> >  drivers/iio/accel/adxl313_core.c | 164 +++++++++++++++++++++++--------
> >  drivers/iio/accel/adxl313_spi.c  |  40 +++++++-
> >  3 files changed, 173 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> > index 4415f2fc07e1..7428b1f7768f 100644
> > --- a/drivers/iio/accel/adxl313.h
> > +++ b/drivers/iio/accel/adxl313.h
> > @@ -26,6 +26,7 @@
> >  #define ADXL313_REG_FIFO_STATUS		0x39
> >
> >  #define ADXL313_DEVID0			0xAD
> > +#define ADXL313_DEVID0_ADXL312_314	0xE5
> >  #define ADXL313_DEVID1			0x1D
> >  #define ADXL313_PARTID			0xCB
> >  #define ADXL313_SOFT_RESET		0x52
> > @@ -37,18 +38,28 @@
> >  #define ADXL313_MEASUREMENT_MODE	BIT(3)
> >
> >  #define ADXL313_RANGE_MSK		GENMASK(1, 0)
> > -#define ADXL313_RANGE_4G		3
> > +#define ADXL313_RANGE_MAX		3
> >
> >  #define ADXL313_FULL_RES		BIT(3)
> >  #define ADXL313_SPI_3WIRE		BIT(6)
> >  #define ADXL313_I2C_DISABLE		BIT(6)
> >
> > +extern const struct regmap_access_table adxl312_readable_regs_table;
> >  extern const struct regmap_access_table adxl313_readable_regs_table;
> > +extern const struct regmap_access_table adxl314_readable_regs_table;
> >
> > +extern const struct regmap_access_table adxl312_writable_regs_table;
> >  extern const struct regmap_access_table adxl313_writable_regs_table;
> > +extern const struct regmap_access_table adxl314_writable_regs_table;
> > +
> > +enum adxl313_device_type {
> > +	ADXL312,
> > +	ADXL313,
> > +	ADXL314,
> > +};
> >
> >  int adxl313_core_probe(struct device *dev,
> >  		       struct regmap *regmap,
> > -		       const char *name,
> > +		       const struct spi_device_id *id,
> >  		       int (*setup)(struct device *, struct regmap *));
> >  #endif /* _ADXL313_H_ */
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl3=
13_core.c
> > index afeef779e1d0..eea7d235950e 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -11,9 +11,17 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
>=20
> Not in the core driver. This needs to be kept unware of the
> buses that migh be used.
>=20
> >
> >  #include "adxl313.h"
> >
> > +static const struct regmap_range adxl312_readable_reg_range[] =3D {
> > +	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
> > +	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > +	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> > +	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
> > +};
> > +
> >  static const struct regmap_range adxl313_readable_reg_range[] =3D {
> >  	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_XID),
> >  	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> > @@ -22,12 +30,32 @@ static const struct regmap_range adxl313_readable_r=
eg_range[] =3D {
> >  	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
> >  };
> >
> > +const struct regmap_access_table adxl312_readable_regs_table =3D {
> > +	.yes_ranges =3D adxl312_readable_reg_range,
> > +	.n_yes_ranges =3D ARRAY_SIZE(adxl312_readable_reg_range),
> > +};
> > +EXPORT_SYMBOL_NS_GPL(adxl312_readable_regs_table, IIO_ADXL312);
> > +
> >  const struct regmap_access_table adxl313_readable_regs_table =3D {
> >  	.yes_ranges =3D adxl313_readable_reg_range,
> >  	.n_yes_ranges =3D ARRAY_SIZE(adxl313_readable_reg_range),
> >  };
> >  EXPORT_SYMBOL_NS_GPL(adxl313_readable_regs_table, IIO_ADXL313);
> >
> > +const struct regmap_access_table adxl314_readable_regs_table =3D {
> > +	.yes_ranges =3D adxl312_readable_reg_range,
> > +	.n_yes_ranges =3D ARRAY_SIZE(adxl312_readable_reg_range),
> > +};
> > +EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL314);
> > +
> > +static const struct regmap_range adxl312_writable_reg_range[] =3D {
> > +	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > +	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> > +	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_INT_MAP),
> > +	regmap_reg_range(ADXL313_REG_DATA_FORMAT, ADXL313_REG_DATA_FORMAT),
> > +	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
> > +};
> > +
> >  static const struct regmap_range adxl313_writable_reg_range[] =3D {
> >  	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> >  	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > @@ -37,16 +65,30 @@ static const struct regmap_range adxl313_writable_r=
eg_range[] =3D {
> >  	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
> >  };
> >
> > +const struct regmap_access_table adxl312_writable_regs_table =3D {
> > +	.yes_ranges =3D adxl312_writable_reg_range,
> > +	.n_yes_ranges =3D ARRAY_SIZE(adxl312_writable_reg_range),
> > +};
> > +EXPORT_SYMBOL_NS_GPL(adxl312_writable_regs_table, IIO_ADXL312);
> > +
> >  const struct regmap_access_table adxl313_writable_regs_table =3D {
> >  	.yes_ranges =3D adxl313_writable_reg_range,
> >  	.n_yes_ranges =3D ARRAY_SIZE(adxl313_writable_reg_range),
> >  };
> >  EXPORT_SYMBOL_NS_GPL(adxl313_writable_regs_table, IIO_ADXL313);
> >
> > +const struct regmap_access_table adxl314_writable_regs_table =3D {
> > +	.yes_ranges =3D adxl312_writable_reg_range,
> > +	.n_yes_ranges =3D ARRAY_SIZE(adxl312_writable_reg_range),
> > +};
> > +EXPORT_SYMBOL_NS_GPL(adxl314_writable_regs_table, IIO_ADXL314);
> > +
> >  struct adxl313_data {
> >  	struct regmap	*regmap;
> > +	const struct spi_device_id *id;
> > +	int scale_factor;
> >  	struct mutex	lock; /* lock to protect transf_buf */
> > -	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
> > +	__le16		transf_buf ____cacheline_aligned;
> Check your patch for accidental reverts of other changes like this...
>=20
> >  };
> >
> >  static const int adxl313_odr_freqs[][2] =3D {
> > @@ -156,12 +198,10 @@ static int adxl313_read_raw(struct iio_dev *indio=
_dev,
> >  		*val =3D sign_extend32(ret, chan->scan_type.realbits - 1);
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_SCALE:
> > -		/*
> > -		 * Scale for any g range is given in datasheet as
> > -		 * 1024 LSB/g =3D 0.0009765625 * 9.80665 =3D 0.009576806640625 m/s^2
> > -		 */
> >  		*val =3D 0;
> > -		*val2 =3D 9576806;
> > +
> > +		*val2 =3D data->scale_factor;
> I'd move this into a structure containing all the chip type specific data=
.
> Hence this would be
> data->chip.scale_factor.
>=20
> > +
> >  		return IIO_VAL_INT_PLUS_NANO;
> >  	case IIO_CHAN_INFO_CALIBBIAS:
> >  		ret =3D regmap_read(data->regmap,
> > @@ -170,7 +210,7 @@ static int adxl313_read_raw(struct iio_dev *indio_d=
ev,
> >  			return ret;
> >
> >  		/*
> > -		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> > +		 * 8-bit resolution at minimum range, that is 4x accel data scale
> >  		 * factor at full resolution
> >  		 */
> >  		*val =3D sign_extend32(regval, 7) * 4;
> > @@ -198,7 +238,7 @@ static int adxl313_write_raw(struct iio_dev *indio_=
dev,
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_CALIBBIAS:
> >  		/*
> > -		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> > +		 * 8-bit resolution at minimum range, that is 4x accel data scale
> >  		 * factor at full resolution
> >  		 */
> >  		if (clamp_val(val, -128 * 4, 127 * 4) !=3D val)
> > @@ -223,14 +263,17 @@ static const struct iio_info adxl313_info =3D {
> >  static int adxl313_setup(struct device *dev, struct adxl313_data *data=
,
> >  			 int (*setup)(struct device *, struct regmap *))
> >  {
> > +	enum adxl313_device_type dev_type =3D data->id->driver_data;
> >  	unsigned int regval;
> >  	int ret;
> >
> > -	/* Ensures the device is in a consistent state after start up */
> > -	ret =3D regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> > -			   ADXL313_SOFT_RESET);
> > -	if (ret)
> > -		return ret;
> > +	/* If ADXL313, ensures the device is in a consistent state after star=
t up */
> > +	if (dev_type =3D=3D ADXL313) {
>=20
> Add a flag to the chip_info structure suggested below for 'soft_reset' an=
d
> base this decision on that.  The aim is to encode all the variations in c=
hips
> in one place so adding future chips is isolated there.
>=20
> > +		ret =3D regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> > +				   ADXL313_SOFT_RESET);
> > +		if (ret)
> > +			return ret;
> > +	}
> >
> >  	if (setup) {
> >  		ret =3D setup(dev, data->regmap);
> > @@ -242,41 +285,54 @@ static int adxl313_setup(struct device *dev, stru=
ct adxl313_data *data,
> >  	if (ret)
> >  		return ret;
> >
> > -	if (regval !=3D ADXL313_DEVID0) {
> > +	if (dev_type =3D=3D ADXL313 && regval !=3D ADXL313_DEVID0) {
>=20
> Obviously this predates your changes...
> Don't fail in this case.  Warn only.  We may be dealing with a newer comp=
atible
> device that falls back to an the ADXL313 compatible in dt. It's fine to e=
xpress
> we don't know what it is - particularly if ID matches something else, but
> not to fail as a result.
>=20

Is this change mandatory? I am asking this because we have setups that requ=
ire
the driver to fail if not the correct device is plugged in or if there is n=
o device
attached to the system.=20

Returning only warnings will cause the device  to probe, but abnormal value=
s
to be produced. Moreover, most of the iio drivers perform a chip ID check a=
nd
return an error code if the physical device is not found.

Wouldn't it be better to treat the situation of new compatible devices when
they appear?

> >  		dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
> >  		return -ENODEV;
> >  	}
> >
> > -	ret =3D regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
> > -	if (ret)
> > -		return ret;
> > +	/* If ADXL313, check DEVID1 and PARTID */
> > +	if (regval =3D=3D ADXL313_DEVID0) {
> > +		ret =3D regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
> > +		if (ret)
> > +			return ret;
> >
> > -	if (regval !=3D ADXL313_DEVID1) {
> As above, should not fail - but just give a warning message (or dev_info =
perhaps).
>=20
> > -		dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
> > -		return -ENODEV;
> > -	}
> > +		if (regval !=3D ADXL313_DEVID1) {
> > +			dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
> > +			return -ENODEV;
> > +		}
> >
> > -	ret =3D regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
> > -	if (ret)
> > -		return ret;
> > +		ret =3D regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
> > +		if (ret)
> > +			return ret;
> >
> > -	if (regval !=3D ADXL313_PARTID) {
> > -		dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
> > +		if (regval !=3D ADXL313_PARTID) {
> > +			dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	/* If ADXL312 or ADXL314 device, check DEVID0 */
> > +	if (dev_type !=3D ADXL313 && regval !=3D ADXL313_DEVID0_ADXL312_314) =
{
> > +		dev_err(dev, "Invalid manufacturer ID: %#02x\n", regval);
> >  		return -ENODEV;
> >  	}
> >
> > -	/* Sets the range to +/- 4g */
> > -	ret =3D regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> > -				 ADXL313_RANGE_MSK,
> > -				 FIELD_PREP(ADXL313_RANGE_MSK, ADXL313_RANGE_4G));
> > -	if (ret)
> > -		return ret;
> > +	dev_info(dev, "%s detected.\n", data->id->name);
>=20
> Noise in the log. Drop this. It's easy to find out the name from sysfs.
>=20
> >
> > -	/* Enables full resolution */
> > -	ret =3D regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> > -				 ADXL313_FULL_RES, ADXL313_FULL_RES);
> > -	if (ret)
> > -		return ret;
> > +	/* Sets the range to maximum, full resolution, for ADXL312 and ADXL31=
3 */
> > +	if (dev_type =3D=3D ADXL312 || dev_type =3D=3D ADXL313) {
> I'm reading this backwards btw.  As below, this sort of thing should depe=
nd on
> contents of a chip_info structure.
> In this case perhaps a flag called 'set max range').
>=20
> > +		ret =3D regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> > +					 ADXL313_RANGE_MSK,
> > +					 FIELD_PREP(ADXL313_RANGE_MSK, 0x02));
>=20
> 0x02 looks like a magic numbers, you should ideally provide a define.
>=20
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Enables full resolution */
> > +		ret =3D regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> > +					 ADXL313_FULL_RES, 0);
> > +		if (ret)
> > +			return ret;
> > +	}
> >
> >  	/* Enables measurement mode */
> >  	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
> > @@ -296,7 +352,7 @@ static int adxl313_setup(struct device *dev, struct=
 adxl313_data *data,
> >   */
> >  int adxl313_core_probe(struct device *dev,
> >  		       struct regmap *regmap,
> > -		       const char *name,
> > +		       const struct spi_device_id *id,
>=20
> A core probe function shouldn't be taking an SPI specific structure.
> Fine to pass the id enum entry.  That can then index a chip_info structur=
e
> that includes the part name - we don't want to pass that through this int=
erface
> as well.
>=20
> >  		       int (*setup)(struct device *, struct regmap *))
> >  {
> >  	struct adxl313_data *data;
> > @@ -309,9 +365,35 @@ int adxl313_core_probe(struct device *dev,
> >
> >  	data =3D iio_priv(indio_dev);
> >  	data->regmap =3D regmap;
> > +	data->id =3D id;
> > +
> > +	if (id->driver_data =3D=3D ADXL312)
>=20
> Whenever you hit a case like this, it almost always means you should be s=
electing
> from an array of chip_info structures. One per type of chip.
> If it is possible to convert code to data that is almost always a good id=
ea.
>=20
> > +		/*
> > +		 * ADXL312
> > +		 * Scale for any g range (full range) is given in datasheet as
> > +		 * 345 LSB/g =3D 0.0028985507 * 9.80665 =3D 0.028425072222155 m/s^2
> > +		 */
> > +		data->scale_factor =3D 28425072;
> > +
> > +	if (id->driver_data =3D=3D ADXL313)
> > +		/*
> > +		 * * ADXL313
> > +		 * Scale for any g range is given in datasheet as
> > +		 * 1024 LSB/g =3D 0.0009765625 * 9.80665 =3D 0.009576806640625 m/s^2
> > +		 */
> > +		data->scale_factor =3D 9576806;
> > +
> > +	if (id->driver_data =3D=3D ADXL314)
> > +		/*
> > +		 * ADXL314
> > +		 * At +/-200g with 13-bit resolution, scale factor is given in datas=
heet as
> > +		 * 48.83 mg/LSB =3D 0.0488300 * 9.80665 =3D 0.4788587195 m/s^2.
> > +		 */
> > +		data->scale_factor =3D 478858719;
> > +
> >  	mutex_init(&data->lock);
> >
> > -	indio_dev->name =3D name;
> > +	indio_dev->name =3D id->name;
> >  	indio_dev->info =3D &adxl313_info;
> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> >  	indio_dev->channels =3D adxl313_channels;
> > @@ -319,13 +401,13 @@ int adxl313_core_probe(struct device *dev,
> >
> >  	ret =3D adxl313_setup(dev, data, setup);
> >  	if (ret) {
> > -		dev_err(dev, "ADXL313 setup failed\n");
> > +		dev_err(dev, "Device %s setup failed\n", id->name);
>=20
> I doubt we'll ever care which part it was that failed.  I'd
> just leave that as it waas.
>=20
> >  		return ret;
> >  	}
> >
> >  	return devm_iio_device_register(dev, indio_dev);
> >  }
> > -EXPORT_SYMBOL_NS_GPL(adxl313_core_probe, IIO_ADXL313);
> > +EXPORT_SYMBOL_GPL(adxl313_core_probe);
>=20
> Please don't remove the namespacing. Add any new exports to the
> existing IIO_ADXL313 NS.
>=20
> >
> >  MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> >  MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer core driver")=
;
> > diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl31=
3_spi.c
> > index a3c6d553462d..19cd096373b0 100644
> > --- a/drivers/iio/accel/adxl313_spi.c
> > +++ b/drivers/iio/accel/adxl313_spi.c
> > @@ -14,6 +14,16 @@
> >
> >  #include "adxl313.h"
> >
> > +static const struct regmap_config adxl312_spi_regmap_config =3D {
> > +	.reg_bits	=3D 8,
> > +	.val_bits	=3D 8,
> > +	.rd_table	=3D &adxl312_readable_regs_table,
> > +	.wr_table	=3D &adxl312_writable_regs_table,
> > +	.max_register	=3D 0x39,
> > +	 /* Setting bits 7 and 6 enables multiple-byte read */
> > +	.read_flag_mask	=3D BIT(7) | BIT(6),
> > +};
> > +
> >  static const struct regmap_config adxl313_spi_regmap_config =3D {
> >  	.reg_bits	=3D 8,
> >  	.val_bits	=3D 8,
> > @@ -24,6 +34,22 @@ static const struct regmap_config adxl313_spi_regmap=
_config =3D {
> >  	.read_flag_mask	=3D BIT(7) | BIT(6),
> >  };
> >
> > +static const struct regmap_config adxl314_spi_regmap_config =3D {
> > +	.reg_bits	=3D 8,
> > +	.val_bits	=3D 8,
> > +	.rd_table	=3D &adxl314_readable_regs_table,
> > +	.wr_table	=3D &adxl314_writable_regs_table,
> > +	.max_register	=3D 0x39,
> > +	 /* Setting bits 7 and 6 enables multiple-byte read */
> > +	.read_flag_mask	=3D BIT(7) | BIT(6),
> > +};
> > +
> > +static const struct regmap_config adxl31x_spi_regmap_config[] =3D {
> > +	adxl312_spi_regmap_config,
> > +	adxl313_spi_regmap_config,
> > +	adxl314_spi_regmap_config
> > +};
> > +
> >  static int adxl313_spi_setup(struct device *dev, struct regmap *regmap=
)
> >  {
> >  	struct spi_device *spi =3D container_of(dev, struct spi_device, dev);
> > @@ -51,26 +77,32 @@ static int adxl313_spi_probe(struct spi_device *spi=
)
> >  	if (ret)
> >  		return ret;
> >
> > -	regmap =3D devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
> > +	regmap =3D devm_regmap_init_spi(spi,
> > +				      &adxl31x_spi_regmap_config[id->driver_data]);
> > +
> >  	if (IS_ERR(regmap)) {
> >  		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> >  			PTR_ERR(regmap));
> >  		return PTR_ERR(regmap);
> >  	}
> >
> > -	return adxl313_core_probe(&spi->dev, regmap, id->name,
> > +	return adxl313_core_probe(&spi->dev, regmap, id,
> >  				  &adxl313_spi_setup);
> >  }
> >
> >  static const struct spi_device_id adxl313_spi_id[] =3D {
> > -	{ "adxl313" },
> > +	{ "adxl312", ADXL312 },
> > +	{ "adxl313", ADXL313 },
> > +	{ "adxl314", ADXL314 },
> >  	{ }
> >  };
> >
> >  MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
> >
> >  static const struct of_device_id adxl313_of_match[] =3D {
> > +	{ .compatible =3D "adi,adxl312" },
> >  	{ .compatible =3D "adi,adxl313" },
> > +	{ .compatible =3D "adi,adxl314" },
> >  	{ }
> As mentioned in other thread, there is a nicer way of handling
> the different types of firmware ID.
> >  };
> >
> > @@ -90,4 +122,6 @@ module_spi_driver(adxl313_spi_driver);
> >  MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> >  MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer SPI driver");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(IIO_ADXL312);
> Take a look at what this is doing. There is only one namespace for the
> driver, not one per chip type.
>=20
> >  MODULE_IMPORT_NS(IIO_ADXL313);
> > +MODULE_IMPORT_NS(IIO_ADXL314);

