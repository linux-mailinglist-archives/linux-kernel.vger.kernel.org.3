Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3EC530B64
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiEWIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiEWIZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:25:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0A56431;
        Mon, 23 May 2022 01:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5eUOuHh38vsNzyujHO5gSxIOwNzQ8g+I9tlrrQrd3SjpUkXDbHmjnJXEovYl55u+Fwk83RtqbzfgbuowBeQ/deaGaORnKyQQseK7zESlTcnKqndeD94IR68D5nc1nRb/Kkx+wO1E6K8qhQXNp5ZINEvCIoIUI3Z5MvlbbHQ4znthjNa3HQrl1Az+3QkPacMPcYqRBDbLBLl6nm9MWH57lmRo/pwaKeIDzs32hOalz4B2adRl+9Lb4bPN/Zmxo7nprQgU1NeOdhZSZJTwLDEwsbOk9C/umyEK5oOYT3MolFsYCaqsti5wBzyJJuMkY1g32s7UvpUGiDvyrfqED3Oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXizruybj1Qs5gl7fqQ2Vn+F4IDjtP338AIxTX0jacA=;
 b=d4A9XLN9bdXzGBGpWtPPNFJMOP/XYNaciqo/3FhKcG2Q6CL6xinQU89lEjB8DvWv18HBxFQCV3GWzdOK7RluIyrnf5nXkIZmkuBWTeGJeLGvGOlRoyZOS7fx4hquey9V7JLz1uVDZvr9v22xvWxyv8FoVFQKd+vJdjulNpqvRQi8GDdAcOs+7SPbs41xnKRI8JPVkzcMdt/dG7RKCX2l73GLwVOL9aKeEO1ikGroG/jOU70VUIYdGDlewMn0NKjZFW0DUN+mqpdNMwOSW4clfvpmOmlqWJsopCn5lN72xSxJd3RUXAS8DM2/SWUO7+TriUsokG+zYHJng6jawY5NLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXizruybj1Qs5gl7fqQ2Vn+F4IDjtP338AIxTX0jacA=;
 b=to0B0zt2Nm7ijiW+0RXL13YKVcxC6XMruXV8kdobiD/c1rXGVhVGmn5o2wYOwVBgA9WcM7IC/krSJOhIX8kYYHEXMfbdGMP4NdI+2cIwbtFla+OHzvZCOMsoN9tHmNE5arpC6FuD0YIQwIajk6JtnImEE1mz66+jJxuAGWurR/E=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 08:25:30 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::243c:893a:a5db:1689]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::243c:893a:a5db:1689%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 08:25:28 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Thread-Topic: [PATCH V7 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Thread-Index: AQHYbdLLgXfeBE11A0GbQrf3/h8d/a0sEryAgAAM7LA=
Date:   Mon, 23 May 2022 08:25:28 +0000
Message-ID: <DM4PR12MB6351C32C58F5BA063E89D1A8F7D49@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20220522115423.1147282-1-li.meng@amd.com>
 <20220522115423.1147282-3-li.meng@amd.com>
 <20220523073201.asdi35v5f43aoaee@vireshk-i7>
In-Reply-To: <20220523073201.asdi35v5f43aoaee@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-23T08:21:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9dc4f8e7-3745-4e6b-9636-3ab89b8d27b7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-23T08:25:26Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3e26b4d8-5895-4f63-815c-97c73a4a193c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35769cb5-cc03-47ff-d469-08da3c95cb8b
x-ms-traffictypediagnostic: IA1PR12MB6330:EE_
x-microsoft-antispam-prvs: <IA1PR12MB63308B6F151A44CF232CAD5BF7D49@IA1PR12MB6330.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9JSXQlOWYYg5lRZQyT0hL2ljXdUJS23+oN9RbKOtA3s2RRLJGtGA4v6hsTJ5GqeWu3/tyFnm/3/rWcjEt0f9ucI5Nbvh6ktmlk6gRYVtTiipciOgU69IyKoNk4/i274yXG03GWVWSPOaofOdCGFi3hhUw82VJGIDJzJExk8hii3TI/xE4Sopwkx26aDlmrPV3s2qfep5RPUSR6a4DX+zqklPaC6E/vF/K8sDBhkrTlc1stcII5AcblvehdFTgt7Apj6AEF5hlvEF/nK0LU9uZks/gkAgEK8I/hfNWthgwXQuHqsFtcsc/lomb88DMhiyFesb0AuTP+ba1a9xTufB4zynOomGbmF+6yuT7JHCs7iF2zOn8LdWSAR3wAVt64IZ99K4cspeuv07ox+fopI3hsOEYUQ5a+ME7M6aEBkehopsM2Vgqfx13jZsQqJzvLHE/EN83HV538OgeTIJpktxkPu4cVfG3PQfudtbRsCAnwUFszDdyS4Opq34by/5Zdsu8FZitvBkEwAXCGfCHlxTUwFd1B91PSMSsvhuLkEde41gcfjKV9mcfbDiMux9/dRAXBGVbMZowXmOO+FVlUmwadPAWjp1YwMGWbgUfciLsSuI5kcj+3A0bEbpnckNBeGtHDVp8H2rmCNvGi33tamwG6z8Jh9p0XW6j5YqYIba3mUD2RTAXThNVz1iDKRmzSswCleQIVsaiFq8LTrKjYMmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(86362001)(9686003)(7696005)(8936002)(52536014)(508600001)(53546011)(5660300002)(33656002)(76116006)(83380400001)(186003)(122000001)(38100700002)(38070700005)(64756008)(54906003)(316002)(55016003)(8676002)(4326008)(6916009)(66446008)(66556008)(66946007)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3/BLtZf7yay6I+0sfSoPMhb/5XolqFfshbomnNpYFzFbJOf5tWhZtOL5P1xX?=
 =?us-ascii?Q?zvOym+TooEzXWfYYNHqVpgTM6t4r05tFFHITPMd5D+5XOUW4wGjYWHMZ62fe?=
 =?us-ascii?Q?m/unu9ybrBRju2CSD8Oz9aFld6zmz9jruWWe3XB95Nep2DrGf/hM03oKFJSP?=
 =?us-ascii?Q?pmcpHx+z8vYmTWSsjLNuJJyMxwzvRS4zsHE1Xr9ueK8XDo/qWcXVe5uE6X7W?=
 =?us-ascii?Q?OVTpu406O8rcEZMelxd3X+fEpEyqtR0JNUqvsgOLLzYL9St2+Vm2O1TiL+jh?=
 =?us-ascii?Q?eZ1WKC1Dt8ZCRbT6ZPXTJ0kYZ0udK5ub+auKpZr6iTC1LG11RmMcUQLsojR/?=
 =?us-ascii?Q?zJuKOEiqDWvvGFMMhlrLTXCAP89X0noXisWBgXiJqfv7r6NhbI61ZHrPFU2v?=
 =?us-ascii?Q?EbxE0b5zk4SFyybhjWSnIKvlvhP4r8haqPANptjL4DBv+9icT2TOl+f4LDlP?=
 =?us-ascii?Q?zmZJk22l70/phMiJK51PeLLSQLlXHTvT03aZU8LaYi10rjrG3/7BUqqRcv/f?=
 =?us-ascii?Q?ZofHhQRl8EgPCwHRe3wbfcPCIXrtYUqhLfjrZSUb9BaezzOIH6pcqHz3dpPZ?=
 =?us-ascii?Q?C2cvPMLaGXdwhzRym72pYwYNThUq/F3NUvbQJtl+RCl2AKi5bg3pmKderDjn?=
 =?us-ascii?Q?COTZ4PUgWCvEb482WBALTHrzxfxDRBC5ZqR4r5MOQzksYnDiGeJizNnxYdhY?=
 =?us-ascii?Q?+0tc0ppf/09K4QdJGTNtFZsZ54EQOz+XZxnHGJRV/Ckyp6GBs8OfkDJ8JeYm?=
 =?us-ascii?Q?j+Ym2tDPG5mw3RToEUsbOxLdHjcQLijfZhOoPMSWPYDSapIp1cTQXxRRi804?=
 =?us-ascii?Q?WkSwIus1Hlw3Rd4xpaUEXGi+LiTpEblIZL9KmpYbUB1TdHBiFKyzzBhKNwl9?=
 =?us-ascii?Q?HG8EPOLynTaDXE3udeS299hERC3oCHLXJ70U4ak0eOILoTp1/hAQVOJd9Vs2?=
 =?us-ascii?Q?1sOJcR42GnW1MwFDy96pEZ+LrWJuDNkjsQkW8qXq6lQMSxh0uPjBtGE8Sehm?=
 =?us-ascii?Q?CTYgfhMa2gYmmLPHhfVoBFrbshQzUsgmcPi8qdTV/StawtPVVa7DxwwvUTrb?=
 =?us-ascii?Q?gso9RKYNuefgKAvCrt5ZEFEIXPOFmhukghm5C6N3Rd+xTrCUi2d92Djz8WyV?=
 =?us-ascii?Q?dcCOg7UIfJGOvDN17139K19N8Hilc+Euc+e1TJmHSxNX3lS6XzmK0ijPtET8?=
 =?us-ascii?Q?HGdZ0PFFcgRkgXqBSSTogCSjrcmjW7gHuGvXX++u0+P1rwnMr3bOi26cpoZ9?=
 =?us-ascii?Q?pVtuPtE8keo2sxiDU3qg/J8xQjyJ1FF2zuX8j42ArrHjciuPyR2C4QRuB18A?=
 =?us-ascii?Q?7SR5kq0njbvRYbGXwqZtvAjm/05oDrBWH8MsZ/QWh5dbK64YJbJQlDn+lXxJ?=
 =?us-ascii?Q?S+YSKWrt7PXPW40FfoUq/5KyimaoVCu6EHFJIfas+3BZg2GlnCdvQAd4ZrRV?=
 =?us-ascii?Q?RdgOTcMKYPKnYww6uYUbcPa2Xuv0c1HbjGxUgOxn9ZAX8XNG+mgM/s/p3boT?=
 =?us-ascii?Q?tyAvTVnKLNXpAcjjr2NKnpZek4TVzePZxTxN/fpidfHxa2drPVQFZyesCo9a?=
 =?us-ascii?Q?NC6CYlKxDYmBptR0E3ErKC2YbqFnjPB+ByDfGaGnhZKqNoo5Qn47W8kWdtdD?=
 =?us-ascii?Q?r1sxQB+ME0mGoxjAP3O0YakgehQJje+H0PAOrscnu9fnJ+ir2s54A7MQ0VHT?=
 =?us-ascii?Q?i8IjncH7yG1ba1YdrO/aF+AY5M/yNH/tkyTpcicbUSgu4SvwtdiPf06iDx9c?=
 =?us-ascii?Q?tO1h4zavZ0Dd9lnpLhVctZnua6xOMx5AfMGMgQpmif1g2S+1lxjzhhYFk/hx?=
x-ms-exchange-antispam-messagedata-1: zGp8oGF3VWxDCg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35769cb5-cc03-47ff-d469-08da3c95cb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 08:25:28.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Bz+LNoQ6POIx25Kzs1mr+L1/nI3WXDcDwT9ZsYINuGG2GN4auFOBlUEMe89Bsp7Xwp0+j+AGFrQ/MmuvSGFnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, May 23, 2022 3:32 PM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>; Huang, Ray
> <Ray.Huang@amd.com>; linux-pm@vger.kernel.org; Rafael J . Wysocki
> <rafael.j.wysocki@intel.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Borislav Petkov <bp@alien8.de>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V7 2/4] cpufreq: amd-pstate: Add test module for amd-
> pstate driver
>=20
> [CAUTION: External Email]
>=20
> On 22-05-22, 19:54, Meng Li wrote:
> > Add amd-pstate-ut module, which is conceptually out-of-tree module and
> > provides ways for selftests/amd-pstate driver to test various kernel
> > module-related functionality. This module will be expected by some of
> > selftests to be present and loaded.
> >
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/Kconfig.x86     |   7 +
> >  drivers/cpufreq/Makefile        |   1 +
> >  drivers/cpufreq/amd-pstate-ut.c | 293
> > ++++++++++++++++++++++++++++++++
> >  3 files changed, 301 insertions(+)
> >  create mode 100644 drivers/cpufreq/amd-pstate-ut.c
>=20
> I wonder if this should be moved to selftest directories instead ?
>=20
> --
> Viresh

Thanks.
We took Shuah's comments and put test driver under drivers/cpufreq.

[Meng, Li (Jassmine)]=20
