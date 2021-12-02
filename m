Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB64663E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358019AbhLBMrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:47:20 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:30342 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358008AbhLBMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638449034; x=1669985034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VUzivPX3XOCmHxqtJdx5tC1p0TotXf3F0/fM/rFPnFQ=;
  b=c1MgWBu+WS6RE26sjfvyKioivnpZ9zHqtVa+FgjVg7k3yeih1FIhoYrR
   g8X1FRwdeZ/MJDWp55G6KeKuHjrBS2Fk1GpP5gjvsEI5+4gdRmgs6RIFE
   tZxXyJlhLc7tPwu4O9KKrKjJjFP2hGXMMPGq/VG4RWwfrByCa8rolKAqq
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Dec 2021 04:43:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 04:43:52 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 04:43:51 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 2 Dec 2021
 04:43:49 -0800
Message-ID: <c6f9beb7-98ec-4a5a-a887-b8841c982b04@quicinc.com>
Date:   Thu, 2 Dec 2021 20:43:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RESEND PATCH v3 01/10] spmi: pmic-arb: handle spurious interrupt
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <tglx@linutronix.de>, <maz@kernel.org>,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638403212-29265-2-git-send-email-quic_fenglinw@quicinc.com>
 <829e2ce0-888a-b859-9e94-4b92d6c10d4a@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <829e2ce0-888a-b859-9e94-4b92d6c10d4a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/2 10:39, Bryan O'Donoghue wrote:
> On 02/12/2021 00:00, Fenglin Wu wrote:
>> Call handle_bad_irq() for handling spurious interrupt. While at it,
>> add an error print in cleanup_irq() for any spurious interrupt which
>> is fired but not having interrupt handler registered.
>
> Being excruciatingly pedantic, I'd suggest breaking this up into two 
> patches, one for the ratelimit one for the logical change to the irq 
> handling flow.
>
The original patch actually only prints a message for any interrupt 
that's fired but not
registered, and it got reviewed and commented to add logic to handle 
spurious interrupt
like this.I might have misunderstood the comments so I combined them 
together, I agreed
theyare not very related and I can separate them and send them again.
Thanks.
>> Signed-off-by: Abhijeet Dharmapurikar<adharmap@codeaurora.org>
>> Signed-off-by: David Collins<collinsd@codeaurora.org>
>> Signed-off-by: Fenglin Wu<quic_fenglinw@quicinc.com>
>> ---
>>   drivers/spmi/spmi-pmic-arb.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
>> index bbbd311..da629cc 100644
>> --- a/drivers/spmi/spmi-pmic-arb.c
>> +++ b/drivers/spmi/spmi-pmic-arb.c
>> @@ -489,6 +489,8 @@ static void cleanup_irq(struct spmi_pmic_arb 
>> *pmic_arb, u16 apid, int id)
>>       u8 per = ppid & 0xFF;
>>       u8 irq_mask = BIT(id);
>>   +    dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d 
>> sid=0x%x per=0x%x irq=%d\n",
>> +            __func__, apid, sid, per, id);
>>       writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, 
>> apid));
>>         if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, 
>> sid,
>> @@ -502,10 +504,10 @@ static void cleanup_irq(struct spmi_pmic_arb 
>> *pmic_arb, u16 apid, int id)
>>                   irq_mask, ppid);
>>   }
>>   -static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 
>> apid)
>> +static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
>>   {
>>       unsigned int irq;
>> -    u32 status, id;
>> +    u32 status, id, handled = 0;
>
> If handled were an int
>
>>       u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
>>       u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
>>   @@ -520,7 +522,10 @@ static void periph_interrupt(struct 
>> spmi_pmic_arb *pmic_arb, u16 apid)
>>               continue;
>>           }
>>           generic_handle_irq(irq);
>> +        handled++;
>>       }
>> +
>> +    return (handled) ? 0 : -EINVAL;
>>   }
>
> you could "return handled;" and then have
>
> if (periph_interrupt(pmic_arb, apid))
>     handled++;
>
> later on
>
> Its not important I suppose but please do at least break this up into 
> two separate patches.
>
Got it, will update it. Thanks
> ---
> bod
