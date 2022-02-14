Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8094B53AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355313AbiBNOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:48:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355306AbiBNOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:47:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90164BFFA;
        Mon, 14 Feb 2022 06:47:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5F9AB80D61;
        Mon, 14 Feb 2022 14:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CCAC340E9;
        Mon, 14 Feb 2022 14:47:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H9JaNfXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644850066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4jtSjMajyZb2MUkd1I/zAYQQBBOSUBQUeG3X9YEiSI=;
        b=H9JaNfXzYw4ha+qEkWtLxraRTyluA7sBpS11a78wSbN429YETCTjN4O9KzJoKm07AyvJkv
        djTB76YFFAjtSHGGXc0pvuHdgKzdNsjVIaIKtMGjkqzxcL/0WXkgNwOwWjxNlahJOTuswO
        lyGxVide1s8hYApsPcWdA/aPwlg7VXg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 940936bc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 14:47:46 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id p19so46747757ybc.6;
        Mon, 14 Feb 2022 06:47:46 -0800 (PST)
X-Gm-Message-State: AOAM532XMee9GOr+OgHdqyYPHQhJaXwaVEc0sBMA8Ysp/9OjHvxthk12
        JcAyv8OXXPTHcShr/JfZQFMxlQ7Se8O/SfeQHpc=
X-Google-Smtp-Source: ABdhPJxQ4EqEFWIwK2iMWi7n4C+E5mWgD0RQqRWnPIXcs7LgVUXDCjyW62znmyRnmh2ygLSRyfFinqB8vVFajTuHibM=
X-Received: by 2002:a81:f10b:: with SMTP id h11mr14635319ywm.396.1644850065053;
 Mon, 14 Feb 2022 06:47:45 -0800 (PST)
MIME-Version: 1.0
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de> <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de> <CAHmME9rsOWuprpYqo9G9eUboQwUxRgWqYRYgyHG7cNOG16c5EA@mail.gmail.com>
 <YgoeBYJ5nwc8BTG3@linutronix.de> <CAHmME9otmV1QCX29D_DXsHB-41puTKurWtyZ39huPZtD4mt5ng@mail.gmail.com>
 <Ygo6EX1YVgTrtjVT@linutronix.de>
In-Reply-To: <Ygo6EX1YVgTrtjVT@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 15:47:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9oL0gyJwAtr0e+ZmeD-4tRopf48Go3axYzrd170cctO_w@mail.gmail.com>
Message-ID: <CAHmME9oL0gyJwAtr0e+ZmeD-4tRopf48Go3axYzrd170cctO_w@mail.gmail.com>
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

On Mon, Feb 14, 2022 at 12:16 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-02-14 11:17:20 [+0100], Jason A. Donenfeld wrote:
> > On 2/14/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > to
> > > | - Does anything anywhere call get_random_xx() before the worker has a
> > > |   chance to run?
> > >
> > > Once you queue a work item I don't think that the scheduler needs to put
> > > it on the CPU right away. It may have already have other tasks waiting
> > > including some with a RT priority.
> > > Also, the lock is irqsave() so they can be users in an interrupt
> > > handler. I remember the original reason why I made it irqsave is because
> > > something did kmalloc() and SLUB somehow asked for random bits.
> >
> > Right. So there are two sides of the questions: 1) how bad is this
> > actual race, and are there any drivers that do regularly get bit by
> > this? 2) There's a largeish window between workqueue_init_early()
> > setting up the system highprio workqueue, and workqueue_init()
> > enabling queued workers to actually run. Interrupts also get enabled
> > in the interim. Does anything get bit by that window?
>
> This is only important during boot-up, right?

Right. This is a pre-init window only. But a bunch of things are done
pre-init -- siphash secret keys, aslr seeds, and so forth.
