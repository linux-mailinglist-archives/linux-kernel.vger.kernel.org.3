Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C7580F84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiGZJEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiGZJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:04:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745531220;
        Tue, 26 Jul 2022 02:04:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w5so4517861edd.13;
        Tue, 26 Jul 2022 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bh/cYPesfJEOYn+7FBiGNwd9ISFMUhrd+7+HujLasE0=;
        b=AQJy2By6mzaxOTs2P/InN45FoyNyM9Q2peXphRjZFWnIeJLJBQ4SKSSkV054j8mNXg
         iRm33wYjgV8TN2BADYxzPEM3xYnZ2ltKWRF8uEFqZR1zL9FFw+lJBXunS1a2+dTlvcWp
         +G11tK/IADF2pA1RiGBgHlUoPjkkpwUIUa1flkaB5XFq95/m0t/6Vv6P9MtNUbnJs8GJ
         W3slsbK20+xiP/iZwlj7B4iIu3WTEIAfcLzI1/vzJiesCcqNtdirV6V7iYUF/l69tLzF
         zV55FJeP27HaQf7+880rQBBJw25Q+YTpzd/R04+bwekCRofZ49iTfykbB7Gcb8y3iSxk
         yBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bh/cYPesfJEOYn+7FBiGNwd9ISFMUhrd+7+HujLasE0=;
        b=z8RrETtodbs0hwXh75xErVxYFHTuUohct3NNI0zq3MW45j26yHl1eDtNDq3R84moNO
         xaa85jMrqqDPX94fFRc5CRASkDUET+iLQhKU4J0Hg0vA6NqggFb4NV31Gpo2S1ZiPJBn
         CvSu7EcOqfN2yXWwTT9UEnKkQYl4pz5B3igFGSLnpnSm815QURlEc4LMNG1m+eiTqrcG
         YZsEir4Ux/jbD9JJfZPb48tI5aGcL7wgdX2kyV7KCV9BC4V20beADuQa7oAgg8hcVPev
         u6TbegGNz+jmy3K7xWPIgKWfM6zPlZNLCWHq8tYiyUZa/rvWYczewMnCZrJry8/CqLCi
         eUZQ==
X-Gm-Message-State: AJIora8uUa9wQMkd0Op34LDKnJgHva+b7zFX3+8fjKHcsq5a4ckLwuOc
        qxuI5krPQG4F2ZMk+PcYrZMbBro02SbzBSDH9JxOF0ZuYBMqkQ==
X-Google-Smtp-Source: AGRyM1ujQ9pqxXZ/M29Ddpf0EF6oY6Y7HLud/+Y+wpLR/74GNwU4SsLjJOgZyixR/x9Zc9halmsZdhJuSJ+w9rx+Ukw=
X-Received: by 2002:a05:6402:1768:b0:43b:c4b0:ffd3 with SMTP id
 da8-20020a056402176800b0043bc4b0ffd3mr16889182edb.163.1658826274412; Tue, 26
 Jul 2022 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
 <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
 <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com>
 <CACRpkdYHgD-fmt_2PWJrmyGY=AOP0Z+4jTkH=n3wJ+a0aApqcg@mail.gmail.com>
 <CAHp75Vf_aDSocdB7R6zKFwEOBRwq0w2m6GdCM-5ujKoz4bGiqQ@mail.gmail.com>
 <CACRpkdbTypeq0M8VNb491GaZdBLyE9_TFpCDn5omnTe8D+BU7w@mail.gmail.com>
 <CAHp75Vfrgkq+yTtFxjkvUMnVOHCL+VyHGXPn4BN7i6C1cA=Uuw@mail.gmail.com> <CACRpkdYHN3PPBb-=4MU1aTUxDvij_qeX4YkC9A28FQtUTvam0w@mail.gmail.com>
In-Reply-To: <CACRpkdYHN3PPBb-=4MU1aTUxDvij_qeX4YkC9A28FQtUTvam0w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 11:03:55 +0200
Message-ID: <CAHp75VeU8Jj5RjQ=8X+=F+=COoAjMgQT18DKJrSHn3972ct9Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jul 26, 2022 at 9:31 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
> > It's rather my common sense, because we have a clock here to shift a
> > register. It's kinda obvious *to me* that when we have a latch, that
> > latch shouldn't pass data on a level. Yes, there are buffers with
> > level strobe, but it's different. So, as I said, the oscilloscope can
> > finish our discussion one way or the other, but I believe it will be
> > my way ;) I will very (badly) surprised if it becomes your way. It
> > will ruin my beliefs in humanity. Not less.
>
> I think you are right Andy, I trust your judgement better than my own
> here for sure!

The true science when we put any statement in doubt and then go
step-by-step to prove it again. If this will be done successfully the
statement is correct. That said, thank you to put this in doubt, it's
appreciated!

-- 
With Best Regards,
Andy Shevchenko
