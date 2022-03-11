Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995DB4D65C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiCKQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349896AbiCKQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:08:38 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C6AE51;
        Fri, 11 Mar 2022 08:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT6BadjqOYa16B7aT0UICLnPKS6Gb8KokTUZaxN2j2XpDiGKOq9UevT4dCiPKPTzUu3ZQtgFpiG6yQbewMnfGtys6tAeJPW4lDzLymM19zKDlwQIjjqsFmUsfr4d/8sjsSgnoY4RW82gmgGFwV++LIfEWCRMIUwQbqYOjLVDpaUdYVi1w0LpDFXegXXQRGi4ZqQDiBRiue9N1BLp4lZBsUJNxzV8tyDqu0dHoVlSnRf8frOwFf80K/2/Qo5nTaAIQrGL6FzQTMe2GMf4QgmWdRF0oET2GEme624eO/y9MThingXFj98z2n7fREr+nM9lWGVsa+9R+/2EcuJ6x7hZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNepBWjtxQKShMxNuZe1K4BB8Qi+PFLvUJoRAP+UZxI=;
 b=Vdxz4KR37uq6Pw4HVNcUZvrE4xEijorht8ueHC0P/leKPKR0Kj0EQvQOiSZCZB5bXma4BPY7FLKAq7mkvXC/MlvqI7JXi32t1eqoc9wISw6gk6Ht8BG5SB/bodn/exkUe6Om24xazxBVZ93u1PD0eJM956YYnIhIOEUTAN295CzzDYWa8qFmgCpRzwZgzRKX2bx1R8F9ylr6wayabxJIkL6Qt8W4XO6KO1DIxUVS3TCW1fZw60ooOq6K3gYIhscULpFpH/5WMnSh8ZyIWCWn29TfsQ9D612zxw7DlnQIL+NZWcpgkD3+QORi/pUT6D/57iDrznklDhepuHzGJ2w3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNepBWjtxQKShMxNuZe1K4BB8Qi+PFLvUJoRAP+UZxI=;
 b=FKkobPjmEisp1JtflO4HoTH6gjyJ7gaXtNBxhVy/oouvNmPnDZNNtbBCm7Ui2rGSZYeWW6bQX9/KK82wEK3dFWjrl/ZoOoiMK41LuKZpRietIUwS5Z8pn5GmMzSBcbpbWlqDtgECVL7XnoyLvz2jKGgNMxqcIIizJFV6u38oDiY=
Received: from PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5)
 by DB7PR04MB5241.eurprd04.prod.outlook.com (2603:10a6:10:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.30; Fri, 11 Mar
 2022 16:07:09 +0000
Received: from PAXPR04MB8799.eurprd04.prod.outlook.com
 ([fe80::d5e0:7bb6:f3f9:6068]) by PAXPR04MB8799.eurprd04.prod.outlook.com
 ([fe80::d5e0:7bb6:f3f9:6068%8]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 16:07:09 +0000
From:   Shijie Qin <shijie.qin@nxp.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     =?iso-8859-1?Q?Niklas_S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 12/38] media: platform: amphion: move config to
 its own file
Thread-Topic: [EXT] [PATCH v2 12/38] media: platform: amphion: move config to
 its own file
Thread-Index: AQHYNVGmrgBsl7k+XkK/GnI9tHTCMKy6WS0A
Date:   Fri, 11 Mar 2022 16:07:09 +0000
Message-ID: <PAXPR04MB8799D3526876EED3BECCDA299F0C9@PAXPR04MB8799.eurprd04.prod.outlook.com>
References: <cover.1647006877.git.mchehab@kernel.org>
 <3aa6e54b5f1e3c4ca8eb5a7c2284513f9b555bf5.1647006877.git.mchehab@kernel.org>
In-Reply-To: <3aa6e54b5f1e3c4ca8eb5a7c2284513f9b555bf5.1647006877.git.mchehab@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eb4d0b8-dc5d-45b9-257f-08da0379327a
x-ms-traffictypediagnostic: DB7PR04MB5241:EE_
x-microsoft-antispam-prvs: <DB7PR04MB5241A87BA3F86616524D67A39F0C9@DB7PR04MB5241.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0d6RFvycjttogYgHwPyp5I8gbUBtiV+zGWOKfRND0kc26wCwu1F/F6BGjjiMx+qAyNvAB0M8Su5/OzHCITmkU/Uc8mrBncsSmiFzUBwjfPCdjPLz5n/W1ABiS57PIjrv/SduD+3emdDSu7vhCStxXe2TG9ctjIPsTtYHjo2EZRRFA+4KhwJNFpW0Y27e47SszSSPZNc+lQi8zJq5+WO4uIGuhLMnvf0O/I3994syfPSzHSNvPV/T7asBIWdXnTlcakQHS8BhcYY499aIUdx2THCszHuJFBMivkOcUqHdKpcMjSNAIw7OaN5FtzeiAwCers32yM8H+TG+aLaYOGXdWGwVThk/3w4zXKCqZhKFUTgMMsYL5CQYdRh7t/HlQtNNt6mK5d8pN1xl2z3pl4R1fRY09YONEZdmmMapfQ8JJ4G8Zh7o24Qgy9kCuc+03Cb1CDVztvDRR2eXB9G9VVrMH+ugyCnTM5hdxvdWCHFgZWEUw7UZcJglp0SJG9erRVKM0Yjlb2RvHYk4LzbCC+jL12ICzbLi2zp9UkYJi0IqBDWtc5y+ziNxqqev/6w9Ud+N+KqNeLCAFPyvydB69b1zEcjU4nDYJuj3ifvqrmnhbPknJ9qcjR5dD/eCCBGJiogPhOFM+PCy0CFkdQzA16+OrcnVriHF4EbmZrNJyHYl812U7i2Ohu1Kzt2L+CYkzvNxQXm4tv7aAac6XD+q7GmYD20mxXyxSGthwVFUvK44TqcpfM64Jv6UhdQMt4sx72xC4LJvPYDY7rR575i7H57KhvCzE6cdC7/C8nuBgxakoIs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(44832011)(52536014)(8936002)(38070700005)(33656002)(8676002)(66556008)(66476007)(66446008)(5660300002)(64756008)(76116006)(66574015)(83380400001)(966005)(55016003)(122000001)(6506007)(7696005)(186003)(26005)(38100700002)(9686003)(71200400001)(498600001)(2906002)(4326008)(6916009)(54906003)(45080400002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5V8CGrRNO0GALKaMCx/+7TO+SifNVEy/Arjquc+vrJ/5A2SLu3GN8WWuNA?=
 =?iso-8859-1?Q?R//hToL9FiSyZ4n/JBI35dA7PhlqC4OfIew0dCtUdFG04395/kYEmkd+rF?=
 =?iso-8859-1?Q?DeBKhU+Vg7yq1PxfcwmXGN9wkeKqLRMulnN4fM38LsUP/d2q1Kv1Js3Oxh?=
 =?iso-8859-1?Q?/Ks6gJ1hvKGxTMa+L3mAo2KAP5jNlAQideV1ClXUlkkCq3IspA8eQPCyqQ?=
 =?iso-8859-1?Q?0OqjNDw66KnMKKI8+G06MkjQUpDHdQvclSGx/dgvOhYPkD5zKS/OCScKyB?=
 =?iso-8859-1?Q?HeyW4wfPxLY+cd4neAgdSAUfKmrUNm+P7N16B1nNkemU3m1s7PXR0IVIgE?=
 =?iso-8859-1?Q?gCnair3rLIfPuXzJe4fsfHGOjGPGcQnIsiGvweCOvRzYpU/aU26Jf3PaW6?=
 =?iso-8859-1?Q?afp0tCEDt80w5nIJuWAt/eiT1aLZNPV6XpkWmd8LR08gek5wIA6bNrwAdz?=
 =?iso-8859-1?Q?T4jKYna/pqo2usVjH8rkKIYdrz6Vy4Q+uAH22ry3wql2cNPYZNCpt6vdnr?=
 =?iso-8859-1?Q?hSRKxqtf/nnRVpH0vM4hpSKApAt87Rbj6P2rr2rnZx6bytzJjlQ+MosCIR?=
 =?iso-8859-1?Q?TwaW9J9pZWvg7mJVPcLkpzl00lSTn3NGavgurEkO72H++MgkSXieoPQqAP?=
 =?iso-8859-1?Q?Iu3eVFgj4x2YpNdGet+OggMzEk7HWcDHMweRYIejFYH6DLkBsZ/bq1AwMq?=
 =?iso-8859-1?Q?7OoyNIuS3NoL+McctVKS6TMqKtMMOUupkhG20pTg9DbaBnbXNdtskirM7k?=
 =?iso-8859-1?Q?Kqf7j/Sye/Ipu1jHRWbRsh9onCfRoMLfnJU6KkRgWhMenuLk7YBgd+Bucn?=
 =?iso-8859-1?Q?wDxtHpZDJJvQvSZcFVJu/PtpLCG5iSL9jDIzRZUzBOz47ay4nH0CsSWbBt?=
 =?iso-8859-1?Q?8fENF/AqzBxtz8//3Ek/mS7qBiYOblzv3jRJIDfWLnB5LYHmHxr/40+IWr?=
 =?iso-8859-1?Q?Gbg+glm8iVHwfQvlrjR495+Wr5/w/bazSgFpeJUpeGGG8gfXDYdWHhBeS9?=
 =?iso-8859-1?Q?oe0ipVMRbVmN5CgynlCgFhQworb/WnoX24K7zEvIlhz61cgM2k2V+pxX72?=
 =?iso-8859-1?Q?du9rieO2bh8ZeMAsEo4XL+T5jAuw9sXxVUC0UCRbmEj29YlmpdJ0IewTlv?=
 =?iso-8859-1?Q?/kNQWe+7Eo1m1byeuSwfG9iaada0npeZDa3MJeOJTdwSzitLmUHszdUYHF?=
 =?iso-8859-1?Q?YE2RfLsnVKp7ros/XUD3WDBsxjs2FgpE36sNtxT3gJIti1MW/qFSSBBRXq?=
 =?iso-8859-1?Q?P25PIk/V3UkcNInuH8MQ075A5bf9DWN1m6I5MyXnPQXO6RDXc8oN43oTVv?=
 =?iso-8859-1?Q?NKhtkCQzAskITrf3J8vIpDNZEMfpXpCCAoLYGYkJxTvsgI7O4tKR7v2xog?=
 =?iso-8859-1?Q?MMS+0sx326mza5SbYMsRU+eLk0BtzOO+po5a+1VctUWPJxFeKfMJCPIamC?=
 =?iso-8859-1?Q?M/N9mtlmct6PpcsITDO7z24RQCRpgjXE/UcN9kpP3jDM/yPPsN9zu+214u?=
 =?iso-8859-1?Q?GFQrmtL2sxPVBoomv+TpNGduOXIbSdEz1gtbILNQamDsx3NT4ueGFOWuPO?=
 =?iso-8859-1?Q?DMCat8ra/14TRTlMm7xIF3b+BOaTDezeRP0U825KZXpgbvimxHtz1XJbNO?=
 =?iso-8859-1?Q?lSWSX6i+9b8fjA5yIxeCoVXIYwZMsLRi7SVH+LRcmaVAR4Uvn3o+h+5A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb4d0b8-dc5d-45b9-257f-08da0379327a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 16:07:09.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NumBRrSiOI741C3V8WKCfiQwmhgQtQJwmjpcA9uj3HgWy0Qj6X6fEOrB+MHSQ6qC1tOVbs6Xq9L/6WOlWSPQhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mauro Carvalho Chehab <mchehab@kernel.org>
> Sent: Friday, March 11, 2022 10:07 PM
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>; Niklas S=F6derlund
> <niklas.soderlund+renesas@ragnatech.se>; Dmitry Osipenko
> <digetx@gmail.com>; Hans Verkuil <hverkuil-cisco@xs4all.nl>; Laurent
> Pinchart <laurent.pinchart@ideasonboard.com>; Ming Qian
> <ming.qian@nxp.com>; Shijie Qin <shijie.qin@nxp.com>; Eagle Zhou
> <eagle.zhou@nxp.com>; linux-kernel@vger.kernel.org; linux-
> media@vger.kernel.org
> Subject: [EXT] [PATCH v2 12/38] media: platform: amphion: move config to =
its
> own file
>=20
> Caution: EXT Email
>=20
> In order to better organize the platform/Kconfig, place amphion-specific
> config stuff on a separate Kconfig file.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
   Reviewed-by: Shijie Qin <shijie.qin@nxp.com>

> ---
>=20
> To avoid mailbombing on a large number of people, only mailing lists were
> C/C on the cover.
> See [PATCH v2 00/38] at:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fall%2Fcover.1647006877.git.mchehab%40kernel.org%2F&amp;d
> ata=3D04%7C01%7Cshijie.qin%40nxp.com%7C00b6f167648a4f003f8908da0368c
> 7c6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637826045803762
> 164%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DRHvKEtSj%2B9
> sffB4enxmXoP1FD3%2FQj0MPlDe2WjrjgLQ%3D&amp;reserved=3D0
>=20
>  drivers/media/platform/Kconfig         | 21 +--------------------
>  drivers/media/platform/amphion/Kconfig | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 20 deletions(-)  create mode 100644
> drivers/media/platform/amphion/Kconfig
>=20
> diff --git a/drivers/media/platform/Kconfig
> b/drivers/media/platform/Kconfig index e795a0862841..25cfda75e625
> 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -47,6 +47,7 @@ source "drivers/media/platform/marvell-ccic/Kconfig"
>=20
>  source "drivers/media/platform/via/Kconfig"
>=20
> +source "drivers/media/platform/amphion/Kconfig"
>  source "drivers/media/platform/cadence/Kconfig"
>=20
>  source "drivers/media/platform/davinci/Kconfig"
> @@ -535,26 +536,6 @@ config VIDEO_TEGRA_VDE
>            Support for the NVIDIA Tegra video decoder unit.
>            To compile this driver as a module choose m here.
>=20
> -config VIDEO_AMPHION_VPU
> -       tristate "Amphion VPU (Video Processing Unit) Codec IP"
> -       depends on V4L_MEM2MEM_DRIVERS
> -       depends on ARCH_MXC || COMPILE_TEST
> -       depends on MEDIA_SUPPORT
> -       depends on VIDEO_DEV
> -       depends on VIDEO_V4L2
> -       select MEDIA_CONTROLLER
> -       select V4L2_MEM2MEM_DEV
> -       select VIDEOBUF2_DMA_CONTIG
> -       select VIDEOBUF2_VMALLOC
> -       help
> -         Amphion VPU Codec IP contains two parts: Windsor and Malone.
> -         Windsor is encoder that supports H.264, and Malone is decoder
> -         that supports H.264, HEVC, and other video formats.
> -         This is a V4L2 driver for NXP MXC 8Q video accelerator hardware=
.
> -         It accelerates encoding and decoding operations on
> -         various NXP SoCs.
> -         To compile this driver as a module choose m here.
> -
>  # TI VIDEO PORT Helper Modules
>  # These will be selected by VPE and VIP  config VIDEO_TI_VPDMA diff --gi=
t
> a/drivers/media/platform/amphion/Kconfig
> b/drivers/media/platform/amphion/Kconfig
> new file mode 100644
> index 000000000000..13899649f766
> --- /dev/null
> +++ b/drivers/media/platform/amphion/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only config VIDEO_AMPHION_VPU
> +       tristate "Amphion VPU (Video Processing Unit) Codec IP"
> +       depends on V4L_MEM2MEM_DRIVERS
> +       depends on ARCH_MXC || COMPILE_TEST
> +       depends on MEDIA_SUPPORT
> +       depends on VIDEO_DEV
> +       depends on VIDEO_V4L2
> +       select MEDIA_CONTROLLER
> +       select V4L2_MEM2MEM_DEV
> +       select VIDEOBUF2_DMA_CONTIG
> +       select VIDEOBUF2_VMALLOC
> +       help
> +         Amphion VPU Codec IP contains two parts: Windsor and Malone.
> +         Windsor is encoder that supports H.264, and Malone is decoder
> +         that supports H.264, HEVC, and other video formats.
> +         This is a V4L2 driver for NXP MXC 8Q video accelerator hardware=
.
> +         It accelerates encoding and decoding operations on
> +         various NXP SoCs.
> +         To compile this driver as a module choose m here.
> --
> 2.35.1

