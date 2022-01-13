Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5DD48D5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiAMKgO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jan 2022 05:36:14 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45465 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiAMKgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:36:11 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MOzKk-1my9qH0deG-00PQ2a; Thu, 13
 Jan 2022 11:36:01 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v5 0/3] m68k: Add Virtual M68k Machine
Date:   Thu, 13 Jan 2022 11:35:56 +0100
Message-Id: <20220113103559.2577216-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ypmvwSpEjIlNR1JptUFkgoqoI4kcsgEWjidR96JN7jBwe/Jnnzu
 EaJM9xDDBjNZU6PdvZMcMXZlxfzBy+jTg7Zvqir60uIWyNRJuKQPI+58SNMCPs2LVhRvYcd
 nYJqG+RHuiw0+9XqLs8cX56gFvyr4yhLO1pGqwxOTBlcPX/lJ+EcNlT5/7CY8cL/A7v/h8K
 bI0WsqBwJ+lOGdHzoiBxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LgidH8tRquA=:bMZ6wkalgZOaiz/5y/rwwV
 61cyMAPWwWB9dccQTrWEN1yZlMSmnJBqH5oA+sHVd661EeUtSMDhvaWBMRRyDxd4W1zoJWbgP
 IG7ZbC3FltGaAFUhnA00izPRc/1YsyrLjCxesBVn2DcYdfKj80nWao2431B9FMFxetx5EOu/f
 D3sJI2nGjsqK0mylWqdRvBa2fUUeyjtmsSMHLw5EdMf2xGSNfWRTEf5vN6lbHWESuraxi+loA
 woCCNLqWVTHsZr7C/ZFvy+zGTC/24jNUCz2QAAHEFcBZNcYyFzu4OVUm8F5bOyOLgXWdfWbF5
 1s8jBwTTJigqPN3GG6hxEvlqHsSGYxks+Mzp/1kDvreDQAu5KAhcIfefLmJLkq6u1oz2Zho4U
 ZKNqSa3CfQSH64Wy3Za31yEIqEgZYtgWakfR/2/1AfXbYsr80LG4vs11nsmomdmWIX3XLZb3M
 2IEhLSPYj9QLQQwP9Zq6txe9lUk2+AkL8FO9PBkudA52ArA2vwZReea0IXjWE+GnBpcL2Zg8t
 xR8hRJdbQn/HArLpvpTp4KOASePHik6BKS3oVRzg8cK+gWMn7631cDBgj6E0x4nJbyeZ2UHOn
 Wj1huUI3VejihIUi8tKqilWUXkZW3YRpz+xCzmHWNVgdGDJRTKpVslNtcFqQW/G7peMaj5eRB
 FixGaIB5XQ8vBr8nqcJfOGbwRQbTR4X+Zh/8hSGchESbpvSvh2jAjzx0+ex+LvS/pv9g=
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

Laurent Vivier (3):
  m68k: add asm/config.h
  m68k: introduce a virtual m68k machine
  m68k: virt: Remove LEGACY_TIMER_TICK

 arch/m68k/Kbuild                           |   1 +
 arch/m68k/Kconfig.machine                  |  16 +++
 arch/m68k/amiga/config.c                   |   1 +
 arch/m68k/apollo/config.c                  |   1 +
 arch/m68k/atari/config.c                   |   1 +
 arch/m68k/bvme6000/config.c                |   1 +
 arch/m68k/configs/virt_defconfig           |  65 +++++++++++
 arch/m68k/hp300/config.c                   |   1 +
 arch/m68k/include/asm/config.h             |  35 ++++++
 arch/m68k/include/asm/irq.h                |   3 +-
 arch/m68k/include/asm/pgtable_mm.h         |   7 ++
 arch/m68k/include/asm/setup.h              |  44 ++++++--
 arch/m68k/include/asm/virt.h               |  26 +++++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  18 ++++
 arch/m68k/include/uapi/asm/bootinfo.h      |   1 +
 arch/m68k/kernel/Makefile                  |   1 +
 arch/m68k/kernel/head.S                    |  31 ++++++
 arch/m68k/kernel/setup_mm.c                |  30 ++----
 arch/m68k/mac/config.c                     |   1 +
 arch/m68k/mm/kmap.c                        |  23 ++--
 arch/m68k/mvme147/config.c                 |   1 +
 arch/m68k/mvme16x/config.c                 |   1 +
 arch/m68k/q40/config.c                     |   1 +
 arch/m68k/virt/Makefile                    |   6 ++
 arch/m68k/virt/config.c                    | 112 +++++++++++++++++++
 arch/m68k/virt/ints.c                      | 120 +++++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 +++++++++++++
 arch/m68k/virt/timer.c                     | 120 +++++++++++++++++++++
 28 files changed, 700 insertions(+), 40 deletions(-)
 create mode 100644 arch/m68k/configs/virt_defconfig
 create mode 100644 arch/m68k/include/asm/config.h
 create mode 100644 arch/m68k/include/asm/virt.h
 create mode 100644 arch/m68k/include/uapi/asm/bootinfo-virt.h
 create mode 100644 arch/m68k/virt/Makefile
 create mode 100644 arch/m68k/virt/config.c
 create mode 100644 arch/m68k/virt/ints.c
 create mode 100644 arch/m68k/virt/platform.c
 create mode 100644 arch/m68k/virt/timer.c

-- 
2.34.1

