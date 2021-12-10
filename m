Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF246F9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhLJEb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:31:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37018 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhLJEb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:31:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D2E91F387;
        Fri, 10 Dec 2021 04:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639110472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exDGmvpV/qIsCI3WVAE1kexMAyP+p/jWNiVK7uoUKi4=;
        b=Et5rxi5Hc4qOuTnb7bY+piL9p7ttYB/4OcFhEI0/tZ7BzHujYrmaplQ3xfanrPh3PPuO0c
        sgZ6afkX3Y1HKMdeRTccIO3biRgYJnB9S0TbyLgo39TapLvyvdeezeM7z4XfgRH+3bmL+m
        oUSI7BnM6yCxF1IIYnT9x8VlyRIkETU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639110472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exDGmvpV/qIsCI3WVAE1kexMAyP+p/jWNiVK7uoUKi4=;
        b=gcR88hULbP9FQI8fBCVOmqzGkmiIgyoqYAq0bC17dds+tpSAPT5RL+tjmzyngLWyedehTK
        JVdE78lCEeweyDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7749C13DC8;
        Fri, 10 Dec 2021 04:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mr+FDUbXsmGxTAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 10 Dec 2021 04:27:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Jan Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: don't use congestion_wait()
In-reply-to: <20211118104544.GB13047@quack2.suse.cz>
References: <163712368225.13692.3419908086400748349@noble.neil.brown.name>,
 <20211118104544.GB13047@quack2.suse.cz>
Date:   Fri, 10 Dec 2021 15:27:44 +1100
Message-id: <163911046430.9928.8662346319653420721@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021, Jan Kara wrote:
> On Wed 17-11-21 15:34:42, NeilBrown wrote:
> > 
> > Block devices do not, in general, report congestion any more, so this
> > congestion_wait() is effectively just a sleep.
> > 
> > It isn't entirely clear what is being waited for, but as we only wait
> > when j_async_throttle is elevated, it seems reasonable to stop waiting
> > when j_async_throttle becomes zero - or after the same timeout.
> > 
> > So change to use wait_event_event_timeout() for waiting, and
> > wake_up_var() to signal an end to waiting.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > 
> > I have no idea who might take this.... Jens and Jan have both landed
> > reiserfs patches recently...
> 
> Yeah, I guess I can take this one. Honestly the whole code around
> j_async_throttle looks a bit suspicious but your patch does not make it
> worse so it looks safe to me :).

Hi,
 I don't see this in linux-next.  Should I ??

Thanks,
NeilBrown
