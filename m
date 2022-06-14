Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F054AD90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiFNJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiFNJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:48:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C7427DA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:48:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c2so10811293edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbWEIZKuQEPkI6mw3aStn5U0WWP1BjEat68e2PmiceA=;
        b=N1NiormT/h2pvJCji1D4eEYMeNioGpKvNXYvFBg4XQp8mZGVkkE6bBZfAm3zrDmbhb
         /bHDPI6uqMlXm4lFR2z9UjBANDyP3XAvLzHPoQqChqmwmW1lFFjCj6hPQWpjX/ib9Bls
         UdJDH606+ke3zr7VdHkLFrCmv2rrkEbETNugI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbWEIZKuQEPkI6mw3aStn5U0WWP1BjEat68e2PmiceA=;
        b=hXnzO8B/teuK1YKgEd5yF/q0AxsPWn1N7UYxUJBUia8BlCh3/rCylkNqKDVjRadImO
         osh1SdtAiNZZVeFJvQyyxqWSiJZoekfZAtL4YA5tRdD1mBddO0OS4hdMSW3lvzzlc223
         aJENBVsRYmvDr0X4ptE1wV/EfGZRd6Dkgd8jKjHB0lM++4vdVlVjHRxXNFzJKUZ94BCx
         Xea4HIRfA2o1U5Tu/8hl/nkU8gdD+7N8PoThGP1E0GuaotwOpnCpejXTn3pBbluFAcfK
         zVA33hK+0JbISKZXZsNgdM+IFwvbTL1PRlEr9fWH8eUtw9yYQYV8KghYuo4UnQdGdkBX
         wXaw==
X-Gm-Message-State: AJIora+vBTiJnXAw/WgCKBNznn8F/RVuBDIuyoUn76xhEz0FSIMHlCnI
        6lbdv/919VX/QAauGS/9vY15jI36Njsz5PrWV/AIMSVae34=
X-Google-Smtp-Source: ABdhPJyXQyqWZ3hflsG2HtwWc6SYz4sFBWE+oURZh9HNdq8IrbaTBrl7OmuUmLg8S2s2rqJ2OQs3C4QaqXjhYkWpLts=
X-Received: by 2002:a05:6402:2381:b0:42d:c8fe:d7fe with SMTP id
 j1-20020a056402238100b0042dc8fed7femr4835160eda.248.1655200080686; Tue, 14
 Jun 2022 02:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <b36280be-9993-9a78-0960-4094efeed1aa@linaro.org>
 <CAMuHMdWL93+r0cofwHKj1k-gUo9nk3OzUf6gtY68sK4JNibyNg@mail.gmail.com>
 <eb5ab9553c419b8259f5494664865597b6c5d4db.camel@infradead.org>
 <CAL_JsqJ49bnBe84PXYY6caN0rxEEgL=mcWqKktzbK94McgYNfw@mail.gmail.com> <6757109d4eb065682706e455c9772259cf11e557.camel@infradead.org>
In-Reply-To: <6757109d4eb065682706e455c9772259cf11e557.camel@infradead.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Jun 2022 17:47:49 +0800
Message-ID: <CAGXv+5EbA29qfd9WPP=hawxgAKE-tSQvCsjX+-a0hmUsmWFgzA@mail.gmail.com>
Subject: Re: Getting rid of infradead.org - corrupted subjects
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mark@msapiro.net, workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 11:17 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2022-05-25 at 09:30 -0500, Rob Herring wrote:
> >
> > Yay!!! I should have asked years ago...
> >
> >
> >
> > Any chance the appending of footers can be stopped as it causes lore
> > to report duplicates and b4 dmarc attestation to fail?
>
> That's up to individual list owners; it's part of the per-list config.
> It's very easy to turn off.

Could you share who the owners for linux-arm-kernel@, linux-mtd@ and
linux-mediatek@, just to name a few, are?

Thanks
ChenYu
