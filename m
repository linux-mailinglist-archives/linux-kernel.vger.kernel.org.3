Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF804F4F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836729AbiDFAjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389310AbiDENdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:33:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D547BE886D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:37:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BE56D6E;
        Tue,  5 Apr 2022 05:37:25 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A44BC3F5A1;
        Tue,  5 Apr 2022 05:37:24 -0700 (PDT)
Message-ID: <e1dc64d3-d5b3-07f1-5fd6-c132fc247bb6@arm.com>
Date:   Tue, 5 Apr 2022 13:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ALSA: emu10k1: Stop using iommu_present()
Content-Language: en-GB
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, iommu@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <5ac9b54285b2189b848da2595408eb3cae8e5e9d.1649160813.git.robin.murphy@arm.com>
 <s5ha6cz7lxt.wl-tiwai@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <s5ha6cz7lxt.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-05 13:29, Takashi Iwai wrote:
> On Tue, 05 Apr 2022 14:13:33 +0200,
> Robin Murphy wrote:
>>
>> iommu_get_domain_for_dev() is already perfectly happy to return NULL
>> if the given device has no IOMMU. Drop the unnecessary check.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> This will change the code behavior.  The current code does nothing if
> no IOMMU is found, but after your removal of the check, the code
> reaches to emu->iommu_workaround = true incorrectly.

Ah, right you are - I should have looked more closely at the second 
check, where of course "domain &&" wants tweaking to "!domain ||" as 
well. I'll send a v2 in a bit...

Thanks,
Robin.

> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>   sound/pci/emu10k1/emu10k1_main.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
>> index 86cc1ca025e4..5ffab343b89c 100644
>> --- a/sound/pci/emu10k1/emu10k1_main.c
>> +++ b/sound/pci/emu10k1/emu10k1_main.c
>> @@ -1751,9 +1751,6 @@ static void snd_emu10k1_detect_iommu(struct snd_emu10k1 *emu)
>>   
>>   	emu->iommu_workaround = false;
>>   
>> -	if (!iommu_present(emu->card->dev->bus))
>> -		return;
>> -
>>   	domain = iommu_get_domain_for_dev(emu->card->dev);
>>   	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
>>   		return;
>> -- 
>> 2.28.0.dirty
>>
