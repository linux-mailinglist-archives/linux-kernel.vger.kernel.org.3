Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC556486913
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbiAFRsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbiAFRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:48:11 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88948C061245;
        Thu,  6 Jan 2022 09:48:11 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q14so3004942qtx.10;
        Thu, 06 Jan 2022 09:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzeqOhWeVQiSHelvYCvShiD3mFgyW2CwssuqprC+wZc=;
        b=idGNcipYL7yVkj1KzDHsazAHCepCXgh/Bo2nuVTxkrM9Bziv1HKEOT5SQqW/pwvnpc
         yRiefEmmyfh1sePVatXXthUrqrHYXtj8isuXkfSMdeQDpSI6DS79XI7U9F8SQQndCgOu
         vZ/wkUf6LSRfwe1CIwl+p0/hZ5xq6tRO2+moHyGCOg6epczgFoD2zFHaU4BieAIAQ9zK
         zf1uOlRAdIqXLT5pMG4jKbiFoKwtVIS4sM92/OVgeVnpGOmlOJDB4j7Z9uOzZ2HoApdE
         gotUV7BDJoj6k6V6FyBajvKhf5XdM+oA0NYG7RSuLmoA5wblnghtO7SMCJJWq7mT7hdZ
         mXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzeqOhWeVQiSHelvYCvShiD3mFgyW2CwssuqprC+wZc=;
        b=zXbnjDaCw6V8x7SvAMF6/oP6OwfjdvqBlmgsH6xYQ0e6/grIeMR4H2AqGJFaqcN8uD
         idBAiItuB3kCou4dvt7wJGw35uTylO17om+5py7WEqj16emC9bUZC3RqJeeEEKIsH+4Y
         OL1uyWpvtpY53TxSa0ohC+4oUo+BLtR3GAUQhJz5+nTWNb95TsC1bWOhDkO7d6W0Qdz2
         vjOKvyGSrVMqbbG+J/ShQtMQf2pzKeqISfqMOo8s33T2HJJTHExkflGY83zNllWgqLmA
         0Oyy0zpxF93zHU28FiTBQXvIJWm4aiY6l8fftT2hC5YmxeNLZm411ukpyA5bedHNQ3gd
         9XNg==
X-Gm-Message-State: AOAM531urMBRLJx/jOXWqqPIFoJXz1/RuyZm+vkJFnL7sKeFf+IIZha+
        TfsiKBxtPr179IesGSKoCrVhdhyKNZGpYQ==
X-Google-Smtp-Source: ABdhPJxy81icM8T2h1gX796roVS9zK67zGnXuHaXxmfAAYS9UyrQ8kHbjxVbW6iV2h9TgzYC2YJVLg==
X-Received: by 2002:ac8:5f84:: with SMTP id j4mr53732481qta.271.1641491290443;
        Thu, 06 Jan 2022 09:48:10 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id u19sm1709227qke.1.2022.01.06.09.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:48:10 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v6 0/3] mmc: Add LiteSDCard mmc driver
Date:   Thu,  6 Jan 2022 12:48:00 -0500
Message-Id: <20220106174803.1773876-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

New in v6:

drivers/mmc/host/litex_mmc.c:
  - fix handling of deferred probe vs. platform_get_irq_optional()
  - don't #ifdef dma_set_mask_and_coherent(), since it automatically
    does the right thing on both 32- and 64-bit DMA capable arches
  - remove MMC_CAP2_FULL_PWR_CYCLE, add MMC_CAP2_NO_MMC to list of
    hardcoded capabilities during litex_mmc_probe()
  - hardcode mmc->ocr_avail to the full 2.7-3.6V range allowed by the
    SDCard spec (the LiteSDCard device doesn't accept software
    configuration)

>New in v5:
>
>MAINTAINERS:
>
>  - picked up a/b Mateusz
>
>Doc/dt/bindings/mmc/litex,mmc.yaml:
>
>  - picked up r/b Rob, Joel
>
>drivers/mmc/host/litex_mmc.c:
>
>  - shorten #define constant names (cosmetic, make them less unwieldy)
>  - picked up r/b Joel
>
>>New in v4:
>>
>>Doc/dt/bindings/mmc/litex,mmc.yaml:
>>
>>  - fixed `dt_binding_check` errors uncovered by Rob's script
>>
>>drivers/mmc/host/litex_mmc.c:
>>
>>  - struct litex_mmc_host fields re-ordered so that `pahole` reports
>>    no holes in either 32- or 64-bit builds
>>  - litex_mmc_set_bus_width() now encapsulates check for
>>    host->is_bus_width_set
>>  - litex_mmc_request() - factor out dma data setup into separate
>>    helper function: litex_mmc_do_dma()
>>
>>>New in v3:
>>>
>>>  MAINTAINERS:
>>>
>>>  - picked up acked-by Joel
>>>  - added listing for liteeth driver
>>>  - added Joel as additional co-maintainer (thanks!)
>>>
>>>  Doc/dt/bindings/mmc/litex,mmc.yaml:
>>>
>>>  - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>>>    bindings document (please let me know if that was premature, and
>>>    happy to take further review if needed :)
>>>  - add dedicated DT property for source clock frequency
>>>
>>>  drivers/mmc/host/litex_mmc.c:
>>>
>>>  - fixed function signature (no line split), and naming (litex_mmc_*)
>>>  - more informative MODULE_AUTHOR() entries
>>>    - also added matching "Copyright" entries in file header
>>>  - fixed description in Kconfig
>>>  - fixed DT documentation
>>>  - removed magic constants
>>>  - removed litex_map_status(), have sdcard_wait_done() return *real*
>>>    error codes directly instead.
>>>  - streamlined litex_mmc_reponse_len()
>>>  - call litex_mmc_set_bus_width() only once, and ensure it returns
>>>    correct error code(s)
>>>  - use readx_poll_timeout() -- more concise -- instead of
>>>    read_poll_timeout()
>>>  - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
>>>  - litex_mmc_setclk() will update host->clock before returning
>>>  - separate irq initialization into its own function,
>>>    litex_mmc_irq_init()
>>>  - document rationale for f_min, f_max
>>>  - use dmam_alloc_coherent(), which simplifies cleanup significantly
>>>  - large `if (data) { ... }` block in litex_mmc_request() left as-is,
>>>    there are too many variables shared with the rest of the parent
>>>    function body to easily separate (e.g., `len`, `transfer`, `direct`).
>>>    If this is indeed a blocker, I can take another shot at refactoring
>>>    it in a future revision!
>>>  - bump dma_set_mask_and_coherent() to 64-bits on suitable
>>>    architectures
>>>  - clock source picked up from dedicated DT clock reference property
>>>  - remove gpio card-detect logic (needs testing and a dt binding
>>>    example before being eligible for upstream inclusion)
>>>
>>>> New in v2:
>>>>   - reword info message in litex_set_clk()
>>>>   - streamline code in litex_map_status()
>>>>   - fix typos in Kconfig (thanks Randy Dunlap <rdunlap@infradead.org>)
>>>>   - improvements suggested by Stafford Horne <shorne@gmail.com>
>>>>     - allow COMPILE_TEST in Kconfig
>>>>     - use read_poll_timeout() when waiting for cmd/data/DMA
>>>>       xfer completion
>>>>   - include interrupt.h (thanks kernel test robot <lkp@intel.com>)

Gabriel Somlo (3):
  MAINTAINERS: co-maintain LiteX platform
  dt-bindings: mmc: Add bindings for LiteSDCard
  mmc: Add driver for LiteX's LiteSDCard interface

 .../devicetree/bindings/mmc/litex,mmc.yaml    |  72 ++
 MAINTAINERS                                   |   9 +-
 drivers/mmc/host/Kconfig                      |   9 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/litex_mmc.c                  | 659 ++++++++++++++++++
 5 files changed, 748 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c

-- 
2.31.1

