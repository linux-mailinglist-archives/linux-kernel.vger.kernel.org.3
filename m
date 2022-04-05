Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B893F4F48C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385892AbiDEVuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572978AbiDERjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:39:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18994B8203
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:37:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so9262073lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbbKQlV6u6KKQgV3kF0cSGptF4idzq+5FojEhxitZgw=;
        b=dZ4XXEaJnpTbQNQk046zF6zDvjCUN0Cv1mS/hPtBMnKZaaN5nR3MO1fx0X2r36ErIJ
         NFjVv+WN61WB6ydyCfBXQab73AARWTP69mMuJ4Z1v/ekYSBKIDAbOp4JYqco+Bai/m9M
         xlyXw37jjONTNQfZFUJHuN1SQRQoNMyJtm2ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbbKQlV6u6KKQgV3kF0cSGptF4idzq+5FojEhxitZgw=;
        b=Rlu9kbc1rQR68RNL3QetQwsoXXK256ARxHfnUkLRWXzwdXyTg9gNntWiIqtnlE9ge/
         ug1KsMhVlWfrK4j01GBYq9bJa2jM/FmVGAurR9CZ+Sun8w4hcyZX/PXLM4XLRUi75MKO
         VXS0Abh7HoPaMebjlsq21jyFBb9P8Z+fJa6Xi5JYRu3NTdSgF1/vVBqq6dIE7EMd8RA0
         SGYmHTjgdOsW+z6dEwIK8f3H+louqPpFSaoYNTh4JwI2N75uLh0PFMlC7kgI6CkE0mDf
         X+kO7Q7D8vCdSFvx7ouJUwL9hqUhzkt7b+0HGxuyGZ+/Y7vkh8khREYHELKriHc4F0+n
         11ZA==
X-Gm-Message-State: AOAM532X9Yrya0YDuU4pWBcG/R5rWcw5DXsdH5Yw3ny2DA0HmVBsAbI+
        cNrxbtX5XqmJgSjRLD6kR0oKsJRG1V5D+/6aKJI=
X-Google-Smtp-Source: ABdhPJxiKPhnWAiroPFaSrdtxTb19hBpokrFwUJ1oDsSNyCQHxYmdRWsevCHhD9HYrvADcdJnCG4Sw==
X-Received: by 2002:a05:6512:3b0a:b0:44a:2e21:ef25 with SMTP id f10-20020a0565123b0a00b0044a2e21ef25mr3327241lfv.333.1649180243024;
        Tue, 05 Apr 2022 10:37:23 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q28-20020ac24a7c000000b0044ade90e498sm1464971lfp.144.2022.04.05.10.37.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 10:37:22 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id k21so24570264lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:37:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr3435604lfv.27.1649180241247; Tue, 05
 Apr 2022 10:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220405140906.222350-1-Jason@zx2c4.com>
In-Reply-To: <20220405140906.222350-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Apr 2022 10:37:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFSsa7ZTFOiDCpZbwQsCKdAo3KFetSpGCjusqjjcb2XA@mail.gmail.com>
Message-ID: <CAHk-=wjFSsa7ZTFOiDCpZbwQsCKdAo3KFetSpGCjusqjjcb2XA@mail.gmail.com>
Subject: Re: [PATCH] random: opportunistically initialize on /dev/urandom reads
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

On Tue, Apr 5, 2022 at 7:10 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Practically speaking, this means that at least on x86, /dev/urandom
> becomes safe. Probably other architectures with working cycle counters
> will also become safe. And architectures with slow or broken cycle
> counters at least won't be affected at all by this change.

I think this is a good change, as it's a bit pointless to warn about
uninitialized random data if we can just initialize it.

I do wonder if it wouldn't be better to perhaps move this all into
wait_for_random_bytes(), though, and add an argument to that function
for "no delay".

Because I think we should at the same time also add a warning to
wait_for_random_bytes() for the "uhhhuh, it timed out".

Right now wait_for_random_bytes() returns an error that most people
then just ignore. Including drivers/net/wireguard/cookie.c.

So instead of returning an error that nobody can do much about, how
about we move the warning code into wait_for_random_bytes()?

And make that urandom_read() call the same wait_for_random_bytes()
that random_read() calls, just with GRND_NONBLOCK as an argument?

Not a big deal. Your patch is fine by me too.

                    Linus
