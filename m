Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C8B5819F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiGZStB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiGZStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:49:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88C33A2A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:48:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id os14so27806165ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwELNw3bbB2ZTWei2T0S37d+u0ui6eyIvPEpJ5jDhuw=;
        b=XzGEjBs3MikzPwuYHuHE3qiHAlmb4j5pOP3nnt29C6wiAyL/qpvfTYDvKHu/Llckz1
         jbtcPlykMfK4izgPyciBBXReyCsRqVVoUUNaEycicFg4QInSN6CBJawsjIlv8ea/JDpa
         7KetQn2SfYfGtNNJ7wfzYOdTQ0mBaSMkqFtVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwELNw3bbB2ZTWei2T0S37d+u0ui6eyIvPEpJ5jDhuw=;
        b=JLAloCclFnC5UKZwEMAY4PzuZpoYn8aHuOcOkoJEjwuWnveS5628udZx8qGnZCpbVb
         j5BB+U5ws3leIiZe3J408hLC5JW4veDflkxh/7md9ByDAW05Scp1pOBSPSRxLkJ6V5f3
         IfVdbPHDPEuL+HtAHHTuxJgP71cRKcw8cFrhPfQPIK/xE4Y+E26nx9bbiuxjWK2y/1Ys
         kYyal2FJC0J2kA1dW4sGzFyxkqbc96Cdup0skXs4I3uISmSuh8tLPo+v10AIDDldKEF2
         j3pVmU24JRu/eXgwATerbYgNeG2w+u4lhlk39G/dbaAS3kwbG6SlEysHKYB6SGQZZt4q
         fLdA==
X-Gm-Message-State: AJIora/WfN3s6LkM4OEFwAq/5Aaghgq/sVnYI8/QUCsY9b225vH3TFgW
        iJIcbIUih57SDzK4KUOenZosau2t9IyBcmeM
X-Google-Smtp-Source: AGRyM1sFVjE60aNBD9sdaaWGxh2C5eDGFFsSYUT7hcY03R2ovqbW2+qCwUqqOua/i68zNzEM4hMkuA==
X-Received: by 2002:a17:907:e91:b0:72f:d76:b22c with SMTP id ho17-20020a1709070e9100b0072f0d76b22cmr14536398ejc.364.1658861336747;
        Tue, 26 Jul 2022 11:48:56 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id j4-20020a056402238400b0043bdd401cafsm6144276eda.47.2022.07.26.11.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:48:56 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h9so21398136wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:48:56 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr11795743wrh.193.1658861335710; Tue, 26
 Jul 2022 11:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220726154407.3464776-1-yury.norov@gmail.com> <20220726183519.GA931941@roeck-us.net>
In-Reply-To: <20220726183519.GA931941@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jul 2022 11:48:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDk4iug---FSTxbbNX_JDh4gAXCL4PhZ0JGKuu00SMmg@mail.gmail.com>
Message-ID: <CAHk-=wjDk4iug---FSTxbbNX_JDh4gAXCL4PhZ0JGKuu00SMmg@mail.gmail.com>
Subject: Re: [PATCH] arm: drop arch implementation for find_bit() functions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:35 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> bitmap unit tests succeed, and the KFENCE report is no longer seen
> even after 65 retries (previously it reproduced easily with 5-15
> retries).
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Russell, how do you want to handle this?

It's not exactly super-critical, in that this whole issue with the
bitmap overrun probably not happening in real life outside of the
tests. And even when it does happen, it's probably just going to be a
read that nobody cares about (ie very unlikely to hit something like a
"next-page-is-not-mapped" situation).

But it *could* trigger those kinds of things, I guess.

I'll happily take the patch myself as-is, it seems very safe
(considering that all architectures except for 32-bit arm and m68k
already use the generic code).

But as you pointed out, the arm code does the byte-at-a-time thing,
which *could* hide some other arm code using unaligned bitmaps.

Of course, if you actually have unaligned bitmaps (and one of the arm
chips that don't handle unaligned accesses), you'd then probably have
been bitten by just the *regular* bitmap functions doing word accesses
anyway, so I don't really see that as being an issue - I don't expect
anybody would only use the find_bit() functions, and not use the
regular set/clear/test_bit() functions before/after.

Anyway, the patch looks very safe and fixes a known - but likely
*very* minor - issue.

Just let me know how you want to handle this:

 (a) I'll take it directly on your say-so

 (b) you have other things pending anyway and will apply it and send
me a pull request

 (c) you are nervous enough that you prefer leaving this for the next
merge window

I don't personally really see (c) as an issue, but I don't feel
strongly enough about it to really mind one way or another, so
whatever you feel is simplest and works best for you...

                         Linus
