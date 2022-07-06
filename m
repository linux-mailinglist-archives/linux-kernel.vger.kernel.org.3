Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43656919E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiGFSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:21:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81F1EACD;
        Wed,  6 Jul 2022 11:21:29 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o99eP-0001yD-Im; Wed, 06 Jul 2022 20:21:25 +0200
Message-ID: <8ee1bc75-3ecd-9d87-b7cc-37ba15133026@leemhuis.info>
Date:   Wed, 6 Jul 2022 20:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
Content-Language: en-US
To:     torvic9@mailbox.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <272584304.305738.1657029005216@office.mailbox.org>
 <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
 <MN0PR12MB61015A04C6E4202B2E8E08A9E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
 <72419963.329229.1657096948079@office.mailbox.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <72419963.329229.1657096948079@office.mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1657131689;5fec622f;
X-HE-SMSGID: 1o99eP-0001yD-Im
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.22 10:42, torvic9@mailbox.org wrote:
> 
>> Limonciello, Mario <mario.limonciello@amd.com> hat am 05.07.2022 17:10 GMT geschrieben:
>>> -----Original Message-----
>>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>> Sent: Tuesday, July 5, 2022 11:40
>>> To: Tor Vic <torvic9@mailbox.org>
>>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>>> Hans de Goede <hdegoede@redhat.com>; Jani Nikula
>>> <jani.nikula@intel.com>
>>> Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
>>>
>>> On Tue, Jul 5, 2022 at 6:50 AM <torvic9@mailbox.org> wrote:
>>>>
>>>> Linux 5.19-rc5 does not boot on my Kaby Lake Thinkpad.
>>>> rc3 and rc4 were still fine, so I guess something between rc4 and rc5
>>>> introduced a regression.
>>>
>>> Sounds that way.
>>>
>>>> Unfortunately, there are no errors or warning messages.
>>>> It gets stuck quite early on boot, about the time USB is initialized,
>>>> so less than 1 second into post-bootloader boot.
>>>> It then just sits there doing nothing - SysRq still works though.
>>>
>>> There aren't all that many changes in rc5, and your hardware looks
>>> *very* standard (all intel chipset, and a Samsung SM961 SSD).
>>>
>>> And with the lack of details, we'll either need a bisect:
>>>
>>>> I don't have time for a bisect, but I thought I'll let you know about
>>>> this issue, and maybe someone already has an idea.
>>>
>>> or we'll need more reports..
>>>
>>>> Some system information below. Root filesystem is f2fs.
>>>
>>> Ok, f2fs is certainly unusual, but there are no f2fs changes in rc5.
>>>
>>> There's some PM changes for i915 ("drm/i915/dgfx: Disable d3cold at
>>> gfx root port") and a couple of thinkpad-acpi platform driver updates,
>>> so I'm adding a few random people to the cc in case somebody goes
>>> "ahh..."
>>>
>>
>> If a bisect isn't possible for you the kernel command line should be pretty
>> helpful to isolate which area the problem is introduced.
>> I'd say start out with "nomodeset" on the kernel command line to prevent
>> i915 from loading.  If that fixes it, hopefully it's a small number of commits
>> to peel back like the one Linus mentioned.
> 
> Good advice!
> Using "nomodeset" makes the computer boot again.

Wild guess, I'm not involved at all in any of the following, I just
noticed it and thought it might be worth mentioning:

I heard Fedora rawhide added this patch to solve a boot problem that
sounded similar to yours:
https://patchwork.freedesktop.org/patch/489982/

See also this thread:
https://lore.kernel.org/all/fddf5ca6-77dc-88f9-c191-7de09717063c@redhat.com/

A few config option are mentioned there that seem to have an impact.
Maybe it's worth changing those or trying that patch.

But as I said, I'm not involved, so maybe this is a bad advice.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
