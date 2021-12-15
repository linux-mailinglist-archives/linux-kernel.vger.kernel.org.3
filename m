Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA84755CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbhLOKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:06:22 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236515AbhLOKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:06:21 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF95RNJ015581;
        Wed, 15 Dec 2021 11:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : from : to
 : cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=gIjXSmze8zGdJ/iWENvemHIdtGMxjbPRELTGudH1KNA=;
 b=YG5CIlfgJQEtTPMvA/CPRRJW02ntN5FmDFK1868vXMoWcni2i2UJbBBSNm6TGDDLPTnk
 8f2tDU+iEZYD+IPPWDyQ/BtvPNBUw36IFE9VSmd9LHyEVxqex32q9A2NNa/7jihQTX35
 ZnrzfRlWF+fK3+PT3yBJ2wlAARbYNasR5Z8NmO/QtJ99Q6suKP2B6R4kGY/eCsZ3p9ec
 uIHbs97FIryoMHSOIkZSnDSRNPUOyJdz7DLKFuDlgD+NBrWkqsosi2DaSwJIZGMvt5u2
 Dhkowma/HM7iOERbLBOy4OZtkcc43XaPuipPkDokI6YR25gCL/LUQVxnGr3fNnwxR9AY XA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxrthxpx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:06:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 015EB10002A;
        Wed, 15 Dec 2021 11:06:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA55722ECC4;
        Wed, 15 Dec 2021 11:06:04 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec
 2021 11:06:04 +0100
Subject: Re: [PATCH 1/2] clk: st: clkgen-fsyn: search reg within node or
 parent
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211202072850.194314-1-avolmat@me.com>
 <20211202072850.194314-2-avolmat@me.com>
 <0759650c-7e56-4af5-6957-ac0055341d93@foss.st.com>
Message-ID: <18d1ceab-d2c7-9501-40a3-2bcb36ca1249@foss.st.com>
Date:   Wed, 15 Dec 2021 11:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0759650c-7e56-4af5-6957-ac0055341d93@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah one remark, reviewing the patch 2, i saw you added a pr_err() in case of error, 
perhaps you can add one here also.

Patrice

On 12/15/21 11:03 AM, Patrice CHOTARD wrote:
> Hi Alain
> 
> On 12/2/21 8:28 AM, Alain Volmat wrote:
>> In order to avoid having duplicated addresses within the DT,
>> only have one unit-address per clockgen and each driver within
>> the clockgen should look at the parent node (overall clockgen)
>> to figure out the reg property.  Such behavior is already in
>> place in other STi platform clock drivers such as clk-flexgen
>> and clkgen-pll.  Keep backward compatibility by first looking
>> at reg within the node before looking into the parent node.
>>
>> Signed-off-by: Alain Volmat <avolmat@me.com>
>> ---
>>  drivers/clk/st/clkgen-fsyn.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
>> index 164285d6be97..0d41164f2c7f 100644
>> --- a/drivers/clk/st/clkgen-fsyn.c
>> +++ b/drivers/clk/st/clkgen-fsyn.c
>> @@ -988,9 +988,16 @@ static void __init st_of_quadfs_setup(struct device_node *np,
>>  	void __iomem *reg;
>>  	spinlock_t *lock;
>>  
>> +	/*
>> +	 * First check for reg property within the node to keep backward
>> +	 * compatibility, then if reg doesn't exist look at the parent node
>> +	 */
>>  	reg = of_iomap(np, 0);
>> -	if (!reg)
>> -		return;
>> +	if (!reg) {
>> +		reg = of_iomap(of_get_parent(np), 0);
>> +		if (!reg)
>> +			return;
>> +	}
>>  
>>  	clk_parent_name = of_clk_get_parent_name(np, 0);
>>  	if (!clk_parent_name)
>>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> 
