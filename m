Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00B4755E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhLOKKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:10:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44410 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbhLOKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:10:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C51121106;
        Wed, 15 Dec 2021 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639563007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogUacrei2N1rZsFK2+yERd4h3taB7Ng8o1eMUzKleoY=;
        b=fc2ExMBBruR2DGWH7HIoiSbFgt2URuM9+nxgHrQ6piH0PxOW3xfVbrlWqIBR/bm/jVKMT0
        9eNioA7HnbRcPhG+puvkIByJP/bBq9DzjxLpTVQ6CSVfRMKeeXtK8ZxrwBYRd9C6VRSxtX
        H3fl5U+091ulid+gp2nzUWt1RhaE1ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639563007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogUacrei2N1rZsFK2+yERd4h3taB7Ng8o1eMUzKleoY=;
        b=1o9ux9lQ4OIl8Q7DCuDQH10ukfQpKdZlxpV8yjesUc2Nhd96RXDgEwitowQ4+Y220rXm9L
        szMc/4lvzJyY7mDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D05FB13B09;
        Wed, 15 Dec 2021 10:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZNkcMv6+uWFwZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Dec 2021 10:10:06 +0000
Message-ID: <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
Date:   Wed, 15 Dec 2021 11:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Do we really need SLOB nowdays?
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@gentwo.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org> <20211210110835.GA632811@odroid>
 <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
 <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
 <20211215062904.GA1150813@odroid>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211215062904.GA1150813@odroid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 07:29, Hyeonggon Yoo wrote:
> On Tue, Dec 14, 2021 at 06:24:58PM +0100, Vlastimil Babka wrote:
>> On 12/10/21 13:06, Christoph Lameter wrote:
>> > On Fri, 10 Dec 2021, Hyeonggon Yoo wrote:
>> > 
>> >> > > (But I still have doubt if we can run linux on machines like that.)
>> >> >
>> >> > I sent you a series of articles about making Linux run in 1MB.
>> >>
>> >> After some time playing with the size of kernel,
>> >> I was able to run linux in 6.6MiB of RAM. and the SLOB used
>> >> around 300KiB of memory.
>> > 
>> > What is the minimal size you need for SLUB?
>>  
> 
> I don't know why Christoph's mail is not in my mailbox. maybe I deleted it
> by mistake or I'm not cc-ed.
> 
> Anyway, I tried to measure this again with SLUB and SLOB.
> 
> SLUB uses few hundreds of bytes than SLOB.
> 
> There isn't much difference in 'Memory required to boot'.
> (interestingly SLUB requires less)
> 
> 'Memory required to boot' is measured by reducing memory
> until it says 'System is deadlocked on memory'. I don't know
> exact reason why they differ.
> 
> Note that the configuration is based on tinyconfig and
> I added initramfs support + tty layer (+ uart driver) + procfs support,
> + ELF binary support + etc.
> 
> there isn't even block layer, but it's good starting point to see
> what happens in small system.
> 
> SLOB:
> 
> 	Memory required to boot: 6950K
> 
> 		Slab:                368 kB
> 
> SLUB:
> 	Memory required to boot: 6800K
> 
> 		Slab:                552 kB
> 
> SLUB with slab merging:
> 
> 		Slab:                536 kB

168kB different on a system with less than 8MB memory looks rather
significant to me to simply delete SLOB, I'm afraid.
