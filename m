Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81052CB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiESE7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiESE7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:59:08 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798E787227;
        Wed, 18 May 2022 21:59:05 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ec42eae76bso45264497b3.10;
        Wed, 18 May 2022 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFrp9wzq4sCkuwLY21DamOeXfwOOx7ci5Z7FlQKCo0o=;
        b=pqGBuGbKiyhuZzK3H20eVg3ZjdCpjyeI+gQmEMvGfF2dMzgN/tHoxIud1GDP+n6ZH9
         9AmV/Y4qb/d7mUQXh4gS/iIFKRZ/kvdo7khq7yRoMOQuiTwY11JujXq9GJK1IEmZblnk
         QUuLDl9mGm8T3NDARUl6BOMitQjSFpUeQtPWkHKo3nLIfr2XV1+MayFX91CM2z2jQe0j
         EkicZcXGmE5avn60jigo9wxAqmmA/BixOo18Uw/3hZSityTyg0ZrPZEfNC7gFRj3PDgE
         TKM8ypsAsGafjJHLU5wYIU05LK2GI+z005SyRnQuJnznxmkT4M9uGeChuDp1vBJkG4NG
         WySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFrp9wzq4sCkuwLY21DamOeXfwOOx7ci5Z7FlQKCo0o=;
        b=j+MgwaeBDmVkrLrK6HUEVzU3k5C1njRAi/AjJJKlmBfDYKaUsu8nd+u7TWO/Rsp1xX
         MqhvRgr23+eHos3LbV/P6tyu+dFjS4zr41lDNh3NAxJR3kmirsmj9vMezrED9Q0iSKql
         HK2FzDsUSbeSnbOVasny7957L83OVNzVuOKrNEGz0mla/owXqlE0ZmIkJsb+hRPKcS94
         h4thpz7KzrikWjRjYVIhIdO7h84JqyW6d24fSK8emBrLTAgTcAphviLMHLSLhHQlIoAt
         6vzWM66RVWuQXj+AYkuAYqi8+ehx6/SGDEkg/rysayVPgcJp8Mr2HiN24Mi6TWKL9JKj
         eh6Q==
X-Gm-Message-State: AOAM530UJTwi0MlRpXsB/rWSYGdh+xE/+CzxmKPYTZuzSY2IfUtxCu0R
        YEyp+UeDKZiroDvWQj6ExDdz7QvNXUMY0yO4El4=
X-Google-Smtp-Source: ABdhPJyRx84ItJIk5Ins7S9RGT10EmMI8VoeX1fvKM8UZq0gI9C5++A2/8WlAuVdh/NW42hGU5LdPkHg5Ln1/jGoksw=
X-Received: by 2002:a81:6cc9:0:b0:2fe:cad8:f4e0 with SMTP id
 h192-20020a816cc9000000b002fecad8f4e0mr2956960ywc.119.1652936344738; Wed, 18
 May 2022 21:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220513132500.32395-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YoR6N2ACf3TZr1P5@google.com>
In-Reply-To: <YoR6N2ACf3TZr1P5@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 19 May 2022 05:58:38 +0100
Message-ID: <CA+V-a8si1uD5FgmpRfjfQ9FnarCA0_Fn2SMKJfw4nVZ=4iui4Q@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - Cancel delayed work only in case of GPIO
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the review.

On Wed, May 18, 2022 at 5:46 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Lad,
>
> On Fri, May 13, 2022 at 02:25:00PM +0100, Lad Prabhakar wrote:
> > gpio_keys module can either accept gpios or interrupts. The module
> > initializes delayed work in case of gpios only and not for interrupts,
> > so make sure cancel_delayed_work_sync() is called only when bdata->gpiod
> > is true.
> ...
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index d75a8b179a8a..ec9d50ddda42 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -133,7 +133,7 @@ static void gpio_keys_quiesce_key(void *data)
> >               hrtimer_cancel(&bdata->release_timer);
> >       if (bdata->debounce_use_hrtimer)
> >               hrtimer_cancel(&bdata->debounce_timer);
> > -     else
> > +     else if (bdata->gpiod)
> >               cancel_delayed_work_sync(&bdata->work);
>
> We already have a check for bdata->gpiod a couple lines above. I think
> the chunk should look like this:
>
>         if (!bdata->gpiod)
>                 hrtimer_cancel(&bdata->release_timer);
>         else if (bdata->debounce_use_hrtimer)
>                 hrtimer_cancel(&bdata->debounce_timer);
>         else
>                 cancel_delayed_work_sync(&bdata->work);
>
> since we use debounce timer/work only when we deal with gpio-backed
> keys.
>
Agreed, will fix that in v2.

Cheers,
Prabhakar
