Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12DD53C63A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiFCHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiFCHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:32:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10103.outbound.protection.outlook.com [40.107.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50361D33E;
        Fri,  3 Jun 2022 00:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBp4JNAZVE0Or/hMyJEoBcNyKYGaQM9Z/7wIJFaEhkqfIxSp0nXoM57WMjbVuLMsHikT8jR1cevjrUzkhLL3WaMXhBJlrwFahndFsTzMuNaGEol80sKsJ9XoO/CDfEjO13kpMM8tGdveVi7gfq2nPSdgLTL9YnjvmmSYXGG9wiKjiKTidAKRpXA+RYTldhJ0+rm/EwV4tDDnYQPSnkhEIRuJxepVB/f3pxvw/wq5XgaSDi/uaXgxHj9SVWKrwbTJb/pscMeGFKSfDxy8LenSl91B5yZwgpN+nfFKrOOiYnynsx1fVDMPKFYrUH4b1VRWkrYzgImCk0AW0YPeHen6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPYq+RsvcmDTtA7oJxmSOHjeJefSZP8GPGe2f9Ko2BI=;
 b=AzhD22ps6qNX5eyaPFOVMRYxGnKnrgn/sa0UeFPKKz0kCw2Bc1I5gHrrowHDNzz89ePzCcFY5uTepqTUh0LKFaaM/crYB7dRZDHXgjNVzWX2DDuomC7S31DLh4xlF1jwUFrHr8FYwT5URO8Wutcp4QW5Ydo+LZ9Ji9ldeKZwiD2+yE/ibM4nVKJnys992nZp2fPr8ZZeOQzib7G4IYE/CE63T3W4/uOREG7QF7SnP7RaBD56PnMFf7URhQob5CzHDWv8aiFIi4b+hjbC9xBSYXRfSCwJJcvzF4NBRxP0lVuSCpGNeXL8Zsg+G7xOghBvHfZIPPtXqOlm++y58S7k5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPYq+RsvcmDTtA7oJxmSOHjeJefSZP8GPGe2f9Ko2BI=;
 b=UQzaBjck8Mi1Tw1n2N+3WRltpwWaWCWl92i+9dzPdXXBlbzIkXPKCMkTnav7OCBve8FF/Y8gjiHfa8IfNK1z72vCpdFKq6pCusjbTmDki68hsVaas9uevXP+pY6O33S3eGqT9hfKYTC+cWzXwnP+/c9GfvOAs2g7p7nM7MOqCZ4=
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com (2603:10a6:20b:3aa::24)
 by AM0PR0602MB3620.eurprd06.prod.outlook.com (2603:10a6:208:1f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 07:32:18 +0000
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::7ce1:9e8b:a4f8:11ca]) by AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::7ce1:9e8b:a4f8:11ca%7]) with mapi id 15.20.5314.012; Fri, 3 Jun 2022
 07:32:18 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        HAEMMERLE Thomas <thomas.haemmerle@leica-geosystems.com>
Subject: RE: [PATCH V5 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l
 bindings
Thread-Topic: [PATCH V5 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l
 bindings
Thread-Index: AQHYcQVhb1m+58wAMkWozJbGrJeE9608L2AAgAETZMA=
Date:   Fri, 3 Jun 2022 07:32:17 +0000
Message-ID: <AM9PR06MB78445C0FE66A61F6BAC4CE35D7A19@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220526133359.2261928-7-Qing-wu.Li@leica-geosystems.com.cn>
 <20220602135734.GA2198822-robh@kernel.org>
In-Reply-To: <20220602135734.GA2198822-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 933d6c4e-2bd7-4cb0-ade4-08da4533303e
x-ms-traffictypediagnostic: AM0PR0602MB3620:EE_
x-microsoft-antispam-prvs: <AM0PR0602MB3620FAC90D5CF363301BDD03D7A19@AM0PR0602MB3620.eurprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSfJg8Ar/IHzEiGGOl+D+sncq5J8Kjesrei6Xgte98akEiJvPjtUp63EgAjQX8m9+HjUT+ETwbmEOX+bDeN2rM1Nxn7pnjPmkHN2N8NyNVJRATtklx+MB9WEZhCUVux/wfQXi6tqjbDU1QZREsI+4OUFTmnvNO+60kNkwNEMW2hW61MOocncy6MOW+fleW84do7hSQvRK/bBfNi7ptddAKE90vRAOuxz0jPtQcepz6+/dQAekboM0QOsMIceNyUtJSbSlgheZrT+qrekiRvKpe2l4CXH6UXoQrS6vAMTt2u3mPCjfuySbAyT7nXpYlKiCbT4/AzgwN77vwzZbllzkKQe2PmnKlFFesp0TkpffC1190ZD+Q7Jty7/+NAyz7vpd1pcIuu7EkOqK8RO5pFna59hgITRyTeCqM8NowMIzotzpq1u9QD87EKtuaAEHD2Ou9k7LjjOb7Tyy5QJ+wUy2bfbTxR0Z1Jeimc8xWVn+wu4xyvU65VR5Wg22Yxy27mtyZNIlQDkBTqixr3K7X2o/L+lrEO1W/FsawZVhL5Yn6s+qTv1KogTedht6+Rw32kepMwqOzYuWm8VREXE8qMLXMIXihTNBP/zVR0xITnhFvKcowzd4cswO30qTqjsuJHLVatz7YDYV1Y1gsyjNl3wZYJ2hnD31uiGtKFhetXevc0DvNy4MeOEpBR5mAbbt8jg6moGsY6QO3v8uSUFrrVc/Cp3l3d0y5YX3gEGG4GHaD90Zxfq7hTzgpXXpP5NtjmhC+VnpobAIL/EEKls6bvY9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7844.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(52536014)(122000001)(316002)(9686003)(45080400002)(33656002)(8936002)(38100700002)(86362001)(38070700005)(66446008)(66476007)(66946007)(64756008)(55016003)(4326008)(76116006)(8676002)(66556008)(6916009)(54906003)(186003)(71200400001)(6506007)(7696005)(53546011)(107886003)(508600001)(966005)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o8gi1UVkX4OeQ840cdIbq5xE5ByNW4qIr0DJW1w42qFXcJlNAHY3p9NHT6xi?=
 =?us-ascii?Q?97jqIxoLIoaqku9OqiHnhFBNTiKf8Y0R/Rn6srKx6jM+Xh4k+3ZXPTGjm4Oc?=
 =?us-ascii?Q?8re2LLJKI0ARgBK+2tk4XsV+qmsBSRAF5LcDWXJXr+c8EuxIbbKvM7TAMU10?=
 =?us-ascii?Q?j5Wr9YppSal2G6XpMAMbFbMinvUeVc6jK+c+YTDOX2+mXwouvQ/IJgqu+SJw?=
 =?us-ascii?Q?rme61bPrCVsC2oM4OMYxfHHx2jO6NfXyI5s1xBj4wcyzSvocfLEdNhji2sUs?=
 =?us-ascii?Q?GvY0pOYLCmxW4Z0Fke+9EkfHEg5/DrsGTCbnhcvo0x9yVkt7Ii0N2rQWXlSa?=
 =?us-ascii?Q?f7uevbrhKuDSK73H6SywyL29kCAmuaw08Y7jQfU+5NvEo5Jd2HUy/Mf9t6nS?=
 =?us-ascii?Q?GHOWFk19RCuUo65PVZbwA21XFdDnAZvOZoG9hskNV3IZ9Pc771nKYjDZXv4q?=
 =?us-ascii?Q?txx3dQxt4dikdZJvpBS+D4OL4/Y+ynzi6C/qzBbFojugLcqXRZlaKrdNXKcL?=
 =?us-ascii?Q?yn+MsMM3jDcJecoHLpOmlV8SYExwIXrSYyRzsfUmXnKkfJFQJ0+Fhm9UuFdy?=
 =?us-ascii?Q?r7NolmkKxPV4KnrDKJTY8UMfN/joHKr08Am7VcdCpph9IxBoxMxm129eZUTC?=
 =?us-ascii?Q?c00yvtnvgYJX/4yOQcygU9fctoEfBnJqtqP4/5bHVTFGaEq28P4hgM+kBVmv?=
 =?us-ascii?Q?mh6OqD43x6O8JVYIabhoEVZkzpI32oF1b23L0EIcGWAeaCmpjAGtyI8aIlo/?=
 =?us-ascii?Q?9BpyQ2VFefB02xqTahJf6SwRrg9b3OC9Ht5zS2HCujW9YN8qqIFoPy0wHmWb?=
 =?us-ascii?Q?xwWWh2UO28C4Qm3N/EHOTo0tq+Bs+o8HOU2petoZ8lBrnUsGaVQPwtItKkXQ?=
 =?us-ascii?Q?m2lO1KL48zsDeHLw6dyGrXfIczdcODNtglV9iMHah5N7N+UOfcb0u26/OHiU?=
 =?us-ascii?Q?5AZxmJCNWrDaIgrfF1Vmo72fq8KBt5FKIdIxZ8Gk/hTRND8H9ZWwH5XMbHxJ?=
 =?us-ascii?Q?Qra7Q+41yvDuj/xbkzzCo3LOEXSJOPzYvNFJ+jVZz4yrKRjLN9wKGXBX/2+R?=
 =?us-ascii?Q?nCBX1uc7FXglh4CoswQie+S7y1AlsRx8/Zr2RxCCZmlhPffEKz/1SOo28yX2?=
 =?us-ascii?Q?fj7voAKz5dKyiWbu6boZRtqvv+p5z4Qw/5r74jJahU7Ardr/4r+boYBpWj91?=
 =?us-ascii?Q?G6tNmeRvuMkmJBY3G3ScDPSPFmJaIvaA2LidGFICw/Z9Ybde37qjQqgHNyZw?=
 =?us-ascii?Q?4NOryoxtuj326UAzhBG3eJiYO5kjMMhn1W91eGPtacH80XxE+Jk2El667+ft?=
 =?us-ascii?Q?n7ZHkX8XPCTG6FEDK/aSZWRl1VvaUpdxRwBmbIW4g1Q0JcZSIKYylz+eyUKS?=
 =?us-ascii?Q?KaH9U/p1WITylLtoBIS7NtJY6uBcRXh6F64j5kR8+PhfoDstP9ZLiz57o2jQ?=
 =?us-ascii?Q?RqZKLGe/LS9HItA0Z0l324EC5WmUODp/IgvsLPAxjKspby8Ij+ydWGOpBH5h?=
 =?us-ascii?Q?YYLefF/2JkoDgBs9hZIV2t5/j2FITKUWIVF+AmJ1xVy7dTfES3BIMmnmCRd2?=
 =?us-ascii?Q?Z+I4F88VDiXRSD6WJ619wIBNWTqCiR/krM7gBtNa4Kz7iMxnw+3+q66G+9ur?=
 =?us-ascii?Q?AmfxqUlxaET2XOw2b0Bbz//RUiXpWMVtNgz08Y4ykUQrd4bYiIlIw8vSrWxT?=
 =?us-ascii?Q?hFQOLNROlnS+dsSimMf5fDNSqjY0FAQrSutrNoukGtOrUfJCywPdqrijOnB/?=
 =?us-ascii?Q?URO2hhHxwGtGM3wAIvYZe+okjPY5a/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7844.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933d6c4e-2bd7-4cb0-ade4-08da4533303e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 07:32:18.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UlwQFS46ZbaMpgzwW5RyZKKDW+3fq5zWWq7ukPSAWm2qbVt7otXRA9CLVituc27+KbcfRCwKROcXa2gW7VpuDxgUuohyK7nivCfQo5tTW9YwmTZNXFRyY2yEr7ltzfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3620
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, June 2, 2022 9:58 PM
> To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> Cc: jic23@kernel.org; lars@metafoo.de; mchehab+huawei@kernel.org;
> ardeleanalex@gmail.com; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org; mike.looijmans@topic.nl;
> devicetree@vger.kernel.org; HAEMMERLE Thomas
> <thomas.haemmerle@leica-geosystems.com>
> Subject: Re: [PATCH V5 6/6] dt-bindings: iio: accel: Add bmi085 and bmi09=
0l
> bindings
>=20
> This email is not from Hexagon's Office 365 instance. Please be careful w=
hile
> clicking links, opening attachments, or replying to this email.
>=20
>=20
> On Thu, May 26, 2022 at 01:33:59PM +0000, LI Qingwu wrote:
> > Adds the device-tree bindings for the Bosch
> > BMI085 and BMI090L IMU, the accelerometer part.
> >
> > Datasheet:
> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.b=
os
> ch-sensortec.com%2Fmedia%2Fboschsensortec%2Fdownloads%2Fdatasheets%
> 2Fbst-bmi085-ds001.pdf&amp;data=3D05%7C01%7C%7C6bb7d63d627c49b946c4
> 08da449fd9bf%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C6378977
> 51065729986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> a=3DK3PYyQAGsySCIjKuo1QRVm1HE0cuC3BVXbjuAwwhMjM%3D&amp;reserved=3D
> 0
> > Datasheet:
> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmedia=
.di
> gikey.com%2Fpdf%2FData%2520Sheets%2FBosch%2FBST-BMI090L-DS000-00.p
> df&amp;data=3D05%7C01%7C%7C6bb7d63d627c49b946c408da449fd9bf%7C1b1
> 6ab3eb8f64fe39f3e2db7fe549f6a%7C0%7C0%7C637897751065729986%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D8GfqaDLkn5whi%2F
> bsEH9UATPNkJVgsy859sIifJGv%2BHg%3D&amp;reserved=3D0
>=20
> blank line here. These aren't part of the tags.
Thank you, Rob, I did check, the most datasheets are part of the tags,
and few of them has a blank line, do you agree to keep it?
>=20
> With that,
>=20
> Acked-by: Rob Herring <robh@kernel.org>
>=20
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > ---
> >  Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.y=
aml
> b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > index 911a1ae9c83f..272eb48eef5a 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> > @@ -17,7 +17,9 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > +      - bosch,bmi085-accel
> >        - bosch,bmi088-accel
> > +      - bosch,bmi090l-accel
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.25.1
> >
> >
