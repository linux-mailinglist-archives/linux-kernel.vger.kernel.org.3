Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C824C5D99
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiB0Q62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiB0Q61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:58:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959BC3F8AD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oyR9bICvSF8oqaSCI3XCH9sBS6Bwfxy+ufW0snswUSs=; b=RnYYHAlSQrIWR5htPz/V+VDojs
        ZMIx/HWiehHfoipJKokqY0zG+lJh7M3ZDnD7uT9gabDYrRqyUzfnx79j0ozzLZtVzzNGO52uFAyO6
        8n9mQL+PhTCzM2e/Sw1tAGLM21KtuqT+oqICVI/hMVsXsgyuAxDiQmvX6xx5hRoI+TAOHcTrBOwZY
        A8s54lvymLMJ8oLW9BzKungOiSQNK9sWEKb5052s0vvpIEdWhF5r5xg8NXYTVi5m0xqRW/SB1vRns
        6G71ey7UoK3+DBz5lKvoD52TfhjTJt08nSafvCtMJStlnuTWFX8TK1dVeNF/gD8nkdbVI9KZFwSeR
        8YsDXXTQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOMrh-00DbSl-75; Sun, 27 Feb 2022 16:57:45 +0000
Message-ID: <449d6ceb-7308-9543-c23c-831bebffda21@infradead.org>
Date:   Sun, 27 Feb 2022 08:57:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220226222457.13668-1-rdunlap@infradead.org>
 <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/22 04:04, Arnd Bergmann wrote:
> On Sat, Feb 26, 2022 at 11:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> ---
>>  drivers/misc/cardreader/rtsx_pcr.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- linux-next-20220225.orig/drivers/misc/cardreader/rtsx_pcr.c
>> +++ linux-next-20220225/drivers/misc/cardreader/rtsx_pcr.c
>> @@ -1054,6 +1054,7 @@ static int rtsx_pci_acquire_irq(struct r
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_PM
>>  static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
>>  {
>>         if (pcr->ops->set_aspm)
>> @@ -1085,6 +1086,7 @@ static void rtsx_pm_power_saving(struct
>>  {
>>         rtsx_comm_pm_power_saving(pcr);
>>  }
>> +#endif
> 
> Now that we have DEFINE_SIMPLE_DEV_PM_OPS() etc, I think we should
> no longer add more __maybe_unused annotations or #ifdef CONFIG_PM checks
> but just use the new macros for any new files or whenever a warning like
> this shows up.

In this case it looks like DEFINE_RUNTIME_DEV_PM_OPS() is better.
Using DEFINE_SIMPLE_DEV_PM_OPS() still produces build warnings/errors
for unused functions. And I do see 4 drivers that are already using
DEFINE_RUNTIME_DEV_PM_OPS().

Patch coming right up.

thanks.
-- 
~Randy
