Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F875529F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbiEQKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbiEQKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:17:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82FC54D24F;
        Tue, 17 May 2022 03:14:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505391042;
        Tue, 17 May 2022 03:14:24 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB0E3F66F;
        Tue, 17 May 2022 03:14:22 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Burton <ross.burton@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] of/fdt: Ignore disabled memory nodes
Date:   Tue, 17 May 2022 11:14:10 +0100
Message-Id: <20220517101410.3493781-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we boot a machine using a devicetree, the generic DT code goes
through all nodes with a 'device_type = "memory"' property, and collects
all memory banks mentioned there. However it does not check for the
status property, so any nodes which are explicitly "disabled" will still
be added as a memblock.
This ends up badly for QEMU, when booting with secure firmware on
arm/arm64 machines, because QEMU adds a node describing secure-only
memory:
===================
	secram@e000000 {
		secure-status = "okay";
		status = "disabled";
		reg = <0x00 0xe000000 0x00 0x1000000>;
		device_type = "memory";
	};
===================

The kernel will eventually use that memory block (which is located below
the main DRAM bank), but accesses to that will be answered with an
SError:
===================
[    0.000000] Internal error: synchronous external abort: 96000050 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc6-00014-g10c8acb8b679 #524
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : new_slab+0x190/0x340
[    0.000000] lr : new_slab+0x184/0x340
[    0.000000] sp : ffff80000a4b3d10
....
==================
The actual crash location and call stack will be somewhat random, and
depend on the specific allocation of that physical memory range.

As the DT spec[1] explicitly mentions standard properties, add a simple
check to skip over disabled memory nodes, so that we only use memory
that is meant for non-secure code to use.

That fixes booting a QEMU arm64 VM with EL3 enabled ("secure=on"), when
not using UEFI. In this case the QEMU generated DT will be handed on
to the kernel, which will see the secram node.
This issue is reproducible when using TF-A together with U-Boot as
firmware, then booting with the "booti" command.

When using U-Boot as an UEFI provider, the code there [2] explicitly
filters for disabled nodes when generating the UEFI memory map, so we
are safe.
EDK/2 only reads the first bank of the first DT memory node [3] to learn
about memory, so we got lucky there.

[1] https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst#memory-node (after the table)
[2] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/fdtdec.c#L1061-1063
[3] https://github.com/tianocore/edk2/blob/master/ArmVirtPkg/PrePi/FdtParser.c

Reported-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/of/fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ec315b060cd50..0f30496ce80bf 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1105,6 +1105,9 @@ int __init early_init_dt_scan_memory(void)
 		if (type == NULL || strcmp(type, "memory") != 0)
 			continue;
 
+		if (!of_fdt_device_is_available(fdt, node))
+			continue;
+
 		reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
 		if (reg == NULL)
 			reg = of_get_flat_dt_prop(node, "reg", &l);
-- 
2.25.1

