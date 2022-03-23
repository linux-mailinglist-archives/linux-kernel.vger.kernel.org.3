Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482D14E4E57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbiCWIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCWIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:38:19 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D95312639;
        Wed, 23 Mar 2022 01:36:49 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5ae903.dynamic.kabel-deutschland.de [95.90.233.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BC0B461E6478B;
        Wed, 23 Mar 2022 09:36:47 +0100 (CET)
Message-ID: <b3e4435d-335c-1aba-1920-c225b46d09e7@molgen.mpg.de>
Date:   Wed, 23 Mar 2022 09:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Mario Limonciello <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
 <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Damien,


Am 23.03.22 um 09:24 schrieb Damien Le Moal:
> On 3/23/22 15:55, Paul Menzel wrote:

>> Am 23.03.22 um 06:01 schrieb Damien Le Moal:
>>> On 3/22/22 06:51, Limonciello, Mario wrote:

>>>>> -----Original Message-----
>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>> Sent: Monday, March 21, 2022 16:25
>>
>> […]
>>
>>>> I seem to recall that we were talking about trying to drop the debounce delay for
>>>> everything, weren't we?
>>>>
>>>> So perhaps it would be right to add a 4th patch in the series to do just that.  Then
>>>> If this turns out to be problematic for anything other than the controllers in the
>>>> series that you identified as not problematic then that 4th patch can potentially
>>>> be reverted alone?
>>>
>>> Not quite everything :) But you are right, let's try to switch the default
>>> to no delay. I will be posting patches today for that.
>>>
>>> Paul,
>>>
>>> With these patches, your patches are not necessary anymore as the AMD
>>> chipset falls under the default no-delay.
>>
>> I am all for improving the situation for all devices, but I am unable to
>> judge the regression potential of changing this, as it affects a lot of
>> devices. I guess it’d would go through the next tree, and hopefully the
>> company QA teams can give it a good spin. I hoped that my patches, as I
>> have tested them, and AMD will hopefully too, could go into the current
>> merge window.
> 
> Yes, correct, the plan is to get the generic series queued as soon as rc1
> so that it can spend plenty of time in linux-next for people to test. That
> will hopefully reduce the risk of breaking things in the field. Same for
> the default LPM change.

But 5.18 or 5.19? If 5.18, sounds good to me, if 5.19, I’d be great if 
my patches go into 5.18 cycle, as they have been tested, and it would 
mean the whole change gets tested more widely already.

> With the default removal of the debounce delay, your patches addressing
> only the AMD adapter are not needed anymore: this adapter will not have a
> debounce delay unless the ATA_LFLAG_DEBOUNCE_DELAY flag is set.

Yes, I understand.

>>> It would be nice if you can test though.
>>
>> Of course, I am going to that either way.
> 
> Series posted with you on CC. Please test !

Thank you. I am going to test it in the coming days, and report back.

Maybe more people should be put in Cc (Dell, Lenovo, IBM, x86 subsystem) 
with a request to test this?


Kind regards,

Paul
