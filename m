Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5242F5A4FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiH2PIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiH2PIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:08:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4985189CC9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7756B810D2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B77AC433D7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661785697;
        bh=O/zwJgzMH4rV/88pby0lCa6JJEX2IHSwjxbqTBmKC/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IvYQblDa+pUjgJ6PnEEVSvx36fgJ2dMl5fSKZWCUEWdLE14Zzg8iG9hGAYgp3gvsh
         xK33JfXWhEM37KcLwRMGkB8oWz1gBcbOB+ZATwY1PGwmk5pMjzX27Cmaq3OkPUtkDP
         abfz1h4DrYYo8/wJu0u8VSeuMdAtRQM2Wi0XmYDE9joOlJyfPRrAip6ah2UK+c4Ddb
         E0YDE8hrIFYfnwJe+ylsG2ZX1lTUZs49fwzY48Se+MPwGzXLSDFLzcgT85r0LdWxjc
         Hq4mEqcsAF3axJnOZ8j46FssVjLt0uEAMi7X/e5n6noxNgC7Jjg6gsND0t1tMQkG5l
         AT8tijVPNc3zg==
Received: by mail-vk1-f176.google.com with SMTP id b63so365774vkh.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:08:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo2bnxmAD7HUrGQbQsxJb1Wi3UG1S2ly4cPyYExkbrlNmqAtjW06
        XqqVc1VcVpFNSE+qo3nS5CDhoUhf3GGuDifjE/M=
X-Google-Smtp-Source: AA6agR4Zz45YA3uwrHd1sCTg3Ln5vaySZyffnpDu+lyytLRNXCyOj50I4P6LdV001Bl7hIajoopsiuO5fD1x7wBqOT4=
X-Received: by 2002:a1f:1d4d:0:b0:382:59cd:596c with SMTP id
 d74-20020a1f1d4d000000b0038259cd596cmr3367837vkd.35.1661785696394; Mon, 29
 Aug 2022 08:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133146.15236-1-xry111@xry111.site> <20220829133146.15236-6-xry111@xry111.site>
In-Reply-To: <20220829133146.15236-6-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 29 Aug 2022 23:08:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H77jQvcJL=LF0dknd7EjiWYMZL3ZRMM1drsGkO33UM_Jg@mail.gmail.com>
Message-ID: <CAAhV-H77jQvcJL=LF0dknd7EjiWYMZL3ZRMM1drsGkO33UM_Jg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] LoongArch: Support PC-relative relocations in modules
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Mon, Aug 29, 2022 at 9:35 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> Binutils >= 2.40 uses R_LARCH_B26 instead of R_LARCH_SOP_PUSH_PLT_PCREL,
> and R_LARCH_PCALA* instead of R_LARCH_SOP_PUSH_PCREL.
>
> Handle R_LARCH_B26 and R_LARCH_PCALA* in the module loader.  For
> R_LARCH_B26, also create a PLT entry as needed.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/kernel/module-sections.c |  7 ++-
>  arch/loongarch/kernel/module.c          | 75 +++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
> index 6d498288977d..c67b9cb220eb 100644
> --- a/arch/loongarch/kernel/module-sections.c
> +++ b/arch/loongarch/kernel/module-sections.c
> @@ -56,9 +56,14 @@ static void count_max_entries(Elf_Rela *relas, int num, unsigned int *plts)
>
>         for (i = 0; i < num; i++) {
>                 type = ELF_R_TYPE(relas[i].r_info);
> -               if (type == R_LARCH_SOP_PUSH_PLT_PCREL) {
> +               switch (type) {
> +               case R_LARCH_SOP_PUSH_PLT_PCREL:
> +               case R_LARCH_B26:
>                         if (!duplicate_rela(relas, i))
>                                 (*plts)++;
> +                       break;
> +               default:
> +                       /* Do nothing. */
>                 }
>         }
>  }
> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> index 755d91ef8d85..0024bc6c4af1 100644
> --- a/arch/loongarch/kernel/module.c
> +++ b/arch/loongarch/kernel/module.c
> @@ -281,6 +281,79 @@ static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
>         }
>  }
>
> +static int apply_r_larch_b26(struct module *mod, u32 *location, Elf_Addr v,
> +                       s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +       ptrdiff_t offset = (void *)v - (void *)location;
> +       union loongarch_instruction *insn = (union loongarch_instruction *)location;
> +
> +       if (offset >= SZ_128M)
> +               v = module_emit_plt_entry(mod, v);
> +
> +       if (offset < -SZ_128M)
> +               v = module_emit_plt_entry(mod, v);
> +
> +       offset = (void *)v - (void *)location;
> +
> +       if (offset & 3) {
> +               pr_err("module %s: jump offset = 0x%llx unaligned! dangerous R_LARCH_B26 (%u) relocation\n",
> +                               mod->name, (long long)offset, type);
> +               return -ENOEXEC;
> +       }
> +
> +       if (!signed_imm_check(offset, 28)) {
> +               pr_err("module %s: jump offset = 0x%llx overflow! dangerous R_LARCH_B26 (%u) relocation\n",
> +                               mod->name, (long long)offset, type);
> +               return -ENOEXEC;
> +       }
> +
> +       offset >>= 2;
> +       insn->reg0i26_format.immediate_l = offset & 0xffff;
> +       insn->reg0i26_format.immediate_h = (offset >> 16) & 0x3ff;
> +       return 0;
> +}
> +
> +static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
> +                       s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +       union loongarch_instruction *insn = (union loongarch_instruction *)location;
> +       /* Use s32 for a sign-extension deliberately. */
> +       s32 offset_hi20 = (void *)((v + 0x800) & ~0xfff) -
> +               (void *)((Elf_Addr)location & ~0xfff);
> +       Elf_Addr anchor = (((Elf_Addr)location) & ~0xfff) + offset_hi20;
> +       ptrdiff_t offset_rem = (void *)v - (void *)anchor;
> +
> +       switch (type) {
> +       case R_LARCH_PCALA_HI20:
> +               v = offset_hi20 >> 12;
> +               break;
> +       case R_LARCH_PCALA64_LO20:
> +               v = offset_rem >> 32;
> +               break;
> +       case R_LARCH_PCALA64_HI12:
> +               v = offset_rem >> 52;
> +               break;
> +       default:
> +               /* Do nothing. */
> +       }
> +
> +       switch (type) {
> +       case R_LARCH_PCALA_HI20:
> +       case R_LARCH_PCALA64_LO20:
> +               insn->reg1i20_format.immediate = v & 0xfffff;
> +               break;
> +       case R_LARCH_PCALA_LO12:
> +       case R_LARCH_PCALA64_HI12:
> +               insn->reg2i12_format.immediate = v & 0xfff;
> +               break;
> +       default:
> +               pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
> +               return -EINVAL;
> +       }
Can we merge the two switch here?

Huacai
> +
> +       return 0;
> +}
> +
>  /*
>   * reloc_handlers_rela() - Apply a particular relocation to a module
>   * @mod: the module to apply the reloc to
> @@ -310,6 +383,8 @@ static reloc_rela_handler reloc_rela_handlers[] = {
>         [R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE]            = apply_r_larch_sop,
>         [R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
>         [R_LARCH_ADD32 ... R_LARCH_SUB64]                    = apply_r_larch_add_sub,
> +       [R_LARCH_B26]                                        = apply_r_larch_b26,
> +       [R_LARCH_PCALA_HI20...R_LARCH_PCALA64_HI12]          = apply_r_larch_pcala,
>  };
>
>  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> --
> 2.37.0
>
>
