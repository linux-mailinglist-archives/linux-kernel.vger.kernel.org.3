Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EC04694CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhLFLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:15:41 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:52862 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242265AbhLFLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638789132; x=1670325132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yw4Zezs+y7lDK2bNlODq+I1zoWPnIUpzHgGlHcO8b1k=;
  b=RnFMhzeEyyF5Y/iBeImCysVIr5ZGxOoBljeJudK+japQCNgzFnQBiqh3
   57X0IgIVCqzB+f+n87Tl+cQdbJFFCMKU+EzwUttNlZnwkahnCndg6bZ2c
   262VByZ0E3w6cvPkKJqwPwNRGuGgWPx0LELGgdTm/EAwiGaYbWjY/hcgJ
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 03:12:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:12:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 03:12:11 -0800
Received: from [10.50.43.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 03:12:06 -0800
Message-ID: <7b2b5888-c2ca-2ca0-8c0c-32128fcb37d2@quicinc.com>
Date:   Mon, 6 Dec 2021 16:42:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv5 1/4] arm64: io: Use asm-generic high level MMIO
 accessors
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
        <quic_psodagud@quicinc.com>
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a2JSSJxs92uEiJQAa0iQOvA6NDuww3+Br5cAxYvXVOOAQ@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a2JSSJxs92uEiJQAa0iQOvA6NDuww3+Br5cAxYvXVOOAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2021 2:20 PM, Arnd Bergmann wrote:
> On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> Remove custom arm64 MMIO accessors read{b,w,l,q} and their relaxed
>> versions in support to use asm-generic ones. Also define arm64
>> barrier macros to override the asm-generic defined barriers.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> This looks correct, but I would change one detail:
>
>> +#define __io_ar(v)             __io_par(v)
>> +#define __io_bw()              __iowmb()
>> +#define __io_br(v)
>> +#define __io_aw(v)
> The default __io_par() is defined in terms of __io_ar(), so it would
> be more logical
> to remove the custom __io_par() and just define __io_ar() here.

Makes sense, will do this.

> I think it would be even better to flip these around and make the low-level
> definitions __io_ar() and __io_bw(), and then defining the arm64 specific
> macros based on those:
>
> /* arm64-specific, don't use in portable drivers */
> #define __iormb(v)     __io_ar(v)
> #define __iowmb()      __io_bw()
> #define __iomb()        dma_mb()
>
>

So __iormb on arm64 has some dummy control dependency stuff as well based on
("arm64: io: Ensure calls to delay routines are ordered against prior 
readX()") and then we would
need to change __iormb definition to __io_ar which doesn't seem like 
__iormb definition to be exact
right?

Thanks,
Sai
