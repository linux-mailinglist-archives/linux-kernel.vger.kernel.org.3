Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D151CF39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388415AbiEFDGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiEFDGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:06:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508063BC5;
        Thu,  5 May 2022 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651806162; x=1683342162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UwxBXbDbn02kQFasQ1SH6bPlx2zViOnP3ih2arb8lVM=;
  b=hXhTCczIfAGnZHcysSPwKM7UuLCntGBIkmbAdvQ5nPOqvQj61KKi7cek
   45og1kU6qjjsJsJtjvwj5YsPRgp879idf5Sp8pgUnjZ5x44NcrtNuzZ9U
   bO0yHvQWaYdT7NDTP2bbKoXA/WZVHm8J9jJBBP9+Gms/6fB+91KPj+Jj7
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 May 2022 20:02:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:02:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 20:02:41 -0700
Received: from [10.50.57.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 20:02:36 -0700
Message-ID: <b44a0e0b-ee86-3b08-0103-3ccee94e3270@quicinc.com>
Date:   Fri, 6 May 2022 08:32:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv14 2/9] coresight: etm4x: Use asm-generic IO memory
 barriers
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, <arnd@arndb.de>,
        <catalin.marinas@arm.com>, <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
 <0d76de0ecc0aa7cb01fd8b8863a8e567abd4410b.1651663123.git.quic_saipraka@quicinc.com>
 <483bb401-13e6-8c52-4b5f-f3c635b9ad46@arm.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <483bb401-13e6-8c52-4b5f-f3c635b9ad46@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 5/6/2022 5:14 AM, Suzuki K Poulose wrote:
> Hi,
>
> On 04/05/2022 12:28, Sai Prakash Ranjan wrote:
>> Per discussion in [1], it was decided to move to using architecture
>> independent/asm-generic IO memory barriers to have just one set of
>> them and deprecate use of arm64 specific IO memory barriers in driver
>> code. So replace current usage of __io_rmb()/__iowmb() in drivers to
>> __io_ar()/__io_bw().
>>
>> [1] https://lore.kernel.org/lkml/CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com/
>>
>
> Looking at the dis-assembly it looks like in effect they are slightly
> different for arm64.
>
> i.e., before this patch we had
>
> "dmb osh{ld/st}"
>
> and after the patch we have :
>
> "dsb {ld/st}"
>
> Is this really what we want ? I don't think this is desirable.
>
> Suzuki
>

No, this is not supposed to happen and I do not see how it could happen.
__io_ar() is defined as __iormb() and __io_bw() is __iowmb().

I checked the disassembly in both case with MMIO trace off/on with __etm4_cpu_save()
as below and saw the same number of "dmb"s.

aarch64-linux-gnu-gdb -batch -ex "disassemble/rs __etm4_cpu_save" vmlinux-without-mmio
aarch64-linux-gnu-gdb -batch -ex "disassemble/rs __etm4_cpu_save" vmlinux-with-mmio

Can you tell me how are you validating if I am missing something?

Thanks,
Sai

>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 8 ++++----
>>   drivers/hwtracing/coresight/coresight-etm4x.h      | 8 ++++----
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 7f416a12000e..81c0faf45b28 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -98,7 +98,7 @@ u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>>       }
>>         if (!_relaxed)
>> -        __iormb(res);    /* Imitate the !relaxed I/O helpers */
>> +        __io_ar(res);    /* Imitate the !relaxed I/O helpers */
>>         return res;
>>   }
>> @@ -106,7 +106,7 @@ u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>>   void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>>   {
>>       if (!_relaxed)
>> -        __iowmb();    /* Imitate the !relaxed I/O helpers */
>> +        __io_bw();    /* Imitate the !relaxed I/O helpers */
>>       if (!_64bit)
>>           val &= GENMASK(31, 0);
>>   @@ -130,7 +130,7 @@ static u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>>       }
>>         if (!_relaxed)
>> -        __iormb(res);    /* Imitate the !relaxed I/O helpers */
>> +        __io_ar(res);    /* Imitate the !relaxed I/O helpers */
>>         return res;
>>   }
>> @@ -138,7 +138,7 @@ static u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>>   static void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>>   {
>>       if (!_relaxed)
>> -        __iowmb();    /* Imitate the !relaxed I/O helpers */
>> +        __io_bw();    /* Imitate the !relaxed I/O helpers */
>>       if (!_64bit)
>>           val &= GENMASK(31, 0);
>>   diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 3c4d69b096ca..f54698731582 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -448,14 +448,14 @@
>>   #define etm4x_read32(csa, offset)                    \
>>       ({                                \
>>           u32 __val = etm4x_relaxed_read32((csa), (offset)); \
>> -        __iormb(__val);                        \
>> +        __io_ar(__val);                        \
>>           __val;                            \
>>        })
>>     #define etm4x_read64(csa, offset)                    \
>>       ({                                \
>>           u64 __val = etm4x_relaxed_read64((csa), (offset)); \
>> -        __iormb(__val);                        \
>> +        __io_ar(__val);                        \
>>           __val;                            \
>>        })
>>   @@ -479,13 +479,13 @@
>>     #define etm4x_write32(csa, val, offset)                    \
>>       do {                                \
>> -        __iowmb();                        \
>> +        __io_bw();                        \
>>           etm4x_relaxed_write32((csa), (val), (offset)); \
>>       } while (0)
>>     #define etm4x_write64(csa, val, offset)                    \
>>       do {                                \
>> -        __iowmb();                        \
>> +        __io_bw();                        \
>>           etm4x_relaxed_write64((csa), (val), (offset)); \
>>       } while (0)
>

