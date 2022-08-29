Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A50D5A53D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiH2SQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH2SQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:16:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1CF9C52F;
        Mon, 29 Aug 2022 11:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPE+HpDZ2ZrV/WNUpNesfuURdymwejt4hJF3Yc8yNofUeyCgvBmae/T1zI4Y3mkOHdlHc/qGotsX7Gu+mDalmMnn/8/QXKv950X+PuSoyKgeNVVjt7BjLsjvyIcZ638LnbDGLp03dxiYO3ARaKMwvXpRWAHYVvbYlTqN9Ttsb5xwncuTMnbJ8a79z+5fqjAo5Iz1GoP4Fy5TLy2zonr4XOKXLf5NJzWIdJReCYe4mUf/T7IjWVVPjUA3YVHJiDzgpIXIpOI7NwWkh+BRJ9JGAcSQgaJVFnMCZ0FXznqzIbACjz53PGAQF4JqVN749aF1q+EKhpPu/JQOHMTMvzqGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16KlUpn0ctxrcmVeiKK31Y8QmZKou0EPho5wTppOFqI=;
 b=fRcKM+x5P56PE+OQ58MthrxdFwXwN8sTnZxU4OboMUcRP7Db1NX5wiMEJJR5xUTRLM2qiydyIC1GlPxmeCpCq8humaQ2JOzOKNKlUiJHCstYtJtsz2nGR36e8FzD0TipqSV2R/N2B+4vjxFPdOrbxsKlklK7CQNanv+tRwd37/n32/FS7p7MG3hJuyty6Jv/arkXhYoKNVa4AFuKE9rceoANteXfQi83idt9Smg3/Vd/nJZN89rzYbmASd3+CQpd58hEv6Qg00GV4YFyJFxpuyTMohcSmjnCyTebT0seZHM74asxBqbDECovfLjlb16opm9MRM5qbJ39ysfpBX4wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16KlUpn0ctxrcmVeiKK31Y8QmZKou0EPho5wTppOFqI=;
 b=X3IJcvT0QSSJBswJL74ydJP18GHwt3o6PRaVl9t3sEz3ihCCFUJ6RBpNN31eqEASW+YwJJuFGOdgnD9gsg43gVlFPDUC0E3qKOpE2WQrFG455wyowm6EMbzbcVstgIiqXHqErNe9vfFYTsskUDlLLltPx+0Lr+m9+o7PUIWzLJE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY4PR1201MB0200.namprd12.prod.outlook.com (2603:10b6:910:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 18:16:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:16:45 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programming
 an interrupt
Thread-Topic: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programming
 an interrupt
Thread-Index: AQHYpvEWVuWeMc/TpU+dVB/QfoB2za2dR4yAgCRN8oCABMOCoA==
Date:   Mon, 29 Aug 2022 18:16:45 +0000
Message-ID: <MN0PR12MB610137D56D08C873C7647A9CE2769@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220803042501.515-1-mario.limonciello@amd.com>
 <efb83a0c-7617-894e-a34d-37280238d5aa@redhat.com>
 <YwkDd+mAhyoSwVeq@smile.fi.intel.com>
In-Reply-To: <YwkDd+mAhyoSwVeq@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-29T18:16:42Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=77307db4-f1d6-4309-a63d-106b86d0ad42;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-29T18:16:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 29e90949-1f29-4da2-8612-779ee2d7977c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6a57c37-a019-43e8-b717-08da89eaa1d0
x-ms-traffictypediagnostic: CY4PR1201MB0200:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r5otjl8olWnSHy0Fi4gKJMn0Nj5t7taKf0BNexmEGdAnkc0RybhB0+Ut2/lQ59SmQbiwXBY22JEXRscn0CJECZQcL+QeBptp2ulrH4u5RsGnNXcu2shdFSWNNHN1Dz5EOU+lPsDr4NEJbQ9ZBScYGKdeMGAn0Ny725vqpaVB77+D45lmVDOo5ny8TQgcOeXlCtg1OT5AIdjg+2U2SrLxuaSFK7755OPCTDCiGJdzM0n1iNYMPuAiEiIzgtTTi9CN8DPSPMyvClbpPsmXqPpobWvg/b6ZlOg56wP3RnCEyEjMbDtI4CyzqN7dobYdghesjULKEpR52mqdoECKWYsvCFt04YjGP3YrzQCDbswIIpILlpueKMJ1mi4HnNsYd6p6kwzkxn/FwyWLaizUCWryvOA1/e+J/VNigBd57vy6U9qQf3Q58U+KGzzO7eEqor957HI4uQvH1Uql/6Cw/CjlKltmnUOIrEKZ1COKweImob9fxPuI7LSuvhjp8drMCkmpqj215MPzj4yU1nsQOSyNFwuq8qcAdAJ3oFqh5oIbQpmAyuRrZWqPxsJRg/pJD+vp4XhkYDuZZNoU2Nr7ZXyKyn1jC8W7vBlaY/ZT7L7ieB2OJrFWysheg2s/hRLDhnv43mEeFHhR6sEhmO/RVrfgt0aeiCUXtGA0vEOwvSfr2FT58FzYnF9UgoXCRJAX5xuxXI4baxYy9cesuF7IWToSGIooFP99ZQ1q3fTJ93aeOYAvnZbFQS6wcw+otsp6PCzTXKrklkEpO0ONtmzMqn/mMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(9686003)(6506007)(86362001)(7696005)(26005)(33656002)(53546011)(122000001)(186003)(83380400001)(478600001)(41300700001)(71200400001)(38070700005)(66946007)(8676002)(64756008)(76116006)(54906003)(110136005)(66446008)(316002)(66476007)(66556008)(4326008)(52536014)(8936002)(5660300002)(55016003)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxe4+PYAyItRB/MB1UYHW/VPUR61LZIZyImly7GYZOOi1GGcZZDooZO/timT?=
 =?us-ascii?Q?xMVX3AVEFZ397v+abIqmjvCuRKor+m1FGmLZbt1UoyQrmFlHQuFHjpnTzifZ?=
 =?us-ascii?Q?b0aeRf3YUyxdiQdV1PSOx4qiTPQKBrY7zeRVJfpSd4EJSu/B7jMCeDn67Wxo?=
 =?us-ascii?Q?cSTVlxPNAdJJxwHpbxkrFO9fA8gmAcZeZI6CN5z1fKOVK5wIAmdOOmqW58yU?=
 =?us-ascii?Q?dTa+4oPiuEjtiIKraRrpABhG34EHxg4hFuc25vYrchgpOKrfbbHHJVpaTXiU?=
 =?us-ascii?Q?OWbB6SgCZUWHSgHyc/LMHJeXWLS6TDBmzkXNc9wQvU13YBid0+DHbulJgH2a?=
 =?us-ascii?Q?KBTlj9P+4GYWJNB9gPSc1q+NuBWh0Stc2A5HDDI1HgfPYG3nyC2enISFhSY3?=
 =?us-ascii?Q?urhoYEg4iZ7SaygZ2Pje2ON03QIQPz1i2siIHGe0J0yckC5fMWNol2ZC2rv4?=
 =?us-ascii?Q?i6faboo1fvFr6YKApof9AchP5UIQwAdc0NP1mI2VVYjaXGGbDCASV8VulRH1?=
 =?us-ascii?Q?LwiU7EuuGJAIeNVaryB1HKPJIc2Una39fO+Du/FwjRu8TZkq2DnoLE84dqXf?=
 =?us-ascii?Q?oPjdvUVKid4D58acXhGJVrh4dzdfpN8PXQ5XbGoYsFHEZCwoGLPYD6KQ3tLH?=
 =?us-ascii?Q?B6VzOrCAJB2t8Rd7Xf1KMB1rt9bgZYH9JrHoOgQoA59eJK3eiYI5Cec4uP4z?=
 =?us-ascii?Q?I0KRZ/zmGiVZdW9inRZA/O1EDG0UroU3SSWKNkPb7yfzjWtLXNx8GiMLjb/h?=
 =?us-ascii?Q?n1c0ChRNwePqzmzabeFuMVPGUty0NP7JEF0u7EbvVkqxma+vpoPNMZOH9kqI?=
 =?us-ascii?Q?CQnvhd0bsGqoqppS4JzenQStwbsxX/xU+EOCs4eIFE0Lonh1iyA8EH9fRgEX?=
 =?us-ascii?Q?mPonMm86x9ARODgTP58jXqzHlnAOQ5O23zGVU+7ZM8UbTYUabVj+Ml5dszBq?=
 =?us-ascii?Q?YuBQv+EQhcuteXJYJ4kZF2HBy9PDIhBO4KL0x3Pm7zI/mpVRIL7Z9vWAiZZZ?=
 =?us-ascii?Q?CVqlrlnHKubsYE5vkkp/NsHqA3EwecNU+FIESEkTzaQ8h6s39oZKXjlny/c1?=
 =?us-ascii?Q?u9WhnMkuvful/4svD13Z8M1WMvXr+E+BfXabahTiJz0+P8J6xGZ0iigcW5gc?=
 =?us-ascii?Q?Z4XtdBNANzevPZvak0UZoBzrXsii3/yCwtzak32Yrzm+jjS9vm2sj/fxSsD1?=
 =?us-ascii?Q?Yw1hwbc634UU6sZiIqHn6P2Up4YoJyjEcqteGpQFsO0xY3F6xJBSBfl4esKq?=
 =?us-ascii?Q?NCNFdcFpk0UW+n8owYDJyp+YmQm1kX9EhOjPpcENoWqqCWHhXOyerrH97JsI?=
 =?us-ascii?Q?3mb023QYB6eUm0yywsvshB5KL4lTF6Ro6C1qqADJqnxM1EbeNxjid0QN3TjV?=
 =?us-ascii?Q?tAneJZ1EwzDtga8ij11DHRltmgMVMxl7zlB9TeXWtN0pNeCy7gNiWcCo6CvY?=
 =?us-ascii?Q?H+QNe7DeGDwa6MZ7asodUpNW6Titm4+1bJDGiGouTdm/rc4tmGPx6SHTa4g1?=
 =?us-ascii?Q?oHTJWsANCiT7/M9Rk/nQ3Hd2oniFixJxziCD0w/YiUvZ/bG+L4EddBchl9fM?=
 =?us-ascii?Q?ll5dPP5LAXO1Fw+GsOo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a57c37-a019-43e8-b717-08da89eaa1d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 18:16:45.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNPGZV8YwiZcs58Dzb4r/5XpYTeaUZE6VD6Qpt2DREftjI03L3hBHV7d7Dnhofpt2PWE52tVy9Xto1ngtmBzgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0200
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
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, August 26, 2022 12:32
> To: Hans de Goede <hdegoede@redhat.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Linus Walleij <linus.walleij@linaro.or=
g>;
> Bartosz Golaszewski <brgl@bgdev.pl>; linux-gpio@vger.kernel.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programm=
ing
> an interrupt
>=20
> On Wed, Aug 03, 2022 at 05:07:15PM +0200, Hans de Goede wrote:
> > On 8/3/22 06:24, Mario Limonciello wrote:
> > > gpiolib-acpi already had support for ignoring a pin for wakeup, but
> > > if an OEM configures a floating pin as an interrupt source then
> > > stopping it from being a wakeup won't do much good to stop the
> > > interrupt storm.
> > >
> > > Add support for a module parameter and quirk infrastructure to
> > > ignore interrupts as well.
> > >
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Thanks, patch looks good to me:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Pushed to my review and testing queue, thanks!
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Andy,

Just to double check, you meant you took both patches, not just the first r=
ight?
