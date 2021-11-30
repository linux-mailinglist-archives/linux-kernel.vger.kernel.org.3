Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA54629FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhK3Bx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:53:28 -0500
Received: from mail-bn8nam08on2045.outbound.protection.outlook.com ([40.107.100.45]:17680
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229827AbhK3Bx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:53:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP4pfWx40duij/9fQnntYzBeDIXRc6P5n0USqmuQa577qX0PT0dAY5hJKI+0hYMPlj4fshMDl7juoikV3veEptMOq5m5Qj4F3JBGzp0o/bD/VisHsuc4ygEzc5LqbpExv/fQU95b6cimfMa0mvEnbYfBI3sRU5C5sQPL4gHpprUfwTQ0+zsTLSD3NVxjCPms/yC1x90ddhgJ6hQgnkcLl94OzbaIT9Oo6xilCBaUgbXUWP+z0/+0gWYdMIYEC2hJhTYXvXSvFAhAOE+v6QpEfjDDmNkULzKLXrY4YtzM6Rn+29weWHg4X09sBq8XRlnnVtBTGxgBCySVn9eHikLD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfxOHvoSB89vjvzq7zdAq22ENrytPXpr2cT8vB9vPqM=;
 b=cb9ScwlQ+qI164Um9rP+X84GtvB5GhSSRv8gIUx73yEWsa+codw+10febenp2IEPgIxtiIhzuSghdgmPHiWnHWhIw0j7jUL7UHSlR02MjCSaEjXDHHbXVBSrdoF/s1LYlsO8mQyJlpZkzDbcYsMf5E2nC1t0SQXCB+hVJNdc0LO6ROn7OvI+zP+aNdOJ1hNfSQZ+tMKGyWPihAPUUfhR9nPbiMmcdz9ij3T6Oe38jzQhkv8UorDSCQWVJg9uMzxhutM+i9I3TBMQ/hEMG9oTToL99r3wHVSm+7nZjG9L5u3mWBCEiOlJVn1yJ077vPfQCh7riUAaDY8taPkPvJ9Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfxOHvoSB89vjvzq7zdAq22ENrytPXpr2cT8vB9vPqM=;
 b=WJz0I+BANFQuRz6vDtrW8RHMcUrac9bA/qJpDr5sfZ2+SQHnypya4eHbX4W6kg4Tdw06k7/C3ILYBK9SCmyPKWljif4tirTC/ZRYkDIdj9jXfxNvfBYv+Q/SZv/JHTn+Bs+euGnermm7PsTcKrgTi9UOTHwZAcjcRfv0vTdIHRMiln4ONq9V1GO+9iP8VXcl/1ezigwbNKGXzC98xY/cyOT1wZ3zcqZmPPP4qhzaaQtS2Ei3Waw+DanMlVJOKR/X7A87gljM7uHau5ShunEyKs59n9YP2M/8zdsPW+pTRY5l0Tu9CO61lcufgkM6D40Y/8+omeWvgjnUZoapQ+2KnA==
Received: from BN6PR12MB1249.namprd12.prod.outlook.com (10.168.227.135) by
 BN8PR12MB3364.namprd12.prod.outlook.com (20.178.210.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Tue, 30 Nov 2021 01:50:07 +0000
Received: from BN6PR12MB1249.namprd12.prod.outlook.com
 ([fe80::8cd5:b31d:e3e3:d28e]) by BN6PR12MB1249.namprd12.prod.outlook.com
 ([fe80::8cd5:b31d:e3e3:d28e%3]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 01:50:07 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] spi: tegra210-quad: add acpi support
Thread-Topic: [PATCH 2/2] spi: tegra210-quad: add acpi support
Thread-Index: AQHX4eK2PmZ2lQM7W06Rx2eVyKwOx6wUNK6AgAYJLMCAADdLAIAA4EUg
Date:   Tue, 30 Nov 2021 01:50:07 +0000
Message-ID: <BN6PR12MB124927C4F4FAF53B59C2A23CC3679@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
 <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
 <YZ+ImY1LrvB5a5iF@sirena.org.uk>
 <BN6PR12MB124973BF5CBB4AB35CC59B8AC3669@BN6PR12MB1249.namprd12.prod.outlook.com>
 <YaTHKuohUNt/hVLq@sirena.org.uk>
In-Reply-To: <YaTHKuohUNt/hVLq@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b70bbf-d6ac-422a-3f03-08d9b3a3bcb4
x-ms-traffictypediagnostic: BN8PR12MB3364:
x-microsoft-antispam-prvs: <BN8PR12MB3364E4531B0D6FC79828F8ECC3679@BN8PR12MB3364.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUEP/w80ksAJAmC2ypZKXMwpbMzdGFdW9WWABoLB6sMcl0JVbc22H8ZbBuXK6bE46ZuP+Dk56te0dT7X9Lgw8JA27sHvZKiTHw/7tMr6PKifHRQ7jqewHgoMpK6KQMY1GuZ60tl4cqBp44oK5zm+eSsINpS1KGcdlXtSKNLkOdNG/539qMjnBVy8HUK6Zfh8/eknuGkbcyjVFIrkLJ5SVcnJ4V3lyjWyd6HNy3f/OkHlQCj8c6XW8nSzBjQjFrcRUbEYLa7/TmJAOTtxbDkDzZnCdXyDtFTaCNhNuH4jU6IwsqaOIglnDvaVKEd8CL8jNF5VYTfzGbmHxZQ99GzG2l/7giUHzs7uwFfXx7xlcO5XGx8ZW4dQrE2sUpLgL6x46tBsiX6Hj/BWHkssyel4h+QOWnBKheG9NIgVl6MA5BEhX/BAyjZXCl5C0/6ArOaC8PWRAmnG00qe8iG0zOafPAFsHUM4dldrGDd0h3s/bG9p6iU4xbILLS9gKXWQPWMtnGQRnX3nRnHxXYPSdITU+VeWMTh6TMmN6XDPNjDZAFs2A7GxZGJIeRIdq2J6lhHGy/VMaJjOe1WBelpowK3oWiq4l6tgAl059e2KckTsnilVCxGrzbIEjqsf68FooK3wst2r2167RcYxHjLyXDRw1DWJLdXzDLK2QG7voaxRbU53XNOF//DkX34d2OkL5OVikd/+GwXoKkJsHdb80l/kpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR12MB1249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(110136005)(38070700005)(6506007)(316002)(83380400001)(8936002)(71200400001)(64756008)(66946007)(66446008)(66476007)(38100700002)(54906003)(7696005)(52536014)(76116006)(66556008)(9686003)(5660300002)(186003)(86362001)(53546011)(33656002)(55016003)(4326008)(122000001)(508600001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3u7xV/QNAijTupUBGD7P0/B4Z/atfLrrvw6PQAtaVVXRZyI7nkfKzIZrFhsv?=
 =?us-ascii?Q?JEtK1nqDSP2L8NhxN9g8mGatkIQe3bQ+fQNW0ZadGiCzJRlgTMwLO9mjc4PH?=
 =?us-ascii?Q?4oFDw2AKLUOLbWIfMWDqH9biE31CE8VzZAJ1/i7nfkkDFw7ltV+wjIp0hByW?=
 =?us-ascii?Q?N6eoYvjJxINuWk+OhXlUk4XDFam8ofG8pC0rB05/xATbC9/iKGTWGuka1lM7?=
 =?us-ascii?Q?nBout7AWeGJNHdTAKD1pGHVgTq4AmwDiYrMlpXyl3fvvsdWWqYex2E/B8CQw?=
 =?us-ascii?Q?ASo2hnK1TIRk+FBryOMrU3wbe9d8buUtiu2/M+UoUEZ5FhGucFhWPwaPANqD?=
 =?us-ascii?Q?K7S+KMn0RxdhvHijUO558hxS+KQ/3CCi2K2zRHd0BluyATUhzIS0/Gc+Stas?=
 =?us-ascii?Q?43jLuvbsz/pG6AyGDt7xL/ziugajYNQA4Midflw2IDYHH71Fik/uwCnRYrcG?=
 =?us-ascii?Q?U0GqhkYl7dte5BAV89ouPKzQ32Bxgo2BNwXFk/X2QhnhTw4O90PGGXSlhq3D?=
 =?us-ascii?Q?ZMo4t3yblmX/l6mfZPvAXzq/9ztP+Rh5y2eYGxVc3eR6SPSUfuvil+5/gqVw?=
 =?us-ascii?Q?aZQNs91oI699cK9JxsRXTJxHvVJh3N/vujDEpCakTbN6j7ZBx7qYnzddNf02?=
 =?us-ascii?Q?lhKJWvVNxDL6JjeVAAkQZ3yhsOrDKbvzO6VQeJPlc6/2gPtgfmhqq5ZcNOYJ?=
 =?us-ascii?Q?YKF4QGZAB2gKvc7apEQl/+DMUgnXKaEGjWPJU0knfSdhfIfI8SDP1i/Q5A3U?=
 =?us-ascii?Q?iz3/NodjiPGSaQAb4r7pLedhlan0htAdoz+GNA7N9gPACgsrXTAUNhaZq6hO?=
 =?us-ascii?Q?03LSSKP7zMlvsCrgqiHyYk3fZ7rvEygaFh4KVHye0EJCVPGL01npB603ZDSF?=
 =?us-ascii?Q?PBMZi9320eFwtsjtPy8J2Ogp1TBCJQqC7US5y1dslG3mhd4jug3VWI3v5UDM?=
 =?us-ascii?Q?Se/xaJwMUDVXthXV8llvyltFm7aOwIQ8pXXIwpnewB79+D0ZzUaIy/deeD6s?=
 =?us-ascii?Q?MIQmVC9WiYtkgz1YmYtT6R/uMqLK8CQilYYj7T/xIuCuwya8mYD3RIf0zP1d?=
 =?us-ascii?Q?JESB79Tls4kLGEYnedBIqYTtXqAgeJLW/FHyxbd/i6S+tvGTSHM/yy8yXI1p?=
 =?us-ascii?Q?H9aZRm+CIdR8NHnXimo+XMSxPMo0MBfSF4/ch+XWw+tjZ4NoAO0sruPnEs8S?=
 =?us-ascii?Q?su10j+hHZWA1yT9gX0l1VU7lgitbSylNFEKIduNfFkGtD6ZEyZlc5Sl6/KmU?=
 =?us-ascii?Q?NOQFDweCny3Bk/hugwAnZImgCJd1SaSJyAyrTua4WDqWwN90RedAyC3bzPyd?=
 =?us-ascii?Q?givU0XTEgnxZNvQ4r0qt12YHYGdFJV56VtbjWOzPmbLcD8ZzfhMGJVeMe3ud?=
 =?us-ascii?Q?XwvNbN3atYDu1NjI+Rqfkfxd4ZAFA8IstjoPJjl/3Zk3Jy43oJd6G7tk/F56?=
 =?us-ascii?Q?pT+Dk+mBdo/461RFYMQVFO3DzLpPzIbX9fOl3QS6pZDY5VVWL5tdcuy+TscP?=
 =?us-ascii?Q?Vx2kSN1ygHNlpdXWkNvf13IJeKm63jOi8Dr9imHTei32eHBvCZEklcjuhiiw?=
 =?us-ascii?Q?EXcXOwNFg2qYQlSYPMuDWfsRLq5sKRwvOH1DTLcSFUtMLVSGJbdiqSpx6YfY?=
 =?us-ascii?Q?29Qavt0Q/HbaRE49oOJiRi7eb1T12hVoMG5V3UGOqohOPuQjBwMR0h/TE7xJ?=
 =?us-ascii?Q?RwBivJSiAABjsyMWfyRYpbCXWuk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b70bbf-d6ac-422a-3f03-08d9b3a3bcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 01:50:07.4986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIb82B9nb7UAN+Yc59Lphk+OGkXyroFJ8FBU6C/JLzg0pDyTZD3ZJywCpMB0+z3R3hOzXQWQXDvPOHrtDHl1jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3364
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 29 November 2021 17:57
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>; Thierry Reding
> <thierry.reding@gmail.com>; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; linux-
> tegra@vger.kernel.org; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] spi: tegra210-quad: add acpi support
>=20
> On Mon, Nov 29, 2021 at 09:09:30AM +0000, Krishna Yarlagadda wrote:
>=20
> > > > +#ifdef CONFIG_ACPI
> > > > +	if (ACPI_FAILURE(acpi_evaluate_object(ACPI_HANDLE(tqspi->dev),
> > > > +					      "_RST", NULL, NULL)))
> > > > +		dev_err(tqspi->dev, "failed to reset device\n"); #endif
>=20
> > > What happens when this runs on a DT system?
>=20
> > For a DT system reset handle would be present and this code will not
> > run
>=20
> This code is really unclearly structured, the early return doesn't match =
the
> normal kernel style and the ifdefs aren't helping with clarity.  Please
> restructure it so it's clear that *both* cases have checks for the correc=
t
> firmware type being present.
I will move each reset method into their own function for readability.
>=20
> That said frankly I'd expect this handling of ACPI reset to be pushed int=
o the
> reset code, it's obviously not good to be open coding this in drivers whe=
n this
> looks like it's completely generic to any ACPI object so shouldn't be bei=
ng
> open coded in individual driers especially with the ifdefery.  Shouldn't =
the
> reset API be able to figure out that an object with _RST has a reset cont=
rol
> and provide access to it through the reset API?
Common reset apis are not handling _RST. Each driver is implementing
_RST method in ACPI and calling from drivers.

