Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2918F567B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGFBMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGFBME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:12:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B449D17E3B;
        Tue,  5 Jul 2022 18:12:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h17so6662273wrx.0;
        Tue, 05 Jul 2022 18:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5aHvbPnFc3WrMNwBi3yAbFFZyJSqQyCqgLMTVPf4RLU=;
        b=Kc8vqNE2IGoqlLDiZ+FSqlnPMExF5NIN1pe0GVo228I4/ps9+EPKOFtOoAjww6DkN7
         D3wAOQREyUjj9xFZsxi/9P1VkL2umDintLoR3mqOCyarg6D+20MKs8DKKp8KyL91icZl
         b8RWC2eyMAH+mRGKu/2v2Xic3pokUFFld53cdPko425fHnmg7xHTLhHz4IeV+g8UKzqW
         2Od0FoVavukSxMtI94JeibQJyzqxJKzTeRC/x3z2dUz+BSB95FDZtUj8niJgYUYtqwgT
         631dYIcVdX+TSm4Kcph3oa9DwpDRgTBOtz6nTmyJ9ahi7K+AcI3HoIIjyMNbM/E+K06m
         ExQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5aHvbPnFc3WrMNwBi3yAbFFZyJSqQyCqgLMTVPf4RLU=;
        b=5hKaehKzFQIW6aQOP1eAA1zvEalobt5A2zNVFOycXrcAksn/8azX3SK/fqv9lNhuIU
         IT7l+sKziOHHvHPEbwIL7eEWcJzZf9VNuivm1t9YtDjdi6A3wqLFlI7wlBRV3Z8Ae+Ww
         T0bJ0j6psCvaue6h+vi3dIhsNAPc/pI7ZQIo8BEj6YFHx3a2IABPOguJpqka3jnySv4b
         EjBgta0btZihh1y1cbUJ7LPAI5/++XBLaWgpGL32iMC4bV+O6bLakhSxjRMpYAY+fR+W
         ODl/HDB/AzV8cirAcok9b5wDrXpQ89X7FVDfoxrpjiqgOSZrIdSkiY36ZtqbXsMF75R/
         YLLg==
X-Gm-Message-State: AJIora9FlqQYO91BI2nXRtFqWFZmCnskKxad6Iq/HZ0mKq7cUpG3phvy
        8QalDMyDN7d2tZBKkAULNBV6eOgqbTD/MKCa3e8=
X-Google-Smtp-Source: AGRyM1sdTmzdRD2GUYAi9SAT8RRwNuwCu1WxK/TW2ZV5+qb5KAVwcP2Y6E3q1zrMXKRo9/VS1fNTY93liJO4UFoMeTA=
X-Received: by 2002:adf:f90c:0:b0:21a:3dcb:d106 with SMTP id
 b12-20020adff90c000000b0021a3dcbd106mr33713209wrr.448.1657069922265; Tue, 05
 Jul 2022 18:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <1657038252-31360-1-git-send-email-u0084500@gmail.com>
 <1657038252-31360-3-git-send-email-u0084500@gmail.com> <CAHp75VeV6vByZXGLraLes+94Rfs23ZjPXGaXzUf-YY=sb_1=2Q@mail.gmail.com>
In-Reply-To: <CAHp75VeV6vByZXGLraLes+94Rfs23ZjPXGaXzUf-YY=sb_1=2Q@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 6 Jul 2022 09:11:50 +0800
Message-ID: <CADiBU3_7hbwesbXTHBhqo7orQmYp=bY_8b7yhNDKB6m6-CCEtA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add rtq6056 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A83:09=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, Jul 5, 2022 at 6:31 PM cy_huang <u0084500@gmail.com> wrote:
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Richtek rtq6056 supporting.
> >
> > It can be used for the system to monitor load current and power with 16=
-bit
> > resolution.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Since you sent a new version:
> I said explicitly that the kernel version mustn't be not stable nor devel=
oping.
>
Sorry, and this.
Are you saying that patch series need to depend on the stable kernel versio=
n?
I cannot always sync the latest one and have to use the tag to grab
the stable one.
Right?
> ...
>
> > +KernelVersion: 5.15.31
>
> ^^^ Wrong
>
> --
> With Best Regards,
> Andy Shevchenko
