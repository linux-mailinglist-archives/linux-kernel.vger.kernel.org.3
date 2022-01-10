Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A848A342
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbiAJW4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345540AbiAJW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:56:32 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D1C06173F;
        Mon, 10 Jan 2022 14:56:31 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b85so17175637qkc.1;
        Mon, 10 Jan 2022 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SskPr+2ElCxrniy6s8sDNpZWQ147ZDyNp6OOzb+wBiw=;
        b=cTDE70OzZuqwsdhn48BZB5jsTZyYsgMDuD6bhdVDDL95t9jo6HSwvHD6Kk4oGOQLWR
         yoRxPqUyeaoKhNJr4fbY79r9TgKTRCoA7JXQzTxiLe99qljLSQUmMqWs7zd0c09PtF5U
         eP3pDThaqh04dcXna4eJYIWIKLS2KI9sfrUvuusvWeI93GpCEmbR9xIT31FBEh/9hUhK
         1zAENXJXzKZgqXGKz2fHuiarH9ymFqRo+DbJaJob350c769HOurGcwaQ2FqYVuz1qQwm
         0aOWfIiQWrZo47ZXB1bEDhTTNY2paQX9AI6Dy/8qwDel44YdKmLHiZxR/oBkaxnCXwjd
         igxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SskPr+2ElCxrniy6s8sDNpZWQ147ZDyNp6OOzb+wBiw=;
        b=ypzZV4FDCxNBHlMIA3fpGlsMDFPYQYRrQPOUdtrYF5qPdbJ5EHb8VlBLlUVQKrxNHK
         zjLp8uOurmFONWax8AHr2SEZ2GA+YQfk05r9HI3rp4CgGPBJFU4rx3hETXNHlJqP0YDS
         b9JJeOblNDoaExQvWnuAGT3PSH2O4Gp5G8L6cgvz8F3Y1kW64Fa8lv5YwpxcJ0R+DlXI
         dfNnrAgZfIzY/uHO+xFtTXG9oP4Bl8b9AVS9stq9YtYbC+dY9L48LAGGBhA8/VIObl3i
         RrchP/k61T4DrRdnz+VAf5XbQr7XwA7gaR7NV/FNgZABR4ZV9uofEmn7JR+5RkNKivN5
         Lbmw==
X-Gm-Message-State: AOAM5330gnTdqfGd6JYQVXH7NwuM8c9kVRr8b0HGOz7JE8sVs+SZ/1TM
        3crPvXj5S/YQrS2EuSDWgcwn4ax1qlNZMg==
X-Google-Smtp-Source: ABdhPJwUKuU2cuWIH3sx4yPhPZriI2AWNEdl8JBrzXRPYFLNoppF8M5eZTU4yD14PhsnZT46Ug49Pg==
X-Received: by 2002:a05:620a:25cf:: with SMTP id y15mr1472792qko.21.1641855390605;
        Mon, 10 Jan 2022 14:56:30 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id w12sm986617qtj.64.2022.01.10.14.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:56:30 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v12 0/3] mmc: Add LiteSDCard mmc driver
Date:   Mon, 10 Jan 2022 17:56:20 -0500
Message-Id: <20220110225623.2786104-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

New in v12:
drivers/mmc/host/Kconfig:
  - add dependency on HAVE_CLK for litex_mmc driver
  - (re)add "If unsure, say N" to the litex_mmc driver help message
drivers/mmc/host/litex_mmc.c:
  - prints message using dev_info() before returning success from probe()

>New in v11:
>  - picked up r/b from Andy
>drivers/mmc/host/litex_mmc.c:
>  - defensive coding of litex_mmc_interrupt() return logic
>  - remove `dev` member of `struct litex_mmc_host`, only used during probe
>
>>New in v10:
>>drivers/mmc/host/litex_mmc.c:
>>  - group `linux/mmc/*` includes by themselves
>>  - clean-up of `return` style (multiple locations throughout source)
>>  - create `mmc_free_host()` wrapper for use with
>>    `devm_add_action_or_reset()`
>>  - use GFP_KERNEL with `dmam_alloc_coherent()`
>>
>>>New in v9:
>>>drivers/mmc/host/Kconfig:
>>>  - fix OF dependency
>>>drivers/mmc/host/litex_mmc.c:
>>>  - remove `linux/of.h` include, no longer needed since dropping
>>>    `of_match_ptr()`
>>>  - add `linux/mod_devicetable.h` include
>>>  - use devm_action_or_reset() to devm-ify mmc_alloc_host(), and obviate
>>>    the need to call mmc_free_host() explicitly during either probe()
>>>    error path or during remove()
>>>
>>>>New in v8:
>>>>commit blurbs:
>>>>  - cosmetic editing of descriptions
>>>>  - removed `Cc:` lines
>>>>drivers/mmc/host/litex_mmc.c:
>>>>  - fix file header comment (for real, this time)
>>>>  - add explicit `bits.h` include
>>>>  - remove `of_match_ptr()` wrapper from around .of_match_table argument
>>>>  - fix devm ordering issues: use `devm_request_irq()`, which precludes
>>>>    the need to call `free_irq()` on `probe()` error path or from `remove()`
>>>>
>>>>>New in v7:
>>>>>
>>>>>drivers/mmc/host/Kconfig:
>>>>>  - added module name in LiteSDCard Kconfig entry
>>>>>
>>>>>drivers/mmc/host/litex_mmc.c:
>>>>>  - fixed comment formatting, ordering, and capitalization throughout
>>>>>    the entire file
>>>>>  - sorted header #include statements
>>>>>  - removed redundant parantheses in readx_poll_timeout() condition
>>>>>  - explicit handling of readx_poll_timeout() timeout scenarios
>>>>>  - dev_err() used in litex_mmc_sdcard_wait_done()
>>>>>  - use memcpy_fromio() to grab command response
>>>>>  - no need to apply 0xffff mask to a 32-bit value right-shifted by 16
>>>>>    (host->resp[3])
>>>>>  - use clamp() instead of min(max(...)...)
>>>>>  - reworked platform_get_irq_optional() error handling logic
>>>>>  - no need to explicitly zero host->irq, kzalloc() does that already
>>>>>  - added missing free_irq() in litex_mmc_probe() error path
>>>>>  - reordered calls inside litex_mmc_remove() (calling mmc_free_host()
>>>>>    before free_irq()
>>>>>
>>>>>>New in v6:
>>>>>>
>>>>>>drivers/mmc/host/litex_mmc.c:
>>>>>>  - fix handling of deferred probe vs. platform_get_irq_optional()
>>>>>>  - don't #ifdef dma_set_mask_and_coherent(), since it automatically
>>>>>>    does the right thing on both 32- and 64-bit DMA capable arches
>>>>>>  - remove MMC_CAP2_FULL_PWR_CYCLE, add MMC_CAP2_NO_MMC to list of
>>>>>>    hardcoded capabilities during litex_mmc_probe()
>>>>>>  - hardcode mmc->ocr_avail to the full 2.7-3.6V range allowed by the
>>>>>>    SDCard spec (the LiteSDCard device doesn't accept software
>>>>>>    configuration)
>>>>>>
>>>>>>>New in v5:
>>>>>>>
>>>>>>>MAINTAINERS:
>>>>>>>
>>>>>>>  - picked up a/b Mateusz
>>>>>>>
>>>>>>>Doc/dt/bindings/mmc/litex,mmc.yaml:
>>>>>>>
>>>>>>>  - picked up r/b Rob, Joel
>>>>>>>
>>>>>>>drivers/mmc/host/litex_mmc.c:
>>>>>>>
>>>>>>>  - shorten #define constant names (cosmetic, make them less unwieldy)
>>>>>>>  - picked up r/b Joel
>>>>>>>
>>>>>>>>New in v4:
>>>>>>>>
>>>>>>>>Doc/dt/bindings/mmc/litex,mmc.yaml:
>>>>>>>>
>>>>>>>>  - fixed `dt_binding_check` errors uncovered by Rob's script
>>>>>>>>
>>>>>>>>drivers/mmc/host/litex_mmc.c:
>>>>>>>>
>>>>>>>>  - struct litex_mmc_host fields re-ordered so that `pahole` reports
>>>>>>>>    no holes in either 32- or 64-bit builds
>>>>>>>>  - litex_mmc_set_bus_width() now encapsulates check for
>>>>>>>>    host->is_bus_width_set
>>>>>>>>  - litex_mmc_request() - factor out dma data setup into separate
>>>>>>>>    helper function: litex_mmc_do_dma()
>>>>>>>>
>>>>>>>>>New in v3:
>>>>>>>>>
>>>>>>>>>  MAINTAINERS:
>>>>>>>>>
>>>>>>>>>  - picked up acked-by Joel
>>>>>>>>>  - added listing for liteeth driver
>>>>>>>>>  - added Joel as additional co-maintainer (thanks!)
>>>>>>>>>
>>>>>>>>>  Doc/dt/bindings/mmc/litex,mmc.yaml:
>>>>>>>>>
>>>>>>>>>  - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>>>>>>>>>    bindings document (please let me know if that was premature, and
>>>>>>>>>    happy to take further review if needed :)
>>>>>>>>>  - add dedicated DT property for source clock frequency
>>>>>>>>>
>>>>>>>>>  drivers/mmc/host/litex_mmc.c:
>>>>>>>>>
>>>>>>>>>  - fixed function signature (no line split), and naming (litex_mmc_*)
>>>>>>>>>  - more informative MODULE_AUTHOR() entries
>>>>>>>>>    - also added matching "Copyright" entries in file header
>>>>>>>>>  - fixed description in Kconfig
>>>>>>>>>  - fixed DT documentation
>>>>>>>>>  - removed magic constants
>>>>>>>>>  - removed litex_map_status(), have sdcard_wait_done() return *real*
>>>>>>>>>    error codes directly instead.
>>>>>>>>>  - streamlined litex_mmc_reponse_len()
>>>>>>>>>  - call litex_mmc_set_bus_width() only once, and ensure it returns
>>>>>>>>>    correct error code(s)
>>>>>>>>>  - use readx_poll_timeout() -- more concise -- instead of
>>>>>>>>>    read_poll_timeout()
>>>>>>>>>  - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
>>>>>>>>>  - litex_mmc_setclk() will update host->clock before returning
>>>>>>>>>  - separate irq initialization into its own function,
>>>>>>>>>    litex_mmc_irq_init()
>>>>>>>>>  - document rationale for f_min, f_max
>>>>>>>>>  - use dmam_alloc_coherent(), which simplifies cleanup significantly
>>>>>>>>>  - large `if (data) { ... }` block in litex_mmc_request() left as-is,
>>>>>>>>>    there are too many variables shared with the rest of the parent
>>>>>>>>>    function body to easily separate (e.g., `len`, `transfer`, `direct`).
>>>>>>>>>    If this is indeed a blocker, I can take another shot at refactoring
>>>>>>>>>    it in a future revision!
>>>>>>>>>  - bump dma_set_mask_and_coherent() to 64-bits on suitable
>>>>>>>>>    architectures
>>>>>>>>>  - clock source picked up from dedicated DT clock reference property
>>>>>>>>>  - remove gpio card-detect logic (needs testing and a dt binding
>>>>>>>>>    example before being eligible for upstream inclusion)
>>>>>>>>>
>>>>>>>>>> New in v2:
>>>>>>>>>>   - reword info message in litex_set_clk()
>>>>>>>>>>   - streamline code in litex_map_status()
>>>>>>>>>>   - fix typos in Kconfig (thanks Randy Dunlap <rdunlap@infradead.org>)
>>>>>>>>>>   - improvements suggested by Stafford Horne <shorne@gmail.com>
>>>>>>>>>>     - allow COMPILE_TEST in Kconfig
>>>>>>>>>>     - use read_poll_timeout() when waiting for cmd/data/DMA
>>>>>>>>>>       xfer completion
>>>>>>>>>>   - include interrupt.h (thanks kernel test robot <lkp@intel.com>)

Gabriel Somlo (3):
  MAINTAINERS: co-maintain LiteX platform
  dt-bindings: mmc: Add bindings for LiteSDCard
  mmc: Add driver for LiteX's LiteSDCard interface

 .../devicetree/bindings/mmc/litex,mmc.yaml    |  72 ++
 MAINTAINERS                                   |   9 +-
 drivers/mmc/host/Kconfig                      |  11 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/litex_mmc.c                  | 663 ++++++++++++++++++
 5 files changed, 754 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c

-- 
2.31.1

