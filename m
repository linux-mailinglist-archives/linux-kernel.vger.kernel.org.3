Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4957FC92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiGYJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiGYJhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:37:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD9DF1A;
        Mon, 25 Jul 2022 02:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4890AB80E2A;
        Mon, 25 Jul 2022 09:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95483C341D6;
        Mon, 25 Jul 2022 09:37:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SpfiMXzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658741856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cUpfZrsKgEGJdkkpFrCNXEnszi93Av4FpAsIC0uCa0=;
        b=SpfiMXzUOpap0aBEfAfZZi7o1TEwaCATt4xLMdF0Zred+ymrbuL+5xvQwBCk/R+ObteizU
        ScP65Bn44eIbQOpKP6FA9erfr5zVNhclTelPIeQ09uYgfHkIibo7kdbhd/QmZgO51srDdk
        ROpeJfuW2p4cPnz4Ko230z76w+vfIPs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 113134b8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Jul 2022 09:37:36 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id r3so19062561ybr.6;
        Mon, 25 Jul 2022 02:37:35 -0700 (PDT)
X-Gm-Message-State: AJIora8/hepjbDyZqICPKVbO6bqpJZ1X0uZkhTB6eBs+0l7qQbavquB/
        n9FPu8z1XHgzq5r27XNUjTU5LVGOBvgnmWaiJOw=
X-Google-Smtp-Source: AGRyM1vtoTUXGG7Jo0TmtRIDj+cf9M1nxJdYxKMZn/u+8fRh8UlxuZYJsVFy/hmuvwvzi2boh3ezXgmA1ZUhN9Iv32Y=
X-Received: by 2002:a5b:70f:0:b0:670:7f57:e46b with SMTP id
 g15-20020a5b070f000000b006707f57e46bmr7841207ybq.24.1658741853953; Mon, 25
 Jul 2022 02:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qTA90=GEr6h1GZh0CjS+6tpe5uuqkYoJVv79h0zd0w1w@mail.gmail.com>
 <20220719130207.147536-1-Jason@zx2c4.com> <Yt5gBZe9F1BE0MVF@zn.tnic>
 <Yt5hwxC1xgvA8Asw@zx2c4.com> <10561a841a7342c882aabb0fbdbfc762@AcuMS.aculab.com>
In-Reply-To: <10561a841a7342c882aabb0fbdbfc762@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 25 Jul 2022 11:37:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9p_9j_B2d1h3cKVbv=ucNAa9_grBBW_jdWa8GTbm5WpZg@mail.gmail.com>
Message-ID: <CAHmME9p_9j_B2d1h3cKVbv=ucNAa9_grBBW_jdWa8GTbm5WpZg@mail.gmail.com>
Subject: Re: [PATCH v3] random: handle archrandom with multiple longs
To:     David Laight <David.Laight@aculab.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:36 AM David Laight <David.Laight@aculab.com> wrote:
>
> ...
> > More directly, the reason we don't want to error is because the use case
> > has fallbacks meant to handle errors. The cascade looks like this
> > (quoting from the other email):
> >
> >     unsigned long array[whatever];
> >     for (i = 0; i < ARRAY_SIZE(array);) {
> >         longs = arch_get_random_seed_longs(&array[i], ARRAY_SIZE(array) - i);
> >         if (longs) {
> >             i += longs;
> >             continue;
> >         }
> >         longs = arch_get_random_longs(&array[i], ARRAY_SIZE(array) - i);
> >         if (longs) {
> >             i += longs;
> >             continue;
> >         }
> >         array[i++] = random_get_entropy();
> >     }
> >
> > It tries to get the best that it can as much as it can, but isn't going
> > to block or do anything too nuts for that.
>
> Do you really want to retry the earlier calls that returned no data?

Does the above code do that?
