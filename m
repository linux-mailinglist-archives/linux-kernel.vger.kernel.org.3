Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D69470335
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbhLJO6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242434AbhLJO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:58:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B0C0617A1;
        Fri, 10 Dec 2021 06:54:38 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id s9so8134707qvk.12;
        Fri, 10 Dec 2021 06:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wf4BKyY2V/pYVycdF/iVPuxJUBo+0n5Ukb8K0eQFB9k=;
        b=O9jMv+DstPd3YNF26JQDDo67u8zqEd2XnFDpn1ktGI+Xb5ZhccxA1VRgCeLpy+3i+q
         Vfq2tVQFGLY2YqJGjvwYrSztXsPjVNSVb9szMcOH0ilZxHYc0vcNxiRnvEzmrHpVAuqY
         mRpdERRm1vyioWpxaAcCjeS1yAfjTJm9Ep68JMBJOliNlmtzUrz47yvGY3cKX84DQ22C
         qCOiJb6bSO7qgKvcgdi41vpTe3ffHVHDgbwMtSo/O9b5IG5yYZ92mARCfFGclJy7ZNeL
         lMDQynyDd7FcHsIwRTuB+Oet2JjCoRukKyDN0+EDz2bRyPjJTL6UPaXOkExDdumOE+eA
         yfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wf4BKyY2V/pYVycdF/iVPuxJUBo+0n5Ukb8K0eQFB9k=;
        b=D/OFIsxCRrxWLV9L6aYQwYea+Yuxm/WeUjQTqYuDmest8DLuoxv6ckg3yA2wlzohIY
         1PZ9rPAySkTbxQFMtLjM135FlbaP4sp5F+yUgntaLLSWE/yCIQ7EH7BTkEux5AJYeVS8
         i279bDPREG1lKv9m23aVd6rq012lrPGqGhkia6FF7n+E1HNtGzYU2973TvMVCoVfY2Op
         dV+LwwW5pg0prbjl++Xzf4+K5PMkcjL9P3DjcsZts/+Jmp300AQeVDV8rBddwlaYAZVC
         IhQglyGBj/hNqUi4n6HZyTnLcqEo4/LmYY0qfJ5hY7EOopHW0YcyjMHrWvisXSqQVEtg
         G20w==
X-Gm-Message-State: AOAM531s8b9cpFwSVPL+00pcQ9aCWWukMrFoPD/4NF1nieyKNwtqrDLX
        NSXp8HYvtR0sioIPJFdp+DYIgWTVGSqjJQ==
X-Google-Smtp-Source: ABdhPJxYBPATqlm2AedtfAOqYyiUmxASWxP4cwy6gkN25/SShjIaSq39miYc93hPB8rjQZ7154Jo6w==
X-Received: by 2002:a05:6214:1c85:: with SMTP id ib5mr26507493qvb.72.1639148077376;
        Fri, 10 Dec 2021 06:54:37 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id a3sm2054681qtx.59.2021.12.10.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:54:36 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v4 0/3] mmc: Add LiteSDCard mmc driver
Date:   Fri, 10 Dec 2021 09:54:27 -0500
Message-Id: <20211210145430.3707463-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

New in v4:

Doc/dt/bindings/mmc/litex,mmc.yaml:

  - fixed `dt_binding_check` errors uncovered by Rob's script

drivers/mmc/host/litex_mmc.c:

  - struct litex_mmc_host fields re-ordered so that `pahole` reports
    no holes in either 32- or 64-bit builds
  - litex_mmc_set_bus_width() now encapsulates check for
    host->is_bus_width_set
  - litex_mmc_request() - factor out dma data setup into separate
    helper function: litex_mmc_do_dma()

>New in v3:
>
>  MAINTAINERS:
>
>  - picked up acked-by Joel
>  - added listing for liteeth driver
>  - added Joel as additional co-maintainer (thanks!)
>
>  Doc/dt/bindings/mmc/litex,mmc.yaml:
>
>  - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>    bindings document (please let me know if that was premature, and
>    happy to take further review if needed :)
>  - add dedicated DT property for source clock frequency
>
>  drivers/mmc/host/litex_mmc.c:
>
>  - fixed function signature (no line split), and naming (litex_mmc_*)
>  - more informative MODULE_AUTHOR() entries
>    - also added matching "Copyright" entries in file header
>  - fixed description in Kconfig
>  - fixed DT documentation
>  - removed magic constants
>  - removed litex_map_status(), have sdcard_wait_done() return *real*
>    error codes directly instead.
>  - streamlined litex_mmc_reponse_len()
>  - call litex_mmc_set_bus_width() only once, and ensure it returns
>    correct error code(s)
>  - use readx_poll_timeout() -- more concise -- instead of
>    read_poll_timeout()
>  - use dev_err() in litex_mmc_send_cmd() (instead of pr_err())
>  - litex_mmc_setclk() will update host->clock before returning
>  - separate irq initialization into its own function,
>    litex_mmc_irq_init()
>  - document rationale for f_min, f_max
>  - use dmam_alloc_coherent(), which simplifies cleanup significantly
>  - large `if (data) { ... }` block in litex_mmc_request() left as-is,
>    there are too many variables shared with the rest of the parent
>    function body to easily separate (e.g., `len`, `transfer`, `direct`).
>    If this is indeed a blocker, I can take another shot at refactoring
>    it in a future revision!
>  - bump dma_set_mask_and_coherent() to 64-bits on suitable
>    architectures
>  - clock source picked up from dedicated DT clock reference property
>  - remove gpio card-detect logic (needs testing and a dt binding
>    example before being eligible for upstream inclusion)
>
>> New in v2:
>>   - reword info message in litex_set_clk()
>>   - streamline code in litex_map_status()
>>   - fix typos in Kconfig (thanks Randy Dunlap <rdunlap@infradead.org>)
>>   - improvements suggested by Stafford Horne <shorne@gmail.com>
>>     - allow COMPILE_TEST in Kconfig
>>     - use read_poll_timeout() when waiting for cmd/data/DMA
>>       xfer completion
>>   - include interrupt.h (thanks kernel test robot <lkp@intel.com>)

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

