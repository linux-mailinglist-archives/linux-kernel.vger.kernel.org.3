Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702405ACAC3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiIEG37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiIEG34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:29:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5571DFA7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:29:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1726E5C0FF;
        Mon,  5 Sep 2022 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662359392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhijfRZY40vjJfJyooNR8N9awwqjN0FM9rnSIBMt9qM=;
        b=XiBDhXtj8D9Xq/1iDTG64+f1FivzrJIciuouAcGpXbZRRXjh1w6nG5So+61oKVhokfTB+r
        m7RPRW95Tr6BKnYiHQ3liqzt67JA+nCpxZIfeWf5RyF+XOX6UTDp7PbfbAB6BEfr0G7Iad
        QcwXj6K3n8Inw8gNO8J6Ej8W13kp6SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662359392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhijfRZY40vjJfJyooNR8N9awwqjN0FM9rnSIBMt9qM=;
        b=af1PA2sGw+9FlXu0Q5xfOIZAWligcxM3LpUNzURuwWPx4WwAmOkykPLTMr0qNxjA95HLZh
        UcMGVph0UZ8jSjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D571A139C7;
        Mon,  5 Sep 2022 06:29:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FTd0M1+XFWNKWQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 05 Sep 2022 06:29:51 +0000
Message-ID: <8ff805f4-76ae-fc0f-424f-4d230c08285e@suse.cz>
Date:   Mon, 5 Sep 2022 08:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
To:     Feng Tang <feng.tang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com> <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx> <YxRp5uz9KSY0S9id@hyeyoo>
 <YxRzCX8WqOv3KESJ@feng-clx> <YxSE6XmHl3itv4JY@hyeyoo>
 <YxVlB/YRj7SNLqml@feng-clx>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YxVlB/YRj7SNLqml@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 04:55, Feng Tang wrote:
> On Sun, Sep 04, 2022 at 06:58:49PM +0800, Hyeonggon Yoo wrote:
>> On Sun, Sep 04, 2022 at 05:42:33PM +0800, Feng Tang wrote:
>> > On Sun, Sep 04, 2022 at 05:03:34PM +0800, Hyeonggon Yoo wrote:
>> > [...]
>> > > > > 
>> > > > > This patch is okay but with patch 4, init_object() initializes redzone/poison area
>> > > > > using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
>> > > > > Why not do it in init_object() in the first time?
>> > > > > 
>> > > > > Also, updating redzone/poison area after alloc_single_from_new_slab()
>> > > > > (outside list_lock, after adding slab to list) will introduce races with validation.
>> > > > > 
>> > > > > So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.
>> > > > 
>> > > > Yes, this makes sense, and in v3, kmalloc redzone/poison setup was
>> > > > done in alloc_debug_processing() (through init_object()). When
>> > > > rebasing to v4, I met the classical problem: how to pass 'orig_size'
>> > > > parameter :)
>> > > > 
>> > > > In latest 'for-next' branch, one call path for alloc_debug_processing()
>> > > > is
>> > > >   ___slab_alloc
>> > > >     get_partial
>> > > >       get_any_partial
>> > > >         get_partial_node
>> > > >           alloc_debug_processing
>> > > > 
>> > > > Adding 'orig_size' paramter to all these function looks horrible, and
>> > > > I couldn't figure out a good way and chosed to put those ops after
>> > > > 'set_track()'
>> > > 
>> > > IMO adding a parameter to them isn't too horrible...
>> > > I don't see better solution than adding a parameter with current implementation.
>> > > (Yeah, the code is quite complicated...)
>> > > 
>> > > It won't affect performance to meaningful degree as most of
>> > > allocations will be served from cpu slab or percpu partial list. 
>> > 
>> > Thanks for the suggestion! I'm fine with it and just afraid other
>> > developers may dislike the extra parameter. 
>> > 
>> > The race condition you mentioned is a valid concern, and I have thought
>> > about it, one way is moving the set_orig_size() after the redzone/poision
>> > setup, and in 'check_object()' we can detect whether the 'orig_size' is
>> > set, and skip that check if it's not set yet. As the manual validate_slab
>> > triggered from sysfs interface is a rare debug activity, I think skipping
>> > one object shouldn't hurt much.
>> 
>> That will require smp_wmb()/smp_rmb() pair to make sure that
>> effects of set_orig_size() to be visible after redzone/poison setup.
> 
> Yes, synchronization is needed here.
> 
>> Isn't it simpler to add a parameter?
> 
> OK, I can go this way in v5 if other developers are fine. thanks

How about get_partial() instantiates an on-stack structure that contains
gfpflags, ret_slab, orig_size and passes pointer to that to all the nested
functions.

Would be similar to "struct alloc_context" in page allocation.
Something like "struct partial_context pc"?

> - Feng

