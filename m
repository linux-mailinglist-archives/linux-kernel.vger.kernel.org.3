Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4680F4ED04A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351840AbiC3XpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351835AbiC3XpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:45:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B3C10C6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:43:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id yy13so44628930ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iREdRJSlGkex49OSzIjV0KsFYd3jZkgqeIW8XLnqJVg=;
        b=v3+DvT6MCRwfRE2AsrD6YG1zSiTxbEnxL6aEqZFU/4zqeuCy5A6lE4iTeY+xbiG8I5
         x5sI51qPvKIaTNBzbsgmeiUriNZA6Kn1CbUpdVh6K0ARyes4hEwCSxnpaTpGQo8CsY8I
         68ayLJPCkYZ1TBvBlm8Jy3i/0yq4T7lOHGm4oaGQB57zlbrm14e6zjQ30W4QWlJ1na8B
         yluIPxS3F2ANatES130GX7cIUfWGFbkaMSpvwt/xt4mBXmWxaWn0vCtU6Y9ontlzRgGK
         MnvGuNkZ8A4FkSalHvCMKXkPXM6NSnLvgCAUZybrfmU2m0axLV54Da5AyNWnee/FFq0D
         RkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iREdRJSlGkex49OSzIjV0KsFYd3jZkgqeIW8XLnqJVg=;
        b=WxrPOT+yisPQIHbqIennF33RK0Febys6sDUp8rQDtGMiFQNfsSWL6j9FSAsQQ9JWcK
         l7Uuo8qVVztiuxxVWvuy79cYOJOFizzBZUaYfhoXdF6CEamppCRs2NArBAvYpH7OfyuK
         x/NMbaMpFEA+TILJjyZPgif9km3X7x9nZZoagRB2a5slR5rmFuldgH9PTzYAlijdfJSU
         D0e/dXObJtUt6fW1mqJxdJZfysUhD+7Q36AnbX1h0pRb2LlCn8jw05BWazLPhdMq35+E
         1e+WbLiw5EAjfrSUj/eP57uLhny6ha99gr2DSUKZtNnCL+RGrlNx0P1cwReMXJoysjie
         ljoQ==
X-Gm-Message-State: AOAM532kefKYhFoNEmh5inYhD4cSoJ59MT+jrO4nX9DhpzK4BR2P0q7o
        b2nmDEp1/atFwuZoAJ832ni0iUvtZsIJFwxo/SowvA==
X-Google-Smtp-Source: ABdhPJxy8IQdc1GvtVhMWnjfsuJqWeXYQSzpSc7eTZXkFj106tgToJ42geM6ymErC4zrL4G/l3YiOH/g+QiNb7AA6bE=
X-Received: by 2002:a17:907:168a:b0:6da:9177:9fdd with SMTP id
 hc10-20020a170907168a00b006da91779fddmr2232289ejc.757.1648683800778; Wed, 30
 Mar 2022 16:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-23-nicolas.dufresne@collabora.com> <20220330075913.wfl3prsyw5fvsv4t@basti-XPS-13-9310>
 <4740735d92c0dac3708aa922b3d73db7a61fbdda.camel@collabora.com>
In-Reply-To: <4740735d92c0dac3708aa922b3d73db7a61fbdda.camel@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 30 Mar 2022 20:43:08 -0300
Message-ID: <CAAEAJfCH+m7mzU2EHkyxdKiNs7p=qfSfnvDzS+hLOftFE=n9CA@mail.gmail.com>
Subject: Re: [PATCH v1 22/24] media: hantro: h264: Make dpb entry management
 more robust
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:16 PM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Le mercredi 30 mars 2022 =C3=A0 09:59 +0200, Sebastian Fricke a =C3=A9cri=
t :
> > Hey Nicolas,
> >
> > On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > > From: Jonas Karlman <jonas@kwiboo.se>
> > >
> > > The driver maintains stable slot location for reference pictures. Thi=
s
> >
> > s/slot location/slot locations/
> >
> > > change makes the code more robust by using the reference_ts as key an=
d
> > > by marking all entries invalid right from the start.
> > >
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > ---
> > > drivers/staging/media/hantro/hantro_h264.c | 10 ++++------
> > > 1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/sta=
ging/media/hantro/hantro_h264.c
> > > index 228629fb3cdf..7377fc26f780 100644
> > > --- a/drivers/staging/media/hantro/hantro_h264.c
> > > +++ b/drivers/staging/media/hantro/hantro_h264.c
> > > @@ -258,8 +258,7 @@ static void prepare_table(struct hantro_ctx *ctx)
> > > static bool dpb_entry_match(const struct v4l2_h264_dpb_entry *a,
> > >                         const struct v4l2_h264_dpb_entry *b)
> > > {
> > > -   return a->top_field_order_cnt =3D=3D b->top_field_order_cnt &&
> > > -          a->bottom_field_order_cnt =3D=3D b->bottom_field_order_cnt=
;
> > > +   return a->reference_ts =3D=3D b->reference_ts;
> > > }
> > >
> > > static void update_dpb(struct hantro_ctx *ctx)
> > > @@ -273,13 +272,13 @@ static void update_dpb(struct hantro_ctx *ctx)
> > >
> > >     /* Disable all entries by default. */
> > >     for (i =3D 0; i < ARRAY_SIZE(ctx->h264_dec.dpb); i++)
> > > -           ctx->h264_dec.dpb[i].flags &=3D ~V4L2_H264_DPB_ENTRY_FLAG=
_ACTIVE;
> > > +           ctx->h264_dec.dpb[i].flags =3D 0;
> >
> > Ehm ... we just remove all flags? Can't this have any unwanted side
> > effects like removing a flag that we actually wanted to keep?
> > (Like long term or the field flags?)
>
> This is a local copy of the dpb, the DPB is fully passed for every decode=
. So
> these flags will be fully restored lower when we copy the found entry. In=
 fact,
> holding a state here would not represent well the userland intention and =
can
> have negative side effect on the decoding. Flags are not immutable betwee=
n
> decode and can change. This simplify the code, and make things less error=
 prone.
> This part of the code is already a bit complex, no need for an extra laye=
r.
>
> > If we just want to set the DPB entry inactive, then removing the ACTIVE
> > flag seems like the correct approach to me.
> > If we want to get rid of the VALID flag as well, then we could just do:
> >               ctx->h264_dec.dpb[i].flags &=3D
> >        ~(V4L2_H264_DPB_ENTRY_FLAG_ACTIVE | V4L2_H264_DPB_ENTRY_FLAG_VAL=
ID);
> >
> > In case we really want to reset all flags, I'd say adjust the comment
> > above it:
> > ```
> > -     /* Disable all entries by default. */
> > +     /* Reset the flags for all entries by default. */
> > ```
>
> This reads the same to me, but I can do that yes. understand that VALID m=
eans
> the reference exist and the TS should point to some existing past referen=
ce
> (unless there was some decode error, which the userland may not be aware =
yet as
> this is asynchronous). While ACTIVE means that it is used as a reference.=
 FFMPEG
> is known not to filter inactive references. ACTIVE is just a flag without=
 bunch
> of other flags that can change for every decode. So none of this make sen=
se
> between 2 decodes.
>

Please leave the comment as-is, 'Disable all entries' is readable.

As much as I'd love to have very clear comments everywhere,
we have to accept that only people with insight on codec details
are expected to make sense of driver details :-)

Thanks,
Ezequiel
