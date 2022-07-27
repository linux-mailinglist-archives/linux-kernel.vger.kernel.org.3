Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C14582C75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiG0Qq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbiG0QqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:46:17 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE75FAFF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:31:36 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so13932667iou.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLpauEQ5M+lWRIlS3PcwqsZWVTFiAvj2+32FpHGOhBk=;
        b=klS/6ZXoSeM0uv5HT7/w1pRROtMu2SFyiAGZpuVTlKfCMmZO+NVgryshOQKXZ3mRwO
         aCapBXgciK6e8ZLoA0VmgIdcFIShZvj3yTsNZAVCWrgAfnyA1QH0nmrIVsxq906pdmc0
         hmwXJXpwp0IwAbDiWt5D++aDEST91D1pWaKsHwWFDLX494ZYqaluBT3sHd8k0UTlRBI2
         jEfCfG3Cu4m+fuqo+JGBOr/N1asAZoHTfyfmGqch2N4qoAxdB4As1OnAQTKzEjYhm7vg
         3XTBjSn/35ULRdJL1A6mahAfA9wsliZ8gk/LfZ5hmyy9h93oqA8sg161qx782ugJASrw
         dWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLpauEQ5M+lWRIlS3PcwqsZWVTFiAvj2+32FpHGOhBk=;
        b=BoDQEZfR4q3ktiR90+sEKbW5OAwaoN8ccUHOGafuYy0fmj8/bQ2NeI5Hl5oJEek6u+
         zqutGClFzrJBhjCShlTUjqRiUGo9k2F1T+ql+aM1nyp/BcJb4OvHvVwvxhMlq1xlwmpk
         qfCuTFqRsNPx2lHIDhFCIek+fmkDbXjqTtv7/Up7+HZMVAucm9j5hTLjHrQYiAcj3ii9
         jNxh0euyzBoo9+wpDxixgj+AUW7aunADIHzH+UuJCcOtrLOm+0tGhIhWDFaMQO23lRfL
         5YbfoeR/l575FbCbIOXNUEKJNQPKEcm0642F+Fdr6DSgLOb30a3Yt8FkgGV9zZKw5NyD
         6J+A==
X-Gm-Message-State: AJIora/aFWxHJgoXYae7Qk328ic3oP/izTdR9+ecJfPJgocFfcFzoCRO
        C76yha2503LUjnGP5W88MpkW7dpF0zs0ujxpm1Nn9Q==
X-Google-Smtp-Source: AGRyM1vzxJdX05n48cDiHKWT4UyZZ4xthB7HHUEb5MIzbitr5xn078iGRk5ZiOqwPRiIpO312Lx7K0+ksI9j1fyn3gg=
X-Received: by 2002:a02:a68c:0:b0:33f:46d4:918e with SMTP id
 j12-20020a02a68c000000b0033f46d4918emr8580458jam.58.1658939495323; Wed, 27
 Jul 2022 09:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210929185823.499268-1-alex.popov@linux.com> <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1> <YVWAPXSzFNbHz6+U@alley>
 <CAHk-=widOm3FXMPXXK0cVaoFuy3jCk65=5VweLceQCuWdep=Hg@mail.gmail.com> <7c567acd-1cc1-a480-ca5a-d50a9c5a69ef@ispras.ru>
In-Reply-To: <7c567acd-1cc1-a480-ca5a-d50a9c5a69ef@ispras.ru>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Jul 2022 18:30:59 +0200
Message-ID: <CAG48ez2Sh-kngNVeCF9-X550PQMaNnQaEvS+EAiWaDjWnmoHOg@mail.gmail.com>
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Garnier <thgarnie@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 6:17 PM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> On 01.10.2021 22:59, Linus Torvalds wrote:
> Coming back to the discussion of WARN_ON()/pr_warn("WARNING:") semantics.
>
> We see a number of cases where WARNING is used to inform userspace that
> it is doing something wrong, e.g.
> https://elixir.bootlin.com/linux/v5.19-rc8/source/net/can/j1939/socket.c#L181
> https://elixir.bootlin.com/linux/v5.19-rc8/source/drivers/video/fbdev/core/fbmem.c#L1023
>
> It is definitely useful, but it does not make sense in case of fuzzing
> when the userspace should do wrong things and check if kernel behaves
> correctly.
>
> As a result we have warnings with two different intentions:
> - warn that something wrong happens in kernel, but we are able to continue;
> - warn userspace that it is doing something wrong.
>
> During fuzzing we would like to report the former and to ignore the
> latter. Are any ideas how these intentions can be recognized automatically?

https://elixir.bootlin.com/linux/v5.19-rc8/source/include/asm-generic/bug.h#L74
says:

 * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
 * significant kernel issues that need prompt attention if they should ever
 * appear at runtime.
 *
 * Do not use these macros when checking for invalid external inputs
 * (e.g. invalid system call arguments, or invalid data coming from
 * network/devices), and on transient conditions like ENOMEM or EAGAIN.
 * These macros should be used for recoverable kernel issues only.
 * For invalid external inputs, transient conditions, etc use
 * pr_err[_once/_ratelimited]() followed by dump_stack(), if necessary.
 * Do not include "BUG"/"WARNING" in format strings manually to make these
 * conditions distinguishable from kernel issues.

So if you see drivers intentionally using WARN() or printing
"WARNING:" on codepaths that are reachable with bogus inputs from
userspace, those codepaths should be fixed to log warnings in a
different format.
