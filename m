Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9904A491A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379305AbiAaONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:13:17 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:61455 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379296AbiAaONO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:13:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643638394; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HHc7r3nTW7LvI6JuHzsTAZhfU68I0uEaz59BkQU4fJI=; b=g/h8W017CJSvorH9CHGTdfzySvscxOyA85EB+3no1klLGKYAiCSN8zgfBa26PLsekMsdWAIw
 WIBMqM6BLqEXMQKzn6d89Xeep9PYU8KcqHbjk6t9xDAuY0xEiS8B7EdbTGe4Wtzjn6TtaBDd
 u9cUnyWFHpcWrEQeCmoghaUGSjk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61f7ee79d9d8618172487c1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Jan 2022 14:13:13
 GMT
Sender: sricharan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72A55C43617; Mon, 31 Jan 2022 14:13:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.104] (unknown [183.82.28.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3760AC4338F;
        Mon, 31 Jan 2022 14:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3760AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        pragalla@codeaurora.org
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
 <0a8d6550-aa19-0af1-abae-66bf34c91ea8@somainline.org>
From:   Sricharan Ramabadhran <sricharan@codeaurora.org>
Message-ID: <be779ed9-bd80-8f01-fe7f-d3c07d3d85aa@codeaurora.org>
Date:   Mon, 31 Jan 2022 19:43:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0a8d6550-aa19-0af1-abae-66bf34c91ea8@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 1/31/2022 3:39 PM, Konrad Dybcio wrote:
>
> On 28/01/2022 18:50, Sricharan Ramabadhran wrote:
>> Hi Konrad,
>>
>> On 1/28/2022 9:55 AM, Sricharan Ramabadhran wrote:
>>> Hi Miquel,
>>>
>>> On 1/26/2022 4:12 PM, Miquel Raynal wrote:
>>>> Hi Mani,
>>>>
>>>> mani@kernel.org wrote on Wed, 26 Jan 2022 16:03:16 +0530:
>>>>
>>>>> On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote:
>>>>>> Hello,
>>>>>>
>>>>>> miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100:
>>>>>>> Hi Konrad,
>>>>>>>
>>>>>>> konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 
>>>>>>> +0100:
>>>>>>>> While I have absolutely 0 idea why and how, running 
>>>>>>>> clear_bam_transaction
>>>>>>>> when READID is issued makes the DMA totally clog up and refuse 
>>>>>>>> to function
>>>>>>>> at all on mdm9607. In fact, it is so bad that all the data gets 
>>>>>>>> garbled
>>>>>>>> and after a short while in the nand probe flow, the CPU decides 
>>>>>>>> that
>>>>>>>> sepuku is the only option.
>>>>>>>>
>>>>>>>> Removing _READID from the if condition makes it work like a 
>>>>>>>> charm, I can
>>>>>>>> read data and mount partitions without a problem.
>>>>>>>>
>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>>>>> ---
>>>>>>>> This is totally just an observation which took me an inhumane 
>>>>>>>> amount of
>>>>>>>> debug prints to find.. perhaps there's a better reason behind 
>>>>>>>> this, but
>>>>>>>> I can't seem to find any answers.. Therefore, this is a BIG RFC!
>>>>>>> I'm adding two people from codeaurora who worked a lot on this 
>>>>>>> driver.
>>>>>>> Hopefully they will have an idea :)
>>>>>> Sadre, I've spent a significant amount of time reviewing your 
>>>>>> patches,
>>>>>> now it's your turn to not take a month to answer to your peers
>>>>>> proposals.
>>>>>>
>>>>>> Please help reviewing this patch.
>>>>> Sorry. I was hoping that Qcom folks would chime in as I don't have 
>>>>> any idea
>>>>> about the mdm9607 platform. It could be that the mail server 
>>>>> migration from
>>>>> codeaurora to quicinc put a barrier here.
>>>>>
>>>>> Let me ping them internally.
>>>> Oh, ok, I didn't know. Thanks!
>>>
>>>    Sorry Miquel, somehow we did not get this email in our inbox.
>>>    Thanks to Mani for pinging us, we will test this up today and get 
>>> back.
>>>
>>       While we could not reproduce this issue on our ipq boards (do 
>> not have a mdm9607 right now) and
>>        issue does not look any obvious.
>>       can you please give the debug logs that you did for the above 
>> stage by stage ?
>
> I won't have access to the board for about two weeks, sorry.
>
> When I get to it, I'll surely try to send you the logs, though there
>
> wasn't much more than just something jumping to who-knows-where
>
> after clear_bam_transaction was called, resulting in values associated 
> with
>
> the NAND being all zeroed out in pr_err/_debug/etc.
>
>
     Ok sure. So was the READID command itself failing (or) the 
subsequent one ?
    We can check which parameter reset by the clear_bam_transaction is 
causing the
    failure.  Meanwhile, looping in Pradeep who has access to the board, 
so in a better
    position to debug.

Regards,
    Sricharan


