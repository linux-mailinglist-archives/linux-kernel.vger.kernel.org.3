Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC344893F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiAJIpv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 03:45:51 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:41339 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241148AbiAJImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:42:52 -0500
Received: from quad ([82.142.23.158]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N0F9t-1mBhbi1Yox-00xGOd; Mon, 10
 Jan 2022 09:42:41 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 0/2] m68k: Add Virtual M68k Machine
Date:   Mon, 10 Jan 2022 09:42:37 +0100
Message-Id: <20220110084239.1597511-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:A2qcckiWWYccsW4cUyvRL7Pc4bYkTSfLAzR/YtZ5WFdDxri5UOV
 Fhqt1uW3n5fVe03EFrEHIlv7LBsObEMQDJuis4MJM142Omb1jqwWp1XiPTd/YpaJWy6oz4O
 xsNGkp5dc6Zg4j+jgywJSQyDeZb3i6ExtEhD6/eNJQUBTI2DhV6LuyoTons0uURzoCR/b5O
 2vRLHwrW6oHICETmTYP3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5O0RbQcP2Tw=:EJ3gpm0hrk1GecD2yvaBtB
 UlWoN/ANHavZTHojVEiglYVjQlwlf+W1L7LE/DS5QXglbb0DQHZaZ+gU+UcKE1HRq6wBh9Rab
 c2mXaro8O74USFyK0Xf5ufJfGNKmY5p/je8elW1Q2Ec0XC22jRYDjlymVN4eDqB+pVIHh93+H
 C6g7CwmAqK4wiM+GvOqAx9GP/4VGsfLJvsNcLDIW7HYtn+cAUKxf032d3kUR+KnE88ODLxSEJ
 w2s84gvoknfYmbiN7ogDmwxVLyfDbQVIcEpe+1+vGpHvG1SnupE0DXP9E4Vdzjhz4u4j6+JQR
 2XVpWm3MUVRMMSZ+Bq39/URRl6Su3IlsS5I3eEDfmvC4Xp1J7Al6SzTJMlw+DDAr1kuuvvjV8
 t++2JP5ZsuZUc9SNN9wSYS+L/JgNbbS1FhebaO62Dbe1AeP13nBjXwr25/d8TbFrS8XrXDIjO
 VmBGv+gIKovRKvQq70FReMzzaSCajNzxfNqKNVehNZ5vJpsBSbwZk9bOa5U9cowTpE9iyXO7Q
 xJ8NKuYnNPKH+hMpVJul639p4miQOTQf5j/LnHvY69x38zuljtb07oNpehCL5iQLkwKnwqfaX
 SeSRlM3D7ckZ8SEIb2G7jOArRatS5SB25hotP2C9fR38EebMHnJc+s4/14O50NTGglNNTI8zs
 ex5u+PXeoisEsqZXo/XBJmfvl8yrT2b2anFAo0+J7mrjNPN5vJ2JHklcCI5umwB3sfxw=
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

Laurent Vivier (2):
  m68k: add asm/config.h
  m68k: introduce a virtual m68k machine

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
 arch/m68k/virt/timer.c                     |  90 ++++++++++++++++
 28 files changed, 670 insertions(+), 40 deletions(-)
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
2.33.1

