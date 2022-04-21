Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA95096E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384471AbiDUFiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiDUFiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:38:52 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875612093
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:36:02 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae8f0.dynamic.kabel-deutschland.de [95.90.232.240])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 181F461CCD7D8;
        Thu, 21 Apr 2022 07:35:59 +0200 (CEST)
Message-ID: <294555b4-2d1b-270f-6682-3a17e9df133c@molgen.mpg.de>
Date:   Thu, 21 Apr 2022 07:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based
 systems
Content-Language: en-US
To:     Richard Gong <richard.gong@amd.com>
Cc:     Dave Airlie <airlied@linux.ie>, Xinhui Pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Alexander Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20220412215000.897344-1-richard.gong@amd.com>
 <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
 <CADnq5_MgvcGPWf2gYn_3qCr+Gq1P39tvv-W-o8NhivvMpMwUBA@mail.gmail.com>
 <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de>
 <94fd858d-1792-9c05-b5c6-1b028427687d@amd.com>
 <efc1dfd1-2b54-aee5-1497-4b800a468141@molgen.mpg.de>
 <237da02b-0ed8-6b1c-3eaf-5574aab4f13f@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <237da02b-0ed8-6b1c-3eaf-5574aab4f13f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Richard,


Am 21.04.22 um 03:12 schrieb Gong, Richard:

> On 4/20/2022 3:29 PM, Paul Menzel wrote:

>> Am 19.04.22 um 23:46 schrieb Gong, Richard:
>>
>>> On 4/14/2022 2:52 AM, Paul Menzel wrote:
>>>> [Cc: -kernel test robot <lkp@intel.com>]
>>
>> […]
>>
>>>> Am 13.04.22 um 15:00 schrieb Alex Deucher:
>>>>> On Wed, Apr 13, 2022 at 3:43 AM Paul Menzel wrote:
>>>>
>>>>>> Thank you for sending out v4.
>>>>>>
>>>>>> Am 12.04.22 um 23:50 schrieb Richard Gong:
>>>>>>> Active State Power Management (ASPM) feature is enabled since 
>>>>>>> kernel 5.14.
>>>>>>> There are some AMD GFX cards (such as WX3200 and RX640) that 
>>>>>>> won't work
>>>>>>> with ASPM-enabled Intel Alder Lake based systems. Using these GFX 
>>>>>>> cards as
>>>>>>> video/display output, Intel Alder Lake based systems will hang 
>>>>>>> during
>>>>>>> suspend/resume.
>>
>> [Your email program wraps lines in cited text for some reason, making 
>> the citation harder to read.]
>>
> Not sure why, I am using Mozila Thunderbird for email. I am not using MS 
> Outlook for upstream email.

Strange. No idea if there were bugs in Mozilla Thunderbird 91.2.0, 
released over half year ago. The current version is 91.8.1. [1]

>>>>>> I am still not clear, what “hang during suspend/resume” means. I 
>>>>>> guess
>>>>>> suspending works fine? During resume (S3 or S0ix?), where does it 
>>>>>> hang?
>>>>>> The system is functional, but there are only display problems?
>>> System freeze after suspend/resume.
>>
>> But you see certain messages still? At what point does it freeze 
>> exactly? In the bug report you posted Linux messages.
> 
> No, the system freeze then users have to recycle power to recover.

Then I misread the issue? Did you capture the messages over serial log then?

>>>>>>> The issue was initially reported on one system (Dell Precision 
>>>>>>> 3660 with
>>>>>>> BIOS version 0.14.81), but was later confirmed to affect at least 
>>>>>>> 4 Alder
>>>>>>> Lake based systems.
>>>>>>>
>>>>>>> Add extra check to disable ASPM on Intel Alder Lake based systems.
>>>>>>>
>>>>>>> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
>>>>>>> Link: 
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1885&amp;data=05%7C01%7Crichard.gong%40amd.com%7Cce01de048c61456174ff08da230c750d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637860833680922036%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=vqhh3dTc%2FgBt7GrP9hKppWlrFy2F7DaivkNEuGekl0g%3D&amp;reserved=0 
>>>>>>>
>>
>> Thank you Microsoft Outlook for keeping us safe. :(
> I am not using MS Outlook for the email exchanges.

I guess, it’s not the client but the Microsoft email service (Exchange?) 
no idea adding these protection links. (Making it even harder for users 
to actually verify domain. No idea who comes up with these ideas, and 
customers actually accepting those.)

>>>>>>>
>>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> This tag is a little confusing. Maybe clarify that it was for an 
>>>>>> issue
>>>>>> in a previous patch iteration?
>>>
>>> I did describe in change-list version 3 below, which corrected the 
>>> build error with W=1 option.
>>>
>>> It is not good idea to add the description for that to the commit 
>>> message, this is why I add descriptions on change-list version 3.
>>
>> Do as you wish, but the current style is confusing, and readers of the 
>> commit are going to think, the kernel test robot reported the problem 
>> with AMD VI ASICs and Intel Alder Lake systems.
>>
>>>>>>
>>>>>>> Signed-off-by: Richard Gong <richard.gong@amd.com>
>>>>>>> ---
>>>>>>> v4: s/CONFIG_X86_64/CONFIG_X86
>>>>>>>       enhanced check logic
>>>>>>> v3: s/intel_core_asom_chk/aspm_support_quirk_check
>>>>>>>       correct build error with W=1 option
>>>>>>> v2: correct commit description
>>>>>>>       move the check from chip family to problematic platform
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/vi.c | 17 ++++++++++++++++-
>>>>>>>    1 file changed, 16 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vi.c
>>>>>>> index 039b90cdc3bc..b33e0a9bee65 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>>>>>>> @@ -81,6 +81,10 @@
>>>>>>>    #include "mxgpu_vi.h"
>>>>>>>    #include "amdgpu_dm.h"
>>>>>>>
>>>>>>> +#if IS_ENABLED(CONFIG_X86)
>>>>>>> +#include <asm/intel-family.h>
>>>>>>> +#endif
>>>>>>> +
>>>>>>>    #define ixPCIE_LC_L1_PM_SUBSTATE    0x100100C6
>>>>>>>    #define 
>>>>>>> PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK 0x00000001L
>>>>>>>    #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK 
>>>>>>> 0x00000002L
>>>>>>> @@ -1134,13 +1138,24 @@ static void vi_enable_aspm(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>                WREG32_PCIE(ixPCIE_LC_CNTL, data);
>>>>>>>    }
>>>>>>>
>>>>>>> +static bool aspm_support_quirk_check(void)
>>>>>>> +{
>>>>>>> +     if (IS_ENABLED(CONFIG_X86)) {
>>>>>>> +             struct cpuinfo_x86 *c = &cpu_data(0);
>>>>>>> +
>>>>>>> +             return !(c->x86 == 6 && c->x86_model == 
>>>>>>> INTEL_FAM6_ALDERLAKE);
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return true;
>>>>>>> +}
>>>>>>> +
>>>>>>>    static void vi_program_aspm(struct amdgpu_device *adev)
>>>>>>>    {
>>>>>>>        u32 data, data1, orig;
>>>>>>>        bool bL1SS = false;
>>>>>>>        bool bClkReqSupport = true;
>>>>>>>
>>>>>>> -     if (!amdgpu_device_should_use_aspm(adev))
>>>>>>> +     if (!amdgpu_device_should_use_aspm(adev) || 
>>>>>>> !aspm_support_quirk_check())
>>>>>>>                return;
>>>>>>
>>>>>> Can users still forcefully enable ASPM with the parameter 
>>>>>> `amdgpu.aspm`?
>>>>>>
>>> As Mario mentioned in a separate reply, we can't forcefully enable 
>>> ASPM with the parameter 'amdgpu.aspm'.
>>
>> That would be a regression on systems where ASPM used to work. Hmm. I 
>> guess, you could say, there are no such systems.
>>
>>>>>>>
>>>>>>>        if (adev->flags & AMD_IS_APU ||
>>>>>>
>>>>>> If I remember correctly, there were also newer cards, where ASPM 
>>>>>> worked
>>>>>> with Intel Alder Lake, right? Can only the problematic generations 
>>>>>> for
>>>>>> WX3200 and RX640 be excluded from ASPM?
>>>>>
>>>>> This patch only disables it for the generatioaon that was problematic.
>>>>
>>>> Could that please be made clear in the commit message summary, and 
>>>> message?
>>>
>>> Are you ok with the commit messages below?
>>
>> Please change the commit message summary. Maybe:
>>
>> drm/amdgpu: VI: Disable ASPM on Intel Alder Lake based systems
>>
>>> Active State Power Management (ASPM) feature is enabled since kernel 
>>> 5.14.
>>>
>>> There are some AMD GFX cards (such as WX3200 and RX640) that won't work
>>> with ASPM-enabled Intel Alder Lake based systems. Using these GFX 
>>> cards as
>>> video/display output, Intel Alder Lake based systems will freeze after
>>> suspend/resume.
>>
>> Something like:
>>
>> On Intel Alder Lake based systems using ASPM with AMD GFX Volcanic 
>> Islands (VI) cards, like WX3200 and RX640, graphics don’t initialize 
>> when resuming from S0ix(?).
>>
>>
>>> The issue was initially reported on one system (Dell Precision 3660 with
>>> BIOS version 0.14.81), but was later confirmed to affect at least 4 
>>> Alder
>>> Lake based systems.
>>
>> Which ones?
> those are pre-production Alder Lake based OEM systems

Just write that then: at least four pre-production Alder Lake based systems.

>>> Add extra check to disable ASPM on Intel Alder Lake based systems with
>>> problematic generation GFX cards.
>>
>> … with the problematic Volcanic Islands GFX cards.
>>
>>>>
>>>> Loosely related, is there a public (or internal issue) to analyze 
>>>> how to get ASPM working for VI generation devices with Intel Alder 
>>>> Lake?
>>>
>>> As Alex mentioned, we need support from Intel. We don't have any 
>>> update on that.
>>
>> It’d be great to get that fixed properly.
>>
>> Last thing, please don’t hate me, does Linux log, that ASPM is disabled?


Kind regards,

Paul


[1]: https://www.thunderbird.net/en-US/thunderbird/releases/
