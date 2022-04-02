Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E624F02F3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355808AbiDBNue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355801AbiDBNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:50:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2CEA1;
        Sat,  2 Apr 2022 06:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B055B808C6;
        Sat,  2 Apr 2022 13:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C8AC340F3;
        Sat,  2 Apr 2022 13:48:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d28JnGQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648907309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgYDNU0LQiY6oGkA7JBX7Ywvm2wYE+9Kr5hdSyar1FY=;
        b=d28JnGQnNAjDqdvF6yV+SPY3luDFLVLJizwvnP2vvfCCuZoTZMV1RgPIKd+yVRWT4D0wUt
        1gsNfKVSBsgY9KGVpEVlML9M9aSPi0H2fDZO0+EPanG67VCUe+uOQOoztN1eG8frOC7QgA
        eca+VPWzaBFuhZRG+eu6Cs05KO5kqcE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ec277bcf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 2 Apr 2022 13:48:29 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2eafabbc80aso58077437b3.11;
        Sat, 02 Apr 2022 06:48:29 -0700 (PDT)
X-Gm-Message-State: AOAM530Ou8CWE+8rh98X9kKOxbScL0YDK5VjStP8RN5jgoKvNn5fgz0r
        vPzrDavWQkeVsDtOnNWS7I9ZR4Laj3noRRAbeBE=
X-Google-Smtp-Source: ABdhPJx4PUBZG9fWTmS3fDp6+Djy5WxFlwhbGEo6ocKKRYNhKoMpheI843vvlWLu9wgp8qX/jvyi3v1lXm+tqqM+9HM=
X-Received: by 2002:a81:66c3:0:b0:2eb:41cf:1202 with SMTP id
 a186-20020a8166c3000000b002eb41cf1202mr1884044ywc.396.1648907308407; Sat, 02
 Apr 2022 06:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220331150706.124075-1-Jason@zx2c4.com> <20220331152641.169301-1-Jason@zx2c4.com>
 <CACXcFm=vw6XCnO8peYH4V+sPR076O-Gav46r83+CZJ8oXM8iHA@mail.gmail.com>
In-Reply-To: <CACXcFm=vw6XCnO8peYH4V+sPR076O-Gav46r83+CZJ8oXM8iHA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 2 Apr 2022 15:48:17 +0200
X-Gmail-Original-Message-ID: <CAHmME9qd_jHB-7FHNqNhZC1AQBAZjUjQAYwqcLn3sz-FXoEAFw@mail.gmail.com>
Message-ID: <CAHmME9qd_jHB-7FHNqNhZC1AQBAZjUjQAYwqcLn3sz-FXoEAFw@mail.gmail.com>
Subject: Re: [PATCH v2] random: mix build-time latent entropy into pool at init
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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

Hi Sandy,

On Sat, Apr 2, 2022 at 6:45 AM Sandy Harris <sandyinchina@gmail.com> wrote:
> > In switching to using a hash function, this required us to
> > specifically initialize it to some specific state,
>
> Hash functions do not require that. Any such function must
> work correctly with a new input block and a more-or-less
> random state from hashing previous blocks.

Well yes and no. Strictly no in the sense that blake2s_state has a few
book-keeping variables, which we probably benefit in terms of caching
from having next to the other state variables. Almost yes in the sense
that in the ideal model, the hash state can become _anything_ so
initializing it to random might be okay. But in practice, maybe not,
because at the moment the latent entropy plugin is actually expanding
a 64-bit seed with a basic LFSR, rather than supplying more uniformly
random bytes (I have a patch out for that now). These details might
matter, so rather than tempting fate, just calling blake2s_update the
way the hash function is intended to be used seems a lot more cautious
than poking at the function's innards unnecessarily.

Jason
