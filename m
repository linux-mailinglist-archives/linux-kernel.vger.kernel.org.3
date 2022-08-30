Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7B5A5EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiH3JGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiH3JF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:05:58 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C39D8D5;
        Tue, 30 Aug 2022 02:05:56 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DADF961EA1933;
        Tue, 30 Aug 2022 11:05:53 +0200 (CEST)
Message-ID: <893fe832-d522-112e-53ec-0f030c15af0d@molgen.mpg.de>
Date:   Tue, 30 Aug 2022 11:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
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
 <3135eed0-b7e3-42fa-5b6c-80360f34e428@opensource.wdc.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <3135eed0-b7e3-42fa-5b6c-80360f34e428@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Damien,


Sorry for the late reply, and thank you for your great work.

Am 01.06.22 um 10:58 schrieb Damien Le Moal:
> On 6/1/22 01:18, Paul Menzel wrote:
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
>> I just wanted to inquire about the status of your changes? I do not find
>> them in your `for-5.19` branch. As they should be tested in linux-next
>> before the merge window opens, if these are not ready yet, could you
>> please apply my (tested) patches?
> 
> I could, but 5.19 now has an updated libata.force kernel parameter that
> allows one to disable the debounce delay for a particular port or for all
> ports of an adapter. See libata.force=x.y:nodbdelay for a port y of
> adapter x or libata.force=x:nodbdelay for all ports of adapter x.

This is commit 3af9ca4d341d (ata: libata-core: Improve link flags forced 
settings) [1]. Thank you, this is really useful, but easily overlooked. ;-)

> I still plan to revisit the arbitrary link debounce timers but I prefer to
> have the power management cleanup applied first. The reason is that link
> debounce depends on PHY readiness, which itself depends heavily on power
> mode transitions. My plan is to get this done during this cycle for
> release with 5.20 and then fix on top the arbitrary delays for 5.21.

Nice. Can you share the current status?

> Is the libata.force solution OK for you until we have a final more solid
> fix that can benefit most modern adapters (and not just the ones you
> identified)? If you do have a use case that needs a "nodbdelay" horkage
> due to some constraint in the field, then I will apply your patches, but
> they likely will be voided by coming changes. Let me know.

I think, applying the patch would be an improvement, as people wouldn’t 
need to update their Linux kernel command line, and I do not mind, if it 
gets reverted/dropped later.


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3af9ca4d341d2b8756fa9056ca0715915480e251
