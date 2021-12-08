Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED43746D627
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhLHOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:55:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52584 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235530AbhLHOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:55:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B89sqIR020212;
        Wed, 8 Dec 2021 15:51:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IpuZOGwO/v7ipbt03x8yTn8Car/0TQpCG5NiK+X11ao=;
 b=8ck3ngzmTL3Z/pah5tFBBSgSPJFOfn5R30BELfAYwrlYVBzDmNKFT5Z1/GUmtaE/cHhi
 uXxs2YXAfZTlz1e8ute9dZP+JiMY76u5dWLV86a15TQYfIT3KskJTzQC2mP75Fxx2Njw
 hx7HHLlwoqOPKtS/SfsNMTTySxEcjL2bpFrYKdjpxcxVpltFPFvR8kbTfA9ZCYRuZcoq
 pLYYRRHauF4g7gzOdm3WdzyNt1i1wxEYGMJjsF/5GYMWfBYoPAjQgOruUslvwbMGLhsu
 9Pop5tMVGjmyGczLWotKmu34RlDFNujAZkI5ByCJhAlgVLFLjgUxwfq9S8csDivcJMkH Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cttga9kby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:51:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0DFC010002A;
        Wed,  8 Dec 2021 15:51:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00A7E22CD49;
        Wed,  8 Dec 2021 15:51:51 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec
 2021 15:51:49 +0100
Subject: Re: [PATCH 2/3] irqchip/stm32-exti: add STM32MP13 support
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
 <20211208130456.4002-3-alexandre.torgue@foss.st.com>
 <87fsr31aex.wl-maz@kernel.org>
 <fffb9758-8071-edd8-8fe9-d0d2a57fac05@foss.st.com>
 <87ee6n18im.wl-maz@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <701f4954-5dc8-9b4f-674c-c40d7e6e3df1@foss.st.com>
Date:   Wed, 8 Dec 2021 15:51:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87ee6n18im.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_05,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 3:22 PM, Marc Zyngier wrote:
> Hi Alexandre,
> 
> On Wed, 08 Dec 2021 13:58:46 +0000,
> Alexandre TORGUE <alexandre.torgue@foss.st.com> wrote:
>>
>>> Why does the driver need to carry these tables? This sort of
>>> information should really come from DT, instead of being hardcoded in
>>> the driver and bloating it for no reason. This all has a funny taste
>>> of the board files we used to have pre-DT.
>>>
>>
>> There are absolutely no reason to have it in driver. Honestly It has
>> been done in this way to have minimal changes adding this new SoC
>> support (and it's not smart, I agree).
>>
>> I think it is better to abandon this series. I will create a new one
>> which moves mapping table for MP15 and adds MP13 support to.
> 
> I'm afraid you'll have to keep the in-kernel table for MP15, since the
> driver needs to work with old DTs. For new SoCs (such as MP13), moving
> the table into DT would be good.

I can try to have both for MP15:use new mechanism as MP13 and keep the 
table inside the driver as a fallback if DT mapping is not provided (for 
old DT).

Thanks

> 
> Thanks,
> 
> 	M.
> 

