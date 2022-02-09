Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6440B4AEF56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiBIKew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBIKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:34:50 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F06E090D58
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644402230; x=1645007030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JHsMEnv9/CHTQo7+cloCyrpQDyEnXiO1CrSg7mZKkT0=;
  b=jTJYIGYtY8/i2ajlbnzo4+tB8Yp61VLBn39gzNIOTOuKNpGplytcCSv7
   8hbuDj+5/yxr9CNt+u0m1UOYPd2LGJrwSw/jec0Fazoy6SMDNtlskxw/k
   atWNE4nbjpUfIFhEwe22vDMWh2sEvIf5rtiPKBylmNqnax/zqRWs4QSSO
   w=;
Received: from mail-dm3nam07lp2049.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.49])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:23:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Ctd1lHz7Sl3fT12MWFjzpTjVyO7INUd+9xfmybERbV6ydvPLvmwFp3t9OBHHj8G6zaJ8RkwkLIOYgz6dxuo4ORL585+5DUamt4meI9VzkXMIM3jGWUUhiTvofR7GBnQJ9R5W9/2KjtjjScvQLsH8sQRBeGCb+oZ9SX/JaZbXlieMwi+5ZmO/1lHxEhImTVcCAziLnCEgVqhiP1vGbRlxUF5vigWLBrOzhAfcn+J66UeGQHWyiF7BdUNeLllL+xEB8lQ3YfEmaeHktv7h9+1zKBVRt6zCc5EBljDTlDYHPvfN5l4jz6gzqbgpH9XT+74/Qa74LTDsyhNLRtplTZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHsMEnv9/CHTQo7+cloCyrpQDyEnXiO1CrSg7mZKkT0=;
 b=ff1XPlnVwZVoxAIsH+o5lscitJQzo1t14elPMwaAgDkQqz6+ndskGSo9slAC/lSOUL0ijapF1LXq5d+FjA+L+jFqC0f/+vwZEtqgJ6KwjT+SHKY+EeVT+76D+P8Tg1gTql/pFRdiL8UU3/j1Vp6IceIWiEev56EnaO264TmmGrA/9eazagsL9mDiBK7kXlky/16/OVTsdiWsyT9pjES1Lb1cwsMfP4eRpbez0/dsxTUVaWIuiTBTBX3ro8zXZqgQGNbzF4BT2VJZymhub1YLE6mubBNepD2SoaZjPY/MXNz8GBlZmqYbWA2zz3BWeCO2Urki5VzSimTY6xRHbGempQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SN4PR0201MB3437.namprd02.prod.outlook.com (2603:10b6:803:51::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 10:23:46 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 10:23:46 +0000
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
Subject: RE: [PATCH V5] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V5] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHYHSZc+MddQRsTVUmI/Muk+X5ezKyK5F4AgAAfjMA=
Date:   Wed, 9 Feb 2022 10:23:46 +0000
Message-ID: <SJ0PR02MB84491A01308D4E2B125379F0CD2E9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1644350330-8809-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <d343f7172f179ac2da96f80f54cc500d@walle.cc>
In-Reply-To: <d343f7172f179ac2da96f80f54cc500d@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a4858f7-3b54-4d73-3e7e-08d9ebb64165
x-ms-traffictypediagnostic: SN4PR0201MB3437:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0201MB3437218038881F59A952BF93B12E9@SN4PR0201MB3437.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSqykmjDVHyOPmfeGCvHuVc4rp+Kt8UI5yUPFo5B0V2GUtQvkj1U1XxwrFtA+9unmU2GlQ7ZPXB1Riv/8m9ptoAigVTRRt/vUvx6JCpLaLyqXbzUpfkmNorZ9coeqAu2cyRXYBTZ4kt5ldR12mlgSSIRkB72neUKNlvJ7Mg+10COa6l7PPuoj83FFSnwZr2tzUja/X9BfZAUY/e1CbBWEtdjcBV+LbXaYalO0vMvypKIg6RI3+jx4mcd/mRMgOPnIGtd+Z/HQOVFLRJ4s0lIFhlYPVdXWxT9sr7hEFS6hFgzl2JHFJbN+FymiNWWaB0jROcqGxQxEvHeo6rqkyKUNu1HHeitPSNJjhCEbVL31dZyhVSvsNtm6Btx2s1P7grZYCL24m8dmDVIGMnfNXaUhfFjXtk/UmZcFkRAr4deNU1MrEsvMmo6Gm0BkRFLIZ8L+YVrSemY+AnlZl+xslYw+6d+1LDZqG+mSojGSMvopPONrzn2J6BiRuZJP+A2CradFdlWiWdJaZXSwZitu7iMNgk0QMJTqSl6TkTRLeToVQePbDCafyc+ZEhLVktMPlVcrpFVEimzlvI09XxetXkpF00coMyW7JZ73gWS+9zKhdTCUnamEZgKkcEVopN379T2kbgFSFc9gZ8gqJQegJLujk5obRbot9fO+JUU50XyV2XC72CPYcmuUK+vLCcgk743AD97bH3RAYtQeHXf0OiMag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(316002)(26005)(186003)(83380400001)(53546011)(54906003)(508600001)(71200400001)(33656002)(6506007)(64756008)(52536014)(7696005)(66556008)(55016003)(8676002)(86362001)(76116006)(9686003)(66476007)(122000001)(107886003)(5660300002)(66446008)(110136005)(66946007)(4326008)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nDzqywFtsVjy9TlO/mfzPnQ0gPKopz/0oYRcYMkGAD4fcHEqhGm0z5ZSMQr8?=
 =?us-ascii?Q?rB1cpYcoCqgS4UpBiL4ElvPl2Etda/AuFAJtPvZp0oF3riZn7yLuPCxW45gJ?=
 =?us-ascii?Q?TsK6Wi5w2iThKI25EZU5DHcrkyojT8OYGgbC3qoCUQkLGFIz0FKaWJ0WqSLG?=
 =?us-ascii?Q?i/ty2yPMqmZ3xdZMLIsvJEr12NoqWjW7bP9KoXiQGBuzeHypJ3CCjZ7qz4x3?=
 =?us-ascii?Q?sKl3ttyeF7ocFL0R/i9Xg2H9JfL/BOIpinPOmRwfEjXh5mYRhqbw4nNWKzEL?=
 =?us-ascii?Q?/c66AJ0/m1Ok2BpbGA854H6Nr+aTYAbTwpYFfoPVtRj14LwVOwc5AMzaRL6x?=
 =?us-ascii?Q?90yzmJUwPJksEtIgW5mp+Px+YtUzJlCn7pLtFE7lJkSrAElRbH4l1Rx/HOOx?=
 =?us-ascii?Q?8fiJUxzVfjQNUjA+D0IUlWAuRMarCGV+DGHGsuMG1Btd/LpnosmRTB7zhQlf?=
 =?us-ascii?Q?FQfrrszbqFoxpVD+cDDbMkvnYU1W5CEBcj05uxUlFCysdrsw9Jw/KVqyuTTX?=
 =?us-ascii?Q?uCLf/l/5t32XktcNCpu8qEGP5OC/gBCaJgDawXxim+nw4K5uDgJq8MlPllSw?=
 =?us-ascii?Q?V0yV+5/DTVxQLrVLpbyffZ/kaz167eBwueM3iufLrZpcfV/zw9QmyZ/2L5pL?=
 =?us-ascii?Q?FSHM20sHqPsYzNHk9YdWMXmO8scM/jrdeRDtsXte5qlB3X8SmBRmXHo8PJnK?=
 =?us-ascii?Q?GD0LJfZt2eLHFwX28L79J2uNcXuKTOX42NjeFkvuUMV4AUSG13gqIB2AKJTH?=
 =?us-ascii?Q?Ma6t3JryT9NpOLL/5/SHhXY/munm0BxrmwIn0z818DQCiMngK/rNH2zqNEJv?=
 =?us-ascii?Q?c34HI1X+HsUG6nQENnoacVmSnzzdQooIZBLtjX3uEXPDqxbpTrZm/gD7GkNp?=
 =?us-ascii?Q?Got+4TkA6BaSnblkmiL62eKgiBA5ZTOwzFajBsDtVzSynY/PtgvJBkU0lsWE?=
 =?us-ascii?Q?UBmYWRJBcPORvrrnNO+hd7YDoBfJ5x3PYk5w030ffjAFm8msTglImXa6vpM3?=
 =?us-ascii?Q?FwzKqckZvxJl8pRW562HzgvqbW3eFqgbnGRtRkWplXHT3DTvGbG7+XBaHh6s?=
 =?us-ascii?Q?yNSYqLkJm5WodnFhfSFCxt4CKQ5KqPQdObeIogqE9CECBANeVrw41ytyI5+9?=
 =?us-ascii?Q?UIu3X8THy3U8kM1YGQKb+gYEBbwv6W9x/pCIEOymDm6JUaiGoIXA2cDRk/tx?=
 =?us-ascii?Q?Zw+iG+rxRZen/8imm7tmT/n2LUDn4CdkFcO17cdkcy3vZHoHRjzk/ImEA/MM?=
 =?us-ascii?Q?nRpJq26WAZe8NN/Vcc1f0hHWo+54W00LkDzaGQ5htdpm7MqB2Obp6Z59k8Kl?=
 =?us-ascii?Q?YjBmTUkSvmYAngZnyq9MQyD9URL7U4enMdjMRVVt1v7LBp06OShKOokT+SzF?=
 =?us-ascii?Q?wwMPJxlPtyuYa4e3XcY4HHO3AnS3EDYVO2oXlT6SPULh3rbf3jyGovY7RMkv?=
 =?us-ascii?Q?xN/9hZmyPDwKVFSMlOnkEwOoHN56ddKflwVInmK84uxtddrCHj9j81q0+Uo5?=
 =?us-ascii?Q?oeeveFPBQs4s8y/Xx1Zp2N14HTER3XbRu3DfoOIeggr5axPXFPfQ/xqak6pB?=
 =?us-ascii?Q?HqA/A4vporafLkYJhGOpoPohPs+DVkjQjtur1Tr2mhMsQybz5hlU7Q30GHRn?=
 =?us-ascii?Q?lXxeInbVrweGTUDuelzR+aHawxlk1lTd/3JCVAOXwm1pMFcC4cBwbdNiEyPq?=
 =?us-ascii?Q?v623rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4858f7-3b54-4d73-3e7e-08d9ebb64165
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 10:23:46.1959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siRGAN1dEgKDFg8X+4NTb3pnBPDPe20DgpnO78vc7mfDtJz/gndHIgWkXDRcndBUXddB8W/Wy2dKo5/ecax5iDTyk2Rs7q+s7IUl3eJ5k0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3437
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,
Sajida

-----Original Message-----
From: Michael Walle <michael@walle.cc>=20
Sent: Wednesday, February 9, 2022 2:01 PM
To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Cc: dianders@chromium.org; tudor.ambarus@microchip.com; p.yadav@ti.com; miq=
uel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-mtd@lists.in=
fradead.org; linux-kernel@vger.kernel.org; Sahitya Tummala (QUIC) <quic_stu=
mmala@quicinc.com>; Veerabhadrarao Badiganti (QUIC) <quic_vbadigan@quicinc.=
com>; Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragall=
apati (QUIC) <quic_pragalla@quicinc.com>; Sarthak Garg (QUIC) <quic_sartgar=
g@quicinc.com>
Subject: Re: [PATCH V5] mtd: spi-nor: winbond: Add support for winbond chip

Hi,

Am 2022-02-08 20:58, schrieb Shaik Sajida Bhanu:
> Add support for winbond W25Q512NW-IM chip.

Also please include that in the subject. Eg.

mtd: spi-nor: winbond: add support for W25Q512NW-IM

>=20
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
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

This usually goes first, eg.

PARSE_SFDP
FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) OTP_INFO(256, 3, 0x1000, 0x1000)


>>>> Sure will update.

> +		OTP_INFO(256, 3, 0x1000, 0x1000) },
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },

Otherwise the SFDP dump is still missing as requested in my comment in v4. =
Please make sure you put it in the comment section of the patch, that is un=
der the "---" line.

Then I think, this patch is good.

>>>>> Sure will add SFDP dump.

-michael
