Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D3583622
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiG1BDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiG1BDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:03:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 708DE5C34D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:03:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz9JB4OFiEr49AA--.23298S3;
        Thu, 28 Jul 2022 09:02:58 +0800 (CST)
Subject: Re: [PATCH 3/5] LoongArch: Support relocation against
 _GLOBAL_OFFSET_TABLE_
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
 <99733532831377ab6585d43ee40bf314a2d4c5a3.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <10c1e0f9-8409-a0f4-9b18-a5f56dfb14e1@loongson.cn>
Date:   Thu, 28 Jul 2022 09:02:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <99733532831377ab6585d43ee40bf314a2d4c5a3.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxz9JB4OFiEr49AA--.23298S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xZFyDKr13uFWfXw4UXFb_yoW5JFyxpF
        Wqk395Wr4fCr1DG3Z3Z3WkuFy5GFZ7Gr4jgFW7G345Aw1jqryFyayxKryq9a18X34kC3y0
        qr1rWFW7Kan7ArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/2022 12:28 AM, Xi Ruoyao wrote:
> With the stack-based relocations, the assembler emits three relocations
> to push the PC-relative offset of a GOT entry:
>
>      R_LARCH_SOP_PUSH_PCREL _GLOBAL_OFFSET_TABLE_
>      R_LARCH_SOP_PUSH_GPREL foo
>      R_LARCH_SOP_ADD
>
> "_GLOBAL_OFFSET_TABLE_" does not really exist in the symtab and the BFD
> linker handles it with special hack.  Implement a similar hack for
> kernel so we will be able to really use R_LARCH_SOP_PUSH_GPREL
> relocation.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>   arch/loongarch/kernel/module-sections.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
> index 509c0b86b1e9..73976addbf60 100644
> --- a/arch/loongarch/kernel/module-sections.c
> +++ b/arch/loongarch/kernel/module-sections.c
> @@ -89,6 +89,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>   			      char *secstrings, struct module *mod)
>   {
>   	unsigned int i, num_plts = 0, num_gots = 0;
> +	Elf_Shdr *symtab = NULL;
> +	Elf_Sym *symbols;
> +	char *strings;
>   
>   	/*
>   	 * Find the empty .plt sections.
> @@ -100,6 +103,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>   			mod->arch.plt_idx.shdr = sechdrs + i;
>   		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
>   			mod->arch.got.shdr = sechdrs + i;
> +		else if (sechdrs[i].sh_type == SHT_SYMTAB)
> +			symtab = sechdrs + i;
>   	}
>   
>   	if (!mod->arch.plt.shdr) {
> @@ -115,6 +120,22 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>   		return -ENOEXEC;
>   	}
>   
> +	if (!symtab) {
> +		pr_err("%s: module symbol table missing\n", mod->name);
> +		return -ENOEXEC;
> +	}
> +
> +	symbols = (void *) ehdr + symtab->sh_offset;
> +	strings = (void *) ehdr + sechdrs[symtab->sh_link].sh_offset;
> +
> +	for (i = 0; i < symtab->sh_size / sizeof(Elf_Sym); i++)
> +		if (symbols[i].st_shndx == SHN_UNDEF &&
> +		    strcmp(strings + symbols[i].st_name,
> +			   "_GLOBAL_OFFSET_TABLE_") == 0) {
> +			symbols[i].st_shndx = mod->arch.got.shdr - sechdrs;
> +			symbols[i].st_value = 0;
> +		}
> +
>   	/* Calculate the maxinum number of entries */
>   	for (i = 0; i < ehdr->e_shnum; i++) {
>   		int num_rela = sechdrs[i].sh_size / sizeof(Elf_Rela);

Hi, Ruoyao,


It is possible to create a symbol when linking, which means
maybe we can add _GLOBAL_OFFSET_TABLE_ in 'module.lds.h'.
What do you think about it?


Thanks,

Jinyang

