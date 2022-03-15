Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139C4D9540
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbiCOH3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiCOH3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A074133A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CE9061382
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE51C36AE3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647329278;
        bh=BBSQKwJCStGgVxZ/b0r8DsMDT3TpHCwiamsVqJzOZLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e+GMEpvrRiAXJhxN628VO6L2LoQy0nVATZKUAb4cvl6w1R+oybBaBfZkl6dd2Aalb
         3Ym/t05RurpZYkhNi78Lxe7s8frsoEBAtYtcZjL9riXo7HDIvl3PdkMUEy2O6GfBrr
         Pj5xiRJ4xxNWjScG/Rlu7eXpiCtGNBkYNTtiPklfvNj9XCPz0h3H6eVn2yt9YlXtKg
         SHsk158UtoDEKyGBWkZZYf2AEeDiwUH6WVDa6KeW2rzePq8AVOUolLW1daRgiYyeGu
         CDa5yjt1ZoQJzBATDtZiMxgw8K+dIjLjC1xVmJpg3kDVDTwlBpuYpVdcB+JnhC90PR
         E0tvOqHhSWsdA==
Received: by mail-wm1-f54.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso855101wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:27:58 -0700 (PDT)
X-Gm-Message-State: AOAM532Ubd/HSds2R9MG8q6bldfe8UBNb4GnArPeqfuaVk1rCGZnbUdn
        s/FUrjWX7ZY62MfxJz3RFKlRYDFgP4rmZUteepI=
X-Google-Smtp-Source: ABdhPJwY5fuM2YMogLsZiSBR9L7pRIJRZN3MfahGBTO2tJLhtY4ovyY2yxOQHsJgRE3bQpNHgYYt+n4a+yduaqe8PdY=
X-Received: by 2002:a7b:c19a:0:b0:381:8495:9dd with SMTP id
 y26-20020a7bc19a000000b00381849509ddmr2208271wmi.33.1647329277017; Tue, 15
 Mar 2022 00:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org> <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com> <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
 <CACRpkdbxico4SDottfB9Z8PHsXKG4fNA6G0XNyuaY+LObOovuw@mail.gmail.com>
 <CAK8P3a02a-+k=ChdT_Lg=xvHYZ4WTb-Efu7aQq-yBP1Gn37TgA@mail.gmail.com> <CACRpkdbQo4nzAVTrt-UKfkOYnm=pQwaitq3TtqUmCAXS_6EnBA@mail.gmail.com>
In-Reply-To: <CACRpkdbQo4nzAVTrt-UKfkOYnm=pQwaitq3TtqUmCAXS_6EnBA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Mar 2022 08:27:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UC5sm8T7jRPUKTH-r922ZsT+5wQcknwFqAZrPQhuQNw@mail.gmail.com>
Message-ID: <CAK8P3a1UC5sm8T7jRPUKTH-r922ZsT+5wQcknwFqAZrPQhuQNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Linus Walleij <linus.walleij@linaro.org>
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
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:00 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Mar 10, 2022 at 10:23 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Thu, Mar 10, 2022 at 2:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > > Just delete these, I do have these CPU tiles around but they are so obscure
> > > and I never got around to even testing to boot them.
> >
> > Right, of course you couldn't boot test them because it has been
> > impossible to even select them in Kconfig for years.
>
> Correct, I mean never got around to the whole cycle of "let's make this
> thing boot" and then stumbling over things like that :D
>
> > I've added
> > a patch to completely remove the five v4/v5 NOMMU cores now,
> > will send that later.
>
> Excellent.
>
> > There are five more cores that are only referenced by mach-integrator
> > that are supposed to work (922T, 1020, 1020E, 1022, 1026). Have you
> > ever tested those, or should we consider removing them as well?
>
> Not the 10xx variants, but 920T and 922T I have tested and I
> still have the tiles, while my favourite tile that is usually fitted is
> ARM926EJ-S.

Ok, then I would suggest we keep 922t and 1026 (which Robin mentioned)
but remove the others (1020,1020e, 1022).

     Arnd
