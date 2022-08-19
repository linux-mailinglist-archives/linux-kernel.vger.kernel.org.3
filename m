Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91B359A444
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350896AbiHSRXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354412AbiHSRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:22:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23631500EB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:42:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l19so1867114ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Ig/qPo2qaP4nMZSSCjx0miGkfyyH44acaJdC+xo73VU=;
        b=CKdf0+DFEY9sOKOfNChdys84F5N0FhF0s9FPPb3LzicWn6PnA0gBh0epmrOdLxmTUN
         mApzfY0D1t3y1aZm6Uq8Rs84zwhazoyvoZYR/pYqloP8zRZVHJIsU7Xy/hvfBu/pREN+
         8DARCE4Qlm+LxF14Qnd/PViFb7ghYgcwgvll8cv/YD/Xw/C4uG3SNHW6gbuHAD6tNNKx
         9Sf5jQ3pjyyqQTQnBH9saP3LXhbxOLWCtoJkDlGai+shn85DL7MtLqwloJHMmkP/U1Pd
         Xz8zmKa2LL/ibEDtunk8iNeLMHB2YIaPYaAL+VedOQ6XLhxnchxwKsBMtZaP49ZEW3YN
         gS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Ig/qPo2qaP4nMZSSCjx0miGkfyyH44acaJdC+xo73VU=;
        b=JSbjbq9JqIzKtP2d/rujGQxnKCAsa5ywD2z7bnrRbYe7pDzZALZZq7uuDuUhymuGHw
         IsKLtFNp73xFQhe60xlMhYR/b+hf+jbFqAtzZyUlbGM8cORsn6FzzQKSEZK0JCQpFCNc
         Zx4Co9UczdC7bi4iDABfEQMyT5f4U+ONWLLea+cgczL2xBA6WoQcUgi33Cml2smrfiuO
         GP22XZjtTpRN62xlf4NRDs0O/ME3jENCaY2d5ECl3kYTeNEJs3eSn0+n3YyMIIazXyii
         YBDEX/xBmRY7HuqhcZCowCr7pnErr+hPxLvw8agq5Vqf7OvN4GVHZGfSCwLYxah6ODaf
         g7XQ==
X-Gm-Message-State: ACgBeo1kItXiRQVzo6UoXO8C2mNOkfvBLjZvXTtbLAVPy8ARiXOrgzy0
        DrDPK1UC3BSCirAtiz+bnr+3ZAvJ49cqI0MHz22QOKytahk=
X-Google-Smtp-Source: AA6agR61kyiX8HIDHngzyU8NBFqSG5zymYgJAOjGB0q96t4MJ+iRq5hp428/uccrUY5pdOswTnR7DOStCgFsbtFpAUE=
X-Received: by 2002:a05:651c:b24:b0:261:c1ad:fa27 with SMTP id
 b36-20020a05651c0b2400b00261c1adfa27mr370480ljr.526.1660927329815; Fri, 19
 Aug 2022 09:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220803182402.1217293-1-maccraft123mc@gmail.com> <d24e781c-3c84-26eb-14b9-8cb4ea3b32ba@redhat.com>
In-Reply-To: <d24e781c-3c84-26eb-14b9-8cb4ea3b32ba@redhat.com>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Fri, 19 Aug 2022 18:41:33 +0200
Message-ID: <CAO_Mup+wLRuQPyiBEUV7=qC5OaSdzKpjysH05nUN0mSGSKgoeg@mail.gmail.com>
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for Anbernic Win600
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

czw., 4 sie 2022 o 10:32 Hans de Goede <hdegoede@redhat.com> napisa=C5=82(a=
):
>
> Hi,
>
> On 8/3/22 20:24, Maccraft123 wrote:
> > From: Maya Matuszczyk <maccraft123mc@gmail.com>
> >
> > This device is another x86 gaming handheld, and as (hopefully) there is
> > only one set of DMI IDs it's using DMI_EXACT_MATCH
> >
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Since we are currently in the middle of the merge window
> and this patch needs to go to a -fixes branch I'm not quite
> sure how to handle this.
>
> Hopefully one of the drm-misc maintainers can pick this
> up (once rc1 is out?) .

We're at -rc1 now, and -rc2 will likely release within couple
of days, can anyone take a look at this patch now?

Best Regards,
Maya Matuszczyk

>
> Regards,
>
> Hans
>
>
>
> > ---
> >  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/g=
pu/drm/drm_panel_orientation_quirks.c
> > index d4e0f2e85548..a8681610ede7 100644
> > --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > @@ -128,6 +128,12 @@ static const struct dmi_system_id orientation_data=
[] =3D {
> >                 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
> >               },
> >               .driver_data =3D (void *)&lcd800x1280_rightside_up,
> > +     }, {    /* Anbernic Win600 */
> > +             .matches =3D {
> > +               DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Anbernic"),
> > +               DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Win600"),
> > +             },
> > +             .driver_data =3D (void *)&lcd720x1280_rightside_up,
> >       }, {    /* Asus T100HA */
> >               .matches =3D {
> >                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
>
