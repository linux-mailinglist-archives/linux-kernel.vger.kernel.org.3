Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7BE5A5C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiH3HKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiH3HKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:10:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5985473329
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 073E4B815DD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9671DC433B5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661843441;
        bh=aUwZvFPgGPgQxLQm3ylFwunvJW/D4Qz/bEeYplvQR78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c9uSxjfDl4qaLcZ5MadHTwWSPttIIsyGGo1y4xC+NBR8tZYA3CxmYRCiCBPNTquC3
         R8YxLsncJx0AFoFck02ZSI7FZ4SUi9ePD2hKJyhF/9OTl+ORliLaO+mPu7snTvDLnN
         mWR6d8YWFDL2bVgvlqlJnyIV+2HPdwB7vfmf3W0D8H5aGqX0wLSYg34dlMouF3aacN
         WIujNiA8fpmuKM38YpqRcFjUVg7PqtBvr1MM6YthTuZZ4U5gfGI/Z1J584Wp3YHGdN
         XRwKXSiqC2/VuCukQR27DmS2XbfPNu7WEFkAmR0Ho+SemFYw+Mr9kZMaslJWW5qUGj
         TNAPWA2MGiWRw==
Received: by mail-vs1-f53.google.com with SMTP id n125so10622071vsc.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:10:41 -0700 (PDT)
X-Gm-Message-State: ACgBeo1H0a1vmoqdTyFIhS0Gs6muYX3eeKrgm7AfOs4JF1Txu6Vu3mfJ
        YeIbARwM5DIPvOCSO4yaWE24epc+Qkw4B7KXoYM=
X-Google-Smtp-Source: AA6agR5eMH6mzqudoP6EpTbEAAsSK9Tmk7AaUu96e4Qa164/wnyTqJOVYvqpClplpYFGtKtF3OHjJzDFAc/IcngWzbY=
X-Received: by 2002:a05:6102:30bc:b0:390:da09:3a8c with SMTP id
 y28-20020a05610230bc00b00390da093a8cmr2867659vsd.84.1661843440489; Tue, 30
 Aug 2022 00:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133146.15236-1-xry111@xry111.site> <20220829133146.15236-6-xry111@xry111.site>
 <CAAhV-H77jQvcJL=LF0dknd7EjiWYMZL3ZRMM1drsGkO33UM_Jg@mail.gmail.com> <4033aec9-8df5-53ae-59e1-9ec3ade5f6d7@xen0n.name>
In-Reply-To: <4033aec9-8df5-53ae-59e1-9ec3ade5f6d7@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 30 Aug 2022 15:10:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4PXsBop6c3or92hv01YCiY=JFLnTwjSykaeN21+YvwFQ@mail.gmail.com>
Message-ID: <CAAhV-H4PXsBop6c3or92hv01YCiY=JFLnTwjSykaeN21+YvwFQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] LoongArch: Support PC-relative relocations in modules
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
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

On Tue, Aug 30, 2022 at 9:42 AM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 2022/8/29 23:08, Huacai Chen wrote:
> > [snip]
> >> +static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
> >> +                       s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> >> +{
> >> +       union loongarch_instruction *insn = (union loongarch_instruction *)location;
> >> +       /* Use s32 for a sign-extension deliberately. */
> >> +       s32 offset_hi20 = (void *)((v + 0x800) & ~0xfff) -
> >> +               (void *)((Elf_Addr)location & ~0xfff);
> >> +       Elf_Addr anchor = (((Elf_Addr)location) & ~0xfff) + offset_hi20;
> >> +       ptrdiff_t offset_rem = (void *)v - (void *)anchor;
> >> +
> >> +       switch (type) {
> >> +       case R_LARCH_PCALA_HI20:
> >> +               v = offset_hi20 >> 12;
> >> +               break;
> >> +       case R_LARCH_PCALA64_LO20:
> >> +               v = offset_rem >> 32;
> >> +               break;
> >> +       case R_LARCH_PCALA64_HI12:
> >> +               v = offset_rem >> 52;
> >> +               break;
> >> +       default:
> >> +               /* Do nothing. */
> >> +       }
> >> +
> >> +       switch (type) {
> >> +       case R_LARCH_PCALA_HI20:
> >> +       case R_LARCH_PCALA64_LO20:
> >> +               insn->reg1i20_format.immediate = v & 0xfffff;
> >> +               break;
> >> +       case R_LARCH_PCALA_LO12:
> >> +       case R_LARCH_PCALA64_HI12:
> >> +               insn->reg2i12_format.immediate = v & 0xfff;
> >> +               break;
> >> +       default:
> >> +               pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
> >> +               return -EINVAL;
> >> +       }
> > Can we merge the two switch here?
>
> IMO leaving as-is or even splitting into two functions would be
> acceptable, as the two switches are performing two different things --
> namely "adjustFixupValue" (in LLVM-speak) and actually inserting the
> value into the insn word. But an argument for merging the two can be
> made too, because the v2.00 reloc types are purposely designed with
> unique use case for each, meaning there is actually no flexibility in
> between the fixup value's calculation and application. So I think this
> eventually comes down to coder's preference?
Merging them can just make me understand the logic better, and save
some lines. :)

Huacai
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
