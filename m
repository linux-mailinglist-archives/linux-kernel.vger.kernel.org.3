Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5065B01D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiIGKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiIGKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:23:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8EE2FFF3;
        Wed,  7 Sep 2022 03:23:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CF91202D9;
        Wed,  7 Sep 2022 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662546199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVOd6VzsLq3+2NgXLsXG6WSVb5nAQHjklm2vBJj3gwc=;
        b=TMZULmgGJ0UGAVZEZTXt9pmTbssAEI/3djKPfcbHzpu6CgidfMr61+CPQKNw59KqBGP1xU
        xiLNLKo1bnwQlfgixzCsBl24v7Z6gM28BUoGn8oO+cj77zf43eWf41llI/8DKNFRjBgJv0
        5MAv8c6A0hjgjPM3+YN6QHYgChNndkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662546199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVOd6VzsLq3+2NgXLsXG6WSVb5nAQHjklm2vBJj3gwc=;
        b=sXg8w4N1dtErwl6IQ18gxM8+GY6Lufmi0vT/rUwna9qS6bA34X2RvvNGXkn79LOFX8B13k
        p7yGsx2ekFe3P2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C12813A66;
        Wed,  7 Sep 2022 10:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QLqQEhdxGGOCRwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 07 Sep 2022 10:23:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CFD10A067E; Wed,  7 Sep 2022 12:23:18 +0200 (CEST)
Date:   Wed, 7 Sep 2022 12:23:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, axboe@kernel.dk,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Message-ID: <20220907102318.pdpzpmhah2m3ptbn@quack3>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
 <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-09-22 15:27:51, Keith Busch wrote:
> On Wed, Aug 03, 2022 at 08:15:04PM +0800, Yu Kuai wrote:
> >  	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> > -	if (wait_cnt <= 0) {
> > -		int ret;
> > +	/*
> > +	 * For concurrent callers of this, callers should call this function
> > +	 * again to wakeup a new batch on a different 'ws'.
> > +	 */
> > +	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
> > +		return true;
> 
> If wait_cnt is '0', but the waitqueue_active happens to be false due to racing
> with add_wait_queue(), this returns true so the caller will retry.

Well, note that sbq_wake_ptr() called to obtain 'ws' did waitqueue_active()
check. So !waitqueue_active() should really happen only if waiter was woken
up by someone else or so. Not that it would matter much but I wanted to
point it out.

> The next atomic_dec will set the current waitstate wait_cnt < 0, which
> also forces an early return true. When does the wake up happen, or
> wait_cnt and wait_index get updated in that case?

I guess your concern could be rephrased as: Who's going to ever set
ws->wait_cnt to value > 0 if we ever exit with wait_cnt == 0 due to
!waitqueue_active() condition?

And that is a good question and I think that's a bug in this patch. I think
we need something like:

	...
	/*
	 * For concurrent callers of this, callers should call this function
	 * again to wakeup a new batch on a different 'ws'.
	 */
	if (wait_cnt < 0)
		return true;
	/*
	 * If we decremented queue without waiters, retry to avoid lost
	 * wakeups.
	 */
	if (wait_cnt > 0)
		return !waitqueue_active(&ws->wait);

	/*
	 * When wait_cnt == 0, we have to be particularly careful as we are
	 * responsible to reset wait_cnt regardless whether we've actually
	 * woken up anybody. But in case we didn't wakeup anybody, we still
	 * need to retry.
	 */
	ret = !waitqueue_active(&ws->wait);
	wake_batch = READ_ONCE(sbq->wake_batch);
	/*
	 * Wake up first in case that concurrent callers decrease wait_cnt
	 * while waitqueue is empty.
	 */
	wake_up_nr(&ws->wait, wake_batch);
	...

	return ret;

Does this fix your concern Keith?

								Honza

> 
>   
> > -		wake_batch = READ_ONCE(sbq->wake_batch);
> > +	if (wait_cnt > 0)
> > +		return false;
> >  
> > -		/*
> > -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
> > -		 * ensure that we see the batch size update before the wait
> > -		 * count is reset.
> > -		 */
> > -		smp_mb__before_atomic();
> > +	wake_batch = READ_ONCE(sbq->wake_batch);
> >  
> > -		/*
> > -		 * For concurrent callers of this, the one that failed the
> > -		 * atomic_cmpxhcg() race should call this function again
> > -		 * to wakeup a new batch on a different 'ws'.
> > -		 */
> > -		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
> > -		if (ret == wait_cnt) {
> > -			sbq_index_atomic_inc(&sbq->wake_index);
> > -			wake_up_nr(&ws->wait, wake_batch);
> > -			return false;
> > -		}
> > +	/*
> > +	 * Wake up first in case that concurrent callers decrease wait_cnt
> > +	 * while waitqueue is empty.
> > +	 */
> > +	wake_up_nr(&ws->wait, wake_batch);
> >  
> > -		return true;
> > -	}
> > +	/*
> > +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> > +	 * ensure that we see the batch size update before the wait
> > +	 * count is reset.
> > +	 *
> > +	 * Also pairs with the implicit barrier between decrementing wait_cnt
> > +	 * and checking for waitqueue_active() to make sure waitqueue_active()
> > +	 * sees result of the wakeup if atomic_dec_return() has seen the result
> > +	 * of atomic_set().
> > +	 */
> > +	smp_mb__before_atomic();
> > +
> > +	/*
> > +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> > +	 * callers can see valid wait_cnt in old waitqueue, which can cause
> > +	 * invalid wakeup on the old waitqueue.
> > +	 */
> > +	sbq_index_atomic_inc(&sbq->wake_index);
> > +	atomic_set(&ws->wait_cnt, wake_batch);
> >  
> >  	return false;
> >  }
> > -- 
> > 2.31.1
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
