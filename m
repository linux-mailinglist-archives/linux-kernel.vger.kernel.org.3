Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E679549F273
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbiA1EXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:23:33 -0500
Received: from inva021.nxp.com ([92.121.34.21]:45968 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233877AbiA1EXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:23:31 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D238A2000E1;
        Fri, 28 Jan 2022 05:23:26 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6441C200AE0;
        Fri, 28 Jan 2022 05:23:26 +0100 (CET)
Received: from lsv03267.swis.in-blr01.nxp.com (lsv03267.swis.in-blr01.nxp.com [92.120.147.107])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 907D0183ACDE;
        Fri, 28 Jan 2022 12:23:23 +0800 (+08)
From:   nikhil.gupta@nxp.com
To:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     priyanka.jain@nxp.com, aisheng.dong@nxp.com,
        Nikhil Gupta <nikhil.gupta@nxp.com>
Subject: [PATCH] of/fdt: move elfcorehdr reservation early for crash dump kernel
Date:   Fri, 28 Jan 2022 09:53:21 +0530
Message-Id: <20220128042321.15228-1-nikhil.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Gupta <nikhil.gupta@nxp.com>

elfcorehdr_addr is fixed address passed to Second kernel which may be conflicted
with potential reserved memory in Second kernel,so fdt_reserve_elfcorehdr() ahead
of fdt_init_reserved_mem() can relieve this situation.

Signed-off-by: Nikhil Gupta <nikhil.gupta@nxp.com>
---
elfcorehdr addr is calculated in kexec tool based on reserved crashkernel memory space. (Last page is used in top down order)
So It may potentially conflict the reserved memory in 2nd kernel.
Below is log:
load_crashdump_segments: page_offset:   ffffc00000000000
…..
load_crashdump_segments: elfcorehdr 0xf3fff000-0xf3fff3ff
read_1st_dtb: found /sys/firmware/fdt
get_cells_size: #address-cells:2 #size-cells:2
cells_size_fitted: f3fff000-f3fff3ff
cells_size_fitted: d4000000-f3ffffff

Overlaps seen on LS1043A SoC:

[    0.000000] memblock_reserve: [0x00000000d4010000-0x00000000d677ffff] arm64_memblock_init+0x258/0x2c8
[    0.000000] memblock_phys_alloc_range: 4194304 bytes align=0x400000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x9c/0x16c
[    0.000000] memblock_reserve: [0x00000000f3c00000-0x00000000f3ffffff] memblock_alloc_range_nid+0xdc/0x150
[    0.000000] memblock_phys_alloc_range: 33554432 bytes align=0x2000000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x9c/0x16c
[    0.000000] memblock_reserve: [0x00000000f0000000-0x00000000f1ffffff] memblock_alloc_range_nid+0xdc/0x150
[    0.000000] memblock_phys_alloc_range: 16777216 bytes align=0x1000000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x9c/0x16c
[    0.000000] memblock_reserve: [0x00000000f2000000-0x00000000f2ffffff] memblock_alloc_range_nid+0xdc/0x150
[    0.000000] OF: reserved mem: initialized node bman-fbpr, compatible id fsl,bman-fbpr
[    0.000000] OF: fdt: elfcorehdr is overlapped

panic in elfcorehdr_read.
[    0.443984] Unable to handle kernel paging request at virtual address ffff000037fff000
[    0.451942] Mem abort info:
[    0.454740]   ESR = 0x96000006
[    0.457806]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.463142]   SET = 0, FnV = 0
[    0.466202]   EA = 0, S1PTW = 0
[    0.469353] Data abort info:
[    0.472243]   ISV = 0, ISS = 0x00000006
[    0.476094]   CM = 0, WnR = 0
[    0.479072] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000d9373000
[    0.485806] [ffff000037fff000] pgd=00000000f7bf7003, pud=00000000f7bf6003, pmd=0000000000000000
[    0.494553] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[    0.500146] Modules linked in:
[    0.503211] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc3-00062-gbf8d1cd #5
[    0.510725] Hardware name: LS1043A RDB Board (DT)
[    0.515446] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    0.520260] pc : __memcpy+0x78/0x180
[    0.523847] lr : elfcorehdr_read+0x28/0x38
[    0.611262] Call trace:
[    0.613713]  __memcpy+0x78/0x180
[    0.616950]  vmcore_init+0x70/0x534
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ad85ff6474ff..ec315b060cd5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -648,8 +648,8 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	}
 
 	fdt_scan_reserved_mem();
-	fdt_init_reserved_mem();
 	fdt_reserve_elfcorehdr();
+	fdt_init_reserved_mem();
 }
 
 /**
-- 
2.17.1

