Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9365066D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349908AbiDSIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiDSIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:24:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93042CE28;
        Tue, 19 Apr 2022 01:22:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t11so31259440eju.13;
        Tue, 19 Apr 2022 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDezyw7oAUdrZNSvtrlYFBOqIqBL/GY7YbeRS6TE8iQ=;
        b=bPSYUl/EaJ3C6Tecf4Uf0NbSMXV8VtkVBYgVginaVN7zmCBGBRbDERUOE+V52oJstl
         WrOho5AtwZ2he/XVu+3gjnKmNOoFrnYS50UiBw9/G/SYevyPq0uZ5NeeanfNhQnool/+
         w3VYKNcHXFx95ZT/iUcUofzDHJN/qF0YllzgwtMx3FsqC3Y8mqJwGVRwGiHYIr4XZ1hW
         JxpztDCp1KtUIodshiR4OO1t4uC009P9dS1HoiQthzrLSGFvzh8qiiTKC7IQLK8sp/LS
         0UkJADrf0kaXf261R3h/20dixv5WWZ+Rn+2t2MCyaijIfPdjVdh7xYtkDvJZg6/Q2OCi
         nmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDezyw7oAUdrZNSvtrlYFBOqIqBL/GY7YbeRS6TE8iQ=;
        b=t3GH6Z96tmQBqV+D8C/uvN6ZO68yJLBPQt/UR2EpZWEXCl3V1vmYCTZuCKlhFySO6u
         lTK9aASFZClQ5R5dNEjlwDPqBEBkldYBh+EztwhJu98E8461FSk4mMLlhhO1nnNAtqLw
         hss4/zG9MyI/pgTi610EoP9uFuaQ4NAQdcy3J1QeRp6BoHWNTjoKyYzuHiBXZG/YX6+y
         N79nvsidB01up6kylGFuTzI/pCuI7uH1+cmKy9WIIqsgzOnqaNq5MHlnK6Vl1Zti2Ohg
         SzDn14d6+bN/bLemrlfM/hrFcKfjHi+Q0DPGUb3Dz/z+vNmk2pZo0l9HVXTJO78CwYxv
         +JLw==
X-Gm-Message-State: AOAM531Y7g2+w+HmHn8rbFa/XtgwFZltnP5NBmHt6KQotQMU+3MUSyBU
        wGmWLV+BksGHajnyLxn1d+3+YaqS4nklWzIUA6s=
X-Google-Smtp-Source: ABdhPJy1BI+kV6WyWW37ji+ylkjjIWTBWFf1qwtkGDw3Mxc8DghxigPvlj/PBqptD5608TIHvHb826oYhxBwwZ8+2WI=
X-Received: by 2002:a17:906:1692:b0:6e8:d245:44a9 with SMTP id
 s18-20020a170906169200b006e8d24544a9mr12378077ejd.639.1650356528238; Tue, 19
 Apr 2022 01:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220418053202.24528-1-yu.tu@amlogic.com> <20220418053202.24528-2-yu.tu@amlogic.com>
 <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
 <d10e27ff-e674-87bd-2c98-63c7040baeb1@amlogic.com> <9af92c78-73a7-d524-182c-3ebffa69b08a@kernel.org>
In-Reply-To: <9af92c78-73a7-d524-182c-3ebffa69b08a@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Apr 2022 11:21:32 +0300
Message-ID: <CAHp75Vc87oTmJ6zVeY2mGbP8Jx_SSDtp39Uq4YhWerDUX9RdQQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Yu Tu <yu.tu@amlogic.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

On Tue, Apr 19, 2022 at 10:38 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> On 19. 04. 22, 9:29, Yu Tu wrote:
> > On 2022/4/18 20:09, Andy Shevchenko wrote:
> >> On Mon, Apr 18, 2022 at 8:50 AM Yu Tu <yu.tu@amlogic.com> wrote:

...

> >>> +struct meson_uart_data {
> >>> +       bool has_xtal_div2;
> >>
> >> I would prefer to see this as an unsigned int and with a less
> >> particular name, e.g. xtal_div would suffice.
> > I don't have a problem with your suggestion.Let's see What Neil has to say.
>
> Actually why uint provided it's a boolean value? Or do you mean to store
> the divisor directly in this member, Andy?

Yes I was thinking to provide the value and then always provide the
private data. In such cases we don't need an additional condition.

-- 
With Best Regards,
Andy Shevchenko
