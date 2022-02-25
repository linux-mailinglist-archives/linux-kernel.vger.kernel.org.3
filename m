Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6CE4C41F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbiBYKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiBYKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:08:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5A186415
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:07:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6275E21109;
        Fri, 25 Feb 2022 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645783666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0etQo+U80wvzQbUb7jsrk6VICiK3jE1FOjeQLmt9D44=;
        b=DCqqIlZIPUKeqzrRxVBK2ZEwhIOsEBfMJg9ZxQ0SH8So+Zq2+dp+LUKTcIQoT4rtylGnMa
        0la/ZMOY1ESNLbqkJggGPmpCd9N9V8s+cOtM/zCnWVcUtAFRWxDAhhVCxMbo+gkAmaculG
        4lN7sq5vCA3sYTwTPH18b25fp630NU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645783666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0etQo+U80wvzQbUb7jsrk6VICiK3jE1FOjeQLmt9D44=;
        b=OyTJdOZq2p+0QdcP+CbJ8DY56byCESn/swz2Ee7CAkPSlBrypNyHrb920iColIyEMOo6Zj
        p1bWgu+vBBAaGTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F5AE13B65;
        Fri, 25 Feb 2022 10:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nDOxDnKqGGLwaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Feb 2022 10:07:46 +0000
Message-ID: <21c9fa1a-a003-3325-dd92-982ae3102336@suse.cz>
Date:   Fri, 25 Feb 2022 11:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-6-42.hyeyoo@gmail.com>
 <cd4144f5-e769-cf73-ca25-b36f2c4bbf35@suse.cz>
 <YhiikbXALDX6fFyr@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <YhimVo7oKmnMSkYS@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 5/5] mm/slub: Refactor deactivate_slab()
In-Reply-To: <YhimVo7oKmnMSkYS@ip-172-31-19-208.ap-northeast-1.compute.internal>
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

On 2/25/22 10:50, Hyeonggon Yoo wrote:
> On Fri, Feb 25, 2022 at 09:34:09AM +0000, Hyeonggon Yoo wrote:
>> On Thu, Feb 24, 2022 at 07:16:11PM +0100, Vlastimil Babka wrote:
>> > On 2/21/22 11:53, Hyeonggon Yoo wrote:
>> > > Simply deactivate_slab() by removing variable 'lock' and replacing
>> > > 'l' and 'm' with 'mode'. Instead, remove slab from list and unlock
>> > > n->list_lock when cmpxchg_double() fails, and then retry.
>> > > 
>> > > One slight functional change is releasing and taking n->list_lock again
>> > > when cmpxchg_double() fails. This is not harmful because SLUB avoids
>> > > deactivating slabs as much as possible.
>> > > 
>> > > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> > 
>> > Hm I wonder if we could simplify even a bit more. Do we have to actually
>> > place the slab on a partial (full) list before the cmpxchg, only to remove
>> > it when cmpxchg fails? Seems it's to avoid anyone else seeing the slab
>> > un-frozen, but not on the list, which would be unexpected. However if anyone
>> > sees such slab, they have to take the list_lock first to start working with
>> > the slab... so this should be safe, because we hold the list_lock here, and
>> > will place the slab on the list before we release it. But it thus shouldn't
>> > matter if the placement happens before or after a successful cmpxchg, no? So
>> > we can only do it once after a successful cmpxchg and need no undo's?
>> >
>> 
>> My thought was similar. But after testing I noticed that &n->list_lock prevents
>> race between __slab_free() and deactivate_slab().
>> 
>> > Specifically AFAIK the only possible race should be with a __slab_free()
>> > which might observe !was_frozen after we succeed an unfreezing cmpxchg and
>> > go through the
>> > "} else { /* Needs to be taken off a list */"
>> > branch but then it takes the list_lock as the first thing, so will be able
>> > to proceed only after the slab is actually on the list.
>> > 
>> > Do I miss anything or would you agree?
>> >
>> 
>> It's so tricky.
>> 
>> I tried to simplify more as you said. Seeing frozen slab on list was not
>> problem. But the problem was that something might interfere between
>> cmpxchg_double() and taking spinlock.
>> 
>> This is what I faced:
>> 
>> 	CPU A				CPU B
>> deactivate_slab() {			__slab_free() {
>> 	/* slab is full */
>> 	slab.frozen = 0;
>> 	cmpxchg_double();
>> 						/* Hmm... 
>> 						slab->frozen == 0 &&
>> 						slab->freelist != NULL?
>> 						Oh This must be on the list.. */
> 						Oh this is wrong.
> 						slab->freelist must be
> 						NULL because it's full
> 						slab.
> 
> 						It's more complex
> 						than I thought...
> 
> 
>> 						spin_lock_irqsave();
>> 						cmpxchg_double();
>> 						/* Corruption: slab
>> 						 * was not yet inserted to
>> 						 * list but try removing */
>> 						remove_full();
>> 						spin_unlock_irqrestore();
>> 					}
>> 	spin_lock_irqsave();
>> 	add_full();
>> 	spin_unlock_irqrestore();
>> }
> 
> So it was...
> 
>  	CPU A				CPU B
>  deactivate_slab() {			__slab_free() {
>  	/* slab is full */
>  	slab.frozen = 0;
>  	cmpxchg_double();
>  						/*
> 							Hmm... 
> 							!was_frozen &&
> 							prior == NULL?
> 							Let's freeze this!
> 						*/
> 						put_cpu_partial();
>  					}
>  	spin_lock_irqsave();

Yeah in my proposal I didn't intend to only take spin_lock_irqsave() here.
My idea for CPU A would be something like:

spin_lock_irqsave();
slab.frozen = 0;
if (cmpxchg_double()); {
	/* success */
	add_partial(); // (or add_full())
	spin_unlock_irqrestore();
} else {
	/* fail */
	spin_unlock_irqrestore();
	goto redo;
}
	
So we would still have the list_lock protection around cmpxchg as in the
current code. We just wouldn't do e.g. add_partial() before cmpxchg, only to
remove_partial() when cmpxchg failed.

>  	add_full();
> 	/* It's now frozen by CPU B and at the same time on full list */
>  	spin_unlock_irqrestore();
> 
> And &n->list_lock prevents such a race.

