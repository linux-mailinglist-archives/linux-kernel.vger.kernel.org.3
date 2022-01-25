Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DF249B536
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355183AbiAYNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:39:16 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15156 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1577561AbiAYNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643117742; x=1674653742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6QOS2vhkzpOd+F1HWVgj+YzEw7rbBdqchftQpFVFphk=;
  b=kEYPqA8PMpG0Oo1+p4smhBxHXU2CJfllTHdvxIgXKFMZgNg8RgMa+ZAW
   aBuFJsTh+YqbLyURmShvT0eJmkgXp+oBJS75XfLgKoRMxbc9dXCFmDpUP
   c+2pG4p16VAmn33+e15WAgg0v6GxBICZY4TicFch8dLR1/L+YLRxdfzso
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jan 2022 05:35:37 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 05:35:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 05:35:36 -0800
Received: from [10.50.13.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 25 Jan
 2022 05:35:32 -0800
Message-ID: <dc36531d-0e03-94f3-3e77-0108fbe41e63@quicinc.com>
Date:   Tue, 25 Jan 2022 19:05:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv9 2/5] irqchip/tegra: Fix overflow implicit truncation
 warnings
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <cover.1642482334.git.quic_saipraka@quicinc.com>
 <2cd67f7eee96e062ea479b7406799f7a2daa5b1b.1642482334.git.quic_saipraka@quicinc.com>
 <8735lc88n9.wl-maz@kernel.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <8735lc88n9.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/2022 3:00 PM, Marc Zyngier wrote:
> On Mon, 24 Jan 2022 06:33:31 +0000,
> Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:
>> Fix -Woverflow warnings for tegra irqchip driver which is a result
>> of moving arm64 custom MMIO accessor macros to asm-generic function
>> implementations giving a bonus type-checking now and uncovering these
>> overflow warnings.
>>
>> drivers/irqchip/irq-tegra.c: In function ‘tegra_ictlr_suspend’:
>> drivers/irqchip/irq-tegra.c:151:18: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>     writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
>>                    ^
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
>>   drivers/irqchip/irq-tegra.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
>> index e1f771c72fc4..9e4e5b39c701 100644
>> --- a/drivers/irqchip/irq-tegra.c
>> +++ b/drivers/irqchip/irq-tegra.c
>> @@ -148,10 +148,10 @@ static int tegra_ictlr_suspend(void)
>>   		lic->cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
>>   
>>   		/* Disable COP interrupts */
>> -		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
>> +		writel_relaxed(~0u, ictlr + ICTLR_COP_IER_CLR);
> Aside from the 'l' in writel really meaning 'long' (a historical
> artefact), it would probably be better to lift the ambiguity entirely
> and write this as GENMASK(31, 0), making it clear what is being set,
> no matter what the revision of the architecture is (this driver also
> works on 32bit machines).
>

Sure, I will make this change.

Thanks,
Sai
