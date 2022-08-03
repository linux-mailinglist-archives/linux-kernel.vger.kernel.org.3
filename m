Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45558854A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiHCBIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHCBIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:08:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12EF5509E;
        Tue,  2 Aug 2022 18:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93BABB82029;
        Wed,  3 Aug 2022 01:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F8C433D6;
        Wed,  3 Aug 2022 01:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659488918;
        bh=nFvBbjR87hTY904i1+8Fy8FiC4hebZxTVV+qEYLIg/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IK44tNyATmuHIJbWXYRZMj56Cu8AdGwvjirxqR90PmsqSdmS1JoZOnmyd7NUcUKWl
         avx17DBgigH9IH3d1beVf0Z7h0wMJxGe8DW3jjidN0HKn5sxI9w9X2I/c3qDMlmVKj
         kUjPBQMDanzoZX1U6MsM3KUxl80kDuh9qN6OloReq/EVXf4soGAWlONt8wd2aA03zo
         /DffC6Xko1Qxt42aK2yLSp9t+oSsimdWBspR6JY7viQKAXYc95G3u1jxM/t0rexV67
         fUvT76BqSpCP7BHZQyZ1K4WH+US2HghnrlSlxP3jk7TrDzhp2tzJ/RaBD17N/7uYRn
         EQ9yTuwrgkh8Q==
Date:   Tue, 2 Aug 2022 18:08:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <YunKlJCDlmyn2hJ4@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728155121.12145-1-code@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 09:21:21PM +0530, Siddh Raman Pant wrote:
> If not done, a reference to a freed pipe remains in the watch_queue,
> as this function is called before freeing a pipe in free_pipe_info()
> (see line 834 of fs/pipe.c).
> 
> This causes a UAF when post_one_notification() tries to access the pipe
> on a key update, which is reported by syzbot.
> 
> We also need to use READ_ONCE() in post_one_notification() to prevent the
> compiler from optimising and loading a non-NULL value from wqueue->pipe.

Didn't this already get fixed by the following commit?

	commit 353f7988dd8413c47718f7ca79c030b6fb62cfe5
	Author: Linus Torvalds <torvalds@linux-foundation.org>
	Date:   Tue Jul 19 11:09:01 2022 -0700

	    watchqueue: make sure to serialize 'wqueue->defunct' properly

With that, post_one_notification() only runs while the watch_queue is locked and
not "defunct".  So it's guaranteed that the pipe still exists.  Any concurrent
free_pipe_info() waits for the watch_queue to be unlocked in watch_queue_clear()
before proceeding to free the pipe.  So where is there still a bug?

> 
> Bug report: https://syzkaller.appspot.com/bug?id=1870dd7791ba05f2ea7f47f7cbdde701173973fc
> Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com

If this actually does fix something, then it's mixing Fixes and Cc stable tags.

> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index bb9962b33f95..617425e34252 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -99,7 +99,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
>  				  struct watch_notification *n)
>  {
>  	void *p;
> -	struct pipe_inode_info *pipe = wqueue->pipe;
> +	struct pipe_inode_info *pipe = READ_ONCE(wqueue->pipe);
>  	struct pipe_buffer *buf;
>  	struct page *page;
>  	unsigned int head, tail, mask, note, offset, len;
> @@ -637,6 +637,12 @@ void watch_queue_clear(struct watch_queue *wqueue)
>  		spin_lock_bh(&wqueue->lock);
>  	}
>  
> +	/* Clearing the watch queue, so we should clean the associated pipe. */
> +	if (wqueue->pipe) {
> +		wqueue->pipe->watch_queue = NULL;
> +		wqueue->pipe = NULL;
> +	}
> +
>  	spin_unlock_bh(&wqueue->lock);
>  	rcu_read_unlock();
>  }

And this is clearly the wrong fix anyway, since it makes the call to
put_watch_queue() in free_pipe_info() never be executed.  So AFAICT, this patch
introduces a memory leak, and doesn't actually fix anything...

- Eric
