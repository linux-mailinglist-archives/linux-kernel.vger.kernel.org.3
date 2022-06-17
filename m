Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5BB54F279
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380724AbiFQIDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344176AbiFQIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:03:19 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3072140BF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:03:16 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1977759wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzg4HckHFSbHYNGKJ4i1YLB0dVmoVIir8olD0ftfqDQ=;
        b=BPdxVEr0m+p9FS8U+hdVHlvdLJz0CZCuuCK80VvYZJPz32Ojr1Mr8hFZQ4d3ERTfxr
         X65TWuKdNyYDyXvdW/YspAb/61Igsk6g1EbBmZ+fMHc4mLNq5k7m4W9yKurKmW0Td+El
         x/tNVCMTu0wBoOFThi6YRahckHnLKsOws80OUGak5JracqFkcUFVQg2HTGdPGlPULhHi
         ryYmJKdDlvhLxnURb4TgJBp6RPWwXKQ4T9ZfLkSF1FIlnO65fRXFFrKP6uhm9cCtFDNt
         tPwFrp4wsGXro7ZadM2/KNtr2J+LbQ6anavf9wBxYjLnTDK9Quf4GQ2iG47AbWhspJAZ
         A/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzg4HckHFSbHYNGKJ4i1YLB0dVmoVIir8olD0ftfqDQ=;
        b=UHo0KpdYSq8eLfJYbo+cWyHBb/50azq/oLqQHOm+kejzK6kF6SdljmaPFn55Mxlh9O
         vJRMt3B23BfXIqPlh+q2RQthzwDHu7KX3i3UJw965iJweaqMcjOTcG9KEwyprkwfpTP6
         Q8OZjuG3iOgX29rJO+c9xfolNfLCaedtsZaZO8v+qfDrXWBHN1s992+s1zdM6nHaDnCX
         qqh5l3tj8QUNiKqJQU5bNkQduZD3jXh7P4rj3rv/wosMel7aLAHKRlFxMWVRWIwe5ku9
         Un9BfOTi78qwlaaAwEdZVBcOuZA9t1anYtPf3crGlrUB1Yb/yDjPMtdbxNsthhgbqkYI
         7Nbg==
X-Gm-Message-State: AOAM531jfIP6o6X/kdPjdIPHn4YupVoY+OCYL5jx5GdHv5A/m5VqkyeR
        Q/oWFB2MnsCw6lExewLjkAShb9VQvu5qjKKLtQ2AaA==
X-Google-Smtp-Source: ABdhPJwGllmaptIB/AllP0uZ7jUHDq3fElMzxdIzeWpPDwzjF5/4d7ZsZCjqkbwg6Xxo0AMkCT6JRUznOVtgQEyIMpA=
X-Received: by 2002:a05:600c:294a:b0:39c:4df5:f825 with SMTP id
 n10-20020a05600c294a00b0039c4df5f825mr19543009wmd.55.1655452935448; Fri, 17
 Jun 2022 01:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220616180430.930721-1-dlatypov@google.com>
In-Reply-To: <20220616180430.930721-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 17 Jun 2022 16:02:04 +0800
Message-ID: <CABVgOSnevOm1djuJrAR3K1kcVkXrZxugHL-b2bBPhHNSXE1GyA@mail.gmail.com>
Subject: Re: [PATCH] lib/atomic64_test.c: convert to use KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     mark.rutland@arm.com, boqun.feng@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 2:04 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The test currently is a bunch of checks (implemented using BUG_ON())
> that can be built into the kernel or as a module.
>
> Convert it to a KUnit test, which can also run in both modes.
> From a user's perspective, this change adds a CONFIG_KUNIT=y dep and
> changes the output format of the test [1] and makes it less destructive
> on failure. The test itself is the same.
>
> This hopefully makes the test easier to run and more consistent with
> similar tests in lib/.
> Since it has no dependencies, it can be run without explicitly setting
> up a .kunitconfig via
> $ ./tools/testing/kunit/kunit.py run atomic
> ...
> [13:53:44] Starting KUnit Kernel (1/1)...
> [13:53:44] ============================================================
> [13:53:47] =================== atomic (2 subtests) ====================
> [13:53:47] [PASSED] test_atomic
> [13:53:47] [PASSED] test_atomic64
> [13:53:47] ===================== [PASSED] atomic ======================
> [13:53:47] ============================================================
> [13:53:47] Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> [13:53:47] Elapsed time: 13.902s total, 1.629s configuring, 9.331s building, 2.852s running
>
> It can be run on ARCH=x86_64 (and others) via:
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 atomic
>
> The message about which platform the test ran on won't show up in
> kunit.py, but still gets printed out in dmesg, e.g.
> > TAP version 14
> > 1..1
> >     # Subtest: atomic
> >     1..2
> >     ok 1 - test_atomic
> >     ok 2 - test_atomic64
> >     # atomic: ran on x86-64 platform with CX8 and with SSE
> > # atomic: pass:2 fail:0 skip:0 total:2
> > # Totals: pass:2 fail:0 skip:0 total:2
> > ok 1 - atomic
>
> [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> ---
> Meta: this is a resend of https://lore.kernel.org/linux-kselftest/20220502192327.81153-1-dlatypov@google.com/
> Michael kindly pointed me to the right MAINTAINERS entry (this test file
> isn't covered by it, and it slipped my mind to check the non-test code).
>
> I've waited until 5.19-rc1 so that the relevant KUnit patches this
> depended on have been merged.
> Rebasing and tweaking the commit message a bit are the only changes.
> ---

Tested this again just to be sure, and it still builds, runs, and
passes for me on:

- UML (x86_64)
- x86_64 + qemu
- i386 + qemu
- arm64 + qemu + clang/LLVM

Cheers,
-- David
