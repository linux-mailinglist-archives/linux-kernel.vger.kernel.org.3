Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83654CC086
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiCCPAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiCCPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:00:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C111EF0D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:59:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i6-20020a1c3b06000000b00386f2897400so123214wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyZKtms3/fooY346YEFh4aDUln7VR4f3ZkWUMV+VfiY=;
        b=XoZI7nJBCKEM9JhyOj4+4Q/Ee/yq2th4jAnz/UhBWAKDEgTrbUkfdcxKDciB6eEhjC
         eu1hktSPl2tRO0qnypW8sk7nLauSF373ejLjGCvkInaDqIkg8mTY8BOO0SbsT19/BQE8
         FU24TDNc2ZrpGUMsktjKuOK6lRIqhUtV4r4tniYIIPW/fYzB+c9YvQK3ouion6eS/abr
         dcu5rUaZ6s2dWGZ4ZbaVtabVYr1ASu4BeEA8hiVMqCVbcERpTZOxGCHrMksDLSSRL2eX
         VzrlPgWl6ukUwfM+NF0fwROCvjlq/g3LVy9wr/qzTzkRy26qkAIUi27HY72ND5MxX4Qi
         ir/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyZKtms3/fooY346YEFh4aDUln7VR4f3ZkWUMV+VfiY=;
        b=L0/Rc6KCrW20bVah1iojGAVGwEeHAxg+qH9fzGFq/mlI16rcnJl3O47qrr7uTUbJZU
         ZfbMkYf7mG4IHU3WKDzHTgQzTRGRSFHg0YyBtQFp84UdhiN79Ugtw1dMvP181B6Ve3Pq
         fpBDGyysijxNiB+au3sAlnPHEmnmVzOF4Aq9AEMiX8i8bt35qBXRRP5m1qqnJXC3SIKP
         xd4c1DfYZu8qXSBMGiwjJHQHq6fkg/BqPX2z20PBxqXFRAs7kSVcjUoHKqUKKfeA1w89
         bn+EOPLYACe2LA7x/PT3QZAl9hUH5p7e9UqvmmerSvzL6wvFMsmOGZMHk6ED65Eg0PPK
         asPA==
X-Gm-Message-State: AOAM533QFcY+/NebRfUNggoZW3nwGwqNgaqj/ybpYGAnEjULhlvMlT3Y
        Bw7iVpeZN7YohPhRGgDpJ9WBug==
X-Google-Smtp-Source: ABdhPJyNhPVn3ujz+yed9ZU8ZsVBArmJ+s8GAWfDmrjEO7NKWveEpuqL/2TcQKekRcVES9Tf/1cDog==
X-Received: by 2002:a05:600c:1c25:b0:380:d306:1058 with SMTP id j37-20020a05600c1c2500b00380d3061058mr4125847wms.150.1646319598144;
        Thu, 03 Mar 2022 06:59:58 -0800 (PST)
Received: from localhost.localdomain ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d522f000000b001e85b14dadcsm2224166wra.5.2022.03.03.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 06:59:57 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Abner Chang <abner.chang@hpe.com>,
        Jessica Clarke <jrtc27@jrtc27.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH V2 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Date:   Thu,  3 Mar 2022 20:29:43 +0530
Message-Id: <20220303145944.307321-1-sunilvl@ventanamicro.com>
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

This patch adds support for getting the boot hart ID using new
RISCV_EFI_BOOT_PROTOCOL in linux efi stub. While there is an existing
solution of passing the boot hart ID through Device Tree, it doesn't work
for ACPI. Hence an EFI protocol protocol is recommended which works for
both DT and ACPI based platforms.

The latest draft spec of this new protocol is available at
https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc2/RISCV_UEFI_PROTOCOL-spec.pdf

This linux ptach can be found in:
riscv_boot_protocol_rfc_v2 branch at
https://github.com/vlsunil/linux.git

This is tested in qemu with u-boot 2022.04.rc3.

Changes since V1:
  - Rebased to get the "Fix get_boot_hartid_from_fdt() return value"
    patch
  - Removed mixed_mode member
  - Separated return value and status.

Sunil V L (1):
  riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL

 drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
 drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
 include/linux/efi.h                       |  1 +
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.25.1

