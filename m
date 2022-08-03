Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5C58861E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiHCD4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHCD4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:56:52 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0E81C909;
        Tue,  2 Aug 2022 20:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659498976; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=aRmv8ft/QV0SV0pY9DB8VSmzcWxlYMX3VCP8fvpSBmBXvT2I2LFOJNCjLBygrSDOpv935TBJVZh/SFRN1Gfn76O8cL/JumUl+b1fIvnzVpfHT4P4FaZTCDBxQiJxFLlHBhvVlB9+Vw/WmWzXBanXZrBYdKt9MWad/MkLNZ7TKZk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659498976; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xU5ES2CK52NAh8jyyaVRlZryGewNv2BrrDPGvXlAlJA=; 
        b=c+CizvWRt8OK57861X+Fm+zOyZW97ncwGtpGGZfQxrbWWjM8mRNNhZU3oMKn2MqtyovHj4P2OU1aO3Wn9XnQeHRT1bjLf/9LGkxGwwk25lsDPej5Ty5oGQOakqxPewSXllrchUAOUJbwH6BF5/PjEAHud+wkhQzDMWze45FAUM0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659498976;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=xU5ES2CK52NAh8jyyaVRlZryGewNv2BrrDPGvXlAlJA=;
        b=R/VQkNWzGmZSw9cHnIPU2cRDV0IwE8FIoJ3CVRWRYexIbNvTkdbF8AmF+LGC9tXE
        sUMwDAxJt6NdG9qLjczLSJ1VOPtBaS6sT634lWpXa3TLvO3k+XfOvv0HdctteRnvGq3
        nuhBVEFkkhEIR/S28VwgGrL3y/dafxhoDMdta5Ds=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659498964559564.7672547663559; Wed, 3 Aug 2022 09:26:04 +0530 (IST)
Date:   Wed, 03 Aug 2022 09:26:04 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Message-ID: <18261d8a63a.33799d2a402802.7512018232560408914@siddh.me>
In-Reply-To: <YunKlJCDlmyn2hJ4@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me> <YunKlJCDlmyn2hJ4@sol.localdomain>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 06:38:36 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Jul 28, 2022 at 09:21:21PM +0530, Siddh Raman Pant wrote:
> > If not done, a reference to a freed pipe remains in the watch_queue,
> > as this function is called before freeing a pipe in free_pipe_info()
> > (see line 834 of fs/pipe.c).
> > 
> > This causes a UAF when post_one_notification() tries to access the pipe
> > on a key update, which is reported by syzbot.
> > 
> > We also need to use READ_ONCE() in post_one_notification() to prevent the
> > compiler from optimising and loading a non-NULL value from wqueue->pipe.
> 
> Didn't this already get fixed by the following commit?
> 
>     commit 353f7988dd8413c47718f7ca79c030b6fb62cfe5
>     Author: Linus Torvalds <torvalds@linux-foundation.org>
>     Date:   Tue Jul 19 11:09:01 2022 -0700
> 
>         watchqueue: make sure to serialize 'wqueue->defunct' properly
> 
> With that, post_one_notification() only runs while the watch_queue is locked and
> not "defunct".  So it's guaranteed that the pipe still exists.  Any concurrent
> free_pipe_info() waits for the watch_queue to be unlocked in watch_queue_clear()
> before proceeding to free the pipe.  So where is there still a bug?

It doesn't fix the dangling pointer to the freed pipe in the watch_queue, which
had caused this crash.

> > 
> > Bug report: https://syzkaller.appspot.com/bug?id=1870dd7791ba05f2ea7f47f7cbdde701173973fc
> > Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
> 
> If this actually does fix something, then it's mixing Fixes and Cc stable tags.

Noted.

> > diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> > index bb9962b33f95..617425e34252 100644
> > --- a/kernel/watch_queue.c
> > +++ b/kernel/watch_queue.c
> > @@ -99,7 +99,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
> >                    struct watch_notification *n)
> >  {
> >      void *p;
> > -    struct pipe_inode_info *pipe = wqueue->pipe;
> > +    struct pipe_inode_info *pipe = READ_ONCE(wqueue->pipe);
> >      struct pipe_buffer *buf;
> >      struct page *page;
> >      unsigned int head, tail, mask, note, offset, len;
> > @@ -637,6 +637,12 @@ void watch_queue_clear(struct watch_queue *wqueue)
> >          spin_lock_bh(&wqueue->lock);
> >      }
> >  
> > +    /* Clearing the watch queue, so we should clean the associated pipe. */
> > +    if (wqueue->pipe) {
> > +        wqueue->pipe->watch_queue = NULL;
> > +        wqueue->pipe = NULL;
> > +    }
> > +
> >      spin_unlock_bh(&wqueue->lock);
> >      rcu_read_unlock();
> >  }
> 
> And this is clearly the wrong fix anyway, since it makes the call to
> put_watch_queue() in free_pipe_info() never be executed.  So AFAICT, this patch
> introduces a memory leak, and doesn't actually fix anything...
> 
> - Eric
> 

Sorry for overlooking that. wqueue->pipe->watch_queue = NULL; is unnecessary,
but wqueue->pipe = NULL; is needed.

I will send a final v4 once all issues are resolved in this thread.

Thanks,
Siddh
