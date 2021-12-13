Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851DB47353D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbhLMTst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbhLMTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:48:47 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:48:47 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 14so19939126ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6QuR33j2DsoUJNFFaRZPJl4fM7lAitWddXNO1xO6oI=;
        b=UrQQ9TYvfsaiCZzyJbAzWYy4pJEp5qvdnZU9cbPL47O35QI/oD4/nn2w1kRYMFezNf
         tZD0O4xHk77V+21gXGvEVm9cyh30XS8wiLmBI1yCmxy0NMHFWbjuZ7Ezb6qzDvHZOZAK
         f1U3Eh66HmjCmnRc5NC8AQ6IksYWq7rlEMFTNZmAGv4tksGI4UYiIAB+KHE9YPHU1Gnm
         jM3JhyCSYScvY1Wkc8dTSeGRqOKnSuRJAnmmXQ8X7i6+tdSExaxl9P0j4lFHYQ3CCdSR
         /5VbqgroLzKFPeEiiyYjRK/8XegXp1n1WWnh1lXHFTiKuM1FM6nPe7vzrAVg3Kz0GpNX
         ZPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6QuR33j2DsoUJNFFaRZPJl4fM7lAitWddXNO1xO6oI=;
        b=ecvQ1Ro7jLoksYWvbi6GwAHF4r6wX3IewEVpCG0HYhRFuXBry5bahdMmE6vO0z3/VG
         9vz1tZtFWczuZ+3V5RhSWQPGb7V3498pGgowr1Dla9dTmctRGFn9RcrW/PyRWna+eOSe
         eiHs8zzFLOZaAfwpfefgPRoaKSBG0CwhkLMAs0V5ZSSntmI/zmFrxOj37K1uf9aGf1eg
         Y/XcA3Zy1nRdYK6xiRIT3mNTev3tEb2RHikzExLtPL8zxIhOi2qDcW0K119G/S5Tmbr2
         Qf5BbWZEsPbf7RlCN7wwxikQDT37J81S701qZMAIVN0cARj+8kcnyeJFxZeRl7+zc/FJ
         MO0w==
X-Gm-Message-State: AOAM533B68fh8D0dY5YKEOkCnmoPkTR/4sRvNusklxIaCchZdFNUJ5Sx
        jVizGNeSUdbHvj118B3GwM2bEdO7zOyvVFFI4LrsbA==
X-Google-Smtp-Source: ABdhPJyscPfItKuhVZr3PwGvaGNZCpkAA36mnR/7RE2hth99WAbWi+k1gcCtFhjgDtYtRedJjY7SsjsxKG4DaBIvPV4=
X-Received: by 2002:a05:6602:3c2:: with SMTP id g2mr591936iov.65.1639424926915;
 Mon, 13 Dec 2021 11:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com> <fce9898e392f42a0830892a1735deb3e@AcuMS.aculab.com>
In-Reply-To: <fce9898e392f42a0830892a1735deb3e@AcuMS.aculab.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 13 Dec 2021 11:48:35 -0800
Message-ID: <CAMn1gO5mBHR3-Wd2CyxQ8PYt8apTiWNOtFwKY4duwXvGwkZFWA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] kernel: introduce uaccess logging
To:     David Laight <David.Laight@aculab.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 9:23 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Peter Collingbourne
> > Sent: 09 December 2021 22:16
> >
> > This patch series introduces a kernel feature known as uaccess
> > logging, which allows userspace programs to be made aware of the
> > address and size of uaccesses performed by the kernel during
> > the servicing of a syscall. More details on the motivation
> > for and interface to this feature are available in the file
> > Documentation/admin-guide/uaccess-logging.rst added by the final
> > patch in the series.
>
> How does this work when get_user() and put_user() are used to
> do optimised copies?
>
> While adding checks to copy_to/from_user() is going to have
> a measurable performance impact - even if nothing is done,
> adding them to get/put_user() (and friends) is going to
> make some hot paths really slow.
>
> So maybe you could add it so KASAN test kernels, but you can't
> sensibly enable it on a production kernel.
>
> Now, it might be that you could semi-sensibly log 'data' transfers.
> But have you actually looked at all the transfers that happen
> for something like sendmsg().
> The 'user copy hardening' code already has a significant impact
> on that code (in many places).

Hi David,

Yes, I realised after I sent out my patch (and while writing test
cases for it) that it didn't cover get_user()/put_user(). I have a
patch under development that will add this coverage. I used it to run
my invalid syscall and uname benchmarks and the results were basically
the same as without the coverage.

Are you aware of any benchmarks that cover sendmsg()? I can try to
look at writing my own if not. I was also planning to write a
benchmark that uses getresuid() as this was the simplest syscall that
I could find that does multiple put_user() calls.

Peter
