Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415D847595A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbhLONIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbhLONIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:08:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DDDC061574;
        Wed, 15 Dec 2021 05:08:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 8so21644038qtx.5;
        Wed, 15 Dec 2021 05:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GLmrtVY3mlw6PxvKrp+ryQ5RNIZJBHhbkDOOk/zN8M=;
        b=FnPw2FcRZk6yy3HprbrUHUBXaIeRDx35/RhIjGq9AwUpFolrHBJGJtX4aqeN15UdxK
         febrifzQtxOokU/C2mweJVi2AphspoqMH2x2HbQChkqgtKi5eSGQBi4mInNhDTsWOIkJ
         P2aUvMsK/wxfA5yfwSj5hyAPm4Er2MsYfEN3mJYQ5im/tWzAflKI7cv07jbZj+vPeMCf
         jwQ+JtH+f/zC69jL6qiahz3CXsmXU2XCNFulgo6qVXMv3s/b0DoiEWg+yFykk/7NNpbr
         w9hz23GN8//HzH9LLSM42H7QUHpH4PMGt086K2K9c3SR2ntBiApAzDZ+RCES9P/3ccwF
         T72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GLmrtVY3mlw6PxvKrp+ryQ5RNIZJBHhbkDOOk/zN8M=;
        b=XISA1D8ttaeosYhEsQbQyN/0R3Shgs/DTlGCN/mQVtQpBUjuVC0SsprAA/AB6CNCt8
         nKeAyGhNt0DYLVHSbDujvp0iuaTcCx4WPA4ehQ4FqT/4PL/f06Z+kw6D+IOdHOyk75w7
         LCrMkUBTlUoI4h77yHCk6pP4tqUP+lDH/8YtuEnO9lOpHKnH92X7M3rnBq/Wr8itT5Wy
         8NOncmuS6AHFXFx43b/ONXDF9xOlE/sTpQC5Zer9sB1hXTC+FffcClvtcGYPyAS4DHYa
         vEgGIv+aX/Nc5X7vCj1YZ0XrfIujHfNkX6xdptal4nB+/msMmKrF9GCnfYZru9bCM+mD
         kaHw==
X-Gm-Message-State: AOAM531sgmgkIayVDGP6txS3bgawAPlZrhdGy09PX+UmuzMqXfYx8VlI
        lqERrPGsP+EbyXetf4VqdJ30kQ1fRlmCjQ==
X-Google-Smtp-Source: ABdhPJxXDdsg3L4nNkBiiLfEDRhc3E3DjaFoGsPam430WLVBMt6N3ziIPss5P8QbgQl1D3gOxl/Gew==
X-Received: by 2002:ac8:5fd0:: with SMTP id k16mr11407365qta.521.1639573699486;
        Wed, 15 Dec 2021 05:08:19 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j12sm1594897qta.54.2021.12.15.05.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:07:36 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v5 0/3] mmc: Add LiteSDCard mmc driver
Date:   Wed, 15 Dec 2021 08:07:08 -0500
Message-Id: <20211215130711.111186-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

New in v5:

MAINTAINERS:

  - picked up a/b Mateusz

Doc/dt/bindings/mmc/litex,mmc.yaml:

  - picked up r/b Rob, Joel

drivers/mmc/host/litex_mmc.c:

  - shorten #define constant names (cosmetic, make them less unwieldy)
  - picked up r/b Joel

>New in v4:
>
>Doc/dt/bindings/mmc/litex,mmc.yaml:
>
>  - fixed `dt_binding_check` errors uncovered by Rob's script
>
>drivers/mmc/host/litex_mmc.c:
>
>  - struct litex_mmc_host fields re-ordered so that `pahole` reports
>    no holes in either 32- or 64-bit builds
>  - litex_mmc_set_bus_width() now encapsulates check for
>    host->is_bus_width_set
>  - litex_mmc_request() - factor out dma data setup into separate
>    helper function: litex_mmc_do_dma()
>
>>New in v3:
>>
>>  MAINTAINERS:
>>
>>  - picked up acked-by Joel
>>  - added listing for liteeth driver
>>  - added Joel as additional co-maintainer (thanks!)
>>
>>  Doc/dt/bindings/mmc/litex,mmc.yaml:
>>
>>  - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>>    bindings document (please let me know if that was premature, and
>>    happy to take further review if needed :)
>>  - add dedicated DT property for source clock frequency
>>
>>  drivers/mmc/host/litex_mmc.c:
>>
>>  - fixed function signature (no line split), and naming (litex_mmc_*)
>>  - more informative MODULE_AUTHOR() entries
>>    - also added matching "Copyright" entries in file header
>>  - fixed description in Kconfig
>>  - fixed DT documentation
>>  - removed magic constants
>>  - removed litex_map_status(), have sdcard_wait_done() return *real*
>>    error codes directly instead.
>>  - streamlined litex_mmc_reponse_len()
>>  - call litex_mmc_set_bus_width() only once, and ensure it returns
>>    correct error code(s)
>>  - use readx_poll_timeout() -- more concise -- instead of
>>    read_poll_timeout()
>>  - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
>>  - litex_mmc_setclk() will update host->clock before returning
>>  - separate irq initialization into its own function,
>>    litex_mmc_irq_init()
>>  - document rationale for f_min, f_max
>>  - use dmam_alloc_coherent(), which simplifies cleanup significantly
>>  - large `if (data) { ... }` block in litex_mmc_request() left as-is,
>>    there are too many variables shared with the rest of the parent
>>    function body to easily separate (e.g., `len`, `transfer`, `direct`).
>>    If this is indeed a blocker, I can take another shot at refactoring
>>    it in a future revision!
>>  - bump dma_set_mask_and_coherent() to 64-bits on suitable
>>    architectures
>>  - clock source picked up from dedicated DT clock reference property
>>  - remove gpio card-detect logic (needs testing and a dt binding
>>    example before being eligible for upstream inclusion)
>>
>>> New in v2:
>>>   - reword info message in litex_set_clk()
>>>   - streamline code in litex_map_status()
>>>   - fix typos in Kconfig (thanks Randy Dunlap <rdunlap@infradead.org>)
>>>   - improvements suggested by Stafford Horne <shorne@gmail.com>
>>>     - allow COMPILE_TEST in Kconfig
>>>     - use read_poll_timeout() when waiting for cmd/data/DMA
>>>       xfer completion
>>>   - include interrupt.h (thanks kernel test robot <lkp@intel.com>)

Gabriel Somlo (3):
  MAINTAINERS: co-maintain LiteX platform
  dt-bindings: mmc: Add bindings for LiteSDCard
  mmc: Add driver for LiteX's LiteSDCard interface

 .../devicetree/bindings/mmc/litex,mmc.yaml    |  72 ++
 MAINTAINERS                                   |   9 +-
 drivers/mmc/host/Kconfig                      |   9 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/litex_mmc.c                  | 652 ++++++++++++++++++
 5 files changed, 741 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c

-- 
2.31.1

