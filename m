Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9E5ADF51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiIFGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiIFGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:01:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71EE6DF8C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:00:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c9so15362934ybf.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 23:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dVgxTZ8rakP42g8vhCO3njeR/uRGYZNUUx4gShIILwI=;
        b=d5kvgH2al2OzGC3Spb+XGYBBgJ8Mm3xF808v2cmMFnU1xLOoRQA1O8WMwDdihc92M5
         pUEv0pk58+n2FJOnauWMMiUVOLfTQFcXt3C0p9xdRDWTV2oc7VmLJtkJP6ltuwHFAjWa
         k7Mce8yApzVuKrgcPGcGlJKVzv+L7kp83eUQzZV39wsCezAUJMlTUkLS/x5MCJlI0xfm
         KyMb3YRNyUpuo2gDRdUWW2bo3Op/mmCtFoHp/xWm6hu8ZtI9/eRx4ByXrC68Kqo2O0LI
         7g5gOwSlPWos1y5l9tI4FKYGDrcjXP9vGElk7Sk5h7awDPHdIHLtRpqx32YcUapuOioQ
         gO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dVgxTZ8rakP42g8vhCO3njeR/uRGYZNUUx4gShIILwI=;
        b=Q+hC7FXd4b5/4U9xDOiwIMo8SJVR5+0xSmVKFGzGOiTmfmeCvnt0Vypo2XlSB0LFU3
         wMW3yj1cPYs+HBa1aQGrxI88HKfiLsQfcDIb9QBNULVTs+ZEi8i8rO4RggO1527KHBq2
         CDcWEo5xhRElqLIoXuemiNg6pPTGm0yZmtuxC6iJOW6qR78mFcuHrSes4aDWF/1guqMc
         hb/QB8bugVo2gE798b5Gr5xGaxj5+/BFhY7czAas5FNPSa/0AXn+XA+dEV/oR4RDDW+L
         DZiKA+GXMqmIIw/uveJDVLpVNtLksr6VgxjrJ/k0aDrL3oHEOYbh7cvP8vTbP+Md7ovu
         jaPg==
X-Gm-Message-State: ACgBeo0LvoltRqSjEaYNKq6Gu+SXGzdG3Ydwzq3Z85TeobSSDTleIa/s
        Kc8QzDw+6UZEVq4gRORuGcf/mfuKW5dpCuGFkZyRFw==
X-Google-Smtp-Source: AA6agR6H7ZaNY+warUhZhyAV9xv4cf03bKqoY92Ggt4rv/7N5rkwicu6vEp+repqTe/aMzeM+7QruB3NXr28ULn5MCY=
X-Received: by 2002:a25:b983:0:b0:695:d8b4:a5a3 with SMTP id
 r3-20020a25b983000000b00695d8b4a5a3mr36413414ybg.553.1662444051930; Mon, 05
 Sep 2022 23:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <676398f0aeecd47d2f8e3369ea0e95563f641a36.1662416260.git.andreyknvl@google.com>
In-Reply-To: <676398f0aeecd47d2f8e3369ea0e95563f641a36.1662416260.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 6 Sep 2022 08:00:00 +0200
Message-ID: <CANpmjNN2T=uufbrj3ghr7S6k5E=YxvNpkq2Qa8qCY9NfPeeRsg@mail.gmail.com>
Subject: Re: [PATCH] kasan: move tests to mm/kasan/
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 00:18, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Move KASAN tests to mm/kasan/ to keep the test code alongside the
> implementation.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks - this is overdue, and follows what newer KUnit tests do.

> ---
>  MAINTAINERS                                             | 1 -
>  lib/Makefile                                            | 5 -----
>  mm/kasan/Makefile                                       | 8 ++++++++
>  lib/test_kasan.c => mm/kasan/kasan_test.c               | 2 +-
>  lib/test_kasan_module.c => mm/kasan/kasan_test_module.c | 2 +-
>  5 files changed, 10 insertions(+), 8 deletions(-)
>  rename lib/test_kasan.c => mm/kasan/kasan_test.c (99%)
>  rename lib/test_kasan_module.c => mm/kasan/kasan_test_module.c (99%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 589517372408..31b3e4b11e01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10938,7 +10938,6 @@ F:      arch/*/include/asm/*kasan.h
>  F:     arch/*/mm/kasan_init*
>  F:     include/linux/kasan*.h
>  F:     lib/Kconfig.kasan
> -F:     lib/test_kasan*.c
>  F:     mm/kasan/
>  F:     scripts/Makefile.kasan
>
> diff --git a/lib/Makefile b/lib/Makefile
> index ffabc30a27d4..928d7605c35c 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -65,11 +65,6 @@ obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
>  obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
>  obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
>  obj-$(CONFIG_TEST_IDA) += test_ida.o
> -obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
> -CFLAGS_test_kasan.o += -fno-builtin
> -CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
> -obj-$(CONFIG_KASAN_MODULE_TEST) += test_kasan_module.o
> -CFLAGS_test_kasan_module.o += -fno-builtin
>  obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
>  CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
>  UBSAN_SANITIZE_test_ubsan.o := y
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 1f84df9c302e..d4837bff3b60 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -35,7 +35,15 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>
> +CFLAGS_KASAN_TEST := $(CFLAGS_KASAN) -fno-builtin $(call cc-disable-warning, vla)
> +
> +CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
> +CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
> +
>  obj-y := common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
>  obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o report_tags.o
>  obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o report_tags.o
> +
> +obj-$(CONFIG_KASAN_KUNIT_TEST) += kasan_test.o
> +obj-$(CONFIG_KASAN_MODULE_TEST) += kasan_test_module.o
> diff --git a/lib/test_kasan.c b/mm/kasan/kasan_test.c
> similarity index 99%
> rename from lib/test_kasan.c
> rename to mm/kasan/kasan_test.c
> index 505f77ffad27..f25692def781 100644
> --- a/lib/test_kasan.c
> +++ b/mm/kasan/kasan_test.c
> @@ -25,7 +25,7 @@
>
>  #include <kunit/test.h>
>
> -#include "../mm/kasan/kasan.h"
> +#include "kasan.h"
>
>  #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
>
> diff --git a/lib/test_kasan_module.c b/mm/kasan/kasan_test_module.c
> similarity index 99%
> rename from lib/test_kasan_module.c
> rename to mm/kasan/kasan_test_module.c
> index b112cbc835e9..e4ca82dc2c16 100644
> --- a/lib/test_kasan_module.c
> +++ b/mm/kasan/kasan_test_module.c
> @@ -13,7 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>
> -#include "../mm/kasan/kasan.h"
> +#include "kasan.h"
>
>  static noinline void __init copy_user_test(void)
>  {
> --
> 2.25.1
>
