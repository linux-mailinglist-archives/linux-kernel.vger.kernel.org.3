Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0964B5588FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiFWTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiFWTcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C0993C6;
        Thu, 23 Jun 2022 12:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0fmuNDPii/+LS4hwpOLpiz2Z7URUMwBh4cP6JO0adqeV45oQ5r24OG3PFrLdQv0qp1UCa4Ptj91ABIfzQ92K8jjuJdy6y+/rgy6LHIIYyCMjyDMZsf5FMhdZvbO3BP5ghNgXFmpztENYMYKAkqc1u6wkYh6A8+S3hEXZfZNUFIMiKle7LLGCqsrHtMwa7c3pjAHL+nWigUWtAIQEXAtdBggI/I2rVdJ/8a15XhzXGNFAdcYTkAsPSK/SGFhF3qgJX4S9Uzhlawk32T1XZoCQRC7vHSgpP8GPZftYmJgDW6MtrbVJCBdU6e8oADX6Pz7erbYOsOP/ATB4w2OhT219w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QGYFR0Z+SWnA5UWHtXjgI1eYnIxmi22/7wqNSh5bqU=;
 b=DmffyBXTkFxOFRaip4N3h3iIE85K178GCmk6ruioBjdwqpw7WEbLWsAJxBziGK92QfRGKS0jGdsnbIc8gycyEIWTrQpCKhEtd+pvsnZ+GAabaZ6p/x91XVprJTw7sCG2wf+/WzS+r+NBdMovRBhB/IH5znO/ZuM6OxXeKsZ6pplQ//fPU0s8ymd5xd/LDUbOFE/ZXGRQdALBjmJOGA0PaOQM5qhzW3itOMFjKz7c60Lg76R4b5Y7cvkzoUa52eoZDPLWLMiSe4Yt15nyaJKvDeesFAiAkzwppk+Ltt/jeiVo0erQX1DoIRcGUvq4t60NZJMkTPPLMyfYuMPwh2C6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QGYFR0Z+SWnA5UWHtXjgI1eYnIxmi22/7wqNSh5bqU=;
 b=5Jf2B3ZdPt0WrQ9aJ6CGK2/p33AqOamDhDV8AECeOreUnS0tzR4Y3u5oWYjZ1Sip9OkpT/mMAs4XEoFCBuqT9qOdtDpeVcnu24BaL+0k03fU7lIhg++8xItu4S7uTcjys/hTlXtD/y1fOHVD57OifS2b1DjvQJjrz/RB3BIktxE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 19:10:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5353.016; Thu, 23 Jun 2022
 19:10:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>
Subject: RE: [PATCH v3 0/6] Add support for upcoming chips to k10temp and
 amd_nb
Thread-Topic: [PATCH v3 0/6] Add support for upcoming chips to k10temp and
 amd_nb
Thread-Index: AQHYf1wFHl6WqwCUtkm2Hz2zk959Jq1dajRA
Date:   Thu, 23 Jun 2022 19:10:12 +0000
Message-ID: <MN0PR12MB6101336EA32DB8A391DE4605E2B59@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220613192956.4911-1-mario.limonciello@amd.com>
In-Reply-To: <20220613192956.4911-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-23T19:09:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=eae91805-a738-45c7-ad3a-3d6c8c965de9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-23T19:10:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1d8ca488-9ee4-4e26-aca6-de727297a2c0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2118019-260f-4d1d-845d-08da554bffe4
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oLR7UboxxDT+QKywRgKRCcGwkYecT4ttynTy03bxYUpV/ipUdyDF68KlobtmzlWx/PbitiWa3sV8hzSMOJB6IE/jesEvoTNogh9vhSLV7SggQIzSzk/KuXtv1I4ZmJRDcHZKvs5aXYgFbWNMsFjrU6XwEQ6wXxn6olKXSQ7ZGADIOruu0PLGYhY/8R96dtIcf/kJsv7sgH1srX4XtbiY5EE4pYU9TV3A1sZHev13vHqRPxwD8eptSpxnU5qr5Jl4hyP3HBd6wjleLuXHZETXsbuggvyz72l2pDWNl4sK2vy4gCBp+vLavy6+XB21fkA5Uz4aAedDrhIRbsb6u6n+LoNzK/OReVGk69xRn7r18fTnYLt/I6FEw87IpickvoyldUSf4J+BZDTwfJvyRLDZmHtalOpsVX5NbHiPaiW+/VNKALHdtm1N8nl3kAJE8ZpavMikF1pzpMYauhESurk4Zhy1HOYxs4KYa67U0gZQQhc7UvSodhUfsxobtt+VIW0BD8skWaoEAW4NWcy08gLP5maxD3iFPCn/DK2YT7TkU6NfQRr9oMnn4y1Z90CBNwv36QgXfky76lFY0NfhpL6DMgv7eGXREV3wPkT7R2Pi4boG1rSRxp+WVlJEJZPHxFraIexqJ+IC4oOU9nu97MrMy8YUz+PVywx3cKiqMcL6eRxpWqyZa8i6X4MFuKtoVvIraXrEI9zIemYVTx3G1qtFpEQw+g0Lf+Rj3vO80VXwGjmRgs4Wd0KEkQRe/xAd8fPXGsM3bBfGJks/Qc/9GHF0d4dYDt2lfj+sUACCpHEEjI0sLHmZRdtwJvf2bg56zRGtLIU2ipjR4ibXp+a2RmgT4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(8676002)(4326008)(110136005)(8936002)(52536014)(5660300002)(38100700002)(7696005)(122000001)(6506007)(53546011)(71200400001)(478600001)(66446008)(66556008)(76116006)(64756008)(86362001)(83380400001)(316002)(54906003)(966005)(66946007)(66476007)(186003)(33656002)(41300700001)(55016003)(9686003)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IQlVAV6ovzvgC9hiIpUog4LgDNC3rMqZkwqRIKN1IX6h0w22QBIifiUCTPt5?=
 =?us-ascii?Q?pHK6USdHRnS80YeFF+Cy8lK1uN+VvLJVeI8I5FKLAfGJa5MZmpWZ2lC8CgGO?=
 =?us-ascii?Q?90AAoItAUXfE7xrzqvIy7pJE8+3yOmfkJnicPgomw0FI1pHRHsku9weRDrQ8?=
 =?us-ascii?Q?nmejopDb+lxivDlGFK0emQbJ1ZOGs1LN57o3SXvl5hC6bpS8UG7+ti/pnKeg?=
 =?us-ascii?Q?9gdW6lpvxchgg8biAkDyK+Vn4U8dpBOtA7ctgvpkJPuO5y5nz16VQkh26j75?=
 =?us-ascii?Q?da1HGdeTHCxoPh16uuZ1jEf5te6SC+H5jtTFHJDIfeWWqPSGvgN8B9y303ze?=
 =?us-ascii?Q?kSHY2FhL7gsDj7E8atUrm0+ib5dBpLFP4K0QirMovza9vTBICInIDrCMapLG?=
 =?us-ascii?Q?RtGmDfQcUn/ECNg6tEQs/6BK/7EGA9JOGjyDF6UO8nUZd0eoXhv69T+7cDHc?=
 =?us-ascii?Q?fvGiZC/pHCGKHO43FhTj3JCfgxb1H1r/shJlhO3pwR6xeUeW5mABrm7lNdUb?=
 =?us-ascii?Q?ZDJqyfmLZnTZIxBKVWjIX68rJKmSovivGq78+UV/UvzCN8EXrmbqxCwDmhVT?=
 =?us-ascii?Q?mA0syBgZeCRnav5vqbNPEb6eEWp4W4N9D87f6xUTu0IE7GyZcHt2smOkR9/2?=
 =?us-ascii?Q?S6FUyIlbiJ8fCpkZjhVzfzY/XFBnAdqz8mRamfP6wvhr3ZrYveN3aoKAcG7l?=
 =?us-ascii?Q?v6DmqtNhVRYvLE8ess5FuP0uYy1MJrSGXeNqEj+M8cZLAMTwCO7rzSV0G5yE?=
 =?us-ascii?Q?zQcnag9TJB0ZYjNgoBOXy8Rbw0aBGBENv81HjI1i3A8TfEiOsA6Dkv+A/sey?=
 =?us-ascii?Q?r+7iGytlZ4WvcIHXwPaOnZQie1wqNCQKUIF4jyhv8J4ellwGkxVu1wW+GxqD?=
 =?us-ascii?Q?niEmHb+HiojKXKDu3MbCHyIAS7/WI2Qsc6CaiCiaNwdlRmC8JFBWavNfg7fj?=
 =?us-ascii?Q?pFN5E56juyUGq0v7chcbQF6WDU75lxHHHApE2mQjxBfofItWSsB2v16MHbBM?=
 =?us-ascii?Q?FHK7VOWe24IGdZ+ROnW3bII/9ID4sDuu+ZyB5K6TPhcV7pXxYX1sT9Rh+8In?=
 =?us-ascii?Q?RDs76H5o3P/fc9Qr9hGoGtfKpe7VcoUouuvuAU5Bln/kQVjVsKwaySctfTie?=
 =?us-ascii?Q?n5DwASkgNK/mxy9DG5qLdgr8bhL+sOSCjr4+nyiWmPcdWlBrn3oKQ735cMxf?=
 =?us-ascii?Q?T/cm452MHRrM/yQta5oIh4xEyc26A6e45moP5q+eCcXvIKDB86aXZHN+VgxQ?=
 =?us-ascii?Q?xfOjmQi0rqPQIGrIB1NYSAySUZ2KI5LKTEX4OvKf2TjJrTcfn+YRk0+56zUy?=
 =?us-ascii?Q?PPqtN85hyZx+cKR0qXP+L3QB0G5K7RUBJWnPu90lkD/U/dc4EUQO05DdKADU?=
 =?us-ascii?Q?i6zrcWCd/HqPCL7MsQ3tbaQDKR/y7tVMOBnqB/V5D9OA/hG78PUybhQ6fkZd?=
 =?us-ascii?Q?YyDHk73G8OcvpSVCgLX7oXCrFmIBVYT8Dhtkhrl90AXDN++ygZfygE+I/wsj?=
 =?us-ascii?Q?JZXBxQT3nBxwUrMMCxSQ6fpEGTEx0WxuVqP/m1rBVBoKDueK/UH7xW4zoDNG?=
 =?us-ascii?Q?OM9Zlx0SZPTRN3EQDDIgPUub3NCPeVGscbfKx8gfdo2xFBXliMvHd9VdnMBQ?=
 =?us-ascii?Q?Qsfg8+B2Qs4DGaXPki3mASk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2118019-260f-4d1d-845d-08da554bffe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 19:10:13.0108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6AbRFOOkrhBU7/Po9NqbGR9E2uUE4EVsQ/HmjzraFAaUqhe3d2KzPVMGROnCybbQ8O7Z01QI9oLwZ1pVsmAxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, June 13, 2022 14:30
> To: Clemens Ladisch <clemens@ladisch.de>
> Cc: linux-hwmon@vger.kernel.org; Guenter Roeck <linux@roeck-us.net>;
> Moger, Babu <Babu.Moger@amd.com>; Ghannam, Yazen
> <Yazen.Ghannam@amd.com>; linux-kernel@vger.kernel.org;
> x86@kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH v3 0/6] Add support for upcoming chips to k10temp and
> amd_nb
>=20
> This series started as what looked like a correction to previous
> commits, but I missed that the previous commits were for a different
> family with the same chip models.  So while fixing up the series I also
> noticed that a few upcoming chips have new PCIe IDs and CCD offsets not
> yet supported, so add them to amd_nb/k10temp.
>=20
> v2->v3
>  * Pick up tags
>  * Group "ROOT" PCI IDs with others in patches 2 and 3.
> v1->v2:
>  * Correct commit messages
>  * Add more missing chips and offsets
>  * since so much changed, do not include Bjorn's Ack.
>=20
> Mario Limonciello (6):
>   x86/amd_nb: Add AMD Family 17h A0-AF IDs
>   x86/amd_nb: Add Family 19h model 70h-7Fh IDs
>   x86/amd_nb: Add Family 19h model 60h-6Fh IDs
>   hwmon: (k10temp): Add support for family 17h models A0h-AFh
>   hwmon: (k10temp): Add support for family 19h models 70h-7Fh
>   hwmon: (k10temp): Add support for family 19h models 60h-6Fh
>=20
>  arch/x86/kernel/amd_nb.c | 13 +++++++++++++
>  drivers/hwmon/k10temp.c  | 12 ++++++++++++
>  include/linux/pci_ids.h  |  3 +++
>  3 files changed, 28 insertions(+)
>=20
> --
> 2.25.1

+ x86 maintainers.  I believe, you weren't on the series to line, only CC.
This series crosses both x86 and hwmon so it needs to go one way or the oth=
er.

Can you please review and comment if you will take it or want hwmon to take=
 it?
Here's the rest of the patches:
https://patchwork.kernel.org/project/linux-hwmon/list/?series=3D649968

If you'd like a RESEND, happy to do that too.

Thanks,
