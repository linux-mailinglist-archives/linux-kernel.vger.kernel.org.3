Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693DD4B4D66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbiBNKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:54:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349339AbiBNKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:54:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A789CEB;
        Mon, 14 Feb 2022 02:19:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC3ECB80DFE;
        Mon, 14 Feb 2022 10:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C731C340F4;
        Mon, 14 Feb 2022 10:19:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KPM49c59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644833963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXyOZa2DqzfFgsJ7rFwjQ8rxXT43Pi8c1Wt/XancfYs=;
        b=KPM49c599dfFLb0/tVyRbdwBPfufgAjgcs9YCxTY6pJ4Ua0ixL/I4y01cB0wB3WfVhU/oj
        em8TdVNok5zbKoLwNCTwhlAB3tx7OpBXFKvrnl+/3YdKNllGVsfznHNRMiT1oe5MU7Gth1
        ZXVFNaVpRprBSRB1Thge6sQsOZym4ag=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c0d3dcc9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 10:19:22 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id l125so11414997ybl.4;
        Mon, 14 Feb 2022 02:19:22 -0800 (PST)
X-Gm-Message-State: AOAM530YS/qgD6i4/lONCkiiqESAxzt3KvZJDquiSlWiF+lVknsGCK8k
        J674sDjFn60H6/saugGk3ZFQerFnAHxb5rFrMf8=
X-Google-Smtp-Source: ABdhPJw3gFWatSo1Y6jV4gB75V0xWxyOFOmjPvNd5QIFQn+mMGqoFG7fKgRXKN3l3QNdXQ8DqfrausXl2kVpFlIhrHM=
X-Received: by 2002:a25:dc14:: with SMTP id y20mr8337357ybe.115.1644833961454;
 Mon, 14 Feb 2022 02:19:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:88a:b0:15e:9450:8ed4 with HTTP; Mon, 14 Feb 2022
 02:19:20 -0800 (PST)
In-Reply-To: <CAHmME9okFEVqTM9c9fQY02UiiNBkpaZMLSYMhzHs8FqtpV1F1g@mail.gmail.com>
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de> <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de> <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
 <YgaZuShru2HQiFXg@linutronix.de> <CAHmME9oZMFN80M98Mt6JysPSMTJoXfKTjHuxG6BQSsC=+0z5fg@mail.gmail.com>
 <YgacTN2zHeBhWw5d@linutronix.de> <CAHmME9okFEVqTM9c9fQY02UiiNBkpaZMLSYMhzHs8FqtpV1F1g@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 11:19:20 +0100
X-Gmail-Original-Message-ID: <CAHmME9pDcL6vaoHGqiK+eGeS10f+kW3xRft=ZJFk-Dnxh8+eMg@mail.gmail.com>
Message-ID: <CAHmME9pDcL6vaoHGqiK+eGeS10f+kW3xRft=ZJFk-Dnxh8+eMg@mail.gmail.com>
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

On 2/13/22, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey Sebastian,
>
> On Fri, Feb 11, 2022 at 6:26 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> Sure. I can do the CPU-HP notifier later one once we are done with
>> everything. I acked the v7, don't see a road block.
>
> I've been running this over the weekend and performance is generally okay.
>
> # perf top --symbols $(objdump -t
> /usr/src/linux/drivers/char/random.o|fgrep 'F .text'|awk '{print
> $6}'|tr '\n' ,) -F max -g
>
> One thing I noticed though was that add_interrupt_randomness spends
> most of its time on:
>
>     lock   xadd   %eax,0x38(%rbp)
>
> So, as expected, those atomics really need to go. Indeed we might be
> best off with the CPU hotplug notifier for setting the count back to
> zero.
>
> Do you want to prepare a patch for this? Or should I take a stab at it?

FYI, I was overwhelmed with a compulsion to try doing it myself and
posted that here
https://lore.kernel.org/lkml/20220213215343.11652-1-Jason@zx2c4.com/
which is now pending your review.
