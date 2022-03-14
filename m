Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC924D88F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbiCNQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiCNQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:21:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1011260E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:20:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF715210F6;
        Mon, 14 Mar 2022 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647274818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzYMEtu5lGd+7jkZ0DahqSJurPiBuUODohRK/bWM34c=;
        b=EGwc1wzljvBJTwEQY1joLi7cIDsnsMS0sU2lFm9v7DGWib5BBYmDPRzEBzU9jvCZC+0djn
        GJ7MYF6LG2kAj8PQm1c48Mc0jUbVRoNe1AFC+YFP+5ahbfHg+K00k3buKtbG5uf5uYkC8A
        qZDgBwa9Fd6V7uS2deq2A3HqTTwZvt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647274818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzYMEtu5lGd+7jkZ0DahqSJurPiBuUODohRK/bWM34c=;
        b=hFEtDddvyDM/2xhbscwcH6A5Af6XAWqsgHdpDQn/O+DzU3ouAmIigbrl9HuUhYYXeFc5FZ
        LQDKIpjx3tYZ6yCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 983CD13ADA;
        Mon, 14 Mar 2022 16:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QyJjJEJrL2LDKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 14 Mar 2022 16:20:18 +0000
Message-ID: <3d2872e9-b17f-a9f9-cad1-09a7fff85b5b@suse.cz>
Date:   Mon, 14 Mar 2022 17:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [mm/slub] ae107fa919: BUG:unable_to_handle_page_fault_for_address
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
References: <20220311145427.GA1227220@odroid>
 <667d594b-bdad-4082-09d5-7b0587af2ae3@suse.cz>
 <20220311164600.GA1234616@odroid>
 <YivzD7PYilkFwjFt@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <a8dc8bc4-9a00-b2f7-1f68-273f7a14a14c@suse.cz>
 <Yix+Pn9a9yKIiXC4@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <YiyMvBouXGLk/xWP@kernel.org> <ff4daab3-0ae6-65b9-dbc6-8033cf7ad6a7@suse.cz>
In-Reply-To: <ff4daab3-0ae6-65b9-dbc6-8033cf7ad6a7@suse.cz>
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

On 3/12/22 14:08, Vlastimil Babka wrote:
> On 3/12/22 13:06, Mike Rapoport wrote:
>>>>> Ideas? implementing something like kmem_cache_init_early() again?
>>>>
>>>> I think we could simply make CONFIG_SLUB_DEBUG_ON select/depend on
>>>> STACKDEPOT_ALWAYS_INIT?
>>>
>>> Oh, sounds better.
>>>
>>> If we make CONFIG_SLUB_DEBUG_ON select STACK_DEPOT_ALWAYS_INIT,
>>> that is simple solution. but stackdepot will be initialized on
>>> slub_debug=- too.
> 
> Valid point.
> 
>>> But I think no one will set CONFIG_SLUB_DEBUG_ON=y if not debugging...
>> 
>> If memory wasted by stack_table is a real concern, we may free it after
>> parsing slub_debug or add a condition taking into account
>> CONFIG_SLUB_DEBUG_ON and slub_debug=- to the 
>> 
>> 	if (slub_debug & SLAB_STORE_USER)
>> 		stack_depot_want_early_init();
>> 
>> But I agree that if somebody runs a kernel with CONFIG_SLUB_DEBUG_ON=y, the
>> goal is to have slub debugging on, so making CONFIG_SLUB_DEBUG_ON select
>> STACK_DEPOT_ALWAYS_INIT totally makes sense to me.
> 
> Agree. We had to decouple stackdpepot init from CONFIG_SLUB_DEBUG
> because almost everyone enables CONFIG_SLUB_DEBUG by default, but on
> smaller systems doesn't want to always pay the price even if unused.
> But I don't expect anyone to enable CONFIG_SLUB_DEBUG_ON and then run
> with slub_debug=- by default, and complain. If anyone like that exists,
> they could also add the stackdepot_disable parameter.

Pushed fixed version to
https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git
slub-stackdepot-v3r1 for now
As it's too late to target 5.18 now, will post v3 properly after merge
window and add to slab-next towards 5.19 then.

>>> I don't think making CONFIG_SLUB_DEBUG_ON depend on
>>> CONFIG_STACKDEPOT_ALWAYS_INIT is good solution. only KASAN selects it.
>>>
>>> -- 
>>> Thank you, You are awesome!
>>> Hyeonggon :-)
>> 
> 

