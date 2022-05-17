Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB59529635
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiEQAza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiEQAz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8761344C8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q4so15979892plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xTvUZ/MZ/hBMOv0pU4miRbRa4E1wCeud/j7eErPbOM=;
        b=At1cMaJ1YI6mdPHBhH3EPPsHY6nby2Qx29Higj+fSkAGshMg27QehHqxn0Qw60C7WG
         rmyP9l5SX7+5F1EKSb6XFioQ46dBJFzb20vro+6u5Di0S6qxt4ID+ywnzkrDF4pLUWSU
         UQtHCGBdEY37uV+5XzXfWif/D0H+dbaUJr4k8uAxypOo2w4BwZzYOl9rs2goqvNolCr9
         HCUijfCdjwZs61FHuQ0RJLRCWmPqinCtzR/SCKWVYT7liaWWT4vhMET+ZZd5djczY38Q
         ByvA2k9qUemcnjyzOyghUseZVCwrNSPUsHDX3buS62/jkabqMnSinkoQIqrB/DczqS+D
         +cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xTvUZ/MZ/hBMOv0pU4miRbRa4E1wCeud/j7eErPbOM=;
        b=yZWhiPNIXDoAxFeL4k6g7OP0J3gzCZb6iHpV+XLQ2vKKqMz3PcT54Hdjbhis6iym0v
         CHUiXw4r0nZSqmjl3mBBikESl+RL64NDu+fmMdzOjlJo1rFOIELgNFNaSkvhpp2O4yXp
         +YHAERKPPQzg3ElaQWdUcAah+H5x+eKidfWEMnpxRwnVYInuplCBMA32a5IlEbgwxuXw
         A84s8EXaQZ0KrFRYyyoxBjsdCQueAiczDm0Uj92PzHMY6jE7B4QGEJsY1Pi+apHxaZa+
         qyJRLa0uB+iyxl9PqQ/dKpiqC6gjsBx6tzZIWf3Z+aYqHvAtR5PK4SDGqAWrkHqPPcGX
         b+TA==
X-Gm-Message-State: AOAM533QFn3nGRguB+emK6vljcFok6bZY1B+hmWJ41uqGBdcWakOsykt
        4z8EBRLCnWdTQs6UKhRt4U6nW50gVUc=
X-Google-Smtp-Source: ABdhPJyag62O3xF/5d9ATebbPs62aYvEzfoSK6yl9zsJiq2cgZwzvUpHoCEpuDyZIqK2SUIzuJ74aQ==
X-Received: by 2002:a17:902:7e01:b0:15e:caea:d6 with SMTP id b1-20020a1709027e0100b0015ecaea00d6mr19997264plm.33.1652748925641;
        Mon, 16 May 2022 17:55:25 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id w2-20020a63fb42000000b003ed6b3dc52esm5486685pgj.55.2022.05.16.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:25 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 00/13]  OpenRISC misc cleanups for 5.19
Date:   Tue, 17 May 2022 09:54:57 +0900
Message-Id: <20220517005510.3500105-1-shorne@gmail.com>
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
 arch/openrisc/configs/or1klitex_defconfig |  33 ++
 arch/openrisc/kernel/entry.S              |  20 +-
 arch/openrisc/kernel/head.S               | 368 ++++++----------------
 arch/openrisc/kernel/time.c               |   3 +-
 arch/openrisc/kernel/traps.c              |  63 ++--
 arch/openrisc/lib/delay.c                 |   1 +
 arch/openrisc/mm/fault.c                  |   4 +-
 9 files changed, 255 insertions(+), 307 deletions(-)

-- 
2.31.1

