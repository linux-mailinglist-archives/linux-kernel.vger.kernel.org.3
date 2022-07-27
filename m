Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7D582751
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiG0NCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiG0NCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:02:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE989286E5;
        Wed, 27 Jul 2022 06:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiboYGJzteCtdKIxxNwA/WM4xD3M3OHs1dKpPdz8xyKkLnMuTZc60FYOExGuO1mDNTh3LwWoZuTPN4XKFy9bHZMlU2bVM9/m1INhZpFvEOAfg/TqNd9qOwy9mUwAFugyL4Kg+GahGcjhJiOrREOVzkI+7xafyqCUHoipKGDpF0T56gUZW6h9aTziRoAjiWlFVjQPqfaXgQBG6B5b+gFibDJNOCwKEIyL53kfOS5gg7r26nYsf7vSD50yBVTc3mWb4CaegiDn6s4hnbGN+P1NsaDfBVmOPjmtxvI3zJRtdqq89GT6RajxxpD9dcrdKYVSLpkscSuRHyIkoDi2xE88AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpbHcqfU14VeVOuTfeJvjqi53KIFSy66f9F7/hD67kw=;
 b=ccqN64jIrZSmXTRiLVM6miTWXlIJ2siJxb2pdJa1vLqgIruvAQT7jrmJbCkhlhlJafFzTkEmowZlHHjrfewTGu4FoT+WtOjCBG+0HoM8Fw91eMOXeQWGBISqV3IQLrOhkIHLJI96ePTgF4XByN4Yb/qZcsQ9e8RWHliceNHZYVyIsFe5VmzjiWd1vfYvqWsEcVWAgc63fraJ9hTcwEO/A1vbnkiBcFoKBk8BOE2lRLDfs+PGT9YTCf4KeFjjn1P+oF2k3pE7f9w968CTSPUUpqearm33qklWTCmWG6w6oPo+FrCNeeFRMWvfW4uY8j6deiOvaQRYf0PHOafA+kCBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpbHcqfU14VeVOuTfeJvjqi53KIFSy66f9F7/hD67kw=;
 b=vSMQ+HkNPN8tBOxaHeKdx7Vyhokusu9u25DPXjJkEWFEq3elmydZaA22hxHjjCnHekHWTUZxCE7/L5z1EaS1rAk6O4P27WCgkOZRtYDMk7uhLyVUDQHy6MeuBkU5C+vD9TpUWdO9lNk7QdENwcqK/KxhyD9jOqWJ7lZ0PbZ4qaU=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by CH2PR12MB4008.namprd12.prod.outlook.com (2603:10b6:610:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 13:02:31 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::30c4:f356:a806:509a]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::30c4:f356:a806:509a%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 13:02:31 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Topic: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Index: AQHYeZhXApErq+32kkmuJFVVfXogSAG7F8aMAeAoVR+snXQgIICishAAgCJ4JhCAAFqwgIAF7C1AgAB+foCACo7NsA==
Date:   Wed, 27 Jul 2022 13:02:31 +0000
Message-ID: <BN7PR12MB2802E2A9079E505932832270DC979@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <DM6PR12MB2809F6C7D80B60556218D627DCB59@DM6PR12MB2809.namprd12.prod.outlook.com>
 <YrRXTrYN3BuShbzg@sirena.org.uk>
 <DM6PR12MB28091BEB013B6F1903B5CDE3DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
 <YtGNnT2cP5HIayp3@sirena.org.uk>
 <BN7PR12MB280220006B18F06E9ADA31F5DC8F9@BN7PR12MB2802.namprd12.prod.outlook.com>
 <YtbvlYZoRDz6i+pS@sirena.org.uk>
In-Reply-To: <YtbvlYZoRDz6i+pS@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fabb8b4-0571-4772-b095-08da6fd0440c
x-ms-traffictypediagnostic: CH2PR12MB4008:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKkUjZ2eygXE/7T5JILEu/9eHa8/8vaTj8KSwJamyWUiG4mPQmKXRjkw/O1hQZwzVONDYUxdacgwQfY1N5/h88tyBWLD2PV2Mj2QtbvwsMGGqR1UX5FFgGO64nsMVDiKCKkDGbKUz5aeei0HLcpheVN+XguaNpG78vKiUDvbP1pIk9zvRkEeI6nvtE0CFrog2sr1r39AACFcQBB/ena0rhpKKK1D4a0QY4Lf257SNW9turWwTU2fL5dEBYc82NwvQZurCj/b3TvmDZONFTgsSM3qDjVa/TKq1bEElRJsbr6PvtKV+DDXov6nwAcwsCU/UOWCQkRrznynpzWUcfr3JH/r/l8y0TMHXVuB8arM+0HGNsX+Jy8SE07vvYARD+GIrpfzHDX6AsdexlrGp27tw8HL7vnhqjCYJWPx3nYuKqzWsq4mpj6dFlwqXU2HRMsq3nrvy/yWN/wHwkIXMj8cTc2VraVBrBaDZBSWmhJaseI7LPb/da6oRzayu8IfSgWLEP35ws5wAYzUQGvLqg4VrkQbVbk/zlmkkmU52dxglvVwTO/eBWYMqReIwMtL40p5BeenPdTAZNfDQhZemXWarnvrmxl8QOCzAis7M1Y7bzhsWIleddFPi0guOaKn30GABtxn0kPefBiFIP/YvJt/nmP8CzaqD5nKgxIMqVcyf3355i6jWSw2Zxfx63KNkojcfpeG3cDAC74YsM9jqprFbZ8uH1YspHHzx9ORDYC5qJSeUIe4C2KLx4MV50U7d8xm/akl8rQi/p+d1be8tUXGMCSE10YDhceNJEpXxnXf8sg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(64756008)(76116006)(122000001)(66946007)(66556008)(8676002)(6506007)(4326008)(66446008)(41300700001)(66476007)(7696005)(5660300002)(71200400001)(7416002)(38070700005)(83380400001)(478600001)(8936002)(52536014)(33656002)(38100700002)(53546011)(316002)(2906002)(55016003)(86362001)(9686003)(6916009)(54906003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZEEm6Tqg8K4E5QgIO+E+DVwSNqmUjOuKr+9Y9QN/Aww6hsCPEq5YNdRdPnzA?=
 =?us-ascii?Q?KlZLuHM1HgDHKeT9Nf8PXpH47tD+YLslzBDT/R9z7INGP7ncGIZJaKNH/DOu?=
 =?us-ascii?Q?CFcNPrlrWFlepoBu0zDLsETY5FYUeFv54HCEVRCJzfHPUA087V+2SoxXUwJ9?=
 =?us-ascii?Q?/AF8RfHA+IHUadKUnJXZv7/rsXN+yN4pksKVIlz0dKSJAIb0SeUg04N5s6GT?=
 =?us-ascii?Q?q/9pxitIDVW/0jxHMll0ymXiz+j2y8vYqEwmolZVrTb1MvAYAVWbfEXPqthF?=
 =?us-ascii?Q?gvNb2GcAhPICDKrZOc3dxY9eMDnOZNESjeYuJESJ8Rp7BIv8Stsziu3xjkSu?=
 =?us-ascii?Q?9ZH4OnZM8S8SEeFeupafQMwh2RF6K14zrXubo/7xlItML477mA1h7kcVv0mF?=
 =?us-ascii?Q?W4Alvbc3fLgC6xn8jbPLhuhyV/ULE1bGjfKG5Ib7x4NGlAVTATnPOMoHVczK?=
 =?us-ascii?Q?p4VHJiCUr7lrpnftZYGUCfUa3xhonBqjzGiEZy0CUbHLybsq1PEETGyQ7rnw?=
 =?us-ascii?Q?uwgwJ7j3KYkUhlRbmkHvQABy6iX1jlNXfSeaMski58rc5lc+wYPJuZNMhBuy?=
 =?us-ascii?Q?sbwOUni4QvPVsVRMCB2X041YMx7l7TNwcs7ew2JTGQoTu8ZrZUXRfshxK03R?=
 =?us-ascii?Q?whk968RHlwIIv36zQDyHGkXuqTCgiwYI/QcEy/Lq/WHUbW/bzNayG/QtOgip?=
 =?us-ascii?Q?IsmML7g73M5a3QIYuKZq2dj062JBGWY1+gizm9WHmQG6d2PO8GY+Iuza9v/n?=
 =?us-ascii?Q?/Fd7Fo9j0rgMw0HS0l86ZU4wE7WVQ4z5639O245YiMHpfjVpxAciX8nig7gN?=
 =?us-ascii?Q?dNElkzKmZ/7XOdYZVRwfC2uaStAdjRUjnu6e57zGszzptAyASaUNNBepzKEA?=
 =?us-ascii?Q?h8Lu6GF3gMfplzWUaFMMbws4HWcFztgYwFwMK8J6sj7pOZXq1SCWW9yWiktM?=
 =?us-ascii?Q?5b2UCVGsml1rPWELrsqV5xtqHViD8CpVZbsOQk71pFdII38Ix9HcWRwbC3Q9?=
 =?us-ascii?Q?a6BO/1SET2/rGiTHkdcsHU/drgamcDKjaUZSmz/Qj14yrGkY77CafUnjZ1s7?=
 =?us-ascii?Q?fVldWT/PYyryzYvW1rmA2urqSmz2lW2uhcNIfmXgK+aQ8jbZ6FCe9NXihBnQ?=
 =?us-ascii?Q?AJu63grZJE8TmW3yni9ZyBYF0WGGrSNXMlTrFpkFyw1aGvebx8s6NPdSzarQ?=
 =?us-ascii?Q?WYSZLiW+EaqabiW4ccM+kM8SNZaW6ClGge1oLwW8pDVKVYLs+1CJ1NTydTpn?=
 =?us-ascii?Q?ZTAiyTX5iGngmgblYgaXrzBMAY3UB4MbMpQnbCj+2hMXdv8eLVTBrOXgVL8L?=
 =?us-ascii?Q?JhFfcJJ4lPemRjvCaW7E3lksJNjq9nREIXJiLf32Ysl6FSjkuXH39HzVYTJx?=
 =?us-ascii?Q?sJGd5Ap0ZEI5MDncAb10v4aPTBeIgZUlNk4n6Qd/0J1i/pzPGAjbn/eD5I3J?=
 =?us-ascii?Q?Xhre0Rz507lb6A6mpTmvs9kGCuxFN6oSMAqYmRFWeG0Z0i9caFfYbCjRf517?=
 =?us-ascii?Q?osXSLif+jgf9iBb4BIUuafz2mm2hcEI8/iaJXVINLwqU3TFGVwhd3z+wwuMZ?=
 =?us-ascii?Q?f5VuU01PtsESDn3bknE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fabb8b4-0571-4772-b095-08da6fd0440c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 13:02:31.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiRUQqhFX8P/DWO1HO56Ovrx6CSTg5Em33R2RLR58kuw1SgshG5ljyDPW3oWQh4iBtEgnMe+X7yI+WBlgjeoGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4008
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
> Sent: Tuesday, July 19, 2022 11:23 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>;
> p.yadav@ti.com; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com; git@xilinx.com; michal.simek@xilinx.com; linux-
> spi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; michael@walle.cc; linux-mtd@lists.infradead.org;
> git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SP=
I
> device
>=20
> On Tue, Jul 19, 2022 at 01:21:41PM +0000, Mahapatra, Amit Kumar wrote:
>=20
> > I agree, so for checking the controller multiple chip select
> > capability(using more than one chip select at once) we can define a
> > new spi controller DT property like "multi-cs-cap"(please suggest a bet=
ter
> name).
> > The controller that can support multiple chip selects should have this
> > property in the spi controller DT node. The spi core will check
> > ctlr->multi-cs-cap to operate multiple chip select in parallel.
>=20
> I'm not sure this needs to be a DT property, it's more just something we =
infer
> from the compatible.  The name seems fine, as does the flag in the contro=
ller
> data.

I agree that we can infer this from the compatible and set the flag in the =
controller data.

>=20
> > > the chip selects are available and that the controller can do
> > > something useful with them (and probably have an implementation in
> > > the core for doing so via GPIO).
>=20
> > Here are you referring to the usecase in which a controller
> > implementing multi CS support using GPIO?
>=20
> Yes, we probably ought to.

In my next version I will add the implementation in the spi core for multi =
CS support using GPIO, but I will not be able test it as I don't have the n=
ecessary hardware setup .

Regards,
Amit =20
