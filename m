Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBED516F20
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384768AbiEBL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiEBL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:57:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65BB1A044
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:54:13 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i38so25514041ybj.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=450+a8YD7aZQ0EGwCGQKaHlnNFXghGzV04RemoibDz0=;
        b=V+y9BcKPTPPewHAowP0m9B4NF9B2bPaEnby0teZKw0gCUMoO/0/BCRPcnFs1FRNZx+
         ZrOFb8tsHaTMwN4FDqA/ZRJasiUiJcxNlpRJLQAEubEcmFMIHrA4+iuuWDxEECasppS7
         CJ5EQ+4nK2fvi8Yk8q4L/IXNbyPVL478KJ74W3MU5pGhbOmmCYD9vVcUieHdTvOD4EGy
         oad/Fzx9zwJ4WqLJhMQ9mqhs4lMrh2XdyOwimlkhqD9Ks7OxkRTsWIgbxny9q1tNtdDP
         pyC/NCSZLbfKrCV/HmElBs9I79Ehuo3/+juuijxCkdow80Ex7E5AaUs2UwXO1gs8k3Va
         5XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=450+a8YD7aZQ0EGwCGQKaHlnNFXghGzV04RemoibDz0=;
        b=ksSE8B1bQxr0pHaBYG1D43c7CevePNgKimIVKmMUhON4pgQ+Bg5gC3Ae+pf8h8f4h3
         1TAKPRLfu3PgnfTzaOQUJhCV3EisKi4hQb5Ak5I5UGZx2uBDDZfwNGwC8SkCCY+ixqpM
         yFRp/fuswG0rfQLq6JY3A2TrEQeT3+ubDL1c3/khvwcyGTfeJ3sGI087gZVHaszGWWmv
         U8736Lm4lXEPQvbNsuQiUDyotOXBqimI3f8Q8LbgqbFLDaF++6JcMKJFfzJ5qMyoQqCU
         Am8RwRyNpOa34ewcx9/sYuXni/HmHu1snDh3NZ7ZTkMAaHqSSXbMXLnFwwGJLGRPsrVe
         FE3g==
X-Gm-Message-State: AOAM5318bZUNuJfIDjJfelxjq1cTYAtPVTvHem1YHGu4Pz8dFJvJhIFW
        1TOh5Y3Ml48BLGvyWBqRHVwFssiK8x1peuRsKZ2IZLGXOes9wA==
X-Google-Smtp-Source: ABdhPJxTUvo0GQhDgWM8GuEQ4ebpQT8+1plB7ML+kfOwbJaylX/Ujo5HfIclJo1hBLTC/jH/9soCUcwSmJX/Cr22u8Q=
X-Received: by 2002:a25:6652:0:b0:645:d4c1:eb7 with SMTP id
 z18-20020a256652000000b00645d4c10eb7mr9786088ybm.412.1651492452482; Mon, 02
 May 2022 04:54:12 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 May 2022 17:24:01 +0530
Message-ID: <CA+G9fYuD_pcr4eyFSNg+XCf8TpdU+m6yRKugCoOp+pFRAdAo=w@mail.gmail.com>
Subject: [arm] lib: bitmap.sh: BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@google.com>, decot@googlers.com,
        "Tobin C. Harding" <tobin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel BUG KFENCE noticed on qemu_arm while testing lib: bitmap.sh
with kselftest merge config build image [1] & [2].

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
  git_describe: v5.18-rc5
  kernel_version: 5.18.0-rc5
  kernel-config: https://builds.tuxbuild.com/28a2wdk3XzmLVGqD5njLS4uX1tm/config
  artifact-location: https://builds.tuxbuild.com/28a2wdk3XzmLVGqD5njLS4uX1tm
  toolchain: gcc-10


Test log:
---------
# selftests: lib: bitmap.sh
[   36.266913] test_bitmap: loaded.
[   36.269151] test_bitmap: parselist: 14: input is '0-2047:128/256'
OK, Time: 4600
[   36.273024] ==================================================================
[   36.275942] BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48
[   36.275942]
[   36.279808] Out-of-bounds read at 0x9ec8e937 (4096B right of kfence-#29):
[   36.283046]  _find_next_bit_le+0x10/0x48
[   36.285030]
[   36.285816] kfence-#29: 0xf28dd28d-0x0b305c8e, size=4096, cache=kmalloc-4k
[   36.285816]
[   36.289807] allocated by task 498 on cpu 1 at 36.272960s:
[   36.292432]  test_bitmap_printlist+0x2c/0x13c [test_bitmap]
[   36.295174]  test_bitmap_init+0x5c/0xefc [test_bitmap]
[   36.297709]  do_one_initcall+0x70/0x330
[   36.299605]  do_init_module+0x4c/0x26c
[   36.301484]  sys_finit_module+0xdc/0x138
[   36.303452]  ret_fast_syscall+0x0/0x1c
[   36.305294]  0xbebec788
[   36.306516]
[   36.307264] CPU: 1 PID: 498 Comm: modprobe Not tainted 5.18.0-rc5 #1
[   36.310304] Hardware name: Generic DT based system
[   36.312658] ==================================================================
[   36.316609] test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
[   36.316609] ', Time: 43635540
[   36.333605] test_bitmap: all 1945 tests passed
[   36.360116] test_bitmap: unloaded.
# bitmap: ok

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4975877#L995
[2] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.18-rc5/testrun/9320073/suite/linux-log-parser/test/check-kernel-bug-4975877/log
