Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D77C494689
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358465AbiATEnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:43:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:59148 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiATEnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:43:09 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id A3E6F15F939;
        Thu, 20 Jan 2022 13:43:08 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 20K4h7uu116242
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 13:43:08 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 20K4h7jJ493217
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 13:43:07 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 20K4h6L8493216;
        Thu, 20 Jan 2022 13:43:06 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] block: Fix wrong offset in bio_truncate()
References: <000000000000880fca05d4fc73b0@google.com>
        <875yqt1c9g.fsf@mail.parknet.co.jp> <YdvngICmbNXOFIIj@T590>
Date:   Thu, 20 Jan 2022 13:43:05 +0900
In-Reply-To: <YdvngICmbNXOFIIj@T590> (Ming Lei's message of "Mon, 10 Jan 2022
        16:00:00 +0800")
Message-ID: <87pmonqap2.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> On Sun, Jan 09, 2022 at 06:36:43PM +0900, OGAWA Hirofumi wrote:
>> bio_truncate() clears the buffer outside of last block of bdev, however
>> current bio_truncate() is using the wrong offset of page. So it can
>> return the uninitialized data.
>> 
>> This happened when both of truncated/corrupted FS and userspace (via
>> bdev) are trying to read the last of bdev.
>> 
>> Reported-by: syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> ---
>>  block/bio.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/block/bio.c b/block/bio.c
>> index a6fb6a0..25f1ed2 100644
>> --- a/block/bio.c	2021-11-01 09:19:05.999472589 +0900
>> +++ b/block/bio.c	2022-01-09 17:40:09.010438012 +0900
>> @@ -567,7 +567,8 @@ void bio_truncate(struct bio *bio, unsig
>>  				offset = new_size - done;
>>  			else
>>  				offset = 0;
>> -			zero_user(bv.bv_page, offset, bv.bv_len - offset);
>> +			zero_user(bv.bv_page, bv.bv_offset + offset,
>> +				  bv.bv_len - offset);
>
> Looks correct:
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

ping?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
