Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B278B4979BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiAXHmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiAXHmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:42:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89964C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 23:42:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j2so54795688edj.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 23:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/x4cWx0FlqiYyWIO9v+6frfgtjqdloEnhyL562FSKqY=;
        b=a6L/SHKUojh/M3OqLlblvh0ECUcqTu16A2CE+TO7YFkg/cul41WVSfjDgA7syUi0kf
         z5lAGC/iWbHkI6WLbsMORQcbgnLRFyv2HieE0LXPn+diiK41nKPe/XCpOhIDc8rVXW1M
         8TSyeVXZVgCsn097K0LVbHC/WhUiOg93u4g2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/x4cWx0FlqiYyWIO9v+6frfgtjqdloEnhyL562FSKqY=;
        b=Qbh3p2Xa7iPB0NPUzxAg6OleZwdLuUXcXLgmiDnaWTI//ImvzejtmjjQcz+AIVaYTZ
         Au/syjzp5XBAp8KzvD9GP7neUpDJsCcjNT6N2kg22Del33QgLWFBFkU+o7KJnm8l8/W2
         MB5fCsCN7O52I2ok+f/m1g6Hth/3MabeGsFiDoktHctNTy0fDhcd8m4teA0+t99aokxS
         BN6KUiVjyWwKUMMUD2kZztp7Wqi2LcFYiIXUWElTXEnvhcUtvN5QggYMVohYyw3f2C0B
         Mz5IckASz22EK8o+IoUoBYNdWzWwBJ4Xa1QgQbPynkUQOhZTS2gc1h/okYAfOwDibKQe
         BcGQ==
X-Gm-Message-State: AOAM530tqI8qZJVpB+CEX0IMtZ04PEFkWWCzK2F6XDFOE34PPhUR/83+
        24WpmlCI7Nqz/zvczxaIzlTHJoOqWJuLLdKj
X-Google-Smtp-Source: ABdhPJwx0ggSABWg6A7e9v1B8gduCvvHp/UdcCO8rV/Waxx5koFZJed1nrTYNe76jJhxoCiCEueV9w==
X-Received: by 2002:a50:d69e:: with SMTP id r30mr14894438edi.284.1643010139524;
        Sun, 23 Jan 2022 23:42:19 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id g17sm2832176ejd.82.2022.01.23.23.42.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 23:42:18 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id r14so1262973wrc.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 23:42:17 -0800 (PST)
X-Received: by 2002:adf:9dce:: with SMTP id q14mr11932475wre.193.1643010137698;
 Sun, 23 Jan 2022 23:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20220123193154.14565-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20220123193154.14565-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jan 2022 09:42:01 +0200
X-Gmail-Original-Message-ID: <CAHk-=whhEB-A-ahgeMsozDfdGNmP_MB9JVnV3bavGbeqgfpStQ@mail.gmail.com>
Message-ID: <CAHk-=whhEB-A-ahgeMsozDfdGNmP_MB9JVnV3bavGbeqgfpStQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rseq: Fix broken uapi field layout on 32-bit little endian
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andi Kleen <andi@firstfloor.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 9:32 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The rseq rseq_cs.ptr.{ptr32,padding} uapi endianness handling is
> entirely wrong on 32-bit little endian: a preprocessor logic mistake
> wrongly uses the big endian field layout on 32-bit little endian
> architectures.
>
> Fortunately, those ptr32 accessors were never used within the kernel,
> and only meant as a convenience for user-space.

Please don't double down on something that was already broken once.

Just remove the broken 32-bit one entirely that the kernel doesn't
even use, and make everybody use

   __u64 ptr64;

and be done with it.

Adding a new "arch.ptr32" thing to replace the broken ptr.ptr32 is
just not worth it. This "convenience feature" never worked correctly
on any relevant architecture, so it clearly was never a convenience
feature, and deciding to try to re-do it because it was broken and
pointless the first time around isn't sane.

The definition of insanity is literally to do the same broken thing over again.

So just remove the broken ptr.ptr32 thing, don't add anything new to
replace it. Existing binaries will continue to work (or not work) as
well as they ever did. And new people getting new headers will get a
clear and proper compile error for the broken code that they can
trivially fix using 'ptr64' after they have actually thought about it
for a while.

Giving them a "arch.ptr32" doesn't help them at all. Quite the
reverse. You seem to hve the intention that they should just
mindlessly replace "ptr.ptr32" with "arch.ptr32", and now their code
won't actually work the same. Plus it will build with one version but
not the other.

In contrast, if you just tell people "ptr.ptr32 was always broken, use
ptr64 instead", it will actually work THE SAME with both old and new
headers. No odd "changed behavior from syntactic patch". No odd "this
won't work with older headers so now you have to add some
configuration or #ifdef".

The kernel cares about maintaining the ABI. The *binary* interface. If
the API was broken, it needs to be fixed. Not made worse by keeping
the broken fields and adding new ones for no reason.

               Linus
