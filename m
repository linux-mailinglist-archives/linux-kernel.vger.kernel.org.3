Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607B0461710
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244699AbhK2NzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:55:20 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55818 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238715AbhK2NxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638193793; x=1669729793;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=AjNlHkQhieFspKATbLnIUNoPpyvk2lFtejCtDPm1ES8=;
  b=w17fMPBA5DQDjPlDWwZ4rVvjUZg1V9TyvAVlSiEsRXnifdColUgczQiM
   Qdsq+PfqszWqZKekrMdaRQJ6nnj9QWxkOKzOCyDMYDB8ZaOqPiLtUpn4d
   SQAy2RHPDG3/8/yV1t48eAV8XNDQoUce0kY2lJmuROFxND4ovePDcjEAt
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Nov 2021 05:49:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 05:49:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 05:49:52 -0800
Received: from [10.50.44.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 29 Nov
 2021 05:49:48 -0800
Message-ID: <466449a1-36da-aaa9-7e4f-477f36b52c9e@quicinc.com>
Date:   Mon, 29 Nov 2021 19:19:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv4 2/2] arm64/io: Add a header for mmio access
 instrumentation
Content-Language: en-US
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <quic_psodagud@quicinc.com>, "Marc Zyngier" <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <cover.1636973694.git.quic_saipraka@quicinc.com>
 <9396fbdc415a3096ab271868960372b21479e4fb.1636973694.git.quic_saipraka@quicinc.com>
 <CAK8P3a2Bp4LP7C1-XLKvjyxV-e1vrHb-=3zpm75CRgPYNbY2jA@mail.gmail.com>
 <b07e339c-530d-683c-c626-14b73b42e72a@quicinc.com>
 <1609f1f7-6f61-6e17-d907-c526f09bffe5@quicinc.com>
 <CAK8P3a1KxJFwgock3XiRDZYzT=5PZ=Hsh_8uFv9heoa1rwNqtA@mail.gmail.com>
 <9ef8b483-f15f-eda8-d430-2d01e6cad70e@quicinc.com>
 <CAK8P3a0Zo+PTGAAvisAZamfLUm1ToGZpmHDn-Xk0Eo8TTRGyZg@mail.gmail.com>
 <4ed41054-3868-d5e2-9958-56250b7f9be0@quicinc.com>
 <CAK8P3a07sMdR9NUz5AOJk+O-op9qLU_PjnhvqvTz9xrHE7NXEg@mail.gmail.com>
 <d216f201-183f-c253-495d-1d9203141a63@quicinc.com>
In-Reply-To: <d216f201-183f-c253-495d-1d9203141a63@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 11/22/2021 9:13 PM, Sai Prakash Ranjan wrote:
> On 11/22/2021 9:05 PM, Arnd Bergmann wrote:
>> On Mon, Nov 22, 2021 at 3:59 PM Sai Prakash Ranjan
>> <quic_saipraka@quicinc.com> wrote:
>>>>> And if we do move this instrumentation to asm-generic/io.h, how will
>>>>> that be executed since
>>>>> the arch specifc read{b,w,l,q} overrides this generic version?
>>>> As I understand it, your version also requires architecture specific
>>>> changes, so that would be the same: it only works for architectures
>>>> that get the definition of readl()/readl_relaxed()/inl()/... from
>>>> include/asm-generic/io.h and only override the __raw version. Arnd
>>> Sorry, I didn't get this part, so  I am trying this on ARM64:
>>>
>>> arm64/include/asm/io.h has read{b,l,w,q} defined.
>>> include/asm-generic/io.h has below:
>>>     #ifndef readl
>>>     #define readl readl
>>>     static inline u32 readl(const volatile void __iomem *addr)
>>>
>>> and we include asm-generic/io.h in arm64/include/asm/io.h at the end
>>> after the definitions for arm64 mmio accesors.
>>> So arch implementation here overrides generic ones as I see it, am I
>>> missing something? I even confirmed this
>>> with some trace_printk to generic and arch specific definitions of 
>>> readl
>>> and I see arch specific ones being called.
>> Ah, you are right that the arm64 version currently has custom 
>> definitions
>> of the high-level interfaces. These predate the introduction of the
>> __io_{p,}{b,a}{r,w} macros and are currently only used on risc-v.
>>
>> I think in this case you should start by changing arm64 to use the
>> generic readl() etc definitions, by removing the extra definitions and
>> using
>>
>> #define __io_ar(v) __iormb(__v)
>> #define __io_bw() dma_wmb()
>>
>>
>
> Sure, will do that.

I got the callback version implemented as suggested by you to compare 
the overall size and performance
with the inline version and apparently the size increased more in case 
of callback version when compared to
inline version. As for the performance, I ran some basic dd tests and 
sysbench and didn't see any noticeable
difference between the two implementations.

**Inline version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
$ size vmlinux
    text                   data                    bss dec             
hex         filename
23884219        14284468         532568 38701255        24e88c7 vmlinux

**Callback version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
$ size vmlinux
    text                  data                     bss dec               
        hex        filename
24108179        14279596         532568 38920343        251e097 vmlinux

$ ./scripts/bloat-o-meter inline-vmlinux callback-vmlinux
add/remove: 8/3 grow/shrink: 4889/89 up/down: 242244/-11564 (230680)
Total: Before=25812612, After=26043292, chg +0.89%

Note: I had arm64 move to asm-generic high level accessors in both 
versions which I plan to post together but
not included in below links,

For your reference, here are the 2 versions of the patches,
  Inline version - 
https://github.com/saiprakash-ranjan/RTB-Patches/blob/main/0001-asm-generic-io-Add-logging-support-for-MMIO-accessor.patch
  Callback version - 
https://github.com/saiprakash-ranjan/RTB-Patches/blob/main/0001-asm-generic-io-Add-callback-based-MMIO-logging-suppo.patch

Couple of things noted in callback version which didn't look quite good 
was that it needed some way to register the
callbacks and need to use some initcall (core_initcall used) as 
implemented in above patch but that would probably
mean we would lose some register logging(if there is some) in between 
early_initcall(which is when trace events get
enabled) and this trace_readwrite core_initcall. Another thing I noticed 
that since we now move to callback based
implementations, the caller info is somewhat inaccurate when compared to 
inline version.

Also regarding your earlier comment on inline versions being possibly 
problematic on lower memory systems, enabling
Ftrace itself is making a considerable size difference and in such 
systems ftrace wouldn't be enabled which implicitly means
MMIO logging which are based on trace events will be disabled anyways.

Here is the size delta with FTRACE enabled and disabled with arm64 
defconfig without MMIO logging support:
$ ./scripts/bloat-o-meter ftrace-disabled-vmlinux ftrace-enabled-vmlinux
add/remove: 8/3 grow/shrink: 4889/89 up/down: 242244/-11564 (230680)
Total: Before=22865837, After=25215198, chg +10.27%

Given all this, I would prefer inline versions in asm-generic high level 
accessors, let me know what you think.

Thanks,
Sai
