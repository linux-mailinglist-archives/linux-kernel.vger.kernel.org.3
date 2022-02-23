Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AB4C0C94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiBWGda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiBWGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:33:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A260CEF;
        Tue, 22 Feb 2022 22:32:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGThPLqU8fNQrQOumQXCxFCBukRG2h1Q6TRouCvI+uTYqXq5b/Ip0KHydIgZQ3bQdjqcDOJIGFdv6965jWeFhZjVLNKS/yAs9lVzasSeKzQE9mSru6JmPwSIjOf9d/YWxxDzLTN7jijPcRmUX8kHRmc0ATV5v9VaVYvfQJrxFKuMUxlgT0wCJG+rsRBSIlKFt208Dbtyv61ikDINz+Mz+XxgalsUhe/1F4jhv5SDNJDWZ+TUxm0YdnpPWtQT1UhDRr1cTTXDL2uPBRYQs7nbnQacRnTWA4qWZ1jb5VrG01UWI0EErB0yjCzyFK5oqVKsdugXjqFdG0VQs1nt1Vfctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaf3dIwchCmazMeq+reJ/Y6gWpJWEib4lk/7iUnJqJc=;
 b=i3aaeDChzgXMI4PYCZngbN+XhVNnWcCUzK+dppSwYquGFY44V0jbZRnRsrghWPswj2d5JiFOv/9tCA3GlLWHc2KB1rt7wwAoZ0txC9NOKv5U0Qp2EcwByb8w2hQpihyXfpfvghWhdSQhwEEQ2J2p5sjY2DF3uN4oR/7swP9Kegef2TIjOxQTK09IGnRSZSIYJLYV0fwrpnsf6b4UofwqsJlms2st8TL3ZEqOPlAB+CyjeDUAy9xtJTpOFpZRSt5OO0btnzJKSNEvfU8ppkAL3wWT9AEcClLX3NIByZz8NkzqvRwRphgZ/AZd22k7gtktLJfeCa2IcL9+T4uWiNWTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaf3dIwchCmazMeq+reJ/Y6gWpJWEib4lk/7iUnJqJc=;
 b=GShElrJPyLcIzoa+Jitctg7mZTbjGVT91/zRU0LTnADtE8I+ZuZB88gWaMYEmztoHlfItgnnuNPWoXdU7tB+VeWymDd8ADuxA4lD5bU9v51ZEYYRz0yGysLO0Hcd1LohoSLzngBLWkpSeoTaGqNRRGFY0PSc28dxIPI3gr9nIRNBnrKHBrZuo9q8wYNmG8LpBTj4P1sFG8FfX5SPkIbIgKbq0ntGu5YTbSrK8y1KQVSq/MdxAJ60w1vvXse7eS1Aig5jX2a40zKvjosuIiqXPdFU9zO0tftdIRyq5WMAVuOIITrPulez83Dya0At8WTLRlxKV0/3lIRlWCCi1PhrJg==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 06:32:56 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 06:32:56 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Subject: RE: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
Thread-Topic: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
Thread-Index: AQHYKBWa+O2JqvcM5kOPguoIZ3KOyqyf5iWAgADIESA=
Date:   Wed, 23 Feb 2022 06:32:56 +0000
Message-ID: <DM4PR12MB57693F28A727964ED67BBEB4C33C9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-5-kyarlagadda@nvidia.com>
 <YhUtQ/8Kgcx4OY4S@sirena.org.uk>
In-Reply-To: <YhUtQ/8Kgcx4OY4S@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f564733-0d80-4a0d-5c57-08d9f696541d
x-ms-traffictypediagnostic: MN0PR12MB5956:EE_
x-microsoft-antispam-prvs: <MN0PR12MB5956135619E0E989447961EEC33C9@MN0PR12MB5956.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZFVEovmtpXu0bZD31AnxQm2XydC8TUG1wcUcz2RKmHlyYfGbJvhN0WqswK+GeS3iq6ItiCnNfTlrk55lPwPhdmARkw/UJN1z+1V+t+Fnok9pnOs6SvGPNxO5EzdSVpy8JExXM955GxfgDSQcNDVsK/6YAGF+R2+k6XQrROPBvGKsRknV/YZKOvgSjAVT4WCcOCQYCYLmweq6HBG0wHvZW8AfXvyoPbfce7O80cbkPkleQcsip9s2g+6EgENEaCAy3/0Lw8hExjWJDIoq4PecEioy44MQzdG7GgoykJjYQE3m8nttnvmGTJsAUDYF1JsU8q7ciqNhLOuYQgwRqFCEHq6bwNJbW7O6DnSHBu5x75gl+ahs6TLZZP0qPk1CcB1aF+rIc7iQVXo4vL5da8RiGQiRIk0r72KqDbCDuRqziEOv55WRJTc8vkJ9V4qBbEtYfwcVZip5VDUeQu4nkyiI6NprFWiTYVDirfa8bScyhgrX1opRgNHY0Psunh7875Ao2bqhF+zIqBayCGYxWp29kh6iQYoPHWOGxr1/qpNMUwKynhrJyJGwlJsFN3I9b6au+xfksUQRSRefwJ5YBhjOqDrj2O/cXjMyehoO1ykv4lUWrHMaHp1j1cuAkHre6M3ifcmWcre2MrGRkVeb9QavdUh3zuJjbG0ibqUGlEl6XkTY5HkK2S+DcY3QetfgUIksTWyyRLqRVJg+iAM7eZnuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(53546011)(71200400001)(186003)(26005)(66556008)(66476007)(2906002)(66946007)(76116006)(6506007)(64756008)(9686003)(7696005)(55236004)(508600001)(4326008)(52536014)(5660300002)(8936002)(55016003)(86362001)(83380400001)(33656002)(6916009)(316002)(54906003)(8676002)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6gZdQaQOdB+PNqkHaFT6+kOc/b1Z9kwmG/M+HWOa8iUq+MaNYQOmCpFJibPq?=
 =?us-ascii?Q?kRz+5xeSRg8cKGaPky37SdN9166W7eK3YeRBA370ZPq0PlUhfG9svxy049bu?=
 =?us-ascii?Q?HpLTU55kE1x8D2yyu7J9hksFhve5YfcUbusCH5Je0prrDkkzob8gEB55w8J+?=
 =?us-ascii?Q?ZeCgzFBHpJZ4TNal0Q3jjFCaPyVKNLxPEvXAwsHoWxywK3sT7hLc4g9i32L5?=
 =?us-ascii?Q?bR5hvWvdyFdQCLkOgdbiZcm2fr7Yem3ftfE2s5IOCfwGWMouhlMfj/NcmvH1?=
 =?us-ascii?Q?xOdbh1KbTeeI5U4Hp9KzmmXK6bngmP9VDPdll0SoRpViZWzlnJ68PDQgxIko?=
 =?us-ascii?Q?uq6HNz3WJer1fFzZcbpfTSF1XIBDwDLFi3J641HPVjVGPaa86bylsvOjWHOz?=
 =?us-ascii?Q?+cYVYtjPt3sjaC8rc5sQJwr68c0rGKCmn3Kp8Z5PGLU9IQmVK6nN0zmyVIKL?=
 =?us-ascii?Q?xWcbCf6tZcP4Lm2xvohnvwjjfeuXmkd9fy2tJhJTwLtLiE223RIGjPAGGPJR?=
 =?us-ascii?Q?2BlsKXiiafIS/BffsEuLbSXqGA3Adzr+ZEFnWjv6n+BBEvO0ORNOF6PyD5Mu?=
 =?us-ascii?Q?+ust1GCHs69yq/NiTRetaqWA+SzlDv7j8sXMLGSDVSGgVJ4/7MhskNzfZdle?=
 =?us-ascii?Q?Dr8izgt6q94UZtC5EeYZGzXeubKAyKoxkiRQOuSBjJS7H54WeyvrDgxZXMKB?=
 =?us-ascii?Q?TrVKEAlq7Qx9bFd1WrxtnEqyuYNS1NdzTavEM+OGTK2IGgBGJv5nVzUBTphv?=
 =?us-ascii?Q?w/VztIejsGRKfgOFVmB/ODWoYeigqqkNkbjq+JwIxjFzixC52BnaBVQoQu7+?=
 =?us-ascii?Q?DqwvX6MJeSDC9xRiBK6NfRHiOqm3cDba3UKy4yhQ1i1fyCG0r4x7w9VkYs2l?=
 =?us-ascii?Q?EUxxd+d9bYfjSpny1REPgJg9JtOvFRlajCgjglKlVOa8omzfGDzT6kL9sajo?=
 =?us-ascii?Q?hAf8iMeJ5spmxFGxXAS21dR3087nzcgEAOIfrk8nHncqn1uV8JqrgWypHN8z?=
 =?us-ascii?Q?hp154Pp9ZVZ8+m0no64mgs+R7D8Vf4nihdyX1XzBDJeXVCkyDRiLLx7wcXlu?=
 =?us-ascii?Q?Tx+7Do4Ng/OB3d31sT8HwhRwDvgPeguMxrrlhjN6mh8K9s7vjHMmEDKcIskO?=
 =?us-ascii?Q?jGv/oYVzmKkeXhL/QSY416mDDp9qebKV8RHP3bHxc7zvMlPPDPkZHiPDvUwe?=
 =?us-ascii?Q?w+GpKExBRB+la6siAcZrizjthe9HiN09Rd7JDyJBHPVk4LrY8mHuuK0HDq7w?=
 =?us-ascii?Q?td+nkb2mcw2btFJCbpRSg4zk9lH1DOyUk2op8waDW5oI/+iObX/gS3QZPkQq?=
 =?us-ascii?Q?XVsckaM4usoDYOCT6NkvpDYjEUGTLF420EbjR8phbGoA9KkKV2cRdutGKY9F?=
 =?us-ascii?Q?Olm5+iKINPCRnOzWhI+n0nZHhfcGj5/ikrFs8kwWzHXbLvk2sF7NzY5jFw1w?=
 =?us-ascii?Q?JkLC8f9Xr4MPTOYUJFzeH+hMYjGBIRksLJV5W/g26q8vxtym30hCDxaLwRwT?=
 =?us-ascii?Q?H4opKAqGugyBLPLFZkpq9yCXwsWvkMpos1En7D9kMiuPmiC89ugAbnQ4ArQs?=
 =?us-ascii?Q?n4UxBDVPyRHN9OXRHMIzRTiTR28DE0DY1mMKPgt8aHnhG75xJb0b4NqdMvvR?=
 =?us-ascii?Q?WT0I5nlGCvu/NRaCS+hbqx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f564733-0d80-4a0d-5c57-08d9f696541d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 06:32:56.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mANbpjbBDMRbjRzbOE0t6MAqloshvD67ky0KnQLh45tWmtQh0YFSlzlRJyLzynpP6yC7XRj45+IFeDigH34O9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 23 February 2022 00:07
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; linux-spi@vger.kernel.org; linux-
> tegra@vger.kernel.org; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>; robh+dt@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> p.zabel@pengutronix.de
> Subject: Re: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
>=20
> On Tue, Feb 22, 2022 at 11:26:10PM +0530, Krishna Yarlagadda wrote:
>=20
> > Add ACPI ID for Tegra QUAD SPI. Switch to common device property
> calls.
> > Skip clock calls that are not updated in ACPI boot.
>=20
> > @@ -1377,6 +1400,8 @@ static int __maybe_unused
> tegra_qspi_runtime_suspend(struct device *dev)
> >  	struct spi_master *master =3D dev_get_drvdata(dev);
> >  	struct tegra_qspi *tqspi =3D spi_master_get_devdata(master);
> >
> > +	if (has_acpi_companion(tqspi->dev))
> > +		return 0;
> >  	/* flush all write which are in PPSB queue by reading back */
> >  	tegra_qspi_readl(tqspi, QSPI_COMMAND1);
>=20
> As well as clock stuff this is also skipping flushing of pending writes
> - is that intentional?  It's not called out in the changelog and seems li=
ke
> something that could cause issues if someone runs on a system where
> the firmware does implement runtime suspend.
Runtime suspend is not enabled with ACPI firmware. Converted compiler flag =
in v1 to runtime check.
We must add more changes like setting DPM flags for runtime pm support with=
 ACPI.
Can take this as part of a different series.
