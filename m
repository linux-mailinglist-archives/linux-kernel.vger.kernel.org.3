Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD010471F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhLMCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:49:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhLMCtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:49:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3EF4D1F3B0;
        Mon, 13 Dec 2021 02:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639363755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARU1chUSDNNbEO0Gmuw+z4jcRaOzwHttZpVv4bXZVME=;
        b=c+/6p2rTtmAaA+NWZr62ery+YWOgqmspY1w9O5n7qryWpA4hi1LkwmuPwcNYqcy86OpsVa
        T9lQKdu0kurh6iIO7gkw18q1teD5Rok6yWovORBIY5gNtVuEACQ/rF0Nv1QQ6yFfhPAIDt
        TqsZJ7Vn0ds4asvPPy4SdV9cXNCWFAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639363755;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARU1chUSDNNbEO0Gmuw+z4jcRaOzwHttZpVv4bXZVME=;
        b=P2E/S3Ksotww5zAfG0rehTW0+xH/GdzUOwA2yBfwCVas0vGSzH7qIQQKwVJ1rVy8o6pfcv
        GUw2ATTgU+5XdbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB88913310;
        Mon, 13 Dec 2021 02:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z7zYIKm0tmHgKwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Dec 2021 02:49:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH v2] FAT: use schedule_timeout_uninterruptible() instead of
 congestion_wait()
In-reply-to: <875yrtql2s.fsf@mail.parknet.co.jp>
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>,
 <87ee79yiik.fsf@mail.parknet.co.jp>,
 <163754226639.13692.10449616189734943162@noble.neil.brown.name>,
 <874k84hi5q.fsf@mail.parknet.co.jp>,
 <163911011670.9928.6438117555175130033@noble.neil.brown.name>,
 <163911016975.9928.6568675782275129@noble.neil.brown.name>,
 <87h7bfmtqc.fsf@mail.parknet.co.jp>,
 <163936252397.22433.9103044991910658320@noble.neil.brown.name>,
 <875yrtql2s.fsf@mail.parknet.co.jp>
Date:   Mon, 13 Dec 2021 13:49:07 +1100
Message-id: <163936374739.22433.3300471788473733689@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021, OGAWA Hirofumi wrote:
> "NeilBrown" <neilb@suse.de> writes:
>=20
> > On Sat, 11 Dec 2021, OGAWA Hirofumi wrote:
> >> "NeilBrown" <neilb@suse.de> writes:
> >>=20
> >> > congestion_wait() in this context is just a sleep - block devices do n=
ot
> >> > in general support congestion signalling any more.
> >> >
> >> > The goal here is to wait for any recently written data to get to
> >> > storage.  blkdev_issue_flush() is thought to be too expensive, so
> >> > replace congestion_wait() with an explicit timeout.
> >>=20
> >> If just replace, the following looks better
> >>=20
> >> 	set_current_state(TASK_UNINTERRUPTIBLE);
> >> 	io_schedule_timeout(HZ/10);
> >>=20
> >> Otherwise,
> >>=20
> >> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> >
> > Thanks.
> > According to MAINTAINERS, I should send patches for this code to you,
> > with the implication (I assumed) that you would forwarded them upstream
> > if acceptable.
> > But the fact that you have send mt an Acked-By seems to suggest that you
> > won't be doing that.
> > To whom should I send this patch with your acked-by?
>=20
> Ah, sorry. I have no repository. So FAT patches goes to linus tree via
> akpm's help.
>=20
> So "Cc: Andrew Morton <akpm@linux-foundation.org>" and my Acked-by
> should work (or I will Cc as reply if need).

Will do, thanks.

NeilBrown
