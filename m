Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54C4575825
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiGNXqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiGNXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:46:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A076D9DC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:46:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id oy13so6194816ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyIlDk4W3kNLsc6EwzwzX2HL8L0b3ZfiT6dB513UuYM=;
        b=dACUMMrTnZ8StS9Wk8a47jEtPZIugOyWZ7Vcvfp0a+6cmjwB3tl+YjORYLAZSAhAwh
         3YnJRiFzgbMmS9MCckIQQ0mZx8LClTRChtf2ag6hIrS4t2kZGEv8DvJvNa9R6g+adwNt
         2mXDFXA039575hMyK0Edw1x7YJXtv9Z57pwp2PugxU9Z7r1LCkyTn6m6NKG4kHQWIqyc
         PUgZB1Ud8L74oImS9H5eMf6RDzMODarA0TP1P+g+W+IsQzQZJeF13bZeMfXcAizGYVTU
         FEToUDLfE/KGCVoEHLvKa1dYcBpLpTjUcyzsIA1sNTRyI4Q5sKYKY6BILfGOTseQPqfg
         N98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyIlDk4W3kNLsc6EwzwzX2HL8L0b3ZfiT6dB513UuYM=;
        b=DMmx9CtHqNuAtbIMLgtL8lS2t7TYXRteLOJ2A+DTu5mY5JxcCNXkKQLaKlastfUg1+
         3jO4LsNatJfBgFQnONtxApRtyVnC37eka0iUdGedHnz1iugkLzePj5e2ktXoqkAucsUn
         mDKECoHRIksitaw3AdcO0NyPVy5J5xoWKDW9di4OernDtCzq1k/cOUmvwDYdn621whII
         iGyYimonCAlkJKulOw9Er1A8nRdnOOR1tNBzLGPh65QqOHKPOMmdjbdnoXMY4+BPeJSV
         JkH1uocuIHTwmN/sSipMMUockKYU1vJqgO4EsO/rkY9nP3JrZynwhOPYA2hCRoBfRinr
         UkkA==
X-Gm-Message-State: AJIora+jSOCEzbgmaNVoe34EP4ekf48RwL0cWQgYtg8ZVjPb7ozLEAT5
        BpSHpq7kdt3wgl97Z1Yw9dM88WKpP0R4NmsmJoTyLw==
X-Google-Smtp-Source: AGRyM1sUVfE+I1d5lIJ+y0Q9r3UAo6dg47JNpdIyqioxncfGeJ5K+AY+s4F6lYuDnZoGifhgb2jhirTnrsHYxkVdN18=
X-Received: by 2002:a17:907:2856:b0:72b:54bd:40eb with SMTP id
 el22-20020a170907285600b0072b54bd40ebmr10726416ejc.542.1657842366888; Thu, 14
 Jul 2022 16:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com> <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
 <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
 <CAGS_qxr_+KgqXRG-f9XMWsZ+ASOxSHFy9_4OZKnvS5eZAaAT7g@mail.gmail.com> <CANpmjNP-YYB05skVuJkk9CRB=KVvS+5Yd+yTAzXC7MAkKAe4jw@mail.gmail.com>
In-Reply-To: <CANpmjNP-YYB05skVuJkk9CRB=KVvS+5Yd+yTAzXC7MAkKAe4jw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 14 Jul 2022 16:45:55 -0700
Message-ID: <CAGS_qxq5AAe0vB8N5Eq+WKKNBchEW++Cap2UDo=2hqGzjAekCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     Marco Elver <elver@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:41 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 14 Jul 2022 at 22:23, Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Thu, May 19, 2022 at 6:24 AM Marco Elver <elver@google.com> wrote:
> > > I'd keep it simple for now, and remove both lines i.e. make non-strict
> > > the default. It's easy to just run with --kconfig_add
> > > CONFIG_KCSAN_STRICT=y, along with other variations. I know that
> > > rcutoruture uses KCSAN_STRICT=y by default, so it's already getting
> > > coverage there. ;-)
> >
> > David decided to drop the parent patch (the new QEMU config) now
> > --qemu_args was merged into the kunit tree.
> > Did we want a standalone v2 of this patch?
> >
> > Based on Marco's comments, we'd change:
> > * drop CONFIG_KCSAN_STRICT=y per this comment [1]
> > * drop CONFIG_KCSAN_WEAK_MEMORY per previous comments
> > Then for --qemu_args changes:
> > * add CONFIG_SMP=y explicitly to this file
> > * update the comment to show to include --qemu_args="-smp 8"
> >
> > Does this sound right?
>
> Yes, sounds good to me, and thanks for remembering this. I'd prefer a
> close-to-default config.
>
> > [1] Note: there's also patches in kunit now so you could do
> > --kconfig_add=CONFIG_KCSAN_STRICT=n to explicitly disable it. This
> > wasn't possible before. Does that change what we want for the default?
>
> I'd just have KCSAN_STRICT=n by default, and if desired it can be
> added per kconfig_add just the same way.

Ack.
So concretely, so then a final result like this?

$ cat kernel/kcsan/.kunitconfig
# Note that the KCSAN tests need to run on an SMP setup.
# Under kunit_tool, this can be done by using the x86_64-smp
# qemu-based architecture:
# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
--arch=x86_64 --qemu_args='-smp 8'

CONFIG_KUNIT=y

CONFIG_DEBUG_KERNEL=y

CONFIG_KCSAN=y
CONFIG_KCSAN_KUNIT_TEST=y

# Need some level of concurrency to test a concurrency sanitizer.
CONFIG_SMP=y

# This prevents the test from timing out on many setups. Feel free to remove
# (or alter) this, in conjunction with setting a different test timeout with,
# for example, the --timeout kunit_tool option.
CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
