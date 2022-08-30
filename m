Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA05E5A58ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiH3Bmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiH3Bme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:42:34 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8C47C1AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1661823748; bh=58NYac2VN6bAtPqhMxaL7OUy/f09kLyZxGEBfpCP8Pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dhnnHxB41JmaLmFWVDb9H/AcsuXykMH6m1vgqHVMU+AX+m7r9H8LLVDmIO8toAGmi
         WEtcX/7xf8MbUxgjkd9ZqBRrTfD1VTutzc64xMgnmf+QBW7d2QLYfhOcgXx50beoDU
         mSYdyLY2uTo09URLkuZnaTePH/jdJKrCxV7Pe378=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E3664600D1;
        Tue, 30 Aug 2022 09:42:27 +0800 (CST)
Message-ID: <4033aec9-8df5-53ae-59e1-9ec3ade5f6d7@xen0n.name>
Date:   Tue, 30 Aug 2022 09:42:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:106.0)
 Gecko/20100101 Thunderbird/106.0a1
Subject: Re: [PATCH v6 5/6] LoongArch: Support PC-relative relocations in
 modules
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
References: <20220829133146.15236-1-xry111@xry111.site>
 <20220829133146.15236-6-xry111@xry111.site>
 <CAAhV-H77jQvcJL=LF0dknd7EjiWYMZL3ZRMM1drsGkO33UM_Jg@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H77jQvcJL=LF0dknd7EjiWYMZL3ZRMM1drsGkO33UM_Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/29 23:08, Huacai Chen wrote:
> [snip]
>> +static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
>> +                       s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
>> +{
>> +       union loongarch_instruction *insn = (union loongarch_instruction *)location;
>> +       /* Use s32 for a sign-extension deliberately. */
>> +       s32 offset_hi20 = (void *)((v + 0x800) & ~0xfff) -
>> +               (void *)((Elf_Addr)location & ~0xfff);
>> +       Elf_Addr anchor = (((Elf_Addr)location) & ~0xfff) + offset_hi20;
>> +       ptrdiff_t offset_rem = (void *)v - (void *)anchor;
>> +
>> +       switch (type) {
>> +       case R_LARCH_PCALA_HI20:
>> +               v = offset_hi20 >> 12;
>> +               break;
>> +       case R_LARCH_PCALA64_LO20:
>> +               v = offset_rem >> 32;
>> +               break;
>> +       case R_LARCH_PCALA64_HI12:
>> +               v = offset_rem >> 52;
>> +               break;
>> +       default:
>> +               /* Do nothing. */
>> +       }
>> +
>> +       switch (type) {
>> +       case R_LARCH_PCALA_HI20:
>> +       case R_LARCH_PCALA64_LO20:
>> +               insn->reg1i20_format.immediate = v & 0xfffff;
>> +               break;
>> +       case R_LARCH_PCALA_LO12:
>> +       case R_LARCH_PCALA64_HI12:
>> +               insn->reg2i12_format.immediate = v & 0xfff;
>> +               break;
>> +       default:
>> +               pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
>> +               return -EINVAL;
>> +       }
> Can we merge the two switch here?

IMO leaving as-is or even splitting into two functions would be 
acceptable, as the two switches are performing two different things -- 
namely "adjustFixupValue" (in LLVM-speak) and actually inserting the 
value into the insn word. But an argument for merging the two can be 
made too, because the v2.00 reloc types are purposely designed with 
unique use case for each, meaning there is actually no flexibility in 
between the fixup value's calculation and application. So I think this 
eventually comes down to coder's preference?

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

