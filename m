Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61D0471F89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhLMDRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:17:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLMDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:17:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAFC32114E;
        Mon, 13 Dec 2021 03:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639365449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ouwu3rIILZdyNvJCYuDu81WB3rt0CZUyp9hytfG6M4=;
        b=oFgdzjNketS5iKV6eS2mbjV5pQtJm+3g3a3WIjkFCcOhcbI0DYNKILX429SYKMy4MqY6oQ
        iSOsNwRyx+mutVpkqbmhK0c8djykMJbiAsDTWFqc5ctUKXgY4u/YubHRBSMM7Beu2Ucy4Z
        fwH2B9c5ID+ZgFAg0CllQKZq92o6/G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639365449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ouwu3rIILZdyNvJCYuDu81WB3rt0CZUyp9hytfG6M4=;
        b=nm9KnkJTyUnbQj6v6Z7o56gmW+42O6Bz50+yQKiSTxqduOfma7q3oS1TQ88fxdvSoTs2aa
        g8NLf11IfuosYGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44BFD13425;
        Mon, 13 Dec 2021 03:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N8PJAEi7tmGQMgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Dec 2021 03:17:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "Christoph Hellwig" <hch@infradead.org>
Subject: [PATCH v3] FAT: use io_schedule_timeout() instead of congestion_wait()
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
Date:   Mon, 13 Dec 2021 14:17:25 +1100
Message-id: <163936544519.22433.13400436295732112065@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


congestion_wait() in this context is just a sleep - block devices do not
support congestion signalling any more.

The goal for this wait, which was introduced in Commit ae78bf9c4f5f
("[PATCH] add -o flush for fat") is to wait for any recently written
data to get to storage.  We currently have no direct mechanism to do
this, so a simple wait that behaves identically to the current
congestion_wait() is the best we can do.

This is a step towards removing congestion_wait()

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: NeilBrown <neilb@suse.de>
---

Hi Andrew,
 I believe you are an appropriate conduit for fs/fat patches once that
 have been suitably acked.
Thanks
NeilBrown

 fs/fat/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 13855ba49cd9..a5a309fcc7fa 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -175,9 +175,10 @@ long fat_generic_ioctl(struct file *filp, unsigned int c=
md, unsigned long arg)
 static int fat_file_release(struct inode *inode, struct file *filp)
 {
 	if ((filp->f_mode & FMODE_WRITE) &&
-	     MSDOS_SB(inode->i_sb)->options.flush) {
+	    MSDOS_SB(inode->i_sb)->options.flush) {
 		fat_flush_inodes(inode->i_sb, inode, NULL);
-		congestion_wait(BLK_RW_ASYNC, HZ/10);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		io_schedule_timeout(HZ/10);
 	}
 	return 0;
 }
--=20
2.34.1

