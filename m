Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395757E3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiGVPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiGVPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:23:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB589F04C;
        Fri, 22 Jul 2022 08:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaQ6ocA3w9uO64+5wteXU6XGyCJ80UzS26W2GnevXu0KhdElST8RPB1JvOjAvoonDLMidPV4BdY9qicpRf0QlnPP6BykA25oiHf/IWvgVh1U2hzNccL03kJbzGCG6zDoPUhG/JmiEo5b0u/dhgXoz1if48tVUUY01zVbyCHqU6HAA/EjBO8aqbL9xUCLCJx2jKCRh++f9nOB1SmCWiC9ugozJDICDhqWGEF1nSkkzqasev5dpPmJzVygQ/0f7dZ3rMMFk7xBnZrAkQyM+08+xljcxv6duLevYw6qqh3w+jV+hWmCgVqATX4NFirdanhUbKza3H1f6hHitOwG5wgeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSDZkTkXwfVbN/8DsuU0dnWMiTBOzQj8WlfkPA+swgU=;
 b=UYAk2fvQ33CKwHIhnajeWudAK9PGAqsE419GGTi+1oKhlkljxT+HR/xGRU88+OF02+C7ehxUWiXKO4/QxJVkIBDGT/Tp4ZFD4tvmfLq1HxyGw1axZxUkiIbWnZM0lODMB8xQM+XjcniSX0W/hkU3rCsdKJjyKK8XlMD+IfHfrHh1mgjvsoOI2GQHdh5gfRZZB6+ZGnhOwPVReyYvtSG4aFyTUYXyIUppQSYZUERV7ewMqHTTdBoML8S/b+yj1m1ot78XWMs9sijg6iWl6NUl3JHEK6pUZBudNn0KOBko4vWgOh1Xh8vZrSDozXu1mVwzZs0tmRqt1p+fgAW05tmmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSDZkTkXwfVbN/8DsuU0dnWMiTBOzQj8WlfkPA+swgU=;
 b=VAXVqR/t5kQkyocmpOJooCtRLFvipB89CTR6zmTzLgRZDwaPAllbuDx259i3yGeUTSIqf1PmzekHbvxwF46ltEBX+wYyibH5d8Xq7yasnFhqdRSsxxljzYqYb9E05Mug6BwnvUv45sqoqW3Y4wkrTYh7Wra64PGZjpJlmLFl5YQ=
Received: from BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 by DM6PR12MB3691.namprd12.prod.outlook.com (2603:10b6:5:1c5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 15:23:36 +0000
Received: from BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::ed39:947f:6d95:63fd]) by BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::ed39:947f:6d95:63fd%5]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 15:23:36 +0000
From:   "Neeli, Srinivas" <srinivas.neeli@amd.com>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "neelisrinivas18@gmail.com" <neelisrinivas18@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "sgoud@xilinx.com" <sgoud@xilinx.com>,
        "shubhraj@xilinx.com" <shubhraj@xilinx.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>, "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH V10 3/3] rtc: zynqmp: Add calibration set and get support
Thread-Topic: [PATCH V10 3/3] rtc: zynqmp: Add calibration set and get support
Thread-Index: AQHYiSud22fNRODcnkC45HjQDtDBrK2Kqu9A
Date:   Fri, 22 Jul 2022 15:23:36 +0000
Message-ID: <BY5PR12MB4033037009559D6A0BE5571193909@BY5PR12MB4033.namprd12.prod.outlook.com>
References: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
 <20220626070817.3780977-3-srinivas.neeli@xilinx.com>
In-Reply-To: <20220626070817.3780977-3-srinivas.neeli@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2387c310-97ef-44d6-a129-08da6bf625b3
x-ms-traffictypediagnostic: DM6PR12MB3691:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2shCkpwP/JeInPP6k6XyXUDy7SbsH2KDT4t7kYj4mQqYCJ11r+AjuF4neqEtaA/bK/exVgmyvZe0I4pUCcM7jBQsKE5D7M17tHQDLb6AqBOKkQD1085hfhxNWo+o7vsin18INmtCdJv4AYBWWYDYyWKgAfX/WdWP5MVlXqcq3mMUv3t/2qpbzpfhO1xAW3jFKw9YVY/IQL/BE4I7bI9x9hT1YpFVsfwE9j4QdufQHpK3sifYA45790EGpcxbRtN7vMEMtY3lHfDQYp79G+FM2QN0PKy/KWK5z0ItcszEI9dcAib6g7HDHrfuLsLDVIrbcRapm22ABDjsRBLB65/w47LVuCWTUrQfYkdVqM+IMNfm6/9v6BUo3PKPOiQsqNYQh3PuD1o8c/JlnoaSeizfzfYmvgQgdnh8cn5s3oBhGjX3o0TvzHoL4rDM8YUbpZoHVfoutS/oXTiejRFbe6rGjyDRsF/10vjG6hc7x4FQ0WVwtA9njpzmBLAIcQ0VXgdnjo1oEKFpil3nPeAUrwNJ80ZjoRxF8GRykWUK1tBQ71gmsBMn9tEGkmb9Ap97jOhG0XwPbRv+X4ykfoR9ulSdB14tVe8V3ivc1+UJcoq0xb3hjL88vVQtjNKmXVfJaUkaN5u1nWzcyrK2UFgeo3oLDNYASSUQ7yiRLdEAqLDSLrZ60q33sT/7mceqa/uJ3DI4HO/XJOYK5yB1f987ijWvLN4Bcr4LqCphontaF6ZGYaIv8TrJLzOKjAsws1gYZ+scvelhYUX84XJm6asuFWR4znTkuNc0e4JnWzbpe5abfyK10LQpofSvLqlVvIpIoxfm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(6506007)(7696005)(2906002)(53546011)(122000001)(38100700002)(52536014)(41300700001)(107886003)(83380400001)(33656002)(186003)(9686003)(26005)(54906003)(55016003)(71200400001)(64756008)(66476007)(4326008)(66946007)(8676002)(86362001)(66446008)(76116006)(66556008)(316002)(8936002)(5660300002)(110136005)(7416002)(38070700005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BYdIy/u9BBAg6PHY17S2D8Cc3p/vR4FxvH4cFmS59qTbICG9K2rH0e7EL7y9?=
 =?us-ascii?Q?XkFFdZy7Jjouxl4U+HnyzweCx7mH+siaoYo7ix06cJ9hA3ZTm5anfZXoNdLK?=
 =?us-ascii?Q?o28606qTg4Th1BXlwFTPxxruedqM/k7XyufF4w3iHnAmoiUMPiGVdHzmJkkR?=
 =?us-ascii?Q?dgfPiODftukbnTkbj9oQlH9i3kC8vr4jiTBD55jWb4spVUvzsdZbZqphCji1?=
 =?us-ascii?Q?ypAQtxvfYe2pkDhoAFxSrGFgXN7HIEkqOV7LpBxBZG2Ato6DEoxPUFtwV9yE?=
 =?us-ascii?Q?OIGj1YzMy8qqHf2mi83lhEAJPM3gV0dN6/UUAe/QZ3ReutFAlydrf+isaLzN?=
 =?us-ascii?Q?fbDy8Ncf92Lq7PaMIh5P5jdYR0/qjt0jjQE4cggklO1xObD67aMbGkDla1PB?=
 =?us-ascii?Q?lHvU8KXpUAYAlaAbXPxB5rKPQ/quX+5JsN5/mTXmyTBpn9tjaJ4ZE63M9L6v?=
 =?us-ascii?Q?4c7XBYDlq56y0CGYtLRU95EhehoSVkZBPyMFnNLPPro0ns2UqtiI8tW9B1SI?=
 =?us-ascii?Q?yjv1PwqSCsnnQvoc1VgJKaJ5Y7NzLAvv7FXHGq9bAZ+RcUFeADMvg1pxmCM/?=
 =?us-ascii?Q?TxPTwxMZ6dQ6KU7jrIEGLDsN4kg1jjH1fG5esWhdOpGRwcBfrGAinkNleW9j?=
 =?us-ascii?Q?L0QIyVCRyZqSEllHKNlDmJPWHK4C8Dkokc/dvUj31Mtxfu8k/xy2k7QdWwCO?=
 =?us-ascii?Q?q00yaJNj13nC//PW6AOrGj3zADCjRjWaD+P4FfJapzQGy+GhHMwH+QSvRIkK?=
 =?us-ascii?Q?wSjX+k7odNwE1WyPYPsUAFmjwPWdKiBqMTGmOS2Ql0aieKDQ3AsLnlw+fosn?=
 =?us-ascii?Q?asASm53634z6mFMrlNvS96+n3utEjg0/wKD64NqWlLPmBh3tXEKLdZaJEtmZ?=
 =?us-ascii?Q?OwXrsjlO4oiym9Fmz4eiN/kHcFNSEAjjM1z7A8i1wddISUZOcWBh4F8n4eqv?=
 =?us-ascii?Q?db0jDQ7dXJhWzSOSsmRExRK2Fq82OLqRHLTL8AZSnq1L5FYJcW3OlAMwNexH?=
 =?us-ascii?Q?2fe1Ps5qOoVaAup+2G0p3iaEZNqTOLrGFybylToawMg4XW+ffQM0UJRehS6P?=
 =?us-ascii?Q?imwCId4mv38t4v4HdaM7AyElfmZWbZrDL67lWoXkUpCZdb63QOD/BD2rTt37?=
 =?us-ascii?Q?AUfcrn0jjb1ncgDQbQAOJvOCYyMu7fNoamJ/L/Spp3chM1Fb4wEzTB3w3dYl?=
 =?us-ascii?Q?lCMwzeYNgWLzl6Gt8VuraaA7/K1U9xSGd69AUroWUlNYgOj/r15wmnG9OOkA?=
 =?us-ascii?Q?UFyuGYEkYzliesqRkE+bYBFAxOTfUo7dHNJV2Si1TCDIjMq7CDGZgxCyyh4V?=
 =?us-ascii?Q?PR7Hz1d2kamMvqmuBAHIQLpf+Nz2tG30GbANtNK+W3WXbgJbDTUtm0Hr0TSP?=
 =?us-ascii?Q?h4O/mzoSNTRQsssQF2qblc549L1fBE3AYPxLOgC8ip9aEHH7A8NSbcIZzb+/?=
 =?us-ascii?Q?kPqvUS/KBM6qSRKVmR15q+g/hYe6Zhw33TIUSxRBUPxMkxH8errEuNWGKA43?=
 =?us-ascii?Q?6Y8M7MgZZhrMoOKLTwJAAQz2MtOgSq6+QgasY975crHq1e+FfkG1LhPHKUY/?=
 =?us-ascii?Q?Oz75EynV/12FMXfacy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2387c310-97ef-44d6-a129-08da6bf625b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 15:23:36.4533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVDjuHHpLtLH4Z+zi4J39swpgc8wgT6Fe8ql6qlZc9UozTNallx3zv2JFotWqw0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3691
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any comments on this patch ?.

Thanks
Neeli Srinivas
> -----Original Message-----
> From: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Sent: Sunday, June 26, 2022 12:38 PM
> To: a.zummo@towertech.it; alexandre.belloni@bootlin.com;
> robh+dt@kernel.org; Neeli, Srinivas <srinivas.neeli@amd.com>;
> neelisrinivas18@gmail.com; krzysztof.kozlowski+dt@linaro.org;
> michal.simek@xilinx.com; sgoud@xilinx.com; shubhraj@xilinx.com
> Cc: devicetree@vger.kernel.org; linux-rtc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (AMD-Xilinx=
)
> <git@amd.com>; git@xilinx.com; Srinivas Neeli <srinivas.neeli@xilinx.com>
> Subject: [PATCH V10 3/3] rtc: zynqmp: Add calibration set and get support
>=20
> Zynqmp RTC controller has a calibration feature to compensate time
> deviation due to input clock inaccuracy.
> Set and get calibration API's are used for setting and getting calibratio=
n value
> from the controller calibration register.
>=20
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Chanes in V10:
> -None
> Changes in V9:
> -None
> Changes in V8:
> -None
> Changes in V7:
> -Removed calibration default value update from this patch.
> Changes in V6:
> -None
> Changes in V5:
> -None
> Changes in V4:
> -Updated MIN and MAX calibration values.
> Changes in V3:
> -Calculated tick_mult using crystal frequency.
> -Calibration register updating based on crystal frequency in probe.
> -Supressed MIN an MAX calibration values,Will send separate patch in
> future.
> Changes in V2:
> -Removed unused macro.
> -Updated code with review comments.
> ---
>  drivers/rtc/rtc-zynqmp.c | 113 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c index
> 5da33d760419..1dd389b891fe 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -6,6 +6,7 @@
>   *
>   */
>=20
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -40,13 +41,19 @@
>  #define RTC_CALIB_MASK		0x1FFFFF
>  #define RTC_ALRM_MASK          BIT(1)
>  #define RTC_MSEC               1000
> +#define RTC_FR_MASK		0xF0000
> +#define RTC_FR_MAX_TICKS	16
> +#define RTC_PPB			1000000000LL
> +#define RTC_MIN_OFFSET		-32768000
> +#define RTC_MAX_OFFSET		32767000
>=20
>  struct xlnx_rtc_dev {
>  	struct rtc_device	*rtc;
>  	void __iomem		*reg_base;
>  	int			alarm_irq;
>  	int			sec_irq;
> -	unsigned int		calibval;
> +	struct clk		*rtc_clk;
> +	unsigned int		freq;
>  };
>=20
>  static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm) @@=
 -
> 61,13 +68,6 @@ static int xlnx_rtc_set_time(struct device *dev, struct
> rtc_time *tm)
>  	 */
>  	new_time =3D rtc_tm_to_time64(tm) + 1;
>=20
> -	/*
> -	 * Writing into calibration register will clear the Tick Counter and
> -	 * force the next second to be signaled exactly in 1 second period
> -	 */
> -	xrtcdev->calibval &=3D RTC_CALIB_MASK;
> -	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
> -
>  	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
>=20
>  	/*
> @@ -173,15 +173,76 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev
> *xrtcdev)
>  	rtc_ctrl =3D readl(xrtcdev->reg_base + RTC_CTRL);
>  	rtc_ctrl |=3D RTC_BATT_EN;
>  	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
> +}
>=20
> -	/*
> -	 * Based on crystal freq of 33.330 KHz
> -	 * set the seconds counter and enable, set fractions counter
> -	 * to default value suggested as per design spec
> -	 * to correct RTC delay in frequency over period of time.
> +static int xlnx_rtc_read_offset(struct device *dev, long *offset) {
> +	struct xlnx_rtc_dev *xrtcdev =3D dev_get_drvdata(dev);
> +	unsigned long long rtc_ppb =3D RTC_PPB;
> +	unsigned int tick_mult =3D do_div(rtc_ppb, xrtcdev->freq);
> +	unsigned int calibval;
> +	long offset_val;
> +
> +	calibval =3D readl(xrtcdev->reg_base + RTC_CALIB_RD);
> +	/* Offset with seconds ticks */
> +	offset_val =3D calibval & RTC_TICK_MASK;
> +	offset_val =3D offset_val - RTC_CALIB_DEF;
> +	offset_val =3D offset_val * tick_mult;
> +
> +	/* Offset with fractional ticks */
> +	if (calibval & RTC_FR_EN)
> +		offset_val +=3D ((calibval & RTC_FR_MASK) >>
> RTC_FR_DATSHIFT)
> +			* (tick_mult / RTC_FR_MAX_TICKS);
> +	*offset =3D offset_val;
> +
> +	return 0;
> +}
> +
> +static int xlnx_rtc_set_offset(struct device *dev, long offset) {
> +	struct xlnx_rtc_dev *xrtcdev =3D dev_get_drvdata(dev);
> +	unsigned long long rtc_ppb =3D RTC_PPB;
> +	unsigned int tick_mult =3D do_div(rtc_ppb, xrtcdev->freq);
> +	unsigned char fract_tick;
> +	unsigned int calibval;
> +	short int  max_tick;
> +	int fract_offset;
> +
> +	if (offset < RTC_MIN_OFFSET || offset > RTC_MAX_OFFSET)
> +		return -ERANGE;
> +
> +	/* Number ticks for given offset */
> +	max_tick =3D div_s64_rem(offset, tick_mult, &fract_offset);
> +
> +	/* Number fractional ticks for given offset */
> +	if (fract_offset) {
> +		if (fract_offset < 0) {
> +			fract_offset =3D fract_offset + tick_mult;
> +			max_tick--;
> +		}
> +		if (fract_offset > (tick_mult / RTC_FR_MAX_TICKS)) {
> +			for (fract_tick =3D 1; fract_tick < 16; fract_tick++) {
> +				if (fract_offset <=3D
> +				    (fract_tick *
> +				     (tick_mult / RTC_FR_MAX_TICKS)))
> +					break;
> +			}
> +		}
> +	}
> +
> +	/* Zynqmp RTC uses second and fractional tick
> +	 * counters for compensation
>  	 */
> -	xrtcdev->calibval &=3D RTC_CALIB_MASK;
> -	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
> +	calibval =3D max_tick + RTC_CALIB_DEF;
> +
> +	if (fract_tick)
> +		calibval |=3D RTC_FR_EN;
> +
> +	calibval |=3D (fract_tick << RTC_FR_DATSHIFT);
> +
> +	writel(calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
> +
> +	return 0;
>  }
>=20
>  static const struct rtc_class_ops xlnx_rtc_ops =3D { @@ -190,6 +251,8 @@
> static const struct rtc_class_ops xlnx_rtc_ops =3D {
>  	.read_alarm	  =3D xlnx_rtc_read_alarm,
>  	.set_alarm	  =3D xlnx_rtc_set_alarm,
>  	.alarm_irq_enable =3D xlnx_rtc_alarm_irq_enable,
> +	.read_offset	  =3D xlnx_rtc_read_offset,
> +	.set_offset	  =3D xlnx_rtc_set_offset,
>  };
>=20
>  static irqreturn_t xlnx_rtc_interrupt(int irq, void *id) @@ -255,10 +318=
,22
> @@ static int xlnx_rtc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>=20
> -	ret =3D of_property_read_u32(pdev->dev.of_node, "calibration",
> -				   &xrtcdev->calibval);
> -	if (ret)
> -		xrtcdev->calibval =3D RTC_CALIB_DEF;
> +	/* Getting the rtc_clk info */
> +	xrtcdev->rtc_clk =3D devm_clk_get_optional(&pdev->dev, "rtc_clk");
> +	if (IS_ERR(xrtcdev->rtc_clk)) {
> +		if (PTR_ERR(xrtcdev->rtc_clk) !=3D -EPROBE_DEFER)
> +			dev_warn(&pdev->dev, "Device clock not found.\n");
> +	}
> +	xrtcdev->freq =3D clk_get_rate(xrtcdev->rtc_clk);
> +	if (!xrtcdev->freq) {
> +		ret =3D of_property_read_u32(pdev->dev.of_node,
> "calibration",
> +					   &xrtcdev->freq);
> +		if (ret)
> +			xrtcdev->freq =3D RTC_CALIB_DEF;
> +	}
> +	ret =3D readl(xrtcdev->reg_base + RTC_CALIB_RD);
> +	if (!ret)
> +		writel(xrtcdev->freq, (xrtcdev->reg_base + RTC_CALIB_WR));
>=20
>  	xlnx_init_rtc(xrtcdev);
>=20
> --
> 2.25.1

