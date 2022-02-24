Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6884C2C26
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiBXMwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiBXMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:52:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FA20C192
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:52:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6ADD01F44A;
        Thu, 24 Feb 2022 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645707120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hEOHSk6mpdWOQGBOjCX5MvKKazQNk0J6qqzBVupACc=;
        b=kd9qcHfB0uMRnvQRtQlnE/2aEw8n/2DqkEVkk4NCDppua4OsOt9r39jkr1e37OcLY7oi9x
        8b6IJtKOCCx3+/MtXErSwIKnUYmLN4Iq0WzCphMhnF2I345uBcNsUSY4hmugGlLeO9KHG+
        +QS7rib+SQSEWj9RVOGVLj2Yt2JzFZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645707120;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hEOHSk6mpdWOQGBOjCX5MvKKazQNk0J6qqzBVupACc=;
        b=R/upWeR00uc1VkH7l85083qEPjAX6RcNX226l+2+LFBkeQhHyGwoncgYIQ6JYh4rAF9iuV
        JVX5a87C5Qv087Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4946D13AD9;
        Thu, 24 Feb 2022 12:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hF8dEXB/F2LJEAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Feb 2022 12:52:00 +0000
Message-ID: <2a7e0f81-8152-4e6b-6036-43c236da5013@suse.cz>
Date:   Thu, 24 Feb 2022 13:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/5] mm/slub: Limit min_partial only in cache creation
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-5-42.hyeyoo@gmail.com>
 <91cc8ab-a0f0-2687-df99-10b2267c7a9@google.com>
 <YhWsF/Bz89LpLa/g@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YhWsF/Bz89LpLa/g@ip-172-31-19-208.ap-northeast-1.compute.internal>
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

On 2/23/22 04:37, Hyeonggon Yoo wrote:
> On Tue, Feb 22, 2022 at 03:48:16PM -0800, David Rientjes wrote:
>> On Mon, 21 Feb 2022, Hyeonggon Yoo wrote:
>> 
>> > SLUB sets number of minimum partial slabs for node (min_partial) using
>> > set_min_partial(). SLUB holds at least min_partial slabs even if they're empty
>> > to avoid excessive use of page allocator.
>> > 
>> > set_min_partial() limits value of min_partial between MIN_PARTIAL and
>> > MAX_PARTIAL. As set_min_partial() can be called by min_partial_store()
>> > too, Only limit value of min_partial in kmem_cache_open() so that it
>> > can be changed to value that a user wants.
>> > 
>> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> 
>> I think this makes sense and there is no reason to limit the bounds that 
>> may be set at runtime with undocumented behavior.

Right.

> Thank you for comment.
> 
>> 
>> However, since set_min_partial() is only setting the value in the 
>> kmem_cache, could we remove the helper function entirely and fold it into 
>> its two callers?
> 
> Right. We don't need to separate this as function. I'll update this
> in next version. Thanks!

Agreed, thanks!
