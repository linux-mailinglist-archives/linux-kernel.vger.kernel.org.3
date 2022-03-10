Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3054D4321
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiCJJIH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 04:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiCJJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:07:50 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA993137768;
        Thu, 10 Mar 2022 01:06:49 -0800 (PST)
Received: from quad ([82.142.8.122]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N6srB-1oDfpd1yL1-018ODl; Thu, 10
 Mar 2022 10:00:50 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v15 0/5] m68k: Add Virtual M68k Machine
Date:   Thu, 10 Mar 2022 10:00:43 +0100
Message-Id: <20220310090048.1933020-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:e5xppiFh9Gm+arxF2OZAGeqW7ue2mRq0txNg7MRNVTuzlkS2xFL
 u6WvJrjpCXp1AT+h+BZevjw4TPRI2SadJRcUUi1UD7vcvC2+khScZheSgXavzTvqIhE3eES
 9BEdXlZwWkuQQCVVpy29yFQ/7WORpOYw8ZRDvtFqSUWp0gHdakk8YPwNYh3nNGBWPzxovuj
 oHtmUIHSWdwFBju+3YoTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0jQqKP24XY4=:IVE67pbq1tJIaS4eIkmqcp
 tEqCBkRwbZgdqVcwjhPGt7pk5lITnvE9Wrzcv9D75lWkfcsYAXwUFa3nsoWxC7aMkh8COFOPG
 KUGjFFEluaXJu22jlhSL7rnCeWi/VWlWZ8w/ZTS1A2Xk5qS2YQHXPfHzWxE8p3CQWRhNG260N
 YJV2zkjos2Y4MGCpuEQ99i/PVVdkSNdAmxGzNHGYJP12m0x9pnNtuSd6WAKWEdZT5XyHJis44
 21vz5OP5ffUt6++KS5uGIfrKo9MFdsx5OMRF352ra1A8rHXZzZkbxdTMF6qD8b0ddXRi4IwsV
 7MKuaWrMYOP6Tj01nNB/+dfAmpQmpbq42q3TyqHJJZfTyMIlKHZeN5aBJIDPJkA5V2D+/jh61
 B6rJO9vlGhbvu5sKrXJGIaMhCw9IuE40MnNPSOBHTVeBcPuTxbmzwJSZqDdJHTS1MjMP8lmSu
 W0tnBofQEhfFYnQ4bpNUchhxzCuDpbun/jtXWxkaqowsi+Bj0INkAXYMRqts9AJMD3+P83Ewg
 HZQHnwcZcF3wQg9FmPggg+hUg3M9y0vHh99h9F/ui4CXy5LuzIUjrn00q3nwVcEMexuDzFxba
 qhYMRJ6jl06P5mGAMBoM7SvmfUk5WZKLUK8VdBCXBwlwXT3VgnKsQg0WpRSz2/GfTK0CPAxb4
 61JRUHAbXHUVLSM9meUaIyOiMLSKSbKFoYBIa0Ejj0xBXDYR8RJ8U12UVzBHz6nu/mCs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v15:
- rebase
- update clocksource patch description to remove URL

v14:
- address Geert's comments on v13

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
 arch/m68k/mm/kmap.c                        |  21 ++-
 arch/m68k/mvme147/config.c                 |   1 +
 arch/m68k/mvme16x/config.c                 |   1 +
 arch/m68k/q40/config.c                     |   1 +
 arch/m68k/virt/Makefile                    |   6 +
 arch/m68k/virt/config.c                    | 130 +++++++++++++++++
 arch/m68k/virt/ints.c                      | 155 +++++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 ++++++++++
 drivers/clocksource/Kconfig                |   7 +
 drivers/clocksource/Makefile               |   1 +
 drivers/clocksource/timer-goldfish.c       | 153 ++++++++++++++++++++
 drivers/rtc/rtc-goldfish.c                 |  44 +++---
 drivers/tty/goldfish.c                     |  20 +--
 include/clocksource/timer-goldfish.h       |  31 +++++
 include/linux/goldfish.h                   |  15 +-
 35 files changed, 868 insertions(+), 80 deletions(-)
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
2.35.1

