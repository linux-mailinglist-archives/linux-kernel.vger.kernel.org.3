Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043954E596A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244906AbiCWTyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiCWTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:54:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85EA7C16F;
        Wed, 23 Mar 2022 12:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95DE3B81FDB;
        Wed, 23 Mar 2022 19:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD5FC340F4;
        Wed, 23 Mar 2022 19:53:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c3/cXOFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648065196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMk8V2X3o4sbNIG5kMPoqxm240J/8B6Z9RWZ6FUqIwg=;
        b=c3/cXOFKCbip3lNmIAavx8n8ejoQB70BJNzKUErSlVm/QimujdahA44c+AGc2hQ6JvbIEv
        niHRM+AfXwYsOktOabpc8/hXUfkT3mjYa87k2qxvSm5LdCTQk9U0Pa53fy+eHmUsWbUnKe
        McYyGKTW3QxpLpjDasKTCLjw7qpKvgE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e884b0f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Mar 2022 19:53:16 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id u103so4656069ybi.9;
        Wed, 23 Mar 2022 12:53:15 -0700 (PDT)
X-Gm-Message-State: AOAM531AhFNIgNm9DR0bTEavSG4IoX1uf4lfvzJitCrNDEB8jiGspC1f
        hk/vHUL19QXisWDkphVN12LyRezKI2bmVDk7Pcc=
X-Google-Smtp-Source: ABdhPJyyILuutx5UvrpfJSTJzzIiGwfjoVodxSefOrtWkqpEvPqCRmdmo5baaODx20up+gpurhgdtNkoP5MW6qKGtEw=
X-Received: by 2002:a25:ad83:0:b0:633:abf6:5f69 with SMTP id
 z3-20020a25ad83000000b00633abf65f69mr1612956ybi.382.1648065194876; Wed, 23
 Mar 2022 12:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220322191436.110963-1-Jason@zx2c4.com> <1648009787.fah6dos6ya.none@localhost>
 <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com> <7cde489e73c8448b95a1b7bc6ed1d75b@AcuMS.aculab.com>
In-Reply-To: <7cde489e73c8448b95a1b7bc6ed1d75b@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 23 Mar 2022 13:53:03 -0600
X-Gmail-Original-Message-ID: <CAHmME9rxV-WLBCGyMRwba_8nF_onRfBi0+-xz84-HLNfee=R3Q@mail.gmail.com>
Message-ID: <CAHmME9rxV-WLBCGyMRwba_8nF_onRfBi0+-xz84-HLNfee=R3Q@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     David Laight <David.Laight@aculab.com>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sandy Harris <sandyinchina@gmail.com>
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

Hi David,

On Wed, Mar 23, 2022 at 8:01 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jason A. Donenfeld
> > Sent: 23 March 2022 04:48
> ...
> > - Plenty of things are seeding the RNG correctly, and buildroot's
> > shell script is just "doing it wrong".
> >
> > On that last point, I should reiterate that buildroot's shell script
> > still isn't actually initializing the RNG, despite what it says in its
> > echo; there's never been a way to initialize the RNG from a shell
> > script, without calling out to various special purpose ioctl-aware
> > binaries.
>
> Perhaps the very first write after boot could be assumed to
> be valid initialisation data?
> (On top of a few other tests.)

I addressed this already earlier. That approach does not work. Too
many things already pass in garbage, not expecting for it to be
credited, but just contributory. /dev/urandom writes simply has never
had the semantics one would want for credited seeding. Adding a
heuristic like this will break users.

Jason
