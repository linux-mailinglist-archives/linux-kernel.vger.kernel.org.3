Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE25AB70D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiIBRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiIBRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:01:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3BD8B39
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:01:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f12so2391159plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YUxOFpnDcuO1JKcZKoGOLhBh9DhGvttoN1H+IidO6hU=;
        b=ETyEOM40mL6WbpHYxawQkUwUqftcZOHasqHn1N2MV2Rmdifn+azsFcD3L9Rxm6Doob
         KYKtL5G1u+PGSpFcQzCJF45Q5LUQncBQ6sVZTFYRSSSe4ZUFdv+TlhW4j0VscznpqBUo
         F6U7nVgYJQPVJh/ZY6rKhO+k44vgYS5SomlukJn9HGDlFRnXaCUd+tjNHVxXGjPuOuLe
         +AQp7LdDBBYtvZd7rmDBvIXhdSEqXN7RaRVwjdtHGsvA7qcXu1QF3Vrjk5f94CgG6wpY
         mygpMiQRHmDYNrMLkbxZR4V333iaCvozt1+UiBzOmnN/ff3B3zQu8D8NQmHVTeej1hdF
         FE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YUxOFpnDcuO1JKcZKoGOLhBh9DhGvttoN1H+IidO6hU=;
        b=MeC/kpkuip1ky5SHyRigDAoo4I+tog795GfBfBJIWnJfm/aPcSlX0IlqTsYBJetzFB
         lWqAgjI9jVXKoEhDFwLouU8x9E1hhaKuPYPRxy+HClORMmMln2EH/JuZDEdWZASpAJj8
         +w8e5pR6Vt3QxOjbPN1TjqQHFM3C0MIOGk4SDQjnJOoR6XD+5+aMbCGvgM1Y01cW6wr7
         swFbROecFrMf+np/sRRde4pPYB7HyheqiVg78+/U7JSq8nMEvvpG0RKhoW8aTEZMpYgs
         lMWFj3cF3H3yVWdXFUOevUKr9pcSS43mVklSQ3QhB7eIC/jeCXCQDqI9+KSij7ugFj5w
         Fa0g==
X-Gm-Message-State: ACgBeo2HRVziOHBvnJyAQ+TkzNgZYh7IGUg3RNGR+GIjidG9y11ZPT8N
        2fycK6jKdq17d0+3/bD+O4DNqg==
X-Google-Smtp-Source: AA6agR6AZOMgkiY+i1WsWPOVMnHoXdP3XF2/SxVDcMtustilH221mFiL8FiGhx5WwGV9f1MOs3htnA==
X-Received: by 2002:a17:90b:4a87:b0:1fd:f44a:1d9e with SMTP id lp7-20020a17090b4a8700b001fdf44a1d9emr5731358pjb.241.1662138104265;
        Fri, 02 Sep 2022 10:01:44 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.83.155])
        by smtp.gmail.com with ESMTPSA id w10-20020a65534a000000b0043014f9a4c9sm1638800pgr.93.2022.09.02.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:01:43 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/3] Svinval support for KVM RISC-V
Date:   Fri,  2 Sep 2022 22:31:28 +0530
Message-Id: <20220902170131.32334-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

This series adds Svinval extension support for both Host hypervisor
and Guest.

These patches can also be found in riscv_kvm_svinval_v1 branch at:
https://github.com/avpatel/linux.git

The corresponding KVMTOOL patches are available in riscv_svinval_v1
branch at: https://github.com/avpatel/kvmtool.git

Anup Patel (2):
  RISC-V: KVM: Use Svinval for local TLB maintenance when available
  RISC-V: KVM: Allow Guest use Svinval extension

Mayuresh Chitale (1):
  RISC-V: Probe Svinval extension form ISA string

 arch/riscv/include/asm/hwcap.h    |  4 +++
 arch/riscv/include/asm/insn-def.h | 20 +++++++++++
 arch/riscv/include/uapi/asm/kvm.h |  1 +
 arch/riscv/kernel/cpu.c           |  1 +
 arch/riscv/kernel/cpufeature.c    |  1 +
 arch/riscv/kvm/tlb.c              | 60 ++++++++++++++++++++++++-------
 arch/riscv/kvm/vcpu.c             |  2 ++
 7 files changed, 77 insertions(+), 12 deletions(-)

-- 
2.34.1

