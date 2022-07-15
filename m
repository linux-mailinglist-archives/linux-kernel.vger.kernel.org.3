Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036A7576484
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiGOPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiGOPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:36:31 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6763655091;
        Fri, 15 Jul 2022 08:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgDvHQxlNp/DQ62JEHLCxAUdhedPRRcBes8hNR6JPLzsTUnZjBp4VEHQMXlhDJUxKtIuIkVCoFOPSurMPLUDes6W2Ta8k6Fs2+IQCn4GTLxTWkokkEYU88KB+2EQKzkYu+cVP8cSwiX2a5RtLzNNkRlfgAldDOWwkbU0MObwNQPycK0Y9fJsMJG+h5OfbYre5BjdhVJCCGHwu53sdK9ICTCYErGDWd1uPDm+Kv2PTQzMHPcvCICpaS/EXJr9iuTUjumDlt3kD7lu1ml7AbucbxVYLnrnG3pO6woERsADFlMlu4F0Rfycx2rglzblCb/P837AL8UjDB7pTLV3S+jl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEnDKXwHMiQtef28w+sZKEDLQzVOMg9VaLmuUnp8lH8=;
 b=iOio8FpZiNQv3D7WuN0fIO766op+DPy9q3njYm+Gdp73D4OewgtNH5kZmtoyXRFryHSg6tmI8mP7phyJP+fJ7cbq/UfbW0ICkZNLnm9TStBcL4XYVbYYQlvPwBE7OUQyt316IMB42EYlTSoQzcpR5ajenLSWuoWawOh0cSlh65Ehfkx2FiJieJe1npKFg7lSo6+sINshflr3EVkkDaKgdUeMFGy2jMZVsoNSoEbMv4dqLnYWH0XjgNM1bex7AfWaYOPZ8XVNFGsHpDnokRZm/43WsgYDH99J6CVGZmf5liUlutvF/CyDN/dxV9AHa/uZL5eMywEYvLYtiabiJ45ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEnDKXwHMiQtef28w+sZKEDLQzVOMg9VaLmuUnp8lH8=;
 b=GjBtdoWKU8syj4bwwnOhEK/SKbTPROm9G9LzFx5n8nfxhU4FBNxFLs519U4Aj4QvY9hWMCXv19oQQ8N9S0+CsIBBYAilcE54teofHTu2ABUI2Am1hOqzQajgrKyPCnWq8ira63rXsLKHrc+ypiiXHkyUeXrNsi7RZKKso3TFJjQ=
Received: from DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) by
 MWHPR12MB1325.namprd12.prod.outlook.com (2603:10b6:300:f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Fri, 15 Jul 2022 15:36:24 +0000
Received: from DM6PR12MB2809.namprd12.prod.outlook.com
 ([fe80::fcd1:f8aa:6c69:eacb]) by DM6PR12MB2809.namprd12.prod.outlook.com
 ([fe80::fcd1:f8aa:6c69:eacb%5]) with mapi id 15.20.5438.015; Fri, 15 Jul 2022
 15:36:24 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Subject: RE: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Topic: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Index: AQHYeZhXApErq+32kkmuJFVVfXogSAG7F8aMAeAoVR8BtmPI/ALXxyQSrJxOXKA=
Date:   Fri, 15 Jul 2022 15:36:23 +0000
Message-ID: <DM6PR12MB2809BA6D4F94EA59E76E6576DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <40110ff8-5c19-bc54-759b-a51a919788eb@xilinx.com>
 <Ysw5MpvjKM5LKvWd@sirena.org.uk>
In-Reply-To: <Ysw5MpvjKM5LKvWd@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8217ced-9fb9-41df-d0a6-08da6677c646
x-ms-traffictypediagnostic: MWHPR12MB1325:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BI7rVEnq2FQO5MUIAzR/uqqI4oY6Rl69/LNYW23MHI3obV69DTNLpUC3zoloP7KSFUoToWK220wUZ4FG7sjxPWutcJNaQxOMCF4OgaZXW2UB4/PTdCkUUkKg4SE/hvIIYsViwoHbTMPKs+BwBWybHccNsWYS24/TBTPVkI3GICtGb/6JBUrK2WlF7kFMVN++GErthgrYDEf/OD3apzxwx75MwD2djAG7qiOa0WAthxVle7u77zCN0YxHKoSsRcgk1vqNAHPho10GLwflawGjpokYQE73vjcqfTBhmEtngK2jsLwQ4bo3fSIHW68NUwhWxyfGpMYhrT/TkJ03/JKX6JEjFpGNAi+PoVvDX5KmlWC+/1t6hnl1vCE9zhSHlZ9WtaD8pAmj615n+LtiqD1W4WCfMY0TYmrpepfUG49TzzIO6UDTLRdmlSCBZ9HRqSfJ0xId/iD8ZXIGD3b0Ywy9BYhwBWmDO13xetDmOXSU4ZpbltVYyDRxBFG5SGRbF7ymUHBTVKQu27qFY0tYZMGQMoY4YtmG3yK6F74QUXHz4wzANKeTYOgGIPH1d6SU9kdn0xP0XppMPioUo0M3adAkecPPwGc9DonO5QQ2slwMNH8uQhwsjYeA4kl2I1r6gR+NThaeiSb5ZoILmbf1juYbjyzbmS8O1Odikl8RDDkDp0C1OOli1wF/K12V3ice07KstmAsVdU8inWA1VGWG0b4ysIGEFPdYp4IA7ZYUtK7KEDYuvRdUTEMqC5faE3gOZgcMaNFKDGaDPXLNJeAeI3M6nYr9gBz2lgW0xvhYt9LqrCpVhoNbfRXIi6r/0yxATU7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2809.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(4326008)(83380400001)(55016003)(66446008)(64756008)(71200400001)(110136005)(8676002)(76116006)(66556008)(66476007)(26005)(54906003)(2906002)(9686003)(7696005)(66946007)(53546011)(6506007)(86362001)(33656002)(38100700002)(5660300002)(38070700005)(8936002)(478600001)(122000001)(41300700001)(52536014)(7416002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uQGWjl/8Pi7n+dNv3G2TidaoyfyzaWXyj6EmUnJlDcBLmO6Fre2u+axNyjBv?=
 =?us-ascii?Q?LYN+07Cxffm/oVzSzd2WXCW8FEomABc52V6ZlTztc3gklgQSoBGaZ0EYX9Cd?=
 =?us-ascii?Q?ZS1zCDFgGoJjUyhfhQoOCRuBZLNzNsJ9BaaGT/zg/NxLTFBWV0YqIsPOztgs?=
 =?us-ascii?Q?G4TA5tjpQbz0z1WUHTTKbH1NyQE2XGmVAWTp/aesKXnUtsZKLva+l5rKTx7g?=
 =?us-ascii?Q?2YIq39n4OmNfRc1a6/FIT84GS6n339a6PREKOYz//akV/eil+vemSboJgZ/v?=
 =?us-ascii?Q?WYVD0bpkF/8CHR+byo4FTkH6xEYUXgepxpWlM5zP/G3ixaOgOs8fwp5m+Uw6?=
 =?us-ascii?Q?gD4wM8jp2C8Pz5k2znbZoaBsOEk4HR+PL2mjyc57T1PtJX9eDaGk3/q7Maqe?=
 =?us-ascii?Q?P0Fz7LyG1ONhj+f8S1ggqQHtJsPSkTpsJDBfUDH3QU839cAFP8Zh9L4JcD6v?=
 =?us-ascii?Q?BiMxix+icikqkfQPLW0ZHFHvDHRmV6XsRnSv/vFctHtx0pbilG0HzKfAsu41?=
 =?us-ascii?Q?vcvzqaBdV14OVlJXkvp9cxV2GU9vQOkm6OcqPsU4PTA+jZPEjM/FJvPLMIm/?=
 =?us-ascii?Q?bEVSL31oOYCOgG1lSdbl5SuH+WeJ5ztZ438yjaDbSMEiRzwUyrh8uYLbav5A?=
 =?us-ascii?Q?FU7k75Jkn7KFyAzYnv6A9CY/S92jtOF0X0lTpDtv7bjWADTAT3ztMfEcnbvB?=
 =?us-ascii?Q?b4VSkuXbh1sT1hc1EiN3VHOX+6VH48wv6MPZaFfW3tdJIc4wcJrCe2EdRN0V?=
 =?us-ascii?Q?tr+9W872XbcE0TWT0RM4ordNb9gpptmqxdCfqWJKOW+nHBgWzukPsE6zzNQd?=
 =?us-ascii?Q?AQ4PFz6Kh1ReDho0U+7b2vYgwO7DWO9phl91el40bYtjOM1kDevWAg1oK/7r?=
 =?us-ascii?Q?ZELeUd4h+KZdoYSjnWdho9RnkVQY9HHRQHIAlZ9DD2vHYOlxE11YZ1m0wVkM?=
 =?us-ascii?Q?DXGDToOFWziYLYH+BAK9MY9lch7fG8VSHlMjC9J2DvQ748JZOCfpBI3F4cPL?=
 =?us-ascii?Q?MVp4AGEiendEUG+tN0XJnh8Iduva9ZTt6QFhovtFSt1ZAZTzO7/Tb0Upq2Z7?=
 =?us-ascii?Q?6WfoY9VQ0CtCk64jp2S8jtoVop9NVm/IlAK5qoisYY1XzwKWtMeUAQupYSBc?=
 =?us-ascii?Q?MUiEOUmcirNBA/JZxMIiSTg2XmlQIPo2yZ2g5QhmBV4EeaGt2KQLdcdeUJNB?=
 =?us-ascii?Q?IsRzAgg3xQfdkI5wm1tytqqHZW80on95J7dBp0NcuVCl8wp31/OXdAwUPNIY?=
 =?us-ascii?Q?Idzhso8yJjJhi6l/MpwiuiBZvYbd7GQYVcklFKwBEMIIvhjVpF1F/AX5fzSN?=
 =?us-ascii?Q?Z+TIF1KYHBpK7IPX/DEmvMRkaDw619UfGEKRY6fUAwgpvHqoQEIdXmowBDKZ?=
 =?us-ascii?Q?yFqEHksIulC7QvzENmZLb8GwbdSmlRv1Ax4PxNbR4lYah2Y87fbYk/3wKGic?=
 =?us-ascii?Q?/Drwujw4FTuTOImOT0gYEMhsXtN1I7szrfKTQDyeU2pvF6YigsKROnM6UZ1+?=
 =?us-ascii?Q?JGFzpYLzzT3lQQFkOkq6jhXmfO6oCaqgRUZwAxvT3mUXsHPmZtp/kr2ASsK/?=
 =?us-ascii?Q?qAsJHnnFNn5B/AyS+/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2809.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8217ced-9fb9-41df-d0a6-08da6677c646
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 15:36:23.9548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ey4ePu/UXhVLwZmC3GXUwLJCyZ49kxaz7T6Kwphe0STYA+8r4dglpCphU6dJrgYm0hikTPMfDnQHdSqza9wU9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, July 11, 2022 8:23 PM
> To: Michal Simek <michal.simek@xilinx.com>
> Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; p.yadav@ti.com;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com;
> git@xilinx.com; linux-spi@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; michael@walle.c=
c;
> linux-mtd@lists.infradead.org
> Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SP=
I
> device
>=20
> On Mon, Jul 11, 2022 at 02:47:54PM +0200, Michal Simek wrote:
> > On 6/9/22 13:54, Mark Brown wrote:
> > > On Mon, Jun 06, 2022 at 04:56:06PM +0530, Amit Kumar Mahapatra
> wrote:
>=20
> > > > +	u32 cs[SPI_CS_CNT_MAX];
> > > > +	u8 idx;
> > > >   	/* Mode (clock phase/polarity/etc.) */
> > > >   	if (of_property_read_bool(nc, "spi-cpha"))
>=20
> > > This is changing the DT binding but doesn't have any updates to the
> > > binding document.  The binding code also doesn't validate that we
> > > don't have too many chip selects.
>=20
> > I would like to better understand your request here in connection to
> > change in the binding code for validation.
> > What exactly do you want to validate?
> > That child reg property is not bigger than num-cs in controller node?
>=20
> If you are adding support for multiple chip selects in the driver then th=
ere
> must be some mechanism for expressing that in the bindings which I would
> expect to see appear as a change to the binding document.

Thank you for the clarification.
As per my understanding we would not be needing a new DT=20
property for expressing multi chip select support in the driver.
We can use "num-cs" property of the spi controller for=20
broadcasting multi chip select support of the driver.
If "num-cs" value is greater than 1 then the driver can support=20
multiple chip selects.

Please let us know if you have any other approach in mind.

Regards,
Amit
