Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6662C4892F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiAJICi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242080AbiAJIAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641801646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8uXDg0+yQDdSb7ulPXiELnZGHaVMyBnuD++p+AMB1M=;
        b=EDCFDcyKymGhdjXVMe0VKvz8N4MGdnswG6Gw5PmH2d89UlAflWEJwskjPh3aYOXdQWoXkF
        Jz5C1pRZvYHaR7pXUG/8dOtUZ0BTFGbr2xg2EFR8Bwp9f6f7lCDmOX+nhKAgDDqBHMOK5x
        2ZnrVwOvIN4bcO5oScgLelVSSozKtmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-xrlnaNm0PIyI_mpyPYD6fQ-1; Mon, 10 Jan 2022 03:00:42 -0500
X-MC-Unique: xrlnaNm0PIyI_mpyPYD6fQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C92498042F6;
        Mon, 10 Jan 2022 08:00:39 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3484C5F939;
        Mon, 10 Jan 2022 08:00:06 +0000 (UTC)
Date:   Mon, 10 Jan 2022 16:00:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] block: Fix wrong offset in bio_truncate()
Message-ID: <YdvngICmbNXOFIIj@T590>
References: <000000000000880fca05d4fc73b0@google.com>
 <875yqt1c9g.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yqt1c9g.fsf@mail.parknet.co.jp>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 06:36:43PM +0900, OGAWA Hirofumi wrote:
> bio_truncate() clears the buffer outside of last block of bdev, however
> current bio_truncate() is using the wrong offset of page. So it can
> return the uninitialized data.
> 
> This happened when both of truncated/corrupted FS and userspace (via
> bdev) are trying to read the last of bdev.
> 
> Reported-by: syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
>  block/bio.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a6fb6a0..25f1ed2 100644
> --- a/block/bio.c	2021-11-01 09:19:05.999472589 +0900
> +++ b/block/bio.c	2022-01-09 17:40:09.010438012 +0900
> @@ -567,7 +567,8 @@ void bio_truncate(struct bio *bio, unsig
>  				offset = new_size - done;
>  			else
>  				offset = 0;
> -			zero_user(bv.bv_page, offset, bv.bv_len - offset);
> +			zero_user(bv.bv_page, bv.bv_offset + offset,
> +				  bv.bv_len - offset);

Looks correct:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

