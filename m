Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3024F6C82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiDFVWe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Apr 2022 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbiDFVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:22:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1F62EB;
        Wed,  6 Apr 2022 13:15:59 -0700 (PDT)
Received: from quad ([82.142.17.26]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MsZeX-1nrfk50NpL-00u2Wm; Wed, 06
 Apr 2022 22:15:26 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v16 0/4] m68k: Add Virtual M68k Machine
Date:   Wed,  6 Apr 2022 22:15:19 +0200
Message-Id: <20220406201523.243733-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:xyZVNXwrgrcxzM6hrVyAjSa3g6AWeS2iZHNfzqC2QzOzm65vXa4
 2GY3ZV4SreBU7dAdlKO8rGcaWCINGsRpRpTkYqSkC0lnY1t1E9Xy/Uugnu/t1b6GbBc24BC
 KNBOx4wuLyMQRe6J/2sMYRK6LvAlwzssVTu1byue350iGluNKKlKElostvonx79aL6TdT7X
 F/y4dAS9+gu0lHzmY7/4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/mZczqIKP8E=:jpOZNEZuMWDI2LwLP+UgQo
 Zc84ix0rsDJHCldBj6oWhppnSkrjLNpafh5VFuqtP0AJasqcT7PkIesuqQSrw+I2OG6v9xVHr
 wneL0cVXu3Q9P8wku4WyQfs1nQfZ9esBtCJ3OgSK7jgPCvTmOLwj6B2d8B6lMALbYT357VxNZ
 9n4owuWbGwQn0NvkJV4WjXPxqgG23CLI8KL7G3+eIS9jeqFBrVnYnStnCFqw51EoM60KT5RhX
 7m6wzqXhchL1kCPcyEN3qz+jRqAy/ujMe8rO2pnsygM8+epFAQDh15YFQefoZ82fF5Zy5d8h4
 fSucYpLuG5KVrtX32ZgaFlXmfXh2xb0XYkM8A75n2+C7Go6zTkOkaCCFQnLeldJe0upI79sv0
 uiP2B1iV/pFZeuKVlfHK/bh0VaKzA4BVguw4f3sm5vjA8Ci5RwPjm2y5p5dZo6Y8QFAoGx4d2
 N1/exT3BGZmXnoGE3QXCb6yuydfYO6TV5qtB5rVOaK2VzDWH3rmTuK1pxq4x0kmI5fieeiH42
 cbqL9DzE00Y+LyKsJCQ2iVrd5J4jtQhxDYWj0jp0MEu0ZixLudmFoA3FtDYVkUdmlEX4MNo13
 hPNsck9oASk5FLcpwLH/0G94tDTLHyE2SpvXqe7cafXvKehwXkY0G4HW1ajriVBGGwOAKpnGm
 mOsQ958wX5ZOt5q6sFLgzc5fARjQuSepbpK2exdrpnsQiA+UeVJh3Jc9I8Moivuns6jk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v16:
- rebase
- s/existin/existing/
- Add Acked-by from Daniel
- Add Reviewed-by from Geert

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

Laurent Vivier (4):
  tty: goldfish: introduce gf_ioread32()/gf_iowrite32()
  rtc: goldfish: use gf_ioread32()/gf_iowrite32()
  clocksource/drivers: Add a goldfish-timer clocksource
  m68k: introduce a virtual m68k machine

 arch/m68k/Kbuild                           |   1 +
 arch/m68k/Kconfig.machine                  |  17 +++
 arch/m68k/configs/virt_defconfig           |  68 +++++++++
 arch/m68k/include/asm/config.h             |   2 +
 arch/m68k/include/asm/io.h                 |   3 +
 arch/m68k/include/asm/irq.h                |   3 +-
 arch/m68k/include/asm/pgtable_mm.h         |   7 +
 arch/m68k/include/asm/setup.h              |  44 ++++--
 arch/m68k/include/asm/virt.h               |  25 ++++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  18 +++
 arch/m68k/include/uapi/asm/bootinfo.h      |   1 +
 arch/m68k/kernel/Makefile                  |   1 +
 arch/m68k/kernel/head.S                    |  31 +++++
 arch/m68k/kernel/setup_mm.c                |   7 +
 arch/m68k/mm/kmap.c                        |  21 ++-
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
 26 files changed, 825 insertions(+), 58 deletions(-)
 create mode 100644 arch/m68k/configs/virt_defconfig
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

