Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005F7535B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbiE0IPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbiE0IPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:15:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97A102746;
        Fri, 27 May 2022 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653639338; x=1685175338;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NPssZIB5ojpggYpD06lY2w2A02C2ejWhyudIE9kNBu4=;
  b=Cich6SO0DFFGUt0pFeYfEObCR/fIpTTntEyzz+isx+z67PBmNrgiuC8A
   PKExM97HFq6ntG8SwZiv8uhIP7v44aa01jZOTdNfyMzoR8Cjn0CR6ZL9Q
   jI06DxKKghhmEW3gHtfVCDlko4fFWLPhsM4zX1tbvMRwz4sb2PdvMkmQ8
   OAiDXv0hhYuoWq3Sb8QGaQlywpm3f31xhufRAsPxyxP/DT1u41Tm18o3l
   lV1vY/aDazNEl8C9c++88pjoD1jFmMSKRJs3W2zJBLE+YmCQ8gfnXMFSk
   Rgst5SnJ6qxUQA3u9kYQV/k8gs3VHw8KFFPgiMBaJ9fttkvjCyfOjIyV8
   g==;
X-IronPort-AV: E=Sophos;i="5.91,254,1647273600"; 
   d="scan'208";a="313603610"
Received: from mail-dm3nam07lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2022 16:15:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHI9rowCir15d9FlgmtPm9D5V2KIkxRIt0DYuEm0cs21I9eG5v8FkQj8syKs4psytuioHWzAZEaTn4TaHMEIH8UhV/yHuj/SegV/HWCfltszD6Y/TtY+eKcQ+/43gbQip28Qm0erQ4IpWGpp+f7bgq8k5w/iYIMpxy8G/iAuHvIB23peFdWHoIjhQbmoiUp67Hw7QZFzZGK64yA4iSPDFZ6IFW3e6RrFDPfEF3GBxB53SVU+YbL/lGCBJAsC0CecVVRQEX3uijnUNh5zNILwBIs0HlbskaNye9kG/QCvNfCjKsaeGfzlcU8TacIZId2GL7rCYAMDH8Ntj7Sax6rpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBR/vcVNvVvZtZk8Tgb2Uat+NdIygWOIlqRXE301BUE=;
 b=R6qKnlq9wHeGWjFZ4kg57VXJIJhLEWsn+rf/LZXBAAgTP7KQx3/U8H9KvgSOUqQj8pF4DTSdalqVkHmaqxwpaAA7+5bURoqmLazyYaai5TSysx4kdlUINM758CFv/IjXFu3ErJ28uY7YcAWXyMKQ9ZjGNo0LtFM4Lo2dyfZj1uWElzQtXCJgNhMXmxyNtpKJA9x+OUUX6yo8IboGTbYk/EpUmCw+k3jHqwXCjQEiv8ieEb8RwxhRK4akNgjnc1FbYPMow77H4xGw1VLVfuGhLS0tfqrd+khVTawvNxbTqyioMHuMO23xPocGqRQMocNgUP1J+sA2FQig+JgPBqODOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBR/vcVNvVvZtZk8Tgb2Uat+NdIygWOIlqRXE301BUE=;
 b=N2nUUiOIiO0CS4HOopdFFphHUwQ9hOKb2Q49jnWpWPjFRRZt/qjJGEtAw41PUbsxbwTom7Q4Z45DYPe8OcJ186udCBeJCGDEqG3R/bz4dRSGJ/xwkT6oiN5nfDYXS+WAZcP/5oZSmorzGTtHAFg20sPtBFDv9RkIqcVdvo150ME=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN3PR04MB2132.namprd04.prod.outlook.com (2a01:111:e400:7bbe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 27 May
 2022 08:15:35 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb%3]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 08:15:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     keliu <liuke94@huawei.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Directly use ida_free()
Thread-Topic: [PATCH] mmc: core: Directly use ida_free()
Thread-Index: AQHYcZwBkciviCI3ZkSt/FTDUwEPYK0yYFQA
Date:   Fri, 27 May 2022 08:15:35 +0000
Message-ID: <DM6PR04MB65755DE8388D88867BEA23E1FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220527075428.2475782-1-liuke94@huawei.com>
In-Reply-To: <20220527075428.2475782-1-liuke94@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 375f2f41-5748-4157-0160-08da3fb91352
x-ms-traffictypediagnostic: BN3PR04MB2132:EE_
x-microsoft-antispam-prvs: <BN3PR04MB2132C17B1E46EB8EE2AF0B23FCD89@BN3PR04MB2132.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDaqK8CwLmJaps2bwoXyJ4M2nvjD/rzjLJ+xLeBCafDvYnlB5Bt6JzZ2hkaX3kvog6nRcbW2XWrDyZIkR9eRK5ZYiepdUZH/ntq0up2W1bgKj3qxXcY7d5aWQQCiT7+vIW2VMb9sf+n6KB+SVdw+JfYXkNQuoXpCwxQLnqiGoZlxYiy9H1XTSYj57G1gaoRAtga5U0B3Uy35tvu6sTVP6MViHxzU4+RY4O6JjpkDpNhdWDL75zH5RKRQoPkaUTCCUuclDyhBmyzU5xAVz8uEBDUGAaWUMx6pYLlcoQvOtiS5NR5nXnwySHdjbnxv6VSTjUx2xze3S/9EZalsTvljhxBG5Zem3IUwQo7xeH8j3NXj3fZWI7CUNwmLUeyJvC74vBNL66fp/aSyCtQ39SkrTXTwNKtBhMRC4eDNFJJ70rn3HA83WkAiGQLEZsr5AAH9UjO/7be4mFmRpHdObpb/TeAqpMbui5XtHezS1eB/Keuce5lSZ9uVLl5/uyRuWq01OM1KdDbWIBrk8nzjMCUGySYtMu7t9v6NEEaeBmzuq9FiGNBip+rDeqdE3AMCuzj6wlcsPrXgdnUpuzZJMJ3ULHPhuRqrBi0f17ST53ttGT1Ste1zBJzEyO68ji0/1H+1fQPh8Z4BQAsGOnPQdTVOWO9iPOsSoccMD+6LYNTaHLkqZIva9glxdAMJ2mNSWVbJnx5FCSRZm7CmFNSrBqxB1HwQSbDRuh2/gKqenjsRO08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(508600001)(55016003)(38100700002)(52536014)(5660300002)(9686003)(26005)(86362001)(8936002)(7696005)(2906002)(6506007)(33656002)(186003)(64756008)(66556008)(83380400001)(66476007)(66946007)(66446008)(8676002)(71200400001)(76116006)(316002)(110136005)(82960400001)(122000001)(921005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nPzBl16hu2VLZXjcYaqPj7sKhDGjEorXPfsk/qTFlY/RIqTdbA4D9oVr4UtR?=
 =?us-ascii?Q?6RpcOrJulvCgcyIvwfyGMc2oThEqSEy2JKc2x4KNCyFWztb/B5CcmGPPl0PZ?=
 =?us-ascii?Q?Nw1+RhDlwnal0Irwbq5Bk1bg8Yuhv+95bE1HTT3rwk3gTeGJFahXeS7IU0qu?=
 =?us-ascii?Q?hTcjtE7lm6q/A4TLejfrDR5hmuxDrAsgF9jggn35lEvxLYDcTQkJP/gBLBeM?=
 =?us-ascii?Q?08cIzZExhcnYLcP/t7RLo6vk39Pz61EsN/Qw/30GGap8BpnXQneHHQey2wB1?=
 =?us-ascii?Q?wgEr3gHj2+J1A/2ShxOOFkT9eu9bbOQMG52yQqqoYfeqqN0OLFZTRStQy8JP?=
 =?us-ascii?Q?d/PKLnTPNaE7Vqjs4YvRo6i0256wfmyUJLbiI990mpN6ytmLqy/AvVgQ30Kw?=
 =?us-ascii?Q?RmnWWhN3dN6Z1V8t6jc+iBLis6U67hsRaxX5GcBaAYgurIc0TrhWGPMQSCxR?=
 =?us-ascii?Q?1HiO07bPK1eCZD1PlSmtlufqpfg+m2N5rA5Im4cyMwlOFgbnBm2MaBq6bT13?=
 =?us-ascii?Q?4GHIqNLM3wrUSgMTqfx57QSvGinpZOwRy5GUE7S6fKqqq2QxmFG7UrW+/64Y?=
 =?us-ascii?Q?66fflbQS/WYZ0plACy6HjHB3QYdWeH8hgWaXJkT6PriByZmsa+v4WRz/V5F0?=
 =?us-ascii?Q?k+Akvb9sYEx0sulr4C8ZsAPc/l8Q0X3C8qA4xglkNVpT1C4h5/T1+x+Abe5n?=
 =?us-ascii?Q?B/s3tJhsOu4pLRJtXKV7jxbMnxen9tTjgllSqKXRR0Syie12gLhwPsf7Dbk+?=
 =?us-ascii?Q?HH0NbiDmbvWGof2/1NOsKXCuOfiW8rTPtA2XXZQo8QoS7e/GROUFH6ewfF/B?=
 =?us-ascii?Q?sH2PaUUNnS5Jdl4kuFrlZuT5iLwAj9u7fLG0j5tjNkDIK4vKzzO9zlXAJF+a?=
 =?us-ascii?Q?9fcgnaYI8Y+I6xLHOQjnutBzPUmcTJFOmy11yZJ9I/r6SMdo5FEWoBpM6JRV?=
 =?us-ascii?Q?sFQoMpgwRt+UEt8FkoykemUXwlOEnRzFHGrvpd2Sr7jci4OtMg3fMrEoCcDp?=
 =?us-ascii?Q?ZCLX4M5gnBlWC6ItWPd2k8k8O9Y62XaguTRt3bpR2FITrPauRo+BRsKcP6jZ?=
 =?us-ascii?Q?VNljeGU5+Vg7DypaDhDcuqvCTGXYeaVp5eS8amqhg3Nmn3qQmAoBm1li7ju4?=
 =?us-ascii?Q?rtUbkNbn94MnZMvYDoGAkApzk8ESg+Q8m6N+oTeT7f2d3tpXz03FS7DMZrlT?=
 =?us-ascii?Q?1nw4/40jqyzUalil3PxDWbq6olOtUr1PkmioDr3+++W1R9fd8atPdeug0/Wl?=
 =?us-ascii?Q?lwgQEOP7GOfU1Bag+rsoJEkq1MvaEoqq6mhDeIl63oshwibZDk+GU2NK61ww?=
 =?us-ascii?Q?CW6ueE3nMKAORgyTThT6G5wRnh/OzAZxqC8Upu5a9e9v2Hq0zuVQZXoV+LUK?=
 =?us-ascii?Q?9+Rm8q9v77VtSoWKusdqZnMn4YqZVWNuIzdy3K9gNUxhEhI0tQgxNhgNMWmM?=
 =?us-ascii?Q?pxGDPrzLDm+x0eFlVXY6/w7RIrjGFSEszSgYbRHHFM44fYXgYSHzbOtsNwNs?=
 =?us-ascii?Q?vS1tvWCye6xDtWrqi95DunweyISN6mztELxpxTjep2DBvENPwyzPQwkn+xOf?=
 =?us-ascii?Q?SGHUn0C8vuHMBUwfA3pKYrtLJtrzEBWpixS9UFx4urPB4FrXzca3VaihxFdY?=
 =?us-ascii?Q?SXT88VN1FX9gz2QffRKnVOl9ZWJGmOCVJFoFI5FVE090LZoO7QHrNyNZrIHy?=
 =?us-ascii?Q?ymL0vtUdgBWuXvC4ntFl/nxA4nfYTGN75kh8zyUGMORLQ6bUQcRjD0NcqE1k?=
 =?us-ascii?Q?Ez4NTjus5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375f2f41-5748-4157-0160-08da3fb91352
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 08:15:35.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nj7QbDzUGD5a+CRKkaJOuU6fUYp8X9BccCsombDH9S6bnVLGGcBMuLSeA4MqfJN7RruBQ8uur2kiOmyaDGaJRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2132
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Use ida_free() instead of deprecated
> ida_simple_remove() .
>=20
> Signed-off-by: keliu <liuke94@huawei.com>
Need to replace the corresponding ida_simple_get by ida_alloc.

Thanks,
Avri

> ---
>  drivers/mmc/core/block.c | 8 ++++----
>  drivers/mmc/core/host.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 506dc900f5c7..c8d702db483d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -204,7 +204,7 @@ static void mmc_blk_kref_release(struct kref *ref)
>         int devidx;
>=20
>         devidx =3D mmc_get_devidx(md->disk);
> -       ida_simple_remove(&mmc_blk_ida, devidx);
> +       ida_free(&mmc_blk_ida, devidx);
>=20
>         mutex_lock(&open_lock);
>         md->disk->private_data =3D NULL;
> @@ -2495,7 +2495,7 @@ static struct mmc_blk_data
> *mmc_blk_alloc_req(struct mmc_card *card,
>   err_kfree:
>         kfree(md);
>   out:
> -       ida_simple_remove(&mmc_blk_ida, devidx);
> +       ida_free(&mmc_blk_ida, devidx);
>         return ERR_PTR(ret);
>  }
>=20
> @@ -2621,7 +2621,7 @@ static void mmc_blk_rpmb_device_release(struct
> device *dev)  {
>         struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
>=20
> -       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> +       ida_free(&mmc_rpmb_ida, rpmb->id);
>         kfree(rpmb);
>  }
>=20
> @@ -2643,7 +2643,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card
> *card,
>=20
>         rpmb =3D kzalloc(sizeof(*rpmb), GFP_KERNEL);
>         if (!rpmb) {
> -               ida_simple_remove(&mmc_rpmb_ida, devidx);
> +               ida_free(&mmc_rpmb_ida, devidx);
>                 return -ENOMEM;
>         }
>=20
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> 2ed2b4d5e5a5..9332e82e175a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -76,7 +76,7 @@ static void mmc_host_classdev_release(struct device
> *dev)
>         struct mmc_host *host =3D cls_dev_to_mmc_host(dev);
>         wakeup_source_unregister(host->ws);
>         if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
> -               ida_simple_remove(&mmc_host_ida, host->index);
> +               ida_free(&mmc_host_ida, host->index);
>         kfree(host);
>  }
>=20
> --
> 2.25.1

