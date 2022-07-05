Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128895668CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiGEK64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiGEK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:57:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A827175A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:57:21 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o8gF4-0004up-Rj; Tue, 05 Jul 2022 12:57:18 +0200
Message-ID: <4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info>
Date:   Tue, 5 Jul 2022 12:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state
 when running on e.g. Xen
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
 <8756355c-b586-3d1b-531c-72a04a8c047a@leemhuis.info>
 <05b5e672-0a1b-2d00-a879-b5127a94973f@suse.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <05b5e672-0a1b-2d00-a879-b5127a94973f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1657018641;7415d32a;
X-HE-SMSGID: 1o8gF4-0004up-Rj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing tglx, mingo, Boris and Juergen]

On 04.07.22 14:26, Jan Beulich wrote:
> On 04.07.2022 13:58, Thorsten Leemhuis wrote:
>> On 25.05.22 10:55, Jan Beulich wrote:
>>> On 28.04.2022 16:50, Jan Beulich wrote:
>>>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
>>>> with pat_enabled()") pat_enabled() returning false (because of PAT
>>>> initialization being suppressed in the absence of MTRRs being announced
>>>> to be available) has become a problem: The i915 driver now fails to
>>>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
>>>> located the induced failure), and its error handling is flaky enough to
>>>> (at least sometimes) result in a hung system.
>>>>
>>>> Yet even beyond that problem the keying of the use of WC mappings to
>>>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
>>>> graphics frame buffer accesses would have been quite a bit less
>>>> performant than possible.
>>>>
>>>> Arrange for the function to return true in such environments, without
>>>> undermining the rest of PAT MSR management logic considering PAT to be
>>>> disabled: Specifically, no writes to the PAT MSR should occur.
>>>>
>>>> For the new boolean to live in .init.data, init_cache_modes() also needs
>>>> moving to .init.text (where it could/should have lived already before).
>>>>
>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>
>>> The Linux kernel regression tracker is pestering me because things are
>>> taking so long (effectively quoting him), and alternative proposals
>>> made so far look to have more severe downsides.
>>
>> Has any progress been made with this patch? It afaics is meant to fix
>> this regression, which ideally should have been fixed weeks ago (btw:
>> adding a "Link:" tag pointing to it would be good):
>> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
>>
>> According to Juergen it's still needed:
>> https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
>>
>> Or was a different solution found to fix that regression?
> 
> No progress and no alternatives I'm aware of.

Getting closer to the point where I need to bring this to Linus
attention. I hope this mail can help avoiding this.

Jan, I didn't follow this closely, but do you have any idea why Dave,
Luto, and Peter are ignoring this? Is reverting bdd8b6c98239 a option to
get the regression fixed? Would a repost maybe help getting this rolling
again?

BTW, for anyone new to this, Jan's patch afaics is supposed to fix the
regression reported here:
https://lore.kernel.org/all/YnHK1Z3o99eMXsVK@mail-itl/

Side note: Juergen Gross recently posted related patches in this code
area to fix some other problems (regressions?), but his efforts look
stalled, too:
https://lore.kernel.org/all/ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com/

And he recently stated this Jan's patch is still needed, even if his
changes make it in.
https://lore.kernel.org/all/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/

This from my point all looks a bit... unsatisfying. :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
