Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CD496631
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiAUUIR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 15:08:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:56319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiAUUIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:08:12 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MmU9R-1mSu1J43Zx-00iUtq; Fri, 21
 Jan 2022 21:07:45 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v12 0/5] m68k: Add Virtual M68k Machine
Date:   Fri, 21 Jan 2022 21:07:33 +0100
Message-Id: <20220121200738.2577697-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:0iNDGFjLUwPwbyrIVgMPeBxpDtj2yGcYN/TtaQuzKHEntU1w7Ow
 dyZBJflwLrqIic3Bhrv3I+8l1RCVCdaTdaPNlMFuoUUYm6Q7np7B4C62eBOFbgi5AeN6uUi
 EszisD0R4NSr1ioa2DMdJ3f7PrCQ37SM8igtQMer4HhqSvg2Zj5rqvndc5OfBS8ECijX7NT
 wutl2wMjyGujHKUOv2zJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:20FrPwPGfFc=:DdYlHCefwYVyP8EXIqJZu0
 OzydmDv0OA1G0sLdEVQ3n30A8HCB1eFMmJG+jszo7kNDfeC0yjGGG8aGyBkdY6Ef46ypSyJZQ
 4f/MpwtlItH+gt1vptaGGZRchdgiXoQElXJvcg2TSE7w+KpQncMDZ0tJQ37BvQV6er8ac1vUG
 lfDZ4VogLTotLBjx1ynI7afH0RfAuS3tJQRKHAJ+99+xgRqSBG1lsotdLdSxdAQwXc+W/F39x
 1rY1AkwxGQrYyQusctBSZHThBMdoqeKV6quAQrbxgM3Ek0/XrK7TC2FKJYHRS+xsX+ApV1IBd
 YyGX5id/yvaIhLhx/vUyrsYRHAAWfWqSB4ZFbTONpz924WdAL69mvLhP2k0Q7wTbiv+b2ivzI
 U6SL4ZBpKHyX8Rbz5mbuCZSrCZ80F1Gqs+gkwVI03imGzXTbhetBEKKyTL5lA169e0ItYo6Fg
 LuI6xiJ+2VdI2YJibF5kFye96IouMo6YsB4uvU6iZxIN8hfU14HinIPrmEDNLmduUQAtdUABj
 NPR0fRTzjhTZiCzZKtQMidmTcSBpSP7TSNGai0Cyl82ZQoZKzpD4+vdwz8OMlDkE3cz7kY/wc
 +wARvwpV14YpQuf5s+/8td5MrTiVgxrNsbz5ojwU/TxHNnVtXNBEmUwCfibQrZJZ7NO/92yYf
 SrX+Kycir/UBsuGe2rF6s48xnNTGCWQoef/kV30dKrfYFkOanPDd3x/Akxp4wLjS9TGs=
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

v12:
- add request_resource() for pic and virtctrl
- enable virtio-snd in virt_defconfig
- add #include <linux/goldfish.h> in rtc and timer

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
 arch/m68k/configs/virt_defconfig           |  68 +++++++++
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
 arch/m68k/virt/config.c                    | 130 ++++++++++++++++
 arch/m68k/virt/ints.c                      | 153 +++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 +++++++++
 drivers/clocksource/Kconfig                |   7 +
 drivers/clocksource/Makefile               |   1 +
 drivers/clocksource/timer-goldfish.c       | 163 +++++++++++++++++++++
 drivers/rtc/rtc-goldfish.c                 |  31 ++--
 drivers/tty/goldfish.c                     |  20 +--
 include/clocksource/timer-goldfish.h       |  11 ++
 include/linux/goldfish.h                   |  15 +-
 35 files changed, 856 insertions(+), 69 deletions(-)
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

