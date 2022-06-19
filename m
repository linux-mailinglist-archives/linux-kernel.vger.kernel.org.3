Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B93550B3B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiFSOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiFSOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:50:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8719DB847
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:50:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s12so16713750ejx.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBpskjLAIf5dTPr6z7wJPVIk6lvAxrTtZPp1bVT75nI=;
        b=HaFjSDt8cyoRkLyikO4ia66OkqlimL+Z2xx3nOOfLBFc9y8IiEIe6zjhdZPzD9TS9n
         0FyZlX47R9V01wjuPQct6dSAGZg+Rc+CGJPPxD+n4bhz1HfYk8AhcJd7jKH9yu/c4YWr
         6IK22sDQWJTGcFFpkvCCMqyJGlBKMn84RA1/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBpskjLAIf5dTPr6z7wJPVIk6lvAxrTtZPp1bVT75nI=;
        b=63jc8WM9GVYRbB1IyJau5w53/H8K3BgEgKRX+3hwass0up1xqdSaTJxsufZjwTG/w8
         dkUrfGi/UNZs8VrtiV6nyt5JYKxosqqk1kNPo9w4dAwhltXCUbqUkduNR6VgXPelIuR5
         PYZYG8N8T7PQ9GFaV+QvZAyjMVWMYRhO9iJjcz70KGcn2kdSMkfFkYgkKnRCpRnv/jqT
         Ev+Js3rzQn5eCtH9JAUHXXVZhNXCSncfeLXpcXRjfTOK7R5JmQevfDK6PuCglpqjDA45
         ZIT0MitvT/q3tCvzv2+nhMS1uUJIchylNYz0FPjgIaX4QMZRiCx4mAVAblSRuxAYfTHD
         Lh9Q==
X-Gm-Message-State: AJIora8RLWsvADuGN0mObTDB3Sv49WXg+pnG7/OywqBMVwgEKeuopQ/3
        XcbbkExMdThkrWtG7ZrIW2gu/XCHlR4AEA==
X-Google-Smtp-Source: AGRyM1vH2IqhI8AN98giVqGxYRgwHghWGVTBjtRXU8kNsJKQH0/iI5Ampj/os3LJ7cFjWIgU7B0xqg==
X-Received: by 2002:a17:907:16a5:b0:710:7e87:465a with SMTP id hc37-20020a17090716a500b007107e87465amr17226664ejc.137.1655650249813;
        Sun, 19 Jun 2022 07:50:49 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id gc21-20020a1709072b1500b0070e01426360sm4639658ejc.91.2022.06.19.07.50.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 07:50:49 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id q9so11451755wrd.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:50:48 -0700 (PDT)
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id
 u3-20020a5d6da3000000b00219bcdd97cdmr18523619wrs.274.1655650248564; Sun, 19
 Jun 2022 07:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <165564429738.1413209.17302088152547038708.tglx@xen13> <165564429887.1413209.8729918730024457105.tglx@xen13>
In-Reply-To: <165564429887.1413209.8729918730024457105.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jun 2022 09:50:32 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgfrUdWBXA-Jx7ZC1x3wwsomou0L6niGgpRS2Hd5rQxyg@mail.gmail.com>
Message-ID: <CAHk-=wgfrUdWBXA-Jx7ZC1x3wwsomou0L6niGgpRS2Hd5rQxyg@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for 5.19-rc3
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Sun, Jun 19, 2022 at 8:12 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A RT fix for lockdep. lockdep invokes prandom_u32() to create cookies. This
> worked until prandom_u32() was switched to the real random generator, which
> takes a spinlock for extraction, which does not work on RT when invoked
> from atomic contexts. lockdep has no requirement for real random numbers
> and it turns out sched_clock() is good enough to create the cookie. That
> works everywhere and is faster.

So this is obviously fine and works ok, but I do think it highlights
that maybe that prandom change was a bad bad idea.

Even outside of RT, you might end up getting nasty locks within locks.
Not a deadlock, but a "this was just pointless".

                 Linus
