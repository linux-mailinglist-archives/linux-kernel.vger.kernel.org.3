Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C2D4E7FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiCZH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCZH5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:57:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C921E523C;
        Sat, 26 Mar 2022 00:55:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 5so16830505lfp.1;
        Sat, 26 Mar 2022 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vtMXvDURXGEKzwLejhvn8Ej3qBD0c3vHRdo5p0wXzqY=;
        b=p9TUnUzvVLv7N0/Nen20K1cXd5bKdWYD5+XhXtDMNZQrLyA8Iz2wo0MbuGZEH1JsUe
         30v/IOgxvRurXi3QABzU1M7V3I/aq0lh8VzAQA+1q9lF5vCRv8vQNFEUdxYlaFXKRRwY
         MO1sQyGQkPWVXTl99+ASeS5bjVVcL8r4q6ziekHjNUm1U2bW8MZws6CoeoSH9HKJUOLL
         eNpjsYUQOBUNy+9ugMvr9kIdWqLMq8+QLbp7MGIyiMI5/ybHPV4+wzWTUkmFBWEdpKk/
         Fz4CRvD1AuC5zbnWm2rXmYv8MKC/WXfndkeItqHwq7KhxsGZ+vyS1ThGHpVeeoIFszNl
         +KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vtMXvDURXGEKzwLejhvn8Ej3qBD0c3vHRdo5p0wXzqY=;
        b=sdNoY0rKW734B3GbALkFjTfK8mktbEymds4Li813XygohMb/f6A+1g7ydI5AtO7snm
         97sxZbFzM2ZgOnVOwy8R3KbXvhKcNUznXmvnZy1PDpbEdQtA6gk6te1nfwCK9i699t27
         LQZCqkULPFEnT/UFi39qqeQ8tVgW7A7Lr0iZME/m7P6AaWBg8VuLZTMmSekEuzA/lyK7
         rf9WEYE+2rUh6N4Osh4zUPO8MGF/N1RfJlPlwwssUpgrLXFctudKCgcuKBLTzJ6HxECD
         toO199zDvTZgDxkQFnFhn5banlRcOxR3m4QGJSr+qIOiKdik+sOgQQvxiwzZM5vIpN1x
         /9fw==
X-Gm-Message-State: AOAM532dvw2mjcOcsbF6N0XzRWEEEZfuABqbeeVZfKicb8vej8PAPWmi
        Th6YQDvx3SGIKG93IwRHBASoobysQ/tjuTazSwQ+lGiD3ug=
X-Google-Smtp-Source: ABdhPJxZotAolPw05aa1obaIosg5NY7A5wPZORAClJsKd/FlvRmxqbcbqFrjymPqxXC0DLUXZFnp98cvJGBTi09AHXk=
X-Received: by 2002:a05:6512:3152:b0:448:2622:e77f with SMTP id
 s18-20020a056512315200b004482622e77fmr10680060lfi.407.1648281352758; Sat, 26
 Mar 2022 00:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org> <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org> <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
 <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org> <Yj3oXuijuZY1gG9X@sirena.org.uk>
 <d2f220ae-c62c-a7f7-23cc-c33956c2eeaf@kernel.org> <CADiBU3-3QLi5PVUymk_VCbF+-uVSqjoP9jLGL+R=PQ-S=Y=_AA@mail.gmail.com>
 <Yj5nYUeizlmlbX4O@sirena.org.uk>
In-Reply-To: <Yj5nYUeizlmlbX4O@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 26 Mar 2022 15:55:41 +0800
Message-ID: <CADiBU38O6zdp5KYt90KgrZKJwAzBqPoaYQYehAJ=wS42NyVcjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sat, Mar 26, 2022 at 08:58:47AM +0800, ChiYuan Huang wrote:
>
> > I tried to remove only __maybe_unused and build with x86 config  that
> > CONFIG_OF=3Dn.
> > There's no warning or error message when compiling the rt5759 source co=
de.
>
> > If so, I will remove only '__maybe_unused'.
> > May I ask whether 'of_match_ptr'  need to be added or not?
>
> If you add of_match_ptr() (which is a little better, though it's
> a tiny different either way) then you shouldn't remove
> __maybe_unused - the thing here is that the __maybe_unused is
> needed because of_match_ptr() is used.

Sorry, I'm confused.
Originally, Krzysztof's opinion is to tell me why 'of_device_id' is
declared as '__maybe_unused'.
That's why I mentioned that the return value  about of_device_get_match_dat=
a'
And now we're talking about to add 'of_match_ptr' in struct driver
of_match_table.

Back to the original topic, two ways can solve this.
1) only remove '__maybe_unused' in of_device_id
2) keep '__maybe_unused' in of_device_id, and add of_match_ptr for
of_match_table.
But option 2 seems conflict with Krzysztof's gueestion.

May I ask which option you suggested?
