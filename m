Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888A51AE79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiEDT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbiEDT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:59:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0062E8;
        Wed,  4 May 2022 12:56:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p18so2906541edr.7;
        Wed, 04 May 2022 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHzN/II1cqKG6Dxy3ToqBfroY6UHh0zWNL0Co+wZqsU=;
        b=XHO7iOq/qqQ21uCUaSIAHFkG/WcxpiKguZE7NqeR4ndEtDqWMXhN9HdlAuEKQZhOZ1
         VPJ+UbojC9TuiU5u8V4uDbfAehIaGrXYoj8rIXSVOqDS0wTScuqw6Xy6xySDXb2nbg14
         6pu08x8MpTqBx/iryzQcJHl4dAlxvtzQExPy91oeGkGApKYfxiagVJ4SAl+uaZGpzxCX
         UUuA7Qc6rpfpCDyR1txQWqsZjTah861eUXNpQk3rJ34jBRvpCBujSVWc3zRP6iK/sLQe
         nqVR2O2zAPwsUpZkPNLRG/2T+3AXgE4Ehg7+8qr4hQZ8Q5xFRadXN+rbY8jLs7KQjCrM
         rQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHzN/II1cqKG6Dxy3ToqBfroY6UHh0zWNL0Co+wZqsU=;
        b=R5xxIQYDG7LTXjkXGbIzUR1maaYtkqOvdqUYWuaJm5bpYeNJK5fXsp3Owey7gAVJhN
         +pE0qUq/GhChbq9XvdhiGvkLY29rYpcbuV/GBZrvA8klCaO0wissu9XEKPJctnhzifKy
         b56U5DSAlWca/Z7PZ/2lzxjr8VpZmoe4HxAPMPgkkWwZD3gjYRH/aj4XQnYfK2VpkW9X
         U3bhz5nFAfSYWUmuOyDq31zzpHtgXKQSvw9M9WPZD2anb/shl5+Q5JnMkaf/snB2Wwm9
         8nSZ5pRGBwDPU7dv7bc+6xzHqk1edq4/UfZcMqjW9Pj37fWCGH2w3/R4f63Ch9QUZzyO
         hTbg==
X-Gm-Message-State: AOAM5319vyDZAJfOfp+6LOZUksgzUYZjFU3qcSW8rEkbHRuW7nwWo+6j
        guqOZM/y85kmij0rMBHQ4Anmtw48tZJD0OmDRRQ=
X-Google-Smtp-Source: ABdhPJzoLtDpQCHhg4vioDldJRRTCvYHn7hSBl7b9n91FwSGhv1/4alySP2hCps314zWYRH0QbPJY2cSM6YnoyJrlzQ=
X-Received: by 2002:aa7:d350:0:b0:425:e029:da56 with SMTP id
 m16-20020aa7d350000000b00425e029da56mr25311335edr.296.1651694168197; Wed, 04
 May 2022 12:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220504193439.15938-1-markuss.broks@gmail.com>
 <CAHp75VeMCiwgTFFy5vGBoWYSw4mGQU6623B1eMr7apJZF_L-kg@mail.gmail.com> <20220504195042.GA25790@duo.ucw.cz>
In-Reply-To: <20220504195042.GA25790@duo.ucw.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 21:55:32 +0200
Message-ID: <CAHp75VeBovr7FvaW3VYhoR=QN0RUSdBEAYoP8jftS30_10vsOA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Make AUX gpio pin optional for ktd2692
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, May 4, 2022 at 9:50 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > v7:
> > > - drop the MAINTAINERS part
> >
> > I'm not sure why it happened.
> >
> > 4) update MAINTAINERS.
>
> I asked for that one.
>
> If there's no other problem, I can take the series.

Ah, thanks for clarification.
As I mentioned before, it would be really nice to have a fix-patch
prepending this series. That said, this series needs to be rebased on
it.

-- 
With Best Regards,
Andy Shevchenko
