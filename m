Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70335A5BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiH3GTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3GTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:19:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733EB6001;
        Mon, 29 Aug 2022 23:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeEQThHezNCZjCe+E5VIgCu/vHdltCIG+LxXR1hayBrpmanlVR2iOG3dcN1a1fcLENfDQ7mqIchhkGzFizehzdmsf2MVSlzS+SrqCNP6SiESL9SsqZVqZ3d6LNJ1s4zHYGAzBdZTUOtANrK4AOvmvbzlkt9mUYXP4V0ohD5DzOybYI7p25/nIwl+dZAPl9eaBe1xNNF4J4cONz2yF4mjqAk5ziZ3z3pcwzXcJ4oUmETGinx3m9SmCmREL+B3jtHS6KIasg1GQ8i/+dHqF5nVuJu62McNO2cV3Ee8KsvNiOe7Fy7qVyoavNXUGf8I2JmKACPexgvjwUSXnQckt5dDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr3vAdQAmtJT9at+r7GQXSkLiOllYoNmfW2zBkTfrVU=;
 b=fophDMa8CSxL+LOxygRC2rrtlcjL9AnB4ANqJ3pTSiB+eF3G8HlC1PIcqbZ503z/zWDi5rtz50no/dwaEymNIUT+WnK/78MhcWLgw8lZ49kJH95+7xDbyXWVgXmFgIdJigMHV/o1B9hSSOdG8kcxEKUV8zAkyGpDAjWsmpLxOkWabyt2+GcB+vaMPzK2M9oyUlnpzbhFqWhwQqEILrlPMpEwJjEqp/sRmlaDwuBCpVE81tzu72cvcPcpTjLeHOu4tF/RMhXUjO3bu/nzXse53yPI9HyJMJAOJqeECYr1V1t8mULd9/tolWXMTuq19bR649XhN+rJeI6Vjy3R2T0l2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr3vAdQAmtJT9at+r7GQXSkLiOllYoNmfW2zBkTfrVU=;
 b=QhQenu4pMPK936igbR2Od8nWsg1aJ9ewyQliO1JxPlvJWzQU0GUvmqmJQlTduQrHAx2Cr98tvUz6ubju7xFU7NwJMHZ4AcIrpe8/OV5UPqAl6ja0A/LHJWmDzx3o5wzFb6HHqQPRUsn+lOPE0mnt6xJVhrQbl5yeBrp4kTE1CFA=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 06:18:55 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 06:18:55 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     "quanyang.wang@windriver.com" <quanyang.wang@windriver.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Michael Tretter <m.tretter@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: zynqmp: pll: rectify rate rounding in
 zynqmp_pll_round_rate
Thread-Topic: [PATCH] clk: zynqmp: pll: rectify rate rounding in
 zynqmp_pll_round_rate
Thread-Index: AQDcf5P6NtAgSeODCl3uhXFlQArgNa+/b3lw
Date:   Tue, 30 Aug 2022 06:18:55 +0000
Message-ID: <BY5PR12MB4902F502F67AEC1B575A867281799@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20220826142030.213805-1-quanyang.wang@windriver.com>
In-Reply-To: <20220826142030.213805-1-quanyang.wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-30T06:18:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d888d5b9-7b67-49b9-8b13-246118464707;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6fc677-ef12-45c3-c00d-08da8a4f8481
x-ms-traffictypediagnostic: DM6PR12MB4925:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nid+uctTGmWwz2eP1ujJnw+NOZx4Bhsuwh3R482xFNriKTm3+axefKxzRbNjK8TUIHVksRxfrdkxFvMJKui3owzwv1MUONwXAew61n5L9x7A9inmzI7/igt+akhKuDt1jTEA4gvwqlyEbB/clrLuenO6XbIpyg76kwrgddyMxc+4McE3WuirLbz5/faZIrlsEG3MugZRTN8BNGSXMVCwkHpNK+pIZVnny3s6GOJlM2GhL1b9gqmIzD/uBys7QYH1wvnUiefM/C0DwtC7A+cEw8AIfHorcMR0Pu2awOavWJEDEAM2KlvrSF4sWg/6eRqlODChUzDjPL1U3qI1EzFodbMZjSRHOYJiHV+jOHGP6BLqeaqMrM8CE8jMTW6hLwiOPJWTTFIbFb87oT/+ZLpT8fEnfJrjBGZcvSgXrDK9LdTLzcLez5Rjh/OYVsI6q1SArVU7qNdW1Qh7FTzvrfF+ctT/QfbATdZd1UaaHLecN669hBtd4pKo2rbuYPLhF7yELjxHiFrOjod5YdUhji2AdaAowE8XqmHcP0iOBvnZ6a6VogQj0ICdG9usSOmcwxM2uPKRmWFoXzjzzxFkcZMjBuCuBFH0U6E6Yg5/sC5DF3eiAsvIEeNUbXT3CGmVQwZHFRAUiYxcqeoDSPI4ixmBa9yns2jLh9aVe00RfZZPfkgsdEZeTjccdgwvrzQ8nT0O/3cbRS1fVgE34xnj2cd/4Qx029WoAMnK2X/VaMvAWOva9B0xcIOToBNttoK9pL6KBoxTw2ey6VOetPAVCxbKmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(83380400001)(55016003)(38070700005)(86362001)(33656002)(122000001)(38100700002)(66556008)(66946007)(76116006)(66476007)(66446008)(64756008)(478600001)(4326008)(8676002)(8936002)(52536014)(110136005)(316002)(71200400001)(54906003)(9686003)(186003)(26005)(53546011)(6506007)(7696005)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bW2XDQrILr2sCVON0CTjhJKSVV7WnSRK7mBMAG7KjiynzHnwxdBh+wEs61ec?=
 =?us-ascii?Q?eDjK3tN+1bVFTb+M8kgXjebln14tjSPgekH+J3Qn8rOo0vmr2yfS/0wVywms?=
 =?us-ascii?Q?rfd4LvmTBRLrWaKlj6FPONR100hnOSJdvbRgKKwNl4rpPJHsfKhsbaAyOOv0?=
 =?us-ascii?Q?Tud9QP+UN4IKBDF2C5bfH29nHZ6dotmEd4Le//9+1VNQrtPheiwuAQtJTF5/?=
 =?us-ascii?Q?GPhm9kdgmd7cBsZms5BMWhbA8PHF/hxyNeN8cpYZ9PIiNKLoAoqerxE77BxC?=
 =?us-ascii?Q?nhLldSDqm/oIgSXerTGwLTNRrBCgjEHKhDjPl/Kbe/IiCnUxXGWUKtGjDhdU?=
 =?us-ascii?Q?a/i2xdnHuB8zeMU4kBc17LQEH/z23vmsEqFhAZGEaoTRBUsGTsx9pScNsg3b?=
 =?us-ascii?Q?PQZRPCfQLAoyQHX458bl5paYs+5dZPI3I1WAwsC0ckLrwI2G2Gx8pxq84Xuv?=
 =?us-ascii?Q?pAPom5/a6E/H2HcJEZYPaEKlPsVnhSmplhSc7TZQTftY45Cg0j41ilPE7McG?=
 =?us-ascii?Q?44Re87BVIAozEyJs+XU2uyOJE8JrqSU8c9l/BZ0Ks+yv9bntwa10i7BB7R64?=
 =?us-ascii?Q?ifehRogoxI+dGPjpTO4H/IJuSTB4UUjuvcyO12Z8cSSNkdYIfaFiBkOBCRTj?=
 =?us-ascii?Q?TSNJlsSCYWbr3Ul1F3lL5h5ptvqTzyC4yQ/OtbyTVgR2XkCzrF1wdTojIyaR?=
 =?us-ascii?Q?wGrLyNGxXrD2RXSYIcU6m2Q6XIbe6rHF/T2uzRHUfxPPLj6dlkjys9SKH025?=
 =?us-ascii?Q?vt5I7HfLmdqejM33bTHauylmW/UyJ6eUkJX0Iz2oMkHulSziHIfSBJ+ZM70a?=
 =?us-ascii?Q?7C5a+YAu4IxLbZNZTgaB9rEAZxu0W62OstcvheUPESHcPr/zAn2HSA5rF3cf?=
 =?us-ascii?Q?Ei4M60hbW0BytPfWaa1zmYEDKofM5PMLyfxyFmIVtHQqd2XpNdOa/Pyf/5NM?=
 =?us-ascii?Q?wKQd0QfDGbwDQzuRjAZx6LosXBH+vGHefwp/7kqg8WUCygpr9spt63PGgi3L?=
 =?us-ascii?Q?/2b+4lNRWA7ZGPCqdSvB4fjfvS5SVcuHoaTmVfaqWwi/F5WCibwYWJoq/jRo?=
 =?us-ascii?Q?i3Uhb6ub7T+bFvYgUNRaUjrUDdrws3ok1c1b9ynV5uVJZWNLjXmpCsIPntSq?=
 =?us-ascii?Q?KAqASOIlUpt62hCPGxYrzW8iehtpCs+rYbmPdWElBYGI/QNBxKU3VvFd/BDq?=
 =?us-ascii?Q?lwmatkcbauinVKCONG69r011nj2GbpxC1smBmCmzFVW6B+JGuVxRq8a6z0FH?=
 =?us-ascii?Q?oHiIUFyviMWDzCzEKyptLGkwKeldaeOUO9rD2u66XFrofDS/GoPptR/5TwEu?=
 =?us-ascii?Q?fYP0WuGr32huplOvJzIl/NLkhPeuoUVejmmnDLbUoGn7Qapd/Ac6T3nFOD8z?=
 =?us-ascii?Q?ZvngorR5z9ZpO19n5hMi2KPHG0OHkZmQkIx+m2zK7yl2UUuCJrmg35DI2wge?=
 =?us-ascii?Q?lEeNgwwOgVmbhG/KhCj1q/ptvCqOSU1s5DVugW+zofpnu4K3qFg55/1H9ejn?=
 =?us-ascii?Q?NxRwQxklCq2uqF9quAnpusc1AZqT7oZx9qJyfIfj0iuX36a+PCh645BJG3Up?=
 =?us-ascii?Q?8w3DtzSyoiA5pufsLvw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6fc677-ef12-45c3-c00d-08da8a4f8481
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 06:18:55.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkqzJULLjtx0dVPSQjlJWy5TDT6cD/5ImuvuNcsxhtKGfFWGSsY2HFUK1KWGh0gk+WvE6BGh3xCmiPBYNyxu9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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

Hi ,
Thanks for the patch.

> -----Original Message-----
> From: quanyang.wang@windriver.com <quanyang.wang@windriver.com>
> Sent: Friday, August 26, 2022 7:51 PM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Michal Simek <michal.simek@xilinx.com>
> Cc: Michael Tretter <m.tretter@pengutronix.de>; Quanyang Wang
> <quanyang.wang@windriver.com>; linux-clk@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] clk: zynqmp: pll: rectify rate rounding in
> zynqmp_pll_round_rate
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> From: Quanyang Wang <quanyang.wang@windriver.com>
>=20
> The function zynqmp_pll_round_rate is used to find a most appropriate PLL
> frequency which the hardware can generate according to the desired
> frequency. For example, if the desired frequency is 297MHz, considering t=
he
> limited range from PS_PLL_VCO_MIN (1.5GHz) to PS_PLL_VCO_MAX (3.0GHz)
> of PLL, zynqmp_pll_round_rate should return 1.872GHz (297MHz * 5).
>=20
> There are two problems with the current code of zynqmp_pll_round_rate:
>=20
> 1) When the rate is below PS_PLL_VCO_MIN, it can't find a correct rate wh=
en
> the parameter "rate" is an integer multiple of *prate, in other words, if=
 "f" is
> zero, zynqmp_pll_round_rate won't return a valid frequency which is from
> PS_PLL_VCO_MIN to PS_PLL_VCO_MAX. For example, *prate is 33MHz and
> the rate is 660MHz, zynqmp_pll_round_rate will not boost up rate and just
> return 660MHz, and this will cause clk_calc_new_rates failure since
> zynqmp_pll_round_rate returns an invalid rate out of its boundaries.
>=20
> 2) Even if the rate is higher than PS_PLL_VCO_MIN, there is still a risk =
that
> zynqmp_pll_round_rate returns an invalid rate because the function
> DIV_ROUND_CLOSEST makes some loss in the fractional part. If the parent
> clock *prate is 33333333Hz and we want to set the PLL rate to 1.5GHz, thi=
s
> function will return 1499999985Hz by using the formula below:
>     value =3D *prate * DIV_ROUND_CLOSEST(rate, *prate)).
> This value is also invalid since it's slightly smaller than PS_PLL_VCO_MI=
N.
> because DIV_ROUND_CLOSEST makes some loss in the fractional part.
>=20
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
