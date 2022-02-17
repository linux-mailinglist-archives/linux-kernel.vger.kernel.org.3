Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C14B99A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiBQHLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:11:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiBQHLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:11:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03068298AE3;
        Wed, 16 Feb 2022 23:11:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmGlMTEUPqYziOf2UJE9S7fKDaE/AqCiR2wGBaroKhVVtfk1AgCqS+r6YMuS7gF8VOOFlmucmiUrp6yAMo/qGxL3GSMcfAHXq141okc2zBTz4TOR/vg5ZRjHJoaxQhvqg0MAMbfbgLtu8qBWZ0yzsMsBGKwZN6JfCCkQXOLy/sE+hiw4YggutOVfguGgzcNmXiehkRoVgHO79vQbsTC2f8T6IAEvm/Cc0npIA/YtIK/hjqg6UbQt3f9PngThzV4EgnPD8+iERJHToi3bpRla7D5KsdVCFPqwWUOfnd5Bto682jHRwoDjA3zPojtEDmCmh7hiVKmyY6HUyAny/6cqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L52cvMFB81nw1KUE02eAp3Z5r9Sr8v3OkaafiAroEuU=;
 b=nv/p7XRy/J+2fYGXxaOTfXZGNY+UIT27A9TijCKcj/2s+h9+qM2puTPJ15NOknv+nPrbh7QpweQGTi1o7Qi1wkTmRyXhvTfGAikRhvU53GFcSjYtWajatMQCmG4zXj3e593ynYQW6eiHA/Zac3cObVNgbTdRLEeH8DS5BrWaTvRaHPwLswiA24j06siaVIAsZFm92Ai1tFGTiTAX1gdAmksQaB1Pl2F4m0wjobe62CY5CTbCrVGdAYhqe8hlEqeyV/cRSPtFQDGgwXcWSvcOZSJftdzvXPMJj88Zzx6waeqxQKmGL73QzRCED2Wat7oDoNy5/IXwDy8mzegtj0rwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L52cvMFB81nw1KUE02eAp3Z5r9Sr8v3OkaafiAroEuU=;
 b=fYg9mf1SG7s7ob/mGoas7AfhQXy7ECybjXMdvZd3ymYgEtRtGPXj6PS2al7E7myMa00mbVgrlhvoERiAtsvfU+Umm+sZ6JqB+p+fDHEopAn6V0vSsOGCE3AxhG7+drbZJOdn2d/H9OJiggbAK4ecoVBpbl6uDD4Exorl7W6X7aI=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by MN2PR05MB6622.namprd05.prod.outlook.com (2603:10b6:208:db::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 07:10:59 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8442:3d51:d711:e651]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8442:3d51:d711:e651%5]) with mapi id 15.20.4995.020; Thu, 17 Feb 2022
 07:10:49 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jorgen Hansen <jhansen@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "acking@vmware.com" <acking@vmware.com>,
        "dtor@vmware.com" <dtor@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 2/3] VMCI: No need to clear memory after a
 dma_alloc_coherent() call
Thread-Topic: [PATCH 2/3] VMCI: No need to clear memory after a
 dma_alloc_coherent() call
Thread-Index: AQHYHs1k1FkE9f+uNkWjdrIRHx81P6yXXVKA
Date:   Thu, 17 Feb 2022 07:10:48 +0000
Message-ID: <00F97241-10DF-4D3D-9544-105C4E9DC5BB@vmware.com>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <232d7bb2eace0d4dc2228134c6a424472412adfa.1644531317.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <232d7bb2eace0d4dc2228134c6a424472412adfa.1644531317.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a4be843-22c6-4c2e-d97d-08d9f1e4a0b7
x-ms-traffictypediagnostic: MN2PR05MB6622:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN2PR05MB6622D97689A87980D6E85EF6CE369@MN2PR05MB6622.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q6WzZHwkaNDuSmYlRHJJT0XLYj7URvA9km873ydyIkUo7oafZtG7ciIbKoanj8Hxs3p6vh4dMd4/Br/rc4oVhFK/Qef0/cpir7ci+PlLHIrD/Tj9QP4GrLXBdFMukmv+/NuWDz+Aev94bmD24Qsyh+D08t6zdD9LV7QL0fQNFtH6t7hI7AVFj9qE81m8hrHnwBieMvN2mZp/v/znwv2jfzYpIgBN928udCYvCsHg5E9XK+nKxd87O2iPDSSVxPfYEeZTQI+/zKmk4mmhieLRk4dyuzdIcTEeAzJR1XFprhlQMmyS+nXtJMm63l4JFDbOZ0VJ+hbUUKOP6rkYN0D6XPGeQZi3ctLVQ9U7Y0E/vff4xvA75ns8PoCzErx9z0L0gAz4Kbi3UvxEBCKNEPc0aaY+wen/SeiZ5Z2bVFJy8GcJALvWbKy8LVJQzRFWqKnbVcduJooSd4Us2UkxdHn6igOaSLi4d7Bko/E3Jl/2VlaXwLfEkz3h3tiR36a5126bXkMuJVrSls5wA88iDsr15CdueY3wQI+MqzTHdVDymsXjTUCJAQhCTApNvJs4QnklVB6Aw9+3YagoexLCl5MjUySU65vIkdteC6IIiy4cKZ4d7yCX3FqXglk86dqS7YjV7cfSN1lmyAVFiPhI3DXHzLB+XJCIQrMYQSQST84kCTa0NwUwnHLeuuxpu76nK6ySKhTFaeo9OpqTd3iieJpYYgtkKvqYoDuu9s/iAekCTM4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(76116006)(8676002)(66446008)(64756008)(66556008)(83380400001)(4326008)(66946007)(86362001)(53546011)(6512007)(38070700005)(6506007)(71200400001)(38100700002)(2906002)(36756003)(5660300002)(6486002)(2616005)(186003)(122000001)(8936002)(508600001)(6916009)(316002)(54906003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WU8uPgwA9OD1Ok/ZCCFl9McN2DU1GZhS8GTEcYjEbMI8fLbf4856sgttflI?=
 =?us-ascii?Q?ipeF1iVLbkff8fiyZIUtTK5eg2JVV4FuQYyU850NA4Pv9TEj/OTdpCv1lNVA?=
 =?us-ascii?Q?yRWysHW2V8xlEl4UcV+f0RcsTDb+GVFz/Otv57PGmVeTpHNo5rXPw6TU3RU+?=
 =?us-ascii?Q?6t1XrFrdtHU60dufcG6gMQZwrKgoeLAgL0tbmOYe3LOXyakyHelJw6hzxzOL?=
 =?us-ascii?Q?ol/6EOIpvHY63GDAzL9KPuEvvo1hFc+uv1fdvphWKbAefRrhc66m/l5rbmXq?=
 =?us-ascii?Q?vQ0Mdd7M1NpRcLN2h1XZW1MazpZc3/c31YPd/P9YNutxZekOQMf1lFqS0abO?=
 =?us-ascii?Q?+j3kNV6fHkqH1/H+zAkIWMVkJQ0pXv4eeeVYRbins+uKsQZOuhhQxZb+k020?=
 =?us-ascii?Q?Zp5jIc6Z8fEmrHDyUxTQAJcDMxaHUNvIafTg2E7RsCDtvFiuo1YtewWfOMvh?=
 =?us-ascii?Q?PUiFJeFOPYhkbMszYsxTGVoLD8Ry8KfepHEADsPCVruLKT3dFMfICHQOkFMX?=
 =?us-ascii?Q?OLpSFEoPS5+W8BdWPeh7hlodHvMKOb/YsdYAB3hMMga/BQZHATqZjl+4X0ME?=
 =?us-ascii?Q?KtQx8qLSkMNP7rR0SFfyoz4mCowNToYzkvhcrFKQp9AZCxKOseEOOAS9BMc5?=
 =?us-ascii?Q?FOY+u0ZeKg4WxDRbidbRBxDwrZfxegIZIYzikd/csVNMKkTu91AvXUGlzQ42?=
 =?us-ascii?Q?JZi8IASXixfdNikWGg0LoQFDrfO7o5Lg6ENkQKbhquF1x5a7r6Ab+CP416c7?=
 =?us-ascii?Q?Pb2QqT0ibcN8ktfchIINjntKacKwtA9Uz+GzXK64/MlYe3nc1tI+oRkNd3Ip?=
 =?us-ascii?Q?rrEJ8j7OrJk+xVd2V+oyAuHAaWJayqRD+oIcxsLIUviuMCMOyIbEQOhAOz71?=
 =?us-ascii?Q?I4qlE1yQ6Sfc8YN6xmPdNX88YwPBkje8TDI6zfPryX1A/5NsTNZKc+EK/EdD?=
 =?us-ascii?Q?RPu3Y8lk5eV4cNMzhgXslxYfkJrCNGMRgl/c8t+xCtfTflmWUXVFN6HnE6x5?=
 =?us-ascii?Q?BT5RVEpKPv3E0zlGk0eJlb7L2T0hTtIOzoRnMxothjNN4UIr7E28/r7w4dcO?=
 =?us-ascii?Q?Sd8HTcEJEkfM2k780EUvFAEq8GEWCq0wXk/1AiyBO3QJU8Io4SjaYN8cr0we?=
 =?us-ascii?Q?VVPDK86yswZSIvHPLrNg2JT9vgvJMMAoQu2F6/0YvubrHIYjeoTn6fDJf/0n?=
 =?us-ascii?Q?+woWuGu7lRUOPmI0YuTRmh91sygdtvUIFKpymYXzxGVD4CV6mrp2Vu0Wv/vf?=
 =?us-ascii?Q?CfsQyE7dSlDYbfCspZQ8mGsKuEUAcdPL8Wxekq9Cge2APxSLlKH1pzjitx2Y?=
 =?us-ascii?Q?SgrrAvJ2DBUUQoPQpRdVX0vLKJK6Nbc2Ag9LWbrtKylP4dScHv66rJuR9Q25?=
 =?us-ascii?Q?gOszob6LR2GI+/gBkxSFDCslIGznwXRaCvHuhwxdlUierTjyraoSaRYcKn80?=
 =?us-ascii?Q?VO34VuNfSEoPYMeV4Q15qFe88asZ/iiJuwnt+d93nrAo1w5RP0whPafEpGod?=
 =?us-ascii?Q?mdiEvhn82Alwx3TKpr9X/zlXSp7cIlJ/X9lkeeWL7aKXovtwDTF5b4Ar5MEF?=
 =?us-ascii?Q?OyBfYIU9XRxAjEH+7Q/3CnB1/x15HwIxKMrkphO7sxb87fsp426KcHvSRIuo?=
 =?us-ascii?Q?j8FHQm5nBaun4GfXxZeWdC09RdVO8ESYvCIiu/mftHjg3W2T4PYP1tKAV2Kb?=
 =?us-ascii?Q?ZlLe0BAnOCgkQaqi9nDz1RdyqpU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A61E461690373479C4A5C1469BFEE74@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4be843-22c6-4c2e-d97d-08d9f1e4a0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 07:10:48.9002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +V7rFEHK1USwRWVraosuAIx8mnIseGG08ak8XTY6sE/vB0MQFUu+3o3C/qYW+31vxFtycUaQ1f/Q3s1RpAzG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6622
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 10, 2022, at 2:27 PM, Christophe JAILLET <christophe.jaillet@wanad=
oo.fr> wrote:
>=20
> dma_alloc_coherent() already clear the allocated memory, there is no need
> to explicitly call memset().
> This saves a few cycles and a few lines of code.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> drivers/misc/vmw_vmci/vmci_guest.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/v=
mci_guest.c
> index 1a1858742f75..02d4722d8474 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -706,13 +706,11 @@ static int vmci_guest_probe_device(struct pci_dev *=
pdev,
> 		vmci_dev->notification_bitmap =3D dma_alloc_coherent(
> 			&pdev->dev, PAGE_SIZE, &vmci_dev->notification_base,
> 			GFP_KERNEL);
> -		if (!vmci_dev->notification_bitmap) {
> +		if (!vmci_dev->notification_bitmap)
> 			dev_warn(&pdev->dev,
> 				 "Unable to allocate notification bitmap\n");
> -		} else {
> -			memset(vmci_dev->notification_bitmap, 0, PAGE_SIZE);
> +		else
> 			caps_in_use |=3D VMCI_CAPS_NOTIFICATIONS;
> -		}
> 	}
>=20
> 	if (mmio_base !=3D NULL) {
> --=20
> 2.32.0
>=20

Thanks!

Acked-by: Vishnu Dasa <vdasa@vmware.com>=
