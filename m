Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1A581A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiGZTKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiGZTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:10:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9027B32;
        Tue, 26 Jul 2022 12:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKegZR/ogztFlS0BNDN/syhf8RJg6aXVxn/ycX9sUPKq0PWWvb9wCNMb5zIglZvWW0ZCj4k50W4VPuwE+WI1mwJxJQqD8LDKHuZQ2LYxz+uqox/bfG2a/kspc342PunkVsZrC3YqgmOJRNcAXepDRVY6733t6Rzmlb3ZyI7kBjTxRbbffIlNMKFIX5Ik3E+UYPSdFpmxKQGOQ2Hq//kr92dGojvWzaXsLYzxZschWmIYoyDTMPWVq2fEmCGBOt4vdKfKvvX9QxHd0lL271pPIeHtTqT3IjGXNw6e0CDTFWZkuzQBrhKJby75iiJuBJgUSbA94XJZn34GowvI0vzkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPPve4gSp21/q+01bHYccV2mMAJ/c9VMHvj6IFbSce8=;
 b=QDMKNMM7Qm9+Xw6/ENLsKqsrAjwDDxWkT+fmwYHbNt7Det5ihohJKWFDOfuppnc+DuUzQNSTqpybI6WReJCwEJKyAjGM1IRKg9wAW+MvtmAkh0GnaJKbgmT1PLn4U7l90bid/n9pylbzwROI84GaAYCWyAItboS16ZNTuq46RI/cnHdy72oRFUmliaq+ML1inh3ViJW+yYyF1IH394W3Yhr3yA7EQ+71dHN3BqlUmkVoyV91f7ktl9Btz6FuxCI28cosIFoyEFiUCUbbl0IIjI423kIwUEuqeOTJD4lG08CYzCMlMgeXcK0W+MXmi3YLVDs0hDDmNi+6xpNpAiuobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPPve4gSp21/q+01bHYccV2mMAJ/c9VMHvj6IFbSce8=;
 b=WwvF3wNb7w8CQ4ZAr4wXbmSy7kzhTOjMGKDgEibat/J0oHiK71jZ5EcX0e2AmswNyTfAJalbXAHJgiBOShFaa0uuyP3HpteD81etGt1VGLVJXxWbNMft1WWfUxVXrFkFdv8T8SysSi6+Dh/DfeIsH7AD0lDJCnsZkHCJDMeRZCF0oXgBSjoa5u20kyGJ3CK8se5QFoFklKWRUSuP00GwvIbRWTTqpZ/YIaYaEYqsVJy9oKB07dWJgdIIOJLSYbN2gtVNOMLbH7BYdID+a1QIENGTD9YC0aRi2v/Quoc4AhDBHggtfa2NqA9h356eoAF3Pi+GNncd3r0T4poV9p6xgw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 19:10:40 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b%5]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 19:10:40 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] linux-next: Fix build failure in pwr-mlxbf.c
Thread-Topic: [PATCH v1 1/1] linux-next: Fix build failure in pwr-mlxbf.c
Thread-Index: AQHYhW1qRSrWn7beqkKARqFh62L39q2RO7IQ
Date:   Tue, 26 Jul 2022 19:10:40 +0000
Message-ID: <CH2PR12MB3895CA98F1CEC2093CD7B25BD7949@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220621124930.23758-1-asmaa@nvidia.com>
In-Reply-To: <20220621124930.23758-1-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d7f791e-f767-4c0a-b2c8-08da6f3a87ba
x-ms-traffictypediagnostic: DM5PR12MB2566:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXlnAIkeDFXZ+9+KQK6jjGGBV7+kfGuXEsMZNjo4x4Lp9MTKCUYdN9wMhcyDOufMlQklGhez4F+e9DCOD0Lde+/0Yx5FwYHFR8rUBsDw66OfKZQ8+iT1CEZ87RyPw1y7xFkclxoXiU4six/kxifG94hVPzWqJkwx1kGPzW+ksMLD7wYAa0yiNqgE3WCOqWfcNr3pwAhYVQOtoYRbmy7q19fkFAc5E+dQac4baYifRD/jr71Qfh700xkQUVzoP2ZPBARKQCrdNWzZ07qvDmvkmYArbZFf1ld6iT0IVuQgVFYIkVMYrIQ7L1eF9oqV6zDppiq7Z6l/TlafdB4AGfR87qpzs8fjx1EjtmEmCZhC3hvNavDaYiRAo9vgTRZGPv1gujUA8M6ZsjO/s+StR2cdhbWKXpXOToToCdKMPMoLFe/qjvpBa7juPvwzWbJzK9TafMAENRawgd+24hWbAzbXdF082/kT91/k/xniNy0BvOqAWlAfSA0bVdAEHaA70SFXBI81NHPOvykShjnzdAnRK0fmqiAPumPL/MP8NKiff6FKMScJuMm9KNZhsDWJtoR/OQePg0I1dBTYAcf0U0sMXdYoW4olXAO6DvL1RyFYBnlaKgpbZJZwextafynTy+kMACFFhkc6FEC/x7XJtTKTByrd7wJ3HwKhfNqHzCoIfhbOiF3Spbnq69xYsrqfPVJQGrhzn7lVoTl5qC9Aw6USRwmkU/atWAn9gBy8vTNe/tvCQHtGxvhvF+ZxcQg5jyia0gjFg9/TTyGMUMDmQD3s0hN4RYDC9ieQJPxrFwES8fwqOLcu54mFiTqm9emUvgE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(38100700002)(122000001)(38070700005)(186003)(83380400001)(71200400001)(7696005)(6506007)(41300700001)(478600001)(26005)(53546011)(9686003)(110136005)(33656002)(316002)(66946007)(76116006)(66446008)(66556008)(64756008)(66476007)(8676002)(52536014)(2906002)(86362001)(55016003)(5660300002)(8936002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3gEaQ96rwAqGAQnV6Jfdp04ZVyIqf2DZNhSukBEoAAtOEiq084DU0Hhbpwj2?=
 =?us-ascii?Q?uUO25+7AyF6dxNk5rtJf4TZU/ki4H41meUg/hcrV64fKQ7jf5YEHX4iOZE6y?=
 =?us-ascii?Q?J2ynzBJvLILPJYr4W70mxAH92hoxHpq3jpa6syBT0LJG37KYkkVDsHdN3WuG?=
 =?us-ascii?Q?7GVg7r/eJtTcKXoGUkpRKAEBrsA5T9zmnCDz/AliZItd7JYaPpH4Pstj8mK+?=
 =?us-ascii?Q?4tObeGbTLRA1VbbJ2jKbFZIQWEVw/Z7ZFp1q8snmANzMD7q1ZVOs4oAj3cfR?=
 =?us-ascii?Q?Sl14CFyvMLDxRLMcROCQJR8udrdzra9MR6kfGLcIHn1W/F1F0DkaDQuL+EpW?=
 =?us-ascii?Q?bH+NxymSrb274tyMJedX/xNx+ngTUIrTxzCGgGPWPPuKirGyH03grAwD4VPK?=
 =?us-ascii?Q?fx/y0enJEczwuwHBgD/lAOxNqSzjIGiItRC4rveHw/Z+pXBnrx9xVp07W9f6?=
 =?us-ascii?Q?JqC+IavPuhXmqpiNUfXsw9OSHkkliwh3MNjcBERuTGuqNOR8KPcdnKTNKQpx?=
 =?us-ascii?Q?LessxG1aL78451wDsyGdW3uUCcs2V8PLBzwDPoQPJUqmUkmDlt9Dh49ZgL2d?=
 =?us-ascii?Q?+RS0OkFUQglAjcVCzW0sTqRtCZFPSRPVFq+NAWeC5N5rExLAU7jWQWijIuzH?=
 =?us-ascii?Q?iCTvMwKO5UCRv1gf+bYc+uTfRR3+Mzz65OxDf+59q5+t+M4YKuv/I+Pmbj78?=
 =?us-ascii?Q?KL9JntF5EYIUqw/QdxCZEpxpCFhupaEEueKBlJvB4si2x0l1JuEYFEQkp6jX?=
 =?us-ascii?Q?OkkbXOGMoIUJ5J8V4TMbs21oyN0lXExLe9vDTu0sC0Nu3es8GtUEdR5F9Ujv?=
 =?us-ascii?Q?4OshiPCYqBXUCKBEtGIcUfqIc0rlmDH2OXa3fQJzcVpawBj009I5ns8oLeXP?=
 =?us-ascii?Q?agsUtX/CNIIyqGOpuepIeDlYxpJPT2m+ohLOBwMWDO8+lsMHwsZveCT5wHMZ?=
 =?us-ascii?Q?w3K8Xrm4rdnlDJzKEch9Z3V7tchUG5rrAXxzlc8d8EtxF6I728+RBn3ni5rL?=
 =?us-ascii?Q?2Skfq2OFgaZ/XHOzhByr720oBm56rlkK7BnX2siAW1z/so9FuQ1tmiX4s8nc?=
 =?us-ascii?Q?6RKh2SNfWcvGEJcef0MEtjK21JAFPOOu1naMaeaCYFL2AIJEu5YufIv40Mcn?=
 =?us-ascii?Q?HK/8qa7POv5b4IRlryAjshYeKr0gbN0WJvUVbnMhXXlALnUTX+cM7uQvbZa5?=
 =?us-ascii?Q?2KMw7ir7eRsbzM3iEvtXnO4tgEnTngyUK8GtBZpg/57XpLnxmIuPpP6fhHte?=
 =?us-ascii?Q?X4CXgXqf1ZsQ7gAiRvmvVD8khkebRvcZfy4mPxKHXhF+kGt/vYDuIFGanVBf?=
 =?us-ascii?Q?39J2g7hFA8V45SBdCM2VeiODeTGk1AbtiJn1RqhE2MHLRZCYSNTl7yxzuXVa?=
 =?us-ascii?Q?em9qk8naV3B7GGNLG6c7bU7wGm9kjlihvcAUIGTj1sZaSrCG75/ufN6zwr+z?=
 =?us-ascii?Q?+ZJQRO2OanaGLUXUUs/imZ4m703hERzeZtaZQh4+kLtpl8tedhJtbMggcASZ?=
 =?us-ascii?Q?7fFKhrnDpIxsLwha5bguF4Ell6aK3ckPIlxTUygDbhjYblq6aUPrFo/ZJ5P8?=
 =?us-ascii?Q?PAfmjhlTMWs9w+iFi4w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7f791e-f767-4c0a-b2c8-08da6f3a87ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 19:10:40.1823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z08x+sIen0jhKGfaoo8YFAzmGKy9MWm83l0W/cEyaSVV7oxWUk8AxKy776YP4e38ivDgTt+DzxZH+BCsdg9BYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, Hi Stephen,

Could you please review this? I didn't see this being pushed.

Thanks.
Asmaa

-----Original Message-----
From: Asmaa Mnebhi <asmaa@nvidia.com>=20
Sent: Tuesday, June 21, 2022 8:50 AM
To: sebastian.reichel@collabora.com; sre@kernel.org; linux-kernel@vger.kern=
el.org; sfr@canb.auug.org.au; linux-next@vger.kernel.org
Cc: Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/1] linux-next: Fix build failure in pwr-mlxbf.c

The build failure is at line 67: implicit declaration of function 'devm_wor=
k_autocancel'.
So declare library for devm_work_autocancel.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/power/reset/pwr-mlxbf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxb=
f.c index c1f9987834a2..1c4904c0e1f5 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -6,6 +6,7 @@
=20
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
--
2.30.1

