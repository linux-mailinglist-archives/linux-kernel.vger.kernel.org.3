Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9971650E3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiDYPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiDYPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACEBC8E;
        Mon, 25 Apr 2022 08:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D6F960AEC;
        Mon, 25 Apr 2022 15:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B13C385A7;
        Mon, 25 Apr 2022 15:03:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FmlRDvmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650898982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRG2KHeOyDhcUmVlkf7s8JUrvKt8qVlfa0xo+V7Zi+4=;
        b=FmlRDvmVWhzLXhqsNjg6ICBQOautm7yeN+whkRHB+yIdFQ1VdhHUaQB5JtALIZG+9SF3O9
        J/uT5NnFu9NsR5hvOQB47KceJtYgct192LdP31FZ6IEfuVbBUTB8eMVvido1YB0l2QpCHj
        sn/y9Qn1H8mHxXpgEVnTNWBGNY56UbU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6854621e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 15:03:01 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f7d19cac0bso44552677b3.13;
        Mon, 25 Apr 2022 08:03:01 -0700 (PDT)
X-Gm-Message-State: AOAM532LaL7aMsUhIZcomVCQrzso4tjZme0mD+h8+MxQM2fwiKmTtGXO
        SxNMmR2zmvXRbdqhPf0SEwg5n6bJM7SbI9o4JiM=
X-Google-Smtp-Source: ABdhPJwRBkzycZNtw+Xpgw+TUn2gCHD/52y23ZaBb64ec3dvvERDUW8hwIJ64xGWlSDPyjvcqUgcHuAr8LcjyaS7fTE=
X-Received: by 2002:a81:515:0:b0:2f7:f0f8:b521 with SMTP id
 21-20020a810515000000b002f7f0f8b521mr3983397ywf.2.1650898980131; Mon, 25 Apr
 2022 08:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220423212623.1957011-9-Jason@zx2c4.com> <mhng-57e67f41-bbc5-437c-b4cd-c6f5f9924a67@palmer-mbp2014>
In-Reply-To: <mhng-57e67f41-bbc5-437c-b4cd-c6f5f9924a67@palmer-mbp2014>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 25 Apr 2022 17:02:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9qosSq+3RYtBCMiS6yCaiZcJtaBW=8StMTACEkr3hVSow@mail.gmail.com>
Message-ID: <CAHmME9qosSq+3RYtBCMiS6yCaiZcJtaBW=8StMTACEkr3hVSow@mail.gmail.com>
Subject: Re: [PATCH v6 08/17] riscv: use fallback for random_get_entropy()
 instead of zero
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>
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

Hi Palmer,

On Mon, Apr 25, 2022 at 4:55 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> Fine for me if this goes in via some other tree, but also happy to take
> it via the RISC-V tree if you'd like.

I'm going to take this series through the random.git tree, as I've got
things that build on top of it for random.c slated for 5.19.

> IMO we could just call this a
> fix, maybe
>
> Fixes: aa9887608e77 ("RISC-V: Check clint_time_val before use")
>
> (but that just brought this back, so there's likely older kernels broken
> too).  Shouldn't be breaking any real hardware, though, so no rush on my
> end.

That'd be fine with me, but it'd involve also backporting the
timekeeping patch, which adds a new API, so maybe we better err on the
side of caution with that new code.

> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks for the review.

> Makes sense: we had an architecturally-mandated timer at the time, but
> we don't any more.

That's too bad. Out of curiosity, what happened? Was that deemed too
expensive for certain types of chips that western digital wanted to
produce for their hard drives, or some really constrained use case
like that?

Jason
