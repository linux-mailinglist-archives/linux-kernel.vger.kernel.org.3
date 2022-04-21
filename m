Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CBC5094E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383767AbiDUCDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383762AbiDUCDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:03:16 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE675BF63;
        Wed, 20 Apr 2022 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650506429; x=1682042429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zXMWQITVh0r0GmBQz9Pe/u3r7jSNrLigmueSoCH3SF0=;
  b=SKQfD/subJHEyskX0L9l0K0a/dlaWJYeu6UcqBithx8o5FTsAVX2Rs2B
   dxLSuuGTiEu2Ca1X6EXNoSVi+bFmkEeF4Vi8xm+4AmqPPJMXnI/wWGGJV
   hLEvBVIL6E1xCcwmNEjs/8t1w+5vOj92/SGGkjmX+KpygOgEbklUloMFG
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Apr 2022 19:00:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 19:00:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 19:00:27 -0700
Received: from [10.50.28.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Apr
 2022 19:00:23 -0700
Message-ID: <bb99b615-cc76-9591-a610-fb4841d41d62@quicinc.com>
Date:   Thu, 21 Apr 2022 07:30:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv10 0/6] lib/rwmmio/arm64: Add support to trace register
 reads/writes
Content-Language: en-US
To:     <arnd@arndb.de>
CC:     <catalin.marinas@arm.com>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <rostedt@goodmis.org>, <will@kernel.org>
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
 <20220408111707.2488-1-quic_saipraka@quicinc.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220408111707.2488-1-quic_saipraka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 4/8/2022 4:47 PM, Sai Prakash Ranjan wrote:
> Hi Arnd,
>
> On 2/24/2022 11:37 AM, Sai Prakash Ranjan wrote:
>> Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
>> are typically used to read/write from/to memory mapped registers
>> and can cause hangs or some undefined behaviour in following cases,
>>
>> * If the access to the register space is unclocked, for example: if
>>    there is an access to multimedia(MM) block registers without MM
>>    clocks.
>>
>> * If the register space is protected and not set to be accessible from
>>    non-secure world, for example: only EL3 (EL: Exception level) access
>>    is allowed and any EL2/EL1 access is forbidden.
>>
>> * If xPU(memory/register protection units) is controlling access to
>>    certain memory/register space for specific clients.
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
>> rwmmio_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
>> rwmmio_post_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
>> rwmmio_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 addr=0xfffffbfffdbff610
>> rwmmio_post_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 val=0x0 addr=0xfffffbfffdbff610
>>
>> This series is a follow-up for the series [1] and a recent series [2] making use
>> of both.
>>
>> [1] https://lore.kernel.org/lkml/cover.1536430404.git.saiprakash.ranjan@codeaurora.org/
>> [2] https://lore.kernel.org/lkml/1604631386-178312-1-git-send-email-psodagud@codeaurora.org/
>>
>> Note in previous v4 version, Arnd suggested to benchmark and compare size with callback
>> based implementation, please see [3] for more details on that with brief comparison below.
>>
>>
>> **Inline version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
>> $ size vmlinux
>>     text           data             bss     dec             hex         filename
>>   23884219        14284468         532568 38701255        24e88c7        vmlinux
>>
>> **Callback version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
>> $ size vmlinux
>>      text          data             bss     dec             hex        filename
>>   24108179        14279596         532568 38920343        251e097       vmlinux
>>
>> $ ./scripts/bloat-o-meter inline-vmlinux callback-vmlinux
>> add/remove: 8/3 grow/shrink: 4889/89 up/down: 242244/-11564 (230680)
>> Total: Before=25812612, After=26043292, chg +0.89%
>>
>> [3] https://lore.kernel.org/lkml/466449a1-36da-aaa9-7e4f-477f36b52c9e@quicinc.com/
>>
>> Changes in v10:
>>   * Use GENMASK(31, 0) for -Woverflow warning in irqchip tegra driver (Marc).
>>   * Convert ETM4x ARM64 driver to use asm-generic IO memory barriers (Catalin).
>>   * Collect ack from Catalin for arm64 change.
>>
>> Changes in v9:
>>   * Use TRACE_EVENT_CLASS for rwmmio_write and post_write (Steven Rostedt).
>>
>> Changes in v8:
>>   * Fix build error reported by kernel test robot.
>>
>> Changes in v7:
>>   * Use lib/ instead of kernel/trace/ based on review comment by Steven Rostedt.
>>
>> Changes in v6:
>>   * Implemented suggestions by Arnd Bergmann:
>>     - Use arch independent IO barriers in arm64/asm
>>     - Add ARCH_HAVE_TRACE_MMIO_ACCESS
>>     - Add post read and post write logging support
>>     - Remove tracepoint_active check
>>   * Fix build error reported by kernel test robot.
>>
>> Changes in v5:
>>   * Move arm64 to use asm-generic provided high level MMIO accessors (Arnd).
>>   * Add inline logging for MMIO relaxed and non-relaxed accessors.
>>   * Move nVHE KVM comment to makefile (Marc).
>>   * Fix overflow warning due to switch to inline accessors instead of macro.
>>   * Modify trace event field to include caller and parent details for more detailed logs.
>>
>> Changes in v4:
>>   * Drop dynamic debug based filter support since that will be developed later with
>>     the help from Steven (Ftrace maintainer).
>>   * Drop value passed to writel as it is causing hangs when tracing is enabled.
>>   * Code cleanup for trace event as suggested by Steven for earlier version.
>>   * Fixed some build errors reported by 0-day bot.
>>
>> Changes in v3:
>>   * Create a generic mmio header for instrumented version (Earlier suggested in [1]
>>     by Will Deacon and recently [2] by Greg to have a generic version first).
>>   * Add dynamic debug support to filter out traces which can be very useful for targeted
>>     debugging specific to subsystems or drivers.
>>   * Few modifications to the rwmmio trace event fields to include the mmio width and print
>>     addresses in hex.
>>   * Rewrote commit msg to explain some more about usecases.
>>
>> Prasad Sodagudi (1):
>>    lib: Add register read/write tracing support
>>
>> Sai Prakash Ranjan (5):
>>    arm64: io: Use asm-generic high level MMIO accessors
>>    coresight: etm4x: Use asm-generic IO memory barriers
>>    irqchip/tegra: Fix overflow implicit truncation warnings
>>    drm/meson: Fix overflow implicit truncation warnings
>>    asm-generic/io: Add logging support for MMIO accessors
>>
>>   arch/Kconfig                                  |  3 +
>>   arch/arm64/Kconfig                            |  1 +
>>   arch/arm64/include/asm/io.h                   | 41 ++------
>>   arch/arm64/kvm/hyp/nvhe/Makefile              |  7 +-
>>   drivers/gpu/drm/meson/meson_viu.c             | 22 ++---
>>   .../coresight/coresight-etm4x-core.c          |  8 +-
>>   drivers/hwtracing/coresight/coresight-etm4x.h |  8 +-
>>   drivers/irqchip/irq-tegra.c                   | 10 +-
>>   include/asm-generic/io.h                      | 82 +++++++++++++++-
>>   include/trace/events/rwmmio.h                 | 97 +++++++++++++++++++
>>   lib/Kconfig                                   |  7 ++
>>   lib/Makefile                                  |  2 +
>>   lib/trace_readwrite.c                         | 47 +++++++++
>>   13 files changed, 273 insertions(+), 62 deletions(-)
>>   create mode 100644 include/trace/events/rwmmio.h
>>   create mode 100644 lib/trace_readwrite.c
>>
>>
>> base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07
> Gentle ping, could you please take a look at this, would appreciate your reviews.
>

Gentle Ping !!

Thanks,
Sai
