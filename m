Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA04258D045
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiHHWnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiHHWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:43:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209441CB0A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:43:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x21so13087308edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bkfkLAktjDEknGMwnNyaIsJ3/ajtZNP7PXnXfvzJJOk=;
        b=JvwhcOuadZTVVXHe3sUQRrEmWl+jt00xAh16PvtbtBY4cVJMnI8HwDoG2ZVvavPV8u
         7Qa5B/eOum6jFFQeAQfWBr77wRL6PYwf1w6byA4MhIgNfN0i13Q0W8uvZZBt+mEFTYlZ
         z896pq1ssQhD6q0jfjMVy4xBY0DO4xfNOg1K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bkfkLAktjDEknGMwnNyaIsJ3/ajtZNP7PXnXfvzJJOk=;
        b=pqoQ0duaXm53NJ41VfO75LvwB399sygZDQbYKBxW0AP7OJhwvBU4+JaGH1UyqzaFG0
         58ZkUveTZ2snMh/VKe+N2c+8Le6n7qk2E6Z5ekGDYJFwEsmRxFDsPW9v5mhgPa6yUOB7
         gGXRzPV82yhGOceJjJ7uzY4lRn+6LWkAP2Yvl7Ju+eQoxI6Iur848ApL5UCq837CFOtZ
         lnlBKm+W+3T8vN0fFxFKawgWunUQMno/ifQ3XrIE2XZqHWjTFjkczltjTnPm6CqJ/JAS
         xOqtNmV/0Tz1kmP7tIkxvtDhuCCaLQzAayuCFs2VrQDfHK6omXLXxFfNgpsz0YduAfBZ
         g/qw==
X-Gm-Message-State: ACgBeo3Iqn+Xv8vi/ZVLes3qDqPYgnVtaTV+8Tvxfxi7tz57m+S4W2hU
        rKH8GlQqPdKo1s+ZJglcsCtaZXvWyezA9Xa1
X-Google-Smtp-Source: AA6agR4ZDdy4ZG6gzXiRDwuBL+b3/9oWfurK7JStP4Qqsyc7wdQYnXHhdVrSi+w+6AAtB96Hq1559A==
X-Received: by 2002:aa7:ccc4:0:b0:43d:9e0e:b7ff with SMTP id y4-20020aa7ccc4000000b0043d9e0eb7ffmr19779626edt.14.1659998605348;
        Mon, 08 Aug 2022 15:43:25 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id pk9-20020a170906d7a900b0073065767404sm372170ejb.34.2022.08.08.15.43.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 15:43:24 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id q1-20020a05600c040100b003a52db97fffso3187760wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 15:43:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr13578399wms.8.1659998604085; Mon, 08
 Aug 2022 15:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV> <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org> <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home> <YusDmF39ykDmfSkF@casper.infradead.org>
 <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com> <8735e6qtjc.ffs@tglx>
In-Reply-To: <8735e6qtjc.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Aug 2022 15:43:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1z8h=hcAhZ0hx9UNxWXzWFFrd-z3ZgwM5mxhNQjPHDw@mail.gmail.com>
Message-ID: <CAHk-=wi1z8h=hcAhZ0hx9UNxWXzWFFrd-z3ZgwM5mxhNQjPHDw@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Mon, Aug 8, 2022 at 3:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The use cases in mm/vmstat are not really all under spinlocks. That code
> gets called also just from plain local_irq or even just preempt disabled
> regions (depending on the stats item), which makes the proposed name
> less accurate than you describe.

Augh.

How about "preempt_disable_nested()" with a big comment about how some
operations normally disable preemption (interrupts off, spinlocks,
anything else?) but not on PREEMPT_RT?

> A worse case is the u64_stat code which is an ifdef maze (only partially
> due to RT). Those stats updates can also be called from various contexts
> where no spinlock is involved. That code is extra convoluted due to
> irqsave variants and "optimizations" for 32bit UP. Removing the latter
> would make a cleanup with write_seqcount_...() wrappers pretty simple.

I think we most definitely can start removing optimisations for 32-bit
UP by now.

Let's not do them without any reason, but any time you hit a code that
makes you go "this makes it harder to do better", feel free to go all
Alexander the Great on the 32-bit UP code and just cut through the
problem by removing it.

> Aside of that we have RT conditional preempt related code in
> page_alloc() and kmap_atomic(). Both care only about the task staying
> pinned on a CPU. In page_alloc() using preempt_disable() on !RT is more
> lightweight than migrate_disable(). So something like
> task_[un]pin_temporary() might work and be descriptive enough.

Yeah, that was the other odd pattern. I'm not sure "temporary" is all
that relevant, but yes, if we end up having more of those, some kind
of "thread_{un]pin_cpu()" would probably be worth it.

But the kmap code may be so special that nothing else has _that_
particular issue.

                   Linus
