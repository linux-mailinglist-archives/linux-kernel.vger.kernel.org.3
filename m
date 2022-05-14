Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9581E52704A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiENJbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 05:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiENJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 05:31:30 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3ADFF0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:31:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kj8so8629818qvb.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBK9297vnNgTKNgzNQdSDNoUsAxJ9WLW7oIgz8DQcSQ=;
        b=L9FHvU+n7zduTDdwW6sM3XmD/9wzi3G1eROUAAADWvcagmlZrosiIxmoFVhCc++wU/
         G/wn3evuB/SaKze24We7GHRT7s7kOBwhOHTaRj9kUCXVdLXuS/QurwYLEBa6F4WcrXp/
         Rb8xMq+QS5lpHE6GI3XofD8jMk6/aKXjwxOo2gfrAyCSVNrdOGXw609tXzmBADIIIOGz
         usd1MAxow1mTHq0VcsmTK3MR7S91hOrc9PKPyVEWc2RgKGqYR2h7Ydl2huag//mXLbXW
         rEZ81TtGqh6eAhes1JQX/S1w+SVIZ0/36QcTl3wm5hwb0lIlva7baMAVV2cTYNIg/vLV
         aJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBK9297vnNgTKNgzNQdSDNoUsAxJ9WLW7oIgz8DQcSQ=;
        b=Csx5sxQspAPc1YQ/g/6BtRz4UNVEbGBb2iixv6AywfFOixApDI6c1RWmBMYebrSUrg
         P6QFWjO8OlrKR5PREBuRPRxmGqsykgaeaBzgMl6yAVxyJsJtx7SE3g3n+giEfUW8PK4Y
         ymk2otqbzqFBCo2FLo5wvtNPsod6QrDTOSxPreVEY/5Xob4U6Sy5YDfTOPlNA9h2mMiV
         uW+pLL/d8Bqwtgwtp4Jm4cv8L2DdDyMrthJeukQXu0cYc9ynJJi1eGTkFk4ntLzgqOq3
         UcoW2eRadvLRi6oAvw/YwwlDg2dAF3CpWQXvrzvtOnUdgQ3MKAz8J8gbe6UkcBEbx9yW
         pmtQ==
X-Gm-Message-State: AOAM5334qOKXsr/6OfAegrnejw4Xw9h5AU1K1R0TdOxZ6AivYhcgmkqN
        hVLTZ/0PHyk/Izbfw3z+Ktn4G4e85SnsTTzOww8=
X-Google-Smtp-Source: ABdhPJx3uoXlvhDURRNtcVVvWbJdG3SZWqCUBgZGLGvb9vz8AnZpK9r1uFYdFUjTH6egnoJKdsUzQp2dujaVwKuhf9k=
X-Received: by 2002:a05:6214:5189:b0:45d:d051:ea06 with SMTP id
 kl9-20020a056214518900b0045dd051ea06mr7616646qvb.2.1652520687896; Sat, 14 May
 2022 02:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220513153009.228282-1-ubizjak@gmail.com> <20220513153009.228282-3-ubizjak@gmail.com>
 <20220513221820.GK76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220513221820.GK76023@worktop.programming.kicks-ass.net>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 14 May 2022 11:31:38 +0200
Message-ID: <CAFULd4Z2AAvGkfdvG9RexfZRaMgWdU6HJG1jRD4E052vd35ySA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locking/atomic/x86: Introduce arch_try_cmpxchg64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 12:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 13, 2022 at 05:30:09PM +0200, Uros Bizjak wrote:
>
>
> > +#define arch_try_cmpxchg64(ptr, po, n)                                       \
> > +     ((__typeof__(*(ptr)))__try_cmpxchg64((ptr), (unsigned long long *)(po), \
> > +                                          (unsigned long long)(n)))
>
> That doesn't look right (unless it's so late I really can't read
> anymore, in which case ignore me and I'll try again on monday). But the
> return value of try_cmpxchg is bool, not typeof(*ptr).

No, you are right, I was too eager when copying the code from the
above arch_cmpxchg64 definition. Unfortunately, although the cast is
benign and the compiler figures out that the cast is unnecessary, it
doesn't warn here...

Actually, since __try_cmpxchg64 is already bool, we don't need any
cast here, and the definition can be substantially simplified.

Thank you for another pair of eyes - I did eyeball this code
extensively, but the issue slipped through somehow.

Patch v3 is in the works.

Thanks,
Uros.
