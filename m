Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271BE582A97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiG0QVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiG0QVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:21:32 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796343E48;
        Wed, 27 Jul 2022 09:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658938862; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=YPp9A7wZ03tp8wezdjbFc7e9zwHpNpauHaJ6PHEKXYAihY+pGlTxgXZNIVVwMzJDCqoExmkzi+bP88Vs+c84o3IveIS0vlBR9TY6ieWSSQqFIt7ItCbxLv1/8+ZNksi6lMeMPg+lLvvwSVKOziC4MwzwgqqC5bK9eHPilrNGj1I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658938862; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9bWNAdarOcU8borJ9QY+qCVRT1DHj4b2kF/jYpSU85c=; 
        b=WLnR68oCZhvr3LV8cR3r+pA1PahfvotNElQAGKwKistPSqtxzjgjDZuO+uSuL0Nea+ID0/WmdXNxQgb6mzCksukbuDYsRXUww3HbemDvK1iNcvR28RonnH6fwYPq8Qi633QtCoBwBKSdXeXcZTZHLxYKM3xZt3pNt9zulc/2OW0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658938862;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9bWNAdarOcU8borJ9QY+qCVRT1DHj4b2kF/jYpSU85c=;
        b=WBiMOvQofgnmrlX/KDTIEWdpfV4rkfLrTG5khAOmhrYCG98rlbYRkEUNabWjw6nu
        OFttNqXLjHsqjrq7SLioHW6hhVhlA9XdS14RGv9TzPfbf9FA1BKrD7RJauVo/ezCWMM
        El4HJjMSakXH4IOQchuwITyfgJ3Cg3vVrwzdqWUQ=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658938852066566.1813973782993; Wed, 27 Jul 2022 21:50:52 +0530 (IST)
Date:   Wed, 27 Jul 2022 21:50:52 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "David Howells" <dhowells@redhat.com>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Message-ID: <182407602ce.190e58816827.7904364186178466266@siddh.me>
In-Reply-To: <3558070.1658933200@warthog.procyon.org.uk>
References: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me> <20220723135447.199557-1-code@siddh.me> <Ytv/4Tljvlt0PJ2r@kroah.com> <3558070.1658933200@warthog.procyon.org.uk>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
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

On Wed, 27 Jul 2022 20:16:40 +0530  David Howells <dhowells@redhat.com> wrote:
> Siddh Raman Pant <code@siddh.me> wrote:
> 
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > > - spin_unlock_bh(&wqueue->lock);
> > > >   rcu_read_unlock();
> > >
> > > Also you now have a spinlock held when calling rcu_read_unlock(), are
> > > you sure that's ok?
> 
> Worse, we have softirqs disabled still, which might cause problems for
> rcu_read_unlock()?
> 
> > We logically should not do write operations in a read critical section, so the
> > nulling of `wqueue->pipe->watch_queue` should happen after rcu_read_unlock().
> > Also, since we already have a spinlock, we can use it to ensure the nulling.
> > So I think it is okay.
> 
> Read/write locks are perhaps misnamed in this sense; they perhaps should be
> shared/exclusive.  But, yes, we *can* do certain write operations with the
> lock held - if we're careful.  Locks are required if we need to pairs of
> related memory accesses; if we're only making a single non-dependent write,
> then we don't necessarily need a write lock.
> 
> However, you're referring to RCU read lock.  That's a very special lock that
> has to do with maintenance of persistence of objects without taking any other
> lock.  The moment you drop that lock, anything you accessed under RCU protocol
> rules should be considered to have evaporated.
> 
> Think of it more as a way to have a deferred destructor/deallocator.
> 
> So I would do:
> 
> +
> +       /* Clearing the watch queue, so we should clean the associated pipe. */
> +       if (wqueue->pipe) {
> +               wqueue->pipe->watch_queue = NULL;
> +               wqueue->pipe = NULL;
> +       }
> +
>         spin_unlock_bh(&wqueue->lock);
>         rcu_read_unlock();
>  }
> 
> However, since you're now changing wqueue->pipe whilst a notification is being
> posted, you need a barrier in post_one_notification() to prevent the compiler
> from reloading the value:
> 
>         struct pipe_inode_info *pipe = READ_ONCE(wqueue->pipe);
> 
> David
> 

Thank you for explaining it!

I will send a v3. Should I add a Suggested-by tag mentioning you?

Thanks,
Siddh
