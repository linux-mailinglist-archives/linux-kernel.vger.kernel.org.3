Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5E5B0A69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIGQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiIGQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:42:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561B760FC;
        Wed,  7 Sep 2022 09:41:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32E8833F2D;
        Wed,  7 Sep 2022 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662568911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6tOcNdtfFU3h01fMPnmLVH8bomBdNq7Oqmv2FQpXEA=;
        b=rBXrqdSrIf0kgAXJiAQ+wTgPQhRvW0WCEX6CcQi0LnpBLlk0uu3m/F26IV8BTZHWWp13iv
        nPC2WCOeXiTdgOUWYAdDXct1irh3uCOjkCjKIQlh1cLDEv7yxPkPJpkPb9eGj4KN6/nZ8p
        hUR6odgLbdwGFqltXR39eIBZPkSqpeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662568911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6tOcNdtfFU3h01fMPnmLVH8bomBdNq7Oqmv2FQpXEA=;
        b=vncHjWdKL5K7o+84s+DptSAhlOr0WFNomHISBRMXXR4eprSqCJYXvVjEKDWTVYcDZANQ1t
        jAZ7ynqc4kL2TwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25C0213A66;
        Wed,  7 Sep 2022 16:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XsssCc/JGGMZeAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 07 Sep 2022 16:41:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8857A067E; Wed,  7 Sep 2022 18:41:50 +0200 (CEST)
Date:   Wed, 7 Sep 2022 18:41:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>,
        axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Message-ID: <20220907164150.tykjl3jsctjddcnq@quack3>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
 <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
 <20220907102318.pdpzpmhah2m3ptbn@quack3>
 <YxinFEYRCU/QuQ5w@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxinFEYRCU/QuQ5w@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-09-22 08:13:40, Keith Busch wrote:
> On Wed, Sep 07, 2022 at 12:23:18PM +0200, Jan Kara wrote:
> > On Tue 06-09-22 15:27:51, Keith Busch wrote:
> > > On Wed, Aug 03, 2022 at 08:15:04PM +0800, Yu Kuai wrote:
> > > >  	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> > > > -	if (wait_cnt <= 0) {
> > > > -		int ret;
> > > > +	/*
> > > > +	 * For concurrent callers of this, callers should call this function
> > > > +	 * again to wakeup a new batch on a different 'ws'.
> > > > +	 */
> > > > +	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
> > > > +		return true;
> > > 
> > > If wait_cnt is '0', but the waitqueue_active happens to be false due to racing
> > > with add_wait_queue(), this returns true so the caller will retry.
> > 
> > Well, note that sbq_wake_ptr() called to obtain 'ws' did waitqueue_active()
> > check. So !waitqueue_active() should really happen only if waiter was woken
> > up by someone else or so. Not that it would matter much but I wanted to
> > point it out.
> > 
> > > The next atomic_dec will set the current waitstate wait_cnt < 0, which
> > > also forces an early return true. When does the wake up happen, or
> > > wait_cnt and wait_index get updated in that case?
> > 
> > I guess your concern could be rephrased as: Who's going to ever set
> > ws->wait_cnt to value > 0 if we ever exit with wait_cnt == 0 due to
> > !waitqueue_active() condition?
> > 
> > And that is a good question and I think that's a bug in this patch. I think
> > we need something like:
> > 
> > 	...
> > 	/*
> > 	 * For concurrent callers of this, callers should call this function
> > 	 * again to wakeup a new batch on a different 'ws'.
> > 	 */
> > 	if (wait_cnt < 0)
> > 		return true;
> > 	/*
> > 	 * If we decremented queue without waiters, retry to avoid lost
> > 	 * wakeups.
> > 	 */
> > 	if (wait_cnt > 0)
> > 		return !waitqueue_active(&ws->wait);
> 
> I'm not sure about this part. We've already decremented, so the freed bit is
> accounted for against the batch. Returning true here may double-count the freed
> bit, right?

Yes, we may wake up waiters unnecessarily frequently. But that's a
performance issue at worst and only if it happens frequently. So I don't
think it matters in practice (famous last words ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
