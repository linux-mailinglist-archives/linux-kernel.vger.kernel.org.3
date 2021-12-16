Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC8476E24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhLPJtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:49:10 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38362 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230345AbhLPJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:49:07 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG9AAwj021585;
        Thu, 16 Dec 2021 10:48:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=LLN9sSigq+j2eNzjgy1QryZl+qL34fhAv1RfhNaTpPU=;
 b=DD35Vny2lHI/MVlzRibb+MGp58oxZ65yvZNUyrxgpZaf+cnfQTojaRUOMG/vwNE+p4IO
 9SkY9HqRdK2JAgub5OA8Q8Z8DUaOGnYgUz44/E/cK9s4FXGtRlXecerkgvFRagd/8wsq
 2BuA8TElTHyfcMI3mYbRBRu6A4FpSzpmwy0ifE1rm/sHbu/WBJG1b7CcVQMo9cMn/o8p
 oJYv4kDOFko2niCdU7p30OKWqd7md6pnVrZHb+pUilT1PT+HKK7mMu0NDUwIM5lG47X9
 MuhvKJf1zwGdanwNXexhNjCQ/5WIxZNUyE0JfXeSaV4xA0h7RXFuR0eK6Rt0iVB5ALEc Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d02k9g8ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 10:48:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB25610002A;
        Thu, 16 Dec 2021 10:48:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C13AD229F8A;
        Thu, 16 Dec 2021 10:48:55 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 16 Dec
 2021 10:48:55 +0100
Subject: Re: [PATCH 3/4] mmc: mmci: stm32: clear DLYB_CR after sending tuning
 command
To:     Marek Vasut <marex@denx.de>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        <u.kleine-koenig@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
 <20211215141727.4901-4-yann.gautier@foss.st.com>
 <05ab7b52-190e-048f-3803-7bed51e2b09c@denx.de>
From:   Yann Gautier <yann.gautier@foss.st.com>
Message-ID: <67c6d0be-078b-0726-698d-096c5e77b4ab@foss.st.com>
Date:   Thu, 16 Dec 2021 10:48:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <05ab7b52-190e-048f-3803-7bed51e2b09c@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_03,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 10:13 AM, Marek Vasut wrote:
> On 12/15/21 15:17, Yann Gautier wrote:
>> During test campaign, and especially after several unbind/bind sequences,
>> it has been seen that the SD-card on SDMMC1 thread could freeze.
>> The freeze always appear on a CMD23 following a CMD19.
>> Checking SDMMC internal registers shows that the tuning command (CMD19)
>> has failed.
>> The freeze is then due to the delay block involved in the tuning 
>> sequence.
>> To correct this, clear the delay block register DLYB_CR register after
>> the tuning commands.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>> ---
>>   drivers/mmc/host/mmci_stm32_sdmmc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c 
>> b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> index fdaa11f92fe6..a75d3dd34d18 100644
>> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> @@ -441,6 +441,8 @@ static int sdmmc_dlyb_phase_tuning(struct 
>> mmci_host *host, u32 opcode)
>>           return -EINVAL;
>>       }
>> +    writel_relaxed(0, dlyb->base + DLYB_CR);
>> +
>>       phase = end_of_len - max_len / 2;
>>       sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
> 
> Shouldn't this have a Fixes: tag and be CC stable ?
> This seems like a bugfix, no ?

Hi Marek,

You're right, I should have added:
Fixes: 1103f807a3b9 ("mmc: mmci_sdmmc: Add execute tuning with delay block")

Ulf, could you manage that, or should I push a new version?


Best regards,
Yann

