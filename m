Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8F45A8EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiIAG4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiIAG4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:56:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08CDC3F4C;
        Wed, 31 Aug 2022 23:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRMvRuoLypYrI17qLkJwKSmjgrSJQp3t7QQmInU6jtZQzZd0DMP5/sxh+YWqyu5eW4YTAKsBm+g47HA23aCLYRF0+CITh8AwvAC2JvVZLG85Onykw2fP8tasuKjT+7+0PLQF9+yT0FfFRiIRPQQVkUdegyNRXDqRjOHPFUMkAGn7H9K/oyxGiBfVbCHslgpLhJT57tefkuBiwSnrC/L7ZecszJj/wJDBUnHupg68MpmTsPmv3sPZfKegcVzBemhaecntAYYBHaQFrMZ+ZaOSCegkcuaYjozx0kN07eYw822ExGJOsUo6L/nsc9hr8q59irtnERQYLq2+R64xn4HaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlqmB0s5wLoiNEtVlOppEG/ZTrJ2zmnfrbJ8eJFGZzQ=;
 b=JM3KKvnEVeKeFqEi4lNV8LhnwGHiNYgKptmMouaxUT9CpFCzX1zrfWL9Yn5hPWputSJjQb9xwsDwUoh7nJ+ih6eTfwyZfJs7oyBtkOheWIVBM2mGgLydnhpDmktt8X05VLO9ZxjtSPcoGKJORQ3yVHZl4299SYM2mPyLB3CAcnxIbY85aCuxXWU15Gvnoln27UmrT74jOVE0ZNE1XyC9dAwA273SbIJmwplADbfhb5h2bj1AbsM4aUEgQTsqkKDkJ0icQRlUOymmP9ydcBYbd8tOvUhGZtkqYvUpU0Agk/JYy5d8BTxce0+OCdtpSGqEGGr3RMGXKiqEeerj24KmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlqmB0s5wLoiNEtVlOppEG/ZTrJ2zmnfrbJ8eJFGZzQ=;
 b=nyIBPstbocgLOyqdqS7Hmq4uqv0Ea7WUt1TkrYQ/IqFLliwqaYsa2pRYBWW8xPS0CxC0o7UpnmP6+yxFeWLWJQJnZKG169fTNySQpypVEeDMflPBBurnrsE23gdgyNC3rcNMpwVhCbUdBKowGZ4vT/wRUpAl7aJnej11JSfbmdE=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:56:46 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c%8]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 06:56:46 +0000
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
Subject: RE: [PATCH v6] cpufreq: amd-pstate: cleanup the unused and duplicated
 headers declaration
Thread-Topic: [PATCH v6] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
Thread-Index: AQHYvct0m9i+1ckBBkKHTFOVc8xFH63KHXWAgAAGJHA=
Date:   Thu, 1 Sep 2022 06:56:46 +0000
Message-ID: <DM4PR12MB5278D01EA2D78367F182C7C69C7B9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220901062339.2357552-1-Perry.Yuan@amd.com>
 <20220901063153.zutwnnfykaz47sah@vireshk-i7>
In-Reply-To: <20220901063153.zutwnnfykaz47sah@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-01T06:56:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90f69e70-c5d3-4ce6-9240-5ebea8c48b72;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-01T06:56:42Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8eb82365-7c7e-40ab-b233-edd13cc7ebbe
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abb0938e-1754-4cac-d2cf-08da8be7229a
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+WWi4rnMGcmFvw6mKO4bWpxXYXJFPN2vIdU6yhcBPwU/t1/PrGYu3gvRvfT4IpTOXQ9uRS1XrYXwy5DoE9ymd1fz0hdGwlRDU/LE8E6D3FIaYNCpGa/d/dT1nEl+9peeGuo6LOpwR52MR7X10alRYHiGfEfk7+w7HUgduDga/4P4i9LlqJj01k/T2nwqFBrP7m+ArAqohrfzSLXi2TUaX46K5h76VdRDlIqNtiFbIfqpPydz+OTC95g/VwCN9O81KXd/8ewRf4NqtmM5IjwCRUs1exPk56iw1LhnnIkqBHbVc+JuqMezLoj1As2H2k92hb3ZyG3mTiHYWutPSKK4N5nSVRNWXLx45QN1qgEQgCGCMARls5fSGHyldTRieMuWXJhLxA8h/2Vtr1WLG7IK0XlouxECOusnxpGRoptZ64/GHCdXjhHf6k0D+ZfAt8uueUJ3u75GX9jXimjfX5R+B9ghx0KBqU5uYWKxjT2t6Y9fvqMM5hvtI5cFyf0rOgzPKUkyIP9aFm2bQqvXbG92RtZhr6MJzy2dcOHzYCQHRXyxNmkZXGGy3gyNyBAdWplwyts/3uccKY92XGStsg4Ij05RXJVjEbr8cOiwe4FUmmlrQbUQ7civacoeWuYt91PgyoKm31+10g/8SQokUdP/U0v0HNcnMEZZf9t5vM4ePeFcgpNcBfpmTRj7Vl4jTH8Yf6NDicEL11GUEqR9kddCSTQTF7NZZMfV4OGCjUt+m5iz9By+wOOiBE9sLBdMfWCKrMK5Z288vtSAJ0pahyc5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(71200400001)(8936002)(38100700002)(478600001)(52536014)(54906003)(53546011)(6506007)(316002)(7696005)(41300700001)(33656002)(6916009)(5660300002)(9686003)(66446008)(26005)(86362001)(64756008)(55016003)(83380400001)(2906002)(66946007)(66476007)(122000001)(76116006)(186003)(8676002)(66556008)(4326008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1pCEXgRq2GX5TUSltrLbBKm0FBZ9E/6ZXtKutGtD0gd2NjtwvXp6isVVJWBV?=
 =?us-ascii?Q?7y4QGdnbe+PPRtN9nb5BiZIbSH/emAtgoYoCfbz0ohutRLvtw/6QTFWLCeJZ?=
 =?us-ascii?Q?aJWxYtM2aH+IQ1vTfkMSB4dH+dYW2AIEF0AhunNep+RK7pNAfMTkALPdbBj2?=
 =?us-ascii?Q?YJXFMK++uSoCcSPz9shpsz1vdFhPIc7FTWe5iQ0j5k8RpQtEA10UD0G7DeQ6?=
 =?us-ascii?Q?894Z3dtnCuHVvlOObw0PWMnXhOjgr7BVusyICv1Qy4MN0zO9cKEr0easWL1k?=
 =?us-ascii?Q?l1gbPO6TlDpaqoy1LGmgO3jJmT1hzdSIo0MpN4AwWJlEftLZ9k1NIPnHBYrD?=
 =?us-ascii?Q?jVezREdOJQ3DgSeOJ/OEAXdFzEdJ9G2sMORvoaLqLxD4ivVKxWlv1Qyih33y?=
 =?us-ascii?Q?yRL6PP+W9lvOYUbJi6pi2bih/ZcTPhukDulzmNstXkOpXP7nojMwGkLrws9l?=
 =?us-ascii?Q?1QoWjJ8/ZXt4uZdDQ+z1J7kTkFU7tTV4OuF0hP6jE6FSw0pFcKZ3bPBVtY9X?=
 =?us-ascii?Q?+DhRoPF7a5gsDmtIdmzYsnFrQOus2x+zH42fXdeA9f3bDRX1WQ/iOmYW//lI?=
 =?us-ascii?Q?fQw1Z66HbhQfhw+y5/zgg11GVuroukLWGmXPfSlpR4XyV/LBXqne5iOiojIx?=
 =?us-ascii?Q?2BZXcAFFcqbXSGy6BLGsqoCIEvT4hZednxSvdQQpDdkzxgAWvUw+tcZQcKYE?=
 =?us-ascii?Q?QU8a2wDt9EBZncvwJDi5oCmPBCwXR0rUHDhexDxzx6eVCgKBzk23KE/b5URp?=
 =?us-ascii?Q?nrIsr2mAPCIGfKQHAkg2VdGT3Wjpk2aX5W0AWVTfUBqwQz5czcfCpt/P+BpG?=
 =?us-ascii?Q?RXKqIbv39CPPJXLblvbFmc7nA/QLD1DpBml1SqgTJPMZaPcwWGm2Xp/4eGdf?=
 =?us-ascii?Q?c96ldFddzpHFomkONG5xydL+pYJSNlC9rtzk3V/0clKuAmK1t/UF6M/QipjA?=
 =?us-ascii?Q?bZX8umYTWwLv+zDyJoSz9APY3OxDoSe5cx85GsgsHPTjHNPdWJK6l+6SJuX/?=
 =?us-ascii?Q?fhy34k6JtbvJTey3WXUPwXQjjursjnit985ILR2/ByEFFz8YGdFOnUz1oeQJ?=
 =?us-ascii?Q?6sWf9bo1mHMPOZ7u13Jcgw6iz8wF/ERXIJ1zhlSlhhHFM+062I4j1hHdZ9Ks?=
 =?us-ascii?Q?B1kav72ljB9vtb/cNQmcLeocx2SwYM4NV4dtxI9/elu7VRCLBpBL9SwImZMa?=
 =?us-ascii?Q?yKnBSaSiSG108YPdlAVqtXBIE2FlbKmuGfEU3lnpil0vuQ6Aye/Sjb0/ujoO?=
 =?us-ascii?Q?MvT5fiOR/a/KIOTzfGCSLWW+iDhulZO3cMAh+ma1IR7HmQ4tB94NB14uK5eT?=
 =?us-ascii?Q?HSrAcssbsmZOJ/SObcrQm3mRadYkBndaNmyeGPKUuZH2nLNTRO1yCXnqDIs3?=
 =?us-ascii?Q?mNUVBlvq4k45R/lQZEuIynpK0s/sfTPYEgjpQx7QPb1VS6G2iWu8ytdRggxK?=
 =?us-ascii?Q?sF6dC6xGr8+klpIIr7SR8xXcL92nwdX67FAiD1NGLOXzmpRa8eo778N+amiz?=
 =?us-ascii?Q?XY+RX+NhoRNeiXqz8Cxc7HziBlIH7YcLFPAXePcyXsih4H30+fbwcXFmCvMf?=
 =?us-ascii?Q?UOhMEIbiA9v3O1LFg36c3IRCXnP02tBc+ruyeACN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb0938e-1754-4cac-d2cf-08da8be7229a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 06:56:46.0468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBB79gp6Zf61UayqQmoveK5/XNBRVOJ8TmIRo+/ryreBlt3CNMmfYi2vCeejY8361TXnGTEZkc8dePB1wL23Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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

Hi Viresh,=20

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Thursday, September 1, 2022 2:32 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>; Sharma,
> Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6] cpufreq: amd-pstate: cleanup the unused and
> duplicated headers declaration
>=20
> [CAUTION: External Email]
>=20
> On 01-09-22, 14:23, Perry Yuan wrote:
> > Cleanup the headers declaration which are not used actually and
>=20
> This is okay.

Thank you help to confirm this .=20

>=20
> > some duplicated declaration which is declarated in some other headers
> > already, it will help to simplify the header part.
>=20
> This isn't.
>=20
> Every file should directly include headers they use definitions from, ins=
tead of
> relying on indirect inclusions.
>=20
> --
> Viresh

Do I need to update the commit with another V7 version ?
If need, I will update this later.

Thank you.

Perry.=20

