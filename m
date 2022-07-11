Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57856D2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiGKBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGKBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:47:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE8175B1;
        Sun, 10 Jul 2022 18:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6nOj6xx5Jam6PZLZ1OADbbDNbL822ODAXj4ZY+tMSX7ITY/Bo9s+WW2hObkkkdNKP2k2AvtGdpybQu5QiqNWd+T0Ll9m06kuXxd3oHgIhRM1kN8nQmvB0y09yes4AA1sATjK9yqq60Z0ZFv41yealRAgD6P1kPzhABe0s4xyVi1GAF+QdZsutWO1JMninu/Mput9G5cXqWuT2ljmAW0Z6A9qs9oWpHemyxFHNiqRRHjIZYold3nkqmb+6sjGKVYq1QzSM6I7Vc3R8GDmQwsgYcDLKZ+7Cy2FhNIZZPx8A1MGlkBrX8n3qlCW55gjZF9czwty/8Yczlw4stbNLe6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2+goWM+5u5S05hN0hG/a5dzdM3G0DVW8pzz+Jcn2rs=;
 b=jh+TibJ4/u5R4HegMIjNpkwRYagI0EC/k+1fp6ObS/aldwRTjkHuLPSWzaK+6alTsRwpaWDC6xZxOZ8FIpT17tbScUGNqL7bmZ21V+3mONwwA/Icy06BU6qjLTGluJZgCN9EbvJ+2bHL5Or6vD12QB9ApRop4k3QAY0tSv4z1XP85pSg4CFbEIsuJDZlUFxKVrI4SqJFAKiYOAurcQiHDBbq6WvPN9xTFsug/fG5iZwayogGXc1ieh91o5uzrhdfwqQu+Du6WGOh0aYTh7OfKbkkf4a6KhqSUP2aKmioXDLpH9UQzJqF8WgMyws322EbQMMlCUPksfXklNBCEV/Fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2+goWM+5u5S05hN0hG/a5dzdM3G0DVW8pzz+Jcn2rs=;
 b=qr+QN2NBJhh4WGXgVydzAAaCWKodN9/CgEDwwMr4hLCG93eDcqGqOrNIf2Gy7nY0ygCz4a1dsFkNA3fyIdlee94bAcv+Rii26kcc1DRyPTZxXqUrxkbRPOPFPYWiptpSid2kNgy7kixGU3S956SJXeGA/6IcGCXsF/sa+CINi1Q=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 01:47:31 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 01:47:31 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/14] AMD Pstate Enhancement And Issue Fixs
Thread-Topic: [PATCH v2 00/14] AMD Pstate Enhancement And Issue Fixs
Thread-Index: AQHYk52gBr8htQJOTEuIxUKdsACbHq14U4YAgAATUAA=
Date:   Mon, 11 Jul 2022 01:47:31 +0000
Message-ID: <DM4PR12MB52787D7AE2FFB473E4D15C4C9C879@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220709140835.830084-1-Perry.Yuan@amd.com>
 <20220711003010.iofsk6xdyxkvmsnl@vireshk-i7>
In-Reply-To: <20220711003010.iofsk6xdyxkvmsnl@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-11T01:47:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f76385b4-1871-4c4c-803f-b35f5a8dbf87;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-11T01:47:28Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 981ad2e3-80c3-464c-b0ec-41e346d7338e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b86345-78ea-4903-3e33-08da62df51af
x-ms-traffictypediagnostic: SA0PR12MB4477:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCxw935lmqNBaJ1J4dDL6V0Gw5znkLVTBZbhcV8hCkvnwzocFWs3iC8MSpA8YcTQPvTteIHnOaOU+50Bh5ShUNZc1OgCmvXAQWTQPMBc+FrK16fuzHdFpcgA8nOi0z1skmLANEP6OnOAghpNqVvZWCfDA0TNvS1k1RIYfhhM+i6+0ZLy7ThYmjyu/DdR+ggQxoxL7zHwLlo3XJCHNK/20vIXUIFJJcxYjj0TzTDnZoo8dxNCsKRbKKeNyGHhx1I3cPa4DMdDy6xROTpG66De7YrLQwGNsz+uYyQ2HbuvJCDtUNKSYCBs2bXRKTArm+6xXh2V7x/Dvs7+9K0nKyzDJxV8UoTh8+M9FFTfykQ0LHluf4X+on3QjKaFvr9ERYoCWUwg0EZE8O+i27nsyaz2vQENLI4AujIxL4BkA7JMk0JDssZYfruxd14fNJqjVx0YrL4DLOw/WAzv1DbCJe7zMF0BzOMQBvzQmJbe850SWR81WWD5adoOT+CGAss6J9grmCuNkWv+6f/ngObRxuBmuAEnX0jJpNUHxUsEYTlxbkjxAWqfEEvvkLM57vZf3L4XrEKTWPvW1+ZdhyKOiS8Lqfik0ZVWglTwoIUNtl2WMkXASTroHdPZYcvQnB/Lk0wZqbl2fqFQ9ciiXrmVWgecbwu+rvzfY8qgnHKtQoHfQPeCrxNz1uNGaS9GcwFf46NpUdHaavP1mcuQz6E8/ycqPBnKprtwRle6G6R2jq7el0LHEJvMuPZZQoxO0spV2fq//K+0B7OoxyXvvhKYxpy11YOykOfOPDaVTFAO3LN+/R//4pcbCXllEG7wnFUAQkKs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(5660300002)(8936002)(52536014)(9686003)(26005)(55016003)(83380400001)(2906002)(38070700005)(38100700002)(86362001)(478600001)(71200400001)(54906003)(122000001)(6916009)(316002)(4326008)(8676002)(66446008)(66556008)(64756008)(186003)(66476007)(66946007)(41300700001)(6506007)(53546011)(7696005)(76116006)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y56FSQ8Sb5//tKFrioC6CceRHQEUjKLU12oiUOqt1/OUOSpyK861M6OkGVxj?=
 =?us-ascii?Q?wA8f+xoGWNngAbe6Wvp+i4SkVt8XTNoMlieW+/NT/tpzdi57z7YxbUn/fseg?=
 =?us-ascii?Q?V4c5ce+NqNcsHM7JL/1K9Sd4HFuKmRbfO1NTlhpvxqiOvQujbEm1vTY/WasE?=
 =?us-ascii?Q?CVrhHUb2CbrM5gfx8Kih1IloqqvAxYBygdBTelm1FMa81bX8qfYv3+QeXsa3?=
 =?us-ascii?Q?Ueh+/q1z2Mimmw7+eHekj4iqdguGPgrPvqSfpM3MruIyDnk9kpz3be0B26lL?=
 =?us-ascii?Q?03YGjTSUFXSMW8G68I2A7JWscU+E6U/M5pUlKC/wZ6oTm8a2MeIRh7Is9eRM?=
 =?us-ascii?Q?X7iWcs/ROy3Aslw72iEkVq/QQYgft5QhRQRJDy7wg7CA3qFejYFHq9dVBMcr?=
 =?us-ascii?Q?e+3ubgUdQjlRQA8HAbAJsfllagsL7gFHcL3XpUYN48XFGqQcrzbPRAaNVMIp?=
 =?us-ascii?Q?Ghz1JJpPtUOdEKNDryxFYhhFIXsX/KUyN6RKnGSSBoA+P5A3x66jLu0ymgTy?=
 =?us-ascii?Q?T9u+Uu2jR0cz4+OBXvm+U5M71Xglt+4HGeM/1nXcP6ugU5kt/5G6qrNj3l8n?=
 =?us-ascii?Q?uEQcqW5GTw+Wr3ssA7Pt6+MFKHolCRJsh7+ou0wVvlwPQibYU2m32zFHloxq?=
 =?us-ascii?Q?5nmOdUjg8KkIKF2Zr1UnYya2BHOZANtU9BzbsgLlMENWGCckoA7iX8hPZ56w?=
 =?us-ascii?Q?nQ7j3I+nNAN+AfogPNuhFEaC+PWwDoCtOG6iqvGsxBovYpRPuM3D6fnI4CVX?=
 =?us-ascii?Q?a7atKo+wpgpF+IQYWgNuY2AIcBEj5f+U9c2ZFyfGeGsxwfIZe59fTDafkzJd?=
 =?us-ascii?Q?QYDJfeuEUYx5QyPLj169WTlJEEaK4hur5MSvfVReKs5hbllqqxP1hbivUnol?=
 =?us-ascii?Q?4KIGqJHQIbWJ4G46Jb+sazSbp3vO6PZzGFD366PZzxADu26n1c+kGpXKKecJ?=
 =?us-ascii?Q?wuQKskjsq/k6pa5q66fiTWjigSCXVToODXp0xRE+GFWqTokL/e/x+CAdq83T?=
 =?us-ascii?Q?7lv/NEEPrXXTMsEEwsUg853kt6Pfhc2Qt1XtQM8UPHhMFeeyHnZ5BTkPvieo?=
 =?us-ascii?Q?0kBIHWKHBn1r+LODmpytPH8IQax0lBZmdu5MoDCbCHmk9hWCium4t0/m4EoL?=
 =?us-ascii?Q?zVbRWakZeYT1C/JXewl9QlBiBck16BQ6wAXcVdWfDoPwhjer1UccMSeSmaeU?=
 =?us-ascii?Q?dlIxIjZeuaozpBczKDNQ4fyzvD6066jPYgGLLwdLmwkmNYXuRpKkhvQYNVDh?=
 =?us-ascii?Q?4DvSUik1haTCLonA+gdAnO/WWhpdQLUVZaXw429v7dDXGHh9fi2UY1pr7l0R?=
 =?us-ascii?Q?WCBgSh/j0ZA4ZIX2qlr27z7iSid695QTZ8BggDUuD6EjTMA6fGp6k48j41Lj?=
 =?us-ascii?Q?aCaE8bIpCIBx+xC9Vn/4k+hQ25dw/ox3V9ZOns+DxSnTlt9s7IhKrfe2mvyJ?=
 =?us-ascii?Q?qLCC7GiW0gnztyjMor2+Ybukk95e9IsAQRIjsEoRHnAnf6+HhINH5GH07d3m?=
 =?us-ascii?Q?w1AY47Q7dgd4ygqiq0heIRGUl2sf5V39hikDIUYiE9XgE3jU2xKcNicf4QSs?=
 =?us-ascii?Q?oQbgt/mHOsWL424xx/cXpcT7yms5wTv4gLeZsbYe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b86345-78ea-4903-3e33-08da62df51af
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 01:47:31.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcYK1xOsk2hp7FId86QfnMmRROb+K8qxnVMfVG87fDKKo6VmVlDIitonKNcDhmvMuB53cuh9KpcR9vKXteEdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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
> Sent: Monday, July 11, 2022 8:30 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> Sharma, Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 00/14] AMD Pstate Enhancement And Issue Fixs
>=20
> [CAUTION: External Email]
>=20
> On 09-07-22, 10:08, Perry Yuan wrote:
> > Hello,
> >
> > This patchsets adds support for precision boost hardware control for
> > AMD processors.
> >
> > Meanwhile the patchset fixs lowest perf query and desired perf scope
> issues.
> > Update transition delay and latency default value to meet SMU firmware
> requirement.
> > and do some code cleanups,
> > It also exports cpufreq cpu release and acquire for coming amd-pstate
> > epp mode driver
> >
> > The patch series are tested on the AMD mobile and EYPC server systems
>=20
> Please use "--thread=3Dshallow" option while generating patches with git,
> these should be part of a single thread.
>=20
> --
> viresh

Got it, I will use this shallow thread in V3 patchset creating.

Perry.
