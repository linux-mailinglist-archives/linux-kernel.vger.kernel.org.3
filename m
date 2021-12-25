Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18FC47F25E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 07:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhLYGJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 01:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLYGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 01:09:55 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EDC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 22:09:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y130so3863015ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 22:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0a5/ROElbHF7H2S7bFI1s+r5RUzmHzCdZt07fjfWzk=;
        b=EAWOpOvu3FcR7iO6DmwUxRNdvnrkcV/zIpc0PSIVstaAA9S0W06jdTml5u+tGFlKfq
         zeh4xVN7+aKxfjHZDM8a+PK9hPFsBmmhXWBhvzxn3oohUn1wS4j4j6GtGA0P7S9qThnl
         tVbSgtGPOtngPqEK4wBZgpi9v6smH/BFj0s/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0a5/ROElbHF7H2S7bFI1s+r5RUzmHzCdZt07fjfWzk=;
        b=erhKec6B5zagwyQx9CTEIDcwrR9jXKl0L8PuXxARLTMI7cuoFqWmjL477oNxawtZzM
         hWpZwg75CUDt1d6b1tg86f5ZKUCF9FoITJGP5B6ZAjJaiXGUfP+PJy5yjtdEXTr5krBB
         0mSoeN79/UXeZ+5KtHCd0SWi/w2wsaHWlqdSDasPlItOc/dzsE2BqS/kp6OmbFZKf/yp
         1tD7sDPS7MW187AjWEV7YjjWmcQRPS6/OwG8QTdbsmAgFZkTrSPrhszOn9Kc+ZAn8sZ1
         NBz7VD6vL5Mkmd/8Sj2DaF2B6fS04oXnhPMIG4asWWKswXXYVJUopd3RWGo3srjqXVv3
         Yk1g==
X-Gm-Message-State: AOAM530joCHnz/APEPW64cINMz6qDsy4qK9kvnmXWmdmVoPafgTyw/2c
        PRMholKynLKhzbaPHGFQ+MBLyYfVkaNAm/DAU4ah
X-Google-Smtp-Source: ABdhPJyAgO00d6l0GOB96GI7Hr9Kqb4UiZvi6xgIq97UVVNENtVnOn/3GfvJlVIrV26Wi7qefbCMrz2/seG0Dg3hOiQ=
X-Received: by 2002:a5b:b90:: with SMTP id l16mr12521155ybq.632.1640412594055;
 Fri, 24 Dec 2021 22:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20211224211632.1698523-1-atishp@rivosinc.com> <20211224211632.1698523-2-atishp@rivosinc.com>
 <01a238a6-4f0e-623f-4c49-8b0a3f896205@irq.a4lg.com>
In-Reply-To: <01a238a6-4f0e-623f-4c49-8b0a3f896205@irq.a4lg.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Dec 2021 22:09:43 -0800
Message-ID: <CAOnJCUKgt1+SVXTBmGChJf74JrsqeqACXbjQAXnhFALkXhPFew@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] RISC-V: Provide a framework for parsing
 multi-letter ISA extensions
To:     Tsukasa OI <research_trasio@irq.a4lg.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 7:13 PM Tsukasa OI <research_trasio@irq.a4lg.com> wrote:
>
> Hello Atish,
>
> On 2021/12/25 6:16, Atish Patra wrote:
> > Recently, there were 15 specifications/40 ISA extensions were ratified.
> > Except hypervisor ('H') extension, all of them are multi-letter extensions.
> > Going forward, there will be more number of multi-letter extensions as
> > well. Parsing all of these extensions from ISA string is not scalable.
>
> Accepting multi-letter extensions and providing framework is very nice.
>
> But would you enlighten me how and why "parsing all of these extensions
> from ISA string is not scalable"? That's the only thing I'm not convinced.
>

I thought we already discussed the merits in this thread.
https://lore.kernel.org/lkml/9fa0492d-b448-045b-ba8f-e3d68b46d673@irq.a4lg.com/

Anyways, here is summary of disadvantages of "riscv,isa" string
parsing that you proposed

1. The isa string in DT will be really really long. It is time
consuming to parse it and becomes
somewhat unreadable after a point.
2. Currently, /proc/cpuinfo dumps the entire riscv,isa string. That
works for base/single letter extensions.
However, dumping the entire string will not work in userspace. Imagine
the 10~20 extensions string in your terminal.
3. If you want to group them into different extensions, you have to
parse them again and create separate extensions
which I am doing in this patch.
4. In future, there will be subnodes in the isa-ext which will only
describe the ISA-extensions corresponding to Sv* or Sh* or Z*
groups. I did not add those in this version because the unpriv
specification doesn't define them clearly and may change in the future
(as suggested by Greg [1].)

[1] https://github.com/riscv/riscv-isa-manual/issues/781#issuecomment-983233088

It is very easy to create such groupings in the Device tree and
display it to the userspace. However, the isa string has to perform
additional string parsing even for that.

> Parsing ISA string is per-hart but one-time only (in kernel space) and
> doesn't take much long.  Yes, the ISA string will get longer and longer
> over time (which might affect the boot performance on many-core systems)
> but once we get heterogeneous systems (as you mentioned), we will have
> per-hart "isa-ext" anyway and we will have pretty much the same situation.
> We could take per-group approach instead of per-hart for efficiency but
> that means ISA string parsing can be optimized just as "isa-ext".
>
> Current RISC-V systems have not long ISA string and not many cores (making
> per-hart ISA string processing not a problem).  Future complex RISC-V
> systems may have many cores, heterogeneous capabilities and long ISA
> strings that need to be taken care.  However, "isa-ext" will have a
> similar scaling issue over time (just as the ISA string).
>

No. The scaling issue in isa-ext will not be as near as the riscv,isa
string as the early boot code will
load a value from the array and check a DT property.

> So, I don't see any merits of "isa-ext" in the long or short term.
>

On the other hand, I don't understand what is the disadvantage of the
isa-ext approach. Even if you don't
agree on the performance and simplicity front, it certainly becomes
more human readable.


> Regards,
>
>
> > Thus, this patch provides a DT based framework to for easy parsing and
> > querying of any ISA extensions. It facilitates custom user visible strings
> > for the ISA extensions via /proc/cpuinfo as well.
> >
> > Currently, there are no platforms with heterogeneous Linux capable harts.
> > That's why, this patch supports only a single DT node which can only work
> > for systems with homogeneous harts. To support heterogeneous systems, this
> > cpu node must be a subnode for each cpu.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 31 ++++++++++++++++++
> >  arch/riscv/kernel/cpu.c        | 16 ++++++++++
> >  arch/riscv/kernel/cpufeature.c | 58 +++++++++++++++++++++++++++++++++-
> >  3 files changed, 104 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 5ce50468aff1..368ab0f330c8 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -34,7 +34,36 @@ extern unsigned long elf_hwcap;
> >  #define RISCV_ISA_EXT_s              ('s' - 'a')
> >  #define RISCV_ISA_EXT_u              ('u' - 'a')
> >
> > +/*
> > + * Increse this to higher value as kernel support more ISA extensions.
> > + */
> >  #define RISCV_ISA_EXT_MAX    64
> > +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> > +/* The base ID for multi-letter ISA extensions */
> > +#define RISCV_ISA_EXT_BASE 26
> > +
> > +/*
> > + * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> > + * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
> > + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> > + * extensions while all the multi-letter extensions should define the next
> > + * available logical extension id.
> > + */
> > +enum riscv_isa_ext_id {
> > +     RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> > +};
> > +
> > +struct riscv_isa_ext_data {
> > +     struct list_head node;
> > +     /* Name of the extension property in DT */
> > +     char dtprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> > +     /* Name of the extension displayed to userspace via /proc/cpuinfo */
> > +     char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> > +     /* The logical ISA extension ID */
> > +     unsigned int isa_ext_id;
> > +};
> > +
> > +extern struct list_head riscv_isa_ext_list;
> >
> >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
> >
> > @@ -44,6 +73,8 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit);
> >  #define riscv_isa_extension_available(isa_bitmap, ext)       \
> >       __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
> >
> > +int riscv_isa_ext_list_add(struct riscv_isa_ext_data *edata);
> > +
> >  #endif
> >
> >  #endif /* _ASM_RISCV_HWCAP_H */
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index f13b2c9ea912..dad95bdd3cca 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -71,6 +71,21 @@ static void print_isa(struct seq_file *f, const char *isa)
> >       seq_puts(f, "\n");
> >  }
> >
> > +static void print_isa_ext(struct seq_file *f)
> > +{
> > +     struct riscv_isa_ext_data *edata;
> > +     int count = 0;
> > +
> > +     seq_puts(f, "isa-ext\t\t: ");
> > +     list_for_each_entry(edata, &riscv_isa_ext_list, node) {
> > +             if (count)
> > +                     seq_puts(f, ",");
> > +             seq_write(f, edata->uprop, strnlen(edata->uprop, RISCV_ISA_EXT_NAME_LEN_MAX));
> > +             count++;
> > +     }
> > +     seq_puts(f, "\n");
> > +}
> > +
> >  static void print_mmu(struct seq_file *f, const char *mmu_type)
> >  {
> >  #if defined(CONFIG_32BIT)
> > @@ -113,6 +128,7 @@ static int c_show(struct seq_file *m, void *v)
> >       seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> >       if (!of_property_read_string(node, "riscv,isa", &isa))
> >               print_isa(m, isa);
> > +     print_isa_ext(m);
> >       if (!of_property_read_string(node, "mmu-type", &mmu))
> >               print_mmu(m, mmu);
> >       if (!of_property_read_string(node, "compatible", &compat)
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index d959d207a40d..c70eeec17f5b 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -7,6 +7,8 @@
> >   */
> >
> >  #include <linux/bitmap.h>
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> >  #include <linux/of.h>
> >  #include <asm/processor.h>
> >  #include <asm/hwcap.h>
> > @@ -18,6 +20,8 @@ unsigned long elf_hwcap __read_mostly;
> >  /* Host ISA bitmap */
> >  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> >
> > +LIST_HEAD(riscv_isa_ext_list);
> > +
> >  #ifdef CONFIG_FPU
> >  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> >  #endif
> > @@ -59,12 +63,60 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
> >  }
> >  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
> >
> > +#define __RISCV_ISA_EXT_DATA(DTPROP, UPROP, EXTID) \
> > +     {                                                       \
> > +             .dtprop = #DTPROP,                              \
> > +             .uprop = #UPROP,                                \
> > +             .isa_ext_id = EXTID,                            \
> > +     }
> > +
> > +static struct riscv_isa_ext_data isa_ext_arr[] = {
> > +     __RISCV_ISA_EXT_DATA("", "", RISCV_ISA_EXT_MAX),
> > +};
> > +
> > +int riscv_isa_ext_list_add(struct riscv_isa_ext_data *edata)
> > +{
> > +     struct device_node *node, *enode;
> > +     int eid;
> > +
> > +     if (!edata || !edata->dtprop)
> > +             return -EINVAL;
> > +
> > +     node = of_find_node_by_path("/cpus");
> > +     if (!node) {
> > +             pr_err("No CPU information found in DT\n");
> > +             return -ENOENT;
> > +     }
> > +
> > +     enode = of_get_child_by_name(node, "riscv,isa-ext");
> > +     if (!enode) {
> > +             pr_err("No riscv-isa-ext found in DT\n");
> > +             return -ENOENT;
> > +     }
> > +
> > +     eid = edata->isa_ext_id;
> > +     if (eid < RISCV_ISA_EXT_BASE || eid >= RISCV_ISA_EXT_MAX)
> > +             return -EINVAL;
> > +
> > +     if (!of_property_read_bool(enode, edata->dtprop)) {
> > +             pr_err("The ISA extension %s is not present in DT\n", edata->dtprop);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Enable the extension id in the riscv_isa for easier probing */
> > +     riscv_isa[0] |= 1 << eid;
> > +     list_add(&edata->node, &riscv_isa_ext_list);
> > +     pr_info("RISC-V ISA extension '%s' available\n", edata->uprop);
> > +
> > +     return 0;
> > +}
> > +
> >  void __init riscv_fill_hwcap(void)
> >  {
> >       struct device_node *node;
> >       const char *isa;
> >       char print_str[BITS_PER_LONG + 1];
> > -     size_t i, j, isa_len;
> > +     size_t i, j, isa_len, ext_arr_sz;
> >       static unsigned long isa2hwcap[256] = {0};
> >
> >       isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
> > @@ -148,4 +200,8 @@ void __init riscv_fill_hwcap(void)
> >       if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
> >               static_branch_enable(&cpu_hwcap_fpu);
> >  #endif
> > +
> > +     ext_arr_sz = ARRAY_SIZE(isa_ext_arr);
> > +     for (i = 0; i < ext_arr_sz - 1; i++)
> > +             riscv_isa_ext_list_add(&isa_ext_arr[i]);
> >  }
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
