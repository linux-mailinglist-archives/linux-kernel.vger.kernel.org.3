Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266F9522335
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348456AbiEJSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiEJSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:01:34 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F49D2218E1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:57:37 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-ee1e7362caso15094884fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7wBUuDkXrylUgE3dfWtG4eawQu5CXUS0sPJ9RaICBQ=;
        b=B4UCyH+S0164ABWu4q8bjicA4SFup87swZfHNli0S82pOBLMXAhe7oDuDg3TP7CKVI
         5GiWfTzutvWS/WiDNmMbZjYLDZp8I0sXFrw/CLcciRZlPVVdFI2/3uMqWYCh1SGhIyjb
         NHq7x3Bi0Tg0/F20tPGsU05brprIEGkhx8euGpXqrRkYsFKxl6ilScQZ4EEmiZ0S+sIi
         kYHXA8N5YnCFvMg/vXdYByN4ZyRcS3uRwqxgYb/aLDDkRp6akXiIJNBusmkiPhT4J+Ss
         6Z7brpR+N0SzP+yA7woZua6hktXdGwaMeJrrUHVYjCiDsFhU+XPmGBNeE8g5sm66MEZm
         8hPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7wBUuDkXrylUgE3dfWtG4eawQu5CXUS0sPJ9RaICBQ=;
        b=eHu2C+fTh0YqHzskdIK6tIsKFNI6n97jxq7y+oeoaartu9CWyZIb5nfk+7pdi+t0Lc
         XM0jJ/SI2lMeUyNUHL6eCnK1tXa+A8va9BZ8TVKophdL5+lZ3omzbNBRj4yO3mZ5VrFu
         RHMI6PjpJjdYRqjy2L1KDgbqwb8giaj7mHIa6vg6z8rLLS4TFWOdvnXn/Y0/GXcgY+AS
         8cT0sm1jiuN+5sMQM8AqGRsnAZbk9BQzwR/abCckdDZcQ/rAl3OJfUsXKWgNaJ6U1AUc
         GvYzlWcllCGwweKyyxsY/o9ZlWKga2BUGgXk8LHzWVm+eYgxMtPrIHrytG0NC6F7+gQ7
         Ityg==
X-Gm-Message-State: AOAM533HUa1FP0aSRpdAN/MVpvlvYKRqoySU7y4UkgeL99yFzx+uD3s6
        /Kn3UYtXcHjfzx1aLkw9T4dH/NoU9WyUnADDfMc=
X-Google-Smtp-Source: ABdhPJw9iKVuoFR3v2jRXGlYn4dlJrezxX4r/q1RgfIu2hOdt7PPeFgu1PBza0wZSjuONgwmT0Twd5r7X4ondOtIIE4=
X-Received: by 2002:a05:6870:f146:b0:db:c90:99bb with SMTP id
 l6-20020a056870f14600b000db0c9099bbmr701378oac.55.1652205456558; Tue, 10 May
 2022 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220510154750.212913-1-yury.norov@gmail.com> <20220510154750.212913-9-yury.norov@gmail.com>
In-Reply-To: <20220510154750.212913-9-yury.norov@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 10 May 2022 10:57:25 -0700
Message-ID: <CAMo8Bf+JiyKD=g00whNOYGynx_0KjC_wJtpEBCB2ynFZ3U+e_Q@mail.gmail.com>
Subject: Re: [PATCH 08/22] bitops: introduce MANY_BITS() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Tue, May 10, 2022 at 8:48 AM Yury Norov <yury.norov@gmail.com> wrote:
> arch/xtensa/kernel/traps.c and include/linux/log2.h define very similar
> functions with different behaviour. XTENSA defines IS_POW2(), and
> log2.h defines is_power_of_2(). The difference is that IS_POW2()
> considers 0 as power of 2, while is_power_of_2() - does not.

IS_POW2 is constructed this way because we know that there is at least
one non-zero bit in the value that it tests.

> This discrepancy may confuse reader. From mathematical point of view,
> 0 is not a power of 2.

If it would reduce the confusion we can add a check that the value is
non-zero in the IS_POW2 macro.

I'd really like to not introduce the local macro and just use something
standard, but I can't use is_power_of_2 in a preprocessor condition,
can I?

-- 
Thanks.
-- Max
