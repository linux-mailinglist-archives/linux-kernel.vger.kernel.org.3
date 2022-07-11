Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070BB56D374
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiGKDn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:43:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A255AC;
        Sun, 10 Jul 2022 20:43:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so2291671wmf.2;
        Sun, 10 Jul 2022 20:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KqMpWWr7jAHeiYl0M//2HHTwac5q/QWJup1Tb9ebpsE=;
        b=fxUC+Rp5sEY94QL+2UKtp9RwgS/2nBgZ/gGsbIDQy5fWDQqChSmZS03UP6g4+ZpVtF
         RQvRfcReaaSvBC1EMrezqWNSPsgCK2nyitl8oboDn0a/hhJSNpAQLiq5Y1mNiYGRwLzs
         i/0XwKGoeqbfgJUvBOXic0jmxFHZ9hTqP3wkvIKDCRflFk/WDW2Q7AOK+VxQoutP2xhp
         S/v1RoHggmkNNkxfG3rjHcWIxb2dgUTnhiFJv3F2k7BVhAE7L6rLN2hIZIsUfGZQNjIE
         Wo+poC9VRgu6m9/OKsmb2R0kUvh5CxUsVRDUTCom+95CASiEMkytZwj6CzxMtkqIH4QE
         K1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KqMpWWr7jAHeiYl0M//2HHTwac5q/QWJup1Tb9ebpsE=;
        b=RW5a8YSZ8EsFMWFYgRYbsHQh+QdjaxQYrVLsQOQbhWaiJRPQqct0slk0uhG64eNK9K
         fv+2clmsCP6ZEDvs6i1Q8Nza5TWZpwpTE1ccFbTXMn8gwA67yeuO23RO9wNpF6NXkqM6
         zY97cg5Zrfz6VnDzsM3sLZr8o1raM4J+4qzU23W6z6TLSO+14AO2E9sqZ6p2fyeJbpcV
         D+fuvVSnHnjowsAkPS3H70TZ4msyatwSHV6RfRDNZ32klpTjTHuPD0Xv5RDpYaomy7TR
         K52vCjh2BYAiFlutl+Sfm6npJBQOfcMKqmbjvB/+9jVOps2NIAVxving+LQgne2b3ydJ
         qe0w==
X-Gm-Message-State: AJIora+QkZKWJwHzzFJUFH3qFLlYQAkTvSyflcOABqfkRkl+43xhuCq0
        G/ct6/gm8bIvkErRDF2fnrXpJs/NKK53Z2E+3a4=
X-Google-Smtp-Source: AGRyM1uiMzdFBcUgWVzca80FM1o67gTwc+QwMZvxPWQRS7GgdfPxrIdQ2xnKLC8bWu/aGXU3D+3HoGLkT998eFjwXqI=
X-Received: by 2002:a05:600c:2946:b0:3a2:e11f:ce4 with SMTP id
 n6-20020a05600c294600b003a2e11f0ce4mr10852925wmd.186.1657511031221; Sun, 10
 Jul 2022 20:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-5-git-send-email-u0084500@gmail.com> <YskJ1wAp0rV9qFRM@google.com>
In-Reply-To: <YskJ1wAp0rV9qFRM@google.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 11 Jul 2022 11:43:39 +0800
Message-ID: <CADiBU3-ca=YMskJnp++sUHS7fTVb41prUzRtPdhJ_rrnYdzfkQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] input: misc: rt5120: Add power key support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=889=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=AD=E5=8D=8812:53=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi ChiYuan,
>
> On Wed, Jun 22, 2022 at 06:01:44PM +0800, cy_huang wrote:
> > +
> > +     is_pressed =3D !(stat & RT5120_PWRKEYSTAT_MASK);
> > +
> > +     if ((is_pressed && irq =3D=3D priv->press_irq) ||
> > +         (!is_pressed  && irq =3D=3D priv->release_irq)) {
> > +             input_report_key(priv->input, KEY_POWER, is_pressed);
> > +             input_sync(priv->input);
> > +     }
> > +
>
> What is the reason for checking both the status and interrupt? Can we
> simply say:
>
Just to make sure 'press/release' to matche the current state.
In the IC design, it already guarantee press/release interrupt with 50
millisecond debounce time.
But if irq is delayed handling, press and release irq will all be checked.
Although irq is one by one, but in that case, pwrkey button up will be
reported twice.
I'm not sure whether this case exists or not.
>
>         input_report_key(priv->input, KEY_POWER,
>                          !(stat & RT5120_PWRKEYSTAT_MASK));
>         input_sync(priv->input);
>
> ?
>
Yes, but how about the above comment? Is that case 'don't care'?
> Thanks.
>
> --
> Dmitry
