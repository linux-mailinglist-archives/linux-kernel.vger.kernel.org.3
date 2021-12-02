Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7293E466405
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358135AbhLBM4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:56:02 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33166 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhLBMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638449556; x=1669985556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kTXRHtxQamWKYX1ZcqOHF7I6lijmGW768TxL4cvXwAM=;
  b=xrYAEM3q4Q2WlHeaONYjQEXrCaKr4HyRqQ0LRupFi9rwhbcpMbeWJdDZ
   Xg2eFjSqy8iOWU5A6P4qksCYTKlNchEm9hFKYaPsPBCSYkOID4u84uaXa
   BJ6uZ8DL+J+gko5+u4I66mrjiolDffukbENwuZhwd8TTZVbxTw0BEkWKn
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Dec 2021 04:52:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 04:52:35 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 04:52:34 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 2 Dec 2021
 04:52:32 -0800
Message-ID: <7fe2aa6a-0b3a-dd69-e8a5-5f2da3523d67@quicinc.com>
Date:   Thu, 2 Dec 2021 20:52:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RESEND PATCH v3 02/10] spmi: pmic-arb: do not ack and clear
 peripheral interrupts in cleanup_irq
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <tglx@linutronix.de>, <maz@kernel.org>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638403212-29265-3-git-send-email-quic_fenglinw@quicinc.com>
 <09814d45-3f85-5611-5866-b33ae28cc2bb@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <09814d45-3f85-5611-5866-b33ae28cc2bb@linaro.org>
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
>> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
>>
>> Currently, cleanup_irq() is invoked when a peripheral's interrupt
>> fires and there is no mapping present in the interrupt domain of
>> spmi interrupt controller.
>>
>> The cleanup_irq clears the arbiter bit, clears the pmic interrupt
>> and disables it at the pmic in that order. The last disable in
>> cleanup_irq races with request_irq() in that it stomps over the
>> enable issued by request_irq. Fix this by not writing to the pmic
>> in cleanup_irq. The latched bit will be left set in the pmic,
>> which will not send us more interrupts even if the enable bit
>> stays enabled.
>>
>> When a client wants to request an interrupt, use the activate
>> callback on the irq_domain to clear latched bit. This ensures
>> that the latched, if set due to the above changes in cleanup_irq
>> or when the bootloader leaves it set, gets cleaned up, paving way
>> for upcoming interrupts to trigger.
>>
>> With this, there is a possibility of unwanted triggering of
>> interrupt right after the latched bit is cleared - the interrupt
>> may be left enabled too. To avoid that, clear the enable first
>> followed by clearing the latched bit in the activate callback.
>>
>> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
>> [collinsd@codeaurora.org: fix merge conflict]
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   drivers/spmi/spmi-pmic-arb.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
>> index da629cc..ce7ae99 100644
>> --- a/drivers/spmi/spmi-pmic-arb.c
>> +++ b/drivers/spmi/spmi-pmic-arb.c
>> @@ -492,16 +492,6 @@ static void cleanup_irq(struct spmi_pmic_arb 
>> *pmic_arb, u16 apid, int id)
>>       dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x 
>> per=0x%x irq=%d\n",
>>               __func__, apid, sid, per, id);
>>       writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, 
>> apid));
>> -
>> -    if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
>> -            (per << 8) + QPNPINT_REG_LATCHED_CLR, &irq_mask, 1))
>> -        dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack 
>> irq_mask = 0x%x for ppid = %x\n",
>> -                irq_mask, ppid);spmi: pmic-arb: cleanup unrequested 
>> irqs
>> -
>> -    if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
>> -                   (per << 8) + QPNPINT_REG_EN_CLR, &irq_mask, 1))
>> -        dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack 
>> irq_mask = 0x%x for ppid = %x\n",
>> -                irq_mask, ppid);
>>   }
>>     static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 
>> apid)
>> @@ -674,6 +664,7 @@ static int qpnpint_irq_domain_activate(struct 
>> irq_domain *domain,
>>       u16 apid = hwirq_to_apid(d->hwirq);
>>       u16 sid = hwirq_to_sid(d->hwirq);
>>       u16 irq = hwirq_to_irq(d->hwirq);
>> +    u8 buf;
>>         if (pmic_arb->apid_data[apid].irq_ee != pmic_arb->ee) {
>>           dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, 
>> periph = %#x, irq = %u: ee=%u but owner=%u\n",
>> @@ -682,6 +673,10 @@ static int qpnpint_irq_domain_activate(struct 
>> irq_domain *domain,
>>           return -ENODEV;
>>       }
>>   +    buf = BIT(irq);
>> +    qpnpint_spmi_write(d, QPNPINT_REG_EN_CLR, &buf, 1);
>> +    qpnpint_spmi_write(d, QPNPINT_REG_LATCHED_CLR, &buf, 1);
>> +
>>       return 0;
>>   }
>>
>
> Shouldn't this have a
>
> Fixes: 6bc546e71e50 ("spmi: pmic-arb: cleanup unrequested irqs")
> Fixes: 02abec3616c1 ("spmi: pmic-arb: rename pa_xx to pmic_arb_xx and 
> other cleanup")
>
> so we know to backport as necessary
>
Got it, I will add the Fixes tag and send it again.

> ---
> bod
>
