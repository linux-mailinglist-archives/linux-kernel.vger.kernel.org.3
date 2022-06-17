Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A954FAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382431AbiFQQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiFQQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:02:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B762C2;
        Fri, 17 Jun 2022 09:02:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so6743586edm.13;
        Fri, 17 Jun 2022 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8r+G/RXXRoAeZWyzjn9RC7wIGZ16VtLdIGVvQCGaxe0=;
        b=gBG0OWRD+3CvRnekwMCxVXUOzfxJOinlCtJUV2KfH04rXZcpm8CLjLXL0B0VYvr9nQ
         lM4QHde7gyf7Grl061DC83F2z1Tn0psO7z5InnQtyrglRPpDKdvpnj3iTEzd3siBbNCU
         wWS7wHmPki2IP6WuznKo9sTEp/B3F1T3e+eDrSbGdPFr/im8at4m2rES8yPnJdA7Fc4Z
         II/OJigvxvJV1K/gVBP+TcMDGXdyFJdZZLUdiWvwNBQ6w/Wi/xWzq/tDzxJX6fRR9tfk
         hxsjTQwywcUCvKBTBZCNFOGh6mo1wT40EoA7OcEe6TRTpQBXWOzDOh24aeGVa7Waqhme
         8exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8r+G/RXXRoAeZWyzjn9RC7wIGZ16VtLdIGVvQCGaxe0=;
        b=3YGQxQ9hFiXpUNuG/5+XQsyRZQnFMxHCx8bQY/LBNVrMxEikDuNQAdDaXMHaOuWlur
         UVVhcBkWB3sA9SZEPXwnk2abFIg/pgBbPgOU1rE9mVmRBtxWAQAVIgoCjdytLrcIWB7W
         8z9lDdiBZGSbWgqQI73f9YIsVGTQ/HBCtheVmi4c9xlce0/W9Ol7ryQoaFm2W8vOhwhJ
         WFduVV2+aXMnDDe5Asr2WC/WJwz0vCKCnfUp01QIjKqQoBmpRFZqeGhwwAE3yFRXXAuT
         sAW/85pgiUEPiS40OtauFj8AAO4jWynlW4o9CxCDxljDNCydbULV9BvN4RbbwoI/1VUK
         f4aw==
X-Gm-Message-State: AJIora+t7us1V66+90PtASlVCfnVyn5BvWjsNWIFC6SqMq8NvIg1v8yi
        REduPLztWRi6EF4erfDFGqTLAJEu0SFedYja/Oo=
X-Google-Smtp-Source: AGRyM1ssQB7IsQPFnBpZ3gTIbnEzw8LlJzI9C/w2e/SuW4VVN/St+Irhre9f8yhium/nrBdcyhWdznuQVwYZqPgmM5E=
X-Received: by 2002:a50:9f6a:0:b0:435:5804:e07 with SMTP id
 b97-20020a509f6a000000b0043558040e07mr8365919edf.178.1655481757554; Fri, 17
 Jun 2022 09:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220617051921.3801832-1-srinivas.neeli@xilinx.com>
In-Reply-To: <20220617051921.3801832-1-srinivas.neeli@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jun 2022 18:02:00 +0200
Message-ID: <CAHp75VfREw2F3bXDeS8O1jm0r1Ksj923jZDne9UE5vaHM+V17w@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-xilinx: Check return value of of_property_read_u32
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        neelisrinivas18@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        srinivas.neeli@amd.com, Srinivas Goud <sgoud@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
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

On Fri, Jun 17, 2022 at 7:20 AM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:
>
> In five different instances the return value of "of_property_read_u32"
> API was neither captured nor checked.
>
> Fixed it by capturing the return value and then checking for any error.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Addresses-Coverity: "check_return"

I think the best course of action here is to go and fix Coverity while
marking these as false positives.

To the idea of castings -- this is not good style and (many?)
maintainers in kernel do not accept such "workaround" for fixing
broken tool.

That said, NAK to the patch in any of its forms.

-- 
With Best Regards,
Andy Shevchenko
