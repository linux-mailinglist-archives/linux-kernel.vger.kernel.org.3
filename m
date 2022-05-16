Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93F527D62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiEPGJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiEPGJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:09:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D320F42;
        Sun, 15 May 2022 23:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D86B8CE0FF9;
        Mon, 16 May 2022 06:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5FCC385AA;
        Mon, 16 May 2022 06:08:55 +0000 (UTC)
Message-ID: <5d546c21-169c-cacc-6ca3-becf54876f7f@linux-m68k.org>
Date:   Mon, 16 May 2022 16:08:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220513064952.3610672-1-gerg@linux-m68k.org>
 <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
 <2532419a-812b-c2de-ef56-849ec7dc16bc@linux-m68k.org>
 <CAK8P3a3RuOTidFpW7diHekJ6POV20SBb5PhSF943Ju1xAtOxNw@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAK8P3a3RuOTidFpW7diHekJ6POV20SBb5PhSF943Ju1xAtOxNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 13/5/22 22:59, Arnd Bergmann wrote:
> On Fri, May 13, 2022 at 2:25 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 13/5/22 17:12, Geert Uytterhoeven wrote:
>>> read_persistent_clock64() uses mach_hwclk(), which is provided by
>>> both setup_mm.c and setup_no.c, so it's always available?> Albeit not populated by coldfire or nommu platform code, so I see
>>> the point in depending on MMU (no nommu Amiga support yet ;-).
>>
>> Yes, exactly. And even worse is that on ColdFire platforms it
>> is never set, so will be the startup value of NULL. It is called
>> without checking for NULL in both of rtc_generic_get_time() and
>> rtc_generic_set_time().
> 
> I think that's ok because rtc_generic_{get,set}_time is only called
> from the rtc_generic driver, but that is not registered when mach_hwclk()
> is NULL.
> 
> With your patch to add the CONFIG_MMU check, you can actually
> remove the mach_hwclk() symbol from setup_no.c, and move the
> remaining RTC related symbols from setup_mm.c into the #ifdef.

Yes, I think that would be a good idea.
Tidies thins up a little.

Regards
Greg

