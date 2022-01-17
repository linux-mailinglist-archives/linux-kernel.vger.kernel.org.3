Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227A24908CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiAQMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:40:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiAQMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:40:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 915E7212BF;
        Mon, 17 Jan 2022 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642423227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ac5nyObxkkedzmWPxZXWjsCjSPwuhnK/aotnvT2TN1I=;
        b=hRcfG3BuBoCzCulb1co9DL14pIOMcijpy6BZOBmBLCy9VInL7g8rsps1lT0A2/M/xo6H3Q
        q4dkAo6xrcm+un9Gw4q0q8YKXG6mtOmayfkhgR4rerpFjYgJGk3gaS3o0MmRsE3C8QFb8r
        +RaqVVJDummCf4UE0ewOgrb/ysbqfRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642423227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ac5nyObxkkedzmWPxZXWjsCjSPwuhnK/aotnvT2TN1I=;
        b=uJ0MvzKZXpjYLQ8mn8jDnvRpNy6oNSXI1K2JyiK/DwFGH5s8ldnn3XYT/xl1xGPg8f/4Gg
        WZRkfTkZbVFY77CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FE7D13D3C;
        Mon, 17 Jan 2022 12:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xdWGFrtj5WEJJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Jan 2022 12:40:27 +0000
Message-ID: <39a3470f-06ab-cf41-32e4-80edb249c7d3@suse.cz>
Date:   Mon, 17 Jan 2022 13:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Xin Long <lucien.xin@gmail.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Antoine Tenart <atenart@kernel.org>,
        Clark Williams <williams@redhat.com>
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
 <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <CADvbK_eY=3Gf79MkvK72Nh86ysN4eoFei0k1jg0frg22GgToGA@mail.gmail.com>
 <YeU4B46F+oFUBRLE@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
In-Reply-To: <YeU4B46F+oFUBRLE@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Clark

On 1/17/22 10:33, Sebastian Andrzej Siewior wrote:
> On 2022-01-17 16:32:46 [+0800], Xin Long wrote:
>> another issue. From the code analysis, this issue does exist on the
>> upstream kernel, though I couldn't build an upstream RT kernel for the
>> testing.
> 
> This should also reproduce in v5.16 since the commit in question is
> there.

Yeah. I remember we had some issues with the commit during development, but
I'd hope those were resolved and the commit that's ultimately merged got the
fixes, see this subthread:

https://lore.kernel.org/all/0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com/

>> > >         CPU0                        CPU1
>> > >         ----                        ----
>> > >   cpus_read_lock()
>> > >                                    kn->active++
>> > >                                    cpus_read_lock() [a]
>> > >   wait until kn->active == 0
>> > >
>> > > Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
>> > > lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
>> > > would be detected:
> 
> The cpu_hotplug_lock is a per-CPU RWSEM. The lock in [a] will block if
> there is a writer pending.
> 
>> > >   ======================================================
>> > >   WARNING: possible circular locking dependency detected
>> > >   ------------------------------------------------------
>> > >   dmsetup/1832 is trying to acquire lock:
>> > >   ffff986f5a0f9f20 (kn->count#144){++++}-{0:0}, at: kernfs_remove+0x1d/0x30
>> > >
>> > >   but task is already holding lock:
>> > >   ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
>> > >
> 
> I tried to create & destroy a cryptarget which creates/destroy a cache
> via bio_put_slab(). Either the callchain is different or something else
> is but I didn't see a lockdep warning.

RHEL-8 kernel seems to be 4.18, unless RT uses a newer one. Could be some
silently relevant backport is missing? How about e.g. 59450bbc12be ("mm,
slab, slub: stop taking cpu hotplug lock") ?

> Sebastian

