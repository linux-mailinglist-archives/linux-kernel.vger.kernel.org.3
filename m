Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694CE4BE71A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352850AbiBUQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:30:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349831AbiBUQaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:30:01 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA61D0C5;
        Mon, 21 Feb 2022 08:29:36 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21LGTLYg127812;
        Mon, 21 Feb 2022 10:29:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645460961;
        bh=06jOtXI4rzCzz8wUf9ZOcz62rwmanvbVaynL0eLkoGs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EHb1XOncE8G6tEuQe9TkcoGNaB4bjwYqpKB7qWiQ8OI1FAiSnr80PTZFJF0/Z46ua
         Bn7cKoTSZuG+e8Yf2v38ZA+IZnkV7rPjdW7V9RWI7wxjZmLnuJVSdbCjJgiikZZLE/
         ZZ0s6geRJVEUS+6J0Wceg9j/TdURUuDYfuYdUu5U=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21LGTLEB020497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Feb 2022 10:29:21 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Feb 2022 10:29:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Feb 2022 10:29:21 -0600
Received: from [10.249.40.134] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21LGTKtH063338;
        Mon, 21 Feb 2022 10:29:21 -0600
Message-ID: <c96bffda-73bc-0cdf-c77a-39d57abe1a95@ti.com>
Date:   Mon, 21 Feb 2022 10:29:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 3/4] watchdog: rti-wdt: attach to running watchdog
 during probe
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200717132958.14304-1-t-kristo@ti.com>
 <20200717132958.14304-4-t-kristo@ti.com>
 <a80b83c6-cca5-f95c-6930-a6f3e79c6f15@siemens.com>
 <bdecc38d-2b1a-9605-0978-5ad1e8b39e6b@siemens.com>
 <20220221124405.o7vda3zaswi6ycrh@favored>
 <8a3f83be-172b-a0c8-d4ba-befa531e52f6@siemens.com>
 <dae15cec-5d05-a48d-8c3b-392559d8bfb7@siemens.com>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <dae15cec-5d05-a48d-8c3b-392559d8bfb7@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 10:03, Jan Kiszka wrote:
>> K, so we do want a safety margin for min_hw_heartbeat_ms, make it
>> larger. But I still don't think it is best achieved by bending the
>> frequency. That will also affect other values, e.g. returning a wrong
>> programmed timeout to userspace if that was programmed earlier, using
>> the original frequency.
>>
> I think I'm starting to get the original logic, and the result now works
> here:
> 
> The clock driving the watchdog might be slower than thought, and then we
> may time out later than intended - generally not an issue. But it may
> also be faster, and then we will see an expiry earlier than what is
> supposed to be configured via "heartbeat". For the latter case, we lower
> the frequency virtually by 10%, crossing fingers that this is enough.
> 
Humm.. To me it appears the intent is to adjust when the input 32KHz 
clock is slower? when it is slower we reduce the pulse count by 10% 
(assuming the crystals are with 10% off clock) so that the desired 
timeout is achieved with lesser pulse count?
> The problems are now:
>   - U-Boot (as a known early watchdog starter) does not do that as well,
>     and we will cause at least confusion on Linux side (60s will become
>     66s from Linux POV e.g., and we may expire at 54s already)
>      => U-Boot should add the same 10%, patch will be sent
Yes, i see that we need similar adjustment in u-boot as well.
>   - even with U-Boot on the same page, the rounding issue will prevent
>     accurate calculations of derived values, namely min_hw_heartbeat_ms.
>      => patch to come
>   - and ...
> 

