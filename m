Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29104F0DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbiDDDjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiDDDjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:39:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623D39804;
        Sun,  3 Apr 2022 20:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OsXUKgbByLP4TKkrJlWQ1fr5jaRQNDMGQxiR3xsP4gk=; b=j6fT7PRt5ERAIShbgcp9AWcOZ8
        1YgOr7nwAS2RAmAQcosXBk6WyXYfaTa3yrKIqUuQutil8rQsKXg3gbCC2S74KQ0WHmtnkzZkbTe55
        mAUjjP71kz+ZiUKCeljZ8AJEvqT1XKzSCcFzQtvpNe3onoQYF9oPs8zoZsexQHMQQDqfnOgq4iLoc
        RnhhvmxyXNnpX1/ROM7g+xtljRMC0QZv4V5vtD9M3kQwsvkkf2PTnzJm4UggfcECMvf8pe3bGauEv
        vCCp3k6Vv5P4fF84ahq0nzeE4dfY4rYqX8kr9LV8iBiTioqiN8FMLQI8otSNI9OJo2XBQR1P8l4Nv
        Tv+RzHYg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbDWT-005O7U-1b; Mon, 04 Apr 2022 03:36:57 +0000
Message-ID: <61196f88-7306-058d-7b9b-21e32f1fca92@infradead.org>
Date:   Sun, 3 Apr 2022 20:36:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] cpuidle: riscv: support non-SMP config
Content-Language: en-US
To:     Anup Patel <anup@brainfault.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20220403031355.20894-1-rdunlap@infradead.org>
 <CAAhSdy2CJMeD_JhvwkEKShtYxyLGVRme8rE4cmCcDFfO90_D-Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAAhSdy2CJMeD_JhvwkEKShtYxyLGVRme8rE4cmCcDFfO90_D-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/22 20:05, Anup Patel wrote:
> (Removed my WDC email because it does not exist anymore)
> 
> On Sun, Apr 3, 2022 at 8:44 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Add <asm/smp.h> for cpuid_to_hartid_map etc.
>> This is needed for both SMP and non-SMP builds, but not having it
>> causes a build error for non-SMP:
>>
>> drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_init_cpu':
>> drivers/cpuidle/cpuidle-riscv-sbi.c:350:26: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror=implicit-function-declaration]
>>
>> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Anup Patel <anup.patel@wdc.com>
>> Cc: Anup Patel <anup@brainfault.org>
>> Cc: Anup Patel <apatel@ventanamicro.com>
>> Cc: Atish Patra <atishp@rivosinc.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: Palmer Dabbelt <palmer@rivosinc.com>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> ---
>>  drivers/cpuidle/cpuidle-riscv-sbi.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- linux-next-20220401.orig/drivers/cpuidle/cpuidle-riscv-sbi.c
>> +++ linux-next-20220401/drivers/cpuidle/cpuidle-riscv-sbi.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <asm/cpuidle.h>
>>  #include <asm/sbi.h>
>> +#include <asm/smp.h>
> 
> I suggest include linux/smp.h here instead of asm/smp.h
> 
> Otherwise it looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> 

Yeah, checkpatch also suggested that but it does not work.
Yes, I tested it.

linux/smp.h only #includes <asm/smp.h> if CONFIG_SMP is enabled,
and this patch needs <asm/smp.h> for the non-SMP case.

> 
>>  #include <asm/suspend.h>
>>
>>  #include "dt_idle_states.h"

thanks.
-- 
~Randy
