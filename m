Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678C34F94FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiDHMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiDHMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14E52EC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA2962066
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBB7C385A3;
        Fri,  8 Apr 2022 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419246;
        bh=DRv3mm8f90dK7Yzygr45t/zBtQo9zFMAVRIqHpVBdwE=;
        h=Date:From:To:Cc:Subject:From;
        b=G3w5x4c++6cZhm+qV6V7vd7WWzsoQpPUtw5fKyO0m9gfkdtJC+1jqUjukQxnLZAku
         JarSUwGfNA2+dPkrgDu/zXY8dwaKdizyLQaO18QdRnHbVlzzHZakaUrgGljVGdD8+h
         DjG+0T0t4GbM7QKjWIfWp95cLUPpnLWNA/FjRsw3AKqzFuj84ebJCmHJNcLQJA5vc8
         21MH8q7oimWZKavhaaFzWB8oDht5nMdNrwW70RCRaW2EuzQCQ6H0o/3H5PgLPpqGcL
         8hoB4m7SJ2BrCQJr4f8Mz91Xv4aOkoUlgi7CUH6Yl3e0dtYRYEIhu8zJB5fD74zQTW
         iir8FTQI594pQ==
Date:   Fri, 8 Apr 2022 13:00:41 +0100
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Subject: arm64 spectre-bhb backports break boot on stable kernels <= v5.4
Message-ID: <20220408120041.GB27685@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Booting stable kernels <= v5.4 on arm64 with CONFIG_HARDEN_BRANCH_PREDICTOR=n
results in a NULL pointer dereference during boot due to kvm_get_hyp_vector()
dereferencing a NULL pointer from arm64_get_bp_hardening_data():

[    2.384444] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    2.384461] pstate: 20400085 (nzCv daIf +PAN -UAO)
[    2.384472] pc : cpu_hyp_reinit+0x114/0x30c
[    2.384476] lr : cpu_hyp_reinit+0x80/0x30c
[    2.384477] sp : ffff800010013e20
[    2.384479] x29: ffff800010013e20 x28: ffff0000df033f00
[    2.384484] x27: ffff800011caa000 x26: ffff0000de58e000
[    2.384487] x25: ffff800011e57000 x24: ffff800011caad90
[    2.384490] x23: ffff800011c778e0 x22: ffff800011a56000
[    2.384494] x21: ffff800011a56000 x20: 0000b471121a6000
[    2.384497] x19: 00000000de588000 x18: 0000000000000000
[    2.384500] x17: 0000000000000000 x16: 0000000000000400
[    2.384503] x15: 0000000000001000 x14: 00000000000007f2
[    2.384507] x13: 0000000000000004 x12: 0000000000000002
[    2.384510] x11: 0000000000000000 x10: 00000000121a6000
[    2.384513] x9 : ffff800011c77fd8 x8 : 0000000000000010
[    2.384516] x7 : 4f422effff306b64 x6 : 0000008080000000
[    2.384519] x5 : 0000008080000000 x4 : ffff800011fabc94
[    2.384522] x3 : ffff800011f5bde0 x2 : 0000000000000001
[    2.384526] x1 : 00000000121a0000 x0 : ffff8000118f962d
[    2.384529] Call trace:
[    2.384533]  cpu_hyp_reinit+0x114/0x30c
[    2.384537]  _kvm_arch_hardware_enable+0x30/0x54
[    2.384541]  flush_smp_call_function_queue+0xe4/0x154
[    2.384544]  generic_smp_call_function_single_interrupt+0x10/0x18
[    2.384549]  ipi_handler+0x170/0x2b0
[    2.384555]  handle_percpu_devid_fasteoi_ipi+0x120/0x1cc
[    2.384560]  __handle_domain_irq+0x9c/0xf4
[    2.384563]  gic_handle_irq+0x6c/0xe4
[    2.384566]  el1_irq+0xf0/0x1c0
[    2.384570]  arch_cpu_idle+0x28/0x44
[    2.384574]  do_idle+0x100/0x2a8
[    2.384577]  cpu_startup_entry+0x20/0x24
[    2.384581]  secondary_start_kernel+0x1b0/0x1cc
[    2.384589] Code: b9469d08 7100011f 540003ad 52800208 (f9400108)
[    2.384600] ---[ end trace 266d08dbf96ff143 ]---
[    2.385171] Kernel panic - not syncing: Fatal exception in interrupt

The faulting load is the access to 'data->template_start', for which the
compiler emits the hilarious:

	mov	w8, #0x10
	ldr	x8, [x8]

I can bodge this as below (untested), but it's pretty grotty. Please can you
take a look?

Cheers,

Will

--->8

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 33b33416fea4..3bc1380f5524 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -939,6 +939,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
                .cpu_enable = cpu_enable_ssbd_mitigation,
                .midr_range_list = arm64_ssb_cpus,
        },
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
        {
                .desc = "Spectre-BHB",
                .capability = ARM64_SPECTRE_BHB,
@@ -946,6 +947,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
                .matches = is_spectre_bhb_affected,
                .cpu_enable = spectre_bhb_enable_mitigation,
        },
+#endif
 #ifdef CONFIG_ARM64_ERRATUM_1418040
        {
                .desc = "ARM erratum 1418040",

