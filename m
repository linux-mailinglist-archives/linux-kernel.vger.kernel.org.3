Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA3C4610E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbhK2JOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:14:52 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:18784
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230118AbhK2JMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:12:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T44At1QN2MSZKWfcSU+kBMyVJ5kwL0TQy+1EBE5kfirciHLpo4fiEbFLU3WHgh5jB7Bz5rtXQxnIPO3o9o4OHURap9h2Hk9vJXiskIHgVypk5HnZwi13A4aBXVEo3tv7Q9mB63A7iZIyvWjRiTXN8coUbYniVeDr88V0B3xqt3jQPiEJkqmGFX7V39oJ6BDnUcuyrbXHISpMfwHIzETJj8YikXv6Tny68lIcOrR4a4QofPq8TTNrv6q9M+z1j0r8l7aw3TbsMIYjYoJO6E5Fc1gwOQolWLk4Jox+Vz+9hOwoC23nSvowGHNIjHM8cO8LSdnKdLo1tsAOk8zgTcozQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYs/4+rkMd9ixBLA4OTBdbkVgFksyExD/COKhpPVagU=;
 b=ANyjVFUqgRplZiaZicijDAuLNVTE4NlhTsQhM8KsxUJAP2smm65s2oj4uSAerIRWhJbLMWMkMyRobFbWbYa7qHz/Sqv7cFkbg/wuOxePp7GJmRpWXMnhgrcV6RqLRWka0fX2bexkp+ZL3pl7rbiAil9dbolK03zCofT4nqNKaCzBe2WAXZlojX7gzA+bCsShIKQRvW1wHHZPD0M1LsnSuaU81CJEqRHQ1Es/Nhxv2JJdmgR5GbskRcOtlK9J1iB4i27lOIM0wvNsyI8myxG/h2ImIdty1nCfBR68g50DwW1VhO4tqM7/21MYTKr/VtAa68pzwB1IoBujS+DpJPCflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYs/4+rkMd9ixBLA4OTBdbkVgFksyExD/COKhpPVagU=;
 b=R0Ayp6RMqmFH36Q/HJrZTQx8N/tLZQp1kDXRucE2LSmnhlMMCuYU/10aAEmmiJW12Sr0z3KiU5Q74x1md2yK44sDlHa7zGXrwmUQiGcNTvmwbFCrqzeRgQEjRyduOLAKdVmvTtT/gcRmQhomGjGi7Ue2+ud5/ProbSDx0d/IWRqZjx9OMwZ3JobbVIm8GDDgeQWLpx30cZbJliHRhNor3tAW3UrmNY2AFfxffSU2wpDlbe3NDwCeOiqyoM29PdrhoMd6HeRYVm7N2p6DLiOq+xWV9sL/gsLj+Xli5tDG0bNJtAbP7v0vsZkUCtK/4uEzdDKHVzf0uwbvNCh+iN9lgw==
Received: from BN6PR12MB1249.namprd12.prod.outlook.com (2603:10b6:404:1d::7)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 09:09:31 +0000
Received: from BN6PR12MB1249.namprd12.prod.outlook.com
 ([fe80::8cd5:b31d:e3e3:d28e]) by BN6PR12MB1249.namprd12.prod.outlook.com
 ([fe80::8cd5:b31d:e3e3:d28e%3]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 09:09:31 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] spi: tegra210-quad: add acpi support
Thread-Topic: [PATCH 2/2] spi: tegra210-quad: add acpi support
Thread-Index: AQHX4eK2PmZ2lQM7W06Rx2eVyKwOx6wUNK6AgAYJLMA=
Date:   Mon, 29 Nov 2021 09:09:30 +0000
Message-ID: <BN6PR12MB124973BF5CBB4AB35CC59B8AC3669@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
 <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
 <YZ+ImY1LrvB5a5iF@sirena.org.uk>
In-Reply-To: <YZ+ImY1LrvB5a5iF@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d834d946-1564-4ca0-fa92-08d9b317f42f
x-ms-traffictypediagnostic: BN8PR12MB2946:
x-microsoft-antispam-prvs: <BN8PR12MB2946112898E744409072C698C3669@BN8PR12MB2946.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KBRMJRna8iPiAdJN1qFDlr54vyPpGj5z5GvjTPvXFIre/NJcBrlSbM96XpWsowqou7UwRPyZXNOIVkOrgcUS0bw3XDjAbjf2s9tf6bC1b9EYPV4ifvDXPaMO61vx5jNPJLn8ElX9Pkv70Bqvu9im9PDZciVKngznMduGEvt1l6IclMROnM893djl6r4OtxRIwnyV+Py2SkXhJibmy1BfQyb5rNpb4WoZr/ZfSdoQ6K7YDhOfFruo1bpWoAOphu8L137RNhHLvv60nLpCL1LI5yJzVLRAvAq8p40dOz/MADM2utSc2Fz6yBLT0PJs9mxT5IwianoXjic089WEzsolAN1UuSp2+4yo2Wj3uxxTD/Qkxr1T3gpnAHoEDNDgO2PAwV4hmZbM/POUZG9Wn5Iuu/XMwCphtxtw0oj0/o1YeAk5DpabaQSXxL1It1cFLXTnVDElceFHUHJKL8furQqSstfVZ/HF6Zchzh/EW249m/0gzghaTRcpLpQp5LFo5V0feDE46wcUP4Hw58+u/AZvDXRaRMhY4dYsss9lSYp7dk1BmxApN9EsGlsqN5H1zKFb2Rf4FPLySIFzAR/s80lTdvXkpn0GuPNoI969igbOx2RBKSxfROCWmeZSh4r9n2GaSDHdSENtntZsjEW/tvRrkFEjRhsaV1tlaM0bidXqzckTE5cFVmNDFF5kWaEuSd/INdm5TUifm2viHY1UEATFpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR12MB1249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(71200400001)(8936002)(66446008)(316002)(8676002)(64756008)(66556008)(66946007)(66476007)(6916009)(7696005)(86362001)(76116006)(52536014)(33656002)(508600001)(2906002)(83380400001)(9686003)(4744005)(26005)(38100700002)(55016003)(4326008)(38070700005)(55236004)(122000001)(53546011)(5660300002)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wjdlKShY3hKee0JZpSy6fnkf5OE4lN4iYoIXJzHKHv6Hndifp5SIfhVVYaCQ?=
 =?us-ascii?Q?3wQ4axmTtHZVie5PGmFjUf+Hr+8qzolcQ+KObYk9IOr+WQcWfEso7qKZI1m8?=
 =?us-ascii?Q?RlKARnjzW8U+rmiIwipc7vYK62jmh/po9GBUl6DxZL9JM9Uy/ligRUffNUOs?=
 =?us-ascii?Q?bm4UlvuOlVp1ZLlYo2tTucbSTnD3PAbaLwvhH29gzdkPI9JRvuU0uEiMy8ow?=
 =?us-ascii?Q?RoaVAhSW73OU6CEap/tPRFWcw3Pvc45qumWtGZSP04zl6Ugao6oUYatYah6Y?=
 =?us-ascii?Q?nK2KVCrGbKbk2Rw7o3Si1RIcG91pJCQKG95vRt40cbh8Jupv9jZ5SVv3WYgx?=
 =?us-ascii?Q?2cZ3yOy31KLj/wQSqY5ewbYUBxUjCZNHNgJMcogpEDvt999+DSfJs46Pk6Yj?=
 =?us-ascii?Q?mkt3BpQnrSGS03drowmmkt5gosJFn26+2Er8WbI5deFEuKp2zRpGjSYAtyTQ?=
 =?us-ascii?Q?6Kc56rfoP2zeGEFs8lcDEj9l+G2rJOkF+x6ODdSxN30z5b4+KM+OC3VfUfuu?=
 =?us-ascii?Q?R6gCNcQNYypPy+CTCuHxBR3rb5KcYuG7DC5mqD1P8NZcJSEbcBqa3p1hkOom?=
 =?us-ascii?Q?dcQ729r0chKzKZ/nEIBPTCbSKUTWie08NPDzuDnH0XaggxCEuhEEFG/IgIrY?=
 =?us-ascii?Q?qdc3ehiQiClEMVCmkeNtCMvM8L1Dbp6TKn9q/1Y18AP9+KjrQEcRYFOe8Uva?=
 =?us-ascii?Q?im85MdnzAEbunnqBS2X33UbhNHms5gGWudKFHqFKfpXLyC0vNOfXLLN1gNVT?=
 =?us-ascii?Q?j5tKUuyQFiEom/Gh0Fg/ZsCrXnlOZKi1b9YDEJKRaok4JpdFqnrd7QpyQRcf?=
 =?us-ascii?Q?WA7Fzm6lPuPvPptXmMSqFmK+MDyTnysriBo3ptOMmGtpbQsLVl/JWqR+2pdv?=
 =?us-ascii?Q?dqA7Qespyc8oD06f3b2IgsKQJ3TAxJLiSWrYEGdGyuOolwEAyRWDGEjFI5U0?=
 =?us-ascii?Q?EzcvVnHrXJomh4RUs3PwRs0TTt9/px43p0Vp+WdSm9swQNbJ0LwPNKiroVLH?=
 =?us-ascii?Q?FCJeTMx8j8Tb4UF7WPU290UfG8y+YMjUXFbbRItfVY0lqm4SjXFxXZlgYktF?=
 =?us-ascii?Q?z+RIbF4oF00iLG67I7O5utPlYQ5FxtT0gxHj4iUb55wLuoJkZA6EyBGYplSP?=
 =?us-ascii?Q?RnOl+x/PI79eZCi70m8tSaUZtlMgDnsh+lP+lRppFJPeFSAD7GIgheyDG7BA?=
 =?us-ascii?Q?oPjv4RqtC+W/jdNG7qMtT5QPASd4baQfpQp94MicdcBhY7USVBuzVjApyJ17?=
 =?us-ascii?Q?XmdvUSE0A/mV4J/dP6jG8PqnmmefD7NO4rcN9vvjvAyr91o61gacYkSae5eh?=
 =?us-ascii?Q?I3Qz0MP6R6moaghgnRr16maea4VwSB0o7nIbhBmZ3wdZhy1YgvVgB+pDanZb?=
 =?us-ascii?Q?lfjW3MEjWxS5yDxouEM+4zAuWmzdZssd6iw3V6LXiRUktkkyoClx/nO6xYwa?=
 =?us-ascii?Q?WbE26AhinXMUum0Odz5i6dbV+n3LfX1mKlNFEnTVFbxCpnUdJ38isVvbxRcq?=
 =?us-ascii?Q?sCkf2YK7cZz6Ccigj/rb8u2xfByy4jBBoHWTrwADugdw21ijnbIDaXRr6e8e?=
 =?us-ascii?Q?l+IxB8464kUZgGTH1MgHoLftJOXsgbioTr+EOa2A6ra/WqrpDwvAYxfSAh5/?=
 =?us-ascii?Q?bUY+SJaS0Xoux8PlpMoj11g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d834d946-1564-4ca0-fa92-08d9b317f42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 09:09:31.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug/LbrKkwqJSxMXvR5s9x4xFP7F60Uoo0NDErJgkYeqEwdsmNX0bI/hJ+wV8wi/VnhLwdauISC/Oz7dTaPS+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 25 November 2021 18:29
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>; Thierry Reding
> <thierry.reding@gmail.com>; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Philipp Zabel
> <p.zabel@pengutronix.de>; linux-tegra@vger.kernel.org; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] spi: tegra210-quad: add acpi support
>=20
> On Thu, Nov 25, 2021 at 03:25:52PM +0530, Krishna Yarlagadda wrote:
>=20
> > +#ifdef CONFIG_ACPI
> > +	if (ACPI_FAILURE(acpi_evaluate_object(ACPI_HANDLE(tqspi->dev),
> > +					      "_RST", NULL, NULL)))
> > +		dev_err(tqspi->dev, "failed to reset device\n"); #endif
>=20
> What happens when this runs on a DT system?
For a DT system reset handle would be present and this code will not run
-KY
