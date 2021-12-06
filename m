Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E8469458
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhLFKzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:55:52 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:50508 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241722AbhLFKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638787943; x=1670323943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GvwCtKXPvY1WJrhYMRwHFLwl0MUYnLopMeATFz4bWso=;
  b=t6o7JcJz4TxN6P4zK+YIUu7hyG+Snmgc798iaLRnIC41PRhUnyhaJvre
   +MHudxZGlRBfcgt7ALDKBF4xdk4fH63zf2osWoEssJnbxXncxt3zg6XJe
   ZQ4/NGpxlM9PApCt7DE8IWMB5GuTBZnnkghN1XrkjYuYWw74Yb+7vAT6R
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Dec 2021 02:52:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 02:52:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 02:52:22 -0800
Received: from [10.50.43.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 02:52:17 -0800
Message-ID: <a97be342-21e3-54f1-ea36-db67747b7a70@quicinc.com>
Date:   Mon, 6 Dec 2021 16:22:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv5 3/4] tracing: Add register read/write tracing support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        <quic_psodagud@quicinc.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a1wOEkoteJRu+qpE0k3gJ0fRnwfn1Zrtcnmgn5wT4yQdw@mail.gmail.com>
 <09a477b7-4219-756d-ed72-96fcdeb6a77b@quicinc.com>
 <CAK8P3a2hoQHTDUs5YNWwrAk2GfD7bFh6ipvgqSttDxNdUX6jyg@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a2hoQHTDUs5YNWwrAk2GfD7bFh6ipvgqSttDxNdUX6jyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2021 4:16 PM, Arnd Bergmann wrote:
> On Mon, Dec 6, 2021 at 11:11 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> On 12/6/2021 2:29 PM, Arnd Bergmann wrote:
>>> On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
>>>> +void log_read_mmio(u8 width, const volatile void __iomem *addr)
>>>> +{
>>>> +       trace_rwmmio_read(CALLER_ADDR0, CALLER_ADDR1, width, addr);
>>>> +}
>>> Here, it may be better to pass the caller address as an argument, I think
>>> CALLER_ADDR1 is not always reliable, though it's possible that it is
>>> in the configurations when this file gets enabled.
>>>
>>>
>> Do you mean that we use __builtin_return_address(0,1) directly here or
>> that I pass __func__ as the argument to log_read/write_mmio or is there
>> some other way to pass the caller address?
> I meant passing CALLER_ADDR0 from readl() down to
> log_read_mmio().
>
>         Arnd

Ah ok, will do that and remove CALLER_ADDR1.

Thanks,
Sai
