Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4E551026
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiFTGPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiFTGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:15:50 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D263BC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:15:49 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o3AhO-0007Pt-KS; Mon, 20 Jun 2022 08:15:46 +0200
Message-ID: <f6359e71-5516-5b04-ca35-6a4870456cec@leemhuis.info>
Date:   Mon, 20 Jun 2022 08:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     jbeulich@suse.com, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com>
 <fb0eadee-1d45-f414-eda4-a87f01eeb57a@suse.com>
 <effc0c6a-9e4d-b503-e4ba-6c8d2da72699@leemhuis.info>
 <c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655705749;385cc5f6;
X-HE-SMSGID: 1o3AhO-0007Pt-KS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.22 07:30, Juergen Gross wrote:
> On 20.06.22 07:22, Thorsten Leemhuis wrote:
>> On 14.06.22 17:09, Juergen Gross wrote:
>>> On 03.05.22 15:22, Juergen Gross wrote:
>>>> x86_has_pat_wp() is using a wrong test, as it relies on the normal
>>>> PAT configuration used by the kernel. In case the PAT MSR has been
>>>> setup by another entity (e.g. BIOS or Xen hypervisor) it might return
>>>> false even if the PAT configuration is allowing WP mappings.
>>>>
>>>> Fixes: 1f6f655e01ad ("x86/mm: Add a x86_has_pat_wp() helper")
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> ---
>>>>    arch/x86/mm/init.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
>>>> index d8cfce221275..71e182ebced3 100644
>>>> --- a/arch/x86/mm/init.c
>>>> +++ b/arch/x86/mm/init.c
>>>> @@ -80,7 +80,8 @@ static uint8_t __pte2cachemode_tbl[8] = {
>>>>    /* Check that the write-protect PAT entry is set for
>>>> write-protect */
>>>>    bool x86_has_pat_wp(void)
>>>>    {
>>>> -    return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] ==
>>>> _PAGE_CACHE_MODE_WP;
>>>> +    return
>>>> __pte2cachemode_tbl[__cachemode2pte_tbl[_PAGE_CACHE_MODE_WP]] ==
>>>> +           _PAGE_CACHE_MODE_WP;
>>>>    }
>>>>      enum page_cache_mode pgprot2cachemode(pgprot_t pgprot)
>>>
>>> x86 maintainers, please consider taking this patch, as it is fixing
>>> a real bug. Patch 2 of this series can be dropped IMO.
>>
>> Juergen, can you help me out here please. Patch 2 afaics was supposed to
>> fix this regression I'm tracking:
>> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
> No, patch 2 wasn't covering all needed cases.

Ahh, happens. Thx for the info.

>> Is Patch 1 alone enough to fix it? Or is there a different fix for it?
> Patch 1 is fixing a different issue (it is lacking any maintainer
> feedback, though).
> 
> This patch of Jan should do the job, but it seems to be stuck, too:
> https://lore.kernel.org/lkml/9385fa60-fa5d-f559-a137-6608408f88b0@suse.com/

Ahh. Fun fact: that was on my list of things to prod, too.

>> Or is there some other solution to finally fix that regressions that
>> ideally should have been fixed weeks ago already?
> 
> I agree it should have been fixed quite some time now, but the x86
> maintainers don't seem to be interested in those stuck patches. :-(
> 
> Maybe I should take a different approach:
> 
> x86 maintainers, please speak up if you NAK (or Ack) any of above two
> patches.
> In case you don't NAK or take the patches, I'm inclined to carry them via
> the Xen tree to get the issues fixed.

Yeah, I'd be really glad if we could find a solution for this situation
and get it finally fixed in mainline and backported to stable.

Ciao, Thorsten
