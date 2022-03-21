Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D94E2CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiCUPu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCUPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:50:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2224594;
        Mon, 21 Mar 2022 08:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNXnwaDa3uejuHTBXWTf7E9Ldj8NmnElfYEn8NgnU2msaGoJiZAkxAeheac6q6WU0t7WU/dqzT0GZyDklC9l0/tteLZ1UW9eKuUBHStM5HhVeDJOfL4hvASH+sYHCMokFPQxvtxBkqeDfGt3bHWMRgSk3HU9Etmb11wDB676s1HCD0GUja1+8e+zhz5TbIbA50PhlkBnCpZU6sGwDjudwijyfK8qxkwVHLe+e7cZhzrArW7ibx6IBZ2KXe47qnUrEuZIqG6+Oj1/55OeLyv8VghTYIiQwz15lVWNUmq8ZIX0KcuFF94HMIYzZ27Gei1et+Xw7ctPQKM7CKZBK+1aAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta1u1XpAnqJoxVBP7+8T9k4ZzRvq+/SEUVdLQZnIMWo=;
 b=V37CXdocTdzA+UWF1RRgcOi9hjDEr54Tn5ChtFlIOvJVyQzfAaUschOQin4tDKYwwdzfQ7uWapyyYxVbTMvkFGz2R+FoD7X602O2o8Cxbn8yESiXSegyj80ARLjGtkRGurTQsnhQG/xGN5JWmkXV9pZwE95Az2M1NAuS7mylQC8vGgLUHNCuz64LD0X5OsEAdc6DZkzlTZl/vEpfwLfPUwEOewaLtpDgbYVClL8fVvlfRpUCDQEMMFBXedL6HxN3ogzNusaYn/E9BZ8ooR7CMLUHGho7jqwOGLuHrPHwsK9NqvWkVBZPPPynMkYuUChQwg+6Txw3Osu8XtH7UmyB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta1u1XpAnqJoxVBP7+8T9k4ZzRvq+/SEUVdLQZnIMWo=;
 b=V3jAaXJ4vH1UnhjTr9kUhrCIjt71Updy8ukNqga0rk71ETAvJ3IwXj4UlFiTLFPxG5VVC3+sruLi2sVRoaoHN1fTxXyTL0A+JWEW9aUEQcCZjkTN1gRe5PPDfwX+Yv6gdAIE2AK4QqWym3jW+mgKRxeD0Z+hue90qZd6Zl+2WbrTXmYl5iCRh2Nh6HzLqnYMcTHLqkU6cpPT+8xlpURPFhI2qwq9/TNA3aLdIYbtdd/s77jjSoomwhZ7m1Yk1538/7GSqLdtQocxfEl6rQTCk70KvBUJhhT6aenTlP52x6cn3Zi3/ahsN6PEJM/su5KDFPRiyHekk2qs0vaRwK2XwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 MN2PR12MB4639.namprd12.prod.outlook.com (2603:10b6:208:a4::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Mon, 21 Mar 2022 15:49:26 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::1dd:1fa1:7c17:c261]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::1dd:1fa1:7c17:c261%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 15:49:26 +0000
Date:   Mon, 21 Mar 2022 16:48:46 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v1 2/3] arm64: tegra: add node for tegra234 cpufreq
Message-ID: <YjiQ9DThcWuKiHhj@orome>
References: <20220316135831.900-1-sumitg@nvidia.com>
 <20220316135831.900-3-sumitg@nvidia.com>
 <30bb04fe-4fed-04bc-6f99-158ac09d6bb8@nvidia.com>
 <748d87c6-3f91-8bc0-ce8f-0a64278b4122@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9ibEdqmUBL5zAej0"
Content-Disposition: inline
In-Reply-To: <748d87c6-3f91-8bc0-ce8f-0a64278b4122@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-ClientProxiedBy: AM6PR01CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::46) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa426d99-22b2-4b5f-b73d-08da0b526091
X-MS-TrafficTypeDiagnostic: MN2PR12MB4639:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB463953FD8FC7AFCB78CDE750CF169@MN2PR12MB4639.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgRYGnOAp4N0Ow2s1cn+vC09teaZFxMMsKAJeJnKAC1KFU1B38kFkIG08wpuV9X8pCndS+UuGnpfzlNU/z4ywb3KlgAXD8fKAdfmahqTjZHPEvR7FfvBxSrn9/Jdj5J3NvmdpLWRe6NnJ8lh26FQrKwsbad6GufwjVucnqaBUYL4IsHDP9aFEYOud27TPEImCSHKZ9j/6wMoQPkFgspmzsewkCBh32UwZfYwDtBpGQyf/8ubc3Rad5ALJpjUuzPmnc0+KoEJgWf4AsCtEeYSAY9119WoAJHdAYoSlzxXX/WAcr2cItmchNNNjgsaY0/rW2y06cVbzhKBinWJP5JcxWKSBqZpX4lZbVwdADHZufEK/flk+wc4kBEJ6CGMs+Xy9yuGlp763ZjLyUI+XP+WXlMKb51tcF6lCGj05zZjp3L8b1pAYF5u7AELKB7YCxheuoWoXlVp6JNzU7LKLrCQ0Byz5XXMFI8f54vCPfIdt5n4sVIq8m4e0pXdKf4JyK68IMd9hgEFHjNDAN2M0NqPk5g1FIPD6f5M1Foumrn4LIv1IVm7tkyXdK/+uzfwRsMJpTHe/7eGtSZPPD3Mvy5C+3sBX/79Y+LSyZLAuMogS48VMdsofro2K2eLdYlodxyVH4voBE2/lE5ESa/naQ1SRsGeMKo7omsnjVNarQskMs4+PxrMoTUKzfh09q/+OgYjMKG/Ga0L4+xU82VwFEDQbi3Mr9oiD4AQr2zJa27cQkimvvVQGshYV6YnxrFpNcC7qC+UP7Fc/2wl3M6dKCdkS7K6JRcN03ccsETGhZQhiXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8936002)(6666004)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(21480400003)(316002)(6512007)(9686003)(6636002)(6506007)(186003)(44144004)(6862004)(66476007)(66556008)(66946007)(4326008)(8676002)(508600001)(6486002)(33964004)(107886003)(33716001)(966005)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDI0OWtKT0h0YndiVTE1UHJzTHpkTnhWSGpqUHU0TkdmemJVU0Zwd2RrTlI1?=
 =?utf-8?B?TWZiRUR6anpXeDV4RUR1TFAraW14QmpmSmVxamlBUDBhcmNIbzh6UlhZbUZx?=
 =?utf-8?B?Tko2cUh3MDJnYWNjL3Q0WGREeTk5dzA1YklsanBtWlpEeWxza0pWakNmOWlZ?=
 =?utf-8?B?eCs5Uy9teTR3WDlIUGp2alpQYWRoNXMyVk9ERkpSSXlwZytJQVcvT2Zpcm8r?=
 =?utf-8?B?NGMzelQyclBIRlpIMSttU3k2SHdpOW1JTFJLMld3S1FpVmZ3a1JNYlZxa0VH?=
 =?utf-8?B?Y2RQYkMwZEQ1SkNYRmhBbDF2clBmTnNYTHlMaTVMcnRUY0RBbzc4aDc4MHV2?=
 =?utf-8?B?SUYyTkdDYk1qUmlTckRqV1BaWVEwY0djY1ZYZ1E5cHpLbndzMFVLbFlzeW1S?=
 =?utf-8?B?L1FyeU1XUFphaXRtaWNmTkdtY3dxcW00dE41YnhVbjBQUW1iY1RBMmVLVm1z?=
 =?utf-8?B?UGZ1VHkrRklzVDZQL2xwb3RYSk9Yd2JXb2t6L01seThDVHdVTzRuVlo1T2wr?=
 =?utf-8?B?a1E4aEQ5SXk5ODVyRnNFTEFTS0VvR0V5eWx1V2ljVk1qWjJ3ekxmd2ErclhY?=
 =?utf-8?B?aTRrbWZRbW05TGc3TmU4b1BGeGd4UXJQVDczSGkrU0RXQUxsWlFnUnBKQTRH?=
 =?utf-8?B?ZFNwZVkyUHlBbktidXhVQjRHcCs4aFB6NEg2Q2hEUUpHR0NmMXIxYUdlUDFI?=
 =?utf-8?B?SzdkVUZoaExNYURLLzNocytNK3BwTDZlRnl6ZU1ucEF4b0VYVE81SkxmZ1or?=
 =?utf-8?B?QkNqOXBUM0J5WWM1RnVtbks5anM5cjA4cFRVWU5tOG5nUjNDNDYveE4yL0t3?=
 =?utf-8?B?VWZqUHlON2VMcW1LOFk3T1dDaWhzTFNNb0U0MmVaNHUvU0ptZW1yM2VnYlFT?=
 =?utf-8?B?K1NSSjduMVhUeDVjbU1wT01qNTE3Y2xSb2srRFY5VzFpTmF6YUxpdkpTYUQz?=
 =?utf-8?B?MUFrUmZOVUpsanJvK3JJcFdxWm9lYjVjVDg4N3ZnMUxkL0pFOE52QmNwbmxX?=
 =?utf-8?B?dWlMbVhja3c0TkR1UStteXZpR1RxeG9VQVRsZjlkMkZ3MjgxbzRxbGFUeVBQ?=
 =?utf-8?B?YjlmV3ArVERlbVpFOUVmVmdTa09QMk5oakNLaStvamw3ZFkxRWlPdkxDQ3VK?=
 =?utf-8?B?RllzazM1enhNOUxBOS9pK3JEeVpVZVE4QVB2KzRhbGdKV01TRzlyeUJ5YURY?=
 =?utf-8?B?aFVldWptbnFQd25veHpRWUN4S3N5RjU0SDE0QUVWK2s4bGhVUE5qdEtyVURj?=
 =?utf-8?B?Sm1TanI3Rk9XcWM0c0l0QWh1Mk45NjZucXBsSytqU0RpRFVIQVl2RjNGVjFR?=
 =?utf-8?B?dzZqL2d0L0FYUjdiUWRVdEFpQlZwV2dDc0VMYk1TNHZ1U3hDUVJQNE12V1J0?=
 =?utf-8?B?R1ZRWEJteWkrdCtOSGNnRzVuMmxNZXErVUtHVGE3RkplT3JBOE1wQjZ1T3ZT?=
 =?utf-8?B?eUxDbnlrUFBPRXV4WktMcmluWU5HUkVPNTlCREhmWWxCUWhETXY1U0pSenBj?=
 =?utf-8?B?MjFmUnFUUWRjUnp3RXAwSXkrYkloTFRxVWtsakJHaitvVFExQTZHOXJyRkpu?=
 =?utf-8?B?WVhJeFJ2ZE9HbmFqaDBhdU1kK2hRUXZWWVY1NzBtOXc3T1ZZaWo3Z1F1czRk?=
 =?utf-8?B?bVpnTnFJa1JqeEc3WWRXdWRtZ0ovQ3Z1YzZBcW5UQnFzRGNrQ2ZvaUdQVWRl?=
 =?utf-8?B?bkF4WVY5em9tbjRoYVZRYll3S1JWVTY2L29SbFdjWGRsSXRrT1JOMklaaHlJ?=
 =?utf-8?B?NlJVLy9CUU5vOEhUMndlcGhtNWdtUEpBK2dVOHpGMldVN0hvUi8xZ0MyME5p?=
 =?utf-8?B?c1loU1RCejIrbFI5YlpZRUduUlFtNTBMTWpmTUNRY0xUS09INDBtWjNIWlN3?=
 =?utf-8?B?dDNiZlNXUTNJRjZlVS9mV0E1a2tlUkhnUk9NM245cUlwY0VOK252aTdkZHY2?=
 =?utf-8?B?RGtZMVhRai8yVytvZjVMVkZDd21oWUJjTnQvL2VGd1MrTUhJS0xSaTlVY2dl?=
 =?utf-8?B?czhaWGo5amhYREFMS0JMUFUrTTJwSW42NVREaVZhWS82c2tsdCt4ckJHOVpB?=
 =?utf-8?Q?ap3AJs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa426d99-22b2-4b5f-b73d-08da0b526091
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 15:49:26.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbM90Ir4cpi4xwGabUyfiMet0dpSxN90rTashiNxKIbGPgI/zzo9vdbzIXTqLMJkryzQ53HkJerGZvkz27uPRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4639
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9ibEdqmUBL5zAej0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2022 at 06:24:21PM +0530, Sumit Gupta wrote:
>=20
>=20
> > > Adding cclpex node to represent Tegra234 cpufreq.
> > > Tegra234 uses some of the CRAB (Control Register Access Bus)
> > > registers for cpu frequency requests. These registers are
> > > memory mapped to CCPLEX_MMCRAB_ARM region. In this node, mapping
> > > the range of MMCRAB registers required only for cpu frequency info.
> > >=20
> > > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > > ---
> > > =C2=A0 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 7 +++++++
> > > =C2=A0 1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> > > b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> > > index aaace605bdaa..610207f3f967 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> > > @@ -1258,6 +1258,13 @@
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0 ccplex@e000000 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "nvidia,te=
gra234-ccplex-cluster";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x0 0x0e000000 0=
x0 0x5ffff>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia,bpmp =3D <&bpmp>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> > > +=C2=A0=C2=A0=C2=A0 };
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sram@40000000 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D=
 "nvidia,tegra234-sysram", "mmio-sram";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x0 0=
x40000000 0x0 0x80000>;
> >=20
> >=20
> > We need to add this compatible string to a DT binding doc somewhere.
> It seems the binding doc was previously posted in [1] for T186 SoC.
> Same will be applicable for T234 SoC also. Only compatible string need to=
 be
> added.
> Should I sent a separate patch after converting it to yaml format and add
> compatible string (or) send as part of v2.
>=20
> [1] https://lkml.org/lkml/2017/4/3/324

Yeah, it's probably best to pick up Mikko's patch, convert the bindings
to YAML and then make the addition of the Tegra234 compatible string a
separate patch on top of that. Alternatively you may want to add the
compatible string while doing the conversion since it's just a one-line
change.

Thierry

--9ibEdqmUBL5zAej0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmI4nlwACgkQ3SOs138+
s6EY3Q//fbNDHtaSk1JPUwURP88fXvWWZ5FKhtoCW6Pv7xs4o0e9AKPYMo0DQWrI
nPoXAHq3rQO1C2On4O5NWzJ5dd516JTDcjBs0wnQNPXR63PyIm3pEgAr59Hw1wmR
+99UfMMEz80H844U6vqwKKn75QKomRvLleaYoOCyJZMZysPbOJdz0OaXcvLIsnGQ
139AVt36LG0KDyH/Fnv3tA/oHRRn5dPbDDKki4S481PXcOASvLP1H+UlvWSnJdRG
uEssL9aKAL8Rw2sGrd0o/qaYm8CCa66WW7ovW3VaEx49wuQCoeeATPj3iMX/0RWq
DigwUSlWwsdxzKgD+YNfhjdsKAs4MKTriDSGo+KHFitp7S1s7oDbznlKS5RwjZ48
CyAzX80HIYmj/5JNdgwJexENG3OLu0g86FdSnor2mzGY1vKV4Jia1T1FVjLP5mUZ
OKfZkYnPJfwYceUktweX8LyVIZwbQD9qoxeryIqDcB4eRG42/oxBTv2O++PN6+7M
BBp4vMF82kTsU9APRQYMigeXfHxIvK4+H5wc4SEhjAkR7zr5XUVdl1nzJlw6xs1w
itdpKKwP9pxJgVH6onFVJufw9jdeV9CUXQJhZ9jLhIl8cx74uBPYXNjzpOiNFUoH
jDLddq8KeyFXlT+2g/yg1zEhazcqVBYdjDp3nq5lm+ADLbn1FGs=
=7jG6
-----END PGP SIGNATURE-----

--9ibEdqmUBL5zAej0--
