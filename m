Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7395D4C0F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiBWJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiBWJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:45:55 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B685965;
        Wed, 23 Feb 2022 01:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laTB15ATEmULGM6DglTgPq0wXJKpqP02yL3QI3uDokPIbN7vnPKy6d5/uKPSmeMenJ2cnsbS61OnYYS3UpSvBtvO5H+5x4pVWB6tSDwtY5F16l13gh3ikVivf03ziLc6RTsu+54b56XqWR+1wgx0Vd2D8DsF7gL8kYNu7gP7xG5zE1/uOXePgQfqv0/NUEdqI5iQe8MaBjbkTVb7ZS/OgCQ4IeaR1OV97tsR+BGCbRp/bJyXjgeUnM8nS93hgGvAiKEfcXlshs/5QXAF6Twn5Ld3utLS+nuPV0rEcClD5obB62GSq+9RR+DqvdqY3aE2J+5XVXPdjfXv6mx3oWVdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tccdQAovGyIwaLe0qI+BRy0CruijMajs/Z8kUG0k1Fw=;
 b=gUuXTXjvvFX9udo36DGGZTfBeyX1Q05pdWzCIbrbrxHNxK48leCoW0jGRxPubA9jQCVp5VgMsW+4nivFdJmHZOjg7ZzrD+peVOmqbNE+EGbW3uWzQQSGcbrV2WmisIpQpcczpnUXRhsZkrABiMqSjGMAM7hZpU3YqcgOeGkCtRLG4JtzeNJROlevbS3ZmgxMEA+4oTK+lHzO8drkckr65doxZhwDZOsD5f8oCnVlZcOUbecPoNJ02IegENJo3fyE3tpyZZPWtGbI2ERpZaPE3nqrYusbZdXO+DxDszZNGaRXB+ype6YVV7czwsMTf//Ael1BxVevSIu26M8ME2w8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tccdQAovGyIwaLe0qI+BRy0CruijMajs/Z8kUG0k1Fw=;
 b=o4nPFuewaf7lGDFYf/HEpy3OXLTvy0nNTEhzTSFKrgEkSSh0NSvC4oG41tagAmr1VU4IyWD2tkFCf9ZAkxOHPBvRpuyZuS1OFoX09eNXh4iTRvBwFIXm78hPTop6jADiQ9jr1EQSLpxN1moznJIDUp64KK3E0iNaw5L8hheTfcE=
Received: from PH0PR02MB7271.namprd02.prod.outlook.com (2603:10b6:510:1c::9)
 by DM6PR02MB6986.namprd02.prod.outlook.com (2603:10b6:5:22e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 09:45:25 +0000
Received: from PH0PR02MB7271.namprd02.prod.outlook.com
 ([fe80::609c:b5b8:1b64:307a]) by PH0PR02MB7271.namprd02.prod.outlook.com
 ([fe80::609c:b5b8:1b64:307a%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 09:45:25 +0000
From:   Harsha Harsha <harshah@xilinx.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>, git <git@xilinx.com>
Subject: RE: [PATCH V2 3/4] crypto: xilinx: Add Xilinx SHA3 driver
Thread-Topic: [PATCH V2 3/4] crypto: xilinx: Add Xilinx SHA3 driver
Thread-Index: AQHYJDKpbYlvNhvclkiZxu4lhrpFE6yfXfuAgAGDgRA=
Date:   Wed, 23 Feb 2022 09:45:24 +0000
Message-ID: <PH0PR02MB7271E7D12E4971513733A694DE3C9@PH0PR02MB7271.namprd02.prod.outlook.com>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
 <1645125264-11033-4-git-send-email-harsha.harsha@xilinx.com>
 <YhS0hY4c0p4rL8K/@Red>
In-Reply-To: <YhS0hY4c0p4rL8K/@Red>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96cff696-44c6-4d16-f015-08d9f6b1377e
x-ms-traffictypediagnostic: DM6PR02MB6986:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB69864ED77F054C49E98BE24BDE3C9@DM6PR02MB6986.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zYsgczQLPk+tZPdoXbccG8Ab8OvDBR0z8oekO3KZsN4bp0JHmeWDla79Nt+/sN8X8GZ7UmwgH7u0eL4FsKphUh124dDwmnF6hEcFnNd8CsQw6W21ZKC2uRAW8xHT4KLboNUWKZyX2f8Jx1MAGUZnFOXMQPzE1Yt9mFy6L30ODs4LF4zunmmrqKhOj3KuoJawKMQjvmrieaMVbCqUhQiPvE1xSLd4NGWJEW6lp3XV2Pd4GgOq6KgcQGCXIJ1E1zeoPDvIyPUhC4dVPUx1xmqJKaZeXYJzkZQtAKWvFPMLpeYOQ75p0KzUwTyFG18WMNrsIsx/BMM+s/kaPuEAAP868epaSqwIxHdhaDJIbimRG0L7pgZMzagTDFNcewKEGnMk1sLEbbXPtPZkrG/dco2YbBoKePwwA5cPQcY4p7ye0TloEZ7ozU5HCzcUhI01ioZBt78e3AQkwvoDTIiXtsS0RC5mZCLPHueH534WQWkv+9j7gEfclUu6uG1NdurX78Ht26gYg8KgPKcT2kqonl6t1e0gfw5NFSIK4NcbOthPGr5ExzdWIR7r0uWzp+8SzGZ2Mh2HzBcoxDoeEcm0dJL1BOulCfTzu64X/ibpxmij6OKl72mfBbtPoIJNd1NRwznINMFhlR9DOWUx8Z0GSb6yZrIdukUAs89quLgtGgRDnPe0AIU/BWZ9hcwpkf4UttoWcpYxjCSoxgtE2K+QAIEUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7271.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(76116006)(83380400001)(54906003)(55016003)(38070700005)(316002)(66574015)(6916009)(8676002)(66556008)(66446008)(107886003)(122000001)(52536014)(6506007)(66476007)(9686003)(2906002)(4326008)(71200400001)(64756008)(7696005)(53546011)(38100700002)(5660300002)(66946007)(8936002)(186003)(86362001)(26005)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4HXCSPmp8VY26mmurT2v5y6c4mCa1LfmM7y1YEh8y9Kc+MuQoXzpxqpoRg?=
 =?iso-8859-1?Q?/zdV01URq7qQ9AUGgqHHmGc4ojJrTY7cfYvWp6S4XDFdnV0XLb3F1HSWls?=
 =?iso-8859-1?Q?MzbwwKF1qg8mmGT8RWnWxkKjceH/dVUSoQea0MVHWBqJepi0aU54y91jgZ?=
 =?iso-8859-1?Q?oWjz9zCobMLnlKbzzyfP7g0B3TP398Lq+bDaFaSNlJfemnkprKs3P6/n/k?=
 =?iso-8859-1?Q?MqYziJqPLU1nHcNrqYIoToTrwYU3/smpm9yyTQ8nym0e4niql1VU0tesxg?=
 =?iso-8859-1?Q?DBHUAlbPbKqzxyM9hbBcWLQlRPI31qUkCocvPJgNg5Lmv8+42ytQEpy5Ku?=
 =?iso-8859-1?Q?hZahwnl1YMP8PrAhu/wvQoWDwZAY3bxGaVVoxLHBMU+T2x+hs/A5jxwjOa?=
 =?iso-8859-1?Q?H6wybt2u7Uz0miKkPnkIw1eXQmLwtPmMjhK5+w+YNBiZ27ctU3SN9EJ64j?=
 =?iso-8859-1?Q?+jJrYy6AsBqpvOU+sHQ3RnnC2/5Cm+u4R5ud0AlV9zHNFWjdTN5jECz6+J?=
 =?iso-8859-1?Q?vcum84yrxPsloElE3lwgHZ+f2wd6q/1F14YRfD72PaVZOJwpO2VJGcTsB7?=
 =?iso-8859-1?Q?I+bmNj8gPXGWfHvL8szQLjodor7AGHxNu4lDDcCRKrnAWEsIS9sFOWB7iY?=
 =?iso-8859-1?Q?+hzwNERiIGdf4sxMEK4Rk2Ech4n3Zzu2tW9h581NVPmBlEZLXR+WBagV/9?=
 =?iso-8859-1?Q?Wfw6oMsfRbvhAUbWTpLJyexRGgObCaf61Z/VK1FZQnb+KfsyTCnkPaLO94?=
 =?iso-8859-1?Q?ienGriRc84zoTGZd/rz3/OmxSDN/Z7WatmRc+wkVI3jz1GQrjlDsEKY6yZ?=
 =?iso-8859-1?Q?uadCll4mX39ydpNZnVS4UlCj7e47dhu4NuuxGcHIjUo/GRORrrVLJ4HBl+?=
 =?iso-8859-1?Q?tjEuBbBs+PqHxTZPRunx+5Qqg1gc1BNbLYjfEeICIPw921er1OlnwHXu4E?=
 =?iso-8859-1?Q?5G8k3GshhMdWmXneaYn8jMgPoWw8nEcR3bJ8vevsCLr7UUpfzurQ0P0poH?=
 =?iso-8859-1?Q?4H6p5b2ucw0GDCtmeEVghAMOl+hOqpZFPoUef0PXwgUvGe2iFOpSGowLnK?=
 =?iso-8859-1?Q?MG5zLYxxXyLq3HcbDfSdZyV44bPS6Mqd+uSACenYysgBdtuNV6PupNWtpP?=
 =?iso-8859-1?Q?S8TIzZ5XTiYQgsOAvvTTulpCh925SdIVGfRtn82cseXH7fo0gEI9kNPo3D?=
 =?iso-8859-1?Q?e77Zf/AdH7E+rKDslI7p+Jko8BhcPF12B6e9GOGJGfqEDVtqxSkKqyc5D3?=
 =?iso-8859-1?Q?5qe8rZQUc704+sfcaFA5JLQUkZdtccKTSwoqRYFOzil+Ctr4MJ8ON/9uXQ?=
 =?iso-8859-1?Q?wSWXH9fxAB95uoxGQuO1hnNBMfC+5YFXy4QbyJxIm6s4OvZ0GTPgZE/Gmn?=
 =?iso-8859-1?Q?9hD0/iq3Du40U5/b7j+CejrsvqnQp12zD5gHTolpg6qk+g3abzXhjc1IY6?=
 =?iso-8859-1?Q?WJ4lPtrzNBITMaUXssilRVps228YJEiwOyWfTdvcvjIGPT++0qwe4dHEoJ?=
 =?iso-8859-1?Q?kwxLOQcuGCTN1xEWJR+6R+xJFf2hddqe4n+l7fuhQnwII+yz1Ku9TfaYwj?=
 =?iso-8859-1?Q?2piISdN2DcbUalV6T7aH+vqJdc46NBwOleF9BBQvdADOkamPqgzgrecEcd?=
 =?iso-8859-1?Q?6noUvKV1i4tlhimSfpMRhD+uIL2lhZyIqSZAacbm//JFUx6Oe2aS33O/mq?=
 =?iso-8859-1?Q?39qD7KKUYAI3sbmUEI4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7271.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cff696-44c6-4d16-f015-08d9f6b1377e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 09:45:24.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZ5nMgo836yhBxkisdtWeVd5gcnbG8V3DsrTtovxW5FaQ4zoK3cg0sAJupE8DDrMvTTouyegIok+cmsL9/Hf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6986
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> Sent: Tuesday, February 22, 2022 3:32 PM
> To: Harsha Harsha <harshah@xilinx.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-crypto@vger.k=
ernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Michal Simek <michals@xilinx.com>; Sarat Chan=
d Savitala <saratcha@xilinx.com>; Harsh Jain
> <harshj@xilinx.com>; git <git@xilinx.com>
> Subject: Re: [PATCH V2 3/4] crypto: xilinx: Add Xilinx SHA3 driver
>=20
> Le Fri, Feb 18, 2022 at 12:44:23AM +0530, Harsha a =E9crit :
> > This patch adds SHA3 driver support for the Xilinx ZynqMP SoC.
> > Xilinx ZynqMP SoC has SHA3 engine used for secure hash calculation.
> > The flow is
> > SHA3 request from Userspace -> SHA3 driver-> ZynqMp driver-> Firmware -=
>
> > SHA3 HW Engine
> >
> > SHA3 HW engine in Xilinx ZynqMP SoC, does not support parallel processi=
ng
> > of 2 hash requests.
> > Therefore, software fallback is being used for init, update, final,
> > export and import in the ZynqMP SHA driver
> > For digest, the calculation of SHA3 hash is done by the hardened
> > SHA3 accelerator in Xilinx ZynqMP SoC.
> >
> > Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> > ---
> >  drivers/crypto/Kconfig             |  10 ++
> >  drivers/crypto/xilinx/Makefile     |   1 +
> >  drivers/crypto/xilinx/zynqmp-sha.c | 285 +++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 296 insertions(+)
> >  create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c
> >
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index 4f70567..bf4e55e 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -808,6 +808,16 @@ config CRYPTO_DEV_ZYNQMP_AES
> >  	  accelerator. Select this if you want to use the ZynqMP module
> >  	  for AES algorithms.
> >
> > +config CRYPTO_DEV_ZYNQMP_SHA3
> > +	bool "Support for Xilinx ZynqMP SHA3 hardware accelerator"
> > +	depends on ARCH_ZYNQMP
> > +	select CRYPTO_SHA3
> > +	help
> > +	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
> > +	  This driver interfaces with SHA3 hardware engine.
> > +	  Select this if you want to use the ZynqMP module
> > +	  for SHA3 hash computation.
> > +
> >  source "drivers/crypto/chelsio/Kconfig"
> >
> >  source "drivers/crypto/virtio/Kconfig"
> > diff --git a/drivers/crypto/xilinx/Makefile b/drivers/crypto/xilinx/Mak=
efile
> > index 534e32d..730feff 100644
> > --- a/drivers/crypto/xilinx/Makefile
> > +++ b/drivers/crypto/xilinx/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) +=3D zynqmp-aes-gcm.o
> > +obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_SHA3) +=3D zynqmp-sha.o
> > diff --git a/drivers/crypto/xilinx/zynqmp-sha.c b/drivers/crypto/xilinx=
/zynqmp-sha.c
> > new file mode 100644
> > index 0000000..1eaca97
> > --- /dev/null
> > +++ b/drivers/crypto/xilinx/zynqmp-sha.c
> > @@ -0,0 +1,285 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx ZynqMP SHA Driver.
> > + * Copyright (c) 2022 Xilinx Inc.
> > + */
> > +#include <linux/cacheflush.h>
> > +#include <crypto/hash.h>
> > +#include <crypto/internal/hash.h>
> > +#include <crypto/sha3.h>
> > +#include <linux/crypto.h>
> > +#include <linux/device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define ZYNQMP_DMA_BIT_MASK		32U
> > +#define ZYNQMP_DMA_ALLOC_FIXED_SIZE	0x1000U
> > +
> > +enum zynqmp_sha_op {
> > +	ZYNQMP_SHA3_INIT =3D 1,
> > +	ZYNQMP_SHA3_UPDATE =3D 2,
> > +	ZYNQMP_SHA3_FINAL =3D 4,
> > +};
> > +
> > +struct zynqmp_sha_drv_ctx {
> > +	struct shash_alg sha3_384;
> > +	struct device *dev;
> > +};
> > +
> > +struct zynqmp_sha_tfm_ctx {
> > +	struct device *dev;
> > +	struct crypto_shash *fbk_tfm;
> > +};
> > +
> > +struct zynqmp_sha_desc_ctx {
> > +	struct shash_desc fbk_req;
> > +};
> > +
> > +static dma_addr_t update_dma_addr, final_dma_addr;
> > +static char *ubuf, *fbuf;
> > +
> > +static int zynqmp_sha_init_tfm(struct crypto_shash *hash)
> > +{
> > +	const char *fallback_driver_name =3D crypto_shash_alg_name(hash);
> > +	struct zynqmp_sha_tfm_ctx *tfm_ctx =3D crypto_shash_ctx(hash);
> > +	struct shash_alg *alg =3D crypto_shash_alg(hash);
> > +	struct crypto_shash *fallback_tfm;
> > +	struct zynqmp_sha_drv_ctx *drv_ctx;
> > +
> > +	drv_ctx =3D container_of(alg, struct zynqmp_sha_drv_ctx, sha3_384);
> > +	tfm_ctx->dev =3D drv_ctx->dev;
> > +
> > +	/* Allocate a fallback and abort if it failed. */
> > +	fallback_tfm =3D crypto_alloc_shash(fallback_driver_name, 0,
> > +					  CRYPTO_ALG_NEED_FALLBACK);
> > +	if (IS_ERR(fallback_tfm))
> > +		return PTR_ERR(fallback_tfm);
> > +
> > +	tfm_ctx->fbk_tfm =3D fallback_tfm;
> > +	hash->descsize +=3D crypto_shash_descsize(tfm_ctx->fbk_tfm);
> > +
> > +	return 0;
> > +}
> > +
> > +static void zynqmp_sha_exit_tfm(struct crypto_shash *hash)
> > +{
> > +	struct zynqmp_sha_tfm_ctx *tfm_ctx =3D crypto_shash_ctx(hash);
> > +
> > +	if (tfm_ctx->fbk_tfm) {
> > +		crypto_free_shash(tfm_ctx->fbk_tfm);
> > +		tfm_ctx->fbk_tfm =3D NULL;
> > +	}
> > +
> > +	memzero_explicit(tfm_ctx, sizeof(struct zynqmp_sha_tfm_ctx));
> > +}
> > +
> > +static int zynqmp_sha_init(struct shash_desc *desc)
> > +{
> > +	struct zynqmp_sha_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > +	struct zynqmp_sha_tfm_ctx *tctx =3D crypto_shash_ctx(desc->tfm);
> > +
> > +	dctx->fbk_req.tfm =3D tctx->fbk_tfm;
> > +	return crypto_shash_init(&dctx->fbk_req);
> > +}
> > +
> > +static int zynqmp_sha_update(struct shash_desc *desc, const u8 *data, =
unsigned int length)
> > +{
> > +	struct zynqmp_sha_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > +
> > +	return crypto_shash_update(&dctx->fbk_req, data, length);
> > +}
> > +
> > +static int zynqmp_sha_final(struct shash_desc *desc, u8 *out)
> > +{
> > +	struct zynqmp_sha_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > +
> > +	return crypto_shash_final(&dctx->fbk_req, out);
> > +}
> > +
> > +static int zynqmp_sha_finup(struct shash_desc *desc, const u8 *data, u=
nsigned int length, u8 *out)
> > +{
> > +	struct zynqmp_sha_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > +
> > +	return crypto_shash_finup(&dctx->fbk_req, data, length, out);
> > +}
> > +
> > +static int zynqmp_sha_import(struct shash_desc *desc, const void *in)
> > +{
> > +	struct zynqmp_sha_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > +	struct zynqmp_sha_tfm_ctx *tctx =3D crypto_shash_ctx(desc->tfm);
> > +
> > +	dctx->fbk_req.tfm =3D tctx->fbk_tfm;
> > +	return crypto_shash_import(&dctx->fbk_req, in);
> > +}
> > +
> > +static int zynqmp_sha_export(struct shash_desc *desc, void *out)
> > +{
> > +	struct zynqmp_sha_desc_ctx *dctx =3D shash_desc_ctx(desc);
> > +
> > +	return crypto_shash_export(&dctx->fbk_req, out);
> > +}
> > +
> > +static int zynqmp_sha_digest(struct shash_desc *desc, const u8 *data, =
unsigned int len, u8 *out)
> > +{
> > +	unsigned int remaining_len =3D len;
> > +	int update_size;
> > +	int ret;
> > +
> > +	ret =3D zynqmp_pm_sha_hash(0, 0, ZYNQMP_SHA3_INIT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	while (remaining_len !=3D 0) {
> > +		memset(ubuf, 0, ZYNQMP_DMA_ALLOC_FIXED_SIZE);
> > +		if (remaining_len >=3D ZYNQMP_DMA_ALLOC_FIXED_SIZE) {
> > +			update_size =3D ZYNQMP_DMA_ALLOC_FIXED_SIZE;
> > +			remaining_len -=3D ZYNQMP_DMA_ALLOC_FIXED_SIZE;
> > +		} else {
> > +			update_size =3D remaining_len;
> > +			remaining_len =3D 0;
> > +		}
> > +		memcpy(ubuf, data, update_size);
> > +		flush_icache_range((unsigned long)ubuf, (unsigned long)ubuf + update=
_size);
>=20
> Hello
>=20
> Why do you copy all data before processing and not use them in-place ?

The firmware expects a DMA capable memory in the lower-32 bit address space=
. This is the reason we cannot use the data in-place.
ubuf is a pointer to the allocated region (in the processor's virtual
address space) returned by dma_alloc_coherent(). The driver copies the data=
 in ubuf and
passes the associated dma handle to the firmware. This is the reason we can=
not use the data in-place.

>=20
>=20
> > +		ret =3D zynqmp_pm_sha_hash(update_dma_addr, update_size, ZYNQMP_SHA3=
_UPDATE);
> > +		if (ret)
> > +			return ret;
> > +
> > +		data +=3D update_size;
> > +	}
> > +
> > +	ret =3D zynqmp_pm_sha_hash(final_dma_addr, SHA3_384_DIGEST_SIZE, ZYNQ=
MP_SHA3_FINAL);
> > +	memcpy(out, fbuf, SHA3_384_DIGEST_SIZE);
> > +	memset(fbuf, 0, SHA3_384_DIGEST_SIZE);
>=20
> You should use memzero_explicit()

I will fix this in next version of patch.

>=20
> Regards

Regards,
Harsha
