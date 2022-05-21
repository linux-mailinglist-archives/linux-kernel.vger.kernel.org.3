Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6652FFC9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 00:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbiEUWbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 18:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiEUWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 18:31:06 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7ED63CA
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 15:31:03 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z20so3477043iof.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FonIHMi/3lO9Jffb1ttV3+nPKi58eDv/a59C6q9nmzI=;
        b=NaAO8pGGJ3T+MKNvg6WEHzeviTfr99ijUwaHhRJvuBfYsjLET3d2JzRD+AbYnPvVsp
         UUiKuvcF2XUO2+p4aKPweMWzrGVFtR00l7hYnztPRs5axpgJ3hnruLd7i165qiT0EPyo
         KdMMBVmFCSSl1Q6foB6wS++7HnFaNF+pHuyzZ68DogBZwEbz+Kgy5N11MsKwDzacegxo
         jH3CdtTIsOrfdezE0zxgJmKFy2YRJkWJNGOMEfBdjDirby+7ZdR0JvKy+kB8RFVBXbEe
         7mzHsxgyZgWOEdBtjPCcY7ZNvGQv7476Y0XvRO8aKvysFgECGRaSKYS3qRAijP4WtZys
         5TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FonIHMi/3lO9Jffb1ttV3+nPKi58eDv/a59C6q9nmzI=;
        b=LUCJHWw+HHpcQl00E0ADpWbkwOBdYZBHJRgH/fklxHtGOaSbT05nINQUMheY5YZHPB
         hyi07LulHTGU+7MXy8oXtgt6e9idyUBFhCknQgmCSfxkjEQPtVT1Y+qfaDvCjrayAU1B
         T+iHtBoTARRYxzFWVswn+6NDaxWFuZ2TWoBcZY0bl6fJ+IclK7Po0jCbe6+/8wcIq+sF
         YHU6ksrhTIuIjLhUiFb/jLAtshy1wtF9NG/Vufvs0Tnpkqdy6MXF1QiKGNm3G0V/p85L
         tNm29yDTrOZsgaAWJGSOS6wtcx8G+JF4lSWbeFxyyLoLlC2hqmJnjNxh34tZqJfRyem1
         RGgg==
X-Gm-Message-State: AOAM532HzcFUcFmhtyfLLnEDIkDl4VQ0q4QYRXGdIOrdpRY8ioavxN3f
        E5HfxPSGuKESPuuZgfukbsG7QEu4B9zJ9hmR1F0=
X-Google-Smtp-Source: ABdhPJzZ3q9U8SzINmFXzXhh1wuHsq2L8h2lKquyKk70w4Hj7ZmKbqyB6DmkTDCvjEzonsVoYuXQLydy0bsaZUjcTyQ=
X-Received: by 2002:a05:6638:381c:b0:32e:49f9:5b6e with SMTP id
 i28-20020a056638381c00b0032e49f95b6emr8942455jav.71.1653172263265; Sat, 21
 May 2022 15:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649877511.git.andreyknvl@google.com> <YlgVa+AP0g4IYvzN@lakrids>
In-Reply-To: <YlgVa+AP0g4IYvzN@lakrids>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 22 May 2022 00:30:52 +0200
Message-ID: <CA+fCnZcM-1oxVeZSPHnnwy-9CiksZhWfqEbms-yg22hRjr7EFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] kasan, arm64, scs: collect stack traces from
 Shadow Call Stack
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Thu, Apr 14, 2022 at 2:37 PM Mark Rutland <mark.rutland@arm.com> wrote:
>

Hi Mark,

Sorry for the delayed response, it took some time getting my hands on
hardware for testing these changes.

> Just to be clear: QEMU TCG mode is *in no way* representative of HW
> performance, and has drastically different performance characteristics
> compared to real HW. Please be very clear when you are quoting
> performance figures from QEMU TCG mode.
>
> Previously you said you were trying to optimize this so that some
> version of KASAN could be enabled in production builds, and the above is
> not a suitable benchmark system for that.

Understood.

My expectation was that performance numbers from QEMU would be close
to hardware. I knew that there are instructions that take longer to be
emulated, but I expected that they would be uniformly spread across
the code.

However, your explanation proved this wrong. This indeed doesn't apply
when measuring the performance of a piece of code with a different
density of function calls.

Thank you for the detailed explanation! Those QEMU arguments will
definitely be handy when I need a faster QEMU setup.

> Is that *actually* what you're trying to enable, or are you just trying
> to speed up running instances under QEMU (e.g. for arm64 Syzkaller runs
> on GCE)?

No, I'm not trying to speed up QEMU. QEMU was just the only setup that
I had access to at that moment.

The goal is to allow enabling stack trace collection in production on
HW_TAGS-enabled devices once those are created.

[...]

> While the SCS unwinder is still faster, the difference is nowhere near
> as pronounced. As I mentioned before, there are changes that we can make
> to the regular unwinder to close that gap somewhat, some of which I
> intend to make as part of ongoing cleanup/rework in that area.

I tried running the same experiments on Pixel 6.

Unfortunately, I was only able to test the OUTLINE SW_TAGS mode
(without STACK instrumentation, as HW_TAGS doesn't support STACK at
the moment.) All of the other modes either fail to flash or fail to
boot with AOSP on Pixel 6 :(

The results are (timestamps were measured when "ALSA device list" was
printed to the kernel log):

sw_tags outline nostacks: 2.218
sw_tags outline: 2.516 (+13.4%)
sw_tags outline nosanitize: 2.364 (+6.5%)
sw_tags outline nosanitize __set_bit: 2.364 (+6.5%)
sw_tags outline nosanitize scs: 2.236 (+0.8%)

Used markings:

nostacks: patch from master-no-stack-traces applied
nosanitize: KASAN_SANITIZE_stacktrace.o := n
__set_bit: set_bit -> __set_bit change applied
scs: patches from up-scs-stacks-v3 applied

First, disabling instrumentation of stacktrace.c is indeed a great
idea for software KASAN modes! I will send a patch for this later.

Changing set_bit to __set_bit seems to make no difference on Pixel 6.

The awesome part is that the overhead of collecting stack traces with
SCS and even saving them into the stack depot is less than 1%.

However once again note, that this is for OUTLINE SW_TAGS without STACK.

> I haven't bothered testing HW_TAGS, because the performance
> characteristics of emulated MTE are also nothing like that of a real HW
> implementation.
>
> So, given that and the problems I mentioned before, I don't think
> there's a justification for adding a separate SCS unwinder. As before,
> I'm still happy to try to make the regular unwinder faster (and I'm
> happy to make changes which benefit QEMU TCG mode if those don't harm
> the maintainability of the unwinder).
>
> NAK to adding an SCS-specific unwinder, regardless of where in the
> source tree that is placed.

I see.

Perhaps, it makes sense to wait until there's HW_TAGS-enabled hardware
available before continuing to look into this. At the end, the
performance overhead for that setup is what matters.

I'll look into improving the performance of the existing unwinder a
bit more. However, I don't think I'll be able to speed it up to < 1%.
Which means that we'll likely need a sample-based approach for HW_TAGS
stack collection to reduce the overhead.

Thank you!
