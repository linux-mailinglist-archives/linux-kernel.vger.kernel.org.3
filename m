Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA244BA928
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiBQTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:03:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbiBQTDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:03:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF88021E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=6O8Xpg6MydXTil/FTqFUVmc2lW46rPBJGcK5U75LtL4=; b=AW1GIrcC5d/KTVTumGcfQ6UlbI
        fbcOBreeOXkTeIFQPJyLmKVrDUCO6uA9BJCPDDxYKUwF2AbuNTJnuo6prS2ZlCBIwagyz2FA/tQ9i
        9DO2NVOB4HayNQqO97dOd8kowNYMN1wICi25FiF2u84pHYzihx6rnc4YDkM7WKpkciLUFyTj6NZiv
        70TTX1QzVPUsdftwl3MuPTb7W4jT8y3wu8h1amZjpwa3hufk5gWQa9cbQg205vezk61ATTjsyywVe
        lUV5HXxq6GYfqdjOQK9nAy2ZfRtvO28FnR6FcZRsUtxnKNMoaTjeA+hW31jAqftVctLC4dypq/H89
        rM7KA3kw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKm3L-00Fs8e-3C; Thu, 17 Feb 2022 19:02:55 +0000
Message-ID: <cb2a6fc4-1a6e-02ed-07e2-8e2a3fe7e93e@infradead.org>
Date:   Thu, 17 Feb 2022 11:02:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] NDS32: export __trace_hardirqs_on/_offf for entry/exit
Content-Language: en-US
To:     Greentime Hu <green.hu@gmail.com>, Alan Kao <alankao@andestech.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>, kclin@andestech.com
References: <20210928052657.20909-1-rdunlap@infradead.org>
 <CAEbi=3cT_ifvDmn3WKHfuy=VyG8Y79X+HS9hNNuvNwTn_Ned_Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEbi=3cT_ifvDmn3WKHfuy=VyG8Y79X+HS9hNNuvNwTn_Ned_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

I have an updated patch for this one ... if anyone is out there
to apply arch/nds32/ patches.


On 9/28/21 06:15, Greentime Hu wrote:
> Randy Dunlap <rdunlap@infradead.org> 於 2021年9月28日 週二 下午1:27寫道：
>>
>> Add exports for __trace_hardirqs_on/_off and use them in
>> kernel/ex-entry.S and kernel/ex-exit.S to fix build/linker errors.
>>
>> nds32le-linux-ld: arch/nds32/kernel/ex-entry.o: in function `fucop_ctl_done':
>> (.text+0x12a): undefined reference to `__trace_hardirqs_off'
>> (.text+0x12a): relocation truncated to fit: R_NDS32_25_PCREL_RELA against undefined symbol `__trace_hardirqs_off'
>> nds32le-linux-ld: arch/nds32/kernel/ex-exit.o: in function `no_work_pending':
>> (.text+0xea): undefined reference to `__trace_hardirqs_off'
>> nds32le-linux-ld: (.text+0xee): undefined reference to `__trace_hardirqs_off'
>> nds32le-linux-ld: (.text+0xf2): undefined reference to `__trace_hardirqs_on'
>> nds32le-linux-ld: (.text+0xf6): undefined reference to `__trace_hardirqs_on'
>>
>> Fixes: 0cde56e0280d ("nds32: Fix a kernel panic issue because of wrong frame pointer access.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Nick Hu <nickhu@andestech.com>
>> Cc: Greentime Hu <green.hu@gmail.com>
>> Cc: Vincent Chen <deanbo422@gmail.com>
>> ---
>>  arch/nds32/include/asm/ftrace.h |    3 +++
>>  arch/nds32/kernel/ex-entry.S    |    1 +
>>  arch/nds32/kernel/ex-exit.S     |    2 +-
>>  arch/nds32/kernel/ftrace.c      |    3 +++
>>  4 files changed, 8 insertions(+), 1 deletion(-)
>>
>> --- linux-next-20210917.orig/arch/nds32/kernel/ftrace.c
>> +++ linux-next-20210917/arch/nds32/kernel/ftrace.c
>> @@ -276,8 +276,11 @@ noinline void __trace_hardirqs_off(void)
>>  {
>>         trace_hardirqs_off();
>>  }
>> +EXPORT_SYMBOL(__trace_hardirqs_off);
>> +
>>  noinline void __trace_hardirqs_on(void)
>>  {
>>         trace_hardirqs_on();
>>  }
>> +EXPORT_SYMBOL(__trace_hardirqs_on);
>>  #endif /* CONFIG_TRACE_IRQFLAGS */
>> --- linux-next-20210917.orig/arch/nds32/include/asm/ftrace.h
>> +++ linux-next-20210917/arch/nds32/include/asm/ftrace.h
>> @@ -15,6 +15,9 @@
>>
>>  extern void _mcount(unsigned long parent_ip);
>>
>> +extern void __trace_hardirqs_off(void);
>> +extern void __trace_hardirqs_on(void);
>> +
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>>
>>  #define FTRACE_ADDR ((unsigned long)_ftrace_caller)
>> --- linux-next-20210917.orig/arch/nds32/kernel/ex-entry.S
>> +++ linux-next-20210917/arch/nds32/kernel/ex-entry.S
>> @@ -8,6 +8,7 @@
>>  #include <asm/asm-offsets.h>
>>  #include <asm/page.h>
>>  #include <asm/fpu.h>
>> +#include <asm/ftrace.h>
>>
>>  #ifdef CONFIG_HWZOL
>>         .macro push_zol
>> --- linux-next-20210917.orig/arch/nds32/kernel/ex-exit.S
>> +++ linux-next-20210917/arch/nds32/kernel/ex-exit.S
>> @@ -9,7 +9,7 @@
>>  #include <asm/thread_info.h>
>>  #include <asm/current.h>
>>  #include <asm/fpu.h>
>> -
>> +#include <asm/ftrace.h>
>>
>>
>>  #ifdef CONFIG_HWZOL
> 
> loop in Alan and KC.

-- 
~Randy
