Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9648EAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiANN3H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 08:29:07 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbiANN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:29:05 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MIxBc-1mtR5L0ghu-00KQXj; Fri, 14
 Jan 2022 14:28:53 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k@lists.linux-m68k.org, Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v7 0/4] m68k: Add Virtual M68k Machine
Date:   Fri, 14 Jan 2022 14:28:46 +0100
Message-Id: <20220114132850.3433263-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:m+RGYi8U+lE78sPsNWInFn18FOcPahMNdWLiss5x0dvmHbyXtr2
 4pqpPpdhctHIwha7JY6Jx/Kfc8TJoVGyKhqnmluy3g24CeBmHMHOgq/LLuLOY63lwF1Mby4
 9bQH8Ri/9JUfr4lQpF6Fmuqfv3rkqswiTHCZdj+44NwJ1RDazB352DtO2qcIbb8iuXT2VE8
 m8btpbjelu/Fmazpjbjeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xadTaUrCyZc=:mniGAX20kqxrbVxgpqm/P0
 sz29ibZjVpOQBVHBW9nJr/hwNbGACfxCDjvAOMc/DuHEbmmu8DN4Jg0lvWqcXyMo1tMZSyvKh
 EhPFqBr/gP9IXsy6HpDDgNmSM2uyxrCfPj4gli0XU7KohvqQUZqhV+/Sr3Ol5fdj/ohV1IXBy
 pZjLLhcf03ASsIT4iJw5VdGT7N0EIXYrqbDul+CE6sYXB+x3PAZipX6UniRbgTKw04YQh58oj
 DaiLiOh3oMQKeW+HgkyOSNzckXbRWMLEV3n3u7OMmyRY5fIvwge5w6jH1/Ms6TL+17w1J7XKp
 wZrVaVg1G9Z9TIUJsnX7DKi1tLVSJBLDBCoZpoXg0mCqxAbDicyryQljsVgPEUgPw4qQSmo23
 ElFh/gOzjwLvcpUsmmavpr08MK/c8CiWu0i19JKcdLlQZEpD/PfnVRrS56M42eGbI4Z7x3QJm
 spjocSKEZsIYSCsHoWYhpfsaIUTKZQ/VX3b/fJyCrNiUykjjH/Lmn2WMAfciIiqqy1k+LONzt
 pQMw5nahtqWfGjlaZ9UIS0SLg6ZoctjNJTwT70MoXA91h+2t2PH4uqQqKx6lhUF+0rknT7anm
 L7uQitR4bHEWiffWExYoQ07CDnNGcdH1YF5vNGkA9GdlllcvFArJcs5iVtzuZsQGW7CEqRv8s
 lPqqLCN0j7AAvRAqoBX6VSTFHQdVzRgWJa/iV+mmeAKkYu0bT+8GVEuR3u8qthRUja6I=
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

Laurent Vivier (4):
  m68k: add asm/config.h
  rtc: goldfish: introduce goldfish_ioread32()/goldfish_iowrite32()
  clocksource/drivers: Add a goldfish-timer clocksource
  m68k: introduce a virtual m68k machine

 arch/m68k/Kbuild                           |   1 +
 arch/m68k/Kconfig.machine                  |  17 +++
 arch/m68k/amiga/config.c                   |   1 +
 arch/m68k/apollo/config.c                  |   1 +
 arch/m68k/atari/config.c                   |   1 +
 arch/m68k/bvme6000/config.c                |   1 +
 arch/m68k/configs/virt_defconfig           |  65 ++++++++++
 arch/m68k/hp300/config.c                   |   1 +
 arch/m68k/include/asm/config.h             |  35 ++++++
 arch/m68k/include/asm/irq.h                |   3 +-
 arch/m68k/include/asm/pgtable_mm.h         |   7 ++
 arch/m68k/include/asm/setup.h              |  44 +++++--
 arch/m68k/include/asm/virt.h               |  25 ++++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  18 +++
 arch/m68k/include/uapi/asm/bootinfo.h      |   1 +
 arch/m68k/kernel/Makefile                  |   1 +
 arch/m68k/kernel/head.S                    |  31 +++++
 arch/m68k/kernel/setup_mm.c                |  30 ++---
 arch/m68k/mac/config.c                     |   1 +
 arch/m68k/mm/kmap.c                        |  23 ++--
 arch/m68k/mvme147/config.c                 |   1 +
 arch/m68k/mvme16x/config.c                 |   1 +
 arch/m68k/q40/config.c                     |   1 +
 arch/m68k/virt/Makefile                    |   6 +
 arch/m68k/virt/config.c                    | 119 ++++++++++++++++++
 arch/m68k/virt/ints.c                      | 120 ++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 +++++++++++
 drivers/clocksource/Kconfig                |   7 ++
 drivers/clocksource/Makefile               |   1 +
 drivers/clocksource/timer-goldfish.c       | 139 +++++++++++++++++++++
 drivers/rtc/rtc-goldfish.c                 |  39 +++---
 include/clocksource/timer-goldfish.h       |  11 ++
 32 files changed, 769 insertions(+), 55 deletions(-)
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

