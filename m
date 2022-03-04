Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1514CD955
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiCDQnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiCDQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:43:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227F86E7A2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:42:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C720C1F38A;
        Fri,  4 Mar 2022 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646412167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+2Itu7S1crpuZV7anehYym0zMXdq6gIiMgw+mWxVb4=;
        b=aKUeVXsAibm8DTcJS4p3Odp8T2pRYvkHDAatPXKAO4xM83rIJhLiCnbFNqOozShOI9w2dy
        9/xHRBjevpgP3lT1A3TLp0I7srrfJuGil31hUkVvS4dW7WtHSfFOIMHpcLOtICIMb4zMfE
        In2ePdyWDb4C1Rsm5j/aI+8skosaPWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646412167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+2Itu7S1crpuZV7anehYym0zMXdq6gIiMgw+mWxVb4=;
        b=HdfV+Xl8PhkuhtYO3gxqiy4fR7yefPCrGWo/VKV5Wo4R1iooE+5j5g/z7CWSNK29C1IaaR
        1ZH9rGQE/j1ptMCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DF0813CE6;
        Fri,  4 Mar 2022 16:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bLbFJYdBImIpUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 16:42:47 +0000
Message-ID: <b9adf3a8-a260-c3ae-58a3-feefab40a651@suse.cz>
Date:   Fri, 4 Mar 2022 17:42:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Marco Elver <elver@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <CANpmjNNv8+frHPdvT=0ZNuz5phUy1WRanJ6DkiiNvDTBtFraAQ@mail.gmail.com>
 <YiH/6MeYNaEehXmj@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <CANpmjNNYt9AG8RrGF0pq2dPbFc=vw2kaOnL2k5+8kfJeEMGuwg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 0/5] slab cleanups
In-Reply-To: <CANpmjNNYt9AG8RrGF0pq2dPbFc=vw2kaOnL2k5+8kfJeEMGuwg@mail.gmail.com>
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

On 3/4/22 14:11, Marco Elver wrote:
> On Fri, 4 Mar 2022 at 13:02, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>>
>> On Fri, Mar 04, 2022 at 12:50:21PM +0100, Marco Elver wrote:
>> > On Fri, 4 Mar 2022 at 07:34, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>> > >
>> > > Changes from v1:
>> > >         Now SLAB passes requests larger than order-1 page
>> > >         to page allocator.
>> > >
>> > >         Adjusted comments from Matthew, Vlastimil, Rientjes.
>> > >         Thank you for feedback!
>> > >
>> > >         BTW, I have no idea what __ksize() should return when an object that
>> > >         is not allocated from slab is passed. both 0 and folio_size()
>> > >         seems wrong to me.
>> >
>> > Didn't we say 0 would be the safer of the two options?
>> > https://lkml.kernel.org/r/0e02416f-ef43-dc8a-9e8e-50ff63dd3c61@suse.cz
>> >
>>
>> Oh sorry, I didn't understand why 0 was safer when I was reading it.
>>
>> Reading again, 0 is safer because kasan does not unpoison for
>> wrongly passed object, right?
> 
> Not quite. KASAN can tell if something is wrong, i.e. invalid object.
> Similarly, if you are able to tell if the passed pointer is not a
> valid object some other way, you can do something better - namely,
> return 0.

Hmm, but how paranoid do we have to be? Patch 1 converts SLAB to use
kmalloc_large(). So it's now legitimate to have objects allocated by SLAB's
kmalloc() that don't have a slab folio flag set, and their size is
folio_size(). It would be more common than getting a bogus pointer, so
should we return 0 just because a bogus pointer is possible? If we do that,
then KASAN will fail to unpoison legitimate kmalloc_large() objects, no?
What I suggested earlier is we could make the checks more precise - if
folio_size() is smaller or equal order-1 page, then it's bogus because we
only do kmalloc_large() for >order-1. If the object pointer is not to the
beginning of the folio, then it's bogus, because kmalloc_large() returns the
beginning of the folio. Then in these case we return 0, but otherwise we
should return folio_size()?

> The intuition here is that the caller has a pointer to an
> invalid object, and wants to use ksize() to determine its size, and
> most likely access all those bytes. Arguably, at that point the kernel
> is already in a degrading state. But we can try to not let things get
> worse by having ksize() return 0, in the hopes that it will stop
> corrupting more memory. It won't work in all cases, but should avoid
> things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
> bounds the memory accessed corrupting random memory.
> 
> The other reason is that a caller could actually check the size, and
> if 0, do something else. Few callers will do so, because nobody
> expects that their code has a bug. :-)

