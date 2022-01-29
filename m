Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDB4A318A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353057AbiA2T3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:29:24 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:45568 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiA2T3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:29:24 -0500
Received: by mail-vk1-f181.google.com with SMTP id l14so4643428vko.12;
        Sat, 29 Jan 2022 11:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LT7tcf8P3clsm6+J8stOJcHuTe1R/OFSzCzhh/zfabg=;
        b=kIkELZkvnefUyjt/Ztgq3g+A7TOwategpVJKt27E7h0RsmJOSRb6sWe+voBrLYgBZX
         a7nQoRJ0wqztDXDdzHuLNyRjk2hYZPfY9dtZ4g4XhFiBGSu7bAebEuA3zN7B7uJpJhHy
         9HF6kwSvS44OzsWUvbKvv+JAZp/XqCeJ740QSeK1kQzIkHh2xJ920lwcSxShura/4nWK
         BI174K7m9LYtl4WN6cQBGM8L+mNy/FD5f1JP6E9/dURktsBOVBxE1jQHyMXy7ASK/wez
         y9w9HskW9nWVHMDrae3QtNesOy2V9tu7QkbKn+vbJ3X40HvF+st+y128wPflxn4+LWku
         AEBA==
X-Gm-Message-State: AOAM531OCAM2ngfHTI9p8p62i1x/LewwCTqnyNSCCLogIp50lgpOvctb
        0LfsKtBAWGzPSnjM1P+ZkpfCsgJ43WDebw==
X-Google-Smtp-Source: ABdhPJyZUksHa/lMM8do+0w4UxCOF0Sd1ofQpJ/RBYSmOlFCdF5iSw4BzE8NQc/9diZnO2WLN8CyxA==
X-Received: by 2002:a1f:a483:: with SMTP id n125mr5926689vke.19.1643484562987;
        Sat, 29 Jan 2022 11:29:22 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id w3sm2507472vkd.5.2022.01.29.11.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 11:29:22 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id l14so7080514vsm.3;
        Sat, 29 Jan 2022 11:29:22 -0800 (PST)
X-Received: by 2002:a67:fd63:: with SMTP id h3mr5329100vsa.77.1643484562024;
 Sat, 29 Jan 2022 11:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20220129184225.407100-1-laurent@vivier.eu> <20220129184225.407100-6-laurent@vivier.eu>
In-Reply-To: <20220129184225.407100-6-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 29 Jan 2022 20:29:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX54W9c6F=0WE5=mSi373B546zrHEMkDqAb_V9HHoq80g@mail.gmail.com>
Message-ID: <CAMuHMdX54W9c6F=0WE5=mSi373B546zrHEMkDqAb_V9HHoq80g@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] m68k: introduce a virtual m68k machine
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sat, Jan 29, 2022 at 7:42 PM Laurent Vivier <laurent@vivier.eu> wrote:
> This machine allows to have up to 3.2 GiB and 128 Virtio devices.
>
> It is based on android goldfish devices.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Thanks for your patch!

> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -149,6 +149,23 @@ config SUN3
>
>           If you don't want to compile a kernel exclusively for a Sun 3, say N.
>
> +config VIRT
> +       bool "Virtual M68k Machine support"
> +       depends on MMU
> +       select GENERIC_CLOCKEVENTS
> +       select M68040
> +       select MMU_MOTOROLA if MMU
> +       select RTC_CLASS
> +       select GOLDFISH
> +       select RTC_DRV_GOLDFISH
> +       select GOLDFISH_TIMER
> +       select GOLDFISH_TTY
> +       select TTY
> +       select VIRTIO_MMIO

Please sort alphabetically.

> +       help
> +         This options enable a pure virtual machine based on m68k,
> +         VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC)
> +
>  config PILOT
>         bool
>

> --- /dev/null
> +++ b/arch/m68k/include/asm/virt.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_VIRT_H
> +#define __ASM_VIRT_H
> +
> +#define NUM_VIRT_SOURCES 200
> +
> +struct virt_booter_device_data {
> +       unsigned long mmio;
> +       unsigned long irq;

Probably you want to make these explicitly sized (u32)?
Or perhaps mmio should be void __iomem *, to avoid some casts
(at expense of other casts)?

> +};
> +
> +struct virt_booter_data {
> +       unsigned long qemu_version;

u32?

> +       struct virt_booter_device_data pic;
> +       struct virt_booter_device_data rtc;
> +       struct virt_booter_device_data tty;
> +       struct virt_booter_device_data ctrl;
> +       struct virt_booter_device_data virtio;
> +};
> +
> +extern struct virt_booter_data virt_bi_data;
> +
> +extern void __init virt_init_IRQ(void);
> +
> +#endif

> --- a/arch/m68k/mm/kmap.c
> +++ b/arch/m68k/mm/kmap.c
> @@ -179,6 +179,12 @@ void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cachefla
>                         return (void __iomem *)physaddr;
>         }
>  #endif
> +#ifdef CONFIG_VIRT
> +       if (MACH_IS_VIRT) {
> +               if (physaddr >= 0xff000000 && cacheflag == IOMAP_NOCACHE_SER)
> +                       return (void __iomem *)physaddr;
> +       }
> +#endif
>  #ifdef CONFIG_COLDFIRE
>         if (__cf_internalio(physaddr))
>                 return (void __iomem *) physaddr;
> @@ -292,18 +298,21 @@ EXPORT_SYMBOL(__ioremap);
>   */
>  void iounmap(void __iomem *addr)
>  {
> -#ifdef CONFIG_AMIGA
> -       if ((!MACH_IS_AMIGA) ||
> -           (((unsigned long)addr < 0x40000000) ||
> -            ((unsigned long)addr > 0x60000000)))
> -                       free_io_area((__force void *)addr);
> -#else
> +#if defined(CONFIG_AMIGA)

"#ifdef CONFIG_AMIGA" was fine

> +       if (MACH_IS_AMIGA &&
> +           ((unsigned long)addr >= 0x40000000) &&
> +           ((unsigned long)addr < 0x60000000))
> +               return;
> +#endif
> +#if defined(CONFIG_VIRT)

#ifdef CONFIG_VIRT

> +       if (MACH_IS_VIRT && (unsigned long)addr >= 0xff000000)
> +               return;
> +#endif
>  #ifdef CONFIG_COLDFIRE
>         if (cf_internalio(addr))
>                 return;
>  #endif
>         free_io_area((__force void *)addr);
> -#endif
>  }
>  EXPORT_SYMBOL(iounmap);
>

> --- /dev/null
> +++ b/arch/m68k/virt/config.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/serial_core.h>
> +#include <clocksource/timer-goldfish.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/bootinfo-virt.h>
> +#include <asm/byteorder.h>
> +#include <asm/machdep.h>
> +#include <asm/virt.h>
> +#include <asm/config.h>
> +
> +struct virt_booter_data virt_bi_data;
> +
> +#define VIRT_CTRL_REG_FEATURES 0x00
> +#define VIRT_CTRL_REG_CMD      0x04
> +
> +static struct resource ctrlres;
> +
> +enum {
> +       CMD_NOOP,
> +       CMD_RESET,
> +       CMD_HALT,
> +       CMD_PANIC,
> +};
> +
> +static void virt_get_model(char *str)
> +{
> +       /* str is 80 characters long */
> +       sprintf(str, "QEMU Virtual M68K Machine (%u.%u.%u)",
> +               (u8)(virt_bi_data.qemu_version >> 24),
> +               (u8)(virt_bi_data.qemu_version >> 16),
> +               (u8)(virt_bi_data.qemu_version >> 8));
> +}
> +
> +static void virt_halt(void)
> +{
> +       void __iomem *base = (void *)virt_bi_data.ctrl.mmio;

"(void __iomem *)" everywhere, else sparse complains (make C=1)

> +
> +       iowrite32be(CMD_HALT, base + VIRT_CTRL_REG_CMD);
> +       local_irq_disable();
> +       while (1)
> +               ;
> +}

> --- /dev/null
> +++ b/arch/m68k/virt/ints.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/sched/debug.h>
> +#include <linux/types.h>
> +#include <linux/ioport.h>
> +
> +#include <asm/hwtest.h>
> +#include <asm/irq.h>
> +#include <asm/irq_regs.h>
> +#include <asm/virt.h>
> +
> +#define GFPIC_REG_IRQ_PENDING           0x04
> +#define GFPIC_REG_IRQ_DISABLE_ALL       0x08
> +#define GFPIC_REG_IRQ_DISABLE           0x0c
> +#define GFPIC_REG_IRQ_ENABLE            0x10
> +
> +extern void show_registers(struct pt_regs *regs);
> +
> +static struct resource picres[6];
> +static const char *picname[6] = {
> +       "goldfish_pic.0",
> +       "goldfish_pic.1",
> +       "goldfish_pic.2",
> +       "goldfish_pic.3",
> +       "goldfish_pic.4",
> +       "goldfish_pic.5"
> +};
> +
> +/*
> + * 6 goldfish-pic for CPU IRQ #1 to IRQ #6
> + * CPU IRQ #1 -> PIC #1
> + *               IRQ #1 to IRQ #31 -> unused
> + *               IRQ #32 -> goldfish-tty
> + * CPU IRQ #2 -> PIC #2
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 1 to 32
> + * CPU IRQ #3 -> PIC #3
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 33 to 64
> + * CPU IRQ #4 -> PIC #4
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 65 to 96
> + * CPU IRQ #5 -> PIC #5
> + *               IRQ #1 to IRQ #32 -> virtio-mmio from 97 to 128
> + * CPU IRQ #6 -> PIC #6
> + *               IRQ #1 -> goldfish-timer
> + *               IRQ #2 -> goldfish-rtc
> + *               IRQ #3 to IRQ #32 -> unused
> + * CPU IRQ #7 -> NMI
> + */
> +
> +static u32 gfpic_read(int pic, int reg)
> +{
> +       void __iomem *base = (void *)(virt_bi_data.pic.mmio + pic * 0x1000);

(void __iomem *)

> +
> +       return ioread32be(base + reg);
> +}
> +
> +static void gfpic_write(u32 value, int pic, int reg)
> +{
> +       void __iomem *base = (void *)(virt_bi_data.pic.mmio + pic * 0x1000);
> +
> +       iowrite32be(value, base + reg);
> +}
> +
> +#define GF_PIC(irq) ((irq - IRQ_USER) / 32)
> +#define GF_IRQ(irq) ((irq - IRQ_USER) % 32)
> +
> +static void virt_irq_enable(struct irq_data *data)
> +{
> +       gfpic_write(1 << GF_IRQ(data->irq), GF_PIC(data->irq),

"1U". Or perhaps "BIT(GF_IRQ(data->irq)"?

> +                   GFPIC_REG_IRQ_ENABLE);
> +}
> +
> +static void virt_irq_disable(struct irq_data *data)
> +{
> +       gfpic_write(1 << GF_IRQ(data->irq), GF_PIC(data->irq),

likewise

> +                   GFPIC_REG_IRQ_DISABLE);
> +}

void goldfish_pic_irq(struct irq_desc *desc)
> +{
> +       u32 irq_pending;
> +       int irq_num;

unsigned int

> +       int pic = desc->irq_data.irq - 1;

unsigned int

> +
> +       irq_pending = gfpic_read(pic, GFPIC_REG_IRQ_PENDING);
> +       irq_num = IRQ_USER + pic * 32;
> +
> +       do {
> +               if (irq_pending & 1)
> +                       generic_handle_irq(irq_num);
> +               ++irq_num;
> +               irq_pending >>= 1;
> +       } while (irq_pending);
> +}
> +
> +void __init virt_init_IRQ(void)
> +{
> +       int pic;

unsigned int i

> +
> +       m68k_setup_irq_controller(&virt_irq_chip, handle_simple_irq, IRQ_USER,
> +                                 NUM_VIRT_SOURCES - IRQ_USER);
> +
> +       for (pic = 0; pic < 6; pic++) {
> +
> +               picres[pic] = (struct resource)
> +                   DEFINE_RES_MEM_NAMED(virt_bi_data.pic.mmio + pic * 0x1000,
> +                                        0x1000, picname[pic]);
> +               if (request_resource(&iomem_resource, &picres[pic])) {
> +                       pr_err("Cannot allocate %s resource\n", picname[pic]);
> +                       return;
> +               }
> +
> +               irq_set_chained_handler(virt_bi_data.pic.irq + pic,
> +                                       goldfish_pic_irq);
> +       }
> +
> +       if (request_irq(IRQ_AUTO_7, virt_nmi_handler, 0, "NMI",
> +                       virt_nmi_handler))
> +               pr_err("Couldn't register NMI\n");
> +}

> --- /dev/null
> +++ b/arch/m68k/virt/platform.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/memblock.h>
> +#include <asm/virt.h>
> +#include <asm/irq.h>
> +
> +#define VIRTIO_BUS_NB  128
> +
> +static int __init virt_virtio_init(int id)

unsigned int id

> +{
> +       const struct resource res[] = {
> +               DEFINE_RES_MEM(virt_bi_data.virtio.mmio + id * 0x200, 0x200),
> +               DEFINE_RES_IRQ(virt_bi_data.virtio.irq + id),
> +       };
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_register_simple("virtio-mmio", id,
> +                                              res, ARRAY_SIZE(res));
> +       if (IS_ERR(pdev))
> +               return PTR_ERR(pdev);
> +
> +       return 0;
> +}
> +
> +static int __init virt_platform_init(void)
> +{
> +       const struct resource goldfish_tty_res[] = {
> +               DEFINE_RES_MEM(virt_bi_data.tty.mmio, 1),
> +               DEFINE_RES_IRQ(virt_bi_data.tty.irq),
> +       };
> +       /* this is the second gf-rtc, the first one is used by the scheduler */
> +       const struct resource goldfish_rtc_res[] = {
> +               DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
> +               DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
> +       };
> +       struct platform_device *pdev;
> +       int i;

unsigned int

> +
> +       if (!MACH_IS_VIRT)
> +               return -ENODEV;
> +
> +       /* We need this to have DMA'able memory provided to goldfish-tty */
> +       min_low_pfn = 0;
> +
> +       pdev = platform_device_register_simple("goldfish_tty",
> +                                              PLATFORM_DEVID_NONE,
> +                                              goldfish_tty_res,
> +                                              ARRAY_SIZE(goldfish_tty_res));
> +       if (IS_ERR(pdev))
> +               return PTR_ERR(pdev);
> +
> +       pdev = platform_device_register_simple("goldfish_rtc",
> +                                              PLATFORM_DEVID_NONE,
> +                                              goldfish_rtc_res,
> +                                              ARRAY_SIZE(goldfish_rtc_res));
> +       if (IS_ERR(pdev))
> +               return PTR_ERR(pdev);
> +
> +       for (i = 0; i < VIRTIO_BUS_NB; i++) {
> +               int err;
> +
> +               err = virt_virtio_init(i);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
