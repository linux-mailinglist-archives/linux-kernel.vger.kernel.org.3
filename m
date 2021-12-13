Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484D2471F68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhLMCph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:45:37 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:54060 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhLMCpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:45:36 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 69DD314CD00;
        Mon, 13 Dec 2021 11:45:33 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1BD2jVeL114862
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 11:45:32 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1BD2jVZB651649
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 11:45:31 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 1BD2jVvQ651648;
        Mon, 13 Dec 2021 11:45:31 +0900
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
        <87h7bfmtqc.fsf@mail.parknet.co.jp>
        <163936252397.22433.9103044991910658320@noble.neil.brown.name>
Date:   Mon, 13 Dec 2021 11:45:31 +0900
In-Reply-To: <163936252397.22433.9103044991910658320@noble.neil.brown.name>
        (NeilBrown's message of "Mon, 13 Dec 2021 13:28:43 +1100")
Message-ID: <875yrtql2s.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"NeilBrown" <neilb@suse.de> writes:

> On Sat, 11 Dec 2021, OGAWA Hirofumi wrote:
>> "NeilBrown" <neilb@suse.de> writes:
>> 
>> > congestion_wait() in this context is just a sleep - block devices do not
>> > in general support congestion signalling any more.
>> >
>> > The goal here is to wait for any recently written data to get to
>> > storage.  blkdev_issue_flush() is thought to be too expensive, so
>> > replace congestion_wait() with an explicit timeout.
>> 
>> If just replace, the following looks better
>> 
>> 	set_current_state(TASK_UNINTERRUPTIBLE);
>> 	io_schedule_timeout(HZ/10);
>> 
>> Otherwise,
>> 
>> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Thanks.
> According to MAINTAINERS, I should send patches for this code to you,
> with the implication (I assumed) that you would forwarded them upstream
> if acceptable.
> But the fact that you have send mt an Acked-By seems to suggest that you
> won't be doing that.
> To whom should I send this patch with your acked-by?

Ah, sorry. I have no repository. So FAT patches goes to linus tree via
akpm's help.

So "Cc: Andrew Morton <akpm@linux-foundation.org>" and my Acked-by
should work (or I will Cc as reply if need).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
