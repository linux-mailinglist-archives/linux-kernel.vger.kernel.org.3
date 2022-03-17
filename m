Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D924DCA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiCQPgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiCQPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:36:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F82182AC5;
        Thu, 17 Mar 2022 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OB1IcziBWfAnbJ9LsEdMKWfQUQHAFJ2UIjfWTh8yHjg=; b=YyYJaJIeQbwttSAMgjXp8NQJxK
        eAz9SSVREsDA6lc5UYh+72O9d6zRKP+NkHlvZIXypEM3RMnoc7ifgKL6lT3zJw3T+yV0usG0zdteN
        4NxBwpyFM6lSufaZBwDmjHvLFvRNs3RpXAUyKKlBPXRy4HID32E3iVF5TYeokMeolM9O3mKsk3TtN
        wRl+NswsnCP5dvYlCSaqmiJfzgZc5sq2jKq2lzX1HRlC93YUllLZ2mpUDyabCPKBADR7jxSKzcy0f
        qX0CLpPsCPiDmPhndLs0Cx4dB2tKG/c2NlAEJ4qWSpoka36AxUyT3aF8UPJFloOUNC0nN0gZoGhdy
        eDNRwIJA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUs9F-0075Ll-K1; Thu, 17 Mar 2022 15:34:45 +0000
Message-ID: <8779cbd8-6d7c-7895-7c2c-27778bdf1d96@infradead.org>
Date:   Thu, 17 Mar 2022 08:34:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] clocksource: acpi_pm: fix return value of __setup
 handler
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20220315144122.23144-1-rdunlap@infradead.org>
 <CAJZ5v0gfX2weU++t4szknB16PxufzGZ26NHgqe__B-+VdAmCQw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJZ5v0gfX2weU++t4szknB16PxufzGZ26NHgqe__B-+VdAmCQw@mail.gmail.com>
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



On 3/17/22 06:25, Rafael J. Wysocki wrote:
> On Tue, Mar 15, 2022 at 3:41 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> __setup() handlers should return 1 to obsolete_checksetup() in
>> init/main.c to indicate that the boot option has been handled.
>> A return of 0 causes the boot option/value to be listed as an Unknown
>> kernel parameter and added to init's (limited) environment strings.
>>
>> The __setup() handler interface isn't meant to handle negative return
>> values -- they are non-zero, so they mean "handled" (like a return
>> value of 1 does), but that's just a quirk. So return 1 from
>> parse_pmtmr(). Also print a warning message if kstrtouint() returns
>> an error.
>>
>> Fixes: 6b148507d3d0 ("pmtmr: allow command line override of ioport")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> From: Igor Zhbanov <i.zhbanov@omprussia.ru>
> 
> What does this From tag mean?

Well shucks. That should be "Reported-by: Igor", like it is in all of the
other __setup handler fixing patches.
I don't know how that happened.
I'll send a v4....

thanks.

> 
>> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> ---
>> v3: also cc: linux-acpi (Rafael)
>> v2: correct the Fixes: tag (Dan Carpenter)
>>
>>  drivers/clocksource/acpi_pm.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20220315.orig/drivers/clocksource/acpi_pm.c
>> +++ linux-next-20220315/drivers/clocksource/acpi_pm.c
>> @@ -229,8 +229,10 @@ static int __init parse_pmtmr(char *arg)
>>         int ret;
>>
>>         ret = kstrtouint(arg, 16, &base);
>> -       if (ret)
>> -               return ret;
>> +       if (ret) {
>> +               pr_warn("PMTMR: invalid 'pmtmr=' value: '%s'\n", arg);
>> +               return 1;
>> +       }
>>
>>         pr_info("PMTMR IOPort override: 0x%04x -> 0x%04x\n", pmtmr_ioport,
>>                 base);

-- 
~Randy
