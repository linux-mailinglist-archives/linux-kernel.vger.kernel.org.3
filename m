Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BFB57CDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiGUOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGUOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:36:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60E54A814;
        Thu, 21 Jul 2022 07:36:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a23so687489lfm.10;
        Thu, 21 Jul 2022 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a45XGYjGqJj1SQDNhpIFTnsS1sN/Pvl1ei9cqTikBdo=;
        b=ZtPDqAPNcLI5BmGpzis11nE5xbKaJSqYBdhdLVwZSA9MIrBTenSJl984+CJg2un54E
         0vOQ9dVDtygBYd2OWxt0jt320O9/Cfz5DmAre28h5pFNYVpyjnnyWq0mOd1kxYA/wQDb
         Nk8uVDwav760RHf7Re6a4/p6aREx/utu7K/v8xQvupb6Nvdp6pLi9grUtIqDJNUC/2lk
         TVSJ4PZPO1LxcpuZSqldEfoGfaPUbS5jXm6dPfX87s45ZNYXduJo+A2CnUyEOB6FPIVy
         5eG5O2MPHt/BMI7s3vo5BhVu0vZsAh34ZHRP8rBvLXTcHFiq8r9dro2jAi6SIuuphkLz
         YyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a45XGYjGqJj1SQDNhpIFTnsS1sN/Pvl1ei9cqTikBdo=;
        b=ubRSra4WSUlj9lG9c9Ia8pk2pFAIXGTPVq38TU4h/QIXGMWxFim1l9yVZOkaXm//MN
         Eaxtkh71KGXsaieoyrgzbNiy7/WuD1jNGo0Z+pu8MnSIY+CST2cUsrunK/S6Q3MGa1fd
         0qV9o+YIfp1YqCgE6LkxfWUCdWv9d8Pbzt9HNexi9kD/0OeZ1+UXje8jzVhpcNK3fq4V
         Px3wegtmCaMvxr4cjtwo/F0OlGw9nuUkkus7oI3zYOucl0d19Tp+BJ8w5gtKzdsYfPzo
         lY/17qMxznQnsIjgVO+iQNrl+jaHlbtyeiMPfoUcRQpLDxkTZ5KcRZrvt2toV14jNbt8
         fJuA==
X-Gm-Message-State: AJIora99UNZ/qWoC2prWM68GWNdfifJK9etWzFPHiUVGWNdWUYogOthp
        v2l/1B6pAtUYmZil/rvi/jNLMiKaQ1jB9KoR95I=
X-Google-Smtp-Source: AGRyM1tJveEikQFTfSBOWxKIFmbqGzdQVmYaRXPZa7hYzIom8WOv8CXPxQnNyXC+Eclmf8Z12KA3a8w8w+W0bZdh2FU=
X-Received: by 2002:ac2:4897:0:b0:489:f2ad:1191 with SMTP id
 x23-20020ac24897000000b00489f2ad1191mr21118185lfc.25.1658414169880; Thu, 21
 Jul 2022 07:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220721101556.118568-1-tmaimon77@gmail.com> <YtlES7MX6nJr8l+L@sirena.org.uk>
In-Reply-To: <YtlES7MX6nJr8l+L@sirena.org.uk>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 21 Jul 2022 17:35:58 +0300
Message-ID: <CAP6Zq1gB1yrqNDJROf8xyjYiCv6H-rW=Qa7J17AoFo3mv5hsLA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] spi: npcm-pspi: add Arbel NPCM8XX and full duplex support
To:     Mark Brown <broonie@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for your comment, next version I will make sure to send two
separate patches

On Thu, 21 Jul 2022 at 15:19, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 01:15:54PM +0300, Tomer Maimon wrote:
>
> > Tomer Maimon (2):
> >   spi: npcm-pspi: add full duplex support
> >   dt-binding: spi: npcm-pspi: Add npcm845 compatible
>
> It is not obvious why these are a series, they appear to be entirely
> orthogonal.  If there's no relationship between patches it's generally
> better to send them separately, that way problems with one patch won't
> hold up unrelated patches and reviewers aren't left wondering about why
> things are grouped.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Best regards,

Tomer
