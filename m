Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC053BF05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiFBTnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiFBTnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A42E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0930617C4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04714C385A5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:43:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a1Esxugg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654198982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83SdYmk3U61Aj+CbfcRuFsqRAJiVBcI1MBf6jt14hV4=;
        b=a1EsxuggogeBBcOkOPsSyXOkxEpbqRYHoK1osBYXagFMgswEII3gfkU16CQ7gsPuSC0Sck
        WW0wwaKta8m3dEfXr/sYmJB74PZEuQLjrkVAebQRhoyu/gXrEgDfBL82lmZ2kRHdHV0oqh
        X5Y6ObzLALVlsoxxSqqXIoB2e5hmQ50=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2a3a6932 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 2 Jun 2022 19:43:02 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id g4so10055247ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:43:01 -0700 (PDT)
X-Gm-Message-State: AOAM530OFjl6wBhDwnu/fraxlinilA3N3sBSjdrOWPaeD3ED1IQY29yJ
        eVujIJSoYnR8DVYxRUu4NfYl6g32cW4iKYrXaUg=
X-Google-Smtp-Source: ABdhPJw5Cq823Cb32SVFmeD53s1eU3Rhxhl1GctOd4kRnWxPpJtExToAx55KKweaEe/OxLwDh4VDKrpwbHW+BMCC/hY=
X-Received: by 2002:a25:83c2:0:b0:65c:bc75:800b with SMTP id
 v2-20020a2583c2000000b0065cbc75800bmr7224464ybm.373.1654198979830; Thu, 02
 Jun 2022 12:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220602022109.780348-1-swboyd@chromium.org> <165419885870.2681883.10934677413962491141.b4-ty@arm.com>
In-Reply-To: <165419885870.2681883.10934677413962491141.b4-ty@arm.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 2 Jun 2022 21:42:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9qBOwb==N9AWSSb8VhCXANsieWi7JpiiiUMvjU2rdb5XA@mail.gmail.com>
Message-ID: <CAHmME9qBOwb==N9AWSSb8VhCXANsieWi7JpiiiUMvjU2rdb5XA@mail.gmail.com>
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

Hi Catalin,

On Thu, Jun 2, 2022 at 9:41 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, 1 Jun 2022 19:21:09 -0700, Stephen Boyd wrote:
> > A static key warning splat appears during early boot on arm64 systems
> > that credit randomness from devicetrees that contain an "rng-seed"
> > property. This is because setup_machine_fdt() is called before
> > jump_label_init() during setup_arch(). Let's swap the order of these two
> > calls so that jump labels are initialized before the devicetree is
> > unflattened and the rng seed is credited.
> >
> > [...]
>
> Applied to arm64 (for-next/core), thanks!
>
> [1/1] arm64: Initialize jump labels before setup_machine_fdt()
>       https://git.kernel.org/arm64/c/73e2d827a501

I'm not sure precisely what your for-next tag corresponds to, but just
FYI, this should probably go into 5.19 asap and be marked for stable@.

Jason
