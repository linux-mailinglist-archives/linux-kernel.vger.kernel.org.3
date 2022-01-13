Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D040748D2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiAMHXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:23:11 -0500
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:26049
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230368AbiAMHXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:23:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKStwwy8+pHdVFsQoseQUG8hirf8FZ5zwS/0Ol96gaOa+t4JLszM4CDWslg2RHT2ALbk/6TyPzAN1C7pHpwmILOpMadm8mUFUtsoYc6ZgRIIQ27sdAnD3nheSbN8YleCf8y+/Mn1u4ftxm1wx9v8b0XO0eyD7zOzqf/ykju++diumyYKRVeHmcHNJNlzYzX16M8s0U3IDQNQnkTNLTnvQWuPTUqTyU9ikvO48VsXP+cSE6YFi0d+lQZYzf24h67TXxFOu7Ko9u+co0jjvu6Sjs3X+aVqtgAi8tTHyHxqK5AgKxDbIgiRpSt6Z//kMB/wqGDGbULi2Sov1vJx4ogW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRUWw8yircKK+07Jr1tG7ttNu9RmAG70LIcfXw7WGp8=;
 b=c6UWnYoeyRpqhBXKv1nvVuqhKpdhU+2mAW2kQcbXgZGYH4AckMIDIct6x05tMMLiR4opgiG8eZ9FuatytlnVygo4TsTnDEd/3UChg8bYkF1zAMeKoWOcsyTJZnleh/DUf+PyZaPSYgwcESyu1j/sIZ/xjNxeXg9Th+EranALc6XqIOhnkdQBhOTF2RA/6ylUJxYpW0UFwqhUEy23y6sdf6RAFFLw7lFCS9u/p2kT53pomdWxuvAS9LRxDfy6w7DAn5etNuXWV7z9rc8Ovk3LB0uYweTgiKozKgFjW0eyU1NVzOMBJg2X5kxXV67fjKtRO4/vUdq73u9FE3BnOEsZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRUWw8yircKK+07Jr1tG7ttNu9RmAG70LIcfXw7WGp8=;
 b=h42OFmt2XHJLmjmUYLBF35YIwtl1VdjsP/gSRumcM9gSw8q/0EZvsK7MnNdKyRRjUhZlbcQOd0FqzMohPG1ucouimeOOvmfmDEqg7JhPlStSzEte9QZ8BhosJt1UhuOrwgovCaFSHY+REcQ0EkpKctKYWOLK7mdgxlfIOf5X5sA=
Received: from VI1PR04MB5342.eurprd04.prod.outlook.com (2603:10a6:803:46::16)
 by DB7PR04MB4345.eurprd04.prod.outlook.com (2603:10a6:5:25::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 07:23:04 +0000
Received: from VI1PR04MB5342.eurprd04.prod.outlook.com
 ([fe80::ceb:f79:2700:ba2a]) by VI1PR04MB5342.eurprd04.prod.outlook.com
 ([fe80::ceb:f79:2700:ba2a%3]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 07:23:04 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "\"Herbert Xu\"" <herbert@gondor.apana.org.au>,
        =?iso-8859-2?Q?=22Michal_Vok=E1=E8=22?= <michal.vokac@ysoft.com>
CC:     "\"David S. Miller\"" <davem@davemloft.net>,
        "\"Petr Benes\"" <petr.benes@ysoft.com>,
        "petrben@gmail.com" <petrben@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robert.hancock@calian.com" <robert.hancock@calian.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW RNG
 failure
Thread-Topic: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW
 RNG failure
Thread-Index: AQHX19neHowqaTNf00Kheozf5e35Yqxg5qfggAAANIA=
Date:   Thu, 13 Jan 2022 07:23:04 +0000
Message-ID: <VI1PR04MB5342237C91A2ADF239B05711E7539@VI1PR04MB5342.eurprd04.prod.outlook.com>
References: <ea3906acc2c8d6fb56eacd94b9531c18fa7cb4dc.camel@calian.com>
 <20211112152705.90513-1-michal.vokac@ysoft.com>
 <DU2PR04MB863088F218774551FA254EB795539@DU2PR04MB8630.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB863088F218774551FA254EB795539@DU2PR04MB8630.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1c144b9-d25a-4ddc-2a0b-08d9d6658a26
x-ms-traffictypediagnostic: DB7PR04MB4345:EE_
x-microsoft-antispam-prvs: <DB7PR04MB43454E10BA9BCBB0421AF581E7539@DB7PR04MB4345.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAl2DJdFUTSI6kXfHeIPk5vfxiKsnvH6GoTePvRDbjzxruJeFpzFmUXApmJbdSPx22xRd9QNeT0LVZnNEF7kuugNLK5rb0lh5OiTaxGIolRnXxtFb0UYbXhoO1dJBRZmHBrxGMuxZfeb+RuFALz4LzH1p3Dq8H2ZHUY0pTxUJJSOKOyUtXIs/VdLpw21cuy1mX1+cqWCKCA5AEZnZNwVi9XjRWztZ0bYIiymSayvtfy3zyvFaOcdV1vw5idw7R8eS8akgb+2QoHNiPD2Oq6ZPS9jz3N3+1Z/OZIZ5/6UI5iqVf6+iNBVrf8QFR1cApBbZAfj5EwxcDBsbUAWOF9Zxei9ZUxfIqE9hgy8artf1Cd2lJDWLxM29FjRmfBe8yIAj36lG5cQtMwH2sifYCgiEmmgpWkEY7ytxmOCP+UrN3bMiDfT79dMTzWFBU7H/0Ht7TWW7SEApWOByfE8IOWrLhjl0OJm6fbpoOVN4XWVMxWgAxkLjGUzV0gn6MEBfyCdya8jhcLxULomoboFRdvvl8Vr/ecVA++2kP4zu7RPGf9eS6foNUNYILds556FJpwpKCSlRsKZNdbn+pOvJldtT4h+Hl4Mx+z7vM4f9ugju3E2lbwdGfl+6ThxyBf76B2IV2quLr0+fl4m5Wz4AWSVrROq75ER1U1dpkYt3lCzCfOeEgUoCdLmT15yKBLE9oGH1xqk3K5wFh6LjmdLR2ajUmTSE9I/gRBuukNfE6L0/okLFaj5/ZZM5ywcSc3dapK/7eB+qaFy9NOX64NjzDCjsIUE9nLO83VR/B9EdSIniXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(54906003)(52536014)(8676002)(7696005)(110136005)(64756008)(186003)(66446008)(83380400001)(66556008)(2906002)(5660300002)(38070700005)(8936002)(76116006)(33656002)(66946007)(966005)(45080400002)(71200400001)(55016003)(508600001)(66476007)(86362001)(9686003)(122000001)(316002)(55236004)(26005)(4326008)(6506007)(38100700002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?c76tuF1It9T95CK+gIEs/r2zCTjH6HFWqnc+a1P26h8rE+7v0IUKK3LbZi?=
 =?iso-8859-2?Q?HM7lKnWUDhGpp3+k/c2SdxSoDccHNWmHGkRmiAyitZWc4FlVr4qhZsk3iF?=
 =?iso-8859-2?Q?PBvkAieETCCCny4kDNLIvNAN8BFC8nYXt66Cljq3opUDUXeH+/P4CRma4V?=
 =?iso-8859-2?Q?sz9nHQgg4MYiQCY3/x+UH8CVf0vlc1+mIFitP5ShYU5qbJoz3gmMTxHWnh?=
 =?iso-8859-2?Q?mBSNhWs1bk7z4JV0P7ldAd3/AyPdBeXRirTWSlsCu907O3obYvTSV9sAri?=
 =?iso-8859-2?Q?vt9aPmSPiNrE/qN+F1CWFMTVzZnf0boNmH9M4ZdIsSP5gdhw/bhRH0bnXI?=
 =?iso-8859-2?Q?qwlZVksKs8gttbXXx56hoWa56rQwB0cu7g00QQKQTo3A2QZo3zo5yYbv8X?=
 =?iso-8859-2?Q?g+z4NFMjwUKeGG5tv9Jl61Hjhoz96XWCY6boDMGVGdvKuT2kCg1IwlSVKO?=
 =?iso-8859-2?Q?geRN+de1Ih5+CANz0l5OKGAFbDjg6yYkNJ3P1qnpslqmXGbQECm64ehZdE?=
 =?iso-8859-2?Q?FFaSUW6mIsauM3OJvM3Tw1ucxX9MNj9Wyq1DGB55G2qqVjXUh0RIGRjDcl?=
 =?iso-8859-2?Q?960pVjRkKBRLtyLLJzEnoZgiRiUQwJLysLz4yAB2LBRAHj3MpuvXxpafVt?=
 =?iso-8859-2?Q?6bBgILg8cMnxX4y2eYVWgkJlw26o8I+/B9hPAzMZHXvBya48g6n6HGfoKu?=
 =?iso-8859-2?Q?m+usFIa8M9QrXHOVtIPGYUwdUtbF+KLpaRevsouptEOZ5EGNhcrCMoygio?=
 =?iso-8859-2?Q?dgn6iyGkJrOjFPB/Y9KMVVLs5TXl5N4pDIRFPLttfUXZRHZ+AccrXnk7CG?=
 =?iso-8859-2?Q?q+JbIiGRlmJGtfQgUc9gXITUQ8lxKBOEOUX5wWyfdEm6tDPtYIii25Ipql?=
 =?iso-8859-2?Q?MK85Um7/0v9KbguyL1o01yX1pjscFdVmxGZus3xAjawCcvyHnAmbR3YktI?=
 =?iso-8859-2?Q?guYxIdsgCtXUmDcfbuu+gx/R2sTfqRhcD0eLHp82xPt1F5HN8yKZbDX5ma?=
 =?iso-8859-2?Q?pN3rOtG6rkzT6M/Bq2ieJVQQKlHyftlFvALUBZJDSudDlSqUM4Owtc5ynA?=
 =?iso-8859-2?Q?XHzQja5gS8ZCQKJqOU71/Fj7yIJ6oN9uTAdhZwBX0zUIulu9bbvaEKOaKQ?=
 =?iso-8859-2?Q?jUgRVLbPnSfyZL3TPCgZ+mfhJn2/UJSCDS1hj8Ju9qBMPue4hfJObZP9p7?=
 =?iso-8859-2?Q?3BnEIEWSKmykqN9unB4zlObQXkgN7RK75aaNED5/oov4IIlMP1trrIQ938?=
 =?iso-8859-2?Q?ucXVCdi0Tw4Qxg995aJH7HQfO8qd+BdHZHxVBrlHN7z96pZPf6JMDsE0S3?=
 =?iso-8859-2?Q?Sovq3zNu1eHNy60h12n9R6xs4HGmtHc1SDGA0b9KAEcMW1+Z5uYoxGyAXG?=
 =?iso-8859-2?Q?eT1BI1BysMR2TWsMWhK5sxmIgECyt1hXDVUZ7xjdzUrtopzRRJlpDw3f94?=
 =?iso-8859-2?Q?qgnA/uOpHoW4jnC5SjkwM+0HfIzFYz9aNiwthlHTdCSs2KvtyuSRVO7zGI?=
 =?iso-8859-2?Q?2bU9EPWH/X0WWfkO5GA/Kr4uMPGF3peTxtNu8gB01E571pRyk6coafqizr?=
 =?iso-8859-2?Q?JWe2DIt18ajZ58tRJNZBQ7cOH2hchue/XnQ9DkPNYpxIhBXk+5LscDLDoY?=
 =?iso-8859-2?Q?YCLFsUOjMGPfi/wadk/F66qALqD9qtOWJA7t1Bkmazkaulm5dR+rU4cosH?=
 =?iso-8859-2?Q?XZm35FcUMNU7+uYtMNE=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c144b9-d25a-4ddc-2a0b-08d9d6658a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 07:23:04.4152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73VIBbYaYbBcOdbqn6rvCF1x7zB0uXMFGNCWHK7xCAgbzxwosA4m75tKuf068JcEyf58cB5plHVvWO672VsWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal
=20
>=20
> -----Original Message-----
> From: Michal Vok=E1=E8 <michal.vokac@ysoft.com>
> Sent: Friday, November 12, 2021 8:57 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>; linux-crypto@vger.kernel.org;
> linux-kernel@vger.kernel.org; l.stach@pengutronix.de;
> robert.hancock@calian.com; Petr Benes <petr.benes@ysoft.com>;
> petrben@gmail.com; Michal Vok=E1=E8 <michal.vokac@ysoft.com>
> Subject: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW RN=
G
> failure
>=20
> Caution: EXT Email
>=20
> From: Petr Benes <petr.benes@ysoft.com>
>=20
> Each time TRNG generates entropy, statistical tests are run.
> If they fail, RETRY_COUNT value is decremented. Once it reaches 0, HW RNG
> returns an error, and needs to be reset.

The least-significant 16 bits of the RTSTATUS register reflect the result o=
f each of statistical tests.
Can you dump RTSTATUS to see which test has failed? Please dump RTMCTL as w=
ell.

Have you tried to build this patch for armv8? For me it is failing.

Regards
Gaurav Jain

> RETRY_COUNT could be programmed in RTSCMISC register and is set to 1 by
> default. Hence, we are left without hwrng after the first error, which co=
uld
> happen even under normal conditions.
>=20
> Cc: petrben@gmail.com
> Signed-off-by: Petr Benes <petr.benes@ysoft.com>
> Signed-off-by: Michal Vok=E1=E8 <michal.vokac@ysoft.com>
> ---
> Hi,
> we are also experiencing this issue:
>=20
> caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
>=20
> It is happening on both i.MX6S and i.MX6DL SoCs we use.
> On Solo I can reproduce it really fast. Sometimes it happens right after =
the board
> is NFS booted, sometimes I need to stress the HWRNG for a while (generate=
 few
> hundred KBs of random data). On some DualLite SoCs it is happening at lea=
st
> once a day.
>=20
> We are using the v5.10 LTS branch but I can confirm that this is happenin=
g on all
> kernels since v5.7 to the latest linux-next.
>=20
> We also tried to increase the RTSDCTL_ENT_DLY_MIN delay as suggested in t=
his
> thread [1]. It helped and the issue never occurred since then but we are =
looking
> for more universal and permanent solution suitable for upstream, hence we
> came up with this patch.
>=20
> Any comments will be appreciated.
> Thanks, Michal
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.=
org
> %2Flkml%2F2021%2F8%2F30%2F296&amp;data=3D04%7C01%7Cpankaj.gupta%40
> nxp.com%7C5d6bf460b260415aeda008d9a5f0ffab%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C637723276775699794%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C1000&amp;sdata=3DVxN9MqDFbISptW3OX9XTtZ%2FwQTsEbF6dETxXB%2
> BHrywg%3D&amp;reserved=3D0
>=20
>  drivers/crypto/caam/caamrng.c | 42 ++++++++++++++++++++++++++++++++---
>  drivers/crypto/caam/ctrl.c    | 13 +++++++++++
>  drivers/crypto/caam/ctrl.h    |  2 ++
>  3 files changed, 54 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.=
c
> index 77d048dfe5d0..2be5584ae591 100644
> --- a/drivers/crypto/caam/caamrng.c
> +++ b/drivers/crypto/caam/caamrng.c
> @@ -21,6 +21,7 @@
>  #include "desc_constr.h"
>  #include "jr.h"
>  #include "error.h"
> +#include "ctrl.h"
>=20
>  #define CAAM_RNG_MAX_FIFO_STORE_SIZE   16
>=20
> @@ -113,6 +114,35 @@ static int caam_rng_read_one(struct device *jrdev,
>         return err ?: (ret ?: len);
>  }
>=20
> +static void caam_rng_retry_reset(struct caam_rng_ctx *context) {
> +       struct device *ctrldev =3D context->ctrldev;
> +       struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(ctrldev);
> +       struct caam_ctrl __iomem *ctrl;
> +       struct rng4tst __iomem *r4tst;
> +       u32 __iomem *rtstatus;
> +       u32 retry_count;
> +
> +       ctrl =3D (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
> +       r4tst =3D &ctrl->r4tst[0];
> +
> +       /*
> +        * There is unfortunately no member for RTSTATUS register in
> +        * struct rng4tst and the structure doesn't look stable
> +        */
> +       rtstatus =3D (u32 *)((char *)&ctrl->r4tst[0] + 0x3C);
> +       retry_count =3D (rd_reg32(rtstatus) >> 16) & 0xf;
> +       dev_dbg(ctrldev, "CAAM RNG retry count %d\n", retry_count);
> +       if (retry_count =3D=3D 0) {
> +               dev_err(ctrldev, "CAAM RNG resetting retry count to 1\n")=
;
> +               clrsetbits_32(&r4tst->rtmctl, 0, RTMCTL_PRGM | RTMCTL_ACC=
);
> +               wr_reg32(&r4tst->rtscmisc, (rd_reg32(&r4tst->rtscmisc) & =
0x7f) | (1 <<
> 16));
> +               clrsetbits_32(&r4tst->rtmctl, RTMCTL_PRGM | RTMCTL_ACC,
> +                               RTMCTL_SAMP_MODE_RAW_ES_SC);
> +               caam_reinstantiate_rng(ctrldev);
> +       }
> +}
> +
>  static void caam_rng_fill_async(struct caam_rng_ctx *ctx)  {
>         struct scatterlist sg[1];
> @@ -129,8 +159,10 @@ static void caam_rng_fill_async(struct caam_rng_ctx
> *ctx)
>                                 sg[0].length,
>                                 ctx->desc_async,
>                                 &done);
> -       if (len < 0)
> +       if (len < 0) {
> +               caam_rng_retry_reset(ctx);
>                 return;
> +       }
>=20
>         kfifo_dma_in_finish(&ctx->fifo, len);  } @@ -145,13 +177,17 @@ st=
atic void
> caam_rng_worker(struct work_struct *work)  static int caam_read(struct hw=
rng
> *rng, void *dst, size_t max, bool wait)  {
>         struct caam_rng_ctx *ctx =3D to_caam_rng_ctx(rng);
> -       int out;
> +       int out, ret;
>=20
>         if (wait) {
>                 struct completion done;
>=20
> -               return caam_rng_read_one(ctx->jrdev, dst, max,
> +               ret =3D caam_rng_read_one(ctx->jrdev, dst, max,
>                                          ctx->desc_sync, &done);
> +               if (ret < 0)
> +                       caam_rng_retry_reset(ctx);
> +
> +               return ret;
>         }
>=20
>         out =3D kfifo_out(&ctx->fifo, dst, max); diff --git a/drivers/cry=
pto/caam/ctrl.c
> b/drivers/crypto/caam/ctrl.c index ca0361b2dbb0..e421f8d1982b 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -339,6 +339,19 @@ static int instantiate_rng(struct device *ctrldev, i=
nt
> state_handle_mask,
>         return devm_add_action_or_reset(ctrldev, devm_deinstantiate_rng,
> ctrldev);  }
>=20
> +/*
> + * caam_reinstantiate_rng - reinstantiates RNG. Intended for a case when=
 RNG
> falls into
> + *                         HW error condition. That happens if TRNG fail=
s statistical
> + *                         check and RTY_CNT value set in RTSCMISC decre=
ments to zero.
> + *                         It is exported to caamrng.c
> + * @ctrldev - pointer to device
> + */
> +
> +int caam_reinstantiate_rng(struct device *ctrldev) {
> +       return instantiate_rng(ctrldev, 0, 0); }
> +
>  /*
>   * kick_trng - sets the various parameters for enabling the initializati=
on
>   *            of the RNG4 block in CAAM
> diff --git a/drivers/crypto/caam/ctrl.h b/drivers/crypto/caam/ctrl.h inde=
x
> f3ecd67922a7..26ff5a49a865 100644
> --- a/drivers/crypto/caam/ctrl.h
> +++ b/drivers/crypto/caam/ctrl.h
> @@ -8,6 +8,8 @@
>  #ifndef CTRL_H
>  #define CTRL_H
>=20
> +int caam_reinstantiate_rng(struct device *ctrldev);
> +
>  /* Prototypes for backend-level services exposed to APIs */  extern bool
> caam_dpaa2;
>=20
> --
> 2.25.1

