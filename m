Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBEB497976
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbiAXHbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:31:06 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:61577 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiAXHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1643009465; x=1643614265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ixVOJC82PRe7K1k25FIVUrwmSl7ABuEDFKdCg/7x7FE=;
  b=FpDAAJyp3zUCEavYGcaHJCuSrdr3sJqnSeAYXNNLnRRILnLdyLPtx8V3
   ctqgtL613zpiXJID/cc8DFOwc1wgHWBRLmBq8awf9V0Lf3EY077VvdJqT
   ARD6LbG4e8ArfYy7ZZKo+ISnH0A+1bETB5pOk1S+fCwVzcTrtIv4Ke69m
   Y=;
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuWygw60zOfSiPVA6prb4ppMPymOhtfnGNOCPrx3HELmYzu3mqemocNxlseYsVbvh91Kw4dGfowDYuSOy6eUoZpqhkFWDDmXomGE0eIYSIkW2HF5AxEvte6aJvUfy+eAYG2LYs755n4LmNscrb1cN54Xnv4HEm7fUYthaHGs3OQP+OPnZNK0EI4GfG2PhaKWl7Qpsiv/fQg3G7u5EGkLQ3euDFmVpxZ/Oj/2PwjBinaszSHGP85tP7ad4azQs2hRMPIl0SJ2NOy6WFiBlNTcDRXh2HytlQ+Mq1uiG6VXPWETLcRSisQlPU9i2+6DV8maUC3eymbViHFGxuA3cbAtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixVOJC82PRe7K1k25FIVUrwmSl7ABuEDFKdCg/7x7FE=;
 b=DplTPYCZSge3wTtk9rIdUXon6mtCrTs1erYT7f5vqz9DyYV6vXcpeTCKp1OxDZdsutuOuzRpjEmlgVVG/ImexF+oxwrAy0IDMih6b/w44d+8oI3c8lGg2hf1V+4rDIWAiEbgpY5hDAffHXrAbb1FpCnEBcWwhgta3N1vdeCK798TE1AA0wXO+y8ZJcXa3/vjkQnOvKP2h5Ny2cwvwbEf4kEnivOugfgfPhkjITBc7cjPiBcTNI050byl4krQ9QgIJyz09z6ONjL4Wq8+FNf9wqv0jSvK0S5jIfpqcPXUY+TjE4iw20lBlRtoA4tgqZ1sIbp40DouewogdIBhf8HH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SJ0PR02MB7789.namprd02.prod.outlook.com (2603:10b6:a03:322::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 07:31:01 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%5]) with mapi id 15.20.4909.010; Mon, 24 Jan 2022
 07:31:01 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Pratyush Yadav <p.yadav@ti.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     "dianders@chromium.org" <dianders@chromium.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>
Subject: RE: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHYDePakDL0XfUSukOExyL3iAAZlaxrsKSAgAYb81A=
Date:   Mon, 24 Jan 2022 07:31:01 +0000
Message-ID: <SJ0PR02MB8449DDEE0A6F9146BFF3F265CD5E9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <20220120101221.oqtfa6vosnweqsoq@ti.com>
In-Reply-To: <20220120101221.oqtfa6vosnweqsoq@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f16addbd-e08d-45b1-0664-08d9df0b78ef
x-ms-traffictypediagnostic: SJ0PR02MB7789:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB7789CEAA25C5F347493E6019B15E9@SJ0PR02MB7789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSOp5iO7ZqJdT+N3YWus8QSuEdSfzUvKx4mKMpqlCi0XwTunDEx7aE/qUVQhWToH/8SaqYatgrSNYMwoxjAiyXT2lT+p51u81Aq6tHmmzs58/e2nbYk2rgbaMyAiC00uzG0tgpDMJ6LNuRBYJAJJtXa/gGK+ufvc86ZQxnYcj9sASHqK0Qofw/3Ju8O2yo7/v/V2R84Ie643ayzhB7v5fSyYjl6meeIXoN2Z+FGDWyHZx1Qgd7IBsmmISdBUahPnkfCdsiMDf/P1WxqH6GCajcb9O8phx4NXi6+R04/iZ7YL1V2mU39M/97YZVuzjAvANZte/eefSsFcnVDf21RCkFQCkjuXqS2p4XmPPbZRiWILmnFyR9uRrYwtSBWDS4z1ongDnL5NMpy/CikVcmxSNBk/ys0CG1b7BjWKjL1FgO2XqjNxHI0TTbWkWi/f/21iL1H3dhbKDppAs6R3j8EzWBEEtBow5M4HSE/8kK8MmqjG8bFwScC7r9kBjX0iQjWfpuMNIVvlGCQphGB/AZOhU+k1ujfSnJjZ0aP8nFxAHn0eB8oB+EhpdVKUksTUTZC7pA42x/xbYTTyyLJhmF5mVai5dfwMhtf7tf1SvTUdSOv/P2qppHpTVYzMFYsvYo9BTtLEHfkKnCx4SNBE58rMYL/+byMXhYyBAb6ZM9Mq2woG5yqc/B8eGj936EWwbGrueMQ/RCSBY1G5Xa4BxeB89mqfG/01RQ4BZRTRCoXYCzYA7SMuq/lvOVb+8LYhPqkRezRLKAjMoYLGpTOldGKpwCiA7HeYvZ5PNnHeZgS8GpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(508600001)(38070700005)(7696005)(53546011)(5660300002)(38100700002)(26005)(86362001)(9686003)(52536014)(71200400001)(186003)(76116006)(4326008)(83380400001)(54906003)(316002)(8676002)(64756008)(110136005)(66946007)(6506007)(66476007)(2906002)(122000001)(33656002)(66446008)(7416002)(966005)(8936002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CIJHkpgIBUdnLbo2AalXjB3tfsBhglgPFPMxJOEkXSYLGm44Rm5umOXlXS3v?=
 =?us-ascii?Q?w3A+lUA4sUUPaMJPriSx44lEjACChgSm+qEEP4EbVmCUgPviPJcd5M/gJWwD?=
 =?us-ascii?Q?38za3W1/QWCLDXciDPTMFyJgplqP7prb1MCnZZF3Ee0y1aBBbQSOwpJkvAq/?=
 =?us-ascii?Q?Y6+BR3/M/+EJ0jdFx87LQeXGDAJAJkdigPExy9c6bOLr1Riz4kUjNK4XS7tF?=
 =?us-ascii?Q?mi1i1Szh1dEFCplbIkpDk4h/QPClyNnJFk7o0kKz3jG1dOFdp75lkfKVVQix?=
 =?us-ascii?Q?EhxDjEZum6zpL9DUkkcaKNBwTiBZdeahM1oe1g9rwCFwfWpuWmS2vvwqovHU?=
 =?us-ascii?Q?GnVCfrKWPEXM2CgR9FbjOZkOzcsVuq7sNB6NbVBHzxjmONaQUHcOmxFxrwjG?=
 =?us-ascii?Q?tjGKnDMffnJzgNX1fKaLNewmvgpHfyFapYMr6665EfHLyxxUfkR9PTxX6ktP?=
 =?us-ascii?Q?mslXyCH8GFLqXem5KhEePHuq/mp8SHtZ6YwaA9di2c7ohDzjMeox/TWoWx5+?=
 =?us-ascii?Q?uF9IOVOLd/4XauY35Thz1IKY8SJI63W+3xet3pvNpjTHo7nKPyABsbv3e557?=
 =?us-ascii?Q?3FEWe41Q0AOm4iwSStl6HSkUZd0MzbbqAhqwK1utB525xlFoS78D58n4d+Pv?=
 =?us-ascii?Q?I2LSdd+5+qAqMOoHNGxpsk/Tqjqh8ORq83514aRBxJTCC/5o/3wPudSyuKvJ?=
 =?us-ascii?Q?C43Wo2nWk19C/GK3clhQf09HRUIMMwLcLUcV279LC8f5ZzcsZ7EaqcuXQj4F?=
 =?us-ascii?Q?u3cME6UdebR1oXRMFk76zQbtTH462kYlvRBkM6Nd2ZIocrqx0txQouS/pS4M?=
 =?us-ascii?Q?XqrKJlLq8t7/x3B/4kHxJ0QmMaLk79JPl87dTJrSqhSdzni+En3YntnBOCkj?=
 =?us-ascii?Q?RgIfJpU3XY0cHcLFTo5cUO4cEbdsrxgr9HMm0dFqt1s22h9sZOQFE6VlBCws?=
 =?us-ascii?Q?utc0f0zKAmuBDRCtIQ2eOtGyYBo8pZ+HQ6+9Uu4WXeNa06dFsQokweiC06eB?=
 =?us-ascii?Q?1LD0/T0mvmTsM3kJDGuAnfDmcJeSwMAPPwrJ1FFkUQtVny56kzAeAbfheyi9?=
 =?us-ascii?Q?GixgOv9vYukCuX4T8KwTNvrvrXSHezgCjvyy9U3T8Ysan3nEEhCDnG2dJDM6?=
 =?us-ascii?Q?I9gqqP1ndcjcnMpEmEZkhYJV2SASz5WCojtNp3SOxoq1Ez++/FYXx99KFsQL?=
 =?us-ascii?Q?B8nx1H9L0NNZvppr+9nUVCFA0IiSbVpvGI9FrSwopJhf/TXIqyWxyFjdaGWS?=
 =?us-ascii?Q?ay042k/Wyf4pPt2N/7+fVG8nwGKh4rq0CPvxRzl+Po4mY9nfQCs4Vvc+JW7b?=
 =?us-ascii?Q?u+HrDLfcGGB8/6fUZS5dutNTZVAk+HJTk4qZlxjF7eV0+WKxDPA65afBbgsa?=
 =?us-ascii?Q?VNOD3GgZgVnVF3rAabtpPMw73WOsnawqRRD+aMh6dHNj6MTEYteMlykgQlk6?=
 =?us-ascii?Q?CBD3tHkZkY3Th+pqQK3/haXaBVUJgwpQD80dNZM2gMuSoitMvpCDPk32qQ7g?=
 =?us-ascii?Q?PTSv7L6z/yFnGQTJxWAAV1ZHWsAjJykxYH8/sgAJOtliz4po30WVzeuDVaWv?=
 =?us-ascii?Q?BOCemz+PWLhlzKL0c3+UKftW3fQC1yIrAUTYl/6EianjtIxvtdsUgt/01yzM?=
 =?us-ascii?Q?lYYnBFBb+Grosp/J0oGPzL9Fs534Y27/tdIf8HaYYDt9VmhHHnciGme4BHh8?=
 =?us-ascii?Q?hCGwBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16addbd-e08d-45b1-0664-08d9df0b78ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 07:31:01.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KK6vcnxw39G1CDy2azfWeY0OzaO7Wd74VVbf/7kJ3wIX7AgSb7moPgJgCtn5pR49pXifXrALVaa9CYTCCR5yAxR9XLy60EWUsWhyvLnNqxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,
Sajida

-----Original Message-----
From: Pratyush Yadav <p.yadav@ti.com>=20
Sent: Thursday, January 20, 2022 3:42 PM
To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Cc: dianders@chromium.org; tudor.ambarus@microchip.com; michael@walle.cc; m=
iquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com; linux-mtd@lists.=
infradead.org; linux-kernel@vger.kernel.org; stummala@codeaurora.org; vbadi=
gan@codeaurora.org; Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; P=
radeep Pragallapati (QUIC) <quic_pragalla@quicinc.com>; sartgarg@codeaurora=
.org
Subject: Re: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip

Hi,

On 20/01/22 03:24PM, Shaik Sajida Bhanu wrote:
> Add support for winbond W25Q512NW-IM chip.
>=20
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
>=20
> Changes since V1:
> 	- Added space before name of the flash part as suggested by Doug.
>=20
> Changes since V2:
> 	- Updated chip name as w25q512nwm as suggested by Doug.
>=20
> Changes since V3:
> 	- Updated flash_info flags passing according to below patch
> 	 https://lore.kernel.org/all/20211207140254.87681-7-tudor.ambarus@microc=
hip.com/
> 	 As suggested by Tudor Ambarus.
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/winbond.c=20
> b/drivers/mtd/spi-nor/winbond.c index 675f32c..c4be225 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] =3D {
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

This way is for "legacy" flash code and is not recommended anymore. Does th=
e flash support SFDP? In that case just add PARSE_SFDP and let the SFDP par=
ser discover these capabilities. You can keep the "FLAGS" part since those =
are not discoverable via SFDP.

>>>>>>>Yes this flash supports SFDP, sure will pass PARSE_SFDP.

>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a=20
> member of Code Aurora Forum, hosted by The Linux Foundation
>=20

--=20
Regards,
Pratyush Yadav
Texas Instruments Inc.
