Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1F57564B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiGNUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGNUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:23:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5B365D68
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:23:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bp15so5430584ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJyqb0gXwX9toDZcdJ0Ejs1ECxk9NdxpXaz6/AftgKg=;
        b=M14PGsSK222yjgy/D0paYcb0voen5eGphbEgK3uQZxoMuQFsHYI3PwMr7L7ibygvPr
         GLLhi8rz5UwixkPGAvjMQgDLFKeWONaCdLLlIBqCgo8gWYyXJMZBPJkTduQa8nt6tJYY
         B+fj7GPe1jgzKVT3IbSvtMjxHdUj/TN3flOxxrhwYXEoMV/Q51tJfaK9P3za3sXdcT6q
         YhHvIWvJknzfJUqZKa5dMOVDKLVbhqAMRFnxru8QbLpGZh2T84yyxwbsARJFsQdZ3RT+
         rvQAAhdepnqQ5cvErqrtSoRlecg2ltgzxbYu/sOGZGi0G2BYsp8MV2q7CG1eskRXS7Cr
         nkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJyqb0gXwX9toDZcdJ0Ejs1ECxk9NdxpXaz6/AftgKg=;
        b=ucCFBzd7bSrTxxRASMhhx2xL2vGANzzq9HhoIkhNjBUcirJ1zGLcQnVHxXQXWthbYd
         A1kfEl14n8Haew7GCF6I8CLkgO3p+PNThP/WZAQCf9xDPDAqQVOjh0UkeIZAI5BgzQl3
         482G4eg8d6JgoUw1wJ9+2gg9Df+csmzCU7fkF+jQ96ykbSWzWQVYJU0ewQSNPQ0TBL/i
         imUHl7IbksqmMtYlsu/iWxvQNernk3GqbdtLe963esBDWNdsSkLuQimEX4gT0cqGcG3G
         /kUpU+uF7L5uWrOBEyYUzZfDXjA7VIORTnpx3oP7wNTWq4iCrHAGowIZz9K4lomeNj16
         8tNA==
X-Gm-Message-State: AJIora/GOaYnkTpGRS8FDZ7VCyqR02FSgySjaRcgzACbLjteba+9q3yc
        rAQRW8aEBwtLd62c54y/C15ADhEt53/KX62igipplw==
X-Google-Smtp-Source: AGRyM1urEg/+DXbwKT4pbV7A84j1nZyYkeQHhMSsXo05Z1UxOCW6E7p3rkEfaP8QP5me41BU6K9CvpT8nEXtJ5wi2Qo=
X-Received: by 2002:a17:907:a06e:b0:72b:2cba:da35 with SMTP id
 ia14-20020a170907a06e00b0072b2cbada35mr10407054ejc.358.1657830181392; Thu, 14
 Jul 2022 13:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com> <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
 <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
In-Reply-To: <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 14 Jul 2022 13:22:50 -0700
Message-ID: <CAGS_qxr_+KgqXRG-f9XMWsZ+ASOxSHFy9_4OZKnvS5eZAaAT7g@mail.gmail.com>
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

On Thu, May 19, 2022 at 6:24 AM Marco Elver <elver@google.com> wrote:
> I'd keep it simple for now, and remove both lines i.e. make non-strict
> the default. It's easy to just run with --kconfig_add
> CONFIG_KCSAN_STRICT=y, along with other variations. I know that
> rcutoruture uses KCSAN_STRICT=y by default, so it's already getting
> coverage there. ;-)

David decided to drop the parent patch (the new QEMU config) now
--qemu_args was merged into the kunit tree.
Did we want a standalone v2 of this patch?

Based on Marco's comments, we'd change:
* drop CONFIG_KCSAN_STRICT=y per this comment [1]
* drop CONFIG_KCSAN_WEAK_MEMORY per previous comments
Then for --qemu_args changes:
* add CONFIG_SMP=y explicitly to this file
* update the comment to show to include --qemu_args="-smp 8"

Does this sound right?

[1] Note: there's also patches in kunit now so you could do
--kconfig_add=CONFIG_KCSAN_STRICT=n to explicitly disable it. This
wasn't possible before. Does that change what we want for the default?

Daniel
