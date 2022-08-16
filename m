Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54764595486
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiHPIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiHPIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:05:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119F15817E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:27:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w19so16938190ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8GCiBPOuQM/bTY94OlYfkl/LuAf0jjQOGAAIwdS74Fg=;
        b=JisZo1jwcqMFxEogkyBSj7CD2OQejIZwVaBZLDUMPXyd1/XDJk4yhm5S4XaUclV41a
         DNf6C3jtGn/ICcktl7kKvB8oEvCJEthJjCnq/oKtpHE4qJRvd1ePCf/5cpTiwt6ADx8y
         6ZKi3THb4uQY/A2F+hAzzTdYwLtU3q7b8PgG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8GCiBPOuQM/bTY94OlYfkl/LuAf0jjQOGAAIwdS74Fg=;
        b=rT6oKIG7Y9FqULkbOIBBmWYOZAWZAsXrdxIUYYPSbQ0YxPlcJEU/REFoidu0suqXD4
         +d5aR5KR4ExT/fweJveR/eg6TLjXz+v2nunweyWhKKwvMFP6K/0UhCj16dvKeAGQdNeu
         w4RzePItV9JVJ9xIIqiVMrhn3+RQfI/E6qJVMt4LqU6aNW5AqYCEezihi0wsQ33fQb67
         ou6S/BRckjr5z9hsJoB9N4nYbRJ9ofeGygEejB8gbUCugV4hHQs9GEECa5lG8dZoozpN
         bEQEFAcVrg8Lj2d7G3kZE36/EZoE7epq5r1nLNIX1YfYzIG7oC25Y9QjVlsiPb5LvZMB
         dE+A==
X-Gm-Message-State: ACgBeo2jTLZcM4v2yshTzuxuRiI87eFSP7hRyKlHIqim8JaWN542KqKV
        ZfSsUkOmRknyqM7wfkD9goM0WoaBbrEKGSai/Io=
X-Google-Smtp-Source: AA6agR4d7RGHN5C4KHSdjnTQoT3+3YqKc5mGLI1JYAgcq7K3tcmhftkiLbTJ7DOlgGlFNEjLSur8Ww==
X-Received: by 2002:a17:907:da2:b0:731:60e4:2261 with SMTP id go34-20020a1709070da200b0073160e42261mr12256651ejc.679.1660627647834;
        Mon, 15 Aug 2022 22:27:27 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id l6-20020a056402344600b0043cbdb16fbbsm7792130edc.24.2022.08.15.22.27.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 22:27:27 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id v3so11315559wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:27:27 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr10739050wrv.97.1660627646821; Mon, 15
 Aug 2022 22:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <YvqaK3hxix9AaQBO@slm.duckdns.org> <YvsZ6vObgLaDeSZk@gondor.apana.org.au>
In-Reply-To: <YvsZ6vObgLaDeSZk@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Aug 2022 22:27:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSNiT5qJX53RHtWECsUiFq6d6VWYNAvu71ViOEan07yw@mail.gmail.com>
Message-ID: <CAHk-=wgSNiT5qJX53RHtWECsUiFq6d6VWYNAvu71ViOEan07yw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix memory ordering race in queue_work*()
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, marcan@marcan.st, peterz@infradead.org,
        jirislaby@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, oneukum@suse.com,
        roman.penyaev@profitbricks.com, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 9:15 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Please revert this as test_and_set_bit was always supposed to be
> a full memory barrier.  This is an arch bug.

Yes, the bitops are kind of strange for various legacy reasons:

 - set/clear_bit is atomic, but without a memory barrier, and need a
"smp_mb__before_atomic()" or similar for barriers

 - test_and_set/clear_bit() are atomic, _and_ are memory barriers

 - test_and_set_bit_lock and test_and_clear_bit_unlock are atomic and
_weaker_ than full memory barriers, but sufficient for locking (ie
acquire/release)

Does any of this make any sense at all? No. But those are the
documented semantics exactly because people were worried about
test_and_set_bit being used for locking, since on x86 all the atomics
are also memory barriers.

From looking at it, the asm-generic implementation is a bit
questionable, though. In particular, it does

        if (READ_ONCE(*p) & mask)
                return 1;

so it's *entirely* unordered for the "bit was already set" case.

That looks very wrong to me, since it basically means that the
test_and_set_bit() can return "bit was already set" based on an old
value - not a memory barrier at all.

So if you use "test_and_set_bit()" as some kind of "I've done my work,
now I am going to set the bit to tell people to pick it up", then that
early "bit was already set" code completely breaks it.

Now, arguably our atomic bitop semantics are very very odd, and it
might be time to revisit them. But that code looks very very buggy to
me.

The bug seems to go back to commit e986a0d6cb36 ("locking/atomics,
asm-generic/bitops/atomic.h: Rewrite using atomic_*() APIs"), and the
fix looks to be as simple as just removing that early READ_ONCE return
case (test_and_clear has the same bug).

Will?

IOW, the proper fix for this should, I think, look something like this
(whitespace mangled) thing:

   --- a/include/asm-generic/bitops/atomic.h
   +++ b/include/asm-generic/bitops/atomic.h
   @@ -39,9 +39,6 @@ arch_test_and_set_bit(
        unsigned long mask = BIT_MASK(nr);

        p += BIT_WORD(nr);
   -    if (READ_ONCE(*p) & mask)
   -            return 1;
   -
        old = arch_atomic_long_fetch_or(mask, (atomic_long_t *)p);
        return !!(old & mask);
    }
   @@ -53,9 +50,6 @@ arch_test_and_clear_bit
        unsigned long mask = BIT_MASK(nr);

        p += BIT_WORD(nr);
   -    if (!(READ_ONCE(*p) & mask))
   -            return 0;
   -
        old = arch_atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
        return !!(old & mask);
    }

but the above is not just whitespace-damaged, it's entirely untested
and based purely on me looking at that code.

            Linus
