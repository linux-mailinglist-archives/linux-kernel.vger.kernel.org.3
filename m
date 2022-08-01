Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16829586C11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiHANgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiHANgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:36:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992F63DBF4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:36:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49AAD387DC;
        Mon,  1 Aug 2022 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659361009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48frINV5ScZh/Ic/JwZ64qBIXxEjcd8Ch3oF0V+HeiA=;
        b=wnZ2AZ5/okL/EZgAZRAZGRvTT8g9N6qRxj7CsJDb1vTDzSAcmfhySaYWvVLqq+ECMrZYgB
        v2tiJ4FnVFRuvFyJV/UerOTdJy9+XdPQ1XhO2myKz5Fr+aRoFdng5hGLS3jUX08kV9436M
        HHz+glK6Rl6kcF1EZO+akypGNcZNBI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659361009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48frINV5ScZh/Ic/JwZ64qBIXxEjcd8Ch3oF0V+HeiA=;
        b=oRR/ahRvuXNqsao6OYkoXeWQP7hbSxdpdJk5jRc0HEHuRtxa6v7fOqXxpBw0Nc7az2MsCb
        dLvMfIXAurO85oBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B77913A72;
        Mon,  1 Aug 2022 13:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JgsDBvHW52LdQAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 01 Aug 2022 13:36:49 +0000
Message-ID: <0ca2f22a-8247-8419-3f99-4456a4c7344a@suse.cz>
Date:   Mon, 1 Aug 2022 15:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/15] mm/slab_common: fold kmalloc_order_trace() into
 kmalloc_large()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-7-42.hyeyoo@gmail.com>
 <2e252179-0ffe-0d9c-9340-77e46f6ffdfd@suse.cz> <YufUgFX2shlG5FoR@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YufUgFX2shlG5FoR@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 15:26, Hyeonggon Yoo wrote:
> On Thu, Jul 28, 2022 at 05:23:29PM +0200, Vlastimil Babka wrote:
>> On 7/12/22 15:39, Hyeonggon Yoo wrote:
>> > There is no caller of kmalloc_order_trace() except kmalloc_large().
>> > Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().
>> > 
>> > Also add tracepoint in kmalloc_large() that was previously
>> > in kmalloc_order_trace().
>> > 
>> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> 
> 
> Thank you for review.
> 
>> Hmm noticed a small change in how we call trace_kmalloc() which will now
>> include the __GFP_COMP.
> 
> Good catch.
> 
>> I think we could just call alloc_pages() from
>> kmalloc_large() with flags | __GFP_COMP instead of doing flags |=
>> __GFP_COMP; first.
> 
> I'll consider that in next version.
> 
>> AFAICS both kasan_kmalloc_large() and kmemleak_alloc()
>> will filter it out anyway.
> 
> AFAIK not passing __GFP_COMP to both kasan_kmalloc_large()
> and kmemleak_alloc() will affect their behavior.

You mean "will NOT affect...", right?

> - kasan_kmalloc_large() only checks if flag has __GFP_DIRECT_RECLAIM,
> - kmemleak_alloc() only use it to allocate kmemleak_object from
>   slab/pool, which does not require __GFP_COMP.
> 
> simply calling
> 	alloc_pages() with flags | GFP_COMP
> 	kasan_kmalloc_large() with flags
> 	kmemleak_alloc() with flags
> 	trace_kmalloc() with flags
> will be okay.
> 
> BTW this is fixed after patch 9.

Ah, right. __kmalloc_large_node_notrace() does the same  flags |=
__GFP_COMP; but the tracepoint is outside and unaffected.
