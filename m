Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5E5A5AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiH3Erf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiH3Erc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:47:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32BAB4F9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r22so9623650pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/b4XTCSmASmcmXWYN+QoQmuk6ptlc7NOGx3fVn0HIvc=;
        b=agLFlbQx6jF9QmcGj/HcN/B4W0gUvv3ONgKioHftXcDXr9GQWnQ4lraS+pn6hJTd0X
         x5YUfzKAGw0LIvoyZxC4nruig6UaCtZBV7xpRNsofBkNIlU1zSyUWTbKM7xRd8EsnSMR
         szEETqdqlGEcvWnl1W2ttzvrowZ8Y6GxHuJC49Y3AU5qWexqHLSH5uy+VYnbTLKagFUe
         JyCBosGdbmmmaFUubyhCoAjqdRP5+XBedaV9igQzPKWtKeJiglwjqtAmUR2MGzu3u4SV
         75taJTI2HvYQ2YLgQlMriGryHIoEGaG/cIpPNE5abQnj0KTU1YlXWM+f1FHtlM+J725d
         1BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/b4XTCSmASmcmXWYN+QoQmuk6ptlc7NOGx3fVn0HIvc=;
        b=ETnWbSTmOeaur25awND48nYru4ecuQOJV6Lkf7UkMDv10A1xAeugB6j00smw0gwmJT
         QFQkyqUvZBUpUp7T0GkOLs2ezzKNQWpUgkw5GZm9Z2QBdU0/wGTr0yNpjj9CJUOd4vKn
         oN5I8+7TX7BUBgXLjouU1CZbfLqHwe4dbiGiy/aOoYLjmJ8YLMKOx8vIbGJiApmckSDS
         xLIQ8db95NWhovE+vRYWTV7YvJt39PQctuTWtAZ46A3D6H+vhIITFvUbj0qamfauMWwN
         rVGrrY4eLOn7QgabyMQXaNbPOLB1eB6f12hJq2npP5uPwRED0tRTmOG4+vicuRO3Tat0
         gnRw==
X-Gm-Message-State: ACgBeo2jRopdPWSL3y1j6IbWrQ6FxA6yY9MbIUpTvQ3TP+3nMAy/Rcw9
        OC3XZANaW3mXnbd83skuV3leKw==
X-Google-Smtp-Source: AA6agR7CYibaFU7E3W+MayVq1XBf019nhVormO9jRUAcvfkWaUo2MBQRrD6wT+/Ii9xPcKDYzhQGsA==
X-Received: by 2002:a05:6a00:180b:b0:536:816b:f770 with SMTP id y11-20020a056a00180b00b00536816bf770mr20015644pfa.3.1661834849979;
        Mon, 29 Aug 2022 21:47:29 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.23])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0041cd5ddde6fsm592240pga.76.2022.08.29.21.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:47:29 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 0/4] Add PMEM support for RISC-V
Date:   Tue, 30 Aug 2022 10:16:38 +0530
Message-Id: <20220830044642.566769-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux NVDIMM PEM drivers require arch support to map and access the
persistent memory device. This series adds RISC-V PMEM support using
recently added Svpbmt and Zicbom support.

These patches can also be found in riscv_pmem_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Fix error reported by test bot
   https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/

Anup Patel (4):
  RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
  RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
  RISC-V: Implement arch specific PMEM APIs
  RISC-V: Enable PMEM drivers

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/configs/defconfig        |  1 +
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/include/asm/io.h         | 10 ++++++++
 arch/riscv/include/asm/pgtable.h    |  2 ++
 arch/riscv/mm/Makefile              |  1 +
 arch/riscv/mm/cacheflush.c          | 39 +++++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c     | 38 ----------------------------
 arch/riscv/mm/pmem.c                | 21 ++++++++++++++++
 9 files changed, 77 insertions(+), 38 deletions(-)
 create mode 100644 arch/riscv/mm/pmem.c

-- 
2.34.1

