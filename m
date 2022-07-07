Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5B5696C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGGAQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGGAQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:16:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCD92DA82;
        Wed,  6 Jul 2022 17:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlRSViVLxOoFOq3PWM1ZMlbLsRqDnwgPT1GP8LQmdVS0yP8hwOk1E6ZMr4YlL64RJ19BELl4B6Wbn1ryW4n6JZBCZvFVJSQdi3WRSNHOCTt11JiqDD/U64zLfBQ/ijzXbGMelA+PFs4W0wdLkTjpIcwhywn+an7mFHTEzTa4+8wIYZkrrMkHqhLEqY7822cyNG7qYcYvZWE+lZZmZQwlmzDDzvAlhU8vU+2a7TKT7uQfG5q67JlsjhUGns2AEG8jFom8AtM3/nAYRjPqyamtWFxn4HbS59C4eQjueHydFXkvPACkywtktX6z7aE/QgDXMmDHA2tY9GZ53iXFWJN4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84HNk7uoBBMrBXUL5z/zVh6cGVWc85Dodr9OKp8o/6A=;
 b=B0/2m2tNcGs1JghjburSEXdGz0izoQukucwPvGDs68U62UZ53SXQYHAtaXf2G55UmxMSC+1dmHJ44sVbSSnoqIiZaef9x50npW6HLYhxgigOxty6gRGoY9wD/C1FBVkWYYOnfLARb8hDezzXXEadnly4eD4tX7SucVYLzurUJ3xBZs63n4+WQ4XXkrVVCBtennth5YMygycJOMr6gPQsjnK/xJvYKmw00doz4YEBpxfdWcFikrAaAThoY+gdh8L/zycPo7byI2L4XBiU64Apg1A+RXtFXFwiWw7Lj1CRun0FFMTqjS/1ZdkpjMacL0RkkaxYzawuGjqEuum2F+KdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84HNk7uoBBMrBXUL5z/zVh6cGVWc85Dodr9OKp8o/6A=;
 b=wegu2jNRLdnmhCP8jTsJ63xA5CULeiCaChjqjbr8qJENvN7NiNgSNmD8JcNH1JK2b10tx5lFbGeJl0PlokPj8d2yQOwckVdX6lB8wOf93/UnrAB2IEkaWCHtl5wH/RN4n1jKkZTL/BZLhJw67Y+24pO6GxGozHCaGuMEaJD9s2o=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 00:16:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 00:16:34 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: Fixes tagis need some work in the pm tree
Thread-Topic: linux-next: Fixes tagis need some work in the pm tree
Thread-Index: AQHYkYdEPjBhpI7O6EW58xdpNw5SVa1yCdRg
Date:   Thu, 7 Jul 2022 00:16:34 +0000
Message-ID: <MN0PR12MB610170FFE6DD228E737BC4D4E2839@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220707073554.01b962df@canb.auug.org.au>
In-Reply-To: <20220707073554.01b962df@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-07T00:13:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a620933f-00af-4f2f-9fa1-49bb0d70eac9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-07T00:16:32Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 48ab5b7b-5f6a-463a-aa2a-ac208c3a71fd
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3d386ad-c5bf-4699-1a8f-08da5fadf374
x-ms-traffictypediagnostic: MN2PR12MB4253:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wRPtcmFf677quQ+nfQi/hvgLMLxzc51XRkhN9IFMvRX8gTJDOIXrPwOBRz7Ysz5ibuUzR3F2iystTOrGgQM822VPTi/akBZMsZlFbdUUlkEZFZdkTlADz1BaEgFZHU0hJ2scGZlcXoF9JI82PGLghnjY+Tv98w4Ox889mkS89LPRxp2zVSAszG4N5MyUBtm2CX0i/BzAIdK+TdaLHU9NnyCyaZ8g9JFEHG7j5P2Lll4iSYTVeDYlr8oFaSS8Nxp81M/JphFoVUvOUtcCWHN/5e2k36fNxl8TrDgrwi9kVB82a0Mm3R3zbMgND+p2cviqXWxF6mCWw6UoE4DTLBnIY/jOVAVoz72cGd/XwnByIGQtEquRZIzI4EJpm4j/qiPrGAKssZiGn9d/gTLfxm4XRqWh+58pqo7NJdrLWU+e5vT4HYaPaswS98m37ZpcGMxN8VPwe1XQvDQza2+BsRPousDfWGtI055v8OpW+vqCaWcxqHxj70eOAMl4+xtLkVC/GTPRHGYoNH346/E7OAH5thlDMT0N/UjsyiUIOIRyShc7t7G0uzwTVpXGOB0clBDe9WUm0eNBl637jSi7KE1USsK1nxGUfftGWag+aGdCfZcLmOAEKwlE4JhZDTZVIw91JZbjJrX5b7qHhiKlYGcztdhKjVxCx6P41V+ZMdOcPWtpZWwwLnqTY4VAr21Fe6CsiDzQlNX2ZOkzVvNSg05D6LKqakdoXgekwykB1+LaL606gWMnmv+reL2qrMrB1pSP29h6AkuGW/jjgzvonhpyPEe1ROebI5ul4sC7mL3zFbhKl4PGQnZeQ+GIK+ZInZac
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(110136005)(316002)(53546011)(7696005)(38070700005)(6506007)(186003)(122000001)(41300700001)(55016003)(54906003)(64756008)(66476007)(9686003)(66946007)(66556008)(66446008)(4326008)(8676002)(26005)(76116006)(71200400001)(86362001)(83380400001)(38100700002)(2906002)(478600001)(5660300002)(8936002)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+mAj4KcOZhgoj8PmlJQZbQkpIgDFtwtnMzDe5cI1r4robza5fDxgbWeQRZ+a?=
 =?us-ascii?Q?GW3qrvQj6Pyyi19K4WK7TglgtuMkGOlnocSZl8qw6+sEW+jn1QwsTpUFVM4Y?=
 =?us-ascii?Q?73uLyBubK03Vv4mk0tMGW8oriJScQwNXvo6W0wgdRkgXXYut9KrUlGuTIPLz?=
 =?us-ascii?Q?QpvVIbewlsTB7wfV7xbcYUtw5uTlJqBrB7dQJ5YeJWXAWurfmNflPbZnG0L2?=
 =?us-ascii?Q?hPmy+Q47LhDfcO7y6y4QySTsp/57G8hi57BnVc5kc8Jyo4bblI3hS3MmSRB+?=
 =?us-ascii?Q?icWUj3En94asxSswkQpLQQe2a39QO7cGtrvtFrt5YuTtv5+BBynQ0RLoTpxk?=
 =?us-ascii?Q?RkEVtAM9xlm1XGKvXxix0JRvyKR3SBWNJpPBzN2qm9mXivlMaS1kUFchwYNE?=
 =?us-ascii?Q?hmDxMu03hCoSbesLu2Sf78QqccaLvjV3SHmRzlBAgEcTdIqzfC0hDOH0UiZN?=
 =?us-ascii?Q?tjjDoZiHcDE0DJ5cAGc2v2+iINH7EmBScTUQ1uhSnlZiW7aDMxiPQIKHVRwb?=
 =?us-ascii?Q?TrehA3ENkWLblqdMKSoBBFESCwIwhBrTHZzZoedYwlGz94HULmeSwKyjyLpf?=
 =?us-ascii?Q?YzafisUkSiTwkvQX/UrAi/LvpIYY6gPoILG59LO637fOs3oKlGHibu/7XTI/?=
 =?us-ascii?Q?MltEFrUwsXI6ZHVLlGQflUloF95NUBvbuRyz5rZDGWp6bGCuqt9MRQ4yrsPt?=
 =?us-ascii?Q?2rjie4xIQGlXdnp/RegaLjTirU6qscEhNepTMs3WuTsw1odcv7zDcudaq6fn?=
 =?us-ascii?Q?nnA0ie/6JY3RQ3YyvPlkbXuczQ76oD9C/9aoTRbju6zxyorZj7i5ULnZEQgB?=
 =?us-ascii?Q?1xgml0l3VHIlOmzpwZck1ZFkuyvH1XkMxb2mEgQ60Gxoo911RRWdtyq8ZPZd?=
 =?us-ascii?Q?13mlejBctzo7PAVf3oQmfSrCUi0333bTtwTfGufKPynp6wBiwtRKhs/44NEC?=
 =?us-ascii?Q?9LO5jFXMRrrye5R9dtSKprCV8ZePMQsd+xUhXpA7L9GJcRnJ/SePeIVFUn8c?=
 =?us-ascii?Q?rUCgO4Br1W7wjijcz/Ro5IVkv/P8B35LD9R+nB9iTI0ma6KvMP4onbshp+yw?=
 =?us-ascii?Q?1grWfb95pc3wOd/DEB/AStFihMdXjT8P1sjI05hFMylrw8smu5NMyE07OAqy?=
 =?us-ascii?Q?9MbWDLv0MMWFt8SEDwjlF895+Qp/cY2InFIRd9ieA0WtrnL1zwFf0xqua6h2?=
 =?us-ascii?Q?hvGciD6wTV96FgIqn7/CS+w7gqVozBEvXcJb5MJR/GD0Kj/XjKrBjsYlze/F?=
 =?us-ascii?Q?CVtJI2mGxupRGwRiPOItHzovZRaUU10LmHarTviSB457+Ufcc8tBGsu47zpK?=
 =?us-ascii?Q?Qx8ackpdBQkZjrmbUSRt0AhmtB4y3HVegqp4jxU+NAQNMyvxVy6TldBacEUF?=
 =?us-ascii?Q?WG7Wqd9/Np7wTL8kN3w5mM+mYhaOCvFabFgL2cdDZRZVvV0Hu50m8JPFi53W?=
 =?us-ascii?Q?Ju4oKjCCLjBxW00mOKg0yRsDsVzSTDXp0bS2+eQXjt9HbEiwn6E3oE+mhVvM?=
 =?us-ascii?Q?ePX02m8DUiQXBE9SFh+7z5Dlz9Twy8Hcb9oBvYoyDvxgudVz1q4s8sLYLjJV?=
 =?us-ascii?Q?eV6Y/W98UfnIMaCYlDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d386ad-c5bf-4699-1a8f-08da5fadf374
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 00:16:34.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8O5FIaf002Ni+rLaYD3PhTmvzqcwlicbVrEgSsrN6ExkSadCOsAD5UUrvThWObHZ7easUFzUhvfrgyYkXEwVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

Thanks!  I've put the corrected tags inline below.

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Wednesday, July 6, 2022 16:36
> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Linux Kernel Mailing =
List
> <linux-kernel@vger.kernel.org>; Linux Next Mailing List <linux-
> next@vger.kernel.org>
> Subject: linux-next: Fixes tagis need some work in the pm tree
>=20
> Hi all,
>=20
> In commit
>=20
>   8b356e536e69 ("ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
> supported")
>=20
> Fixes tag
>=20
>   Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is
> supported")
>=20
> has these problem(s):
>=20
>   - Subject does not match target commit subject

Fixes: 72f2ecb7ece7 ("ACPI: bus: Set CPPC _OSC bits for all and when CPPC_L=
IB is supported")

>=20
> In commit
>=20
>   7feec7430edd ("ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked")
>=20
> Fixes tag
>=20
>   Fixes: 2ca8e6285250 ("Revert "ACPI Pass the same capabilities to the _O=
SC
> regardless of the query flag"")
>=20
> has these problem(s):
>=20
>   - Subject does not match target commit subject

Fixes: 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the _OSC =
regardless of the query flag"")

>=20
> Just use
> 	git log -1 --format=3D'Fixes: %h ("%s")'

Thanks!

>=20
> --
> Cheers,
> Stephen Rothwell
