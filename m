Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C67508472
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbiDTJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377004AbiDTJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:07:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA43CA45
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:04:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so777656wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzUTcyuR4EzojyRzvTXUG1XF06DkhMoidKVpipah/8Y=;
        b=Xeq7nxTW0NMv1nTmouN5a0lh9dtODuAwqT4va/5gkVvqvMOKfSLin6+zOIt+rphri0
         v/2HI60lNb/ds8Gqu5XjCEVAaPhD3PhIyAuWpROENDnohocZxNn/qVzbWbJpzGC1045C
         jCY1pyE2CRNAk+35IXDoIC53PPeRqqBt4PBCshXTcViW8+SZp76LS1tH5cUoijw8VUfX
         7/o/sAAdX8bygGHQfcghLPj+7yNAs34lUMZ+tooQ7Ejlgb6Wh42II61bRSgDYgLlcv5T
         ay759u0oSZCYw9I9o6pnGPL2qxA5Kn+Mg/LT6cz/9zM82dDmt5RFgokfMI8mvSUNpboe
         Wkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzUTcyuR4EzojyRzvTXUG1XF06DkhMoidKVpipah/8Y=;
        b=u9N4zRd5qVBoGjs5P/aM5pOEe+T+YFUF20u08M6+CTa7je12nqbIVoYFY9aX1eODiU
         dpPzNNoQHDIw9IkuoL13iYAB12c9XvBWd6wHZ1lsss904uFXuJ+s03hcgD5dyv14fdY8
         ukxiV83z+ESJBJbzo+rgJkg4u3cXaY3NdzZJg69pr2p6McYRcIhdIYsFBkcNw5N/2BNW
         rR72QCWb9xa7pOXDmWGPu3ahWqsyMP+qz2yL1PegHfxW+gsM7zP4T/mWaKpnoWH5T5yz
         Awl+lRO/yC0awtwolnETOThO0DvsrkscVPsSPSkfx5zkWrFisKtKX/K62IxfiKJH+xqD
         3Qiw==
X-Gm-Message-State: AOAM531Yxe/97Lj60MOjYh394WORsItxBEL5RGS6j80jCPHJ0KuD9KmL
        qo9Q47drIEhlNVmkLNy4kC4zCA==
X-Google-Smtp-Source: ABdhPJwoLaeIFc4j1IlTUrwWy1FEVbVOq51maMCj2rJKeVsyeWsccAD5idOM5fvgDNJOZwnvqUfniQ==
X-Received: by 2002:a1c:7710:0:b0:38e:b248:6000 with SMTP id t16-20020a1c7710000000b0038eb2486000mr2620861wmi.39.1650445454920;
        Wed, 20 Apr 2022 02:04:14 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:7d9b:e7a5:8aea:d5ae])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d6da5000000b0020a880e5e9fsm9644074wrs.29.2022.04.20.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:04:14 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:04:07 +0200
From:   Marco Elver <elver@google.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH] xtensa: enable KCSAN
Message-ID: <Yl/Mh4gjG1hYW2nA@elver.google.com>
References: <20220416081355.2155050-1-jcmvbkbc@gmail.com>
 <CANpmjNNW0kLf2Ou6i_dNeRLO=Qrru4bOEfJ=be=Dfig4wnQ67g@mail.gmail.com>
 <CAMo8BfJM0JHqh8Nz3LuK7Ccu7WB1Cup0mX+RYvO1yft_K4hyLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJM0JHqh8Nz3LuK7Ccu7WB1Cup0mX+RYvO1yft_K4hyLQ@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:59PM -0700, Max Filippov wrote:
[...]
> > The stubs are the only thing I don't understand. More elaboration on
> > why this is required would be useful (maybe there's another way to
> > solve?).
> 
> It doesn't build without it, because the compiler left function calls
> in the code:
> 
> xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
> `__tsan_atomic32_compare_exchange_val':
> kernel/kcsan/core.c:1262: undefined reference to `__atomic_load_8'
> xtensa-de233_fpu-elf-ld: kernel/kcsan/core.o: in function
> `__tsan_atomic64_load':
[...]
> 
> None of these functions are called because xtensa doesn't have
> 64-bit atomic ops.
> 
> I guess that another way to fix it would be making
> DEFINE_TSAN_ATOMIC_OPS(64);
> conditional and not enabling it when building for xtensa.

I see - however, it seems the kernel provides 64-bit atomics to xtensa
using lib/atomic64.c:

	arch/xtensa/Kconfig:    select GENERIC_ATOMIC64

So the right thing to do might be to implement the builtin atomics using
the kernel's atomic64_* primitives. However, granted, the builtin
atomics might not be needed on xtensa (depending on configuration).
Their existence is due to some compiler instrumentation emitting
builtin-atomics (Clang's GCOV), folks using them accidentally and
blaming KCSAN (also https://paulmck.livejournal.com/64970.html).

So I think it's fair to leave them to BUG() until somebody complains (at
which point they need to be implemented). I leave it to you.

> > > Disable KCSAN instrumentation in arch/xtensa/boot.
> >
> > Given you went for barrier instrumentation, I assume you tested with a
> > CONFIG_KCSAN_STRICT=y config?
> 
> Yes.
> 
> > Did the kcsan_test pass?
> 
> current results are the following on QEMU:
> 
>      # test_missing_barrier: EXPECTATION FAILED at
> kernel/kcsan/kcsan_test.c:1313
>      Expected match_expect to be true, but is false
>      # test_atomic_builtins_missing_barrier: EXPECTATION FAILED at
> kernel/kcsan/kcsan_test.c:1356
>      Expected match_expect to be true, but is false
>  # kcsan: pass:27 fail:2 skip:0 total:29
>  # Totals: pass:193 fail:4 skip:0 total:197
> 
> and the following on the real hardware:
> 
>     # test_concurrent_races: EXPECTATION FAILED at kernel/kcsan/kcsan_test.c:762
>     Expected match_expect to be true, but is false
>     # test_write_write_struct_part: EXPECTATION FAILED at
> kernel/kcsan/kcsan_test.c:910
>     Expected match_expect to be true, but is false
>     # test_assert_exclusive_access_writer: EXPECTATION FAILED at
> kernel/kcsan/kcsan_test.c:1077
>     Expected match_expect_access_writer to be true, but is false
>     # test_assert_exclusive_bits_change: EXPECTATION FAILED at
> kernel/kcsan/kcsan_test.c:1098
>     Expected match_expect to be true, but is false
>     # test_assert_exclusive_writer_scoped: EXPECTATION FAILED at
> kernel/kcsan/kcsan_test.c:1136
>     Expected match_expect_start to be true, but is false
>     # test_missing_barrier: EXPECTATION FAILED at kernel/kcsan/kcsan_test.c:1313
>     Expected match_expect to be true, but is false
>     # test_atomic_builtins_missing_barrier: EXPECTATION FAILED at
> kernel/kcsan/kcsan_test.c:1356
>     Expected match_expect to be true, but is false
> # kcsan: pass:22 fail:7 skip:0 total:29
> # Totals: pass:177 fail:20 skip:0 total:197

Each test case is run with varying number of threads - am I correctly
inferring that out of all test cases, usually only one such run failed,
and runs with different number of threads (of the same test case)
succeeded?

If that's the case, I think we can say that it works, and the failures
are due to flakiness with either higher or lower threads counts. I know
that some test cases might still be flaky under QEMU TCG because of how
it does concurrent execution of different CPU cores.

Thanks,
-- Marco
