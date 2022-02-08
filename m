Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408C4ACD95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbiBHBHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbiBHALK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:11:10 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF7FC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:11:09 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p5so44899751ybd.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzVf95jt9Q8X/Ra0n/mrM0IlQCfTHamEzF56FJSu1k4=;
        b=Hac8v4TTt2SQ4hjUwDGtWfK7fRdekCOu2cRFwefzFpm9OlbrD0yQw+21oaUoqEiheh
         rQWxUdL+jeSocJkvGBzMR9yXBTic6I/9PLuh1a2wqh2HEtLM6ZpFtZny3rU44280Qw1F
         sDJ5gsHrI9JcedE34z6i72q0p0vEs5QEORBqQIgYVqukLsTLSsRfhfDLB5NDLxFFHtvG
         DmU2D/wClFeKS6xZwG9I3mjXImZ8F85qS/vYksQ5xGMUNRFAHlyo9t6rWkhOAB0u8/J2
         SnjQrD6b1+uuG7FR2mGbAYRrLNiwQGxtwQxTJMe7IFpDzUMbNBPndIg1kLsgAjCoCpRL
         uDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzVf95jt9Q8X/Ra0n/mrM0IlQCfTHamEzF56FJSu1k4=;
        b=Pb2ja9/YRZAZEFxrmA7bSzOGT0ZGblNa2PLCOZt/ePjvQ3kyXwpfJkC9n5X0VI6dA2
         1vC4tHQrq49tsgM5qfpK/UCvOceZacCHiHxAizbbiDOEjy+eTk5p1pje17dVgW+9hPru
         H/sDLM3wevJmxZ3ACOOFWeNym6+Xvqr3ZvN0dYIywq6rK68479Qxja4E3WYBMUZbzO6Z
         uc2INQeqwuoJ2KNlr8Px90fiI3IlkBs1RPVIGOVovMYYA3HMXg0KcXV4Nw0JrIWCNu3d
         hTfclMnvE9Ur9fgE2yk2/adSgFoav0u35FEo4JN0t4toBbDHqY/fAoZWSL3LwO26ttvi
         kRhw==
X-Gm-Message-State: AOAM531LXcOHVYQoFIu2Bqs1NXxPMwI9ZhtsqmfbJIvjidrd32qVEoRv
        kSS1y+3x8U1q+jElMt+ROqmhJIRbYXpxhzD3zPnRHA==
X-Google-Smtp-Source: ABdhPJzV/lpNRtplRw1CaUDDK2Gq2nnv2HEyGcDe4Ret09Fj0j7bjUT++W9fszNJkrNhkZJ4PgHUUI06TYLj0M05Ey4=
X-Received: by 2002:a25:610e:: with SMTP id v14mr2481774ybb.722.1644279068498;
 Mon, 07 Feb 2022 16:11:08 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com> <CAG48ez17i5ObZ62BtDFF5UguO-n_0qvcvrsqVp4auvq2R4NPTA@mail.gmail.com>
In-Reply-To: <CAG48ez17i5ObZ62BtDFF5UguO-n_0qvcvrsqVp4auvq2R4NPTA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Feb 2022 01:10:57 +0100
Message-ID: <CANpmjNPVJP_Y6TjsHAR9dm=RpjY5V-=O5u7iP61dBjH2ePGrRw@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     Jann Horn <jannh@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>, pmenzel@molgen.mpg.de,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 at 22:49, Jann Horn <jannh@google.com> wrote:
> +KCSAN people
>
> On Mon, Feb 7, 2022 at 7:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Thanks for the report. I assume that this is actually an old bug. Do
> > you have a vmlinux or a random.o from this kernel you could send me to
> > double check? Without that, my best guess, which I'd say I have
> > relatively high confidence about,
>
> Maybe KCSAN should go through the same instruction-bytes-dumping thing
> as normal BUG() does? That might be helpful for cases like this...

A BUG() on x86 actually generates a ud2, and somewhere along the way
it uses pt_regs in show_opcodes(). Generating KCSAN stack traces is
very different, and there's no pt_regs because it's going through
compiler instrumentation.

In general, I wouldn't spend much time on one-sided non-symbolized
KCSAN reports, unless it's obvious what's going on. I've been thinking
of making CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n the default, because
the one-sided race reports are not very useful. We need to see what
we're racing against. With the normal reports where both threads'
stack traces are shown it's usually much easier to narrow down what's
happening even in the absence of symbolized stack traces.

My suggestion would be to try and get a normal "2-sided" data race report.

I also haven't found something similar in my pile of data race reports
sitting in syzbot moderation.

Jason - if you're interested in KCSAN data race reports in some
subsystems you maintain (I see a few in Wireguard), let me know, and
I'll release them from syzbot's moderation queue. The way we're trying
to do it with KCSAN is that we pre-moderate and ask maintainers if
they're happy to be forwarded all reports that syzbot finds (currently
some Networking and RCU, though the latter finds almost all data races
via KCSAN-enabled rcutorture).

Thanks,
-- Marco
