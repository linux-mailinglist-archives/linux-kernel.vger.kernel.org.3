Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844304B23A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348175AbiBKKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:45:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiBKKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:45:01 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE553B81
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644576300; x=1645181100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FFdmpbfmKZi+IzweJgggjVO1iCNUaaath6qvaQP2SzE=;
  b=dQLbJQZ/My6hnec1J0b4F1Awr1Qbfq0KO2e3Xs0tedfy7TxSPBfQUrhx
   1W20QL7H6yff4hIffMaXpeUT6KczShxJUnEHAFuqcThMmMsPJ/7H8E6LV
   B9GYMHg0loGKVfMoSwbfbL2ekXjEo9J8F1N892P9cFZZfGILjXnqo+UYv
   c=;
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9KPDlXNVnZskMO8U/KnrZcKQtrO71+RtGU4vuJaB1Eca56oVafb6OGtVByDCjU+5vOOfTeafOmagS0/8WtAdNRNpDgneDYNND34oqjh56j6XJXFnUc5dq9S2asY8v1zP5c43Nb7d+MNGNW16BnoXzmKKgxgDcMPdnYzc0UMRKHx1j+UbbwumVXXmhWVjsVI24bdA/2/2FM2NBRS96GHFx145l42oQaMG7ajknsrfvzlAU+Q1ErfTQ2KE64CnRrM8PFOBDIZIvkngg9GGC+GSlHN76tCFZ/CI954dkLADFOcUbEddCCEKynkEZp49t0ugoR8FxiCdseC5FblMYRwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFdmpbfmKZi+IzweJgggjVO1iCNUaaath6qvaQP2SzE=;
 b=EtaZaiZ1CR98VC2rsLPRil6EHQIsru44dRAkcDmp5V8skiXHX4XN4R8fdImO4asf9dPr/WgcUiD+x1RboqO+X+cFTR8xRQ0AtGpLHU9u7P34RXuHm6V17+4RppH2S9Fh7p8XvxSWHBJ4XQviPKOEk77XnWFJjn/xDs06P0/tWjcRTMGr+3MOmCsdgSLxeWY3ao8vvcCG3utGFICS4VWc7poB2100FWnGitmMXwbQ/lNQXNJAnyhRY37ZrFuG6ff4btJYTN2/BzvVZtGhs4if4XndcuX54gM87pmN33dIBBiyX5+qq1H6A1hzm+04TcQmTRtgb3N8xiLZo8DB04wIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by BL3PR02MB7874.namprd02.prod.outlook.com (2603:10b6:208:33d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 10:44:53 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 10:44:53 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Michael Walle <michael@walle.cc>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     "dianders@chromium.org" <dianders@chromium.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sahitya Tummala (QUIC)" <quic_stummala@quicinc.com>,
        "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
Subject: RE: [PATCH V6] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V6] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHYHyj4jVBt45+Ii0axrXyqiUXVxqyOF/qAgAASerA=
Date:   Fri, 11 Feb 2022 10:44:52 +0000
Message-ID: <SJ0PR02MB844917CF0D89F4127C465DD0CD309@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1644571349-29649-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <98cb875e6f0de468a92692513f0eb47e@walle.cc>
In-Reply-To: <98cb875e6f0de468a92692513f0eb47e@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86abbfd2-3b9a-4ea7-3371-08d9ed4b8938
x-ms-traffictypediagnostic: BL3PR02MB7874:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL3PR02MB787437691645BB4DEA44C88DB1309@BL3PR02MB7874.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAojtJSHZ9Kazx6KGHprFvTidNKKL8NBhiZtWPp0da4bQT9o5FOlmzJwYpC70cu2dopjWie/3J1Z/pkq3+Bqo5zbJnxDX8Xw2N1EptuSZoP0DWswZLCuWrJBWeBdTquYD3PU9lRY5mPEzD0c6YQF8Qths+v5O7818AEivASPGdciT36Ora//6bY5scWf9SFsqyB7cXJfwPTihPC6VTj/ArEO4qE4BEHj3rcH8D1NTWLlb3P190zXtW9QpT1ceR7X8ogCyibC0J+Rct0eeW593jSSqYzkE/PJwRWo9ZscwmA15kT6PLSPe+AsAhgU8VRRySvBcBoEkBk+dj3aoaR3ZWzu89Tnw/68yDj3xCVINM3iJ22ibkhT0cdgzCwb2GH8pjJYPRAINRbZaBGzf/e1Syqp/VUctUwT8k72yjZhCv+PIFqL9zBL2QVP0Tjzo9c8OH2PG9o2ZxlQ06H8Msa65im+0l7D1/BzLZ//DyvNf9kBzdZFpfS3G3GkJGPjbXJ0bidBhG6o3sg5yq/f7mMalJSLYIo41DvHo/cKt3JcWF565kkiWmvkqQf1F/pQhy6pkI4O3EK6DPPD3Bmu6TRdV5g3O4+fr5qEem9bBl0a89j/qIGmQwETK3O0TY6LNSSIuHgINZlKI6qBmNcRB3jHNBQG0brkkb8LlndECgAkogUAlzKUBpZ1WB1SOA6sPtGjXmGePuhrM0ne/H5abmRDoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(7696005)(83380400001)(38070700005)(2906002)(316002)(64756008)(76116006)(66946007)(66476007)(71200400001)(8676002)(66446008)(66556008)(508600001)(4326008)(86362001)(38100700002)(9686003)(55016003)(122000001)(26005)(186003)(107886003)(54906003)(52536014)(5660300002)(8936002)(33656002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HQsjKGxbUEGsCdJ11WbkI7v0fsaR6cq+wzne5C5nRn/vUUHyCk7he+ECLt4g?=
 =?us-ascii?Q?uYf8/Ysye5iab375sfK6c9oN0Kzbj1SXjQUe+Y/v7gwNUzs2pHmyoePrOm28?=
 =?us-ascii?Q?s2cmz6SwNa49y2OfQ5HygMmbHzBJ20rcbCR6TW/KZKTmtazbZ8GWZJF/u5Os?=
 =?us-ascii?Q?09ynkIuo/Wp09xmJqTFs6cdO6zCCHTUABJApimhNFTByBD/v/0AnCgiu7QGT?=
 =?us-ascii?Q?IASNRzr3ftHRHZwFBJ6/IEXDla/hdH/MNrAf/ixrf5pQoXDG23fAWKNilQP+?=
 =?us-ascii?Q?aOq2JEQFtA67iaTeXP4jk+7GacZ8eGGPvDBM4MumDe8i0cb1rXPFnPpME5lW?=
 =?us-ascii?Q?mQh3hE+iwcvkdU20X2CzsMjdDWvt6rAA8iMxYKjBX3iGkywIvB3FSYnqVGLo?=
 =?us-ascii?Q?e168iZ5Fr7tcsqvBkAz3Kdmffilx9bbvYa4+E41U+RtyR9ezc5VjRwn0sFL2?=
 =?us-ascii?Q?Vpyj/QLstnhYUt3BAoTcz1QUr2xXPT+OpXM3SEKIRqb+b9qIdUnNDLPyoaye?=
 =?us-ascii?Q?7lzQvB2qo8OKMs5Mr3hBXOSRsvg6Sjf5kMBmT+gadgqWWkNjsmv6ErSl05sz?=
 =?us-ascii?Q?BzOW9fRSHX3DLlKjPku3hOlKDf9yxZvWI48+MbFW+/D6cR6B7R9w+67KKVDp?=
 =?us-ascii?Q?On+ctCnnAjq14E1HILKSQ50/btZp7I/dNjsxSk9CmO+LYcwILGJBU+v6rSTS?=
 =?us-ascii?Q?WTFqEPm6JWdhP8W5ITdaleO7IdwvjqyaSv/H2PrBjaXI5mx4w5DT9BVFIEA2?=
 =?us-ascii?Q?XDqGf6avmelhkrecyHjn2e+AAwHBtR7o2QSOwG9gzW5jwtUCzDuw2Q9QD/AD?=
 =?us-ascii?Q?mFpBK6q4YvT/mjNCjiHadsweqau8R9t6jFSjLAcby2aojVofdp8AKTeD+3gp?=
 =?us-ascii?Q?zt6k3SzY74opg6UwHWwS8Ej7YBf9eX8sx4VHV7VQSKOhNVr+JXZrbV486PIm?=
 =?us-ascii?Q?L3x4B6FCcU9XvA0XIcAnY2VufdLBRoWVxrvWEaGUeCo7BMc9O/d58QQ4A1WM?=
 =?us-ascii?Q?Vp+QFs/sHARs18piS6CmaRdsX25HCjS3pzwNH4f/RMXKn4hHcv6uZ4bMd85u?=
 =?us-ascii?Q?3g1C//BEi8ybYqtjwex8TBJjb/QyMH1Qs5bIc3wrIVyAMdRG7aTtf89dsxyI?=
 =?us-ascii?Q?biHSwfDN0HAEKxvrT62f3GO+hFxYKGvjWZdnCUmXjeWlzxM+NfmFt84rPLst?=
 =?us-ascii?Q?VuWC0xSfVEv/pztZdAiSaQx9/HP71sp5boft8KvVNhgQL2aOAuooFG03IfWs?=
 =?us-ascii?Q?+NiLHR8wVhxju4NJwN++QPMYEcjv+aDv3XJcuApRCdIrGd6osnF31++ZUUR3?=
 =?us-ascii?Q?pznXOzb/dRnEkXJUtvjppqwpCKYIEb+5590HweGCYlvNZxbB/xx5HUYGAWeT?=
 =?us-ascii?Q?Mp7s6weZREgC4Ni2S+r0iO5mtEBLZt4unzogET89GrFMa6TLlPhCGbO7f8tR?=
 =?us-ascii?Q?POyQd5YCf+F7jGAikWXZS/NxsPlJoa7sQILHBuo2j3R9LATyXLb1a2HUnIkm?=
 =?us-ascii?Q?M27Uw7X0BxxZkedgplacd7UHlPxkqGIwDIOjruv247rlHU+fNxkz1zJfFJYh?=
 =?us-ascii?Q?9W8xkX/utAb+VLPb+6eiwOl9edqQPtT64N2GirLwgiYMawP0oirqO9dhcUJ3?=
 =?us-ascii?Q?vmk0ei1zUuTLmnUhOBQyb429dokwI1fX4+idJMs7mTG0oL0CR3wVNGqXi7wG?=
 =?us-ascii?Q?l29K/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86abbfd2-3b9a-4ea7-3371-08d9ed4b8938
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:44:52.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srPOnDzlF28H5bdqs36+tL61bCD/QY0VeI7O4ZicAYPQdE/R4pXJFR/tO6TdJgiVPypzxyDKSjXijikdPe1bKPON5GjB3a3a0tSPtQYaoXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7874
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

Thanks for quick review

Sure will update the subject and flags order.

Thanks,
Sajida
-----Original Message-----
From: Michael Walle <michael@walle.cc>=20
Sent: Friday, February 11, 2022 3:09 PM
To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Cc: dianders@chromium.org; tudor.ambarus@microchip.com; p.yadav@ti.com; miq=
uel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-mtd@lists.in=
fradead.org; linux-kernel@vger.kernel.org; Sahitya Tummala (QUIC) <quic_stu=
mmala@quicinc.com>; Veerabhadrarao Badiganti (QUIC) <quic_vbadigan@quicinc.=
com>; Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragall=
apati (QUIC) <quic_pragalla@quicinc.com>; Sarthak Garg (QUIC) <quic_sartgar=
g@quicinc.com>
Subject: Re: [PATCH V6] mtd: spi-nor: winbond: Add support for winbond chip

Hi,

Am 2022-02-11 10:22, schrieb Shaik Sajida Bhanu:
> Add support for winbond W25Q512NW-IM chip.
>=20
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
> localhost / # cat
> /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
> spi16.0/spi-nor/jedec_id
> ef8020
>=20
> localhost / # cat
> /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
> spi16.0/spi-nor/manufacturer
> winbond
>=20
> localhost / # cat
> /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
> spi16.0/spi-nor/partname
> w25q512nwm
>=20
> localhost / # hexdump
> /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/sp
> i16/spi16.0/spi-nor/sfdp
> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
> 0000020 6800 6c65 6f6c 7720 726f 646c ffff ffff
> 0000030 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
> 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
> 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
> 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
> 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
> 00000d0 0aff fff0 ff21 ffdc
> 00000d8

Thanks, please provide a md5sum/sha256sum, too. It is to make sure we got t=
he same binary when we pull the data out of the mail.

> Changes since V1:
> 	- Added space before name of the flash part as suggested by Doug.
>=20
> Changes since V2:
> 	- Updated chip name as w25q512nwm as suggested by Doug.
>=20
> Changes since V3:
> 	- Updated flash_info flags passing according to below patch.
>=20
> Changes since V4:
> 	- Added OTP support for SPI card as suggested by Michael Walle.
> 	- Updated SFDP flags passing as suggested by Pratyush Yadav.
>=20
> Changes since V5:
> 	- Reordered flags passing info for spi nor as suggested by
> 	  Michael Walle.

Did something go wrong here? The flags are still ordered the way it was in =
v5 ;) Also, the subject of the patch is still the old one.

> 	- Added SFDP dump info in commit as suggested by Michael Walle.
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/winbond.c=20
> b/drivers/mtd/spi-nor/winbond.c index 675f32c..315b9f6 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] =3D {
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +		PARSE_SFDP
> +		OTP_INFO(256, 3, 0x1000, 0x1000) },
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },

-michael
