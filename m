Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3714F5B1A06
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiIHKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHKbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:31:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A7BC11D;
        Thu,  8 Sep 2022 03:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUIQKQULGkK/gZcSVvjbtguB51ydzanpd3FAaqgAoZd7ll9Qv+qVX6tVEqBbAEZ3Zj0/G+KYIMBUg1vu2JNFTJt56SVzrw4S/MW47J38TW8FjyjjY+QtJJ2DLNnr31NIzSSIdQeKgXnOs1KMqw6LtPxAhazsKdJPl6B7xJdqw68JjqPVRyqzftWGaPlFAK2J+sq+EyR2aqm5XVv1no4RkK5TFpdeNoc3ta/72sTu2MtGslklbqg3A+E3ptHwBvEnxmUSIAp3IEfjCoDcAqHb7rxm3RZR7BsoHOsylfGsoLlr6zkjDzcImsmXPlA1GcoiCK7FJ3BZhTIZKlHeS/vdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBSDZLhGSjM8dDpKlbMeSmu8poTVqsM/OvTz/79y7/s=;
 b=Mrv+6ud49nyDzGXKZH0liXgf85B9xCf8MNZYqfr2i34ASgH8+11iATsg7xrFlweIrV+kGcZ+6yYTjMEIKrGGf9myNGRKzxI1F+UXhwqFBeE7IolLuVvrHEL3196AGbTnJkfRT5NJ6roYPnemqWh2E6FBTC++P74FXqezIOamxX3GKiP5/nsFkB5ljWzh604DuH4RGjdJQ6r+rP5W2IaupWcuJCHBhaZtAjttZA1u6oFSwfVGp9cysCFpFwJC12QWQ7e9+eCxv5TQSP4xr+UuA1vsg8MU7J8vDJSJLqUwDC4uOPoVzYLz+MT41F2TkPZoTNBEuQfQ2dPKneqvj5S5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBSDZLhGSjM8dDpKlbMeSmu8poTVqsM/OvTz/79y7/s=;
 b=tDziDcdkuXyxcfY2GOl9iuXiv7MD56K8vXbkqQKgd78jFyBEjaNNGVBvG/R8A3pvxCwtsU36iIIFd5MsONz71Do57599Qq98+v/0w97T0T1w9rcO/XQVs1C2bzObR9rkPNUeHQjlbnCFVRVAXZwpeVQGCHN621m37DVKYa3G060uhB72qBKQAdi9d5uWjoiXpLn3XIk4Te8g2539nZjpaLdf5ZtkCsalOiPdAAkXjJxZ5wuiH2L8qeSVSxvZq5wsvdTAmLlLrt7+2t1jITVE8wnlsisoqV4rmkMibPIDcWSXcHAfigBhDb3EJTEcoOpdkYjO4zSlxt+kjH5UgiVpqA==
Received: from DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 8 Sep 2022 10:31:46 +0000
Received: from DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::393c:2a84:46aa:3177]) by DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::393c:2a84:46aa:3177%4]) with mapi id 15.20.5612.018; Thu, 8 Sep 2022
 10:31:46 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     Suresh Mangipudi <smangipudi@nvidia.com>,
        Manish Bhardwaj <mbhardwaj@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO
 driver
Thread-Topic: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO
 driver
Thread-Index: AQHYsVrR8d/SrHtqn0eaQvTMm9Q+uK3VeXWg
Date:   Thu, 8 Sep 2022 10:31:46 +0000
Message-ID: <DM5PR12MB2406751A5FB491DF5AA50FCCB7409@DM5PR12MB2406.namprd12.prod.outlook.com>
References: <Yhe0pCpfeCpyfPWg@orome>
 <20220816102725.14708-1-pshete@nvidia.com>
In-Reply-To: <20220816102725.14708-1-pshete@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2406:EE_|DM6PR12MB4941:EE_
x-ms-office365-filtering-correlation-id: 1ea5b938-cdc0-478c-cbd7-08da91855498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3uD/XCeNHriukpPuZdbRiKW+cidBEXVfCoGhzzJ2e5fYqo7mf353dnbu6h5gE3vCb+y/sESMRLfecQ3NAhJYv2UzUPtyyDJ8tUxTApfLA9dq1Cz7MNjjuopgcRIpgG/HgnCp536FChbSupyg9raGnIicnBH/Tc+K1MVCS/7lJwXRjIOpOiGB52UDnwJGGPPePb/CahoarnM+Cw7ZLc9RyJINVatWJmrwApqvxWrdPUpN2cuegRdPUkwMu3NBpvqlgSF5fhSE5fIEMQJAnCdmkbTWEaNjbnmvv/jvrsUh9uUY8ugZ78aMtSFQLMMmjkUCjUK5GrAUg0S/5w6AQoGgKS8dFi07cm9Ym/NKKhGrhPqLsXgtOaySvpfKE4j2Hlc1f5VkfpIKMPupIttu2t3hgv69myB0DpIphMwRuIEjCnj2ipeJ5MfgeY8cuvJ8cmcShWD3x7Fqf0Gn3tMEYiFZlFa0RryYE6Qek0ICvWy9kS8rquMRI1B4vLd960WmYyavjb3ZMAKJM8jUCwNh+bM4eeCAMX4UpAghdi4QvL06R/29HFkzsGM6HENzR/HKLIVivUySlKSE5zvcH9NOxpT1ObWR5hgX6y+RLvuEgoy7fNg/Rc1G4F6e0pJqPjXEUy7Qt8KGOeKqJnfLhFMJzla5J0VITD9xexHpyM8LdG4WOZ5QAT0N9jKFAs2natERGwXVnzqPeaLUGqtd0N/25hGEntvXGQlYZLpy5MM+xL62K74zPnQovshdQobuHjVb6f35SCrC+NR5kqbQccuZnmk3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2406.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7696005)(66556008)(53546011)(8676002)(66476007)(66946007)(5660300002)(110136005)(83380400001)(8936002)(64756008)(76116006)(107886003)(478600001)(26005)(6506007)(41300700001)(52536014)(71200400001)(66446008)(186003)(54906003)(316002)(86362001)(9686003)(55016003)(33656002)(4326008)(38070700005)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kHavmy9TEsvTr46ImgpN5VFCTitAbF1vwTl9VgaQalr0YWkvbxGbodtY0+Ra?=
 =?us-ascii?Q?kYPzw3CesJMvUkmtZ17kMITNrXCyru5YjwYL1YMvV1NAz+U3x4tYN+AKOX+F?=
 =?us-ascii?Q?MDWFCVz0jridvmhwtXP8gbjQwkTpxiQEKfaAlLhrpso6V+Tgp0ya6D2DEyDE?=
 =?us-ascii?Q?9aVlLwz6hbdTmXKTjBU71GFDTHF6bto3YYxKKDswWVMrgQZA49JWqPnlDQSS?=
 =?us-ascii?Q?xNnfVlgHsyupft73rkQb0YVFhFUnmSwzWWTmOOTwcPuoOCGsZC8Zlyf9lO/l?=
 =?us-ascii?Q?ne1zOHAEbZi3JFhmibpSHQH1LRfLyY7rNEiS10SNYo4RA56xYofgB0z2nRJQ?=
 =?us-ascii?Q?cVZ26A3Bcp2yYU5bJo9GFdlqaXkrPT4Zn14xxhyNo6BbjBKAk/riH6/CPsQr?=
 =?us-ascii?Q?kaY7xI9emciih6ebRq6vvOYXiApUBeHnDDAlx7XWkQshBloYpGxNxuzNt8gu?=
 =?us-ascii?Q?YjpU/3oL1V51Xj4tcld+IQYmvREjAfkqGLDpPeF+JrPg747jWR6ytSLbhCdI?=
 =?us-ascii?Q?6FNXKjOA+/Bq6tITbuZb/hKp4Q3etqqFFhkmhBop1+E8EAGtVKPO9WPNenQd?=
 =?us-ascii?Q?Hj6XuWVXQTVvTxPgEmZwLh5cn3dUZwzuXPiuCXnPjMUuBZzazCZXpEtXJsEa?=
 =?us-ascii?Q?80rUMwzFUPCZaZjCYqWYCitglwslohEwvK3IuxWss+Ej0Yxmo7mcs1qhx5UX?=
 =?us-ascii?Q?2GMmBZDbw8bnmWMmfLP4Y5iaP25znU8H9Pz5dGTk+HUKxK85vsXyTTwIjwwn?=
 =?us-ascii?Q?VkLEkt7GRTqAUsZRMxooeqpYiBVDa7MXT/SSeC/LadWzYsd6rsbujDn3O4JG?=
 =?us-ascii?Q?43roAZ40ax1WsyvC4m1XdpiJHcbQTXqIaHWJPCjVwaeft7SxCsfDU3Z8jhBM?=
 =?us-ascii?Q?WQKBqlJCR5OjxmXbZA+czxlpcNVyr6HJ8wX5VQUnCc0I8I9BoXBV7jO6hpPw?=
 =?us-ascii?Q?YmXIZqGuOCisCoQicuk/Wmdu10bxvTLtd+mHXbMIU/GKYHEl4WZI1pTobO0m?=
 =?us-ascii?Q?8utngTSXdBhgg44Yjn1BhXriN/Cf0uut0Ndjfa0m1M77DapOpbCVhLtzM/BG?=
 =?us-ascii?Q?OImIFHo8TkHPkvcSMtRImGY+YJcAUzWwMC7RtTIz9NTV3pSZjknYqwZP5QE3?=
 =?us-ascii?Q?0wQ9bJbA7q4DHjGq8yJA1273PXw8SEGXf0ara7NzNcJGWQk3gi4X9Z3VJK35?=
 =?us-ascii?Q?KytczEKzZJNqqVJrMFcjB6XvtSjjkOz4cVJeHK5Ah3e6E35kx+HodvUSL/hJ?=
 =?us-ascii?Q?D2PSsTdDrRGokkLMqhRXwqp9dk9ZGEqK4/vcWwwn0TIHW06c/zINT+Lkr+En?=
 =?us-ascii?Q?Oj0Xv0VyVEYNAxfd666CFH+0ImB6MVsPTgT8PIS831AzigKEWkrhrTT0ABKk?=
 =?us-ascii?Q?RZNKwKz6g7sV/kT1HmyJG9Mef32YeKngXZn2l/L7lXLBe4dC3DjboCFhYRVd?=
 =?us-ascii?Q?3biiMGQuq66Q9TKySuDCj2WxuwahaYSVJMZp+B37p7E/VGMdfJIBjFvTsDP5?=
 =?us-ascii?Q?zqPGvbS2CYZmh8xFrXksNimo7yrtVqBrQZkKS+6V/AsBSfZjC1azOaHYB70p?=
 =?us-ascii?Q?3J5AAyoIHIk2jzl8y2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea5b938-cdc0-478c-cbd7-08da91855498
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 10:31:46.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXNtbCiNmXH6n87yvLkKmZREgdmhlqmgFJ+H7mHGDtQBikzEj3YW2LnNIPN1ZYhLUjscjHjj40QhJf+WjFritQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=20
Can you please help review this patch=20

Thanks
Prathamesh.

> -----Original Message-----
> From: Prathamesh Shete <pshete@nvidia.com>
> Sent: Tuesday, August 16, 2022 3:57 PM
> To: linus.walleij@linaro.org; bgolaszewski@baylibre.com; linux-
> gpio@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jonathan Hunter <jonathanh@nvidia.com>;
> thierry.reding@gmail.com
> Cc: Suresh Mangipudi <smangipudi@nvidia.com>; Prathamesh Shete
> <pshete@nvidia.com>; Manish Bhardwaj <mbhardwaj@nvidia.com>
> Subject: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO
> driver
>=20
> Using this patch we are adding PMC compatible string for
> Tegra234 in GPIO driver so the IRQ hierarchy can be set.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c =
index
> 54d9fa7da9c1..824a355ff27a 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -669,6 +669,7 @@ static unsigned int
> tegra186_gpio_child_offset_to_irq(struct gpio_chip *chip,  static const s=
truct
> of_device_id tegra186_pmc_of_match[] =3D {
>  	{ .compatible =3D "nvidia,tegra186-pmc" },
>  	{ .compatible =3D "nvidia,tegra194-pmc" },
> +	{ .compatible =3D "nvidia,tegra234-pmc" },
>  	{ /* sentinel */ }
>  };
>=20
> --
> 2.17.1

