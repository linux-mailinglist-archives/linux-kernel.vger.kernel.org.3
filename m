Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6905573C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiGMRvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiGMRvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:51:32 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068A2D1C0;
        Wed, 13 Jul 2022 10:51:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so20522820ybr.6;
        Wed, 13 Jul 2022 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yvxn6S29978hI/T6QCXVM0v4iM3QSPq55Yrl5aDYI6c=;
        b=jnIlgLZ2fiKVP4qOrCjnBx+br4vJ+AmDf+BbxMlEqjvFesMThRdGWab3fDiIvvn2mB
         CmBxUOCxy2LqsH2wGXitO5Lfd/xlKrNOJ4OOQk0CvE/4662285ihChr5BOeODFoM0Djj
         TE1cAwEZU6cGC1W/hAkA24xyIRtxr7behpzhdScSTAeWzsJV1sS6Jx8NNufcYoq63jKO
         pGMki2J1eHtPAzKT4giZiZsud0sWt3ExHfRjMt0lCsErtHjFsp6AGxka7B8AOPetDhgd
         7YUl2ki7MQVY5/xeiiIRbA7zz3FECmqWo801qtV5C6QC7rpc1fmgRNLwBRzUUndQdpYi
         sAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yvxn6S29978hI/T6QCXVM0v4iM3QSPq55Yrl5aDYI6c=;
        b=WNXo4iJN85IHgaDmDtwrD9mVZID/3ioFpFiasBQAg/d77jodd+4AJ4rmGZxRWmdihF
         X82oCDfQXnEfY8hWuTV9K+7cPYg1qB9OoZZerr9eoEaTrRNJUqyERXr0chYrC5xgJr1L
         UlvNyOKNOlpXWl8dskAyt6dUhuAAspfOW9uFSwvWtYTALJjfmLQywiO1MAm+jVvsgQtu
         SS6GkvMYeQaU64Uh3kcfbXjgYBp0C6UGDygV7aZfX2KCIvn7nXhM7gsxHWowdbtR8gsb
         Jv+TOevDP/sjqNhFIAJCGE3+sitYz06NB6ffykUFLqgzb3ROGZXTKurmeY0FZxFpCObT
         8UYA==
X-Gm-Message-State: AJIora/E9ZHD6voTIIR6s45WvbXi94neLwhsF3GqlqWHVuiFWzrbU6o9
        yHT05cLUAMdDzvFAk43+/sKXQdkU5pwLwMtIg+f6aPovQkWwgg==
X-Google-Smtp-Source: AGRyM1tc3NLn7Lq5FqcnSNwh12uwTn1m7HqDTESwOhZ9axw2eDvlOUPo/cX8YrMrSaelLE8rqb6sZoX6+2Z9hNYexbo=
X-Received: by 2002:a25:df97:0:b0:66f:6e7c:b3c0 with SMTP id
 w145-20020a25df97000000b0066f6e7cb3c0mr4738839ybg.93.1657734690911; Wed, 13
 Jul 2022 10:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
 <20220713105910.931983-2-lewis.hanly@microchip.com> <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
 <debb6cf6-65f8-53d2-d8d7-3ed1c3d5a8c7@microchip.com>
In-Reply-To: <debb6cf6-65f8-53d2-d8d7-3ed1c3d5a8c7@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 19:50:54 +0200
Message-ID: <CAHp75VcoiCVrdEMDrDC8qVZZwYgLTdi50tBxB4BQk=tWQWyOBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
To:     Conor.Dooley@microchip.com
Cc:     Lewis.Hanly@microchip.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Marc Zyngier <maz@kernel.org>, Daire.McNamara@microchip.com
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

On Wed, Jul 13, 2022 at 7:44 PM <Conor.Dooley@microchip.com> wrote:
> On 13/07/2022 12:59, Andy Shevchenko wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe

...

> >> +#define BYTE_BOUNDARY                  0x04
> >
> > Without namespace?
>
> Does byte_boundary even need to be defined?
> is incrementing an address by 0x4 not kinda obvious on its own
> as to what it is doing?

The less magic is the better.

Btw, have you considered gpio-regmap? Can it be utilized here?

-- 
With Best Regards,
Andy Shevchenko
