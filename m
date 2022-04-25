Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9B50ECEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiDYX4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiDYX4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:56:51 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF945AE2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:53:45 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id t4-20020a4aa3c4000000b0035db397ae97so6643028ool.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DcihtRyhxZSASrAxWYvG+vbHikEXUCwgp718CSC9bMo=;
        b=bxDlTykMwr9Eii5P0vs5td20RwMYWDrdaNaR3kKZ6vFMPHfRLG5jmjORyoP4POGF60
         nA8phR2ww4MgrzN+LMPxGJbnSEDso7tQL9wckviWO+/d1JIoTst1Xwa/dk58wvUeVjls
         PfcbUhZVCEdviaAFb8SOKwHJ7v6guuTIGUAVf3AEF149Tx//Fq0j1mkofEIskSRN7/Ih
         z7aYDioOgYuIA6euhcoVCkZ5TjsZwpOFdAhJSWXOr/3YvLiOJrWoc/qrnP/fJIQIBCcE
         bL7ORzw1GtMnmr0yYEPa5SD1uwfXD7rURiQfC4d/AHIsn70korOgZqUm5PLbqXq0rZwk
         7n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DcihtRyhxZSASrAxWYvG+vbHikEXUCwgp718CSC9bMo=;
        b=WprR2BuQ7ND3d3Si0ydKSNFwErU96gcon3oWtWaWhG5yYulJ9uMLT/swXthqYgNUMl
         0DelE6INhQFVQ4lrocwMQ9i4rW4K1Sd6Dt3qRBC3KYnth37OKxyvpuz8SWgpJBg51Re9
         k1ukKjD6r56iNanrDetDRc1pNXY1v1/Ex35HSZf+Pr7ZIGd6Pdt93f3WS40/LY9RKUFf
         +6Lb2n6wmoxld8qbZel8rE3kcIN4uP51YJamSgawFl+vBxvm6UpSziRvulq/3qNIus+s
         9iN4nopuVB6PAs7ihBJyik9Lizr9YrUcs0UPgpfbOhoba7NzWHJJpcldYIaG7Tb9nloh
         nXyA==
X-Gm-Message-State: AOAM533c9lT7mOT8zZfTVSAmmgRqGDEeRxTZcIVvfWzCnmGzQFcPx2+Q
        oCrFwzaLXXCsmpW5aeVZOQl2XP7kRCA=
X-Google-Smtp-Source: ABdhPJxKsgOjwnsQHHwzUCN10OQb3jAAYyq3y/pis69T7DTdEuFTR2EpQXnDB6jMJ7K6ExgV6uUQsRgVmh0=
X-Received: from oupton3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a05:6870:1481:b0:d7:30a3:1f39 with SMTP id
 k1-20020a056870148100b000d730a31f39mr12496597oab.14.1650930824850; Mon, 25
 Apr 2022 16:53:44 -0700 (PDT)
Date:   Mon, 25 Apr 2022 23:53:37 +0000
Message-Id: <20220425235342.3210912-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 0/5] KVM: arm64: Limit feature register reads from AArch32
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        reijiw@google.com, ricarkol@google.com,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM/arm64 does not restrict the guest's view of the AArch32 feature
registers when read from AArch32. HCR_EL2.TID3 is cleared for AArch32
guests, meaning that register reads come straight from hardware. This is
problematic as KVM relies on read_sanitised_ftr_reg() to expose a set of
features consistent for a particular system.

Appropriate handlers must first be put in place for CP10 and CP15 ID
register accesses before setting TID3. Rather than exhaustively
enumerating each of the encodings for CP10 and CP15 registers, take the
lazy route and aim the register accesses at the AArch64 system register
table.

Patches 1-2 are small cleanups to how we handle register emulation
failure. No functional change for current KVM, but required to do
register emulation correctly in this series.

Patch 3 reroutes the CP15 registers into the AArch64 table, taking care
to immediately RAZ undefined ranges of registers. This is done to avoid
possibly conflicting with encodings for future AArch64 registers.

Patch 4 installs an exit handler for the CP10 ID registers and also
relies on the general AArch64 register handler to implement reads.

Finally, patch 5 actually sets TID3 for AArch32 guests, providing
known-safe values for feature register accesses.

There is an argument that the series is in fact a bug fix for running
AArch32 VMs on heterogeneous systems. To that end, it could be
blamed/backported to when we first knew better:

  93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")

But I left that tag off as in the aforementioned change skipping
AArch32 was intentional. Up to you, Marc, if you want to call it a
bugfix ;-)

Applies cleanly to 5.18-rc4.

Tested with AArch32 kvm-unit-tests and booting an AArch32 debian guest
on a Raspberry Pi 4. Additionally, I tested AArch32 kvm-unit-tests w/
pmu={on,off} and saw no splat, as Alex had discovered [1]. The test
correctly skips with the PMU feature bit disabled now.

[1]: https://lore.kernel.org/r/20220425145530.723858-1-alexandru.elisei@arm.com

v1: https://lore.kernel.org/kvmarm/20220329011301.1166265-1-oupton@google.com/
v2: https://lore.kernel.org/r/20220401010832.3425787-1-oupton@google.com

v2 -> v3:
 - Collect R-b from Reiji (thanks!)
 - Adopt Marc's suggestion for CP15 register handling
 - Avoid writing to Rt when emulation fails (Marc)
 - Print some debug info on an unexpected CP10 register access (Reiji)

v1 -> v2:
 - Actually set TID3! Oops.
 - Refactor kvm_emulate_cp15_id_reg() to check preconditions before
   proceeding to emulation (Reiji)
 - Tighten up comment on kvm_is_cp15_id_reg() to indicate that the only
   other trapped ID register (CTR) is already handled in the cp15

Oliver Upton (5):
  KVM: arm64: Return a bool from emulate_cp()
  KVM: arm64: Don't write to Rt unless sys_reg emulation succeeds
  KVM: arm64: Wire up CP15 feature registers to their AArch64
    equivalents
  KVM: arm64: Plumb cp10 ID traps through the AArch64 sysreg handler
  KVM: arm64: Start trapping ID registers for 32 bit guests

 arch/arm64/include/asm/kvm_arm.h     |   3 +-
 arch/arm64/include/asm/kvm_emulate.h |   7 -
 arch/arm64/include/asm/kvm_host.h    |   1 +
 arch/arm64/kvm/handle_exit.c         |   1 +
 arch/arm64/kvm/sys_regs.c            | 197 +++++++++++++++++++++++----
 arch/arm64/kvm/sys_regs.h            |   7 +
 6 files changed, 178 insertions(+), 38 deletions(-)

-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

