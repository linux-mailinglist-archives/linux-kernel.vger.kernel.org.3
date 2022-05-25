Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9E533FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiEYPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiEYPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:11:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07660AF324
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j21so18926632pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+qNACW8/gTTgXjb8nsD8aEJ/snZ/Vsd31nRuBosZqE=;
        b=D/ZoD/NZW550gq+SNsQc5HqAlO4qKmEDbX5diUWDfpBt3S6JVTn7Tctqj7fqVUecAV
         BhbQjWZsJf98BatSFTVFTL3Tuz8VKEkuT69uxuIUqckG3nHWF7njiCSEGRV8LH3gmznh
         R9JlDopIZWyydGnZ81fCa+ZJymIOtVp/JsePQgRRqzB+i9J1YgFKhxxmaiOHPxvUBli8
         sx+Bn6K7jXfRbNaImf7sRcwAIlgspr+7L7cLY2xbLgj7i/piYsQSvIRxNXWWMVVYfPGj
         WmF6rIqx7XwZHuj4Y8Lg9Tdv2m+q4uRdQsFKBqJvgQlIp25bRqBbV0PrOHaYiPDgtmSi
         nH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+qNACW8/gTTgXjb8nsD8aEJ/snZ/Vsd31nRuBosZqE=;
        b=S0AlWnrr50xMLSusY3BHxVrxdH+rehM9xccTMgbkETzbXCGjRZQ4A7EFzVRgqYjOo4
         Bc1ASYJAevoSB5PxQwRenaxmX59XdvtkZhKYT0lsHtGjRy6y9EpMVKXCZYJ5+p3TBN20
         7o1kMoiY9DT9lDAbZm/B6WAltwKrzYBu0fnNuLgwUB4qdxIU7jNRTxdv+ThhkvjZDcf/
         GJEu1/aGoPEiAJk75j2s7CmG/HDveqePQKbuNPcYycijkcq/E02omit0EMQxBHtU61GE
         ssLBYFL4PQmz0Dq+rjvhby8KUL16jlSI8p3iCGV0FZZtAqIA98/a19Wu031/ZrU6KPkv
         chLQ==
X-Gm-Message-State: AOAM532MuJv9rQ81E2aa8MlK/i1Y1YTmMFgPjAwaJXfTgFNiO241Xc1D
        JPoYVUMv7NNIIzvaipZ4lVF5iA==
X-Google-Smtp-Source: ABdhPJx3IwZYrY86b1qfCcLPlI48g9BeGyMlMqabnTBv2RlI88lYcTF73oVq4UyivTmlj1ejM+nHjQ==
X-Received: by 2002:a63:6c0a:0:b0:3ab:8716:3d04 with SMTP id h10-20020a636c0a000000b003ab87163d04mr28671293pgc.507.1653491479389;
        Wed, 25 May 2022 08:11:19 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902eb9000b00161b50c3db4sm9383129plg.94.2022.05.25.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:11:18 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 0/5] Support for 64bit hartid on RV64 platforms
Date:   Wed, 25 May 2022 20:41:01 +0530
Message-Id: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hartid can be a 64bit value on RV64 platforms. This series updates
the code so that 64bit hartid can be supported on RV64 platforms.

Sunil V L (5):
  riscv: cpu_ops_sbi: Support for 64bit hartid
  riscv: cpu_ops_spinwait: Support for 64bit hartid
  riscv: smp: Support for 64bit hartid
  riscv: cpu: Support for 64bit hartid
  riscv/efi_stub: Support for 64bit boot-hartid

 arch/riscv/include/asm/processor.h        |  4 ++--
 arch/riscv/include/asm/smp.h              |  4 ++--
 arch/riscv/kernel/cpu.c                   | 26 +++++++++++++----------
 arch/riscv/kernel/cpu_ops_sbi.c           |  4 ++--
 arch/riscv/kernel/cpu_ops_spinwait.c      |  2 +-
 arch/riscv/kernel/cpufeature.c            |  6 ++++--
 arch/riscv/kernel/smp.c                   |  4 ++--
 arch/riscv/kernel/smpboot.c               |  9 ++++----
 drivers/clocksource/timer-riscv.c         | 15 +++++++------
 drivers/firmware/efi/libstub/riscv-stub.c | 12 ++++++++---
 drivers/irqchip/irq-riscv-intc.c          |  7 +++---
 drivers/irqchip/irq-sifive-plic.c         |  7 +++---
 12 files changed, 58 insertions(+), 42 deletions(-)

-- 
2.25.1

