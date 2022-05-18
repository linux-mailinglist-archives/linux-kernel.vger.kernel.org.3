Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5421D52B606
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiERJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiERJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:22:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F313E17
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:21:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso2020969wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7rVBmjBPaKbFzXGI4xWzGXS+NQnq3w6fFhrEq69SdrY=;
        b=ZK4oh48gXj4V3dPWp2vzwMdwq3jKKNuOmSLL4nyFijwM1DBeK3iDzOiMZtGVOVEIsd
         e/nb7Ca2Bu7/wBVG0/Ydu9i9Ekgw6VqiJ3JMhc3Exb1Mq878PkZ4ld8/YMSGizAj2Ufc
         mi14jlynUtnVsD3z+zDch7fA3cZBmBEVejdmIi+AXOALqoxqmnENW+yOO2ZJkhwz7qIj
         hR0+++aq9fXz2sREMs+9cr8tJuwQRF+PVM22DHGGFQRlUh94fmBXpzstec59/X5XNe33
         xyw7H0Flr4CHS003ywfPlWjuWL2IZd/ah0anbVxJ1U7Sfjf7Ja4ALM+cTx4at4E35PLN
         O9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rVBmjBPaKbFzXGI4xWzGXS+NQnq3w6fFhrEq69SdrY=;
        b=ydwhFrN5jEjM9ZtfHc48VL7e9YcHEZeCnqR416YWE4w8Tx9Lcq5CrdICM0g2EjRE8b
         pYZshYIfEJbzAhvLCU1FfUTLe+kJeBk057PAutyxJvB6F5H3KtY83NyTRwAP1lwhNMr6
         vCFbVpBt3HbATjBGawg+l80pTXSMeMbKKYU5uOq5GA9lGa2F8pn8We9+ZsqN/4gYryxD
         wmwltmYqRh8vsxkcSadcZIo+PDliJVOHtKdIAiNV7D44CFMoD4s0gziAERQuGmNytaSh
         BR0PJxlwd7C5phxPvR81eMX73e7C8AU062Ejs90zwGgS2kqh/MYr/sKVgX8u0Fwxa4Ht
         8f4A==
X-Gm-Message-State: AOAM532oM83QJyTLlpG8/JiVb8rz+1Gt9CUHuIGhwjK9NujPwqqug1Yp
        ssRdM++QWtp1xOFwSJL+lRQK5g==
X-Google-Smtp-Source: ABdhPJwwgRhvjrCB/gJi1PFaz8DYLADl44GS8EzEhiuRkkzgxLe01tB7n7P1rCE7RojJIetcvXzYMw==
X-Received: by 2002:a05:600c:4f13:b0:394:8978:7707 with SMTP id l19-20020a05600c4f1300b0039489787707mr36021295wmq.34.1652865717906;
        Wed, 18 May 2022 02:21:57 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:450f:9c92:a170:5581])
        by smtp.gmail.com with ESMTPSA id n7-20020adfc607000000b0020c6a524fe0sm1409185wrg.98.2022.05.18.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:21:57 -0700 (PDT)
Date:   Wed, 18 May 2022 11:21:50 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
Message-ID: <YoS6rthXi9VRXpkg@elver.google.com>
References: <20220518073232.526443-1-davidgow@google.com>
 <20220518073232.526443-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518073232.526443-2-davidgow@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
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

On Wed, May 18, 2022 at 03:32PM +0800, David Gow wrote:
> Add a .kunitconfig file, which provides a default, working config for
> running the KCSAN tests. Note that it needs to run on an SMP machine, so
> to run under kunit_tool, the x86_64-smp qemu-based setup should be used:
> ./tools/testing/kunit/kunit.py run --arch=x86_64-smp --kunitconfig=kernel/kcsan
> 
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks for adding this.

> ---
>  kernel/kcsan/.kunitconfig | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 kernel/kcsan/.kunitconfig
> 
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

Note, KCSAN_STRICT implies KCSAN_WEAK_MEMORY.

Also, a bunch of the test cases' outcomes depend on KCSAN's
"strictness". I think to cover the various combinations would be too
complex, but we can just settle on testing KCSAN_STRICT=y.

The end result is the same, but you could drop the
CONFIG_KCSAN_WEAK_MEMORY=y line, and let the latest KCSAN_STRICT
defaults decide (I don't expect them to change any time soon).

If you want it to be more explicit, it's also fine leaving the
CONFIG_KCSAN_WEAK_MEMORY=y line in.

> +# This prevents the test from timing out on many setups. Feel free to remove
> +# (or alter) this, in conjunction with setting a different test timeout with,
> +# for example, the --timeout kunit_tool option.
> +CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
> -- 
> 2.36.0.550.gb090851708-goog
> 
