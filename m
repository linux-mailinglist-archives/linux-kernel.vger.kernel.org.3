Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB41D4A4FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377565AbiAaTyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiAaTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:54:17 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0B0C061714;
        Mon, 31 Jan 2022 11:54:16 -0800 (PST)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 523D93F748;
        Mon, 31 Jan 2022 20:54:13 +0100 (CET)
Message-ID: <12cad24a-fa2f-9a82-cf43-241a0a6fe4f6@somainline.org>
Date:   Mon, 31 Jan 2022 20:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
To:     Sricharan Ramabadhran <sricharan@codeaurora.org>,
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
 <be779ed9-bd80-8f01-fe7f-d3c07d3d85aa@codeaurora.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <be779ed9-bd80-8f01-fe7f-d3c07d3d85aa@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/01/2022 15:13, Sricharan Ramabadhran wrote:
> Hi Konrad,
>
> On 1/31/2022 3:39 PM, Konrad Dybcio wrote:
>>
>> On 28/01/2022 18:50, Sricharan Ramabadhran wrote:
>>> Hi Konrad,
>>>
>>> On 1/28/2022 9:55 AM, Sricharan Ramabadhran wrote:
>>>> Hi Miquel,
>>>>
>>>> On 1/26/2022 4:12 PM, Miquel Raynal wrote:
>>>>> Hi Mani,
>>>>>
>>>>> mani@kernel.org wrote on Wed, 26 Jan 2022 16:03:16 +0530:
>>>>>
>>>>>> On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100:
>>>>>>>> Hi Konrad,
>>>>>>>>
>>>>>>>> konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 
>>>>>>>> +0100:
>>>>>>>>> While I have absolutely 0 idea why and how, running 
>>>>>>>>> clear_bam_transaction
>>>>>>>>> when READID is issued makes the DMA totally clog up and refuse 
>>>>>>>>> to function
>>>>>>>>> at all on mdm9607. In fact, it is so bad that all the data 
>>>>>>>>> gets garbled
>>>>>>>>> and after a short while in the nand probe flow, the CPU 
>>>>>>>>> decides that
>>>>>>>>> sepuku is the only option.
>>>>>>>>>
>>>>>>>>> Removing _READID from the if condition makes it work like a 
>>>>>>>>> charm, I can
>>>>>>>>> read data and mount partitions without a problem.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>>>>>> ---
>>>>>>>>> This is totally just an observation which took me an inhumane 
>>>>>>>>> amount of
>>>>>>>>> debug prints to find.. perhaps there's a better reason behind 
>>>>>>>>> this, but
>>>>>>>>> I can't seem to find any answers.. Therefore, this is a BIG RFC!
>>>>>>>> I'm adding two people from codeaurora who worked a lot on this 
>>>>>>>> driver.
>>>>>>>> Hopefully they will have an idea :)
>>>>>>> Sadre, I've spent a significant amount of time reviewing your 
>>>>>>> patches,
>>>>>>> now it's your turn to not take a month to answer to your peers
>>>>>>> proposals.
>>>>>>>
>>>>>>> Please help reviewing this patch.
>>>>>> Sorry. I was hoping that Qcom folks would chime in as I don't 
>>>>>> have any idea
>>>>>> about the mdm9607 platform. It could be that the mail server 
>>>>>> migration from
>>>>>> codeaurora to quicinc put a barrier here.
>>>>>>
>>>>>> Let me ping them internally.
>>>>> Oh, ok, I didn't know. Thanks!
>>>>
>>>>    Sorry Miquel, somehow we did not get this email in our inbox.
>>>>    Thanks to Mani for pinging us, we will test this up today and 
>>>> get back.
>>>>
>>>       While we could not reproduce this issue on our ipq boards (do 
>>> not have a mdm9607 right now) and
>>>        issue does not look any obvious.
>>>       can you please give the debug logs that you did for the above 
>>> stage by stage ?
>>
>> I won't have access to the board for about two weeks, sorry.
>>
>> When I get to it, I'll surely try to send you the logs, though there
>>
>> wasn't much more than just something jumping to who-knows-where
>>
>> after clear_bam_transaction was called, resulting in values 
>> associated with
>>
>> the NAND being all zeroed out in pr_err/_debug/etc.
>>
>>
>     Ok sure. So was the READID command itself failing (or) the 
> subsequent one ?
>    We can check which parameter reset by the clear_bam_transaction is 
> causing the
>    failure.  Meanwhile, looping in Pradeep who has access to the 
> board, so in a better
>    position to debug.

I'm sorry I have so few details on hand, and no kernel tree (no access 
to that machine either, for now).


I will try to describe to the best of my abilities what I recall.


My methodology of making sure things don't go haywire was to print the 
oob size

of our NAND basically every two lines of code (yes, i was very desperate 
at one point),

as that was zeroed out when *the bug* happened, leading to a kernel 
bug/panic/stall

(can't recall what exactly it was, but it said something along the lines 
of "no support for

oob size 0" and then it didn't fail graceully, leading to some bad jumps 
and ultimately

a dead platform..)


after hours of digging, I found out that everything goes fine until 
clear_bam_transaction is called,

after that gets executed every nand op starts reading all zeroes (for 
example in JEDEC ID check)

so I added the changes from this patch, and things magically started 
working... My suspicion is

that the underlying FIFO isn't fully drained (is it a FIFO on 9607? bah, 
i work on too many socs at once)

and this function only makes Linux think it is, without actually 
draining it, and the leftover

commands get executed with some parts of them getting overwritten, 
resulting in the

famous garbage in - garbage out situation, but that's only a guesstimate..


Do note this somehow worked fine on 5.11 and then broke on 5.12/13. I 
went as far as replacing most

of the kernel with the updated/downgraded parts via git checkout (i 
tried many combinations),

to no avail.. I even tried different compilers and optimization levels, 
thinking it could have been

a codegen issue, but no luck either.


I.. do understand this email is a total mess to read, as much as it was 
to write, but

without access to my code and the machine itself I can't give you solid 
details, and

the fact this situation is far from ordinary doesn't help either..


The latest (ancient, not quite pretty, but probably working if my memory 
is correct) version of my patches

for the mdm9607 is available at [1], I will push the new revision after 
I get access to the workstation.


Konrad


[1] https://github.com/SoMainline/linux/commits/konrad/pinemodem


>
> Regards,
>    Sricharan
>
>
