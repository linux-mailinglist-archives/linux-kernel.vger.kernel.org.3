Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F219D46D44E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhLHNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhLHNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:24:23 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A88C061746;
        Wed,  8 Dec 2021 05:20:51 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l8so2128943qtk.6;
        Wed, 08 Dec 2021 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vnumgp1YM0raJKUkErg+UDdgq13UlSoZRnKXeW6D/XQ=;
        b=NqTyXb0F+lsHO2JwF3OIdYYNB6pX9GW9bJk9Dy5O0mMOh4vx3BHRsbDayVUemulsyF
         xselFfzupHtiH2P7RlcfBTN4ZM9NVsM8FzSvN4SSSxcB0vCKhQ69amiOZdKB/eUTNdlO
         bMhYlaCLGowDee7Gds7nuNUDqbE5rmmAlRxu1YM1aYGBd98OTgO9/1y8q5L1koZG0yLG
         D3sCYrj9SZ3fiFwBI6d9uAhCOT5y0vxoub7eWMMtbhew3WJLW/yHriNZHE07vFUQPCwN
         KC1YXeT9U9B2AtKmJt2ElojYyiXanFXZLYsaz5hMdF/SnjaN/jVVhml79a7+zVnYaatV
         CdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vnumgp1YM0raJKUkErg+UDdgq13UlSoZRnKXeW6D/XQ=;
        b=hbAIOM66t2T/t90rLu9MYEFl498cR35FsiKMKmR9FGLCwg4IsEN+Ia/hbXhDj68V42
         d/YvKLN4KQkdBVhpfbToeE1Cguo4yYk9i0Xrs6BfVyNWXXdXTFD4GVJJy0x+3KKephjd
         7dJ0V1QNDeU4Wp9E2uRtFT+Q6lQLSJdZbG1j1Pbt5jpvM55dPPLROZSIJw4ZyqUDydkf
         jFDckfT9M70/OjpE6xD0r4FeT0Ew4hcDVj5RrMUV/uo0uYGJPSPv8qsV7AlEbKVkidEu
         CxK+saz0up0wmP9fmlKng1VJ9Dm49kbdY+0cG3MzHT1gjs0MlfaMda4b6KbKo/CB5njG
         9+wA==
X-Gm-Message-State: AOAM533gIW7xLKFP2tdtg4xnGbMqkIf/NfZJaupfjCajkoGw775uFXDJ
        O0RPwGVl8iMTFbfaSaU/z/BvW6SfRwiOCw==
X-Google-Smtp-Source: ABdhPJxxMisDNNOiYTd7LHEn3DLOGCwAG3geVXC+gyNwZ4lSz/NI2pOUuK5njdQQNQ//9KCdGYH1OA==
X-Received: by 2002:a05:622a:1207:: with SMTP id y7mr8315165qtx.626.1638969650628;
        Wed, 08 Dec 2021 05:20:50 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d6sm1544132qtq.15.2021.12.08.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:20:50 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v3 0/3] mmc: Add LiteSDCard mmc driver
Date:   Wed,  8 Dec 2021 08:20:39 -0500
Message-Id: <20211208132042.3226275-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

New in v3:

  MAINTAINERS:

  - picked up acked-by Joel
  - added listing for liteeth driver
  - added Joel as additional co-maintainer (thanks!)

  Doc/dt/bindings/mmc/litex,mmc.yaml:

  - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
    bindings document (please let me know if that was premature, and
    happy to take further review if needed :)
  - add dedicated DT property for source clock frequency

  drivers/mmc/host/litex_mmc.c:

  - fixed function signature (no line split), and naming (litex_mmc_*)
  - more informative MODULE_AUTHOR() entries
    - also added matching "Copyright" entries in file header
  - fixed description in Kconfig
  - fixed DT documentation
  - removed magic constants
  - removed litex_map_status(), have sdcard_wait_done() return *real*
    error codes directly instead.
  - streamlined litex_mmc_reponse_len()
  - call litex_mmc_set_bus_width() only once, and ensure it returns
    correct error code(s)
  - use readx_poll_timeout() -- more concise -- instead of
    read_poll_timeout()
  - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
  - litex_mmc_setclk() will update host->clock before returning
  - separate irq initialization into its own function,
    litex_mmc_irq_init()
  - document rationale for f_min, f_max
  - use dmam_alloc_coherent(), which simplifies cleanup significantly
  - large `if (data) { ... }` block in litex_mmc_request() left as-is,
    there are too many variables shared with the rest of the parent
    function body to easily separate (e.g., `len`, `transfer`, `direct`).
    If this is indeed a blocker, I can take another shot at refactoring
    it in a future revision!
  - bump dma_set_mask_and_coherent() to 64-bits on suitable
    architectures
  - clock source picked up from dedicated DT clock reference property
  - remove gpio card-detect logic (needs testing and a dt binding
    example before being eligible for upstream inclusion)

> New in v2:
>   - reword info message in litex_set_clk()
>   - streamline code in litex_map_status()
>   - fix typos in Kconfig (thanks Randy Dunlap <rdunlap@infradead.org>)
>   - improvements suggested by Stafford Horne <shorne@gmail.com>
>     - allow COMPILE_TEST in Kconfig
>     - use read_poll_timeout() when waiting for cmd/data/DMA
>       xfer completion
>   - include interrupt.h (thanks kernel test robot <lkp@intel.com>)

Gabriel Somlo (3):
  MAINTAINERS: co-maintain LiteX platform
  dt-bindings: mmc: Add bindings for LiteSDCard
  mmc: Add driver for LiteX's LiteSDCard interface

 .../devicetree/bindings/mmc/litex,mmc.yaml    |  72 ++
 MAINTAINERS                                   |   9 +-
 drivers/mmc/host/Kconfig                      |   9 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/litex_mmc.c                  | 644 ++++++++++++++++++
 5 files changed, 733 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c

-- 
2.31.1

