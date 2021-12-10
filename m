Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4446F9CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhLJEZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:25:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54560 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhLJEZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:25:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01D08210FC;
        Fri, 10 Dec 2021 04:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639110121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSE2Lgjco575OzMlHvq9304OLpBdxyI6RgPuZG9KlBU=;
        b=xBvPeVqn6EbDDOXOZIB2UkFOjmNJ6mvwPuUV6b+JWBHMVIM4RyBtay9lDbWA0/Np9g1r4I
        rJvvYxAVndFfJxiQHT2Q8W4Zgc589PqD6P5LhgXik+iVe3Ak4q9+uU7FUT7UfHza6FXFvC
        b2paScM1YuHRNGndzvF7bcben2dSw7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639110121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSE2Lgjco575OzMlHvq9304OLpBdxyI6RgPuZG9KlBU=;
        b=JTu+oXSzg6dgwW28SJhcDFYDaa563iMyamE67yL0LMBlRiraU1IO5yCM1UudaE0lAAhkdT
        7cOkSnLyVYAvn4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A656E13DC8;
        Fri, 10 Dec 2021 04:21:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fiIdGefVsmFJSwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 10 Dec 2021 04:21:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] FAT: use blkdev_issue_flush() instead of congestion_wait()
In-reply-to: <874k84hi5q.fsf@mail.parknet.co.jp>
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>,
 <87ee79yiik.fsf@mail.parknet.co.jp>,
 <163754226639.13692.10449616189734943162@noble.neil.brown.name>,
 <874k84hi5q.fsf@mail.parknet.co.jp>
Date:   Fri, 10 Dec 2021 15:21:56 +1100
Message-id: <163911011670.9928.6438117555175130033@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021, OGAWA Hirofumi wrote:
> "NeilBrown" <neilb@suse.de> writes:
>=20
> > On Sun, 21 Nov 2021, OGAWA Hirofumi wrote:
> >> "NeilBrown" <neilb@suse.de> writes:
> >>=20
> >> > congestion_wait() in this context is just a sleep - block devices do n=
ot
> >> > in general support congestion signalling any more.
> >> >
> >> > The goal here is to wait for any recently written data to get to
> >> > storage.  This can be achieved using blkdev_issue_flush().
> >>=20
> >> Purpose of flush option should be for making umount faster, not data
> >> integrity. (but current flush implement is strange at several places, IM=
O)
> >
> > I don't think that is true.  I believe the purpose of the flush option
> > is to write out data as soon as a file is closed, so that if the media
> > is removed without first unmounting, the data is more likely to be safe.
> > That is why the commit which introduce it:
> >  Commit ae78bf9c4f5f ("[PATCH] add -o flush for fat")
> > particularly mentions "removable media".
>=20
> Right. This was to make the removable device usage better (but sync
> option is too slow).
>=20
> e.g.
>     # cp -a /foo/source /mnt/fatfs
>=20
>     # umount <don't too slow>
>     or
>     <do other thing, and forget umount>

or use GUI to drag a file to the removable device, wait for the copy to
appear to finish, then pull the device.

sync is too slow as it flush each change to storage as it happens.  Each
block, each FA-Table update etc.

"-o flush" does the flush as file-close rather than on each write.
But it still needs to provide the same safety.  i.e. write and flush and
wait.

>=20
> >> So, I don't think the issue_flush is not proper for it (flush is very
> >> slow on some usb thumb), and rather I think it is better off to just
> >> remove the congestion_wait().
> >
> > We already call blkdev_issue_flush() on fsync.  With my patch, a simple
> > close() effective becomes an fsync() and a close().  I think that is
> > completely consistent with the purpose of "-o flush".
>=20
> It makes much slower above "cp -a" part. So I think it is overkill.

There doesn't seem to be any point to "-o flush" if it doesn't promise
anything.  Without the blkdeV_issue_flush() we have no guarantee that
the data is safe after the file is closed - do we?
Certainly it will be slower than without "-o flush", but that is the
price you pay for safety.

However, if you are adamant then let's just put in a timeout.
Patch to follow.

Thanks,
NeilBrown
