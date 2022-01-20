Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DE49490A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358230AbiATIEN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jan 2022 03:04:13 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:41359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbiATIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:04:12 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N4h7p-1mCTAl0WxT-011jH5; Thu, 20
 Jan 2022 09:03:52 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v11 0/5] m68k: Add Virtual M68k Machine
Date:   Thu, 20 Jan 2022 09:03:42 +0100
Message-Id: <20220120080347.1595379-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:mPStHtRaRfDEdBa75XeuQppZv7fubnm+AbaZjJo+Eohwlp0pFzl
 cGIpLXDun3FQTGu0ZdgMi492iHFmXusfoU9a+Smn6YueFxu0rumVg5Gvh+8KvyHn3eB+WYk
 W+BnML7xwSzXGj06opQajm4tcjmJ7ZZcPEIoBQZyD/uQIZ65VaDQeWMk+XXzmtJGSIMUG3g
 St0YDn/fd8ttVkcATku1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T60si9ksIP4=:4jz4EywuAeAGsuNWAfOQ2B
 EnFmfr2pK1Pg3+TV6rqRuOGlgOPKzBfJjYy/9cvtZIauSHWbC8JWnCZ6Dm3qDGvMV0MIIG/Vq
 prIcXBCz4YBTTjJZRrYBkKOXYarKy/kyjXKvaCK/DGiKTigokjuVtXHKdoJDiPzGGy85qw4PX
 epEkTJ+mBIAmOGWRj3TDOk+ffbRmASMN7BO4W4o0Gwbs1t1kjHUxISAfW4J5TAQS9fVQDof1k
 /Z8Lt3vqxEvH9y/7rUfy+WkNNNnEudfDXQu0k4QNCfcChqEuXeZWG8FIszxsqNqA0h8yJDA81
 du/u+il7bl2Wv21vIP1RGWmCotdQbaBM+F5BMzngTFq7JrPocalM90S92pUzP0Pf5zWUbFqcc
 hVb3Sjd4rGQudNcfUwEF7end0Oq7//ytrOHm+qDAtfrO6kxpgDJLetiilgZwY4C4bOk2iHTXi
 e6gf3nx1g5QWrZjLBLrpD5mjR7jdQd2E1Er+vSdRqNC0SJfs2MuDFytDQikbGNA8C4Oo1SpKq
 JngrZM0DDsRE1R1oWZQyjUr5JOf0nno5lgAKHoGhzVzwzPxstuhUFnNMIPeHv24VuqnzbIk+h
 6juUDoy3iOQy0K3EBBbpnAPMY8+g1C/1S3xaxNe27gfPryLnBSWArUprctxrZ9n0pa0WtKeds
 j2QEnvShjo1w+5H5XV47n6VBX/YDGvloxca/i4ixh3/towN4DqU0OGKRZWN1O6DrvL1U=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most powerful m68k machine emulated by QEMU is a Quadra 800,
but this machine is very limited: only 1 GiB of memory and only some
specific interfaces, with no DMA.

The Virtual M68k Machine is based on Goldfish interfaces defined by Google
for Android simulator. It uses Goldfish-rtc (timer and RTC),
Goldfish-pic (PIC) and Goldfish-tty (for early tty).

The machine is created with 128 virtio-mmio buses, and they can
be used to add serial console, GPU, disk, NIC, HID, hwrng, 9PFS...

The virtual m68k machine has been merged in QEMU and will be available
with the release 6.0.

This series introduces the support of this new machine in the linux kernel.

If you want to try:

- Configure and build latest QEMU with (or download qemu 6.0 binary):

  .../configure --target-list=m68k-softmmu --enable-virglrenderer
  make

- Configure and build linux with:

  make virt_defconfig
  make vmlinux

A pre-installed qcow2 disk image is available at:

http://vivier.eu/debian-10.0.qcow2

You can run the machine with something like:

qemu-system-m68k -M virt \
  -m 3G \
  -chardev stdio,signal=off,mux=on,id=char0 \
  -mon chardev=char0,mode=readline \
  -kernel vmlinux \
  -append "console=hvc0 root=/dev/vda2" \
  -blockdev node-name=system,driver=file,filename=debian-10.0.qcow2 \
  -blockdev node-name=drive0,driver=qcow2,file=system \
  -device virtio-blk-device,drive=drive0 \
  -serial chardev:char0 \
  -device virtio-net-device,netdev=hostnet0 \
  -netdev bridge,id=hostnet0,br=virbr0,helper=/usr/libexec/qemu-bridge-helper \
  -device virtio-serial-device \
  -device virtio-gpu-device \
  -device virtconsole,chardev=char0 \
  -device virtio-keyboard-device \
  -device virtio-mouse-device

You can watch a presentation about the machine on the Planet m68k channel:

    https://youtu.be/s_ve0bCC9q4
    [Demo at 38:00]

v11:
- rename goldfish_ioread32()/goldfish_iowrite32() to gf_ioread32()/gfiowrite32()
- move them to linux/goldfish.h and m68k/asm/io.h
- change patches order (tty first to revert my previous work)
- fix clocksource by clearing interrupt on tick not on next_event()
  and clearing shift
- add missing clocksource_register_hz()
- rebase

v10:
- move goldfish_ioread32()/goldfish_iowrite32() to io.h
- also update goldfish-tty
- use READ_ONCE()/WRITE_ONCE() for in_nmi

v9:
- include <linux/memblock.h> to declare min_low_pfn
- goldfish accessors: s/CONFIG_CPU_BIG_ENDIAN/CONFIG_M68K/

v8:
- GF_PUT_CHAR is a 32bit register (in arch/m68k/kernel/head.S)
- rework goldfish-pic and virt_ctrl

v7:
- add "#include <linux/slab.h>" in timer-goldfish.c for kzalloc()
- update timer-goldfish Kconfig
- remove EXPORT_SYMBOL()
- introduce goldfish_ioread32()/goldfish_iowrite32()

v6:
- fix goldfish-rtc endianness
- move goldfish-timer code to drivers/clocksource
- remove LEGACY_TIMER_TICK and use directly goldfish-timer

v5:
- add GENERIC_CLOCKEVENTS in Kconfig.machine

v4:
- update PATCH 1: comments and parameter names
- add a patch to move to generic clockevents
  (I prefer to have a separate patch as it can be used as an example to
   move from legacy timer tick to generic clockevents)

v3:
- introduce config.h to export prototypes to arch/m68k/kernel/setup_mm.c
- define virt_nmi_handler as static

v2:
- Remove VIRTO_MENU set y
- sort the selects
- add CONFIG_LOCALVERSION="-virt"
- generate virt_defconfig using "make savedefconfig"
- rename MACH_VIRTONLY to MACH_VIRT_ONLY
- add a test_notvirt label in head.S
- rework iounmap() to use two separate #ifdefs
- use %u in virt_get_model()
- drop show_registers() in config.c
- drop pr_err() from config_virt()
- sort includes in ints.c
- call virt_irq_enable() in virt_irq_startup()
- drop virt_irq_shutdown() and use virt_irq_disable()
- move in_nmi into virt_nmi_handler()
- use pr_warn() in virt_nmi_handler()
- rework goldfish_pic_irq() IRQ scan
- copy goldfish-pic IRQs related information from QEMU hw/m68k/virt
- add a comment to "min_low_pfn = 0"
- use platform_device_register_simple()
- use goldfish_timer_read(), upper_32_bits() and lower_32_bits()

Thanks,
Laurent

Laurent Vivier (5):
  m68k: add asm/config.h
  tty: goldfish: introduce gf_ioread32()/gf_iowrite32()
  rtc: goldfish: use gf_ioread32()/gf_iowrite32()
  clocksource/drivers: Add a goldfish-timer clocksource
  m68k: introduce a virtual m68k machine

 arch/m68k/Kbuild                           |   1 +
 arch/m68k/Kconfig.machine                  |  17 +++
 arch/m68k/amiga/config.c                   |   1 +
 arch/m68k/apollo/config.c                  |   1 +
 arch/m68k/atari/config.c                   |   1 +
 arch/m68k/bvme6000/config.c                |   1 +
 arch/m68k/configs/virt_defconfig           |  65 +++++++++
 arch/m68k/hp300/config.c                   |   1 +
 arch/m68k/include/asm/config.h             |  35 +++++
 arch/m68k/include/asm/io.h                 |   3 +
 arch/m68k/include/asm/irq.h                |   3 +-
 arch/m68k/include/asm/pgtable_mm.h         |   7 +
 arch/m68k/include/asm/setup.h              |  44 ++++--
 arch/m68k/include/asm/virt.h               |  25 ++++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  18 +++
 arch/m68k/include/uapi/asm/bootinfo.h      |   1 +
 arch/m68k/kernel/Makefile                  |   1 +
 arch/m68k/kernel/head.S                    |  31 ++++
 arch/m68k/kernel/setup_mm.c                |  30 +---
 arch/m68k/mac/config.c                     |   1 +
 arch/m68k/mm/kmap.c                        |  23 ++-
 arch/m68k/mvme147/config.c                 |   1 +
 arch/m68k/mvme16x/config.c                 |   1 +
 arch/m68k/q40/config.c                     |   1 +
 arch/m68k/virt/Makefile                    |   6 +
 arch/m68k/virt/config.c                    | 119 +++++++++++++++
 arch/m68k/virt/ints.c                      | 133 +++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 +++++++++
 drivers/clocksource/Kconfig                |   7 +
 drivers/clocksource/Makefile               |   1 +
 drivers/clocksource/timer-goldfish.c       | 162 +++++++++++++++++++++
 drivers/rtc/rtc-goldfish.c                 |  30 ++--
 drivers/tty/goldfish.c                     |  20 +--
 include/clocksource/timer-goldfish.h       |  11 ++
 include/linux/goldfish.h                   |  15 +-
 35 files changed, 820 insertions(+), 69 deletions(-)
 create mode 100644 arch/m68k/configs/virt_defconfig
 create mode 100644 arch/m68k/include/asm/config.h
 create mode 100644 arch/m68k/include/asm/virt.h
 create mode 100644 arch/m68k/include/uapi/asm/bootinfo-virt.h
 create mode 100644 arch/m68k/virt/Makefile
 create mode 100644 arch/m68k/virt/config.c
 create mode 100644 arch/m68k/virt/ints.c
 create mode 100644 arch/m68k/virt/platform.c
 create mode 100644 drivers/clocksource/timer-goldfish.c
 create mode 100644 include/clocksource/timer-goldfish.h

-- 
2.34.1

