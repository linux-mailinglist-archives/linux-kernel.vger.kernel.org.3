Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84E34A3FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348437AbiAaKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiAaKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:10:00 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A30C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:10:00 -0800 (PST)
Received: from [192.168.1.106] (abxk84.neoplus.adsl.tpnet.pl [83.9.4.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 74A3C3F42A;
        Mon, 31 Jan 2022 11:09:55 +0100 (CET)
Message-ID: <0a8d6550-aa19-0af1-abae-66bf34c91ea8@somainline.org>
Date:   Mon, 31 Jan 2022 11:09:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
To:     Sricharan Ramabadhran <sricharan@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
 <20220114082718.32a2fc83@xps13> <20220126111613.3ab0021e@xps13>
 <20220126103316.GA212068@thinkpad> <20220126114200.4cc3c21b@xps13>
 <fc80a6e7-bd44-3b3e-fca2-1316a76d65f5@codeaurora.org>
 <a6fcc533-e7cd-7b55-4db0-cec80c07b46a@codeaurora.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <a6fcc533-e7cd-7b55-4db0-cec80c07b46a@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/01/2022 18:50, Sricharan Ramabadhran wrote:
> Hi Konrad,
>
> On 1/28/2022 9:55 AM, Sricharan Ramabadhran wrote:
>> Hi Miquel,
>>
>> On 1/26/2022 4:12 PM, Miquel Raynal wrote:
>>> Hi Mani,
>>>
>>> mani@kernel.org wrote on Wed, 26 Jan 2022 16:03:16 +0530:
>>>
>>>> On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote:
>>>>> Hello,
>>>>>
>>>>> miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100:
>>>>>> Hi Konrad,
>>>>>>
>>>>>> konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 
>>>>>> +0100:
>>>>>>> While I have absolutely 0 idea why and how, running 
>>>>>>> clear_bam_transaction
>>>>>>> when READID is issued makes the DMA totally clog up and refuse 
>>>>>>> to function
>>>>>>> at all on mdm9607. In fact, it is so bad that all the data gets 
>>>>>>> garbled
>>>>>>> and after a short while in the nand probe flow, the CPU decides 
>>>>>>> that
>>>>>>> sepuku is the only option.
>>>>>>>
>>>>>>> Removing _READID from the if condition makes it work like a 
>>>>>>> charm, I can
>>>>>>> read data and mount partitions without a problem.
>>>>>>>
>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>>>> ---
>>>>>>> This is totally just an observation which took me an inhumane 
>>>>>>> amount of
>>>>>>> debug prints to find.. perhaps there's a better reason behind 
>>>>>>> this, but
>>>>>>> I can't seem to find any answers.. Therefore, this is a BIG RFC!
>>>>>> I'm adding two people from codeaurora who worked a lot on this 
>>>>>> driver.
>>>>>> Hopefully they will have an idea :)
>>>>> Sadre, I've spent a significant amount of time reviewing your 
>>>>> patches,
>>>>> now it's your turn to not take a month to answer to your peers
>>>>> proposals.
>>>>>
>>>>> Please help reviewing this patch.
>>>> Sorry. I was hoping that Qcom folks would chime in as I don't have 
>>>> any idea
>>>> about the mdm9607 platform. It could be that the mail server 
>>>> migration from
>>>> codeaurora to quicinc put a barrier here.
>>>>
>>>> Let me ping them internally.
>>> Oh, ok, I didn't know. Thanks!
>>
>>    Sorry Miquel, somehow we did not get this email in our inbox.
>>    Thanks to Mani for pinging us, we will test this up today and get 
>> back.
>>
>       While we could not reproduce this issue on our ipq boards (do 
> not have a mdm9607 right now) and
>        issue does not look any obvious.
>       can you please give the debug logs that you did for the above 
> stage by stage ?

I won't have access to the board for about two weeks, sorry.

When I get to it, I'll surely try to send you the logs, though there

wasn't much more than just something jumping to who-knows-where

after clear_bam_transaction was called, resulting in values associated with

the NAND being all zeroed out in pr_err/_debug/etc.


Konrad

>
>   Regards,
>       Sricharan
>
