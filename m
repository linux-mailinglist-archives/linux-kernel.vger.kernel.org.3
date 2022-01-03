Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1110482E37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 06:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiACFlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 00:41:12 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62605 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbiACFlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 00:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641188471; x=1672724471;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ZUtxtdz4uH9rLeuOq9hfgHex7zCJpBmeeoNCCU1r+Yg=;
  b=bGpA/ZjEr0fqXHlNf3iTnS3R5y1AF0JK1pAgJd+WoxQtu6URBeg5anGE
   1jelyTSDk2+oxT41QPt7ing1ukKum1YuZpfqWsTpMKf2U3+bgj51FijkS
   /3pVwi1EhPfK/y1AQ+AH2cGXjShBZ98B/7dV+ZHfUpBLvtTrMj5r7II5H
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jan 2022 21:41:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2022 21:41:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 2 Jan 2022 21:41:10 -0800
Received: from [10.50.54.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 2 Jan 2022
 21:41:06 -0800
Message-ID: <4009226e-76bf-6e37-65be-8942ef7126df@quicinc.com>
Date:   Mon, 3 Jan 2022 11:11:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv6 0/5] tracing/rwmmio/arm64: Add support to trace register
 reads/writes
Content-Language: en-US
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
 <93ef32a5-013a-fdcf-11bb-6f3c9bc34628@quicinc.com>
In-Reply-To: <93ef32a5-013a-fdcf-11bb-6f3c9bc34628@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2021 8:58 AM, Sai Prakash Ranjan wrote:
> Hi Arnd,
>
> On 12/7/2021 12:24 PM, Sai Prakash Ranjan wrote:
>> Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
>> are typically used to read/write from/to memory mapped registers
>> and can cause hangs or some undefined behaviour in following cases,
>>
>> * If the access to the register space is unclocked, for example: if
>>    there is an access to multimedia(MM) block registers without MM
>>    clocks.
>>
>> * If the register space is protected and not set to be accessible from
>>    non-secure world, for example: only EL3 (EL: Exception level) access
>>    is allowed and any EL2/EL1 access is forbidden.
>>
>> * If xPU(memory/register protection units) is controlling access to
>>    certain memory/register space for specific clients.
>>
>> and more...
>>
>> Such cases usually results in instant reboot/SErrors/NOC or interconnect
>> hangs and tracing these register accesses can be very helpful to debug
>> such issues during initial development stages and also in later stages.
>>
>> So use ftrace trace events to log such MMIO register accesses which
>> provides rich feature set such as early enablement of trace events,
>> filtering capability, dumping ftrace logs on console and many more.
>>
>> Sample output:
>>
>> rwmmio_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 
>> val=0xa0d5d addr=0xfffffbfffdbff700
>> rwmmio_post_write: __qcom_geni_serial_console_write+0x160/0x1e0 
>> width=32 val=0xa0d5d addr=0xfffffbfffdbff700
>> rwmmio_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 
>> addr=0xfffffbfffdbff610
>> rwmmio_post_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 
>> val=0x0 addr=0xfffffbfffdbff610
>>
>> This series is a follow-up for the series [1] and a recent series [2] 
>> making use
>> of both.
>>
>> [1] 
>> https://lore.kernel.org/lkml/cover.1536430404.git.saiprakash.ranjan@codeaurora.org/
>> [2] 
>> https://lore.kernel.org/lkml/1604631386-178312-1-git-send-email-psodagud@codeaurora.org/
>>
>> Note in previous v4 version, Arnd suggested to benchmark and compare 
>> size with callback
>> based implementation, please see [3] for more details on that with 
>> brief comparison below.
>>
>>
>> **Inline version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
>> $ size vmlinux
>>     text           data             bss     dec hex         filename
>>   23884219        14284468         532568 38701255 24e88c7        
>> vmlinux
>>
>> **Callback version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
>> $ size vmlinux
>>      text          data             bss     dec hex        filename
>>   24108179        14279596         532568 38920343 251e097       vmlinux
>>
>> $ ./scripts/bloat-o-meter inline-vmlinux callback-vmlinux
>> add/remove: 8/3 grow/shrink: 4889/89 up/down: 242244/-11564 (230680)
>> Total: Before=25812612, After=26043292, chg +0.89%
>>
>> [3] 
>> https://lore.kernel.org/lkml/466449a1-36da-aaa9-7e4f-477f36b52c9e@quicinc.com/
>>
>> Changes in v6:
>>   * Implemented suggestions by Arnd Bergmann:
>>     - Use arch independent IO barriers in arm64/asm
>>     - Add ARCH_HAVE_TRACE_MMIO_ACCESS
>>     - Add post read and post write logging support
>>     - Remove tracepoint_active check
>>   * Fix build error reported by kernel test robot.
>>
>> Changes in v5:
>>   * Move arm64 to use asm-generic provided high level MMIO accessors 
>> (Arnd).
>>   * Add inline logging for MMIO relaxed and non-relaxed accessors.
>>   * Move nVHE KVM comment to makefile (Marc).
>>   * Fix overflow warning due to switch to inline accessors instead of 
>> macro.
>>   * Modify trace event field to include caller and parent details for 
>> more detailed logs.
>>
>> Changes in v4:
>>   * Drop dynamic debug based filter support since that will be 
>> developed later with
>>     the help from Steven (Ftrace maintainer).
>>   * Drop value passed to writel as it is causing hangs when tracing 
>> is enabled.
>>   * Code cleanup for trace event as suggested by Steven for earlier 
>> version.
>>   * Fixed some build errors reported by 0-day bot.
>>
>> Changes in v3:
>>   * Create a generic mmio header for instrumented version (Earlier 
>> suggested in [1]
>>     by Will Deacon and recently [2] by Greg to have a generic version 
>> first).
>>   * Add dynamic debug support to filter out traces which can be very 
>> useful for targeted
>>     debugging specific to subsystems or drivers.
>>   * Few modifications to the rwmmio trace event fields to include the 
>> mmio width and print
>>     addresses in hex.
>>   * Rewrote commit msg to explain some more about usecases.
>>
>> Prasad Sodagudi (1):
>>    tracing: Add register read/write tracing support
>>
>> Sai Prakash Ranjan (4):
>>    arm64: io: Use asm-generic high level MMIO accessors
>>    irqchip/tegra: Fix overflow implicit truncation warnings
>>    drm/meson: Fix overflow implicit truncation warnings
>>    asm-generic/io: Add logging support for MMIO accessors
>>
>>   arch/Kconfig                      |   3 +
>>   arch/arm64/Kconfig                |   1 +
>>   arch/arm64/include/asm/io.h       |  41 +++--------
>>   arch/arm64/kvm/hyp/nvhe/Makefile  |   7 +-
>>   drivers/gpu/drm/meson/meson_viu.c |  22 +++---
>>   drivers/irqchip/irq-tegra.c       |  10 +--
>>   include/asm-generic/io.h          |  81 +++++++++++++++++++--
>>   include/trace/events/rwmmio.h     | 112 ++++++++++++++++++++++++++++++
>>   kernel/trace/Kconfig              |   7 ++
>>   kernel/trace/Makefile             |   1 +
>>   kernel/trace/trace_readwrite.c    |  47 +++++++++++++
>>   11 files changed, 278 insertions(+), 54 deletions(-)
>>   create mode 100644 include/trace/events/rwmmio.h
>>   create mode 100644 kernel/trace/trace_readwrite.c
>>
>
> Does this version look good to you? From the other mail thread it 
> seems Catalin
> is ok with your suggested change. Kernel test robot hasn't come with 
> any build error
> reports so far, I have fixed the previous reported one in meson drm 
> driver.
>
> Thanks,
> Sai

Any more comments for this version?

Thanks,
Sai
