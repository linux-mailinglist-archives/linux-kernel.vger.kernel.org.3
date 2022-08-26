Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BD5A2637
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbiHZKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245100AbiHZKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:55:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEDC1C11B;
        Fri, 26 Aug 2022 03:55:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A42F91F9EF;
        Fri, 26 Aug 2022 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661511313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJjPoLSdn1Ab7WC5trQqNg3byZqTk6tSEArhcgceCXk=;
        b=OW9svkO3+fb0D8mMUaCVQ0Rf0VCHAigtpnLAA9SUHMU/fRhUZyXg/OrSLETY5Fa6Flr9UB
        8W31DSEgjYx9MFKnb+mk9SNtavV8OLzytuOLed6O8PDJbFeWEUCKfMz7qZoDe+D09ywRcp
        AmNU+Lz2EzHqN4zmvFN8MSSRB/zDTDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661511313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJjPoLSdn1Ab7WC5trQqNg3byZqTk6tSEArhcgceCXk=;
        b=UNzojhwqTFs/+RBrjZjarLlWGH52nY2a1OQ+YNAEbC/RTvipGG6ZeDQLGKQZyZBW4EQ8D7
        tExFnSYeG3UedIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9541713A7E;
        Fri, 26 Aug 2022 10:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pnpsJJGmCGOwZwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 26 Aug 2022 10:55:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 278BFA0679; Fri, 26 Aug 2022 12:55:13 +0200 (CEST)
Date:   Fri, 26 Aug 2022 12:55:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Jan Kara <jack@suse.cz>, Meelis Roos <mroos@linux.ee>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.com
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Message-ID: <20220826105513.eo5otoujtz75u7dg@quack3>
References: <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
 <20190219144454.GB12668@bombadil.infradead.org>
 <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
 <20190220094813.GA27474@quack2.suse.cz>
 <2381c264-92f5-db43-b6a5-8e00bd881fef@linux.ee>
 <20190221132916.GA22886@quack2.suse.cz>
 <97dbffaefa65a83b36e1ec134fd53a66@matoro.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97dbffaefa65a83b36e1ec134fd53a66@matoro.tk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-08-22 11:05:48, matoro wrote:
> Hello all, I know this is quite an old thread.  I recently acquired some
> alpha hardware and have run into this exact same problem on the latest
> stable kernel (5.18 and 5.19).  CONFIG_COMPACTION seems to be totally broken
> and causes userspace to be extremely unstable - random segfaults, corruption
> of glibc data structures, gcc ICEs etc etc - seems most noticable during
> tasks with heavy I/O load.
> 
> My hardware is a DS15 (Titan), so only slightly newer than the Tsunamis
> mentioned earlier.  The problem is greatly exacerbated when using a
> machine-optimized kernel (CONFIG_ALPHA_TITAN) over one with
> CONFIG_ALPHA_GENERIC.  But it still doesn't go away on a generic kernel,
> just pops up less often, usually very I/O heavy tasks like checking out a
> tag in the kernel repo.
> 
> However all of this seems to be dependent on CONFIG_COMPACTION.  With this
> toggled off all problems disappear, regardless of other options.  I tried
> reverting the commit 88dbcbb3a4847f5e6dfeae952d3105497700c128 mentioned
> earlier in the thread (the structure has moved to a different file but was
> otherwise the same), but it unfortunately did not make a difference.
> 
> Since this doesn't seem to have a known cause or an easy fix, would it be
> reasonable to just add a Kconfig dep to disable it automatically on alpha?

Thanks for report. I guess this just confirms that migration of pagecache
pages is somehow broken on Alpha. Maybe we are missing to flush some cache
specific for Alpha? Or maybe the page migration code is not safe wrt the
peculiar memory ordering Alpha has... I think this will need someone with
Alpha HW and willingness to dive into MM internals to debug this. Added
Vlasta to CC mostly for awareness and in case it rings some bells :).

								Honza

> -------- Original Message --------
> Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
> Date: 2019-02-21 08:29
> From: Jan Kara <jack@suse.cz>
> To: Meelis Roos <mroos@linux.ee>
> 
> On Thu 21-02-19 01:23:50, Meelis Roos wrote:
> > > > First, I found out that both the problematic alphas had memory compaction and
> > > > page migration and bounce buffers turned on, and working alphas had them off.
> > > >
> > > > Next, turing off these options makes the problematic alphas work.
> > >
> > > OK, thanks for testing! Can you narrow down whether the problem is due to
> > > CONFIG_BOUNCE or CONFIG_MIGRATION + CONFIG_COMPACTION? These are two
> > > completely different things so knowing where to look will help. Thanks!
> > 
> > Tested both.
> > 
> > Just CONFIG_MIGRATION + CONFIG_COMPACTION breaks the alpha.
> > Just CONFIG_BOUNCE has no effect in 5 tries.
> 
> OK, so page migration is problematic. Thanks for confirmation!
> 
> 								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
