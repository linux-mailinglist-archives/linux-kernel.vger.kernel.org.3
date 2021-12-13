Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB48473715
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbhLMV4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:56:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34190 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241399AbhLMV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:56:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 628D7212B6;
        Mon, 13 Dec 2021 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639432575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXmhF7TLPWUnevm8cJSMJUG6ZWkHqwl8bh4f6iLzhao=;
        b=1Pwe9liwMcUWdQdZ0TImAPng+1+V/PkFIOcEeVjyb5CDdKSNm9thkcAvsJ0oDVnpwtiBEk
        lMdfd7/+mcIHVaLI57cSGYQ26hB2sGqLYJ3CYcwg+k6+8kNFYXxE4LKnxZiU09F0Ucad0H
        124lBSmOUwDNGzl0KNomnugKlx/tTGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639432575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXmhF7TLPWUnevm8cJSMJUG6ZWkHqwl8bh4f6iLzhao=;
        b=R6FyI4eWkmJxzyLs618BPssilmj+KnTeC4Z/jaKTuyothPmW1dvLUe0mOR+vdXMWny4ajt
        TfZ7ckorEzA72GBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E176613EA5;
        Mon, 13 Dec 2021 21:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tvU0Jn3Bt2FvSwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Dec 2021 21:56:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Jan Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: don't use congestion_wait()
In-reply-to: <20211213135930.GC14044@quack2.suse.cz>
References: <163712368225.13692.3419908086400748349@noble.neil.brown.name>,
 <20211118104544.GB13047@quack2.suse.cz>,
 <163911046430.9928.8662346319653420721@noble.neil.brown.name>,
 <20211213135930.GC14044@quack2.suse.cz>
Date:   Tue, 14 Dec 2021 08:56:09 +1100
Message-id: <163943256925.22433.4500548806192726621@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021, Jan Kara wrote:
> On Fri 10-12-21 15:27:44, NeilBrown wrote:
> > On Thu, 18 Nov 2021, Jan Kara wrote:
> > > On Wed 17-11-21 15:34:42, NeilBrown wrote:
> > > > 
> > > > Block devices do not, in general, report congestion any more, so this
> > > > congestion_wait() is effectively just a sleep.
> > > > 
> > > > It isn't entirely clear what is being waited for, but as we only wait
> > > > when j_async_throttle is elevated, it seems reasonable to stop waiting
> > > > when j_async_throttle becomes zero - or after the same timeout.
> > > > 
> > > > So change to use wait_event_event_timeout() for waiting, and
> > > > wake_up_var() to signal an end to waiting.
> > > > 
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > > 
> > > > I have no idea who might take this.... Jens and Jan have both landed
> > > > reiserfs patches recently...
> > > 
> > > Yeah, I guess I can take this one. Honestly the whole code around
> > > j_async_throttle looks a bit suspicious but your patch does not make it
> > > worse so it looks safe to me :).
> > 
> > Hi,
> >  I don't see this in linux-next.  Should I ??
> 
> No, my fault. I'm sorry. I didn't push out the resulting branch. Fixed now.
> 

Yes-  I see it in your for-next branch now.  Thanks a lot!

NeilBrown
