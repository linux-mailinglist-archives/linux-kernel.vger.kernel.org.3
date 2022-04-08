Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A084F9BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiDHRgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiDHRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:36:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220C6B0AC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:34:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq30so3492671lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5GX55YGJpovI3tFOv0T1wHUO+Zd7z6zyy2KhM1F0OY=;
        b=HviJScLphHo3UkXhpCiNl1LxhvxjraJCHLTKP36TdiWQBCXsAepTfZ106az+1jbTMS
         TxcNJGW1ffdm7lvXR9Yakz6GxiyVscti8HdV21rlSjgR7kb0U0oSB4inlUhF/IZ36xad
         lulzZgxmxMAX+vX56YO5S9ErNW5Pm+FEch74I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5GX55YGJpovI3tFOv0T1wHUO+Zd7z6zyy2KhM1F0OY=;
        b=HXLC4Qb+PLrze0Zes0cjOKA68kS/Lc8tY0Knrn+J9yTSFwd+U6oBUrlWoe7u8yRJkR
         NzaN1sCtHgtviJsyLB1GnTI/2q1Q+fBeKDV0oD3iPUB2Hwsco2Jllr8OzBoqyETaeMdv
         E38x91LwgLtZIVJAYTb7G5DuCy6pb8//5jbx54UuSfdhBZA/QrTIuQjv8+k0YXsTtNy+
         MEK4cRxbiQ94TNaL8xV7b425nSiMHbS+6iSOVv+PdGXhGYgKJpFRuDvYktVhL9dTK5dU
         aFlpvdMefppzEOASncdEtFTtl+6fKA6hUMtjaZ5SMyVYHW0/gk2pLQUquojlox09Lcri
         uH1A==
X-Gm-Message-State: AOAM530nLdEFltNWSqyLLVlEB3m54qXLkNRQk7U8uSHeAK0W1WqMBd4G
        wNh9f/pdbMzqVhJgNitIZAGc6NXp8YfcZPmE
X-Google-Smtp-Source: ABdhPJw0/dfydhg8LprziYR6HxSjk71ED8OZ01hjavp7/agrjNaAYYxezQpnKhtJxNy39L/RILnTeA==
X-Received: by 2002:a05:6512:10ce:b0:44a:3f13:9876 with SMTP id k14-20020a05651210ce00b0044a3f139876mr12813247lfg.585.1649439254598;
        Fri, 08 Apr 2022 10:34:14 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id i6-20020a198c46000000b0044424910c94sm2514581lfj.113.2022.04.08.10.34.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 10:34:10 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bq30so3492311lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:34:09 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr12805819lfh.687.1649439249623; Fri, 08
 Apr 2022 10:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220407161745.7d6754b3@gandalf.local.home> <87pmlrkgi3.ffs@tglx>
In-Reply-To: <87pmlrkgi3.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Apr 2022 07:33:53 -1000
X-Gmail-Original-Message-ID: <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
Message-ID: <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:37 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> So this would become:
>
> -       BUG_ON(!timer->function);
> +       if (WARN_ON(!timer->function))
> +               return -EBROKEN;

Yes. But please make it a WARN_ON_ONCE(), just on basic principles. I
can't imagine this happening a lot, but at the same time I don't think
there's any reason _not_ to just always use WARN_ON_ONCE() for these
kinds of "serious bug, but should never happen" situations.

Because we don't want some "user can trigger this and spam the logs"
situation either.

That said, I would actually prefer a name-change: instead of making
this about "del_timer_free()", can we please just make this about it
being "final". Or maybe "del_timer_cancel()" or something like that?

Because the actual _freeing_ will obviously happen later, and the
function does nothing of the sort. In fact, there may be situations
where you don't free it at all, but just want to be in the situation
where you want to make sure there are no pending timers until after
you explicitly re-arm it, even if the timer would otherwise be
self-arming.

(That use-case would actually mean removing the WARN_ON_ONCE(), but I
think that would be a "future use" issue, I'm *not* suggesting it not
be done initially).

I also suspect that 99% of all del_timer_sync() users actually want
that kind of explicit "del_timer_final()" behavior. Some may not
_need_ it (because their re-arming already checks for "have I shut
down?"), but I have this suspicion that we could convert a lot - maybe
all - of the current del_timer_sync() users to this and try to see if
we could just make it the rule.

And then we could actually maybe start removing the explicit "shut
down timer" code. See for example "work->canceling" logic for
kthreads, which now does double duty (it disables re-arming the timer,
_and_ it does some "double cancel work avoidance")

              Linus
