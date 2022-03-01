Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828A74C87D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiCAJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiCAJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:29:24 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A3713EBF;
        Tue,  1 Mar 2022 01:28:44 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h16so17726841iol.11;
        Tue, 01 Mar 2022 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7oq8QcvuWk9j+Ov9KHZtupOvSMMPTgudSgXmryJLhQ=;
        b=fRpR+SsX+n+Y1VEfkpZyHODKF8yXim+Aoe60zorIil+hZG+9Usa+tgQ0zvFIj5zBbg
         OQM1fHJ3kgV7ExCOKpO2ad4BbbpwHRuGzBQsyumH/cZyxetB3Ul6gf6HsuCm3P1l9p2m
         JTHKIL33/2wxY7+F3j0dNcRNcv7TdjS1jPjiayNdiFXhWj9leeb5hQOUoZzMK5H+s+Ug
         yO0sS4U0y3h8t8oc04RvGH5SO094xiFVlh1C2PpwUCgndN5CUAjbtyluiu4Yzb/Cdh00
         usJd7gUeU6NFXBAu5nTmoZp36flGtXO/5izMZ7SdJOZY8Ko+7vQOwF6ZHp1psHTFxlEn
         j/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7oq8QcvuWk9j+Ov9KHZtupOvSMMPTgudSgXmryJLhQ=;
        b=RsB0YQXO2AMcELQj9d5f0HhiSOOAxGhHbugUhsH7G62LoBiLueqKawtlV1B4VRCmir
         hVmHLEfew93ii0AAshCRcqpiFIbnVy9HOTrOn0PWeV59r5SJhz3VPyjVdbuLHKaQYbQ1
         mTEyRx2+bEJQLXy8m7Fa4SamtJkUysNZgjMzW7NCSqTBBXwe3nXUmFArF0jC7oyVEiMd
         XXy6zbnaEmMvfn2imaJtezmFYdS2Lyym96dGqZYhC5dGZGbZF8o+xW79UPLUdoFLHdJr
         BIx8v7EvlA2NYyupc4pySeOtvm2aUYW5I5rLOafs3E4YWXeK0bUG3uK4CfBUvmNDrAVv
         TomA==
X-Gm-Message-State: AOAM531fyNCmt3ljo3BiyrMPlspkBdH0YTTcaixdcj5ICdpICzvQGMsm
        32AEqT+8BxhLxUEvpaLrJL/b3hNgAKgMF+jPpvg=
X-Google-Smtp-Source: ABdhPJxw/F8LUd4tEHyA5ovxOOp8pZe/oUlm9MRBeqi6FVI6eyJZsSFV8WHtzwLweWE6jNo0DcDrz7YmIJ0P8JbMJXA=
X-Received: by 2002:a05:6638:1117:b0:30d:1e9f:26ca with SMTP id
 n23-20020a056638111700b0030d1e9f26camr20714457jal.256.1646126923740; Tue, 01
 Mar 2022 01:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
 <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com> <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
In-Reply-To: <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 1 Mar 2022 10:28:32 +0100
Message-ID: <CANiq72m0O7ua3F3eqcEru9RuEWHQbG4SumRSoKCi50A8d-+HtA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
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

On Mon, Feb 28, 2022 at 11:35 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Or simply add a #define for __noscs to include/linux/compiler-gcc.h
> with appropriate guard and leave the existing #ifndef in
> include/linux/compiler_types.h as is.  I'd prefer that when the
> compilers differ in terms of feature detection since it's as explicit
> as possible.

The idea is to avoid differing here to begin with, i.e. to use the
same code for both compilers (only whenever that is possible, of
course), thus having a single `#define` in a single file.

Do you think we will have to change in the future for some reason,
thus needing to split it again?

Cheers,
Miguel
