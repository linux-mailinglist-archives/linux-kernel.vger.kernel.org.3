Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7169D4B3DA5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiBMVEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:04:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiBMVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:04:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596653726;
        Sun, 13 Feb 2022 13:04:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2743D612CF;
        Sun, 13 Feb 2022 21:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F76C340EF;
        Sun, 13 Feb 2022 21:04:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J5OBEqZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644786269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9tdtfUCLfjmaoUMS4eWY1oxo6gPOsu05zgNWrIceOE=;
        b=J5OBEqZnNlsAjnzrcslIJD/yqGExK2xPIXXMw+gHDmhhY16JghsNG+mhrhNdEq9qDc0MZ6
        ErHWyt8PM75w+61EsDhRZSLgYZNKNeMYHgIyQKxvIcikNcjNgeqsrqpVJOlud6DAYmO0vX
        dhzLAwiyqyJ3RlgVVVVBkvSGWJ2eKZ0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf34a3ea (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Feb 2022 21:04:29 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id l125so7483250ybl.4;
        Sun, 13 Feb 2022 13:04:28 -0800 (PST)
X-Gm-Message-State: AOAM533vCCMSJWHfKZJdgwuQmHIH0/1SrRPQb0tbLWmVe6tLz/RWo7ew
        IU2+qglVBJ+43lA0bvhlC1CQ+SenXlWsOmbPGg4=
X-Google-Smtp-Source: ABdhPJxfaSBOjrWt50+mSLSx9Kpq26jILyJbDRt2LbvscNrZfb0aVkEnsc9DzuUEKABhO8iA4gNgOgdUc4VnK89CuXY=
X-Received: by 2002:a25:dc14:: with SMTP id y20mr6542430ybe.115.1644786267702;
 Sun, 13 Feb 2022 13:04:27 -0800 (PST)
MIME-Version: 1.0
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de> <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de> <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
 <YgaZuShru2HQiFXg@linutronix.de> <CAHmME9oZMFN80M98Mt6JysPSMTJoXfKTjHuxG6BQSsC=+0z5fg@mail.gmail.com>
 <YgacTN2zHeBhWw5d@linutronix.de>
In-Reply-To: <YgacTN2zHeBhWw5d@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 22:04:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9okFEVqTM9c9fQY02UiiNBkpaZMLSYMhzHs8FqtpV1F1g@mail.gmail.com>
Message-ID: <CAHmME9okFEVqTM9c9fQY02UiiNBkpaZMLSYMhzHs8FqtpV1F1g@mail.gmail.com>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

Hey Sebastian,

On Fri, Feb 11, 2022 at 6:26 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Sure. I can do the CPU-HP notifier later one once we are done with
> everything. I acked the v7, don't see a road block.

I've been running this over the weekend and performance is generally okay.

# perf top --symbols $(objdump -t
/usr/src/linux/drivers/char/random.o|fgrep 'F .text'|awk '{print
$6}'|tr '\n' ,) -F max -g

One thing I noticed though was that add_interrupt_randomness spends
most of its time on:

    lock   xadd   %eax,0x38(%rbp)

So, as expected, those atomics really need to go. Indeed we might be
best off with the CPU hotplug notifier for setting the count back to
zero.

Do you want to prepare a patch for this? Or should I take a stab at it?

Jason
