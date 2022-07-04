Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA8565436
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiGDL6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiGDL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:58:50 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494361147F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:58:46 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o8Kiw-0000tH-DU; Mon, 04 Jul 2022 13:58:42 +0200
Message-ID: <8756355c-b586-3d1b-531c-72a04a8c047a@leemhuis.info>
Date:   Mon, 4 Jul 2022 13:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state
 when running on e.g. Xen
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1656935926;57eec001;
X-HE-SMSGID: 1o8Kiw-0000tH-DU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.22 10:55, Jan Beulich wrote:
> On 28.04.2022 16:50, Jan Beulich wrote:
>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
>> with pat_enabled()") pat_enabled() returning false (because of PAT
>> initialization being suppressed in the absence of MTRRs being announced
>> to be available) has become a problem: The i915 driver now fails to
>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
>> located the induced failure), and its error handling is flaky enough to
>> (at least sometimes) result in a hung system.
>>
>> Yet even beyond that problem the keying of the use of WC mappings to
>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
>> graphics frame buffer accesses would have been quite a bit less
>> performant than possible.
>>
>> Arrange for the function to return true in such environments, without
>> undermining the rest of PAT MSR management logic considering PAT to be
>> disabled: Specifically, no writes to the PAT MSR should occur.
>>
>> For the new boolean to live in .init.data, init_cache_modes() also needs
>> moving to .init.text (where it could/should have lived already before).
>>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> The Linux kernel regression tracker is pestering me because things are
> taking so long (effectively quoting him), and alternative proposals
> made so far look to have more severe downsides.

Has any progress been made with this patch? It afaics is meant to fix
this regression, which ideally should have been fixed weeks ago (btw:
adding a "Link:" tag pointing to it would be good):
https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/

According to Juergen it's still needed:
https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/

Or was a different solution found to fix that regression?

Ciao, Thorsten
