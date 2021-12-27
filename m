Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC947FB64
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhL0Jjr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Dec 2021 04:39:47 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:45137 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhL0Jjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:39:42 -0500
Received: from quad ([82.142.30.186]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MadGG-1mQmy644RG-00cBAv; Mon, 27
 Dec 2021 10:39:33 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 0/1] m68k: Add Virtual M68k Machine
Date:   Mon, 27 Dec 2021 10:39:30 +0100
Message-Id: <20211227093931.480329-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:fE+9S3RXnXn3AFWIj8kvwpDVE3sFvKWR6/jB09PIS2a5I8Amvug
 FgPU4qpVb+GSdzeVInaYGOYdhHip8EU8J+2XrzXtw/0/nOnatiFZEzhJYD8KuWHZoaScnuQ
 VX1a3i1Poj+7fJe7LDkNjXJY80Y0V+QNnyn2SHP6csCVbcgNsny1NGGBYB9+9uhwz6UD7ZK
 H7gWBub+LF2ql97IynQSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JXMQUKYRg5c=:dKmjuvagxuTKHSSOtwiCGh
 aMNmHJmto2qjUeZNhy8uZf3RbVcNy1gTf+VTQMfJwhOzByXmXkX++B6BLXMmSlu/wq8HEgdS1
 IkypvunzJovN8zq/iQdeS2+XUKvZROHsgrruGiyUqBckMR0UZVFzgD9fkJtZLLerDnesbZp6K
 bezVUShmNHu6siVb0mTXNXEPqgTdfpnq/kSH5OtxQyXaOaQg8WWjYRzu01Atblx4qo2H3joR3
 yOQkR3xjx4oiBH+Jgj9Rib3NYCQdKnQ0GUMNHaZGZnTrFd/ljxYvdYmUS+xsOjxRFux7woGgv
 S0jmvtETxopk6HleVNKsHOCfJ6TG1H9+aHi7PDwUYWcIaO3+1321MQYl6144wjx+x9jdDPiav
 +gfubam21uNa4TGe4cgiduyqeLLvW9fG9OXoNfhy3MmCy9gqyW+ANo8hvRlnXOgxClqFbVWC5
 yXEJBJBcMOnUPUGLsJIAZz10qAEJ3sAMj4c6K0g7KJQHyT8y/5H0TrLm+qHitat65ENK9dED3
 QB+zhBuRXYbK64Kmh1IvhfTpf938JCjbyvHWiTm6Pcg4JQsa0NOT0TrxzzSiPVa74oS6rQRUr
 ZVXbI/j+CR38MkTzcAhhRC2ypfKojH62Nbc/m8xmIgOavWq7Bal35dXe/9R69/1kTwPBnU7Df
 JZaMmq9Fy+7jiW/+vZIOoPOjrtaY7QXCdCe/Z916VDT8nuPjE920uAmevcCFSOztURB0=
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

Laurent Vivier (1):
  m68k: introduce a virtual m68k machine

 arch/m68k/Kbuild                           |   1 +
 arch/m68k/Kconfig.machine                  |  16 +++
 arch/m68k/configs/virt_defconfig           |  65 +++++++++++
 arch/m68k/include/asm/irq.h                |   3 +-
 arch/m68k/include/asm/pgtable_mm.h         |   7 ++
 arch/m68k/include/asm/setup.h              |  44 ++++++--
 arch/m68k/include/asm/virt.h               |  26 +++++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  18 ++++
 arch/m68k/include/uapi/asm/bootinfo.h      |   1 +
 arch/m68k/kernel/Makefile                  |   1 +
 arch/m68k/kernel/head.S                    |  31 ++++++
 arch/m68k/kernel/setup_mm.c                |   9 ++
 arch/m68k/mm/kmap.c                        |  23 ++--
 arch/m68k/virt/Makefile                    |   6 ++
 arch/m68k/virt/config.c                    | 111 +++++++++++++++++++
 arch/m68k/virt/ints.c                      | 120 +++++++++++++++++++++
 arch/m68k/virt/platform.c                  |  72 +++++++++++++
 arch/m68k/virt/timer.c                     |  90 ++++++++++++++++
 18 files changed, 626 insertions(+), 18 deletions(-)
 create mode 100644 arch/m68k/configs/virt_defconfig
 create mode 100644 arch/m68k/include/asm/virt.h
 create mode 100644 arch/m68k/include/uapi/asm/bootinfo-virt.h
 create mode 100644 arch/m68k/virt/Makefile
 create mode 100644 arch/m68k/virt/config.c
 create mode 100644 arch/m68k/virt/ints.c
 create mode 100644 arch/m68k/virt/platform.c
 create mode 100644 arch/m68k/virt/timer.c

-- 
2.33.1

