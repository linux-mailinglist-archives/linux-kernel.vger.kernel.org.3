Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF83248846F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiAHQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiAHQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:11:41 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A4FC06173F;
        Sat,  8 Jan 2022 08:11:40 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id ke6so8816376qvb.1;
        Sat, 08 Jan 2022 08:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AL/Bx8UMXyQlCkUrSicGo4pW7ZJL2mCK5cAhXfv5OVI=;
        b=k87D5hBZUwthNZd9Tp7EI7FsSezhcRbiSU6CXd0blfL6MTmqBG2Qux4+yBqGcdk+i9
         jm0LBAsFOPKMUzsobhxC9slA5RqQBJTnJpK5MdWL5/rtUIrVseErOrE/Ml1kGpq1NOOD
         1ddCwHhWLSak3YO67tiYGLBwGlwMnd9XTf/zEt1kaBkWS90ym2BVCiM7Vgo7frUXvbaR
         3HPrG3gAImWm+fYJjdLuNgcky8X1m471C9dWiVvLdJy5ca2tv4L98GQG1vCv0XT4nr3W
         CffXrL2dBsSoRdKkvkLL9xCtVbmv668izyVlef57grmsdz8RDifwkgbnj5JAu5n/GqqT
         vZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AL/Bx8UMXyQlCkUrSicGo4pW7ZJL2mCK5cAhXfv5OVI=;
        b=ZDcwDGfmfZMri8N5Jb57I3MQehNeRItgqxLNZkZGuIrp6q/3GFQCvdwjBQwL+bfpXf
         TA26ymXs3oK0utUFnJDFzcgcDE7rr2HyejlMsLMRL/75pfV9zxz/YKlwDdgLPi9cUdGm
         fEjV/849kFVhTh0wxygr40idG/maDqp0jT9hICBpMc/UbEA+dXibhb63ABYlxvyxn155
         OpUyavRFQsJtsyQRlkwKB7Yh4/D/asaExnjm4EX4iB7+HV4GzBABZ6qSTH3n0tQiPXI9
         hYqM4Dj3bUX1bt9MsFwZfA6n/3lWLaJPeFY/+joyGaENKlS/dRAfJougZxHVoNpG9BQ6
         rNuA==
X-Gm-Message-State: AOAM533z44TmihvJddyqokyWdVkVIqhD88Jxjsx6qGlCjzVgl9fzauEo
        iEKaEob64OptcaXK2jDsWbHJTZ1PtI6p2w==
X-Google-Smtp-Source: ABdhPJxqhtd76hvkEFEundTjJSb25MKze5rGgYOzakzblC3bAOuaCcTnIhTV0VSQdRq02EqZSsdElw==
X-Received: by 2002:a05:6214:dcf:: with SMTP id 15mr62109812qvt.47.1641658299655;
        Sat, 08 Jan 2022 08:11:39 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id bs9sm1207435qkb.87.2022.01.08.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:11:39 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v9 0/3] mmc: Add LiteSDCard mmc driver
Date:   Sat,  8 Jan 2022 11:11:31 -0500
Message-Id: <20220108161134.2419279-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

New in v9:

drivers/mmc/host/Kconfig:
  - fix OF dependency
drivers/mmc/host/litex_mmc.c:
  - remove `linux/of.h` include, no longer needed since dropping
    `of_match_ptr()`
  - add `linux/mod_devicetable.h` include
  - use devm_action_or_reset() to devm-ify mmc_alloc_host(), and obviate
    the need to call mmc_free_host() explicitly during either probe()
    error path or during remove()

>New in v8:
>commit blurbs:
>  - cosmetic editing of descriptions
>  - removed `Cc:` lines
>drivers/mmc/host/litex_mmc.c:
>  - fix file header comment (for real, this time)
>  - add explicit `bits.h` include
>  - remove `of_match_ptr()` wrapper from around .of_match_table argument
>  - fix devm ordering issues: use `devm_request_irq()`, which precludes
>    the need to call `free_irq()` on `probe()` error path or from `remove()`
>
>>New in v7:
>>
>>drivers/mmc/host/Kconfig:
>>  - added module name in LiteSDCard Kconfig entry
>>
>>drivers/mmc/host/litex_mmc.c:
>>  - fixed comment formatting, ordering, and capitalization throughout
>>    the entire file
>>  - sorted header #include statements
>>  - removed redundant parantheses in readx_poll_timeout() condition
>>  - explicit handling of readx_poll_timeout() timeout scenarios
>>  - dev_err() used in litex_mmc_sdcard_wait_done()
>>  - use memcpy_fromio() to grab command response
>>  - no need to apply 0xffff mask to a 32-bit value right-shifted by 16
>>    (host->resp[3])
>>  - use clamp() instead of min(max(...)...)
>>  - reworked platform_get_irq_optional() error handling logic
>>  - no need to explicitly zero host->irq, kzalloc() does that already
>>  - added missing free_irq() in litex_mmc_probe() error path
>>  - reordered calls inside litex_mmc_remove() (calling mmc_free_host()
>>    before free_irq()
>>
>>>New in v6:
>>>
>>>drivers/mmc/host/litex_mmc.c:
>>>  - fix handling of deferred probe vs. platform_get_irq_optional()
>>>  - don't #ifdef dma_set_mask_and_coherent(), since it automatically
>>>    does the right thing on both 32- and 64-bit DMA capable arches
>>>  - remove MMC_CAP2_FULL_PWR_CYCLE, add MMC_CAP2_NO_MMC to list of
>>>    hardcoded capabilities during litex_mmc_probe()
>>>  - hardcode mmc->ocr_avail to the full 2.7-3.6V range allowed by the
>>>    SDCard spec (the LiteSDCard device doesn't accept software
>>>    configuration)
>>>
>>>>New in v5:
>>>>
>>>>MAINTAINERS:
>>>>
>>>>  - picked up a/b Mateusz
>>>>
>>>>Doc/dt/bindings/mmc/litex,mmc.yaml:
>>>>
>>>>  - picked up r/b Rob, Joel
>>>>
>>>>drivers/mmc/host/litex_mmc.c:
>>>>
>>>>  - shorten #define constant names (cosmetic, make them less unwieldy)
>>>>  - picked up r/b Joel
>>>>
>>>>>New in v4:
>>>>>
>>>>>Doc/dt/bindings/mmc/litex,mmc.yaml:
>>>>>
>>>>>  - fixed `dt_binding_check` errors uncovered by Rob's script
>>>>>
>>>>>drivers/mmc/host/litex_mmc.c:
>>>>>
>>>>>  - struct litex_mmc_host fields re-ordered so that `pahole` reports
>>>>>    no holes in either 32- or 64-bit builds
>>>>>  - litex_mmc_set_bus_width() now encapsulates check for
>>>>>    host->is_bus_width_set
>>>>>  - litex_mmc_request() - factor out dma data setup into separate
>>>>>    helper function: litex_mmc_do_dma()
>>>>>
>>>>>>New in v3:
>>>>>>
>>>>>>  MAINTAINERS:
>>>>>>
>>>>>>  - picked up acked-by Joel
>>>>>>  - added listing for liteeth driver
>>>>>>  - added Joel as additional co-maintainer (thanks!)
>>>>>>
>>>>>>  Doc/dt/bindings/mmc/litex,mmc.yaml:
>>>>>>
>>>>>>  - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>>>>>>    bindings document (please let me know if that was premature, and
>>>>>>    happy to take further review if needed :)
>>>>>>  - add dedicated DT property for source clock frequency
>>>>>>
>>>>>>  drivers/mmc/host/litex_mmc.c:
>>>>>>
>>>>>>  - fixed function signature (no line split), and naming (litex_mmc_*)
>>>>>>  - more informative MODULE_AUTHOR() entries
>>>>>>    - also added matching "Copyright" entries in file header
>>>>>>  - fixed description in Kconfig
>>>>>>  - fixed DT documentation
>>>>>>  - removed magic constants
>>>>>>  - removed litex_map_status(), have sdcard_wait_done() return *real*
>>>>>>    error codes directly instead.
>>>>>>  - streamlined litex_mmc_reponse_len()
>>>>>>  - call litex_mmc_set_bus_width() only once, and ensure it returns
>>>>>>    correct error code(s)
>>>>>>  - use readx_poll_timeout() -- more concise -- instead of
>>>>>>    read_poll_timeout()
>>>>>>  - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
>>>>>>  - litex_mmc_setclk() will update host->clock before returning
>>>>>>  - separate irq initialization into its own function,
>>>>>>    litex_mmc_irq_init()
>>>>>>  - document rationale for f_min, f_max
>>>>>>  - use dmam_alloc_coherent(), which simplifies cleanup significantly
>>>>>>  - large `if (data) { ... }` block in litex_mmc_request() left as-is,
>>>>>>    there are too many variables shared with the rest of the parent
>>>>>>    function body to easily separate (e.g., `len`, `transfer`, `direct`).
>>>>>>    If this is indeed a blocker, I can take another shot at refactoring
>>>>>>    it in a future revision!
>>>>>>  - bump dma_set_mask_and_coherent() to 64-bits on suitable
>>>>>>    architectures
>>>>>>  - clock source picked up from dedicated DT clock reference property
>>>>>>  - remove gpio card-detect logic (needs testing and a dt binding
>>>>>>    example before being eligible for upstream inclusion)
>>>>>>
>>>>>>> New in v2:
>>>>>>>   - reword info message in litex_set_clk()
>>>>>>>   - streamline code in litex_map_status()
>>>>>>>   - fix typos in Kconfig (thanks Randy Dunlap <rdunlap@infradead.org>)
>>>>>>>   - improvements suggested by Stafford Horne <shorne@gmail.com>
>>>>>>>     - allow COMPILE_TEST in Kconfig
>>>>>>>     - use read_poll_timeout() when waiting for cmd/data/DMA
>>>>>>>       xfer completion
>>>>>>>   - include interrupt.h (thanks kernel test robot <lkp@intel.com>)

Gabriel Somlo (3):
  MAINTAINERS: co-maintain LiteX platform
  dt-bindings: mmc: Add bindings for LiteSDCard
  mmc: Add driver for LiteX's LiteSDCard interface

 .../devicetree/bindings/mmc/litex,mmc.yaml    |  72 ++
 MAINTAINERS                                   |   9 +-
 drivers/mmc/host/Kconfig                      |   9 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/litex_mmc.c                  | 654 ++++++++++++++++++
 5 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c

-- 
2.31.1

