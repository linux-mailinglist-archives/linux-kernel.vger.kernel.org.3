Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7853BF8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiFBUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiFBUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58193F38
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF975613CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9202C34115
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:18:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y9AjzC6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654201097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4X9RFE7u/m9m1zpXuX5bcZxKzb6oraJPXpGtx/XO9Tc=;
        b=Y9AjzC6tvduF4Vi21xfFgKI4bVl5p17TtQ/I9S29w4kDotZyWmPfWsQnuh4LSuqUFtrXyt
        HeII2yQh3hTnY/EOe3eGc50eAKSuOjXldV++K5M71XJXa1F+EC+r1K0odYO2ymlawAUn6K
        t2nmjXtvLiWnAFsSKpIw+g5+sYCER04=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 39ede800 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 2 Jun 2022 20:18:17 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id z186so10262488ybz.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 13:18:15 -0700 (PDT)
X-Gm-Message-State: AOAM533ObSowHdurpkZ7tXUMvGh9EqTA83u3DwDLRTrq7mQo+lC5OkVN
        osKDKDSmpvuQ2b6l5dQsM1kPabxUNlj/NCMoD/k=
X-Google-Smtp-Source: ABdhPJzXi+s/TO32ednriWkXhf4jI9E5kn5aAwDIvHX4k5lPCje5vfCCQIh4nBVKCN1a4gxpRPxK/1zwVpwc0X8IEgE=
X-Received: by 2002:a25:890b:0:b0:659:b9d6:a134 with SMTP id
 e11-20020a25890b000000b00659b9d6a134mr7210862ybl.235.1654201095190; Thu, 02
 Jun 2022 13:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220602022109.780348-1-swboyd@chromium.org> <165419885870.2681883.10934677413962491141.b4-ty@arm.com>
 <CAHmME9qBOwb==N9AWSSb8VhCXANsieWi7JpiiiUMvjU2rdb5XA@mail.gmail.com> <YpkTjv6i+IlO32wM@arm.com>
In-Reply-To: <YpkTjv6i+IlO32wM@arm.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 2 Jun 2022 22:18:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9pU+t_rvQULcOwQmhU74ye3ShWi4Tgz5JdGrzW29XO+Kg@mail.gmail.com>
Message-ID: <CAHmME9pU+t_rvQULcOwQmhU74ye3ShWi4Tgz5JdGrzW29XO+Kg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Initialize jump labels before setup_machine_fdt()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 9:46 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Jason,
>
> On Thu, Jun 02, 2022 at 09:42:49PM +0200, Jason A. Donenfeld wrote:
> > On Thu, Jun 2, 2022 at 9:41 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Wed, 1 Jun 2022 19:21:09 -0700, Stephen Boyd wrote:
> > > > A static key warning splat appears during early boot on arm64 systems
> > > > that credit randomness from devicetrees that contain an "rng-seed"
> > > > property. This is because setup_machine_fdt() is called before
> > > > jump_label_init() during setup_arch(). Let's swap the order of these two
> > > > calls so that jump labels are initialized before the devicetree is
> > > > unflattened and the rng seed is credited.
> > > >
> > > > [...]
> > >
> > > Applied to arm64 (for-next/core), thanks!
> > >
> > > [1/1] arm64: Initialize jump labels before setup_machine_fdt()
> > >       https://git.kernel.org/arm64/c/73e2d827a501
> >
> > I'm not sure precisely what your for-next tag corresponds to, but just
> > FYI, this should probably go into 5.19 asap and be marked for stable@.
>
> The for-next/core branch should go in 5.19-rc1 (I'll send a pull request
> tomorrow). There's no need to cc stable since the fixed commit just went
> in (unless you mean something else by "marked for stable").

It is actually in stable, so please do CC. Otherwise I'll just forward manually.

Jason
