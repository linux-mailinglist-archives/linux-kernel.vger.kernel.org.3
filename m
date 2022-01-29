Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF684A3167
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353054AbiA2SnH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 Jan 2022 13:43:07 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353019AbiA2SnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 13:43:02 -0500
Received: from quad ([82.142.10.94]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1McYP5-1mfMoD0nW9-00cxX2; Sat, 29
 Jan 2022 19:42:28 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v13 0/5] m68k: Add Virtual M68k Machine
Date:   Sat, 29 Jan 2022 19:42:20 +0100
Message-Id: <20220129184225.407100-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:q+5F+WTqr44/PzKs2xl3WQ8fL52fjl+jaIi3PGqI/EBlOsBsq9x
 yGQTUespgK0MAK1AVrK4QJqZuVOyphmaNEHWNYycOAU+O8JVl9OngRj2WdrgxP0fucQqyTz
 V+Ev+VUoKxuV5o7Pl04i4cl5luUSBX+RwYAVYrsaok7mfMmI3nlclsiUw+6vPnmX/SFgVwf
 8b39+0Y6JsI/rsaISE4Zw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xk5+xrThGSk=:MLHHwOIB8IkAZZsEeLvHH/
 JKsa2XW145CZdSoiUv1DOuIMtgKKbSXvLiW8QPaXHFv+XMBhQ+QUGvRbGOgX5cMn2MHPrdJJA
 Tq3/mLPFVWf7155+Zr7pGtp57SKrwxh+wwFkCClvxzI6a5ttup0jVvDX8ZTIj2y+6cIyuZwqE
 VtB79vSqHd+vdsXpD/vwcHWJ+H3Wm9m06b9X5c60S37gQSs8KpPEZEnfyufa/fYC6usmJEa3T
 H3MVyvbd+ik6W+pUk3Pc6zXdQ0HQfOVzFS/AllXGkLDmHfv11rfbt9ko0cL+gi+d7CLhHw5Fr
 JVEBqE4BT+YSysdEWrZvWuLl773E9loEwD28IDOR0lDkTgHN3+bJtTPCb2iG5t9+r9jOpQDX2
 fqbYEIhyCiw6Q9UfyEyjeAxQEU66CvNscJU9e/l69oTI1ADj6YH3HN+x7l6sGQeFnsvFjsExL
 Ard688m20ggt1/hBaDClJm5YPYkEHsq1uSG1ES87opcpWcu5tyxFHQLf/EWDi/f0uMEj7T9Gj
 Y3NQfxGYHKK3HW+Nuuudi4F28UJNuohAVd5qMtYv2TinkA7Yem42MJM5ZoE1TbFO7/jigPa3i
 9wU+6U8PXQkKDqjB7Ja4xClQ/vRoHYp8E+/412AOgR0Qnm5cdfAQRLnk2O+9v/A59NsFL/0EL
 RiZ30rN9sfjoW8eKqmkJUct0dt90AspHYtnhKrtKHAe2LfN4Gdbwvp05PXvOvPfW6VS0=
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

    https://youtu.be/s_ve0bgoldfish_timer_shutdownCC9q4
    [Demo at 38:00]

v13:
- rework clocksource according to Daniel's comments
- move the timer registers definition to include/clocksource/timer-goldfish.h

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
 arch/m68k/kernel/head.S                    |  31 +++++
 arch/m68k/kernel/setup_mm.c                |  30 ++--
 arch/m68k/mac/config.c                     |   1 +
 arch/m68k/mm/kmap.c                        |  23 +++-
 arch/m68k/mvme147/config.c                 |   1 +
 arch/m68k/mvme16x/config.c                 |   1 +
 arch/m68k/q40/config.c                     |   1 +
 arch/m68k/virt/Makefile                    |   6 +
 arch/m68k/virt/config.c                    | 130 +++++++++++++++++
 arch/m68k/virt/ints.c                      | 153 +++++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 ++++++++++
 drivers/clocksource/Kconfig                |   7 +
 drivers/clocksource/Makefile               |   1 +
 drivers/clocksource/timer-goldfish.c       | 153 +++++++++++++++++++++
 drivers/rtc/rtc-goldfish.c                 |  44 +++---
 drivers/tty/goldfish.c                     |  20 +--
 include/clocksource/timer-goldfish.h       |  31 +++++
 include/linux/goldfish.h                   |  15 +-
 35 files changed, 867 insertions(+), 81 deletions(-)
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

