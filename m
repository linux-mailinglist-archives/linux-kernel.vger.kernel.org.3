Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F065A6932
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiH3REE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiH3RDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:03:52 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D081CB0F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:03:51 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.5.6])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1oT4eR-0069vo-0x; Tue, 30 Aug 2022 18:03:47 +0100
Message-ID: <cefcf96f-5bcc-d134-fbe5-d1169313b6f3@codethink.co.uk>
Date:   Tue, 30 Aug 2022 18:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] soc: sifive: ccache: reduce printing on init
Content-Language: en-GB
To:     Conor.Dooley@microchip.com, ben.dooks@sifive.com,
        zong.li@sifive.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830082620.1680602-1-ben.dooks@sifive.com>
 <fdec1b72-27f3-96e6-5e19-d54ded4aea68@microchip.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <fdec1b72-27f3-96e6-5e19-d54ded4aea68@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 17:30, Conor.Dooley@microchip.com wrote:
> On 30/08/2022 09:26, Ben Dooks wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> The driver prints out 6 lines on startup, which can easily be redcued
>> to two lines without losing any information.
>>
>> Note, to make the types work better, uint64_t has been replaced with
>> ULL to make the unsigned long long match the format in the print
>> statement.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
>>   1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
>> index 46ce33db7d30..65a10a6ee211 100644
>> --- a/drivers/soc/sifive/sifive_ccache.c
>> +++ b/drivers/soc/sifive/sifive_ccache.c
>> @@ -76,20 +76,17 @@ static void setup_sifive_debug(void)
>>
>>   static void ccache_config_read(void)
>>   {
>> -       u32 regval, val;
>> -
>> -       regval = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
>> -       val = regval & 0xFF;
>> -       pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
>> -       val = (regval & 0xFF00) >> 8;
>> -       pr_info("CCACHE: No. of ways per bank: %d\n", val);
>> -       val = (regval & 0xFF0000) >> 16;
>> -       pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
>> -       val = (regval & 0xFF000000) >> 24;
>> -       pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
>> -
>> -       regval = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
>> -       pr_info("CCACHE: Index of the largest way enabled: %d\n", regval);
>> +       u32 cfg;
>> +
>> +       cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
>> +
>> +       pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
>> +               (cfg & 0xff), (cfg >> 8) & 0xff,
>> +               1ULL << ((cfg >> 16) & 0xff),
> 
> This is just BIT_ULL((cfg >> 16) & 0xff), no?
> Would be nice too if these were defined, so you'd have something
> like BIT_ULL((cfg >> SETS_PER_BANK_SHIFT) & 0xff)
> 
> I do like the cleanup of the uint64_t & cutting down on the prints
> though :) Again, it'd be nice if you and Zong could collaborate on
> a combined v2.

I think even BIT_UL() would do here, if someone is going to make a
cache bigger than 2GiB we'll probably be quite old by then, so v2
might have the last two values down as %lu.

> Thanks,
> Conor.
> 
>> +               1ULL << ((cfg >> 24) & 0xff));
>> +
>> +       cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
>> +       pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
>>   }
>>
>>   static const struct of_device_id sifive_ccache_ids[] = {
>> --
>> 2.35.1
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

