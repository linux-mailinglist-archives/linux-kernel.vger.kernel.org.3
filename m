Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F05261C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380226AbiEMMZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380217AbiEMMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:25:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DCC2A1FCC;
        Fri, 13 May 2022 05:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79627B82F6C;
        Fri, 13 May 2022 12:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C57CC34115;
        Fri, 13 May 2022 12:25:18 +0000 (UTC)
Message-ID: <2532419a-812b-c2de-ef56-849ec7dc16bc@linux-m68k.org>
Date:   Fri, 13 May 2022 22:25:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
References: <20220513064952.3610672-1-gerg@linux-m68k.org>
 <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 13/5/22 17:12, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Fri, May 13, 2022 at 8:50 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> Configuring for a nommu classic m68k target and enabling the generic rtc
>> driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
>> error:
>>
>>     m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>>     time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>>     m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>>     m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>>
>> "mach_set_rtc_pll" and "mach_get_rtc_pll" are only defined in the common
>> MMU setup code, and are really only implemented in any meaningful way on
>> classic M68K MMU enabled machines. So conditionally limit their use to
> 
> And only on Q40/Q60.
> 
>> MMU enabled classic M68K systems.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thanks for your patch!
> 
>> --- a/arch/m68k/kernel/time.c
>> +++ b/arch/m68k/kernel/time.c
>> @@ -62,7 +62,7 @@ void timer_heartbeat(void)
>>   }
>>   #endif /* CONFIG_HEARTBEAT */
>>
>> -#ifdef CONFIG_M68KCLASSIC
>> +#if defined(CONFIG_M68KCLASSIC) && defined(CONFIG_MMU)
>>   #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
>>   void read_persistent_clock64(struct timespec64 *ts)
>>   {
> 
> read_persistent_clock64() uses mach_hwclk(), which is provided by
> both setup_mm.c and setup_no.c, so it's always available?> Albeit not populated by coldfire or nommu platform code, so I see
> the point in depending on MMU (no nommu Amiga support yet ;-).

Yes, exactly. And even worse is that on ColdFire platforms it
is never set, so will be the startup value of NULL. It is called
without checking for NULL in both of rtc_generic_get_time() and
rtc_generic_set_time().

I figured if nommu mode is ever supported on any of the classic
MMU m68k then this could be revisited.


> Perhaps rtc_ioctl() should depend on CONFIG_Q40?

That is probably reasonable too. Using CONFIG_MMU was a good fit
for the way mach_set_rtc_pll and mach_get_rtc_pll are currently
defined - as in setup_mm.c which is CONFIG_MMU only, which is why
I went that way.

But if you prefer I can re-factor further based on CONFIG_Q40?

Regards
Greg


>> @@ -140,7 +140,7 @@ static int __init rtc_init(void)
>>
>>   module_init(rtc_init);
>>   #endif /* CONFIG_RTC_DRV_GENERIC */
>> -#endif /* CONFIG M68KCLASSIC */
>> +#endif /* CONFIG M68KCLASSIC && CONFIG_MMU */
>>
>>   void __init time_init(void)
>>   {
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
