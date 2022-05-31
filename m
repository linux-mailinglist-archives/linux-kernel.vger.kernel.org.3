Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34645394EC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbiEaQYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiEaQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:24:38 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D695DC9;
        Tue, 31 May 2022 09:24:36 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5aeb8b.dynamic.kabel-deutschland.de [95.90.235.139])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C74A261EA1929;
        Tue, 31 May 2022 18:24:34 +0200 (CEST)
Message-ID: <17b11dc6-c31f-4452-c0e8-b450528cb26a@molgen.mpg.de>
Date:   Tue, 31 May 2022 18:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Mario Limonciello <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
 <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
 <b3e4435d-335c-1aba-1920-c225b46d09e7@molgen.mpg.de>
 <f6c78650-f22f-fcaf-a660-b1fc4ea7f641@molgen.mpg.de>
 <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
 <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
 <85f8c8cb-b4b9-b3ed-e79f-a1a161c9b672@opensource.wdc.com>
 <65012735-0a92-1071-e8e0-9d101c247a64@molgen.mpg.de>
 <35f3901c-45cf-dacc-c25e-67c2b9ca61f0@molgen.mpg.de>
In-Reply-To: <35f3901c-45cf-dacc-c25e-67c2b9ca61f0@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Now really. Sorry for the spam.]

Am 31.05.22 um 18:21 schrieb Paul Menzel:
> [Cc: -Nehal-bakulchandra (undeliverable)]
> 
> Am 31.05.22 um 18:18 schrieb Paul Menzel:
>> Dear Damien,
>>
>>
>> Am 01.04.22 um 09:23 schrieb Damien Le Moal:
>>> On 4/1/22 14:18, Paul Menzel wrote:
>>
>> […]
>>
>>>> Am 01.04.22 um 01:04 schrieb Damien Le Moal:
>>>>> On 3/31/22 23:42, Paul Menzel wrote:
>>>>
>>>>>> Am 23.03.22 um 09:36 schrieb Paul Menzel:
>>>>>>
>>>>>>> Am 23.03.22 um 09:24 schrieb Damien Le Moal:
>>>>>>>> On 3/23/22 15:55, Paul Menzel wrote:
>>>>>>>
>>>>>>>>> Am 23.03.22 um 06:01 schrieb Damien Le Moal:
>>>>>>>>>> On 3/22/22 06:51, Limonciello, Mario wrote:
>>>>>>>
>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>>>>>>>>> Sent: Monday, March 21, 2022 16:25
>>>>>>>>>
>>>>>>>>> […]
>>>>>>>>>
>>>>>>>>>>> I seem to recall that we were talking about trying to drop the
>>>>>>>>>>> debounce delay for everything, weren't we?
>>>>>>>>>>>
>>>>>>>>>>> So perhaps it would be right to add a 4th patch in the series 
>>>>>>>>>>> to do
>>>>>>>>>>> just that.  Then If this turns out to be problematic for
>>>>>>>>>>> anything other than the controllers in the series that you
>>>>>>>>>>> identified as not problematic then that 4th patch can
>>>>>>>>>>> potentially be reverted alone?
>>>>>>>>>>
>>>>>>>>>> Not quite everything :) But you are right, let's try to switch the
>>>>>>>>>> default to no delay. I will be posting patches today for that.
>>>>>>>>>> With these patches, your patches are not necessary anymore as the AMD
>>>>>>>>>> chipset falls under the default no-delay.
>>>>>>>>>
>>>>>>>>> I am all for improving the situation for all devices, but I am unable to
>>>>>>>>> judge the regression potential of changing this, as it affects a lot of
>>>>>>>>> devices. I guess it’d would go through the next tree, and hopefully the
>>>>>>>>> company QA teams can give it a good spin. I hoped that my patches, as I
>>>>>>>>> have tested them, and AMD will hopefully too, could go into the current
>>>>>>>>> merge window.
>>>>>>>>
>>>>>>>> Yes, correct, the plan is to get the generic series queued as soon
>>>>>>>> as rc1 so that it can spend plenty of time in linux-next for people
>>>>>>>> to test. That will hopefully reduce the risk of breaking things in
>>>>>>>> the field. Same for  the default LPM change.
>>>>>>>
>>>>>>> But 5.18 or 5.19? If 5.18, sounds good to me, if 5.19, I’d be great if
>>>>>>> my patches go into 5.18 cycle, as they have been tested, and it would
>>>>>>> mean the whole change gets tested more widely already.
>>>>>>>
>>>>>>>> With the default removal of the debounce delay, your patches addressing
>>>>>>>> only the AMD adapter are not needed anymore: this adapter will not have a
>>>>>>>> debounce delay unless the ATA_LFLAG_DEBOUNCE_DELAY flag is set.
>>>>>>>
>>>>>>> Yes, I understand.
>>>>>>
>>>>>> The merge window for Linux 5.18 is going to close in three days this
>>>>>> Sunday. It’d be really great if my patches, tested on hardware, 
>>>>>> could go into that.
>>>>>>
>>>>>>>>>> It would be nice if you can test though.
>>>>>>>>>
>>>>>>>>> Of course, I am going to that either way.
>>>>>>>>
>>>>>>>> Series posted with you on CC. Please test !
>>>>>>>
>>>>>>> Thank you. I am going to test it in the coming days, and report 
>>>>>>> back.
>>>>>>>
>>>>>>> Maybe more people should be put in Cc (Dell, Lenovo, IBM, x86 
>>>>>>> subsystem) with a request to test this?
>>>>>> Thank you for the patches, which are a big improvement. Let’s hope, you
>>>>>> can re-roll them, so they get into Linux very soon for everyone’s 
>>>>>> benefit.
>>>>>
>>>>> I am waiting for 5.18-rc1 to rebase the patches and re-post them. Given
>>>>> reviewed-by and tested-by tags, I will queue them for 5.19.
>>>>
>>>> As discussed in the other thread, it’s impossible to be 100 % certain,
>>>> it won’t break anything.
>>>
>>> Yes, that is why I want to push the patches early in the cycle to be able
>>> to revert if too many problems are reported.
>>>
>>>>> With that in mind, I am not planning to apply your previous patches
>>>>> for 5.18, as they would conflict and would only end up being churn
>>>>> since the delay removal by default will undo your changes.
>>>> Obviously, I do not agree, as this would give the a little bit more
>>>> testing already, if changing the default is a good idea. Also, if the
>>>> conflict will be hard to resolve, I happily do it (the patches could
>>>> even be reverted on top – git commits are cheap and easy to handle).
>>>
>>> The conflict is not hard to resolve. The point is that my patches changing
>>> the default to no debounce delay completely remove the changes of your
>>> patch to do the same for one or some adapters. So adding your patches now
>>> and then my patches on top does not make much sense at all.
>>>
>>> If too many problems show up and I end up reverting/removing the patches,
>>> then I will be happy to take your patches for the adapter you tested. Note
>>> that *all* the machines I have tested so far are OK without a debounce
>>> delay too. So we could add them too... And endup with a long list of
>>> adapters that use the default ahci driver without debounce delay. The goal
>>> of changing the default to no delay is to avoid that. So far, the adapters
>>> I have identified that need the delay have their own declaration, so we
>>> only need to add a flag there. Simpler change that listing up adapters
>>> that are OK without the delay.
>>>
>>>> Anyway, I wrote my piece, but you are the maintainer, so it’s your call
>>>> and I stop bothering you.
>>
>> I just wanted to inquire about the status of your changes? I do not 
>> find them in your `for-5.19` branch. As they should be tested in 
>> linux-next before the merge window opens, if these are not ready yet, 
>> could you please apply my (tested) patches?
>>
>>
>> Kind regards,
>>
>> Paul
