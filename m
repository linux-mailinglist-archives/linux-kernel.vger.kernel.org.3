Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB33538C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbiEaIM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbiEaIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:12:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69884880DC;
        Tue, 31 May 2022 01:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTDpU6ZqdPvpoJwTv/l9jEVB0FtV41FAf4wqzz9iN0ZG7pXgZDwp+rGt9zRrka6MhaGXeKWWuc5WTt1+53hDavoPreIvsJG7AuVp2naaUX9FGauqKIpP/f94PweYKcVg2/1FZsgv1sGvz0sta29N53IzH8oIP140ykNxSIQrfwIHIUnVVhs9IUHA4xsxsPN2ATg345W6qGbekMz4TkkcZOvYY7uWJrHfO1mJWumEpoUXmWoRryq5PWmoFknvjkBXqZahH6wBenhpjaeTPzn2zV1tKs3D+q8TYLLlqno6CJbjsIjN7HHYCqav1ScnFhSIJoOEPjvDGm08e++zSCiPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCpwI53FdLaP8LZmMJ8VA+lmBJf1lVkuh0Wx6T9qYjI=;
 b=BteDxRV/+5BYQOA3Wk+2dMssy8rE91tfsu3/Nq3448tBVUMPCa2XpqmfKhWuSs5wyu7Bw+DjKUXZtQlup0EhLD3MZq67E3S1W5jkFnA5+dP6APUTqQ5MD48ZXEQPjeeRhZKh68j580dq09XPT0gBI4edTRWBxUbrWmrhUYRGmbNn9NrHIGkEdqBJYmi9Z2EvsdgtnDt4nkewN0QiPwZ0ZmiJGGtqO53olkXq4wzugbCptXdelTT0FQwMnjb8jdmqT5uYqd7CFz3d6BIFMlfM/+9nSj/18ml0sJ1rWKJqIotSOZa49Dq+qLmf1AXBlxua3N0m/nKV5qHZHuKl/C+xKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCpwI53FdLaP8LZmMJ8VA+lmBJf1lVkuh0Wx6T9qYjI=;
 b=Ogf3qJHJE8jMYxLpF6uzCLSkI9j64AAcJNdlpHhcsPtr9tFXnb1ZYz+LKAVhqbiON63DHiv83hC269gpWtTLPCSpVay8kBpfLs2a4Zj2id4rXrz42ACODjOOt5JIniIVW4Fu1ewXH5o+dVLtlml/01oHuDNJv9V1D07keyIinXY=
Received: from PH0PR02MB7189.namprd02.prod.outlook.com (2603:10b6:510:1f::8)
 by SN6PR02MB5696.namprd02.prod.outlook.com (2603:10b6:805:e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 08:12:52 +0000
Received: from PH0PR02MB7189.namprd02.prod.outlook.com
 ([fe80::816b:40ab:480e:624f]) by PH0PR02MB7189.namprd02.prod.outlook.com
 ([fe80::816b:40ab:480e:624f%6]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 08:12:52 +0000
From:   Sai Krishna Potthuri <lakshmis@xilinx.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>
Subject: RE: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Thread-Topic: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Thread-Index: AQHYSNyT5AQVGFEfc0CeWm5NB0lZxazhsf2AgFc3IxA=
Date:   Tue, 31 May 2022 08:12:52 +0000
Message-ID: <PH0PR02MB7189C07E60A93426764C688EBDDC9@PH0PR02MB7189.namprd02.prod.outlook.com>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <20220405191757.3rzc6q477reusywp@ti.com>
In-Reply-To: <20220405191757.3rzc6q477reusywp@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95d32d50-c6e8-47ce-8b23-08da42dd5be7
x-ms-traffictypediagnostic: SN6PR02MB5696:EE_
x-microsoft-antispam-prvs: <SN6PR02MB5696283F484A93AD5B2E9AA7BDDC9@SN6PR02MB5696.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gk/KQTHrWHs783WrtuhkzB3SK40/PVUF5cuwn9z72zGVbqyHg0eeIGXgu8k3/xblxT6/ra4imAyDvmjfh6XFDJZDhfp6yeNNMPXLrdgWtW+EEmhMyxD8/5Tzhg8tpJb628y2qkP1XES0R8KZ5b6TUt+LuC5rcr3MICUb9c14W6puQoVCylUrptAhNjHwR41M/X/VyRHsISjDufaGfqqDqPTaeAzCxrJCJXrDc4kf4pWyUaWXsbm771ekBni4v5SeO4xgo42xoxN9oEzfK4z/EGVR1kdA2cBbGJf7TAILtMOCSTOhNYmmFF7W+EARMdG16RViBnKeRnT5PsdnYhYS6IddVthxW83Y+gC0emvqSgeTh6Nx7+r+xJIrFOtFohrZBuWRQ9wUzW041gXSvQEuO0P1KRKjhZqdn6/jaSgyHC9QrtWmsObijF2tGz2rGhyzT85IG0KUnA/kqwHOkD0JlLXjmfRnLlDyQOwO+4wSnB3jrmmOmzOhgZdDD6GlBC0PhsEYKD1LxR4bzCZvXwfTARuhx9dYOJKpQU/T+T8pEp+XooMDKXMixXCubJ4kLFjXrEA7PdM3ksXK6gKcSDMGd5c9pLiKrdVxK7sl8PPRVK7aaEZbTioqLBnbEgMmzSx2FJz16ZUISg8ShM79XbD5V18IcV1LmrxD4hU4hJABa45Sq6qhxksP1XFmFXT9UMnfknMXuWDkrKByDNyUmkMxmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7189.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(86362001)(71200400001)(122000001)(107886003)(64756008)(76116006)(55016003)(5660300002)(66556008)(66946007)(66476007)(66446008)(4326008)(52536014)(83380400001)(8936002)(7696005)(8676002)(33656002)(2906002)(54906003)(38070700005)(6916009)(316002)(9686003)(6506007)(26005)(53546011)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Xc9rRAh8tt9mvKbz5bMQOQeYtaZfXZOH0inL2Zb5qfYCG/SYQGcjBDYniF7?=
 =?us-ascii?Q?Y5I8m0Xa1gRtE758W2fp2Il9tZ8AyMb1Yd6NBH8ybx38mbeiFx4ECVtLUiqY?=
 =?us-ascii?Q?agSTPnEzPkUS29hLMdP5JU6gn0tMRWgkpeoU93zmG0LR6aMoPvgn88cW9bHO?=
 =?us-ascii?Q?TvwTOmUVGZgAyFDADr7IisjDqNUoCpf42FwaEdp3aZphXna2FuDAS8z0PDIF?=
 =?us-ascii?Q?JkNjt5yoOSiWRYk9UY5l48I2LDzmzwVeA4qbUjkNk2tE7UFkekzRZqbMyGwF?=
 =?us-ascii?Q?SxZUZ7Q7h1k8qtMO6Wa4sXckk2acHFazKMzmmLeFCu0blCLV+i8FIHItvMkL?=
 =?us-ascii?Q?7CcgZ8gkWfOGGwpFznKu6vc6stlSdJOkFCmKBfvuNWhJ1ys1D6PXvYtrIMZz?=
 =?us-ascii?Q?G52DpZ37uQ4h91/cOFvmJe3DeAHrx7JyseNWVVtvHOrn36Lbf/rd/DS3vwJh?=
 =?us-ascii?Q?hTWk7qfW54vdPZM23u3gAqG/Wss7sE4rqQl1/gh73nyf6/p4f/3WGbKbjnai?=
 =?us-ascii?Q?CMSEt5RCoGBgVsIm8qqwjIA4puNqGPK46CMDsS2iECYZQgqLeNGpe4V4P8eI?=
 =?us-ascii?Q?czmyZEScK1I7cfhAoiaGvxCpY+BADKhC9l8C+CrCaW661yXnIQkXShqA/ty+?=
 =?us-ascii?Q?gkPog4QPPKoSaqhG27Ujc4wKGSHQz/MZ/xkmE9PlmVfcb22HjnlDX1n1elFf?=
 =?us-ascii?Q?d/hZ/Y7m6woMg3RqFN4QXFmFtudOhSFHrp7rpEve8u56xcB2tdNUctt73K6Z?=
 =?us-ascii?Q?gKWvYBxX93gkbwM7t1axM2kYaTsluoHrhtyoIsZxeHxSUwtxFD0pVC+5s0zg?=
 =?us-ascii?Q?Vx1UMZcHaEIiZtF5xAbZxE++BCwms68Z8FeKZ+HFdbWjLI2+BMaTDdkQNNqc?=
 =?us-ascii?Q?y0eompQRw0jUgSgtnxfaJ1xbIEPTEHKjSPU94ApdfF4jBG8MyyZtRuC+g5qZ?=
 =?us-ascii?Q?d9RsbcagsMy+Z+negEMUt0AGdKxRIAhtNsnNJzwb7kepcCc4/eHrCtApSzp4?=
 =?us-ascii?Q?WviF5F0W8k5drqfOnQHkp5ZlhrjOx14ZZkGMwwz+ZYaCi96hHvcuEm4fKIwY?=
 =?us-ascii?Q?1g25MZARoADMIj6GOnWo2buBsTX/c5n3UqexqC9HN+nO1EEqgTIEeY0hudZ7?=
 =?us-ascii?Q?MGVKwMDlZ3oVUM/15HEK/3auI+M12WKol66dhwECzm8T9YAHCzru/oGox3TB?=
 =?us-ascii?Q?Jlltq+AW9XZkNotJFC1avtN5ky5dqZTGlwIudH0U9E7k4EW59ZMRO5+iIXGB?=
 =?us-ascii?Q?Y/DWuDCD3I9YuQJAL3YzvlQXzJWPNneKITx5PvxSJ2+gS6W1Yi2YFtnmensR?=
 =?us-ascii?Q?uuBxTrpRIWcxh3wWbcros1tyK6Ne9k3FSRkSIZdYISelh7QinQMfnLZMGpHi?=
 =?us-ascii?Q?NIfX8zSpXmW43TU9MUHRY5hU5LHeSrB5qMOPj8/kaNnmxN6aQphNJShguTDK?=
 =?us-ascii?Q?Owuu1EuKA2xjYLNDygkX3TaR4LsjB+oDInIZk+6s/qJLul2O5JS2tAEiQ+rv?=
 =?us-ascii?Q?nBT8DXMQErpmKYavbE9LQkefvm91kyN8pydTfK+LTJQn6/g9RTVE4dP7rblY?=
 =?us-ascii?Q?tHjl7hhF/v6VrFglrEmj7AvbvsSMGODmjL4/bcv3BrnWDM9/7hMsDfwvjLD+?=
 =?us-ascii?Q?d4MTmXIz/le/1it0KjpIjvWPBBvj5fQVbxpfaghI+4pbBfvug94TeEdcaNOk?=
 =?us-ascii?Q?2+9a5naRZuzHueSCTzGAAzSTvx11VgCI/8ReQf9X+XhUAScNjHSKLu3pbU31?=
 =?us-ascii?Q?jOY2oXobSA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d32d50-c6e8-47ce-8b23-08da42dd5be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 08:12:52.2984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5BM2vH6jaERCV8CPY/3jHrIx/cP+/qAFYfcBAB5N/h5fOtrx5QTstnD3a4iRMnTrRmzZTqUnFJMG+S1V8d9Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5696
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

> -----Original Message-----
> From: Pratyush Yadav <p.yadav@ti.com>
> Sent: Wednesday, April 6, 2022 12:48 AM
> To: Sai Krishna Potthuri <lakshmis@xilinx.com>
> Cc: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> spi@vger.kernel.org; Michal Simek <michals@xilinx.com>; git
> <git@xilinx.com>; saikrishna12468@gmail.com; Srinivas Goud
> <sgoud@xilinx.com>
> Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI devic=
e
> reset
>=20
> On 05/04/22 04:30PM, Sai Krishna Potthuri wrote:
> > Cadence OSPI controller always start in SDR mode and it doesn't know
> > the current mode of the flash device (SDR or DDR). This creates issue
> > during Cadence OSPI driver probe if OSPI flash device is in DDR mode.
> > This patch add OSPI flash device reset using HW reset pin for Xilinx
> > Versal platform, this will make sure both Controller and Flash device
> > are in same mode (SDR).
>=20
> Is this supposed to reset the OSPI flash or the controller? If you are re=
setting
> it in the flash then you should handle this from the flash driver, not fr=
om
> here.
I am handling OSPI flash reset here. Agree, controlling or issuing the flas=
h reset=20
should be from the flash driver and not from the controller driver but hand=
ling
the reset might depends on the platform and should be in the controller dri=
ver.=20
One platform might be handling the reset through GPIO and others might hand=
le=20
it differently via some system level control registers or even controller r=
egisters.
To support this platform specific implementation i am thinking to provide a
"hw_reset" hook in the spi_controller_mem_ops structure and this will be
accessed or called from spi-nor if  "broken-flash-reset" property is not se=
t.
Whichever controller driver registers for hw_reset hook, they can have thei=
r own
implementation to reset the flash device based on the platform.
Do you think this approach works? Please suggest.

Code snippet like below.

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 2ba044d0d5e5..b8240dfb246d 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -285,6 +285,7 @@ struct spi_controller_mem_ops {
                           unsigned long initial_delay_us,
                           unsigned long polling_rate_us,
                           unsigned long timeout_ms);
+       int (*hw_reset)(struct spi_mem *mem);

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e8de4f5017cd..9ac2c2c30443 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -598,6 +598,27 @@ static void devm_spi_mem_dirmap_release(struct device =
*dev, void *res)
        spi_mem_dirmap_destroy(desc);
 }
+int spi_mem_hw_reset(struct spi_mem *mem)
+{
+       struct spi_controller *ctlr =3D mem->spi->controller;
+
+       if (ctlr->mem_ops && ctlr->mem_ops->hw_reset)
+               return ctlr->mem_ops->hw_reset(mem);
+
+       return 0;
+}
+EXPORT_SYMBOL_GPL(spi_mem_hw_reset);

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b4f141ad9c9c..2c09c733bb8b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2966,6 +2962,7 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 int spi_nor_scan(struct spi_nor *nor, const char *name,
                 const struct spi_nor_hwcaps *hwcaps)
 {
+       struct device_node *np =3D spi_nor_get_flash_node(nor);
        const struct flash_info *info;
        struct device *dev =3D nor->dev;
        struct mtd_info *mtd =3D &nor->mtd;
@@ -2995,6 +2992,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
        if (!nor->bouncebuf)
                return -ENOMEM;
=20
+       if (of_property_read_bool(np, "broken-flash-reset")) {
+               nor->flags |=3D SNOR_F_BROKEN_RESET;
+       } else {
+               ret =3D spi_mem_hw_reset(nor->spimem);
+               if (ret)
+                       return ret;
+       }

Regards
Sai Krishna
>=20
> Also, as of now at least, SPI NOR only works when the flash is in SDR mod=
e.
> For TI platforms, we reset the flash in the bootloader (U-Boot), before
> handing control off to the kernel. If you do want to properly handle flas=
hes
> that are handed to the kernel in DDR mode, I would suggest you update SPI
> NOR instead to detect the flash mode and work from there. This would also
> allow us to support flashes that boot in DDR mode, so would still be in D=
DR
> mode even after a reset.
>=20
> > Xilinx Versal platform has a dedicated pin used for OSPI device reset.
> > As part of the reset sequence, configure the pin to enable hysteresis
> > and set the direction of the pin to output before toggling the pin.
> > Provided the required delay ranges while toggling the pin to meet the
> > most of the OSPI flash devices reset pulse width, reset recovery and
> > CS high to reset high timings.
> >
> > Signed-off-by: Sai Krishna Potthuri
> > <lakshmi.sai.krishna.potthuri@xilinx.com>
> [...]
>=20
> --
> Regards,
> Pratyush Yadav
> Texas Instruments Inc.
