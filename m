Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8447493C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhLNRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:25:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54586 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhLNRY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:24:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0020C1F381;
        Tue, 14 Dec 2021 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639502699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4Jb4XrzvpacJ7SqkwqBUvrL0B/KpXAmvhwLBcXtmUM=;
        b=AWdQezGgFF8o594XD7pXjKWBBi61aEfkm4WOx/0OyHaEyVtTe3ZWxSBHA/uJ0HvjeW8wEG
        iipfRX7/TcIxlpBuCheE8Wr2NjunupEN8NCg1rxNCdgQ4q7qzTQAr/gSzlhOpowO/TVv7m
        K2+FXvGhLOqLF5Pa80PWGG3epquMHxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639502699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4Jb4XrzvpacJ7SqkwqBUvrL0B/KpXAmvhwLBcXtmUM=;
        b=pYXWsaNTOciDJZmPxXAJ2/iJUYe8bDE+oLdd13wVv6QAM4fMow6zoTFmpqN/kfp8cTey0I
        Po4cLfFzdJ+MZpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B533013D17;
        Tue, 14 Dec 2021 17:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jf/oKmrTuGHIHgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Dec 2021 17:24:58 +0000
Message-ID: <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
Date:   Tue, 14 Dec 2021 18:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org> <20211210110835.GA632811@odroid>
 <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
In-Reply-To: <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 13:06, Christoph Lameter wrote:
> On Fri, 10 Dec 2021, Hyeonggon Yoo wrote:
> 
>> > > (But I still have doubt if we can run linux on machines like that.)
>> >
>> > I sent you a series of articles about making Linux run in 1MB.
>>
>> After some time playing with the size of kernel,
>> I was able to run linux in 6.6MiB of RAM. and the SLOB used
>> around 300KiB of memory.
> 
> What is the minimal size you need for SLUB?
 
Good question. Meanwhile I tried to compare Slab: in /proc/meminfo on a virtme run:
virtme-run --mods=auto --kdir /home/vbabka/wrk/linux/ --memory 2G,slots=2,maxmem=4G --qemu-opts --smp 4

Got ~30800kB with SLOB, 34500kB with SLUB without DEBUG and PERCPU_PARTIAL.
Then did a quick and dirty patch (below) to never load c->slab in
___slab_alloc() and got to 32200kB. Fiddling with
slub_min_order/slub_max_order didn't actually help, probably due to causing
more internal fragmentation.

So that's relatively close, but on a really small system the difference can
be possibly more prominent. Also my test doesn't account for text/data or
percpu usage differences.

diff --git a/mm/slub.c b/mm/slub.c
index 68aa112e469b..fd9c853971d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3054,6 +3054,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	goto return_single;
+
 retry_load_slab:
 
 	local_lock_irqsave(&s->cpu_slab->lock, flags);


 

