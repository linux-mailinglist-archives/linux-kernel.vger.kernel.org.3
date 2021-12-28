Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42BC480992
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhL1N27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:28:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29301 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhL1N25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:57 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JNb2f4WXzzbjjd;
        Tue, 28 Dec 2021 21:28:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 21:28:54 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 21:28:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>
Subject: [PATCH v19 00/13] support reserving crashkernel above 4G on arm64 kdump
Date:   Tue, 28 Dec 2021 21:25:59 +0800
Message-ID: <20211228132612.1860-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which
will fail when there is no enough low memory.
2. If reserving crashkernel above 4G, in this case, crash dump
kernel will boot failure because there is no low memory available
for allocation.

To solve these issues, change the behavior of crashkernel=X.
crashkernel=X tries low allocation in DMA zone and fall back to high
allocation if it fails.

We can also use "crashkernel=X,high" to select a high region above
DMA zone, which also tries to allocate at least 256M low memory in
DMA zone automatically and "crashkernel=Y,low" can be used to allocate
specified size low memory.

When reserving crashkernel in high memory, some low memory is reserved
for crash dump kernel devices. So there may be two regions reserved for
crash dump kernel.
In order to distinct from the high region and make no effect to the use
of existing kexec-tools, rename the low region as "Crash kernel (low)",
and pass the low region by reusing DT property
"linux,usable-memory-range". We made the low memory region as the last
range of "linux,usable-memory-range" to keep compatibility with existing
user-space and older kdump kernels.

Besides, we need to modify kexec-tools:
arm64: support more than one crash kernel regions(see [1])

Another update is document about DT property 'linux,usable-memory-range':
schemas: update 'linux,usable-memory-range' node schema(see [2])

Changes since [v17]: v17 --> v19
1. Patch 0001-0004
   Introduce generic parse_crashkernel_high_low() to bring the parsing of
   "crashkernel=X,high" and the parsing of "crashkernel=X,low" together,
   then use it instead of the call to parse_crashkernel_{high|low}(). Two
   confusing parameters of parse_crashkernel_{high|low}() are deleted.

   I previously sent these four patches separately:
   [1] https://lkml.org/lkml/2021/12/25/40
2. Patch 0005-0009
   Introduce generic reserve_crashkernel_mem[_low](), the implementation of
   these two functions is based on function reserve_crashkernel[_low]() in
   arch/x86/kernel/setup.c. There is no functional change for x86.
   1) The check position of xen_pv_domain() does not change.
   2) Still 1M alignment for crash kernel fixed region, when 'base' is specified.

   To avoid compilation problems on other architectures: patch 0004 moves
   the definition of global variable crashk[_low]_res from kexec_core.c to
   crash_core.c, and provide default definitions for all macros involved, a
   particular platform can redefine these macros to override the default
   values.
3. 0010, only one line of comment was changed.
4. 0011
   1) crashk_low_res may also a valid reserved memory, should be checked
      in crash_is_nosave(), see arch/arm64/kernel/machine_kexec.
   2) Drop memblock_mark_nomap() for crashk_low_res, because of:
      2687275a5843 arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required
   3) Also call kmemleak_ignore_phys() for crashk_low_res, because of:
      85f58eb18898 arm64: kdump: Skip kmemleak scan reserved memory for kdump
5. 0012, slightly rebased, because the following patch is applied in advance. 
   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/linus&id=8347b41748c3019157312fbe7f8a6792ae396eb7
6. 0013, no change.

Others:
1. Discard add ARCH_WANT_RESERVE_CRASH_KERNEL
2. When allocating crash low memory, the start address still starts from 0.
   low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
3. Discard change (1ULL << 32) to CRASH_ADDR_LOW_MAX.
4. Ensure the check position of xen_pv_domain() have no change.
5. Except patch 0010 and 0012, all "Tested-by", "Reviewed-by", "Acked-by" are removed.
6. Update description.



Changes since [v16]
- Because no functional changes in this version, so add
  "Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>" for patch 1-9
- Add "Reviewed-by: Rob Herring <robh@kernel.org>" for patch 8
- Update patch 9 based on the review comments of Rob Herring
- As Catalin Marinas's suggestion, merge the implementation of
  ARCH_WANT_RESERVE_CRASH_KERNEL into patch 5. Ensure that the
  contents of X86 and ARM64 do not overlap, and reduce unnecessary
  temporary differences.

Changes since [v15]
-  Aggregate the processing of "linux,usable-memory-range" into one function.
   Only patch 9-10 have been updated.

Changes since [v14]
- Recovering the requirement that the CrashKernel memory regions on X86
  only requires 1 MiB alignment.
- Combine patches 5 and 6 in v14 into one. The compilation warning fixed
  by patch 6 was introduced by patch 5 in v14.
- As with crashk_res, crashk_low_res is also processed by
  crash_exclude_mem_range() in patch 7.
- Due to commit b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
  has removed the architecture-specific code, extend the property "linux,usable-memory-range"
  in the platform-agnostic FDT core code. See patch 9.
- Discard the x86 description update in the document, because the description
  has been updated by commit b1f4c363666c ("Documentation: kdump: update kdump guide").
- Change "arm64" to "ARM64" in Doc.


Changes since [v13]
- Rebased on top of 5.11-rc5.
- Introduce config CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL.
Since reserve_crashkernel[_low]() implementations are quite similar on
other architectures, so have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in
arch/Kconfig and select this by X86 and ARM64.
- Some minor cleanup.

Changes since [v12]
- Rebased on top of 5.10-rc1.
- Keep CRASH_ALIGN as 16M suggested by Dave.
- Drop patch "kdump: add threshold for the required memory".
- Add Tested-by from John.

Changes since [v11]
- Rebased on top of 5.9-rc4.
- Make the function reserve_crashkernel() of x86 generic.
Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
and arm64 use the generic version to reimplement crashkernel=X.

Changes since [v10]
- Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.

Changes since [v9]
- Patch 1 add Acked-by from Dave.
- Update patch 5 according to Dave's comments.
- Update chosen schema.

Changes since [v8]
- Reuse DT property "linux,usable-memory-range".
Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
memory region.
- Fix kdump broken with ZONE_DMA reintroduced.
- Update chosen schema.

Changes since [v7]
- Move x86 CRASH_ALIGN to 2M
Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
- Update Documentation/devicetree/bindings/chosen.txt.
Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
suggested by Arnd.
- Add Tested-by from Jhon and pk.

Changes since [v6]
- Fix build errors reported by kbuild test robot.

Changes since [v5]
- Move reserve_crashkernel_low() into kernel/crash_core.c.
- Delete crashkernel=X,high.
- Modify crashkernel=X,low.
If crashkernel=X,low is specified simultaneously, reserve spcified size low
memory for crash kdump kernel devices firstly and then reserve memory above 4G.
In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
pass to crash dump kernel by DT property "linux,low-memory-range".
- Update Documentation/admin-guide/kdump/kdump.rst.

Changes since [v4]
- Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.

Changes since [v3]
- Add memblock_cap_memory_ranges back for multiple ranges.
- Fix some compiling warnings.

Changes since [v2]
- Split patch "arm64: kdump: support reserving crashkernel above 4G" as
two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
patch.

Changes since [v1]:
- Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
- Remove memblock_cap_memory_ranges() i added in v1 and implement that
in fdt_enforce_memory_region().
There are at most two crash kernel regions, for two crash kernel regions
case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
and then remove the memory range in the middle.

[1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
[2]: https://github.com/robherring/dt-schema/pull/19 
[v1]: https://lkml.org/lkml/2019/4/2/1174
[v2]: https://lkml.org/lkml/2019/4/9/86
[v3]: https://lkml.org/lkml/2019/4/9/306
[v4]: https://lkml.org/lkml/2019/4/15/273
[v5]: https://lkml.org/lkml/2019/5/6/1360
[v6]: https://lkml.org/lkml/2019/8/30/142
[v7]: https://lkml.org/lkml/2019/12/23/411
[v8]: https://lkml.org/lkml/2020/5/21/213
[v9]: https://lkml.org/lkml/2020/6/28/73
[v10]: https://lkml.org/lkml/2020/7/2/1443
[v11]: https://lkml.org/lkml/2020/8/1/150
[v12]: https://lkml.org/lkml/2020/9/7/1037
[v13]: https://lkml.org/lkml/2020/10/31/34
[v14]: https://lkml.org/lkml/2021/1/30/53
[v15]: https://lkml.org/lkml/2021/10/19/1405
[v16]: https://lkml.org/lkml/2021/11/23/435
[v17]: https://lkml.org/lkml/2021/12/10/38
[v18]: https://lkml.org/lkml/2021/12/22/424


Chen Zhou (6):
  kexec: move crashk[_low]_res to crash_core module
  x86/setup: Move CRASH[_BASE]_ALIGN and CRASH_ADDR_{LOW|HIGH}_MAX to
    asm/kexec.h
  arm64: kdump: introduce some macros for crash kernel reservation
  arm64: kdump: reimplement crashkernel=X
  of: fdt: Add memory for devices by DT property
    "linux,usable-memory-range"
  kdump: update Documentation about crashkernel

Zhen Lei (7):
  kdump: add helper parse_crashkernel_high_low()
  x86/setup: Use parse_crashkernel_high_low() to simplify code
  kdump: make parse_crashkernel_{high|low}() static
  kdump: reduce unnecessary parameters of parse_crashkernel_{high|low}()
  x86/setup: Add and use CRASH_BASE_ALIGN
  kdump: Add helper reserve_crashkernel_mem[_low]()
  x86/setup: Use generic reserve_crashkernel_mem[_low]()

 Documentation/admin-guide/kdump/kdump.rst     |  11 +-
 .../admin-guide/kernel-parameters.txt         |  11 +-
 arch/arm64/include/asm/kexec.h                |   6 +
 arch/arm64/kernel/machine_kexec.c             |   5 +-
 arch/arm64/kernel/machine_kexec_file.c        |  12 +-
 arch/arm64/kernel/setup.c                     |  13 +-
 arch/arm64/mm/init.c                          |  41 ++--
 arch/x86/include/asm/kexec.h                  |  27 +++
 arch/x86/kernel/setup.c                       | 128 +---------
 drivers/of/fdt.c                              |  33 ++-
 include/linux/crash_core.h                    |  17 +-
 include/linux/kexec.h                         |   4 -
 kernel/crash_core.c                           | 224 +++++++++++++++++-
 kernel/kexec_core.c                           |  17 --
 14 files changed, 350 insertions(+), 199 deletions(-)

-- 
2.25.1

