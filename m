Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB75A60B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiH3KXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiH3KWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:22:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87958B41;
        Tue, 30 Aug 2022 03:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAnB9vAO6q8AC+VHh1KGLr1MCxeZJz4ZJgqHkN4M1sF7IrQBwOxhAdQuUD//8Lz4sicdHeyeirBZCjs8lME1icFXMSQOnQ5iYdEYP/r6aRy5k9Caa7QTcyOVy274PLaERqDC+OrCn8xHy3C4z+cZzscwKTXG1ByaYaUN1Kkp9B2Jhm/4lyyiajnTgwmZoocQeMWdZ6shaYf/AIp/ly5yDWEbJ22eafnr5jEHJzboEQeOmgCtrud2OPtF3xGYPfvAoPhsZ+o94ykStHf2EW+Vcpsu3SAhyBI3LaCvLv5QL1k8VFT8Hejn4PH/N3co9WMspemkjcNOrvjhfg0o2aUgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2lzMTBJ7AfOH6kO8n2PWxBbG3D1Umde/BqAfoKycLA=;
 b=kB0nhdrfAm0EGGzRQFlv46dyw4dj5GHtotcMQWwE9eVbYWjOVQeOF+VDaiGHzF0I++wncLme50nOXISlXmxXCCDrO0bYqItScftENOKM0oc2o8Fl1JDA/CmeOwOLUmHziKNi6AoNBDs6r3hRQjJwM+FZyMr1VRtlEpuMpMakYSFmD+ImTohepQDhDou1yEccvS0KGoYany2V7mFSVG9DXS7dBeo/Kltfq0oBSMoWmKQAM+JKg1lQQPsTXDTislxhG82YYAtFwW51QVJgBC0nVoHNgURYPffSJ+d4R8xYYalDILnRk3iJtlx0lXtBMBf3Xw43o+qoRdHCoFH4wfSb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2lzMTBJ7AfOH6kO8n2PWxBbG3D1Umde/BqAfoKycLA=;
 b=cwK+u7c9HPo52T2+5quaEdhauQ7g9OLvG2+N2Hilf5twrseDCWSQuD7W3d3BlsEJATn/OWMZwd9FHD/tfLl3JzoOqpc29GRrnvFILmjgedH/g0cxNsuH81j90aGENfTAPvfaaDbv/vhiKMTf7yBOYbh+v6EUBj6efm8UsUdEz5I=
Received: from CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 by BN6PR12MB1811.namprd12.prod.outlook.com (2603:10b6:404:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 10:22:08 +0000
Received: from CH2PR12MB4264.namprd12.prod.outlook.com
 ([fe80::79bb:53e7:f1cf:840d]) by CH2PR12MB4264.namprd12.prod.outlook.com
 ([fe80::79bb:53e7:f1cf:840d%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 10:22:08 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Thread-Topic: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Thread-Index: AQHYu4bSUGIrY8nYfU66nbvPu6SLyK3FpnEAgAAQlYCAAVDzAIAALXQQ
Date:   Tue, 30 Aug 2022 10:22:08 +0000
Message-ID: <CH2PR12MB4264DD83557D759B8EC8EAD8DB799@CH2PR12MB4264.namprd12.prod.outlook.com>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
 <be7f0b7bbb25d86ac079502babbf5f1b@walle.cc>
 <BY5PR12MB425817D90687D37ABDC638EADB799@BY5PR12MB4258.namprd12.prod.outlook.com>
 <c7fd841b2244cbe60e174be3babb1607@walle.cc>
In-Reply-To: <c7fd841b2244cbe60e174be3babb1607@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64b97130-7346-4ff2-f882-08da8a717e9d
x-ms-traffictypediagnostic: BN6PR12MB1811:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kJpeD0EkudwyfqtNHfKe4fRM5Zr8TggK6kC69hCyNOGDngLWBbM6sFfCkNImrmWNMKneYKHVgJm36Z8HNxcNLsbYQvVhOhXRvyDZtrd8Ta61gxfj1GBCagtnpgD34410O41lgTSjC7+SyymPLY9PDz1Zlsf1fjIqvqYVWf42Z9gn9VwNx8CY/NO1Fny68+zotmSQy+E0nzVBjMZ795WBAqPqoGOvtMhcqyPdZsnVxLWa/X6QVfTy4j0UCOzGk3cC7DbGNAlm6TAQBFDlUmPRET12piwIjmy3gqLZ5rBMCnn2jwJ/wZNgGLXErIBn7jRL0+Q8PuBti0egbZKNvtWvQ513+Z0aUtfY7PRtZb2yvTnz1Y7S+PHMWTBinWUH6WLEIoogAEOPSeJkG17fuicXGLh9maN2tjxz63cmkTTBPz7Ag3pCxFuAxo1B9lkNJKTRJUN4ZOJTMuKv5o2Nouftwf9DVjIbB7TMRZ4DGXOi1ARJqgpKsh02vSY/Ak1Xqdx1SVVkFbfJBH4d0eao46gX5BVBTTm/TG9sgXAbuQhsiWZ/A5fX0x6lRm4aWHknqjB7LMHfrNN26zUEGZ0x+r8ZFkzxzCmTI6W2l8KLeU4/GmfW6zG8kF1bbkTr3V+iZuFonsvGyGXdB6aCXsuz+ftIgC6ni9PD0kjtwEF5uyiPGOD3gvBsSYTEissutoeQPnJQfGeDAr5Zb6PsvvFLZTYcYNSEfhwMu17uKPU7uylFI2RHZtL5jrvwP5rK2plQMCIldg7fBO+zm5MZxmukBIBEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4264.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(122000001)(6916009)(316002)(83380400001)(38100700002)(54906003)(71200400001)(478600001)(76116006)(64756008)(4326008)(66446008)(66556008)(8676002)(38070700005)(66476007)(41300700001)(7416002)(5660300002)(52536014)(55016003)(86362001)(8936002)(33656002)(7696005)(6506007)(66946007)(186003)(53546011)(2906002)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIbxZac4UCdinV0w/F5RSMgOtJO/Jn0x2MpCcvMIclO1Sn91+ucjM9FsFW2s?=
 =?us-ascii?Q?XPhW4QTa8urKU/8aoDcu8Lu/bjavcKvjgjlOGhHyowTfGil0opXv2Xr03Bsa?=
 =?us-ascii?Q?TroSzvCwbsGySPq/xw7vXKbW9Wy9cV56zHJyCdm7+n/Hde4wrUJiAa9DF+lg?=
 =?us-ascii?Q?sUhbse/ud15NVqYs25xsjiFDQsonyDD7280trln1nieUP1MWnOMI17TKXJ2n?=
 =?us-ascii?Q?PXrQqF5py01HpdBUayvnBh16Go9lzZ40m+saR98MgFw6/4q/GoBKTy4XMenU?=
 =?us-ascii?Q?sLljI8Q/iwLPOi9SNu2wvVYaZ7dD4Dj+YUTBYJmJ+M6+ZKyxQSQwOYmP8feA?=
 =?us-ascii?Q?SMmqIWmND5UAxXqrMohS/JtKijmLYaxAYAt60T7PvtU2pD9tmMUj2VG0D8lT?=
 =?us-ascii?Q?8Oah7ykncUxoGZYAIri6zGjYvWQLS5WbqpmC8bHThfDOLijqiFO/sUqYyQAM?=
 =?us-ascii?Q?2IV3hTqtKKzSS/6UuPVeeMhber8qCO6nnQ1gels5BYlSCLW80R00P8ug7A19?=
 =?us-ascii?Q?2Q4RpSzXB0uN5zc7w9yKn71SK2VVT8KBJOKxF+gXV13QZfaqcMpbkzrTu7Nh?=
 =?us-ascii?Q?BvvkXN0+VuHLpwU1xNYeRC/7hXosxOieIGMya+JanhHPOEthlkSs72tE6k1B?=
 =?us-ascii?Q?jA2WFwC5B8FjXUSlsHoinMmEIY74/8I/APhLDWH1olVQuW9K6wYGcqWZTzba?=
 =?us-ascii?Q?ujZ4OBRH4XuKL2Qh7i/THcjptOnJ8crx1ws6C+kqWPTyMENN9SBwBzwT12sW?=
 =?us-ascii?Q?SebsJdCiqN3Pb2EluOCVegHjCY/eCsifw2lUx00qFr/zeLwFGzWlCg2Xf8I8?=
 =?us-ascii?Q?+6W6QtyHJX+EHTItG031RCzZGQggik5LjpTOreXS3chqcx9w+rAFqG6GPDNW?=
 =?us-ascii?Q?ZQ6/WBFcKEDqpO4V1M+y0XWve6tq2tbaj/PZMPjha2L37vpL0e4VNAhBMu3L?=
 =?us-ascii?Q?I5xweYaUqkU8oDeSEu/AxfEHIpu1/+BrYNVlTkjQID4xlNR+nWrrpoUdkT7E?=
 =?us-ascii?Q?TigFQR+RO1kK/6EhZjGBwv4SqA0Fb55PzpQGgCx7GIM25/kTux1py1LgAgkJ?=
 =?us-ascii?Q?zdFAy+CNtO+wGBxdSibZSR4XUwh9R4ZnxCTzKQx0kLOqf+WZnjJ2gbz+6x+u?=
 =?us-ascii?Q?KPOaeLBlTj7TeoUsfsYJKLbs9YhilOjbwl4AJpPs8P8gCcyWe8ISIT3tf3sI?=
 =?us-ascii?Q?Cp+CFXeqHZoZ6FEeP81rtzMM9PbxOZbKe0ETh4kK8X4cTzyVYNFxEWBzEn86?=
 =?us-ascii?Q?PdYBURQVHzaz2cfjDq0yjAOUElmlB25G6plFX2uIzeWsW2dHYXxPkSrOQ/3E?=
 =?us-ascii?Q?Pv9AM0nXZuMgg5Y8PsxmA54+fTo1Qzyhl6yc0A4glEO1UasiKKqlH1Z2OMLX?=
 =?us-ascii?Q?Frt7TH/L6e5UAnPos4CybOaAVXJLveO4hfbtmCx1gS/PSIBPoCZvIFQkduie?=
 =?us-ascii?Q?cUg7yhuxfLN97n/daP6VQbgUz5zek04NQhL+H0IsM4RnkgtsImaQE/N9WZ7c?=
 =?us-ascii?Q?bva0fRma7O/5UBDHgVayAi9NrRe2tHgcr+XZwdRwlcURk7+961Sm4/Q/1+dI?=
 =?us-ascii?Q?TL01J3QNpuX9HbBqLT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b97130-7346-4ff2-f882-08da8a717e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 10:22:08.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pc1xScnzgSeuHd3TNkatyBNgvApQL4oeaYljS35Zn+vBMsam8lJkPLuXmr+/Sb8+OHhUmuZQFG+o723XLaseAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1811
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, August 30, 2022 12:40 PM
> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; Pratyush Yadav
> <pratyush@kernel.org>; Miquel Raynal <miquel.raynal@bootlin.com>;
> Richard Weinberger <richard@nod.at>; Vignesh Raghavendra
> <vigneshr@ti.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; devicetree@vger.kernel.org; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org;
> saikrishna12468@gmail.com; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
>=20
> Hi,
>=20
> Am 2022-08-30 08:32, schrieb Potthuri, Sai Krishna:
>=20
> >> > +	if (ret)
> >> > +		return ret;
> >> > +
> >> > +	/*
> >> > +	 * Experimental Minimum Chip select high to Reset delay value
> >> > +	 * based on the flash device spec.
> >> > +	 */
> >>
> >> Which flash device spec?
> > I referred some of the qspi, ospi flash vendors datasheets like
> > Micron, Macronix, ISSI, gigadevice, spansion.
>=20
> Please mention here that you've looked at datasheets of different vendors=
.
> And maybe instead of doing three comments, just one and then the reset
> sequence.
Ok, I will update in v2.
>=20
> >>
> >> > +	usleep_range(1, 5);
> >> > +	gpiod_set_value(reset, 0);
> >>
> >> Mh, is your logic inverted here? If I read the code correctly, you
> >> should use a value of 1 to take the device into reset. The device
> >> tree should then have a flag "active low", which will
> > Reset Sequence which I implemented here is high(1)->low(0)->high(1).
> > By doing this sequence (active low), flash device is getting reset,
> > this sequence is tested using Octal SPI flash device.
>=20
> How does the device tree property for your look like?
> Has it the GPIO_ACTIVE_LOW flag set?
Sorry, I misunderstand your initial ask, This logic is developed by keeping
the GPIO_ACTIVE_HIGH flag set in the device-tree. Agree this will violate t=
he
flash reset sequence (active low reset).
I will update the sequence in v2 to match with the "active low" flag in the
device tree.

Regards
Sai Krishna
>=20
> -michael
