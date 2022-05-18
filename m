Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334E352C181
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbiERRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiERRMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:12:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC016F939
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:12:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c12so3832148eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WoeKVgQABRiIJ4QhptJclADbVq8q7TSfdxFYu0C6EmM=;
        b=Ma9D+cIlFW04py/6cnvXihNXKKUOyruPaDKvMkEpXXLxniULao3+RFtBBFXQAHbK+X
         pSF6VcB05zYk1XftYnanS0MMJoGECNAcFBZWn63xIbWTiGw5IT0yeLFmLPF/SIv7c6Sl
         y4lcwIaZ5iJcm3YSlIlv1kw4KRuIWjp38enZpuTL6+08MtJZgIZ6p8c1Qh17ADRhFpNd
         IykMIxH5IY6v4soCsHWIARWvtxR3e6Q37uNUh2mdbVi0ltj9RvQN7dj7SDO5D3qINGVl
         MO3B4LaiuPwwE80pHp2g1XYR2lzHnrzEujVFj+t8jbwIdEwFvg1WtbII/ftjHLTA9IL/
         x4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WoeKVgQABRiIJ4QhptJclADbVq8q7TSfdxFYu0C6EmM=;
        b=yvTJERu5DxmBOk+s3KfMmHW6dwoabfVGkZQMBES7XbvOf+j4pbQc+8m5Cdm75PWwU0
         BHCz3jyTtwLMdiQtmbZaryHFHKTxqI9cjrTc0FAeyT0EwML+XLd414ycouDiurBySEjH
         NZd4hetyEUjAXNrSGUXHmh88osj88QdByx2UDHVTjLA9+/1wDClz02CCRrI4sxjkcj2+
         tYByF0G/YJ9wvp9K/co6qiuuiu57XAhkNqJCWHL0TNMhzo5/nJHuM1J+5OdhrsVdu0TO
         ZKM+KLEVuVF1Nwd0Bm1FKTvaG1AgTh4G/XEaLb7qoGNqk6l02Sk6m4fTknAFu+cJtu8G
         wimQ==
X-Gm-Message-State: AOAM530i/Z/Sp4J5sp0N43z8ru9g9aFWQY3gm/91hWQ8lAkz6C/BlP+m
        lWkR87llKE7XGWy72bfsXlVEpv2iiKxvoVFf0tOdUQ==
X-Google-Smtp-Source: ABdhPJzx1BOV2G21NGWMSsebUsdvZMFHsJ3ej189OLe2xnBCmMerviba6vUoml7QDMEl4WYVqQwW1fH9OG9i+sc8ZXA=
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id
 b10-20020a056402084a00b00426262d967emr857938edz.286.1652893964661; Wed, 18
 May 2022 10:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
In-Reply-To: <20220518073232.526443-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 18 May 2022 10:12:33 -0700
Message-ID: <CAGS_qxoVucD5N00g3Tjav5gmYQWvxndTWJYHuKY6mH4bkWXGgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 18, 2022 at 12:32 AM David Gow <davidgow@google.com> wrote:
> diff --git a/kernel/kcsan/.kunitconfig b/kernel/kcsan/.kunitconfig
> new file mode 100644
> index 000000000000..a8a815b1eb73
> --- /dev/null
> +++ b/kernel/kcsan/.kunitconfig
> @@ -0,0 +1,20 @@
> +# Note that the KCSAN tests need to run on an SMP setup.
> +# Under kunit_tool, this can be done by using the x86_64-smp
> +# qemu-based architecture:
> +# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan --arch=x86_64-smp

Just noting here, if we go with --qemu_args [1], then we'd change this to
  --arch=x86_64 --qemu_args='-smp 8'
and then probably add
  CONFIG_SMP=y
to this file.

[1] https://lore.kernel.org/linux-kselftest/20220518170124.2849497-1-dlatypov@google.com

> +
> +CONFIG_KUNIT=y
> +
> +CONFIG_DEBUG_KERNEL=y
> +
> +CONFIG_KCSAN=y
> +CONFIG_KCSAN_KUNIT_TEST=y
> +
> +# Needed for test_barrier_nothreads
> +CONFIG_KCSAN_STRICT=y
> +CONFIG_KCSAN_WEAK_MEMORY=y
> +
> +# This prevents the test from timing out on many setups. Feel free to remove
> +# (or alter) this, in conjunction with setting a different test timeout with,
> +# for example, the --timeout kunit_tool option.
> +CONFIG_KCSAN_REPORT_ONCE_IN_MS=100

Tangent:

Ah this reminds me, unfortunately you can't use --kconfig_add to
overwrite this atm.
Right now, it'll just blindly try to append and then complain that one
of the two copies of the option is missing.

That might be a feature to look into.
Or at least, we can maybe give a better error message.

E.g. with the default kunitconfig, the error currently looks like
# Try to overwrite CONFIG_KUNIT_ALL_TESTS=y
$ ./tools/testing/kunit/kunit.py config --kconfig_add=CONFIG_KUNIT_ALL_TESTS=m
...
ERROR:root:Not all Kconfig options selected in kunitconfig were in the
generated .config.
This is probably due to unsatisfied dependencies.
Missing: CONFIG_KUNIT_ALL_TESTS=m
