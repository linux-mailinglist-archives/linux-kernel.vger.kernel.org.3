Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF951851C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiECNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiECNKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:10:50 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E44729C94
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY+v40n9eQg3mYv45xkrImZaUWGgNk2rISHIcPHdU4/7Wek9vpNdPgkCcCRqGOmsI0+w8EFvN1G3FphKepZv6TbPb/AAFYGQG1MfNV2Vttu3JNaTu+/9ZaIa7Wi7c0BR5UYIJVIrg+36CiPrFk89XHI/Rm7BmlOe5bwg2HjKXwU+9cByWkj5JAgcdlJAocH1AQPWhMVXnEwGrOLgPmKMJaGX2t5s4nb08hjV+z3P2yoak8IzDH/6EPqNy2sFGyTasZAFr7t1Ns+tJLG/Xas7Qtg6ZgazdmmpC2UN00LyIOSrGeMyZy4qf4LQ5uFU5z/X7G0TXI/z0/spdJnuy+vgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbDBwsXM1m9tUqiQIhaCzUosKZM2WhcM0m3lyAMRX3U=;
 b=izYOoO0NdgTs3rTfnV6R/zT+dEF6sKXL8dw+BbIZFqEgfrBCweplsXpo76dbfVkUoJAmkcXUho0Zr8Hl5HWHgReUG/1T8TvKhn9GUV1ontCAs/dbtMuunPxQQlsa1xNDIFw00znXoK+JskdZq9FkfTcsZprhG9A8nOKkO901E6IpL+sdFMb1D6/cVDaclw3s7W+lQ9PA6Ie/7Y/MqhADiMpbk0cTiCcTWw26XOhucnNdllU3SiXR59Q8tc7uvs1vO8MT2A/9+Gt/jjVwRj/aLos+r3Oe2Heor2MXPVwW5s/KAn/ZKsxjLNlFzvFfUZRn0NSPMqILz07nIH76e3P4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbDBwsXM1m9tUqiQIhaCzUosKZM2WhcM0m3lyAMRX3U=;
 b=VRw5kvbTagLIEYwjFetqZtM5j6/Uxj4NHBwx/uWrjm3daax+c49TG3BdE6oSX+dW8LmGq+uvoO3PNxn/BZSfUQ0R519De1kd8Z2rVofhSnIkQaiuZ91KJuR2hz1cF4EtvRv/yaVflBC4KqVzPTS2nSgpdT0l5bTjGpZpbHZ3ew8=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB1691.namprd12.prod.outlook.com (2603:10b6:4:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 3 May 2022 13:07:15 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::797d:cbc4:9716:310e]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::797d:cbc4:9716:310e%5]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 13:07:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
 thinkpad_acpi: quirk_btusb_bug can be static
Thread-Topic: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
 thinkpad_acpi: quirk_btusb_bug can be static
Thread-Index: AQHYXt+N1KX18mXWX06Lb6ljkwtjIK0NH4kQ
Date:   Tue, 3 May 2022 13:07:13 +0000
Message-ID: <BL1PR12MB5157478736D9C5E82B4D9B1DE2C09@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <202205031944.EP1ElC1B-lkp@intel.com>
 <YnEPbSO2rBJq37Ez@74ccfaeec2ea>
In-Reply-To: <YnEPbSO2rBJq37Ez@74ccfaeec2ea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-03T13:06:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1e6ac0de-a6d0-42fd-b4fc-6a3a2b7b01c7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-03T13:07:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 419cbe7e-fc99-4408-89d8-7b4a59c60509
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1398504-e392-4130-6bcc-08da2d05d72f
x-ms-traffictypediagnostic: DM5PR12MB1691:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1691BECA136A3704519C99BAE2C09@DM5PR12MB1691.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3mbwUVC58foMBFAhim4sLSNkM7iB9Tc1JlLt8ZTqrlMHhVCZrKr7E384b73sk+2kYRROpu+gMbVc7JBJN/NFloaujdtVFv1xtnb5EPRe+wTZ7NzHSari169th5zQ43xHIwreMTs99qg4S18YrFYKOeoZk5nfaU0LRsH9mR4QNcd7DUtswTxFuAgrwjZBZnz1KlqKbTa9fRSkdeC7vhtCUiyq7EmVPSWh6q/6yiRq0v4W6OqId60ziNG+MbeK1lSFkr+B3xf4fJhUbY40+0h5j/bn1ANp9QX+qRajmMbPRp6c16PCZ7IawBVpRGMZDjYAZt8H+g/LJ2Lb+U6DWuPKtFK8DYmdZgfXNhj6ex5V/35svi8EPmSTVoH8Xx2pjJgEaSNM3IhI6ZqmHugd7VVByOhkU722v0Nnd8uctSs2fNo6lUuWAvO5RNP6DEBHQ9wx/9ClLYOc55cAuTER1sEIfc+z3oV2Fnr+6LkY9SjsXZbRDl2UCR223dIL6tXs98F4yT5OXw5jdeXnW7k+psMnAmSNQ5piujFhFWF+oyCAlLg/oPo4b4k3msavqUNVWVS/5xuqkElVNOI9AVrSKziIygvYZxTpz1natm8uJydlW8Sto0iOtkkeNnfkEGiTstuMoYgfq1T4N5A1Y5ZY+nikYmkPCDS2qhWEIyY/5iMWu67GnHAj/mK6rxf2JJ5OIwpS9CyRtwSQL74fAFR68JALQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(122000001)(66476007)(64756008)(66446008)(38100700002)(38070700005)(4326008)(66946007)(76116006)(52536014)(8936002)(55016003)(54906003)(5660300002)(6916009)(2906002)(71200400001)(316002)(86362001)(508600001)(83380400001)(33656002)(7696005)(186003)(6506007)(53546011)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P8zqKBRzZM8HxVTj2uYEjGDdoWnpyX6AoJHlqnIrq0jCaYDLoEnGWtPI7P4A?=
 =?us-ascii?Q?K3yhBvLziHRWvNWap2xYIW0PDlxfUTfm4zWVq48nBw790FTpsLxC2nsge/dj?=
 =?us-ascii?Q?PzvQD7HJgO8mCMJicQJZUcRJtAnBCk07ZZfpFOdyAl9ZTyHYZOtEz7aJJGBN?=
 =?us-ascii?Q?fZSUrXX6+y7OM1wgzFhgbU1FzuCu8ehOTe/WFi9ZtpXjn2lBwIcd2Ljpzmlb?=
 =?us-ascii?Q?0aYmV5nIjS6XmYSht4JgppsxCJeHkv5pm48FoQalIcow2YGkKtrBxVGTKYi/?=
 =?us-ascii?Q?wlowAn56w1QHzsFjft3pahQQVDhM+ZsyZQLtR1sGvDa2vmOj0Z+xVT5MqQyp?=
 =?us-ascii?Q?8Fdw3R628TpL4zRTRasdj/8ldqyZppSgysiVWD6ImPXmPQiSXAryiTeZwEXL?=
 =?us-ascii?Q?jxTAipYzeMkUZ2byL0qsrZ+crCLHZ7+TMhwk0s3Ex9Ie/PxkuPTnARa66nGV?=
 =?us-ascii?Q?ZyT6MGfA5PyGPi6hsgEutGXa6xsR7YUt2fRX5i/JC2M38sNwwlgYhLi+qeOa?=
 =?us-ascii?Q?2l/AlmmlfwGfE0NZAyFcCBJDGuOxEzERB/WuEvDwWymJCnPyFC5Rq2LfKofw?=
 =?us-ascii?Q?3a3//jqUAvvVp9veSh4AEbrwFJnudBakky8B+0pwOLYtiU4+4n+WmEko69Ed?=
 =?us-ascii?Q?ZDGn27IjqXvGvjBs9EIyxWk5aaNCjs6P/SUv2JBNbFy03pMA9Lj0l5cyx7uv?=
 =?us-ascii?Q?j03atibvHk2oG4PnKWYAn8sxGSZ1K/VAaJ+p4dwS+pLFnP5ohlgz2Yh7QXkG?=
 =?us-ascii?Q?XyH3gpX8MK5yNeCQm0Kv0OB1CV2u3NeJXCrlQ0mmcYP4rp5pQUhWvTEPOB5O?=
 =?us-ascii?Q?epSS8/T0kIpC2PZcNU6Wp2xRx/EadFNXLTfaAxEb+Xj5Qtmg27JbevB49krC?=
 =?us-ascii?Q?KsWiDzbtr6as9OawLau1ktND2Sat5m75Im0nLfp+caVemaODAVRNrDOHg6JJ?=
 =?us-ascii?Q?L/ZjUkA9QF3+NNe7r9Xvzmsv4xfBen1vSrYfryxN+2Y1I81aAuiec/W+0GTA?=
 =?us-ascii?Q?pGHsyU5538jexRTComN1SFM70aoM9oCCZSDE5HF5Tz8DItMFmcf2XlRUCRbt?=
 =?us-ascii?Q?KWWtXzs1dz8BGB1g329KwDMFaa/314tsHJ2zivp/3LGfAzxU3wz+ujH2h8OB?=
 =?us-ascii?Q?t/9KLel02lmtgkgPorT/nHpDWII8EsNyhNupwTKR750ZpWXBVC0CO6V5DU9Q?=
 =?us-ascii?Q?FAe/JGWb9dNcBDg1bBokDVQlctzqqaRC5vxTKo2tHY6UA164Okry1FJ+OH1X?=
 =?us-ascii?Q?3udmOqG4o8z3f7uvymDHOSo34iR5EZFkdIM2Ikfoa+iIqerAByTz+3sJ8Hjn?=
 =?us-ascii?Q?WzOe9cfYg+1wN624HzfLFCu6sD3Dn4FHK13OwUFt3cA5celP70/3cvZ0bBVF?=
 =?us-ascii?Q?WARTY5RMk4RZdbNH7Acr5THCWXH9864hJjv2EyWj8bvEKh4SqzhvsukvMXVp?=
 =?us-ascii?Q?/aoMGdR2WGMLpEBoSL/fa1Hvrfn4t7bzsE4zbfP9HfvwGwZyKyFc1UGCgH4c?=
 =?us-ascii?Q?Yg5UmwRY9lOSJ94h3D3wV8voLPhmZ9Xk6IKtB68AsVvxSIeIl72PUCMs6+GE?=
 =?us-ascii?Q?5AHIMMycHcMyH79Jje1DihgGkFGKwxBfI+0jM39n3ze9hFFWt2HIVEtmuIb3?=
 =?us-ascii?Q?N/KRnLnbj0BB5PD7BxBgqTRu8GD0CB6rssyBDaP9XubeKLt17oaczkpA42l1?=
 =?us-ascii?Q?3oNnzPtPMMBvsNmX4T/+EmDnzKGl3uERFLCP03H5Jy2eVJAr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1398504-e392-4130-6bcc-08da2d05d72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 13:07:13.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VITF74XS5s06ri+D2pZfFWkKb3Ig7AN1QoZRiqp7LO8NuyCWNuDCk9olfNvzAP/kRMR4/iS8hp3QQuGaXajgkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1691
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
> From: kernel test robot <lkp@intel.com>
> Sent: Tuesday, May 3, 2022 06:18
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: kbuild-all@lists.01.org; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Hans de Goede
> <hdegoede@redhat.com>; linux-kernel@vger.kernel.org
> Subject: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
> thinkpad_acpi: quirk_btusb_bug can be static
>=20
> drivers/platform/x86/thinkpad_acpi.c:317:20: warning: symbol
> 'quirk_btusb_bug' was not declared. Should it be static?
>=20
> Fixes: 25eecc2ff6cc ("platform/x86: thinkpad_acpi: Convert btusb DMI list=
 to
> quirks")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/platform/x86/thinkpad_acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c
> b/drivers/platform/x86/thinkpad_acpi.c
> index aed17d32ed84b..eefa22e86ae10 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -314,7 +314,7 @@ struct quirk_entry {
>  	bool btusb_bug;
>  };
>=20
> -struct quirk_entry quirk_btusb_bug =3D {
> +static struct quirk_entry quirk_btusb_bug =3D {
>  	.btusb_bug =3D true,
>  };
>=20
