Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1823F4C5DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiB0RrF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Feb 2022 12:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiB0RrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:47:04 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F9192B8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:46:26 -0800 (PST)
Date:   Sun, 27 Feb 2022 17:46:12 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <0D5Z7R.NUOWBMRT4GQ2@crapouillou.net>
In-Reply-To: <CAK8P3a30RbSk3Y5CyRrOjfTiq0c9XGxC3qjAD0154j3a7k+xQQ@mail.gmail.com>
References: <20220226222457.13668-1-rdunlap@infradead.org>
        <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
        <449d6ceb-7308-9543-c23c-831bebffda21@infradead.org>
        <CAK8P3a30RbSk3Y5CyRrOjfTiq0c9XGxC3qjAD0154j3a7k+xQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dim., févr. 27 2022 at 18:30:16 +0100, Arnd Bergmann 
<arnd@arndb.de> a écrit :
> On Sun, Feb 27, 2022 at 5:57 PM Randy Dunlap <rdunlap@infradead.org> 
> wrote:
>>  On 2/27/22 04:04, Arnd Bergmann wrote:
>>  > On Sat, Feb 26, 2022 at 11:24 PM Randy Dunlap 
>> <rdunlap@infradead.org> wrote:
>>  >
>>  >> ---
>>  >>  drivers/misc/cardreader/rtsx_pcr.c |    2 ++
>>  >>  1 file changed, 2 insertions(+)
>>  >>
>>  >> --- linux-next-20220225.orig/drivers/misc/cardreader/rtsx_pcr.c
>>  >> +++ linux-next-20220225/drivers/misc/cardreader/rtsx_pcr.c
>>  >> @@ -1054,6 +1054,7 @@ static int rtsx_pci_acquire_irq(struct r
>>  >>         return 0;
>>  >>  }
>>  >>
>>  >> +#ifdef CONFIG_PM
>>  >>  static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
>>  >>  {
>>  >>         if (pcr->ops->set_aspm)
>>  >> @@ -1085,6 +1086,7 @@ static void rtsx_pm_power_saving(struct
>>  >>  {
>>  >>         rtsx_comm_pm_power_saving(pcr);
>>  >>  }
>>  >> +#endif
>>  >
>>  > Now that we have DEFINE_SIMPLE_DEV_PM_OPS() etc, I think we should
>>  > no longer add more __maybe_unused annotations or #ifdef CONFIG_PM 
>> checks
>>  > but just use the new macros for any new files or whenever a 
>> warning like
>>  > this shows up.
>> 
>>  In this case it looks like DEFINE_RUNTIME_DEV_PM_OPS() is better.
>>  Using DEFINE_SIMPLE_DEV_PM_OPS() still produces build 
>> warnings/errors
>>  for unused functions. And I do see 4 drivers that are already using
>>  DEFINE_RUNTIME_DEV_PM_OPS().
>> 
>>  Patch coming right up.
> 
> DEFINE_RUNTIME_DEV_PM_OPS() only references the three runtime 
> functions
> (rtsx_pci_runtime_suspend, rtsx_pci_runtime_resume and 
> rtsx_pci_runtime_idle)
> but not the pm-sleep functions (rtsx_pci_suspend and 
> rtsx_pci_resume), so your
> second patch doesn't look correct either.
> 
> I see there is a _DEFINE_DEV_PM_OPS() helper that appears to do
> what we want here, but I'm not sure this is considered an official 
> API. Adding
> Rafael, Paul and Jonathan to Cc for extra input. As the macros are 
> still
> fairly new, I suspect the idea was to add more as needed, so maybe 
> should
> add a DEFINE_DEV_PM_OPS() to wrap _DEFINE_DEV_PM_OPS()?


There could be a DEFINE_DEV_PM_OPS(), but I don't think that's really 
needed - you can very well declare your struct dev_pm_ops without using 
one of these macros. Just make sure to use the SYSTEM_SLEEP_PM_OPS / 
RUNTIME_PM_OPS macros for the callbacks and pm_ptr() for the device.pm 
pointer.

Cheers,
-Paul


