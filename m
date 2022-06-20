Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78835517ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbiFTMAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbiFTMAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:00:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99A2185
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:00:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3ABC121AD3;
        Mon, 20 Jun 2022 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655726441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rWFG3uWKuuKdwZT86iOp2RBtyzj8xN/EPYd8WQXuuY=;
        b=0QbMavM04QGJH3Y/IhTNDgFjE/11rLYDqeBfol2PSI9ZR4ZUTRF3bLUXOX1aRW+Cgh4CEQ
        rz6nTSkEi9Kkbcs8K7h8BRHqINwOJSazZl0IFJQgPQr5QK4kglrMAyh4eTGpHFhVhzUj/p
        cL2ohjotxpZtyFKE5rnGYCN/zxKfz3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655726441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rWFG3uWKuuKdwZT86iOp2RBtyzj8xN/EPYd8WQXuuY=;
        b=wK1upZ9g1hWwLkkhiY1nwMk+CxWTKKbDOs1po/GRfj6PtiirYM4Z85HNmbaEUAnj+hD2fD
        MrO9j9H3bfl9g9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AC13134CA;
        Mon, 20 Jun 2022 12:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4ZbUBWlhsGLaEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Jun 2022 12:00:41 +0000
Message-ID: <93bf8148-ecc1-75fb-423b-2a76c7252c4e@suse.cz>
Date:   Mon, 20 Jun 2022 14:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 1/1] lib/stackdepot: replace CONFIG_STACK_HASH_ORDER
 with automatic sizing
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com
References: <20220527113706.24870-1-vbabka@suse.cz>
 <20220527113706.24870-2-vbabka@suse.cz>
 <CACT4Y+Y4GZfXOru2z5tFPzFdaSUd+GFc6KVL=bsa0+1m197cQQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CACT4Y+Y4GZfXOru2z5tFPzFdaSUd+GFc6KVL=bsa0+1m197cQQ@mail.gmail.com>
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

On 5/27/22 14:02, Dmitry Vyukov wrote:
> On Fri, 27 May 2022 at 13:37, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> As Linus explained [1], setting the stackdepot hash table size as a
>> config option is suboptimal, especially as stackdepot becomes a
>> dependency of less specialized subsystems than initially (e.g. DRM,
>> networking, SLUB_DEBUG):
>>
>> : (a) it introduces a new compile-time question that isn't sane to ask
>> : a regular user, but is now exposed to regular users.
>>
>> : (b) this by default uses 1MB of memory for a feature that didn't in
>> : the past, so now if you have small machines you need to make sure you
>> : make a special kernel config for them.
>>
>> Ideally we would employ rhashtable for fully automatic resizing, which
>> should be feasible for many of the new users, but problematic for the
>> original users with restricted context that call __stack_depot_save()
>> with can_alloc == false, i.e. KASAN.
>>
>> However we can easily remove the config option and scale the hash table
>> automatically with system memory. The STACK_HASH_MASK constant becomes
>> stack_hash_mask variable and is used only in one mask operation, so the
>> overhead should be negligible to none. For early allocation we can
>> employ the existing alloc_large_system_hash() function and perform
>> similar scaling for the late allocation.
>>
>> The existing limits of the config option (between 4k and 1M buckets)
>> are preserved, and scaling factor is set to one bucket per 16kB memory
>> so on 64bit the max 1M buckets (8MB memory) is achieved with 16GB
>> system, while a 1GB system will use 512kB.
> 
> Hi Vlastimil,
> 
> We use KASAN with VMs with 2GB of memory.
> If I did the math correctly this will result in 128K entries, while
> currently we have CONFIG_STACK_HASH_ORDER=20 even for arm32.
> I am actually not sure how full the table gets, but we can fuzz a
> large kernel for up to an hour, so we can get lots of stacks (we were
> the only known users who routinely overflowed default LOCKDEP tables
> :)).

Aha, good to know the order of 20 has some real use case then :)

> I am not opposed to this in general. And I understand that KASAN Is
> different from the other users.
> What do you think re allowing CONFIG_STACK_HASH_ORDER=0/is not set
> which will mean auto-size, but keeping ability to set exact size as
> well?
> Or alternatively auto-size if KASAN is not enabled and use a large
> table otherwise? But I am not sure if anybody used
> CONFIG_STACK_HASH_ORDER to reduce the default size with KASAN...

Well if you're unsure and nobody else requested it so far, we could try
setting it to 20 when KASAN is enabled, and autosize otherwise. If somebody
comes up with a use-case for the boot-time parameter override (instead of
CONFIG_), we can add it then?
>> If needed, the automatic scaling could be complemented with a boot-time
>> kernel parameter, but it feels pointless to add it without a specific
>> use case.
