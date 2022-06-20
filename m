Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70F1550FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiFTFW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:22:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7BCDF2B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:22:21 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o39re-0008H9-Uu; Mon, 20 Jun 2022 07:22:19 +0200
Message-ID: <effc0c6a-9e4d-b503-e4ba-6c8d2da72699@leemhuis.info>
Date:   Mon, 20 Jun 2022 07:22:18 +0200
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
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <fb0eadee-1d45-f414-eda4-a87f01eeb57a@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655702541;b9ca0aea;
X-HE-SMSGID: 1o39re-0008H9-Uu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.22 17:09, Juergen Gross wrote:
> On 03.05.22 15:22, Juergen Gross wrote:
>> x86_has_pat_wp() is using a wrong test, as it relies on the normal
>> PAT configuration used by the kernel. In case the PAT MSR has been
>> setup by another entity (e.g. BIOS or Xen hypervisor) it might return
>> false even if the PAT configuration is allowing WP mappings.
>>
>> Fixes: 1f6f655e01ad ("x86/mm: Add a x86_has_pat_wp() helper")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/mm/init.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
>> index d8cfce221275..71e182ebced3 100644
>> --- a/arch/x86/mm/init.c
>> +++ b/arch/x86/mm/init.c
>> @@ -80,7 +80,8 @@ static uint8_t __pte2cachemode_tbl[8] = {
>>   /* Check that the write-protect PAT entry is set for write-protect */
>>   bool x86_has_pat_wp(void)
>>   {
>> -    return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] ==
>> _PAGE_CACHE_MODE_WP;
>> +    return
>> __pte2cachemode_tbl[__cachemode2pte_tbl[_PAGE_CACHE_MODE_WP]] ==
>> +           _PAGE_CACHE_MODE_WP;
>>   }
>>     enum page_cache_mode pgprot2cachemode(pgprot_t pgprot)
> 
> x86 maintainers, please consider taking this patch, as it is fixing
> a real bug. Patch 2 of this series can be dropped IMO.

Juergen, can you help me out here please. Patch 2 afaics was supposed to
fix this regression I'm tracking:
https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/

Is Patch 1 alone enough to fix it? Or is there a different fix for it?
Or is there some other solution to finally fix that regressions that
ideally should have been fixed weeks ago already?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
