Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197E45129E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiD1DTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiD1DTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:19:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF03189;
        Wed, 27 Apr 2022 20:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651115784; x=1682651784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OzLHedGGs0p8Rkynak6Kv3mvYKpyq/SCmi4nw9hwu+U=;
  b=ayglFXADbyBsMoLPXTsZHxrSqDqrYrcZ0Tl/xUz8X8JkLBhalW6oxOPp
   RdwY8auoxX9du1CBrR4PsDt/maSjPVIg13w/F48VR7RmJEdWdcA2O3nwF
   qj//kpTdJeUymxPscWd28i0AJVMq+9mMK+ZJKFo6/psEnUT4mqB72B2xb
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 20:16:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 20:16:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 20:16:23 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 20:16:19 -0700
Message-ID: <2cb26bc2-704b-86df-15ed-8c18f81addaf@quicinc.com>
Date:   Thu, 28 Apr 2022 08:46:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv10 5/6] lib: Add register read/write tracing support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
 <8cf9304d9941c25d920c4835cbc624ff5c2ac2cb.1644824638.git.quic_saipraka@quicinc.com>
 <CAK8P3a1WwghVToFBNZMpG7Wcji_k3CebK3--LL8YNJs_Wu3rBQ@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a1WwghVToFBNZMpG7Wcji_k3CebK3--LL8YNJs_Wu3rBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 4/27/2022 9:44 PM, Arnd Bergmann wrote:
> On Thu, Feb 24, 2022 at 7:07 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> From: Prasad Sodagudi <psodagud@codeaurora.org>
>>
>> Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
>> are typically used to read/write from/to memory mapped registers
>> and can cause hangs or some undefined behaviour in following few
>> cases,
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
>> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
>> Co-developed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> I think this is ok in general. I saw that Steve had a minor comment, and
> I suppose you could have just resent the same patches with a fixup in order
> to have me pick it up into the asm-generic tree for 5.19.

I had it ready the same day Steve gave the comment :) but given there was no further
reviews on other patches, I thought of slowing down the posting of new versions.
I will send v11 now.

> There is one more thing that I saw looking through this patch again: the
> address you print is the virtual __iomem token, but it might be more
> valuable to have the physical address instead, which can be looked up
> in the devicetree to know which register is affected.
>
> There is a small extra cost to walk the page table, and I'm not sure
> if we actually have an interface for it (vmalloc_to_page is almost
> what we want, but it returns an invalid page pointer). Any suggestions
> on this?
>
>

Right, it would be useful but currently we rely on the caller information (the function name and
the offset) to identify who writes to the location and then post process to identify the register
written based on it. I am also not aware of the interface for page table walk and the walk on this
hot trace path (note that we are capturing every register read/write) would slow down the system
further.

Even in the internal versions, we get the physical address postmortem from the parser tool [1].

[1] https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/tools/tree/linux-ramdump-parser-v2/parsers/rtb.py#n72

Given that we can add fields to this tracepoint without breaking ABI, we can probably add this addon
at a later point.

Thanks,
Sai
