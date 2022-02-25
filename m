Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8C4C4FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiBYUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiBYUsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:48:06 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA9035DFA;
        Fri, 25 Feb 2022 12:47:30 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d62so7880517iog.13;
        Fri, 25 Feb 2022 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhQ6lKdQCvPa4Z8KH2JlJuyb4CM5CfZt3HGbqFOgQ4M=;
        b=eegCtk9huTZTwXDWkYjkVEEZ5pesUUXBxlnsi20xEbSGwmTDenbsGqD7FfXQ4quQLR
         oMGFfxk/+95IXHOck2zsyXN9Qb3MFG2FbcA85EPpUe+F17Yuygbvg6sQGrL97ZhV2W8k
         RzU0LhY94wy+yc3uEEpLo09XXGh2GNaHtSlnrSz8Z0S+q81auadodsbblVnJWqjKXgV+
         c9dO4Uz3tJE1MgCgr9V/hS/ihJXCOhe5c2Kt0s9hWOiQxoeuiYsBbVC/yjG2b2Ywy1Wb
         6yaH70PUTXqYA6jrN8dOMYZpAxBE7Lyyzan1KInNNGh2YlRcjGpaS0qG1aqPO201F4V1
         sIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhQ6lKdQCvPa4Z8KH2JlJuyb4CM5CfZt3HGbqFOgQ4M=;
        b=7vFZEY9BI09CSdjPus1whgNV5p6H6zymr/tq+qKFEXGBMO7vINNpZGw6rkSP4Wq/ca
         tfu8u3hCVNDEMGjsdWldieMicKS/tdh1kqBT00UToWH3GE0mGDVkhETKWjEzP4z/Z0kc
         a7WxgrKRIzCFzTdClNlbKEGzYvYSY0G5MwOhm1yAVqKl9OhIt+JMgaUGP1jeuYE0JHei
         hM763IMC72dnrJqgFNHIjRgcKhyNJOII4WeKgu7QHuTUoK8APup5/kJClLwiFR1+/yOd
         pU7Wx8mUvpjUnLuYimxjqDSdZ0PwxQrASg6ZZvR60n0FZVI+DJp6cD9HWiVkRALw7mET
         Yc4g==
X-Gm-Message-State: AOAM5307qUfdqdDB7Ajk8KdoDEnVVNbZZfADJO2c8+mgf370cTxADdqg
        lSfqgogPxHBwta4k+x6uNiXx+IDeprIgg8Xnm/o=
X-Google-Smtp-Source: ABdhPJwMci6YtjBxOjakzW01EpDicV5XGJJDGczqNUCY1aXcEKVD0okYOyZY2SmasQNuCV5U0S3wfTU6mAJiYqXfSz0=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr6737452iow.172.1645822050350; Fri, 25
 Feb 2022 12:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
In-Reply-To: <20220225032410.25622-1-ashimida@linux.alibaba.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 25 Feb 2022 21:47:19 +0100
Message-ID: <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, Feb 25, 2022 at 4:24 AM Dan Li <ashimida@linux.alibaba.com> wrote:
>
> +         - Clang (https://clang.llvm.org/docs/ShadowCallStack.html)
> +         - GCC (https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options)

Maybe Clang: and GCC: instead of the parenthesis?

> +#ifdef CONFIG_SHADOW_CALL_STACK
> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> +#endif

Since both compilers have it, and I guess the `#ifdef` condition would
work for both, could this be moved into `compiler_types.h` where the
empty `__noscs` definition is, and remove the one from
`compiler-clang.h`?

Cheers,
Miguel
