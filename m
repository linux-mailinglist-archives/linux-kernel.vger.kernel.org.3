Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDA583EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiG1Ma5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiG1Mah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:30:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431394E63C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE474B82440
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A10C4347C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659011429;
        bh=iv54j1mHM1UKpygMWX9SMc2VsQtTs7Br5QyTcza7ZCI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mjrMP/MH712h+HhGvQQ1kymV+ulGFsQtzZ/Ijr94LT2WGjm/dNHxjCLy6bc2AkVP4
         Evqy4l3EdkssdMZpfmDz+uhkFO0zUQcXykMkSO/T0aSe8+NZ4rMWV+2hY9oKAIbvFU
         i9QIpps2+On3Ehw3kmrLq9M9BOp91RoDZO4FzGHv/vFBSlscDBHZ/Rzd1Pa6x65w/j
         tqjP2lvl0TfEDSXR0d+6c51F1KpFVHUZwT97l7KuaZ2cLp2qUkjGgo4iIuVB88PFiv
         IkkDEgYEwdqeq1tcvAXWwTyWGmpbxouGT1lqCQMc6cendhkCsno6p3QSAigjyNeJF/
         JlsPjXRq3X5Jw==
Received: by mail-vs1-f52.google.com with SMTP id t28so1447080vsr.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:30:29 -0700 (PDT)
X-Gm-Message-State: AJIora8n/vhkfkbj0u8YdA8+/iLgEvW9bu5eM6WqqUHxqRYFudXAl7d2
        BP0gUfFQiHyLtrfCLglrRgMXbosUhpcg8LFT+yc=
X-Google-Smtp-Source: AGRyM1uWtlOR7OMPRfU0AmOx6O5BINwixPbzdpuPUTNDSbsdfGMQkeHg4O6nN54+epVupYXoDw6Gt2MGWnneslj/oNA=
X-Received: by 2002:a67:d599:0:b0:358:6371:4cfb with SMTP id
 m25-20020a67d599000000b0035863714cfbmr6290530vsj.78.1659011428530; Thu, 28
 Jul 2022 05:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site> <81c67c5f4c5f20fa5e6862f260884c61cafcaf93.camel@xry111.site>
In-Reply-To: <81c67c5f4c5f20fa5e6862f260884c61cafcaf93.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 20:30:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4vurz+-jwJm4SCQeaChLkXhrPFginpzNpYX6HkcD_xqA@mail.gmail.com>
Message-ID: <CAAhV-H4vurz+-jwJm4SCQeaChLkXhrPFginpzNpYX6HkcD_xqA@mail.gmail.com>
Subject: Re: [PATCH 2/4] LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation
 type in kernel module
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

Missing V2 in the title?

Huacai

On Thu, Jul 28, 2022 at 7:59 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> This relocation type pushes the offset of the GOT entry for a symbol
> from the beginning of GOT into the relocation stack.  Our linker script
> has initialized an empty GOT, so we need to create a new GOT entry if
> there is no exist one for a symbol.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/kernel/module.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> index 638427ff0d51..3ac4fbb5f109 100644
> --- a/arch/loongarch/kernel/module.c
> +++ b/arch/loongarch/kernel/module.c
> @@ -122,6 +122,16 @@ static int apply_r_larch_sop_push_plt_pcrel(struct module *mod, u32 *location, E
>         return apply_r_larch_sop_push_pcrel(mod, location, v, rela_stack, rela_stack_top, type);
>  }
>
> +static int apply_r_larch_sop_push_gprel(struct module *mod, u32 *location,
> +                       Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
> +                       unsigned int type)
> +{
> +       Elf_Addr got = module_emit_got_entry(mod, v);
> +       ptrdiff_t offset = (void *)got - (void *)mod->arch.got.shdr->sh_addr;
> +
> +       return rela_stack_push(offset, rela_stack, rela_stack_top);
> +}
> +
>  static int apply_r_larch_sop(struct module *mod, u32 *location, Elf_Addr v,
>                         s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
>  {
> @@ -306,6 +316,7 @@ static reloc_rela_handler reloc_rela_handlers[] = {
>         [R_LARCH_SOP_PUSH_PCREL]                             = apply_r_larch_sop_push_pcrel,
>         [R_LARCH_SOP_PUSH_ABSOLUTE]                          = apply_r_larch_sop_push_absolute,
>         [R_LARCH_SOP_PUSH_DUP]                               = apply_r_larch_sop_push_dup,
> +       [R_LARCH_SOP_PUSH_GPREL]                             = apply_r_larch_sop_push_gprel,
>         [R_LARCH_SOP_PUSH_PLT_PCREL]                         = apply_r_larch_sop_push_plt_pcrel,
>         [R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE]            = apply_r_larch_sop,
>         [R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
> --
> 2.37.0
>
>
>
