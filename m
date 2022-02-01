Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F894A586D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiBAIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiBAIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:23:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73448C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:23:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u24so32243471eds.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFZBlP26iSCuq9pcp8AO1ebVNfyJtN9g48o0eg6YeUo=;
        b=G3B3ewFELNCJK22vhw0g+Z2PMKJnRMsQAO/hHyIzUQh5ZlrFJ5omPuWN5VX0uNvNE0
         EXmGj7q2qs/Qn4+WKa5VtdFR+Xt9d8n40Dv/yCHz14Vyk3lRh6yxM+M9LUrXiFkIeHeb
         ZQCK0qrFQHL+eKagfOP9ECzMyNaPvo672BM1oKLuu+bycdx5S3NCkgPpfyLf4WqOYf67
         AW76rtTOE5V23OXmkTwWvTNsl6R8atv3kK6w/Piw2vK4M22HeNpaqXvrqTJimLZiwGzH
         +fzf4JeDVUBmnVW6jFNFd5c+LptJrQ6VIESRg1DIz3YCvu1//jdcQyqVyP18anMZ+lxW
         wkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFZBlP26iSCuq9pcp8AO1ebVNfyJtN9g48o0eg6YeUo=;
        b=ye/FeJvnxsMgLwHHMC2mh12BNytrqta03xF0EgTwxDJ9matUBbCO9GBeEBJ2J8hhgm
         WHXTgvtlZsi+kRBFhs4WbhY7ClN0nUkn74txwN1iqwW7WR2sYKykulkB1xC5Y3l/RbKj
         FOG4cLVK0Ld5+caTnBjXK6WZIMhu5ZjgMojLjxgoivyKPOv0LA/LMpgR1Gdn9OfsBvlp
         WpJEZkrDIoqrdTDAoWyo2BVrUu/7L3FbHP3Ej9oUnu6pBLmSQ/JyseE1oaJDTrIhkvk1
         dnNoG+dR7GM8k38S+IsYo43O/+ZtnRZyTj9eeZbuDPZWUKRO9oRxBTdg/x3j+0e2AWeY
         Lf+w==
X-Gm-Message-State: AOAM532yZK3nD0jJic7jCjlot39YmNHRwWUEMiZtMolyujksUHD63tk1
        V43033s3tD3NONEdpYs2aOcpRQ==
X-Google-Smtp-Source: ABdhPJyAQHIh8pxpRN/DzJhAGdHM+TPIjVRpgsk6BLPGFiShHIF8n3PXkg4A3GBNfSU5h5ety+T+Dw==
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr24015019edr.93.1643703816963;
        Tue, 01 Feb 2022 00:23:36 -0800 (PST)
Received: from localhost.localdomain ([122.179.76.38])
        by smtp.gmail.com with ESMTPSA id w8sm14312133ejq.220.2022.02.01.00.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:23:36 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/6] KVM RISC-V SBI v0.3 support
Date:   Tue,  1 Feb 2022 13:52:21 +0530
Message-Id: <20220201082227.361967-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial support for SBI v0.3 which includes:
1) SBI SRST support for Guest
2) SBI HSM suspend for Guest

The SBI PMU support is intentionally left out and will be added as
a separate patch series.

These patches can also be found in riscv_kvm_sbi_v03_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (6):
  RISC-V: KVM: Upgrade SBI spec version to v0.3
  RISC-V: KVM: Add common kvm_riscv_vcpu_sbi_system_reset() function
  RISC-V: KVM: Implement SBI v0.3 SRST extension
  RISC-V: Add SBI HSM suspend related defines
  RISC-V: KVM: Add common kvm_riscv_vcpu_wfi() function
  RISC-V: KVM: Implement SBI HSM suspend call

 arch/riscv/include/asm/kvm_host.h     |  1 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  5 ++-
 arch/riscv/include/asm/sbi.h          | 27 +++++++++++++---
 arch/riscv/kernel/cpu_ops_sbi.c       |  2 +-
 arch/riscv/kvm/vcpu_exit.c            | 22 ++++++++++----
 arch/riscv/kvm/vcpu_sbi.c             | 19 ++++++++++++
 arch/riscv/kvm/vcpu_sbi_hsm.c         | 18 +++++++++--
 arch/riscv/kvm/vcpu_sbi_replace.c     | 44 +++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_v01.c         | 18 ++---------
 9 files changed, 125 insertions(+), 31 deletions(-)

-- 
2.25.1

