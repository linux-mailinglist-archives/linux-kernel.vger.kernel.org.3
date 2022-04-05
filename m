Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB14F50A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842916AbiDFBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573180AbiDESJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:09:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1620F75
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE093B81F44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3423AC385A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:07:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o0Aae4I9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649182059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xxzjqX5zjzLBo9lliEEikr0oRvt6ogdQu6U4p96NT6I=;
        b=o0Aae4I9EimBqL9ko0l77v5DNgp1H8q0wYg36+jx9FLIhp/ySjP/C0YReA4kdJE8s5VikX
        WJYyr2M3DEUsEhyaiHN3+HA8B02ei6ipoDaEx0nk/dD2Wj5p036R6PxoYSmudfiRdp8+CW
        7/H9H/tGKgq2fFISg+msCI9mkHABnTg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 26dfa0ea (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 5 Apr 2022 18:07:39 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2e5e31c34bfso295787b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:07:38 -0700 (PDT)
X-Gm-Message-State: AOAM530EkRyqILLLvabzmpCYjoHSVFYshezfap9ThflvV82d+WTLuoME
        6VFrQ2wMjhC3QU9p3WFMCmhtD+7xpORzTVV8vd8=
X-Google-Smtp-Source: ABdhPJwgMSBVflV1AO9hG8WdOm0cTEje20yVoBJYN/+T+2YMZjd5/HTPsyBepBs5y6PkleZtjxp9htNQAFtdAPoEFNE=
X-Received: by 2002:a0d:d508:0:b0:2e5:d9ec:d668 with SMTP id
 x8-20020a0dd508000000b002e5d9ecd668mr3959503ywd.499.1649182058356; Tue, 05
 Apr 2022 11:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220405163931.1108442-1-jannh@google.com>
In-Reply-To: <20220405163931.1108442-1-jannh@google.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 5 Apr 2022 20:07:27 +0200
X-Gmail-Original-Message-ID: <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
Message-ID: <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
Subject: Re: [PATCH] random: Fix signal_pending() usage
To:     Jann Horn <jannh@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

Hi Jann,

On Tue, Apr 5, 2022 at 6:39 PM Jann Horn <jannh@google.com> wrote:
> signal_pending() checks TIF_NOTIFY_SIGNAL and TIF_SIGPENDING, which signal
> that the task should bail out of the syscall when possible.
> This is a separate concept from need_resched(), which checks
> TIF_NEED_RESCHED, signalling that the task should preempt.
>
> In particular, with the current code, the signal_pending() bailout probably
> won't work reliably.
>
> Change this to look like other functions that read lots of data, such as
> read_zero().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Applied, thanks.

One funny aspect of the fact that signal_pending() hasn't worked right
since the genesis commit is that this has probably led to a lot of
userspace code that doesn't check the result from read() or
getrandom(), and that code has worked mostly fine.

I wonder if we should do something about that. Worth noting is that
we're no longer contending with /dev/random periodically blocking as
the "entropy runs out" nonsense. I can think of two possible changes,
which maybe aren't mutually exclusive:

1) Turn signal_pending() into fatal_signal_pending() throughout the file.
2) Rather than not checking signal_pending() for reads of length <=
256, we could not check for signal_pending() for the first 256 bytes
of any length read.

Both of these would be changing userspace behavior, so it should
probably be considered carefully. Any thoughts?

Jason
