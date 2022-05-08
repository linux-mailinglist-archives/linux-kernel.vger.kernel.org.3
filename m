Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472FB51ECBB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiEHKAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiEHJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:59:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96822640A;
        Sun,  8 May 2022 02:56:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l18so21736475ejc.7;
        Sun, 08 May 2022 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMTzwniKsJKBvHw/Xx6/XM/Pnx3ZZPbw95CMSttKIV8=;
        b=o5wIsfUNM+VbOjSBIhIyUrCRtI5jh2afkgfbkTbrgJWOWiAWbeVtPSJUHvBSEi/yr6
         m/u7oFiFVMr7YqzcjbJ4WiFHVi2+cddY7rgU/vA7sjbPvJZxsRr9+y3QEhYslDzZr1tb
         RZZkZbYVrfJcLo3tx8yJGAeCOyETwIAl+ixbYuEla8mUDu4OES43Nqzvp6P0fFhqF1e6
         x4kFgVGCyXqO3ihRho5v9e4roW/hNqytoywmuaN3mb7kcvhDej2V422n5YuckxMBw0Oy
         Knhwx61ZlDQ6WsVn8ze7HJEH3lK5M6/AcFKdI14QhXVIs8Igh4BBVWLvaab2kqsCWf2t
         lEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMTzwniKsJKBvHw/Xx6/XM/Pnx3ZZPbw95CMSttKIV8=;
        b=RZe40s+qgwKoSdEPGmrwkm9c8S05FcZgqfF9lGKnP3pXc29wl8MkbqnGUK1TuJZnnK
         MpbqAhk1gpLhFq6BFcdjxYgBWsWj+3Szsq5NeiGCkeFwN0n7q16tSCPK6Ss2SnrFe1OQ
         VLGe8+SW7TwbX7O5aP6h6rBuX3aKnNabNdT5JEKZa6Gz7++ZumS0WEvwzz42PJnMGmbF
         IabIeGkiA+eG/3Oj14vVnQTjmKEb+7gAYy5RH9lCcCfw7m5cua7hwRyw6tXlthX7TxHa
         SME0W2uOMlYoQaeDq7ZMkEqSQpq3+SubZ7RHtEu6KNN47hNoKNOWXT/wWeBacccmvN0d
         8Ruw==
X-Gm-Message-State: AOAM533DUqyKOISkuB9EVx6kA4EeLgoLBv5UiruF4026XHg0yQoD6syj
        rASJuNao2VsDyUyhQkSrgc1wCrA3X0lir+oc7jrwTIQUMaxStj0i
X-Google-Smtp-Source: ABdhPJxmNNQmwZNo8ah9X+MPI91et4WY6i1uhtxjMTikXV0qZBM9zGPzh3XBqhqdhtOO8cw7DdOiASQMyi8Nx4Ef2Xg=
X-Received: by 2002:a17:907:3e8c:b0:6f4:4fdb:6f24 with SMTP id
 hs12-20020a1709073e8c00b006f44fdb6f24mr10204116ejc.44.1652003767031; Sun, 08
 May 2022 02:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220505152521.71019-1-markuss.broks@gmail.com>
 <20220505152521.71019-2-markuss.broks@gmail.com> <CAHp75VfUA3qnZnkPQB3TRpPDwe+F+Q6rv9dQmq2xLfw9PmJ8LA@mail.gmail.com>
 <20220507211402.GD11004@duo.ucw.cz>
In-Reply-To: <20220507211402.GD11004@duo.ucw.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 8 May 2022 11:55:31 +0200
Message-ID: <CAHp75Vd=iD4QO2SV5h_P4GowVEy4Afk4nVyLezVa4w2u4jKybA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] leds: ktd2692: Avoid duplicate error messages on
 probe deferral
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, May 7, 2022 at 11:14 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > Use dev_err_probe instead of dev_err to avoid duplicate error
> > > messages if the GPIO allocation makes the probe defer.
> >
> > Thanks!
> >
> > There are two improvements we can make here.
> > 1) adding a Fixes tag, so it can be backported to stable kernels;
> > 2) see below.
>
> I don't believe this is severe-enough error to be worth stable.

Fixes tag is good to have in either case, but I agree that is not so critical.

-- 
With Best Regards,
Andy Shevchenko
