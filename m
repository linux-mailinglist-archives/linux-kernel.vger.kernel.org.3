Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF614D6A65
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiCKXRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiCKXRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:17:02 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DA1FDFAE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:15:56 -0800 (PST)
Received: from [192.168.1.101] (abxi44.neoplus.adsl.tpnet.pl [83.9.2.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3DE213F6AB;
        Fri, 11 Mar 2022 22:22:52 +0100 (CET)
Message-ID: <b428593e-a4db-984b-df7f-7cd14795d5e2@somainline.org>
Date:   Fri, 11 Mar 2022 22:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Content-Language: en-US
To:     Sricharan Ramabadhran <sricharan@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, pragalla@codeaurora.org,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org,
        bbhatt@codeaurora.org, hemantk@codeaurora.org
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
 <20220114082718.32a2fc83@xps13> <20220126111613.3ab0021e@xps13>
 <20220126103316.GA212068@thinkpad> <20220126114200.4cc3c21b@xps13>
 <fc80a6e7-bd44-3b3e-fca2-1316a76d65f5@codeaurora.org>
 <a6fcc533-e7cd-7b55-4db0-cec80c07b46a@codeaurora.org>
 <0a8d6550-aa19-0af1-abae-66bf34c91ea8@somainline.org>
 <be779ed9-bd80-8f01-fe7f-d3c07d3d85aa@codeaurora.org>
 <12cad24a-fa2f-9a82-cf43-241a0a6fe4f6@somainline.org>
 <20220201145204.54646475@xps13>
 <d79bf21d-5a90-0074-cef6-896f66e80d28@somainline.org>
 <c63d5410-7f08-80fe-28ac-f4867038ff30@codeaurora.org>
 <cc1302f4-9150-0145-421c-bf2b7a7bf258@codeaurora.org>
 <6b839237-74f0-7270-2f33-f5c17e6b59de@somainline.org>
 <2fb9d943-d6c8-06b1-08cc-b0c3a8256082@codeaurora.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <2fb9d943-d6c8-06b1-08cc-b0c3a8256082@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2022 08:33, Sricharan Ramabadhran wrote:
> Hi Konrad,
> 
> On 2/8/2022 10:15 PM, Konrad Dybcio wrote:
>>
>> On 4.02.2022 18:17, Sricharan Ramabadhran wrote:
>>> On 2/2/2022 12:54 PM, Sricharan Ramabadhran wrote:
>>>> Hi Konrad/Miquel,
>>>>
>>>> On 2/1/2022 9:21 PM, Konrad Dybcio wrote:
>>>>> On 01/02/2022 14:52, Miquel Raynal wrote:
>>>>>> Hi Konrad,
>>>>>>
>>>>>> konrad.dybcio@somainline.org wrote on Mon, 31 Jan 2022 20:54:12 +0100:
>>>>>>
>>>>>>> On 31/01/2022 15:13, Sricharan Ramabadhran wrote:
>>>>>>>> Hi Konrad,
>>>>>>>>
>>>>>>>> On 1/31/2022 3:39 PM, Konrad Dybcio wrote:
>>>>>>>>> On 28/01/2022 18:50, Sricharan Ramabadhran wrote:
>>>>>>>>>> Hi Konrad,
>>>>>>>>>>
>>>>>>>>>> On 1/28/2022 9:55 AM, Sricharan Ramabadhran wrote:
>>>>>>>>>>> Hi Miquel,
>>>>>>>>>>>
>>>>>>>>>>> On 1/26/2022 4:12 PM, Miquel Raynal wrote:
>>>>>>>>>>>> Hi Mani,
>>>>>>>>>>>>
>>>>>>>>>>>> mani@kernel.org wrote on Wed, 26 Jan 2022 16:03:16 +0530:
>>>>>>>>>>>>> On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote:
>>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100:
>>>>>>>>>>>>>>> Hi Konrad,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 >>>>>>>> +0100:
>>>>>>>>>>>>>>>> While I have absolutely 0 idea why and how, running >>>>>>>>> clear_bam_transaction
>>>>>>>>>>>>>>>> when READID is issued makes the DMA totally clog up and refuse >>>>>>>>> to function
>>>>>>>>>>>>>>>> at all on mdm9607. In fact, it is so bad that all the data >>>>>>>>> gets garbled
>>>>>>>>>>>>>>>> and after a short while in the nand probe flow, the CPU >>>>>>>>> decides that
>>>>>>>>>>>>>>>> sepuku is the only option.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Removing _READID from the if condition makes it work like a >>>>>>>>> charm, I can
>>>>>>>>>>>>>>>> read data and mount partitions without a problem.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>> This is totally just an observation which took me an inhumane >>>>>>>>> amount of
>>>>>>>>>>>>>>>> debug prints to find.. perhaps there's a better reason behind >>>>>>>>> this, but
>>>>>>>>>>>>>>>> I can't seem to find any answers.. Therefore, this is a BIG RFC!
>>>>>>>>>>>>>>> I'm adding two people from codeaurora who worked a lot on this >>>>>>>> driver.
>>>>>>>>>>>>>>> Hopefully they will have an idea :)
>>>>>>>>>>>>>> Sadre, I've spent a significant amount of time reviewing your >>>>>>> patches,
>>>>>>>>>>>>>> now it's your turn to not take a month to answer to your peers
>>>>>>>>>>>>>> proposals.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Please help reviewing this patch.
>>>>>>>>>>>>> Sorry. I was hoping that Qcom folks would chime in as I don't >>>>>> have any idea
>>>>>>>>>>>>> about the mdm9607 platform. It could be that the mail server >>>>>> migration from
>>>>>>>>>>>>> codeaurora to quicinc put a barrier here.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Let me ping them internally.
>>>>>>>>>>>> Oh, ok, I didn't know. Thanks!
>>>>>>>>>>>      Sorry Miquel, somehow we did not get this email in our inbox.
>>>>>>>>>>>      Thanks to Mani for pinging us, we will test this up today and >>>> get back.
>>>>>>>>>>         While we could not reproduce this issue on our ipq boards (do >>> not have a mdm9607 right now) and
>>>>>>>>>>          issue does not look any obvious.
>>>>>>>>>>         can you please give the debug logs that you did for the above >>> stage by stage ?
>>>>>>>>> I won't have access to the board for about two weeks, sorry.
>>>>>>>>>
>>>>>>>>> When I get to it, I'll surely try to send you the logs, though there
>>>>>>>>>
>>>>>>>>> wasn't much more than just something jumping to who-knows-where
>>>>>>>>>
>>>>>>>>> after clear_bam_transaction was called, resulting in values >> associated with
>>>>>>>>>
>>>>>>>>> the NAND being all zeroed out in pr_err/_debug/etc.
>>>>>>>>>
>>>>>>>>       Ok sure. So was the READID command itself failing (or) the > subsequent one ?
>>>>>>>>      We can check which parameter reset by the clear_bam_transaction is > causing the
>>>>>>>>      failure.  Meanwhile, looping in Pradeep who has access to the > board, so in a better
>>>>>>>>      position to debug.
>>>>>>> I'm sorry I have so few details on hand, and no kernel tree (no access to that machine either, for now).
>>>>>>>
>>>>>>>
>>>>>>> I will try to describe to the best of my abilities what I recall.
>>>>>>>
>>>>>>>
>>>>>>> My methodology of making sure things don't go haywire was to print the oob size
>>>>>>>
>>>>>>> of our NAND basically every two lines of code (yes, i was very desperate at one point),
>>>>>>>
>>>>>>> as that was zeroed out when *the bug* happened,
>>>>>> This does look like a pointer error at some point and some kernel data
>>>>>> has been corrupted very badly by the driver.
>>>>>>
>>>>>>> leading to a kernel bug/panic/stall
>>>>>>>
>>>>>>> (can't recall what exactly it was, but it said something along the lines of "no support for
>>>>>>>
>>>>>>> oob size 0" and then it didn't fail graceully, leading to some bad jumps and ultimately
>>>>>>>
>>>>>>> a dead platform..)
>>>>>>>
>>>>>>>
>>>>>>> after hours of digging, I found out that everything goes fine until clear_bam_transaction is called,
>>>>>> Do you remember if this function was called for the first time when
>>>>>> this happened?
>>>>> I think so, if I recall correctly there are no more callers in this path, as readid is the first nand command executed in flash probe flow.
>>>>>
>>>>>
>>>>>
>>>>>>> after that gets executed every nand op starts reading all zeroes (for example in JEDEC ID check)
>>>>>>>
>>>>>>> so I added the changes from this patch, and things magically started working... My suspicion is
>>>>>>>
>>>>>>> that the underlying FIFO isn't fully drained (is it a FIFO on 9607? bah, i work on too many socs at once)
>>>>>> I don't see it in the list of supported devices, what's the exact
>>>>>> compatible used?
>>>>> qcom,ipq4019-nand
>>>>>
>>>>>
>>>>>
>>>>>>> and this function only makes Linux think it is, without actually draining it, and the leftover
>>>>>>>
>>>>>>> commands get executed with some parts of them getting overwritten, resulting in the
>>>>>>>
>>>>>>> famous garbage in - garbage out situation, but that's only a guesstimate..
>>>>>> I would bet for a non allocated bam-ish pointer that is reset to zero
>>>>>> in the clear_bam_transaction() helper.
>>>>>>
>>>>>> Can you get your hands on the board again?
>>>>> Sure, but as I mentioned previously, only in about 2 weeks, I can't really do any dev before then.. :(
>>>>>
>>>>>
>>>>>
>>>>>> It would be nice to check if the allocation always occurs before use,
>>>>>> and if yes on how much bytes.
>>>>>>
>>>>>> If the pointer is not dangling, then perhaps something else smashes
>>>>>> that pointer.
>>>>>
>>>>> Konrad
>>>>>
>>>>>>> Do note this somehow worked fine on 5.11 and then broke on 5.12/13. I went as far as replacing most
>>>>>>>
>>>>>>> of the kernel with the updated/downgraded parts via git checkout (i tried many combinations),
>>>>>>>
>>>>>>> to no avail.. I even tried different compilers and optimization levels, thinking it could have been
>>>>>>>
>>>>>>> a codegen issue, but no luck either.
>>>>>>>
>>>>>>>
>>>>>>> I.. do understand this email is a total mess to read, as much as it was to write, but
>>>>>>>
>>>>>>> without access to my code and the machine itself I can't give you solid details, and
>>>>>>>
>>>>>>> the fact this situation is far from ordinary doesn't help either..
>>>>>>>
>>>>>>>
>>>>>>> The latest (ancient, not quite pretty, but probably working if my memory is correct) version of my patches
>>>>>>>
>>>>>>> for the mdm9607 is available at [1], I will push the new revision after I get access to the workstation.
>>>>>>>
>>>>    + few more who have access to the board.
>>>>
>>>>     Going by the description, for kernel corruption, we can try out a KASAN build.
>>>>     Since you have mentioned it worked till 5.11, you bisected the driver till 5.11 head and it worked ?
>>>>
>>>     Tried running a KASAN enabled image on IPQ board, but no luck. Nothing came out.
>>>     Only if someone with the board can help here, we can proceed
>>>
>>>
>>> Regards,
>>>    Sricharan
>>>
>> I have the board with me again. Please tell me where do we start :)
> 
>  Sorry for the delayed response.
[Looks at the calendar] What can I say... lots of things happened :)


> 
>      As a first step, Can you enable KASAN and check if you get any warnings ?
> 
>      Then, can you check inside clear_bam_transaction, which parameter resetting specifically is causing the issue ?
> 
I have 3 logs for you:

[1] is KASAN=y, with this patch
[2] is KASAN=y, WITHOUT this patch (should die, but doesn't - does KASAN prevent it from doing something stupid?)
[3] is KASAN=n, WITHOUT this patch (dies as expected)

Looks like there's a lot happening..


Konrad
> 
> Regards,
>   Sricharan
> 
> 

[1] https://paste.debian.net/1233873/
[2] https://paste.debian.net/1233874/
[3] https://paste.debian.net/1233878/
