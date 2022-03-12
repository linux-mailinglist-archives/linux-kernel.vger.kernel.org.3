Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13844D6DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 10:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiCLJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 04:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiCLJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 04:23:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF91264832
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 01:22:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C049521115;
        Sat, 12 Mar 2022 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647076948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGJCc13UG0K1VbfEUqQBOawVmyBeZkeKPtFXK/dmfXw=;
        b=nPLA+jwbqemdF0yMl+jHAT0VKgcAXBHMAkZ84hPxVc4OvBhDNj+s/mGJg8jARMPaKPkyvH
        OmfDuMK/6xDAyjD39sQlPT/jGB2/QXZO3vp1ksQJNfHhFqbdRdwBasL4GTuKzuqDMQDrXb
        m+LG8iK+Ot1NzBusXxWhdhwKcRr2dp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647076948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGJCc13UG0K1VbfEUqQBOawVmyBeZkeKPtFXK/dmfXw=;
        b=xFWVrnxWNVuQFS/8TqdWuVXxNVm3Y5ZrhrhTIYg95u8H6Er6hrCGc+LbAKhkixy5WpAbEx
        Gzrh16XYYW2iQ2Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CC3E13AB1;
        Sat, 12 Mar 2022 09:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x+7DIFRmLGKsPwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 12 Mar 2022 09:22:28 +0000
Message-ID: <a8dc8bc4-9a00-b2f7-1f68-273f7a14a14c@suse.cz>
Date:   Sat, 12 Mar 2022 10:21:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [mm/slub] ae107fa919: BUG:unable_to_handle_page_fault_for_address
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>
References: <20220311145427.GA1227220@odroid>
 <667d594b-bdad-4082-09d5-7b0587af2ae3@suse.cz>
 <20220311164600.GA1234616@odroid>
 <YivzD7PYilkFwjFt@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YivzD7PYilkFwjFt@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 02:10, Hyeonggon Yoo wrote:
> On Fri, Mar 11, 2022 at 04:46:00PM +0000, Hyeonggon Yoo wrote:
>> On Fri, Mar 11, 2022 at 04:36:47PM +0100, Vlastimil Babka wrote:
>>> On 3/11/22 15:54, Hyeonggon Yoo wrote:
>>>> On Wed, Mar 09, 2022 at 10:15:31AM +0800, kernel test robot wrote:
>>>>>
>>>>>
>>>>> Greeting,
>>>>>
>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>
>>>>> commit: ae107fa91914f098cd54ab77e68f83dd6259e901 ("mm/slub: use stackdepot to save stack trace in objects")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slub-stackdepot-v3r0
>>>>>
>>>>> in testcase: boot
>>>>>
>>>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>>>>
>>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>>>
>>>>
>>>> [+Cc Vlastimil and linux-mm]
>>>
>>> Thanks.
>>> lkp folks: it would be nice if I was CC'd automatically on this, it's a
>>> commit from my git tree and with by s-o-b :)
>>>
>>>> I _strongly_ suspect that this is because we don't initialize
>>>> stack_table[i] = NULL when we allocate it from memblock_alloc().
>>>
>>> No, Mike (CC'd) suggested to drop the array init cycle, because
>>> memblock_alloc would zero the area anyway.
>>
>> Ah, you are right. My mistake.
>>
>>> There has to be a different
>>> reason. Wondering if dmesg contains the stack depot initialization message
>>> at all...
>>
>> I think I found the reason.
>> This is because of CONFIG_SLUB_DEBUG_ON.
>> It can enable debugging without passing boot parameter.
>>
>> if CONFIG_SLUB_DEBUG_ON=y && slub_debug is not passed, we do not call
>> stack_depot_want_early_init(), but the debugging flags are set.
>>
>> And we only call stack_depot_init() later in kmem_cache_create_usercopy().
>>
>> so it crashed while creating boot cache.
> 
> I tested this, and this was the reason.
> It crashed on CONFIG_SLUB_DEBUG_ON=y because stackdepot always assume
> that it was initialized in boot step, or failed
> (stack_depot_disable=true).
> 
> But as it didn't even tried to initialize it, stack_table == NULL &&
> stack_depot_disable == false. So accessing *(NULL + <hash value>)

Thanks for finding the cause!

> Ideas? implementing something like kmem_cache_init_early() again?

I think we could simply make CONFIG_SLUB_DEBUG_ON select/depend on
STACKDEPOT_ALWAYS_INIT?
