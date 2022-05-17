Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577E0529B21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiEQHkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbiEQHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:39:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BBC48E48;
        Tue, 17 May 2022 00:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61E1DB8173A;
        Tue, 17 May 2022 07:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D337C385B8;
        Tue, 17 May 2022 07:38:14 +0000 (UTC)
Message-ID: <b4757e58-fafb-c801-3c1f-6ba1c79e6b94@linux-m68k.org>
Date:   Tue, 17 May 2022 17:38:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220513064952.3610672-1-gerg@linux-m68k.org>
 <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
 <2532419a-812b-c2de-ef56-849ec7dc16bc@linux-m68k.org>
 <CAK8P3a3RuOTidFpW7diHekJ6POV20SBb5PhSF943Ju1xAtOxNw@mail.gmail.com>
 <5d546c21-169c-cacc-6ca3-becf54876f7f@linux-m68k.org>
 <CAMuHMdVdWhKJ4Lwr1RaDXsc1b6_J0Hnjv4d+r1q=Fd3qhQ_WLQ@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdVdWhKJ4Lwr1RaDXsc1b6_J0Hnjv4d+r1q=Fd3qhQ_WLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 16/5/22 17:15, Geert Uytterhoeven wrote:
> On Mon, May 16, 2022 at 8:08 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 13/5/22 22:59, Arnd Bergmann wrote:
>>> On Fri, May 13, 2022 at 2:25 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>>>> On 13/5/22 17:12, Geert Uytterhoeven wrote:
>>>>> read_persistent_clock64() uses mach_hwclk(), which is provided by
>>>>> both setup_mm.c and setup_no.c, so it's always available?> Albeit not populated by coldfire or nommu platform code, so I see
>>>>> the point in depending on MMU (no nommu Amiga support yet ;-).
>>>>
>>>> Yes, exactly. And even worse is that on ColdFire platforms it
>>>> is never set, so will be the startup value of NULL. It is called
>>>> without checking for NULL in both of rtc_generic_get_time() and
>>>> rtc_generic_set_time().
>>>
>>> I think that's ok because rtc_generic_{get,set}_time is only called
>>> from the rtc_generic driver, but that is not registered when mach_hwclk()
>>> is NULL.
>>>
>>> With your patch to add the CONFIG_MMU check, you can actually
>>> remove the mach_hwclk() symbol from setup_no.c, and move the
>>> remaining RTC related symbols from setup_mm.c into the #ifdef.
>>
>> Yes, I think that would be a good idea.
>> Tidies thins up a little.
> 
> Let's fix the build error first.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I am re-thinking this fix at the moment. I think I missed the fact that
the 68328 has underlying mach_hwclk support, and so can use be used by
rtc_generic_{get,set}_time. So in other words classic m68k nommu config
should be able to use this code too. CONFIG_MMU blocking it is probably
not right here.

New patch coming.

Regards
Greg


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
