Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF57854B39E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbiFNOj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiFNOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:39:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E2220C8;
        Tue, 14 Jun 2022 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655217560; x=1686753560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yH+tzf1aySvEFk9FYhJWBPUJm41J5mLUUCXkxP0y2x8=;
  b=dK7BBxo1vhPl0BAJn7sKLYLftlyJ30u7cSxmepq/okFpDuWw6nAyjLDW
   O9xifAMtRSG4xeW4mT3udsLTIGCZ9hDeumzIMgiyycoJjavOlp5IsXAIe
   hx606qOoFAzhxB0mBiWD7XEfHXd+80B9zZ0o1vfZNbIsGqVTc2MRjYFyu
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jun 2022 07:39:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 07:39:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 07:39:19 -0700
Received: from [10.50.24.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 07:39:15 -0700
Message-ID: <e9472213-7127-9265-88d2-6f58a97c76d2@quicinc.com>
Date:   Tue, 14 Jun 2022 20:09:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv15 5/9] lib: Add register read/write tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <catalin.marinas@arm.com>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>,
        <quic_psodagud@quicinc.com>, <quic_tsoni@quicinc.com>,
        <will@kernel.org>
References: <cover.1652891705.git.quic_saipraka@quicinc.com>
 <f6d1b9e9d70968b506bdfd1b77129cb751b9df9d.1652891705.git.quic_saipraka@quicinc.com>
 <20220614103205.2d134546@gandalf.local.home>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220614103205.2d134546@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/2022 8:02 PM, Steven Rostedt wrote:
> On Wed, 18 May 2022 22:14:14 +0530
> Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:
>
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
>> ---
>  From a tracing point of view, I do not see anything wrong with this patch.
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve

Thanks Steve.

Hi Arnd, I hope we can take this series in your tree or let me know if anything else is pending?

Thanks,
Sai
