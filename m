Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148F3490A01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiAQOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiAQOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:08:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208B7C061574;
        Mon, 17 Jan 2022 06:08:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 8so10977256pgc.10;
        Mon, 17 Jan 2022 06:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dsWne6XhzeiNUQuLtOj24ikmXAkKtj7DWWvw/Hba8Es=;
        b=Kn0vJ7tUQV/YA9F7lAcqmNcvXX8fs57MAJsAQ7L3hnWBzuUFBHaKqjghrONPPSc3FA
         OhguTCXUPaDdiSK5oYVPmPPuCZGHJOnDqJspA6V/Ti1XMHg2Zt4TenX3EsjmibaWkfil
         /brXelQ9dsn2BM+oeSxOC4lgfwqff/7tVChc7MBAyZaENj4NW2ZVmV2NQFUtJB0baZN/
         Qrs2kvUOAatIz3LhVp2dTud22Bi2bLZ7pmWsLsaNrbwcqS7PeaLH1Y9v6ghhwKiRgTge
         R6RuY3Mh/VxKXJsaatPvjuLzJOQLYv1frs0EjKFI6OJJVhRxFHlOUg3jZ6k+Tp6qJJK5
         UMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dsWne6XhzeiNUQuLtOj24ikmXAkKtj7DWWvw/Hba8Es=;
        b=yJZa0yq+sKmcILPVuOQG7tZtBzmEb40UAe6T6ZMZQuYUITxOKlGxmdZIyoTzNMukA0
         HwCcIc6202mSuo5JaU6Ne9RQ2MSOBijMzXtbu+lwpY23JzCBUIdElvvJ3FD5dIEAGQQL
         fZ+NypZlril70mPmrWlPh1A7vYdWpxzBzp6SYCpOgEhoiBO92qdLg5wKEnyCtQatW4hT
         wehqyRzf5AUoNcR1xZ7r2BVuD/VITkv1n3gQNuKzok9P5THLgsA2TWRUgDmZHkt4YeRZ
         94tNLKp3Vn3hb81V2DwWqV9tzdS86ZHZtaNXodcY9suQmvAInmPZjszbP87oilF7D7pW
         fhJA==
X-Gm-Message-State: AOAM530CAATb8vreUtdJ7MgAcgGQBL52BcFt4y9LexGu/EmsdLDn6Kby
        /pKHcJ27TY0tvmUl8hCNpn0kAsOwqIV+XeWqMbU=
X-Google-Smtp-Source: ABdhPJzLmHViSf0ciOdxtgnx93fpS1MX/WXfQvOyzhWRFmTIkY1YbZ3LAigMQ0gSY64z9L1DltZclJd8dlwRmvHOhwI=
X-Received: by 2002:a05:6a00:8c5:b0:4bc:4c7e:7742 with SMTP id
 s5-20020a056a0008c500b004bc4c7e7742mr21186380pfu.18.1642428532325; Mon, 17
 Jan 2022 06:08:52 -0800 (PST)
MIME-Version: 1.0
References: <ea3906acc2c8d6fb56eacd94b9531c18fa7cb4dc.camel@calian.com>
 <20211112152705.90513-1-michal.vokac@ysoft.com> <DU2PR04MB863088F218774551FA254EB795539@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <VI1PR04MB5342237C91A2ADF239B05711E7539@VI1PR04MB5342.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5342237C91A2ADF239B05711E7539@VI1PR04MB5342.eurprd04.prod.outlook.com>
From:   Petr Benes <petrben@gmail.com>
Date:   Mon, 17 Jan 2022 15:08:41 +0100
Message-ID: <CAPwXO5aPNLSWiOgUCh7D_MwgeE8+4LO6Q6U1yVjTT9GukCCzDw@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW RNG failure
To:     Gaurav Jain <gaurav.jain@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Benes <petr.benes@ysoft.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robert.hancock@calian.com" <robert.hancock@calian.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaurav,

I've resumed work on this issue. I hope I'll get RTSTATUS and RTMCTL
soon. Meanwhile, what is the problem with armv8? I'll try some build
for armv8, but it will take time.

Regards,
Petr

On Thu, 13 Jan 2022 at 08:23, Gaurav Jain <gaurav.jain@nxp.com> wrote:
>
> Hello Michal
>
> >
> > -----Original Message-----
> > From: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> > Sent: Friday, November 12, 2021 8:57 PM
> > To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> > <pankaj.gupta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>; linux-crypto@vger.kernel.org=
;
> > linux-kernel@vger.kernel.org; l.stach@pengutronix.de;
> > robert.hancock@calian.com; Petr Benes <petr.benes@ysoft.com>;
> > petrben@gmail.com; Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> > Subject: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW =
RNG
> > failure
> >
> > Caution: EXT Email
> >
> > From: Petr Benes <petr.benes@ysoft.com>
> >
> > Each time TRNG generates entropy, statistical tests are run.
> > If they fail, RETRY_COUNT value is decremented. Once it reaches 0, HW R=
NG
> > returns an error, and needs to be reset.
>
> The least-significant 16 bits of the RTSTATUS register reflect the result=
 of each of statistical tests.
> Can you dump RTSTATUS to see which test has failed? Please dump RTMCTL as=
 well.
>
> Have you tried to build this patch for armv8? For me it is failing.
>
> Regards
> Gaurav Jain
>
> > RETRY_COUNT could be programmed in RTSCMISC register and is set to 1 by
> > default. Hence, we are left without hwrng after the first error, which =
could
> > happen even under normal conditions.
> >
> > Cc: petrben@gmail.com
> > Signed-off-by: Petr Benes <petr.benes@ysoft.com>
> > Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> > ---
> > Hi,
> > we are also experiencing this issue:
> >
> > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> >
> > It is happening on both i.MX6S and i.MX6DL SoCs we use.
> > On Solo I can reproduce it really fast. Sometimes it happens right afte=
r the board
> > is NFS booted, sometimes I need to stress the HWRNG for a while (genera=
te few
> > hundred KBs of random data). On some DualLite SoCs it is happening at l=
east
> > once a day.
> >
> > We are using the v5.10 LTS branch but I can confirm that this is happen=
ing on all
> > kernels since v5.7 to the latest linux-next.
> >
> > We also tried to increase the RTSDCTL_ENT_DLY_MIN delay as suggested in=
 this
> > thread [1]. It helped and the issue never occurred since then but we ar=
e looking
> > for more universal and permanent solution suitable for upstream, hence =
we
> > came up with this patch.
> >
> > Any comments will be appreciated.
> > Thanks, Michal
> >
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l.org
> > %2Flkml%2F2021%2F8%2F30%2F296&amp;data=3D04%7C01%7Cpankaj.gupta%40
> > nxp.com%7C5d6bf460b260415aeda008d9a5f0ffab%7C686ea1d3bc2b4c6fa92cd
> > 99c5c301635%7C0%7C0%7C637723276775699794%7CUnknown%7CTWFpbGZs
> > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3D%7C1000&amp;sdata=3DVxN9MqDFbISptW3OX9XTtZ%2FwQTsEbF6dETxXB%2
> > BHrywg%3D&amp;reserved=3D0
> >
> >  drivers/crypto/caam/caamrng.c | 42 ++++++++++++++++++++++++++++++++---
> >  drivers/crypto/caam/ctrl.c    | 13 +++++++++++
> >  drivers/crypto/caam/ctrl.h    |  2 ++
> >  3 files changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrn=
g.c
> > index 77d048dfe5d0..2be5584ae591 100644
> > --- a/drivers/crypto/caam/caamrng.c
> > +++ b/drivers/crypto/caam/caamrng.c
> > @@ -21,6 +21,7 @@
> >  #include "desc_constr.h"
> >  #include "jr.h"
> >  #include "error.h"
> > +#include "ctrl.h"
> >
> >  #define CAAM_RNG_MAX_FIFO_STORE_SIZE   16
> >
> > @@ -113,6 +114,35 @@ static int caam_rng_read_one(struct device *jrdev,
> >         return err ?: (ret ?: len);
> >  }
> >
> > +static void caam_rng_retry_reset(struct caam_rng_ctx *context) {
> > +       struct device *ctrldev =3D context->ctrldev;
> > +       struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(ctrldev);
> > +       struct caam_ctrl __iomem *ctrl;
> > +       struct rng4tst __iomem *r4tst;
> > +       u32 __iomem *rtstatus;
> > +       u32 retry_count;
> > +
> > +       ctrl =3D (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
> > +       r4tst =3D &ctrl->r4tst[0];
> > +
> > +       /*
> > +        * There is unfortunately no member for RTSTATUS register in
> > +        * struct rng4tst and the structure doesn't look stable
> > +        */
> > +       rtstatus =3D (u32 *)((char *)&ctrl->r4tst[0] + 0x3C);
> > +       retry_count =3D (rd_reg32(rtstatus) >> 16) & 0xf;
> > +       dev_dbg(ctrldev, "CAAM RNG retry count %d\n", retry_count);
> > +       if (retry_count =3D=3D 0) {
> > +               dev_err(ctrldev, "CAAM RNG resetting retry count to 1\n=
");
> > +               clrsetbits_32(&r4tst->rtmctl, 0, RTMCTL_PRGM | RTMCTL_A=
CC);
> > +               wr_reg32(&r4tst->rtscmisc, (rd_reg32(&r4tst->rtscmisc) =
& 0x7f) | (1 <<
> > 16));
> > +               clrsetbits_32(&r4tst->rtmctl, RTMCTL_PRGM | RTMCTL_ACC,
> > +                               RTMCTL_SAMP_MODE_RAW_ES_SC);
> > +               caam_reinstantiate_rng(ctrldev);
> > +       }
> > +}
> > +
> >  static void caam_rng_fill_async(struct caam_rng_ctx *ctx)  {
> >         struct scatterlist sg[1];
> > @@ -129,8 +159,10 @@ static void caam_rng_fill_async(struct caam_rng_ct=
x
> > *ctx)
> >                                 sg[0].length,
> >                                 ctx->desc_async,
> >                                 &done);
> > -       if (len < 0)
> > +       if (len < 0) {
> > +               caam_rng_retry_reset(ctx);
> >                 return;
> > +       }
> >
> >         kfifo_dma_in_finish(&ctx->fifo, len);  } @@ -145,13 +177,17 @@ =
static void
> > caam_rng_worker(struct work_struct *work)  static int caam_read(struct =
hwrng
> > *rng, void *dst, size_t max, bool wait)  {
> >         struct caam_rng_ctx *ctx =3D to_caam_rng_ctx(rng);
> > -       int out;
> > +       int out, ret;
> >
> >         if (wait) {
> >                 struct completion done;
> >
> > -               return caam_rng_read_one(ctx->jrdev, dst, max,
> > +               ret =3D caam_rng_read_one(ctx->jrdev, dst, max,
> >                                          ctx->desc_sync, &done);
> > +               if (ret < 0)
> > +                       caam_rng_retry_reset(ctx);
> > +
> > +               return ret;
> >         }
> >
> >         out =3D kfifo_out(&ctx->fifo, dst, max); diff --git a/drivers/c=
rypto/caam/ctrl.c
> > b/drivers/crypto/caam/ctrl.c index ca0361b2dbb0..e421f8d1982b 100644
> > --- a/drivers/crypto/caam/ctrl.c
> > +++ b/drivers/crypto/caam/ctrl.c
> > @@ -339,6 +339,19 @@ static int instantiate_rng(struct device *ctrldev,=
 int
> > state_handle_mask,
> >         return devm_add_action_or_reset(ctrldev, devm_deinstantiate_rng=
,
> > ctrldev);  }
> >
> > +/*
> > + * caam_reinstantiate_rng - reinstantiates RNG. Intended for a case wh=
en RNG
> > falls into
> > + *                         HW error condition. That happens if TRNG fa=
ils statistical
> > + *                         check and RTY_CNT value set in RTSCMISC dec=
rements to zero.
> > + *                         It is exported to caamrng.c
> > + * @ctrldev - pointer to device
> > + */
> > +
> > +int caam_reinstantiate_rng(struct device *ctrldev) {
> > +       return instantiate_rng(ctrldev, 0, 0); }
> > +
> >  /*
> >   * kick_trng - sets the various parameters for enabling the initializa=
tion
> >   *            of the RNG4 block in CAAM
> > diff --git a/drivers/crypto/caam/ctrl.h b/drivers/crypto/caam/ctrl.h in=
dex
> > f3ecd67922a7..26ff5a49a865 100644
> > --- a/drivers/crypto/caam/ctrl.h
> > +++ b/drivers/crypto/caam/ctrl.h
> > @@ -8,6 +8,8 @@
> >  #ifndef CTRL_H
> >  #define CTRL_H
> >
> > +int caam_reinstantiate_rng(struct device *ctrldev);
> > +
> >  /* Prototypes for backend-level services exposed to APIs */  extern bo=
ol
> > caam_dpaa2;
> >
> > --
> > 2.25.1
>
