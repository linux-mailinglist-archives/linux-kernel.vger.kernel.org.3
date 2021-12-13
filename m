Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7AC472E52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhLMN7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:59:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbhLMN7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:59:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 56D00210F4;
        Mon, 13 Dec 2021 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639403970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xv2KeMrWgel3brnTG+ZpO98Zs2+HVUao2xU3AH5qJ+g=;
        b=aFH8X9QFHN70y8Gqlzm/EG5anWQFaevDionJGqkVxi2HQpX9tuKh3zmBMSUUndoQF5iPTl
        homIS7SPQ40pYy9XXHwrKkMKe1Np4ONPymns3xA5dXTSp2g92rSf42wLVlwcRYKoabXN+H
        EmW4a5PX1ObGyE31Tw8gWPR5uAnLooA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639403970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xv2KeMrWgel3brnTG+ZpO98Zs2+HVUao2xU3AH5qJ+g=;
        b=6J4PecqkINo4w6VmRIzD+1vHKL6TeSGndXwaFvrjN5I8mCCtwJRA8JsgW2klQPubOV0Quf
        BXIc071GYCxXjMDA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 48A3FA3B89;
        Mon, 13 Dec 2021 13:59:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 17E5F1E11F3; Mon, 13 Dec 2021 14:59:30 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:59:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: don't use congestion_wait()
Message-ID: <20211213135930.GC14044@quack2.suse.cz>
References: <163712368225.13692.3419908086400748349@noble.neil.brown.name>
 <20211118104544.GB13047@quack2.suse.cz>
 <163911046430.9928.8662346319653420721@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163911046430.9928.8662346319653420721@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-12-21 15:27:44, NeilBrown wrote:
> On Thu, 18 Nov 2021, Jan Kara wrote:
> > On Wed 17-11-21 15:34:42, NeilBrown wrote:
> > > 
> > > Block devices do not, in general, report congestion any more, so this
> > > congestion_wait() is effectively just a sleep.
> > > 
> > > It isn't entirely clear what is being waited for, but as we only wait
> > > when j_async_throttle is elevated, it seems reasonable to stop waiting
> > > when j_async_throttle becomes zero - or after the same timeout.
> > > 
> > > So change to use wait_event_event_timeout() for waiting, and
> > > wake_up_var() to signal an end to waiting.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > > 
> > > I have no idea who might take this.... Jens and Jan have both landed
> > > reiserfs patches recently...
> > 
> > Yeah, I guess I can take this one. Honestly the whole code around
> > j_async_throttle looks a bit suspicious but your patch does not make it
> > worse so it looks safe to me :).
> 
> Hi,
>  I don't see this in linux-next.  Should I ??

No, my fault. I'm sorry. I didn't push out the resulting branch. Fixed now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
