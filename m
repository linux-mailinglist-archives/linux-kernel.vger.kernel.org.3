Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7493E4D8FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbiCNXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbiCNXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:01:31 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8963A700
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:00:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u61so33832428ybi.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtDcT5z/zOjELlEB+1PPduUIkALhPYNoY9W8GQomtbs=;
        b=PyO/XVliY6V4NENnF2DcL84cE5yDo9pbbhfOtfq/cK25CY6sBZkEJvC/nhGgx8u5RM
         DoYksyhQqsu6K5UgB3vr6o+dgRWiItLa2eBGQx0GmIISMy22T1LlpaZf4VN8EmH7l8if
         5GcGvHi+9DFANUMaA7WfN+g7Od/4ku35n/MacF/gFqq7QoZ2rGu/SewE28Lz8JKxY1xl
         cjE8846iiL5xwkcZJpc50ZIbSIIK1DcYaFIkJtsslhCWreQhXAXWmnZu+JNJerdaOttA
         i0m/vAjQEg0Ehi3Cs5PR/QvD7LeQMfE2OZwmYnLMc5B9gYU2BLQxhROfOv4UD4C3jm9F
         gHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtDcT5z/zOjELlEB+1PPduUIkALhPYNoY9W8GQomtbs=;
        b=y/cf0eSTNpfm9DMw4NbYSRprImmqnBtj1CLEuuSJF0pBTj9q3p5Yfxqn8iMEuQfeXb
         09kLf1pJpzsHi3fSpFLQ/CsSz/2hIbmL5G8JahuahjZ3Z0sRDbh1shT8MtAaAVPAJiqf
         k/BylDjG39CV+iSr0ZUvgYalEgSF+qIH/tm7mqfiUKB8YwbazfodwlOnDD+NRgt0gcHg
         Og8ahXRJb2rmX/LbTyp5BiAE8EF46HEUO5zMjyX9WNSasSgiXSjJpN1lIozyKX3Qi/cm
         GPYmXxK6W10+DBmfY/06veLLR0jnYNQa4mvMQqOdR0sk/1AwkNcabI4tLEtNjgAi4a23
         x87A==
X-Gm-Message-State: AOAM531UARt5erpyF83ReHkMBbyZyhb75WtrysH0RPNO2jPEo7EyHPsJ
        bGmRA1w/WIEEZwU801tHYjgegP+UjaoJdCP+tAA9kg==
X-Google-Smtp-Source: ABdhPJxBywpdgyKw2iiV/IBhtzBu9ILRrt7epLS26WRGCxr0bE8vshhfJQFLs4JkzgjEWhASPOS2Jqdn6UeCcQKFNzE=
X-Received: by 2002:a25:e710:0:b0:633:67d3:7264 with SMTP id
 e16-20020a25e710000000b0063367d37264mr3154733ybh.291.1647298820471; Mon, 14
 Mar 2022 16:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org> <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com> <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
 <CACRpkdbxico4SDottfB9Z8PHsXKG4fNA6G0XNyuaY+LObOovuw@mail.gmail.com> <CAK8P3a02a-+k=ChdT_Lg=xvHYZ4WTb-Efu7aQq-yBP1Gn37TgA@mail.gmail.com>
In-Reply-To: <CAK8P3a02a-+k=ChdT_Lg=xvHYZ4WTb-Efu7aQq-yBP1Gn37TgA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 00:00:09 +0100
Message-ID: <CACRpkdbQo4nzAVTrt-UKfkOYnm=pQwaitq3TtqUmCAXS_6EnBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:23 AM Arnd Bergmann <arnd@kernel.org> wrote:
> On Thu, Mar 10, 2022 at 2:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > Just delete these, I do have these CPU tiles around but they are so obscure
> > and I never got around to even testing to boot them.
>
> Right, of course you couldn't boot test them because it has been
> impossible to even select them in Kconfig for years.

Correct, I mean never got around to the whole cycle of "let's make this
thing boot" and then stumbling over things like that :D

> I've added
> a patch to completely remove the five v4/v5 NOMMU cores now,
> will send that later.

Excellent.

> There are five more cores that are only referenced by mach-integrator
> that are supposed to work (922T, 1020, 1020E, 1022, 1026). Have you
> ever tested those, or should we consider removing them as well?

Not the 10xx variants, but 920T and 922T I have tested and I
still have the tiles, while my favourite tile that is usually fitted is
ARM926EJ-S.

Yours,
Linus Walleij
