Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5449244F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiARLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:08:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45240 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiARLHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:07:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A45041F3C0;
        Tue, 18 Jan 2022 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642504041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBJ7AEiCYFHzM3I2zFFq4RgvGYZvYiPVEtyWVXWxLN0=;
        b=wNyJMttmonPq40jN9aGmLrlhMPB3R+0kJkRTmMtzp6FH6aKGo+p9S2IqQN5Nz0GXE/TEDb
        I0tTwbDhjJsATIFEu9ZbMeOKYujXAk8/RvcHYGB8obQ1uuDSqSJ2Z8Xofu7ULNbA1j1j/1
        3CVCc1hyrRu96gEUDaSzUu2vy7KB1Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642504041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBJ7AEiCYFHzM3I2zFFq4RgvGYZvYiPVEtyWVXWxLN0=;
        b=b12NQcJmVqQp1B4Dc9n1RQtxR7B3KuqqLyXdYIcS3ovaFM742ko1BTq816R3yVWYL+cnV0
        FX/2ZX/eT2en9JBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77D3013DC7;
        Tue, 18 Jan 2022 11:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CsKRHGmf5mHSQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 11:07:21 +0000
Message-ID: <f8fa28d4-bf89-39f7-92f9-4d7957e57c2c@suse.cz>
Date:   Tue, 18 Jan 2022 12:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
Content-Language: en-US
To:     Xin Long <lucien.xin@gmail.com>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
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
 <39a3470f-06ab-cf41-32e4-80edb249c7d3@suse.cz>
 <20220117131304.pdc3mfdowkzovw6q@localhost.localdomain>
 <CADvbK_eKRNpE7PkdFLQgmfEme5LgEVDK7WakUc-Rj4XTRSpdiQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CADvbK_eKRNpE7PkdFLQgmfEme5LgEVDK7WakUc-Rj4XTRSpdiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/22 09:00, Xin Long wrote:
> On Mon, Jan 17, 2022 at 9:13 PM Juri Lelli <juri.lelli@redhat.com> wrote:
>> >
>> > RHEL-8 kernel seems to be 4.18, unless RT uses a newer one. Could be some
>> > silently relevant backport is missing? How about e.g. 59450bbc12be ("mm,
>> > slab, slub: stop taking cpu hotplug lock") ?
>>
>> Hummm, looks like we have backported commit 59450bbc12be in RHEL-8.
>>
>> Xin Long, would you be able to check if you still see the lockdep splat
>> with latest upstream RT?
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt
> Hi, Juri,
> 
> Thanks for sharing the RT kernel repo.
> 
> I just tried with this kernel, and I couldn't reproduce it on my env.
> But I don't see how the upstream RT kernel can avoid the call trace.
> 
> As this warning was triggered when the system was shutting down, it might
> not be reproduced on it due to some timing change.

As it was caught by lockdep and not as a real deadlock, I think it should be
indepenedent of a timing change. Lockdep will correlate potentially deadlock
scenarios even if they don't really occur in the same time, AFAIK.

But let's go back to:

> Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
> lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
> would be detected:

Is it possible that upstream lockdep handles this RWSEM scenario properly
and doesn't report it, but the RHEL kernel is missing some relevant lockdep fix?

>>
>> Thanks!
>> Juri
>>

