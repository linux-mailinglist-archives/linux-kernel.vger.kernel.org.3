Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF65569240
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiGFS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGFS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:56:19 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361512A941;
        Wed,  6 Jul 2022 11:56:17 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4LdTK74dyDz9sS6;
        Wed,  6 Jul 2022 20:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1657133771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWRQ34WBwUcgZFnDVii0kRTol59eMnvDdmOFJDSqIlM=;
        b=Qlzj0j8gY1Bn+osmzzywPIUHBhOyWzU3O6IDByYpwfi0j1C7dp1Esw1nlxeoBslbtzilJm
        rmyorlJsC6zC/s0VE0u23V5bzAnLtuwjUJM7SKhoSlZ9wXgc29ba5c6BK1nZu/2w+KvSl9
        /j+ZhE91NY/ixoBvRAPDrMe7p5BKV5w/F0vY6pvzb17/avB670q+nXgGzXqQ0HVr/ddRai
        QTrwUJGsWIYr5sAIXS1zdKdzwaijIgXzdAopBK6c//WlyzUa2oDlHRzJM5m6bvqNQ5IxNf
        vsbXWicVS6avS07xWPc30dYmaCk0SwyfFN/bHHjpZgG4akmwNDAUQ+HpXvt/Cg==
Message-ID: <b73295d8-d3e6-c6b8-de76-d82a5ae7ee42@mailbox.org>
Date:   Wed, 6 Jul 2022 18:56:04 +0000
MIME-Version: 1.0
Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
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
 <8ee1bc75-3ecd-9d87-b7cc-37ba15133026@leemhuis.info>
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <8ee1bc75-3ecd-9d87-b7cc-37ba15133026@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 66bb31361032e829da4
X-MBO-RS-META: u68cyx87wwpwomnx367d5ut8eqok4ekg
X-Rspamd-Queue-Id: 4LdTK74dyDz9sS6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.07.22 18:21, Thorsten Leemhuis wrote:
> On 06.07.22 10:42, torvic9@mailbox.org wrote:
>>
>>> Limonciello, Mario <mario.limonciello@amd.com> hat am 05.07.2022 17:10 GMT geschrieben:
>>>> -----Original Message-----
>>>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Sent: Tuesday, July 5, 2022 11:40
>>>> To: Tor Vic <torvic9@mailbox.org>
>>>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>>>> Hans de Goede <hdegoede@redhat.com>; Jani Nikula
>>>> <jani.nikula@intel.com>
>>>> Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
>>>>
>>>> On Tue, Jul 5, 2022 at 6:50 AM <torvic9@mailbox.org> wrote:
>>>>>
>>>>> Linux 5.19-rc5 does not boot on my Kaby Lake Thinkpad.
>>>>> rc3 and rc4 were still fine, so I guess something between rc4 and rc5
>>>>> introduced a regression.
>>>>
>>>> Sounds that way.
>>>>
>>>>> Unfortunately, there are no errors or warning messages.
>>>>> It gets stuck quite early on boot, about the time USB is initialized,
>>>>> so less than 1 second into post-bootloader boot.
>>>>> It then just sits there doing nothing - SysRq still works though.
>>>>
>>>> There aren't all that many changes in rc5, and your hardware looks
>>>> *very* standard (all intel chipset, and a Samsung SM961 SSD).
>>>>
>>>> And with the lack of details, we'll either need a bisect:
>>>>
>>>>> I don't have time for a bisect, but I thought I'll let you know about
>>>>> this issue, and maybe someone already has an idea.
>>>>
>>>> or we'll need more reports..
>>>>
>>>>> Some system information below. Root filesystem is f2fs.
>>>>
>>>> Ok, f2fs is certainly unusual, but there are no f2fs changes in rc5.
>>>>
>>>> There's some PM changes for i915 ("drm/i915/dgfx: Disable d3cold at
>>>> gfx root port") and a couple of thinkpad-acpi platform driver updates,
>>>> so I'm adding a few random people to the cc in case somebody goes
>>>> "ahh..."
>>>>
>>>
>>> If a bisect isn't possible for you the kernel command line should be pretty
>>> helpful to isolate which area the problem is introduced.
>>> I'd say start out with "nomodeset" on the kernel command line to prevent
>>> i915 from loading.  If that fixes it, hopefully it's a small number of commits
>>> to peel back like the one Linus mentioned.
>>
>> Good advice!
>> Using "nomodeset" makes the computer boot again.
> 
> Wild guess, I'm not involved at all in any of the following, I just
> noticed it and thought it might be worth mentioning:
> 
> I heard Fedora rawhide added this patch to solve a boot problem that
> sounded similar to yours:
> https://patchwork.freedesktop.org/patch/489982/
> 
> See also this thread:
> https://lore.kernel.org/all/fddf5ca6-77dc-88f9-c191-7de09717063c@redhat.com/

Hi Thorsten,

Yep, that sounds just like it!
I do have 'CONFIG_SYSFB_SIMPLEFB=y' in my laptop's config.

Will try this tomorrow and report back again.

> 
> A few config option are mentioned there that seem to have an impact.
> Maybe it's worth changing those or trying that patch.
> 
> But as I said, I'm not involved, so maybe this is a bad advice.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
