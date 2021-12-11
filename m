Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6112B4712CE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhLKIQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:16:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:53906 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLKIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:16:39 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 36EE114CD00;
        Sat, 11 Dec 2021 17:16:36 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1BB8GYcT071519
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 17:16:35 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1BB8GYVr371026
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 17:16:34 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 1BB8GY3n371025;
        Sat, 11 Dec 2021 17:16:34 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     "NeilBrown" <neilb@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] FAT: use blkdev_issue_flush() instead of congestion_wait()
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
        <87ee79yiik.fsf@mail.parknet.co.jp>
        <163754226639.13692.10449616189734943162@noble.neil.brown.name>
        <874k84hi5q.fsf@mail.parknet.co.jp>
        <163911011670.9928.6438117555175130033@noble.neil.brown.name>
Date:   Sat, 11 Dec 2021 17:16:34 +0900
In-Reply-To: <163911011670.9928.6438117555175130033@noble.neil.brown.name>
        (NeilBrown's message of "Fri, 10 Dec 2021 15:21:56 +1100")
Message-ID: <87lf0rmu8t.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"NeilBrown" <neilb@suse.de> writes:

> On Mon, 22 Nov 2021, OGAWA Hirofumi wrote:
>> "NeilBrown" <neilb@suse.de> writes:
>> 
>> Right. This was to make the removable device usage better (but sync
>> option is too slow).
>> 
>> e.g.
>>     # cp -a /foo/source /mnt/fatfs
>> 
>>     # umount <don't too slow>
>>     or
>>     <do other thing, and forget umount>
>
> or use GUI to drag a file to the removable device, wait for the copy to
> appear to finish, then pull the device.
>
> sync is too slow as it flush each change to storage as it happens.  Each
> block, each FA-Table update etc.
>
> "-o flush" does the flush as file-close rather than on each write.
> But it still needs to provide the same safety.  i.e. write and flush and
> wait.

If you want to provide the data integrity, e.g., you have to check and
sync parent recursively. And more.

>> It makes much slower above "cp -a" part. So I think it is overkill.
>
> There doesn't seem to be any point to "-o flush" if it doesn't promise
> anything.  Without the blkdeV_issue_flush() we have no guarantee that
> the data is safe after the file is closed - do we?
> Certainly it will be slower than without "-o flush", but that is the
> price you pay for safety.

What I originally think to provide here (before this patch) is,
removable media capable flusher (early flush) + some sort of auto
unmount (syncfs when fs becomes idle.). IOW, nearly maximum throughput
and better safety than default fluser. But never guarantee anything the
data integrity, otherwise this option becomes too complex and heavyweight.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
