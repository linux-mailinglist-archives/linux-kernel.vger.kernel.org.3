Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2155FF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiF2Lzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiF2Lzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:55:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427E387B1;
        Wed, 29 Jun 2022 04:55:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D6707220E0;
        Wed, 29 Jun 2022 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656503739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bF/LSSs2g8Q6JLHlya2E6zoiGTFvYRLz8XXwkmSkeI0=;
        b=GiHzf/Mi0x/V4my9jBprmV4ydlz1A8WxABnZ+n81Wxqgcgfa5dMtxOIA1EtJvo/rN3uJA2
        lVEHsSW5xKN4UPsqhddeK8fDq9C8Ja+RTbdCzXAXQbd42plY8G+0Ag9wjXuWsqEC65fpBQ
        7IkSyEbV5gRPYtEG9fw8bcHwqH1ITFM=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A79142C141;
        Wed, 29 Jun 2022 11:55:39 +0000 (UTC)
Date:   Wed, 29 Jun 2022 13:55:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <20220629115539.GB12720@pathway.suse.cz>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
 <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
 <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-06-28 18:33:08, Valentin Schneider wrote:
> On 27/06/22 13:42, Valentin Schneider wrote:
> > On 25/06/22 12:04, Eric W. Biederman wrote:
> >> At this point I recommend going back to being ``unconventional'' with
> >> the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
> >> use a mutex for locking rather than xchg()").
> >>
> >> That would also mean that we don't have to worry about the lockdep code
> >> doing something weird in the future and breaking kexec.
> >>
> >> Your change starting to is atomic_cmpxchng is most halfway to a revert
> >> of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
> >> xchg()").  So we might as well go the whole way and just document that
> >> the kexec on panic code can not use conventional kernel locking
> >> primitives and has to dig deep and build it's own.  At which point it
> >> makes no sense for the rest of the kexec code to use anything different.
> >>
> >
> > Hm, I'm a bit torn about that one, ideally I'd prefer to keep "homegrown"
> > locking primitives to just where they are needed (loading & kexec'ing), but
> > I'm also not immensely fond of the "hybrid" mutex+cmpxchg approach.
> >
> 
> 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()") was
> straightforward enough because it turned
> 
>         if (xchg(&lock, 1))
>                 return -EBUSY;
> 
> into
> 
>         if (!mutex_trylock(&lock))
>                 return -EBUSY;
> 
> Now, most of the kexec_mutex uses are trylocks, except for:
> - crash_get_memory_size()
> - crash_shrink_memory()
> 
> I really don't want to go down the route of turning those into cmpxchg
> try-loops, would it be acceptable to make those use trylocks (i.e. return
> -EBUSY if the cmpxchg fails)?

IMHO, -EBUSY is acceptable for both crash_get_memory_size()
and crash_shrink_memory(). They are used in the sysfs interface.

> Otherwise, we keep the mutexes for functions like those which go nowhere
> near an NMI.

If we go this way then I would hide the locking into some wrappers,
like crash_kexec_trylock()/unlock() that would do both mutex
and xchg. The xchg part might be hidden in a separate wrapper
__crash_kexec_trylock()/unlock() or
crash_kexec_atomic_trylock()/unlock().

Best Regards,
Petr
