Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3851356C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347508AbiD1Nom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiD1Noi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:44:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465225BE5E;
        Thu, 28 Apr 2022 06:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E50A9B82D5F;
        Thu, 28 Apr 2022 13:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD67C385A9;
        Thu, 28 Apr 2022 13:41:20 +0000 (UTC)
Message-ID: <99adb257-bf94-a291-b5a9-d22e97ce967a@linux-m68k.org>
Date:   Thu, 28 Apr 2022 23:41:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] m68knommu: allow elf_fdpic loader to be selected
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
References: <20220428033319.239341-1-gerg@linux-m68k.org>
 <20220428033319.239341-5-gerg@linux-m68k.org>
 <CAMuHMdXtj+ncYOhc3GcNdBuWxMe+0rP1aYCEKMP0yL3aJ_WH3w@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdXtj+ncYOhc3GcNdBuWxMe+0rP1aYCEKMP0yL3aJ_WH3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 28/4/22 17:20, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Thu, Apr 28, 2022 at 7:05 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> The m68k architecture code is capable of supporting the binfmt_elf_fdpic
>> loader, so allow it to be configured. It is restricted to nommu
>> configurations at this time due to the MMU context structures/code not
>> supporting everything elf_fdpic needs when MMU is enabled.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>> --- a/fs/Kconfig.binfmt
>> +++ b/fs/Kconfig.binfmt
>> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>>   config BINFMT_ELF_FDPIC
>>          bool "Kernel support for FDPIC ELF binaries"
>>          default y if !BINFMT_ELF
>> -       depends on (ARM || (SUPERH && !MMU))
>> +       depends on (ARM || ((M68K || SUPERH) && !MMU))
> 
> While at it, you may want to drop the unneeded outer parentheses,
> as they make the expression harder to round, IMHO.

Sure thing, will do,

Regards
Greg


>>          select ELFCORE
>>          help
>>            ELF FDPIC binaries are based on ELF, but allow the individual load
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
