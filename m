Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4AB487A40
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiAGQYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:24:37 -0500
Received: from mail-dm3nam07on2065.outbound.protection.outlook.com ([40.107.95.65]:18395
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233469AbiAGQYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:24:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USfz0DcOxgZeav4mGNJKRiJGd8viOr6xZthifXRryWrTpRT3aMyRJy0Dfh7qXOj56kritF7gtTtKUZc9t32dqRKRI37tMmOSwNevIc43pKekqDxHZ6HNVXdzRTXX/ariuocRhXac5+2NiPgSKn98TvhNVr2De7fNX+g78dIV2jh9evOVkQFrkzEVak+JUEpX2vY/7DYJFUU1hFyMDd4ejEQDM0idAbwZRVhdKrKGoatjubXZrsAnhgjoqUxDLmarq52W+39NccWlBZoj/7Ln22VlMfWSs+jHgjA95UGp5jfYLKgGuSXGSU1Ow5HrrbY3dX+2Rt/wqAHziJxu2jFkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8gJ62UdHLw2Cj4AVGbnYIAzTfTBOHQLDD3VHNT+YPg=;
 b=GoXxIHrZzP13Ue1ldC8qTYSj644wycfcriygqn1PGB3XV8AGWeDr/8AaBbZ947dk/9gE1626q107QuhQzHIZgMkrnRBj7DMzdrQHRZ9FGoBN/uTCzR8ZVQECAnaMIqZtF3hwaa7IRKmyJli2a8VF9cB3XbsVyb63nJ1sNVWVq0FDRZ43L5U/5kkUIK++7cUaNKvgslVq2qZm7gTRcV7AeYYCeJOqIUTpHjMgNhDynQW3WtAcKIdNgkYzxZnsVyYrxPRUmXdgtxUKfzVRjEMorI2sH7g7ojfzm3Mkb8xSSAocWy3Avt+uuvr1jEsZq52S5iUHtSX8o6uohLPe8rcB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8gJ62UdHLw2Cj4AVGbnYIAzTfTBOHQLDD3VHNT+YPg=;
 b=JH5/7aNhC8NFfZF8U2Ux0LD/ZAG8BBd/nO4gmssYHWdrPsRU8R/AROrE+tbosubJwJuu+gUFkEu2xk1pI1wtxdJOE5uYJtNZt2mwAo2LFSdyDvTSP2kVoykJOx8Lx5rwqS8Sde+d9yyLzj2YR9EL92g+3EIS4L05LZKDWEhddOw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 16:24:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 16:24:34 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
CC:     Song Liu <songliubraving@fb.com>, Jens Axboe <axboe@kernel.dk>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Special regressions report for the pending 5.16 release
Thread-Topic: Special regressions report for the pending 5.16 release
Thread-Index: AQHYA7XblBvfsEzfWUWSWIf3niMMl6xXvcfw
Date:   Fri, 7 Jan 2022 16:24:33 +0000
Message-ID: <BL1PR12MB51445F521B0518A69BBBFDAAF74D9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
In-Reply-To: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-07T16:21:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=29d4c022-3819-4e1f-af6b-ff2464e9b467;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-07T16:24:28Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 169cab88-6238-434f-b740-6e0ca44bc880
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9627ce6b-02e5-46c6-70c6-08d9d1fa30d0
x-ms-traffictypediagnostic: BL0PR12MB5539:EE_
x-microsoft-antispam-prvs: <BL0PR12MB5539A19C9619BE779C461133F74D9@BL0PR12MB5539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lq11FVWlyGQkCiI+KWuIDiqvBIv5CgqtJnKCqlItzgw8lXXuR6bKFXmFrzdzZF2ujJCk1VOKz6iVUeltlByPtG3JmDEo1SpEoEFs2cBgliYCjfqzrDjk1xa/qDKaf0tsYgNkgTDBb+AlOmr0MN2SdgOr1qJ6CEyB16nS+pPTQpFPDMoIiUH2KN3/qjUCa5ikDmC5mW7gyKpSxX5nPuNZNdKovaCZD0jrP5ksFHkyBJmh/ycSlJwZxcHM4XEB1ItT8pB0D9aGBms6VAKgS9epqQ/8rB9Szcq7smu8qkdIUOw+7X+0r5CbRsYVOzYwB0jtazzmZe0nyGJCGRCRNtP1T3YGsdYg+XCHF5qjoMLJDj2AYnTl/Z58SfnHVOpzFuylXlJ9bLGHl79E/pugiEiubkDpNMpS6w29MuA0QAcRNl8gjOZ6+7qyTOP5PJoc+mk1fzAcyVTEFqcN5NNfJPWAKuZayjtzTRTSv1YEH3cdaQqqX/PDLkygSYFgggsCRR8Y7I7tXbh47Rp9zOpL9odvusuWbzpAbUiPOGf79cC/78pW6Ld44jJU132X0S58SSc869C8/2hSmDml48FJlSewnlTrfG3nR76nfq+EmBuNnetaMScecke4oRTaw4aPSsGXMi/YcmszpFPBo+U6hKsaNGmdoMMQv8LvD62k9LpnRnnnvUpUfFh0rB6n/PVVpT9D79UgtO3F5CkvxKXuqI/NZtad3Q6XFxuspFDiBWOKz3Q/DxAPZWW++JFFnpS3xyOU0xMVL2ebngD2/Ci2kaeZUgmVQ7bNssceVinymBdHzQP6Z/XPZ9KF9c2q3tyOIDRRaOHorFQ8M7D9mEfATNqAZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38100700002)(4326008)(966005)(122000001)(71200400001)(508600001)(8936002)(33656002)(86362001)(54906003)(55016003)(45080400002)(6506007)(53546011)(110136005)(83380400001)(186003)(52536014)(7696005)(5660300002)(26005)(316002)(38070700005)(66556008)(66476007)(9686003)(76116006)(2906002)(66446008)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2tlhvh01J6ZD34AzarTuWYMfAZNGvnDQkMLNHwMk2LPnlV8sGA1XzcjPVXjt?=
 =?us-ascii?Q?BbLxPNV7oZ6q5g1qowyH0iy29frFNVvZ7fz4Sr/0GlOMgDXCIKTIo4Nlnpno?=
 =?us-ascii?Q?JQKdvgEAm/sYsWI/sWuky91PrtWyNW7PHVrqMyy9RuI9E+9s3snZarf5bZoJ?=
 =?us-ascii?Q?a3lzQQdC1klDwNnlyT1KgQbyh8ktCiUkH0x8DB1AaQH1xRLcUNIogSez0rbR?=
 =?us-ascii?Q?d7kp/PoNBlq4hbfNaHjgnjptVb6rI6A9ug+LGDHWPEqh3COE+gXgR0JV4Taq?=
 =?us-ascii?Q?thETt7AWF35lEdvC9mP+7FrKNMCM67Is2PM0pLJfOQVxRwRJPIs+ZGANIT6e?=
 =?us-ascii?Q?VO+mHq2H1ycLIsvJ6gCOZJzsIw8MGgNHp24oOQncJiEYuhW1Spg/H/7BNm4k?=
 =?us-ascii?Q?lw61TQ0GSUq5ijoH6K5/ECoEGfOkl+JB/eqmIE66QtxY4RfgxubdDexRPO6M?=
 =?us-ascii?Q?4u+A06cPoEBtRrQb0GCbnK32mnuym5Vh/xK0eMg6fGepJfMjHBbe9IHHb4OB?=
 =?us-ascii?Q?VbjjKf7QD4KaIa0zWMe9MRgyYLSh1s02fMdmAHifqUlCcZRH9XRCjxGaaaSD?=
 =?us-ascii?Q?XLpzDfZZ8CZVxpRKM2KtQi+1tkhzvU4NLxn26sh6FX26VP0fXYO1ws86MrVC?=
 =?us-ascii?Q?oPA7Jz1RPYQsWqr9p6zLxG9nS+YM4yBR5Ns4yEWF2AM+AXzNgj4mte6oSR3q?=
 =?us-ascii?Q?Y/Aj+ZK01HaeSahO42EgUbDsFNWH19pOpGTL/YWMDsAFyRG7ROpd1bsVsTJR?=
 =?us-ascii?Q?1fMi9WyEL1vHk0Xahs2/zt0zZtYM0bdTiHC6vs3pSBqKbthY+FHqigZWbrlr?=
 =?us-ascii?Q?TZesDfdR1QcAd45cUohh/uWA+ba6Bf9UFRhpsCu3lYmtO15UzYjRMBg0gsk2?=
 =?us-ascii?Q?ZqtpYU1KuVc46eAMpxWPLXiwHSHciNagkJDXwDi2kyNSB+x2TEs6/i1qm6vk?=
 =?us-ascii?Q?dS+vCh6vkeQX4eLU6TKC0L4Pk4K9lbD/iduBYYau1RI4/X4vh3evyYIUPn5m?=
 =?us-ascii?Q?oAYpBuZ1aKWA6b7RY67ffw5qH7uKVpAi20kVoHkjlK7H4257rS/q0bYWA8vh?=
 =?us-ascii?Q?NoSbSlpgEl5ekjGyi+aa2Ee4Yj5/wHHRn/7FgdhqI9jrxMxMKI5ASce4345f?=
 =?us-ascii?Q?uWxme0U9SN4TRTA+x5tp8q5GmWfGzdFVpJuq/+HLuWakpWZlmw6r92I+DlRy?=
 =?us-ascii?Q?RIWpsn52SdRm7MjZQ0zMGNL8313W4rBX68WnmTs3Q0u5ucIWG01vLy7WHdzH?=
 =?us-ascii?Q?MG8UWR0tpCPrdSVYpnFO4ShglWyvEZt9S10DM6zUCpFOXUKThVV/FvHxQTm0?=
 =?us-ascii?Q?xulLlU8tygZVRFhKwL54q4Qw1m1V/sU0r7+99dEzv7ukjonLqA9tbObkaUiu?=
 =?us-ascii?Q?e3ri39M6bo1IXEYo9zcrhiTSD+rNswk9e8c5emkmfwNz6G/cotBZ7ZKFfuoO?=
 =?us-ascii?Q?29AFS/jDWVIfiZBtUFOj7neTxLUYHpLmIqkzw/TkBAC2AhKhTfcM912RAt0e?=
 =?us-ascii?Q?HBZhhAKNByyvXRLt2zfQMib8HMj3h1snmSqEbJVFP/Ks9qyClrDNgdEnSkAS?=
 =?us-ascii?Q?HS2R7A7aYwBXhvavA5bvm2K0W/AOw+x2nOlg0oWQ6unEtNkjk8aOfRdzhlSn?=
 =?us-ascii?Q?G+DTlrSfcRdztTwE6uuvl7I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9627ce6b-02e5-46c6-70c6-08d9d1fa30d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 16:24:33.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHkcGZ0ZlHTevwypHUzUX/rLfwuEPvCcqCV729ULgxtFptFBOMSp13yzsf6hu/oyBP0a7QB3TTBalqM0LJwW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Thorsten Leemhuis <linux@leemhuis.info>
> Sent: Friday, January 7, 2022 5:59 AM
> To: Linus Torvalds <torvalds@linux-foundation.org>;
> regressions@lists.linux.dev
> Cc: Song Liu <songliubraving@fb.com>; Jens Axboe <axboe@kernel.dk>;
> wsa@kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Special regressions report for the pending 5.16 release
>=20
> Hi Linus,
>=20
>=20
>=20
> a quick brief manual regressions report, as I assume you'll likely releas=
e 5.16
> soon and thus might find this helpful. Below is a list of remaining regre=
ssions
> in 5.16-rc I'm currently aware of.
>=20
>=20
> regressions where a fix exists
>=20
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>=20
>=20
> * This fix afaics is not yet mainlined:
>=20
> [PATCH] md/raid1: fix missing bitmap update w/o WriteMostly devices
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20220103230401.180704-1-
> song%40kernel.org%2F&amp;data=3D04%7C01%7Calexander.deucher%40amd.
> com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3dd8961fe4884e608e11a82
> d994e183d%7C0%7C0%7C637771500622271889%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3DRlZm%2B2vPqhVO0Vuy1eNtAh%2FKuVjuPIIQ2Fo
> 5RHXsp6U%3D&amp;reserved=3D0
>=20
>=20
>=20
> But I'm pretty sure Jens (CCed) will send it onwards soon:
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F499b185d-ff9a-934e-7768-
> ec796244fa1a%40kernel.dk%2F&amp;data=3D04%7C01%7Calexander.deucher
> %40amd.com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3dd8961fe4884e60
> 8e11a82d994e183d%7C0%7C0%7C637771500622271889%7CUnknown%7CTW
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C3000&amp;sdata=3DrdgKJ4GDQsnmb5RF5ZXEn48Ra32mcuFW
> n3esC1sDRr0%3D&amp;reserved=3D0
>=20
>=20
>=20
> * There is an open regression "Applications that need amdgpu doesn't run
> after waking up from suspend":
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F1295184560.182511.1639075777725%40mail.yahoo.com%
> 2F&amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7Ce1087ce648
> 24412faec908d9d1ccbaf1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
> 0%7C637771500622271889%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;
> sdata=3DJn6vjdwISjMdm8tn0Pw0JSI1%2FD0JmUSiMCMX2FFD%2B70%3D&amp
> ;reserved=3D0
>=20
>=20
>=20
> Wolfram (CCed) plans to revert a i2c commit to fix it, but I'm not sure i=
f he
> plans to send in onwards for 5.16 (or if that would be a good idea at all=
):
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flkml%2F20220106122452.18719-1-
> wsa%40kernel.org%2F&amp;data=3D04%7C01%7Calexander.deucher%40amd.
> com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3dd8961fe4884e608e11a82
> d994e183d%7C0%7C0%7C637771500622271889%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3D%2FibaOVHm2hqKUOf%2BGnQThVw2lsF3znB5v2
> Q41ja%2BDtM%3D&amp;reserved=3D0
>=20
>=20
>=20
> * There are suspend and resume problems related to amdgpu:
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215436&amp;data=3D04%7C01%7Cal
> exander.deucher%40amd.com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3
> dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637771500622271889%7C
> Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DvUyTuQkw3Z5bpIUkwf
> IwHyc5kTKaG3TRr34Tl%2FXHGLo%3D&amp;reserved=3D0
>=20
> Mario (CCed) recently found the root cause and came up with a fix, but it
> likely needs a little more time to bake:
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2FBL1PR12MB5157F21C23A020052FF5C13BE24C9%40BL1PR
> 12MB5157.namprd12.prod.outlook.com%2F&amp;data=3D04%7C01%7Calexan
> der.deucher%40amd.com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3dd89
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637771500622271889%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> 1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Dz5%2FJB2I9ciDhwdvwxjPKZ
> O1t49kwO3Br%2BhXdvUQgyoY%3D&amp;reserved=3D0
>=20
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20220106163054.13781-3-
> mario.limonciello%40amd.com%2F&amp;data=3D04%7C01%7Calexander.deuch
> er%40amd.com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3dd8961fe4884e
> 608e11a82d994e183d%7C0%7C0%7C637771500622271889%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C3000&amp;sdata=3DTGrjrWX22DBOshfAiD9mh8diCq%2FkI
> Mwg6xMdU03aLHc%3D&amp;reserved=3D0
>=20
> no fix in sight
>=20
> ~~~~~~~~~~~~~~~
>=20
>=20
>=20
>  * screen contents do get restored after some input events (so it doesn't=
 stay
> blank).
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215203&amp;data=3D04%7C01%7Cal
> exander.deucher%40amd.com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3
> dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637771500622271889%7C
> Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D%2FpAS9qTCWx%2Br%
> 2FS%2B9WRGC%2FcSFdgw5hWTZIRKHjp189Lg%3D&amp;reserved=3D0
>=20
> (related:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1840&amp;data=3D04%7C01%7Calexander.deucher%40amd.com
> %7Ce1087ce64824412faec908d9d1ccbaf1%7C3dd8961fe4884e608e11a82d994
> e183d%7C0%7C0%7C637771500622271889%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000&amp;sdata=3DhrNAXNori6%2BtgP8X6YEJT5V2Hsnm1mTiZNZI0y7XKL
> A%3D&amp;reserved=3D0 )
>=20
>=20
>=20
> Alex (CCed) is trying hard to find a fix for, but afaics needs more time.

I already sent a workaround to restore the previous behavoir.  It's on its =
way to Linus in Dave's last -fixes PR.  We are working on a proper fix hope=
fully for 5.17.

Alex

>=20
>=20
>=20
> Need more time to analyse
>=20
> ~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>=20
>=20
> I'm aware of two more reports that afaics need (a lot?) more time to
> analyse:
>=20
>=20
>=20
>  * suspend issues for a user that faces another regression that might
> interfer:
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flinux-
> pm%2F256689953.114854578.1640622738334.JavaMail.root%40zimbra40-
> e7.priv.proxad.net%2F&amp;data=3D04%7C01%7Calexander.deucher%40amd.
> com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3dd8961fe4884e608e11a82
> d994e183d%7C0%7C0%7C637771500622271889%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3D4ycXrg1yKHneHJisDmUcSHnXTArFMDP2EZacmtIG
> %2BqM%3D&amp;reserved=3D0
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215427&amp;data=3D04%7C01%7Cal
> exander.deucher%40amd.com%7Ce1087ce64824412faec908d9d1ccbaf1%7C3
> dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637771500622271889%7C
> Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Dxw15%2BdfZMQr%2BU
> 5S9mexnYJyRW1UahrrBLUJRu15oDQ8%3D&amp;reserved=3D0
>=20
>=20
>=20
>  * 5-10% increase in IO latencies with nohz balance patch
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flkml%2FYaUH5GFFoLiS4%252F3%252F%40localhost.localdomai
> n%2F&amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7Ce1087ce6
> 4824412faec908d9d1ccbaf1%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C637771500622271889%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a
> mp;sdata=3DRt%2F06JdscRKj5nQKoXiM75l3JPjwwMQ8f9dx%2FsXSUDw%3D&a
> mp;reserved=3D0
>=20
>=20
>=20
> Closing words
>=20
> ~~~~~~~~~~~~~
>=20
>=20
>=20
> HTH, ciao, Thorsten
