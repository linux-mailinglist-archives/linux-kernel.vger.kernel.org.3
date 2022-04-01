Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D64EEB0E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbiDAKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245030AbiDAKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:14:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884226E543;
        Fri,  1 Apr 2022 03:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkrPZE1YUV0WFSOkH98BzoV4x0sVQ4Af7f7yiVGH9Pnpwj/KgOSG4+YRjvwyRYGnLc3ZeGdiftKlFYaQrkGbuBTwsGFePQEIpQGxeclAnpvRyMAwi3dx2HowIgsZ/X3BthhmUNAuPZm3+OASVOygHeNPoSA+jpBRDBT0DmnlV1Kd0f2IH2JYt01VkplMEnDQh/clBEpbFMGwgAnp/T8xZAQrh8HZy99kT1zLwjuqOba3HyORIre26dMXEG3BvxOMzTNw+Lb2JJrcZcc8WiX2XGBBOdL/mT6HLuOaD3Me5beccIV5AcI2qSsgYeUTSlHTT5hBGkmqaQlHGueBD+n9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYfUYLYH2iMGFPB326wCdgShRY4WBTLfXOiIeZNbyYE=;
 b=haCMZzkFW3aa66D8tJItBQFyWAZ0CgCzPNTgf6H5EhIR9/ccUIybKGAQZGUwyTs1j46RcjG2IBn9ZSx0lg8eTWvOnHv13MahuARnQdWrb9loe3C7JPqhTfF+yMu0Aq+zXxmdOWXP1LjdaD+kvTc/QfCTWAfXbjZYwlLBaSif3ZHDFrDMwNUKVj350LkijFvBcNpK8SYoFkV+GM11+bXmrEP2UrZahk2ciOCwRxPlPxxuBZ2eyR8aHKZNFd4UN5xTpWyQfczGpDi4u34rheZZPXDBKkGPBBcLJkOEi8xHB7KqKCIv6fnI5JUYGgSvDNz9Vy/KxwvNNoyGw6fvXkxncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYfUYLYH2iMGFPB326wCdgShRY4WBTLfXOiIeZNbyYE=;
 b=OkOVL8Y4rFDB2jxWkPERQxWwrFccRU2qG7M6JhbW2NGUvmD7Kwt+1CtzVFY7yT7vrZCmO8uPzFBUOhvsicxtYqD4gBGfKi5hmOGcI9OPyUiqpkqB0JcEaQLlET+L3jaERe9Qc/V5HMckyj38bFgBMEzBB9ql0PMk52rb8eqtbDtyTjwLuQ9sQ2oF5AKv1XamhJriJXrZJqoKUz+dU74QZAq87vyQSUQ3ekB4o5vCQUtrMGGIQXzGaOzUfIHkxMY0SS7hUv6jD1Pez5yhLvt8PODhH9o0/MaQJxAh95NlzdKncXh+0ka4pbytQ3zvde0gaj7n3llKpR2sfS+6hkre8Q==
Received: from DM5PR12MB1628.namprd12.prod.outlook.com (2603:10b6:4:7::13) by
 DM5PR12MB2501.namprd12.prod.outlook.com (2603:10b6:4:b4::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.25; Fri, 1 Apr 2022 10:12:09 +0000
Received: from DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::144a:7c01:7727:1846]) by DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::144a:7c01:7727:1846%9]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 10:12:09 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Bibek Basu <bbasu@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc/tegra: pmc: update Tegra234 reset sources
Thread-Topic: [PATCH] soc/tegra: pmc: update Tegra234 reset sources
Thread-Index: AQHYRACcWXPz7MPbsUCQESpH3BXaoazXpZKAgAMzNDA=
Date:   Fri, 1 Apr 2022 10:12:09 +0000
Message-ID: <DM5PR12MB16288BDAC52414AA65CC647FADE09@DM5PR12MB1628.namprd12.prod.outlook.com>
References: <20220330063635.1689-1-spatra@nvidia.com>
 <YkQf13VH7RzrEcG/@smile.fi.intel.com>
In-Reply-To: <YkQf13VH7RzrEcG/@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e686f6c-5923-467c-dfa9-08da13c8150a
x-ms-traffictypediagnostic: DM5PR12MB2501:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2501A9CB918CA8BC704C18C8ADE09@DM5PR12MB2501.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3xjOf3D7y8ACDM3qRr6SokIgl4DR+yXKMEzdwHjByjy94v5wRiO6QK4fEHkdtsN5K46GyJxuszr8643hOnfdhyOsUL2hGL9FsordCBR/5RoMKpgSlERcAVHQOgQqvrc17PGrcjF9c7mxbPDLOv6ci1pm8lyAjMZW7lal4h5x+Bx7RSaL5181WSNsv61F8SvOqHFZei6tgNBIdnMy3vxI+EdN64x/nO3m0LRRCfveEx/FENGmoBqFgBhKD6wTadQIWPV2XWqQ0D4d+iISK7suCsHveUy5uwO1Y9oCG6e690/tbxBUUPd99gSqD3zDEjwlPIcN0rd49WPIzRC64vnuJjo0y6MgAkYAW9Xuk+I7TJOprfi0d4TSgRvmBf4KA/aUhwJQ025y2/w8z3fIb+YfvyvuarY4pg4ukLwFvRXy9tXX6xSyC5un/pOU/ZHhuaZH7zAsaSZazf37rs4VK3V7Ov992qRCnm1+nqLU4AgO6Fx7Rgpg1ONNiPVzSYsHuRKpOBS3gGAF2gS1ASr1jscGTgjN3n4zvD1s3ubVEF/Cdr6T2bsbREHwvj6WONd3D/rxLX07ZZ3qqVuh14EuQs+i3unBpy9bKUGsk7rLeErG2U0UYczqU/WSsJg1RLwL8+1TWhLi6F5aRywGihbPeHp3ywPQKPe02rDQivmde1zEUo2xNf0j/A8MxsXRPcLDCM/AMzKjQpjxcYftQGQ1UTunw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1628.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(6916009)(186003)(26005)(53546011)(55016003)(71200400001)(54906003)(7696005)(6506007)(508600001)(122000001)(38070700005)(38100700002)(83380400001)(66556008)(86362001)(15650500001)(76116006)(33656002)(66946007)(66446008)(66476007)(4326008)(5660300002)(8936002)(8676002)(52536014)(316002)(64756008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R7UyUdqS+4GemEh84u0Tta6nhyRzVVb+qrbHxlZdtkSW1ts4aiUO5Q/g1W9g?=
 =?us-ascii?Q?9Tnkr/LSCSvZ7mpiSgQh1abAez/hoQzfeNdsy6uQi4eHsWrXsdzUkO4epINg?=
 =?us-ascii?Q?AwP34y1hkDoUYZxQI5/8C5F9HVQMZKDGzpFgpBKfhGoIOwJeSJWGI4XQJR58?=
 =?us-ascii?Q?ZAlxsr8VS7pZSpS2/l4Pp5Wvb3lOvjyqNDXhGaz34dVUtx2M/1/z2RKxem6r?=
 =?us-ascii?Q?QdvO8/mgEDmM7/Ynz0ogooaKxILmOFbBDug/2SH9nYK7M5184goOgxAPo+79?=
 =?us-ascii?Q?RxjEt7dMjfwGUIiGKhwZ+mBFHTR/cOm2NyXPv2B4cYX5Wl+4+1PghHZxBuVF?=
 =?us-ascii?Q?OnlVxTE6WMBgydw+dsmMknjN2W+wbAXA1mSAdTaiGBnS06CsTElEhETddxrb?=
 =?us-ascii?Q?toeyFScfq9MyHEQ5UfBNKAI6zvcjiFhoSQ38IhV/5kg2xt6sitV/ICi/u2jT?=
 =?us-ascii?Q?kNF7tJW/lIbqthzyLgiZNqaCmfpwjI3JIWqLQODzB98WmUidQLUi3XnTeig9?=
 =?us-ascii?Q?+R35P6+I1ywznXHQJJYnzxRjXoYnVlUaZs8gyO7bFL0XqQRBnMcJWmFS5N1u?=
 =?us-ascii?Q?Ne+RgXNytH1rkpsf73J3FQjozpgpqzBT+5e8uILyfiHzXLPiSXom2+cJJM46?=
 =?us-ascii?Q?g812GQSKc/moeZOg0yU33dwvcvGBOZxapke9v8NAxa8MK87jreq0HoxcELEq?=
 =?us-ascii?Q?1RZ+eaQDmi9feeDJqnLnOTkQ44YEQPBJYh/vRe9XZBsb6DLeyh8laqYHXkND?=
 =?us-ascii?Q?SoLooH0xZoKob27luCRHodvdGSAW0ufWO+qcjnXjh5l6yA2oyXrgE92oiV7s?=
 =?us-ascii?Q?BnfSCr5rVBQDELtvR2VdlwqFrqFld/O62YEyguMpGSDwL+PTo0b4gVy1BFUy?=
 =?us-ascii?Q?mGcomusy7TK0rQ1SfnIRjT/MVoUuWguGTCeJpCOdnKUAwLj1vGfbdcyQ7BEn?=
 =?us-ascii?Q?dK7iMnmQuQG6Zv3blZSmEEfZw/HHi6rv+Gy+J3sNHphT91bu6qZNe9R8dLUb?=
 =?us-ascii?Q?1aJd05M3wfzDyH/O32KQdlUm/2ZbhqbzOUvlbeV9ORhDhurpEjNvjJ+lykAD?=
 =?us-ascii?Q?a0E/Rwo288jSSdoAX6ie4kxaGDw5ZKeff48akgkKoQuS91qStNxQ6+9Gujn5?=
 =?us-ascii?Q?EmwhjfhpS32MGC5OiCk0qgv8ng4iA0D/grMDgjQpsJsKC6lA9o3r/wudwzzo?=
 =?us-ascii?Q?M77nV/ggZ7izwKEHtSqjR4yMhacxNBZk7v8dWYPlUiggwmJHZ6S+XKd55uVK?=
 =?us-ascii?Q?aN0y3/w/LwppB9W/8OUcZvCd/aYHIgmQDOeA6IjJEAfcw/PmB+mVhTrwM2jh?=
 =?us-ascii?Q?th2C96eAJXo6RRuGMxwDUwZqO1CFmERSYOXMZ7br474ebdie31CLQqJn3U9t?=
 =?us-ascii?Q?PmB8YPaUCjGpc91iCLdG8fcffc8FpUWPcCfFeHt+Vty/Kfjioa0+v6MHTmmw?=
 =?us-ascii?Q?U7/ajslrHoWIXFDjORJNxOM8LF3UdtN1CcttKtEe37yTUVrxLBFs9ex70tSM?=
 =?us-ascii?Q?t/p9fTEW9yx7oAMJQNdUIVnpdyz5hgrxV9Drtc/CwfIFAuJmQd0dcZm4DWHp?=
 =?us-ascii?Q?WuMYPS10pZqKYJjRtzXSO70p1VRyFRjkem1jHQJbC1OhCcCG9kLVA6RlnQMf?=
 =?us-ascii?Q?ipY5uGdw5nBdsCJGH4q3lMW7NujgGoEvq/xqLaZeK6uttwbpe/Dti1eCtroM?=
 =?us-ascii?Q?N39j3BzlX9BXp4kAFMDZVsiQvykg1IUgf4NWgcYjyWrKCUB5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e686f6c-5923-467c-dfa9-08da13c8150a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 10:12:09.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZIzCHGoJly4pjV/UnrGpmqlSjzJyMbPxyy176vp3K8oAuVpYyCZDfsPPFMhSYoK2fzBUg7tK/ng5/yoOENaeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy for reviewing the patch.


> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, March 30, 2022 2:46 PM
> To: Sandipan Patra <spatra@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>; Jonathan Hunter
> <jonathanh@nvidia.com>; digetx@gmail.com; ulf.hansson@linaro.org;
> cai.huoqing@linux.dev; Bibek Basu <bbasu@nvidia.com>; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] soc/tegra: pmc: update Tegra234 reset sources
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Mar 30, 2022 at 12:06:35PM +0530, Sandipan Patra wrote:
> > Reset_sources list is updated to add all reset sources and removing
> > ones that do not actually exist.
>=20
> ...
>=20
> > +     "SYS_RESET_N",  /*0*/
>=20
> Missed spaces in the comment here and everywhere else.
ACK
>=20
> Not sure about indices. If it's going to be a part of the hardware
> programming interface it may make sense to use hexadecimal rather than
> decimal.
Agree. That's a better suggestion for readability too, I will modify it to =
have hexadecimal in next patch.


Thanks & Regards,
Sandipan
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

