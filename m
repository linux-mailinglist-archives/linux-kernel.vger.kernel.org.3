Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7E46F9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhLJE0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:26:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54572 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbhLJE03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:26:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DB65210EC;
        Fri, 10 Dec 2021 04:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639110174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05F1XNqYCPJh3EiL4B2RX1wiUBf2ZN/JkZnZQ0ZnDro=;
        b=G37VrAZcAqCcQbzrxziS1LCnKkw59bqdkqojPCgjX6cRL22Ot3vg2VqwvKlsALU/BAOeBM
        0iFRGP82dRiaSxwuFJWTVNQ8rE2Rpl4JuffWtolomkDTTgKoEvC6iU/i4/HH4+YH9Q0XPs
        1D7LKNArI1knDPUrgHSK86Ixrx1Uj7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639110174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05F1XNqYCPJh3EiL4B2RX1wiUBf2ZN/JkZnZQ0ZnDro=;
        b=FHoQ7jTcDsRaq9e2bjgHZHi30Ia0Xwt8LdBeNQVrrenQDiFBIntP0JknO2/936A/42fdhz
        PtzMq4NsqUL9emCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C94F313DC8;
        Fri, 10 Dec 2021 04:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yko5IRzWsmF5SwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 10 Dec 2021 04:22:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "Christoph Hellwig" <hch@infradead.org>
Subject: [PATCH v2] FAT: use schedule_timeout_uninterruptible() instead of
 congestion_wait()
In-reply-to: <163911011670.9928.6438117555175130033@noble.neil.brown.name>
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>,
 <87ee79yiik.fsf@mail.parknet.co.jp>,
 <163754226639.13692.10449616189734943162@noble.neil.brown.name>,
 <874k84hi5q.fsf@mail.parknet.co.jp>,
 <163911011670.9928.6438117555175130033@noble.neil.brown.name>
Date:   Fri, 10 Dec 2021 15:22:49 +1100
Message-id: <163911016975.9928.6568675782275129@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


congestion_wait() in this context is just a sleep - block devices do not
in general support congestion signalling any more.

The goal here is to wait for any recently written data to get to
storage.  blkdev_issue_flush() is thought to be too expensive, so
replace congestion_wait() with an explicit timeout.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fat/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 13855ba49cd9..2321fb3eded5 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -175,9 +175,9 @@ long fat_generic_ioctl(struct file *filp, unsigned int cm=
d, unsigned long arg)
 static int fat_file_release(struct inode *inode, struct file *filp)
 {
 	if ((filp->f_mode & FMODE_WRITE) &&
-	     MSDOS_SB(inode->i_sb)->options.flush) {
+	    MSDOS_SB(inode->i_sb)->options.flush) {
 		fat_flush_inodes(inode->i_sb, inode, NULL);
-		congestion_wait(BLK_RW_ASYNC, HZ/10);
+		schedule_timeout_uninterruptible(HZ/10);
 	}
 	return 0;
 }
--=20
2.34.1

