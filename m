Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE5532BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiEXOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiEXOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:02:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718503FBCA;
        Tue, 24 May 2022 07:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1877AB818C4;
        Tue, 24 May 2022 14:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B8CC385AA;
        Tue, 24 May 2022 14:02:02 +0000 (UTC)
Message-ID: <3206237b-4ee2-8707-6de9-87cfb226c87f@linux-m68k.org>
Date:   Wed, 25 May 2022 00:01:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] m68knommu: fix undefined reference to
 `mach_get_rtc_pll'
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
References: <20220518065639.2432213-1-gerg@linux-m68k.org>
 <20220518065639.2432213-2-gerg@linux-m68k.org>
 <CAMuHMdXTn6ysmjg5cr2RvYG=8f3azC1B4v=via0ePua_hv6TgA@mail.gmail.com>
 <CAMuHMdV+k4kGv+vKSGNnwhKCk3eYv5uQd=UgNJQ1HVYxuOUv5g@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdV+k4kGv+vKSGNnwhKCk3eYv5uQd=UgNJQ1HVYxuOUv5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 24/5/22 17:49, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Tue, May 24, 2022 at 9:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, May 18, 2022 at 8:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>>> Configuring for a nommu classic m68k target and enabling the generic rtc
>>> driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
>>> error:
>>>
>>>     m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>>>     time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>>>     m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>>>     m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>>>
>>> There is no definitions of "mach_set_rtc_pll" and "mach_get_rtc_pll" in the
>>> nommu code paths. Move these definitions and the associated "mach_hwclk",
>>> so that they are around their use case in time.c. This means they will
>>> always be defined on the builds that require them, and not on those that
>>> cannot use them - such as ColdFire (both with and without MMU enabled).
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>>
>>> --- a/arch/m68k/kernel/time.c
>>> +++ b/arch/m68k/kernel/time.c
>>> @@ -82,6 +86,11 @@ void read_persistent_clock64(struct timespec64 *ts)
>>>   #endif
>>>
>>>   #if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
>>> +int (*mach_get_rtc_pll)(struct rtc_pll_info *);
>>> +int (*mach_set_rtc_pll)(struct rtc_pll_info *);
>>> +EXPORT_SYMBOL(mach_get_rtc_pll);
>>> +EXPORT_SYMBOL(mach_set_rtc_pll);
>>
>> Oops, this causes build failures for Q40 with CONFIG_RTC_DRV_GENERIC=n,
>> as arch/m68k/q40/config.c uses mach_]gs]et_rtc_pll() unconditionally.
> 
> I think the simplest solution is to move these up, next to mach_hwclk.

Yes, that looks to be the easiest solution.
New patch coming up.

Regards
Greg


>>> +
>>>   static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
>>>   {
>>>          mach_hwclk(0, tm);
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
