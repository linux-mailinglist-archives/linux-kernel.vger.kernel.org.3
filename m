Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C6580E88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiGZIHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGZIHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:07:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AAB2B1A8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:07:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o13so1839307edc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPpfPzEfkaH/DAxlv4YpUMCrqo4JJIKHjJP/Tdj1qsc=;
        b=ZTDShWMSIpO+K5aDdsP3PaORf+TOqh67JQ2rXzK0jh9LoBDfAiELXAfWeBtWdjLlAv
         UUO9Lq3cAe/0PGrQVj7nKz4GQbSZcJ82lUqMen2NU/9dn7F9ip6UX8oL8zXBrjJoD5Mh
         fstJDoVK1Wns8OoPmkoooRSoJaRJ2ZqZxGVKy5yl2Rq9sEo5WOsPlUmqNqg147s8M6UG
         s/eCPigRwpaQw3CYpFVxvMVIfAXtYL4nUeF29ZLMhWnumW/JGYB2tvo6j0o23RzQRlIi
         382mO0J/d3g+GfzjrvVBUhta4/1p1U2XIJuBuhVhJvYIqeu1cZLnX/K1JDlBNZyVJFpm
         QSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPpfPzEfkaH/DAxlv4YpUMCrqo4JJIKHjJP/Tdj1qsc=;
        b=W8pO57jNWbpw6LOHbvrr92w/zrdxG9m2UPBVLT4KDH8i3xtKCkDBwA7g5Dfp01T2l9
         n4PhHF429n+CkD/6FpIhgtfo3F/C4sI+NHPqRieIEPRtseqTE47TIm1Rx5r96RpXllki
         z2+xmgv7/jPEhsWxrwxahGaAXi9cguvr0ICAtUQolnL84lD5do6C4kB7DOtqC/OowPDm
         ahzzqCCS5De+jBkYjJ3AL2GGDQ0AKXzk2eqAZxIqBn2/BjdeaAjPdfUvyFdF1hAiPDfj
         EhVxs/Zm0QMCxqQDgK6OEEDRMeODhm6iD4bdT3DFumPtq5eiw/3oeCGHtTnO3Uxu22j5
         aeRA==
X-Gm-Message-State: AJIora/sSro9eyAcggEAqo1l4nvZMgdjYMnQAnLms3K7FqhAiG70r/CX
        oyjV8Llyd+SR8yx+lN6tI/G6FA0s3/icXjD/c7E=
X-Google-Smtp-Source: AGRyM1va5bJezG2AlV7JDDBBM0PCq1kn7W/ABDMasJ//2+C5ERRcQOFVfGw0sNfXmhwcJb/v8gYhV+jxHi07WE3KWMo=
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id
 w5-20020a05640234c500b0043a8f90e643mr16958490edc.88.1658822865859; Tue, 26
 Jul 2022 01:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <202207251140.M7YAqoLC-lkp@intel.com>
In-Reply-To: <202207251140.M7YAqoLC-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 10:07:09 +0200
Message-ID: <CAHp75Vf0LjA8+JQNmKNYTe-1U58mSUsTiqQWbLAcrBXWs8NGjQ@mail.gmail.com>
Subject: Re: drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of
 packed member 'data' of class or structure 'tsc2046_adc_atom' may result in
 an unaligned pointer value
To:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems yet another false positive from Clang.

On Mon, Jul 25, 2022 at 5:55 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Oleksij,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e0dccc3b76fb35bb257b4118367a883073d7390e
> commit: 9374e8f5a38defe90bc65b2decf317c1c62d91dd iio: adc: add ADC driver for the TI TSC2046 controller
> date:   1 year, 2 months ago
> config: arm-randconfig-r025-20220724 (https://download.01.org/0day-ci/archive/20220725/202207251140.M7YAqoLC-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9374e8f5a38defe90bc65b2decf317c1c62d91dd
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9374e8f5a38defe90bc65b2decf317c1c62d91dd
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iio/adc/ drivers/staging/ fs/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]

What the heck? The get_unaligned_*() is exactly to get unaligned data.

>            return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>                                                                        ^~~~~~~~~
>    include/linux/bitfield.h:108:27: note: expanded from macro 'FIELD_GET'
>                    __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
>                                            ^~~~
>    include/linux/bitfield.h:52:38: note: expanded from macro '__BF_FIELD_CHECK'
>                    BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
>                                                       ^~~~
>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                                             ^~~~
>    note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:308:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
>    include/linux/compiler.h:56:47: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>                                                  ^~~~
>    include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>                                                       ^~~~
> >> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]
>            return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>                                                                        ^~~~~~~~~
>    include/linux/bitfield.h:108:27: note: expanded from macro 'FIELD_GET'
>                    __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
>                                            ^~~~
>    include/linux/bitfield.h:52:38: note: expanded from macro '__BF_FIELD_CHECK'
>                    BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
>                                                       ^~~~
>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                                             ^~~~
>    note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:308:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
>    include/linux/compiler.h:56:47: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>                                                  ^~~~
>    include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>                                                                ^~~~
> >> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]
>            return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>                                                                        ^~~~~~~~~
>    include/linux/bitfield.h:108:27: note: expanded from macro 'FIELD_GET'
>                    __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
>                                            ^~~~
>    include/linux/bitfield.h:52:38: note: expanded from macro '__BF_FIELD_CHECK'
>                    BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
>                                                       ^~~~
>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                                             ^~~~
>    note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler.h:56:47: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>                                                  ^~~~
>    include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>                                                                                         ^~~~
>    include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
>            (cond) ?                                        \
>             ^~~~
>    3 warnings generated.
>
>
> vim +242 drivers/iio/adc/ti-tsc2046.c
>
>    239
>    240  static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
>    241  {
>  > 242          return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
>    243  }


-- 
With Best Regards,
Andy Shevchenko
