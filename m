Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C634E467594
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbhLCKxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhLCKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:53:31 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E442C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 02:50:08 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso2608176otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 02:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvFMOe4+E5sHgDjCmqD90UCfomOIQ0LaYkILiIgPB9o=;
        b=rcwRganNXf7eJcZ6+q0InM+L35qinz1ZGtnGnby3aSX8RQGYFqi2B+zSO365XeGqNO
         /KrHgVPg2kRh4brVRDbI+J7QQGwBzz3wyUi27oLkRoymYJ+Yh7ZTjN423N/DtvBCP19C
         U8z9h9N6/70nZxFy2ipKbQrFGlri1KM10M7tDRlO1a1/uFqdX4tpixAZN41xkD8czVSt
         thqm7jPcbIvYHRgj8vWaBaGuUZ9jge9Ud14T0pRmhHBuJWs+SSGaLYdENbX78qMjlsJ0
         jv0BIUC4rh7Bjqt+bnhF5WxmzxPjOBIhPvQ0fAnKwoK4CkNkAAmF8OMbg/PyccVCZUQx
         Wvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvFMOe4+E5sHgDjCmqD90UCfomOIQ0LaYkILiIgPB9o=;
        b=VJxw+CIveIIxvULEcCQ7v+1HbOeO6CHJDtcvaw7h3PZkeDiSDyAlRzm6x5FiZNXqz+
         XuGDeKBfRlQAGQCkK4LU71FsiWPRkrE4rzv+a7mp4FAOMPc7YNAS66EpQ3b7DwrtBRjI
         y9KpIEeI0RfFGtgJOvtS5ygH9skH0z8QasyyKJch/rxT3n7f4BzOPWBfohelhXP048NA
         rts5ePauPNFbIcizypB/+vC6OgI8YwmplMtETz/0pnyh5v1HJUYEx/stf+dH2GVsojkY
         wr6y/Tzmig2nNNodkHiJblt9ngyLMrdan7dDZM0+MgCaG1gHQ/Kwf/kbyu90tt8rpsrv
         NUpA==
X-Gm-Message-State: AOAM533EiOdTVfXuK3jfPYp/2M+M6yilMlpSFKouXzxBSdQiEJE5iphr
        qVs/bYAvn+WXu23lSZk8ZZitVclsNg0COoCktlK2YA==
X-Google-Smtp-Source: ABdhPJyMWdDC7BH93naPYdh6EY5o2OwXQTEijMK8dDSVABZjgzC3Z+NoYyOTNFdVp7l7xwdrlkIzZk1ORM5c1NKaiVo=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr15709351otl.329.1638528606600;
 Fri, 03 Dec 2021 02:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20211203093000.3714620-1-keescook@chromium.org>
In-Reply-To: <20211203093000.3714620-1-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 3 Dec 2021 11:49:53 +0100
Message-ID: <CANpmjNPCjXp_0iQjdznpvS2vF-VvDkxJrtWnBAoj6TAU488VAQ@mail.gmail.com>
Subject: Re: [PATCH] lib/test_ubsan: Silence compile-time array bounds warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 at 10:30, Kees Cook <keescook@chromium.org> wrote:
> The UBSAN tests intentionally operate beyond array bounds, so silence
> the warning visible with a -Warray-bounds build:
>
> lib/test_ubsan.c: In function 'test_ubsan_object_size_mismatch':
> lib/test_ubsan.c:109:16: error: array subscript 'long long int[0]' is partly outside array bounds of 'volatile int[1]' [-Werror=array-bounds]
>   109 |         val2 = *ptr;
>       |                ^~~~
> lib/test_ubsan.c:104:22: note: while referencing 'val'
>   104 |         volatile int val __aligned(8) = 4;
>       |                      ^~~
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 08959b10bac9..2742a54a4275 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_KASAN_MODULE_TEST) += test_kasan_module.o
>  CFLAGS_test_kasan_module.o += -fno-builtin
>  obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
>  CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
> +CFLAGS_test_ubsan.o += $(call cc-disable-warning, array-bounds)
>  UBSAN_SANITIZE_test_ubsan.o := y
>  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
>  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o

Are there other warnings or only the one for the fsanitize=object-size
test? I think this is fine if there are other warnings.

But, if it's only about the fsanitize=object-size test, I'm going to
propose something more drastic. :-)

I had wanted to wait a bit and dig a little deeper, but I just posted
part of my analysis here:
https://bugzilla.kernel.org/show_bug.cgi?id=214861#c4

My proposal is to remove UBSAN_OBJECT_SIZE and its related tests. The
bugzilla bug goes into the details, but the TLDR is:
1. fsanitize=object-size is incomplete,
2. it should have been a compiler warning,
3. for everything else there is KASAN which detects real OOB,
4. for GCC we already disable UBSAN_OBJECT_SIZE.

Thanks,
-- Marco
