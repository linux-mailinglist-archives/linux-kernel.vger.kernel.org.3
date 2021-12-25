Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFFB47F1CB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 04:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhLYDNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 22:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhLYDNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 22:13:04 -0500
Received: from mail-sender-0.a4lg.com (mail-sender-0.a4lg.com [IPv6:2401:2500:203:30b:4000:6bfe:4757:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63950C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 19:13:03 -0800 (PST)
Received: by mail-sender-0.a4lg.com (Postfix) with ESMTPSA id CAB58300089;
        Sat, 25 Dec 2021 03:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irq.a4lg.com;
        s=2017s01; t=1640401979;
        bh=lUXwwqF9UuGqgRHAjOeTba4TsblHFEGJAMGTvJJ3X6k=;
        h=Message-ID:Date:Mime-Version:Subject:To:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=kjqedETDpzPuAdWAy/s2M4i3PsVx8lIZYgM4NyrFQh1AjwEHgfh/A3T6XYPPMd+8L
         9xDy7RXx7X9S15V1V76K9l+ZG6kkxTsOnlLxPQ3qENBCxenwPwzGwQKXI47ZH6MPOL
         vgYF5W1SDMU1ZWXb8IyXz6LyUxiXrbfWz0cvgEX8=
Message-ID: <01a238a6-4f0e-623f-4c49-8b0a3f896205@irq.a4lg.com>
Date:   Sat, 25 Dec 2021 12:12:57 +0900
Mime-Version: 1.0
Subject: Re: [PATCH v1 1/2] RISC-V: Provide a framework for parsing
 multi-letter ISA extensions
Content-Language: en-US
To:     linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20211224211632.1698523-1-atishp@rivosinc.com>
 <20211224211632.1698523-2-atishp@rivosinc.com>
From:   Tsukasa OI <research_trasio@irq.a4lg.com>
In-Reply-To: <20211224211632.1698523-2-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish,

On 2021/12/25 6:16, Atish Patra wrote:
> Recently, there were 15 specifications/40 ISA extensions were ratified.
> Except hypervisor ('H') extension, all of them are multi-letter extensions.
> Going forward, there will be more number of multi-letter extensions as
> well. Parsing all of these extensions from ISA string is not scalable.

Accepting multi-letter extensions and providing framework is very nice.

But would you enlighten me how and why "parsing all of these extensions
from ISA string is not scalable"? That's the only thing I'm not convinced.

Parsing ISA string is per-hart but one-time only (in kernel space) and
doesn't take much long.  Yes, the ISA string will get longer and longer
over time (which might affect the boot performance on many-core systems)
but once we get heterogeneous systems (as you mentioned), we will have
per-hart "isa-ext" anyway and we will have pretty much the same situation.
We could take per-group approach instead of per-hart for efficiency but
that means ISA string parsing can be optimized just as "isa-ext".

Current RISC-V systems have not long ISA string and not many cores (making
per-hart ISA string processing not a problem).  Future complex RISC-V
systems may have many cores, heterogeneous capabilities and long ISA
strings that need to be taken care.  However, "isa-ext" will have a
similar scaling issue over time (just as the ISA string).

So, I don't see any merits of "isa-ext" in the long or short term.

Regards,


> Thus, this patch provides a DT based framework to for easy parsing and
> querying of any ISA extensions. It facilitates custom user visible strings
> for the ISA extensions via /proc/cpuinfo as well.
> 
> Currently, there are no platforms with heterogeneous Linux capable harts.
> That's why, this patch supports only a single DT node which can only work
> for systems with homogeneous harts. To support heterogeneous systems, this
> cpu node must be a subnode for each cpu.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 31 ++++++++++++++++++
>  arch/riscv/kernel/cpu.c        | 16 ++++++++++
>  arch/riscv/kernel/cpufeature.c | 58 +++++++++++++++++++++++++++++++++-
>  3 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 5ce50468aff1..368ab0f330c8 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -34,7 +34,36 @@ extern unsigned long elf_hwcap;
>  #define RISCV_ISA_EXT_s		('s' - 'a')
>  #define RISCV_ISA_EXT_u		('u' - 'a')
>  
> +/*
> + * Increse this to higher value as kernel support more ISA extensions.
> + */
>  #define RISCV_ISA_EXT_MAX	64
> +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> +/* The base ID for multi-letter ISA extensions */
> +#define RISCV_ISA_EXT_BASE 26
> +
> +/*
> + * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> + * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
> + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> + * extensions while all the multi-letter extensions should define the next
> + * available logical extension id.
> + */
> +enum riscv_isa_ext_id {
> +	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> +};
> +
> +struct riscv_isa_ext_data {
> +	struct list_head node;
> +	/* Name of the extension property in DT */
> +	char dtprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> +	/* Name of the extension displayed to userspace via /proc/cpuinfo */
> +	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> +	/* The logical ISA extension ID */
> +	unsigned int isa_ext_id;
> +};
> +
> +extern struct list_head riscv_isa_ext_list;
>  
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>  
> @@ -44,6 +73,8 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit);
>  #define riscv_isa_extension_available(isa_bitmap, ext)	\
>  	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
>  
> +int riscv_isa_ext_list_add(struct riscv_isa_ext_data *edata);
> +
>  #endif
>  
>  #endif /* _ASM_RISCV_HWCAP_H */
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index f13b2c9ea912..dad95bdd3cca 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -71,6 +71,21 @@ static void print_isa(struct seq_file *f, const char *isa)
>  	seq_puts(f, "\n");
>  }
>  
> +static void print_isa_ext(struct seq_file *f)
> +{
> +	struct riscv_isa_ext_data *edata;
> +	int count = 0;
> +
> +	seq_puts(f, "isa-ext\t\t: ");
> +	list_for_each_entry(edata, &riscv_isa_ext_list, node) {
> +		if (count)
> +			seq_puts(f, ",");
> +		seq_write(f, edata->uprop, strnlen(edata->uprop, RISCV_ISA_EXT_NAME_LEN_MAX));
> +		count++;
> +	}
> +	seq_puts(f, "\n");
> +}
> +
>  static void print_mmu(struct seq_file *f, const char *mmu_type)
>  {
>  #if defined(CONFIG_32BIT)
> @@ -113,6 +128,7 @@ static int c_show(struct seq_file *m, void *v)
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
>  	if (!of_property_read_string(node, "riscv,isa", &isa))
>  		print_isa(m, isa);
> +	print_isa_ext(m);
>  	if (!of_property_read_string(node, "mmu-type", &mmu))
>  		print_mmu(m, mmu);
>  	if (!of_property_read_string(node, "compatible", &compat)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index d959d207a40d..c70eeec17f5b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -7,6 +7,8 @@
>   */
>  
>  #include <linux/bitmap.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
>  #include <linux/of.h>
>  #include <asm/processor.h>
>  #include <asm/hwcap.h>
> @@ -18,6 +20,8 @@ unsigned long elf_hwcap __read_mostly;
>  /* Host ISA bitmap */
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  
> +LIST_HEAD(riscv_isa_ext_list);
> +
>  #ifdef CONFIG_FPU
>  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
> @@ -59,12 +63,60 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
>  }
>  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>  
> +#define __RISCV_ISA_EXT_DATA(DTPROP, UPROP, EXTID) \
> +	{							\
> +		.dtprop = #DTPROP,				\
> +		.uprop = #UPROP,				\
> +		.isa_ext_id = EXTID,				\
> +	}
> +
> +static struct riscv_isa_ext_data isa_ext_arr[] = {
> +	__RISCV_ISA_EXT_DATA("", "", RISCV_ISA_EXT_MAX),
> +};
> +
> +int riscv_isa_ext_list_add(struct riscv_isa_ext_data *edata)
> +{
> +	struct device_node *node, *enode;
> +	int eid;
> +
> +	if (!edata || !edata->dtprop)
> +		return -EINVAL;
> +
> +	node = of_find_node_by_path("/cpus");
> +	if (!node) {
> +		pr_err("No CPU information found in DT\n");
> +		return -ENOENT;
> +	}
> +
> +	enode = of_get_child_by_name(node, "riscv,isa-ext");
> +	if (!enode) {
> +		pr_err("No riscv-isa-ext found in DT\n");
> +		return -ENOENT;
> +	}
> +
> +	eid = edata->isa_ext_id;
> +	if (eid < RISCV_ISA_EXT_BASE || eid >= RISCV_ISA_EXT_MAX)
> +		return -EINVAL;
> +
> +	if (!of_property_read_bool(enode, edata->dtprop)) {
> +		pr_err("The ISA extension %s is not present in DT\n", edata->dtprop);
> +		return -ENODEV;
> +	}
> +
> +	/* Enable the extension id in the riscv_isa for easier probing */
> +	riscv_isa[0] |= 1 << eid;
> +	list_add(&edata->node, &riscv_isa_ext_list);
> +	pr_info("RISC-V ISA extension '%s' available\n", edata->uprop);
> +
> +	return 0;
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	struct device_node *node;
>  	const char *isa;
>  	char print_str[BITS_PER_LONG + 1];
> -	size_t i, j, isa_len;
> +	size_t i, j, isa_len, ext_arr_sz;
>  	static unsigned long isa2hwcap[256] = {0};
>  
>  	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
> @@ -148,4 +200,8 @@ void __init riscv_fill_hwcap(void)
>  	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
>  		static_branch_enable(&cpu_hwcap_fpu);
>  #endif
> +
> +	ext_arr_sz = ARRAY_SIZE(isa_ext_arr);
> +	for (i = 0; i < ext_arr_sz - 1; i++)
> +		riscv_isa_ext_list_add(&isa_ext_arr[i]);
>  }
