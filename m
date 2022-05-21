Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5829E52FC97
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiEUNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiEUNNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:13:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6132387B0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x143so9854145pfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tsnp7LDR4Kj+qjwcH/l61gToy0Uf2WpoVPY59g6dIY=;
        b=ZxwBpu0DVHrWeYFLzEEFa4jqJp/XPgAheEoJmFhCsDTylRmZnEJ2ggi9MHv9yPWMxw
         wF1e6XpqBCKCAaHSRwQuq7UukRsDdWhgIP+KjeUcvG8E3hp3xwbCUP9wjfFagr6f4LNG
         /NZlAEeyRkyETtJCe1ZDNnANcPvwaMJL+qJLJduaAx5tMqZxZJGJTqW/ic9UpLcTyBPN
         elRLB6K+9LQg+IAPX91KwSIadvZ6crob7IUAyCAUYcrLHyYQ03G+TB3fRsPKcVv2hj4B
         Fgj3FJaxV7aBXJ5apxocIuthy7NrVzXzkGXewAm9cpkF1EW7Naz6Abp0J0DgS7J6L8p9
         n9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tsnp7LDR4Kj+qjwcH/l61gToy0Uf2WpoVPY59g6dIY=;
        b=qJOGcjEw/sFo3SsDt2ofbgpiWLumKpiTc9G+hBcYvS/CUWRqOPIG839HmlzKkTj4Q/
         xQ23pLu+mSyJUXCZyYdJjvjDMEnwFoo81thk8VnGD+QneW2OqxAmobGIFjoZSngRyl8R
         ugSPUkcKhLxbkQno0WAlzE+lEJi91K/joXIy0DeM/5gQNdsXWddig5WMhEL70Q9PKKDQ
         mV7Tl1qw4qJVz6ySMYpQzERkDt/cit0fKVrWQaeueN3Y16YuvucjvU12L8EgCKnUF2yw
         VUDoVJkC7pduapC2EvHbyaYatSxKeoqVIHLDVL0kTrw/7vgaCqPMZDUuyiaP/wGGkw7Z
         da4g==
X-Gm-Message-State: AOAM531qZEXDg5nkdtND8qRaoK9l9GcXKr24KCKn5P1kx2GHkmKT6Vzd
        AShaNunt9L5F0YrWZ+fL27MNbm/ypXs=
X-Google-Smtp-Source: ABdhPJwPiWuciTXjZ6QiW+0tPWmqJkOlUJHzwTydnETcGzgcmqZFazom/EYilMGkXkAd23K30ypKIA==
X-Received: by 2002:a62:a516:0:b0:505:722e:15d5 with SMTP id v22-20020a62a516000000b00505722e15d5mr14855952pfm.52.1653138815604;
        Sat, 21 May 2022 06:13:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902e41400b0015e8d4eb25csm1553075ple.166.2022.05.21.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:13:34 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 00/13] OpenRISC misc cleanups for 5.19
Date:   Sat, 21 May 2022 22:13:10 +0900
Message-Id: <20220521131323.631209-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of misc cleanups I have accumulated when working on some
recent OpenRISC projects.

The patch themes:
 - Sparse warning cleanups
 - Removal of dead code
 - Emergency debug fixups in head.S
 - Support for gcc machine instruction flags
 - defconfig updates for litex

I have tested these patches when verifying the glibc port by running the glibc
test suite.

Changes since v2:
 - Don't enabled class II instructions by default
Changes since v1:
 - Fix if/elif issue in emergency print fixes pointed out by Samuel Holland

Stafford Horne (13):
  openrisc: Add gcc machine instruction flag configuration
  openrisc: Cleanup emergency print handling
  openrisc: Add support for liteuart emergency printing
  openrisc: Add syscall details to emergency syscall debugging
  openrisc: Pretty print show_registers memory dumps
  openrisc: Update litex defconfig to support glibc userland
  openrisc/traps: Declare file scope symbols as static
  openrisc/traps: Remove die_if_kernel function
  openrisc/traps: Declare unhandled_exception for asmlinkage
  openrisc/time: Fix symbol scope warnings
  openrisc/delay: Add include to fix symbol not declared warning
  openrisc/fault: Fix symbol scope warnings
  openrisc: Remove unused IMMU tlb workardound

 arch/openrisc/Kconfig                     |  53 ++++
 arch/openrisc/Makefile                    |  17 +
 arch/openrisc/configs/or1klitex_defconfig |  32 ++
 arch/openrisc/kernel/entry.S              |  20 +-
 arch/openrisc/kernel/head.S               | 368 ++++++----------------
 arch/openrisc/kernel/time.c               |   3 +-
 arch/openrisc/kernel/traps.c              |  63 ++--
 arch/openrisc/lib/delay.c                 |   1 +
 arch/openrisc/mm/fault.c                  |   4 +-
 9 files changed, 254 insertions(+), 307 deletions(-)

-- 
2.31.1

