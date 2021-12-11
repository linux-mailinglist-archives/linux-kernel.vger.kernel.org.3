Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD054712E1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhLKI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:27:43 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:53916 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhLKI1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:27:42 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 10B3C14CD00;
        Sat, 11 Dec 2021 17:27:41 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1BB8RdEC071566
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 17:27:40 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1BB8RdpO372257
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 17:27:39 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 1BB8RdVZ372256;
        Sat, 11 Dec 2021 17:27:39 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     "NeilBrown" <neilb@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH v2] FAT: use schedule_timeout_uninterruptible() instead
 of congestion_wait()
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
        <87ee79yiik.fsf@mail.parknet.co.jp>
        <163754226639.13692.10449616189734943162@noble.neil.brown.name>
        <874k84hi5q.fsf@mail.parknet.co.jp>
        <163911011670.9928.6438117555175130033@noble.neil.brown.name>
        <163911016975.9928.6568675782275129@noble.neil.brown.name>
Date:   Sat, 11 Dec 2021 17:27:39 +0900
In-Reply-To: <163911016975.9928.6568675782275129@noble.neil.brown.name>
        (NeilBrown's message of "Fri, 10 Dec 2021 15:22:49 +1100")
Message-ID: <87h7bfmtqc.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"NeilBrown" <neilb@suse.de> writes:

> congestion_wait() in this context is just a sleep - block devices do not
> in general support congestion signalling any more.
>
> The goal here is to wait for any recently written data to get to
> storage.  blkdev_issue_flush() is thought to be too expensive, so
> replace congestion_wait() with an explicit timeout.

If just replace, the following looks better

	set_current_state(TASK_UNINTERRUPTIBLE);
	io_schedule_timeout(HZ/10);

Otherwise,

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/fat/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 13855ba49cd9..2321fb3eded5 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -175,9 +175,9 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  static int fat_file_release(struct inode *inode, struct file *filp)
>  {
>  	if ((filp->f_mode & FMODE_WRITE) &&
> -	     MSDOS_SB(inode->i_sb)->options.flush) {
> +	    MSDOS_SB(inode->i_sb)->options.flush) {
>  		fat_flush_inodes(inode->i_sb, inode, NULL);
> -		congestion_wait(BLK_RW_ASYNC, HZ/10);
> +		schedule_timeout_uninterruptible(HZ/10);
>  	}
>  	return 0;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
