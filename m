Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC44BE123
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379015AbiBUPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379007AbiBUPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:23:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B984E1DA7C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:22:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 693A1B81216
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4585C340F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:22:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XI77mjzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645456963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cAj9BP6fU0x9iYzz4BxpCghwg4kClAZ60uzD2844BI=;
        b=XI77mjzSkvuGzRpdhnCN4WeUKQBvlMx5aaKX1uTdaH7S0YyZPUsNVXFFiy2ARl+AxyS5Ku
        1DYLJI+p5a8dkZXijY8UwY8G4CX0pzMH8HfzOTNmMOa7GHxVhMnz3ntUD5c/cXImjPY0H4
        K0rf27x/XHBve9qRsaQeRV1xrrMgS2Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bb953c46 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 15:22:43 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id bt13so35085806ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:22:43 -0800 (PST)
X-Gm-Message-State: AOAM5326jXghR5Iz9OtpGKYwVQvlhq2fNBaUxVI4XMKBLtL3jcnkLxzq
        XBM32eyQJt00FkgcPkp5Z3XvputzK5MzRqON/nE=
X-Google-Smtp-Source: ABdhPJxiXRBAhr1h7zEP/oBOPV/NaUvEU+XlPSR5TxTuL09+CrpdiRRqa7UTHTJBJw0wLqxnv3Sv9smSdRX4fETku6I=
X-Received: by 2002:a05:6902:693:b0:613:7f4f:2e63 with SMTP id
 i19-20020a056902069300b006137f4f2e63mr18234268ybt.271.1645456962794; Mon, 21
 Feb 2022 07:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20220212231022.679926-1-Jason@zx2c4.com> <20220212231022.679926-2-Jason@zx2c4.com>
 <YhMoLad2U2zJVTyo@sol.localdomain>
In-Reply-To: <YhMoLad2U2zJVTyo@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 16:22:32 +0100
X-Gmail-Original-Message-ID: <CAHmME9rie8h9J=R9UkRQgsNntRKNqwqbQx=LY8wiOS0V-WYV_A@mail.gmail.com>
Message-ID: <CAHmME9rie8h9J=R9UkRQgsNntRKNqwqbQx=LY8wiOS0V-WYV_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] random: unify early init crng load accounting
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Mon, Feb 21, 2022 at 6:50 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Feb 13, 2022 at 12:10:20AM +0100, Jason A. Donenfeld wrote:
> > -static size_t crng_fast_load(const void *cp, size_t len)
> > +static size_t crng_pre_init_inject(const void *cp, size_t len,
> > +                                bool fast, bool account)
>
> This would be a good chance to rename 'cp' to something more usual, like 'in'.

I'll do that. By the way, if you feel inclined to clean up other
instances of 'cp' and other odd variable names, feel free to send a
patch devoted to that.

>
> Also, there's still a mention of "crng_{fast,slow}_load" in crng_make_state().

Nice catch, will fix.

>
> > +     const u8 *src = cp;
> > +
> > +     if (fast) {
> > +             if (!spin_trylock_irqsave(&base_crng.lock, flags))
> > +                     return 0;
> > +     } else
> > +             spin_lock_irqsave(&base_crng.lock, flags);
>
> Nit: the kernel coding style requires braces around the else clause here.

Not the biggest fan of this one, but will do.

Jason
