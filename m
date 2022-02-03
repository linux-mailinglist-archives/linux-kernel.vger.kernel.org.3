Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C394A8820
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiBCP4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:56:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48340 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiBCP43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:56:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 213FuGqB101083;
        Thu, 3 Feb 2022 09:56:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643903776;
        bh=Toar8XQdGaRCOJTQWgbWo4IklEUbtuLsEEHm1375h9s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uugpJAdno1/N/dQ7mLmQyX0IwyanKSZ2mHancxIP6M2awl2U4osWDxEDwBqAyjMaR
         daxSDEzQzNa7GLna9wL543MzxchGWud32mgXYufhHiLoP6uPqprH5hEfjPIYubCmQI
         mJCyQ7UjkLfxZOhAkithcK+OeMwxeH79Zi2qfR8Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 213FuGZS087435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Feb 2022 09:56:16 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 3
 Feb 2022 09:56:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 3 Feb 2022 09:56:15 -0600
Received: from [10.249.37.221] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 213FuFQO019479;
        Thu, 3 Feb 2022 09:56:15 -0600
Message-ID: <123d2444-9f61-7d9c-66d4-7e981dbc945f@ti.com>
Date:   Thu, 3 Feb 2022 09:56:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: fix regression from
 errata i940 fix
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <khilman@baylibre.com>
References: <20220202212554.1316032-1-dfustini@baylibre.com>
 <Yft723A/i3J1ZftC@atomide.com>
From:   Suman Anna <s-anna@ti.com>
In-Reply-To: <Yft723A/i3J1ZftC@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Drew,

On 2/3/22 00:53, Tony Lindgren wrote:
> * Drew Fustini <dfustini@baylibre.com> [220202 23:26]:
>> I modified the errata fix to use timer 15 and 16 instead which resolves
>> the timer conflict.
> 
> Makes sens to me, just one nit below.
> 
>> Note: I am keeping the device tree and driver change together in one
>> patch as that is how the original errata fix commit was structured.
> 
> Yes.. The old dtb handling for the timer driver causes this dependency
> unfortunately.

Can you also add the cyclictest info to the commit log when you repost v2?

regards
Suman

> 
>> --- a/drivers/clocksource/timer-ti-dm-systimer.c
>> +++ b/drivers/clocksource/timer-ti-dm-systimer.c
>> @@ -695,9 +695,9 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
>>  		return 0;
>>  	}
>>  
>> -	if (pa == 0x48034000)		/* dra7 dmtimer3 */
>> +	if (pa == 0x4882C000)           /* dra7 dmtimer15 */
>>  		return dmtimer_percpu_timer_init(np, 0);
>> -	else if (pa == 0x48036000)	/* dra7 dmtimer4 */
>> +	else if (pa == 0x4882E000)      /* dra7 dmtimer16 */
>>  		return dmtimer_percpu_timer_init(np, 1);
>>  
>>  	return 0;
> 
> Linux use lower case hex number typically :)
> 
> With that, please feel free to add:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>

