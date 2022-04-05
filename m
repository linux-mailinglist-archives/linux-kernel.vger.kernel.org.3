Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39354F4297
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447868AbiDEUJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357778AbiDEOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:37:48 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F28126FAB;
        Tue,  5 Apr 2022 06:16:08 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 235DFlkC033288;
        Tue, 5 Apr 2022 22:15:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Tue, 05 Apr 2022 22:15:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 235DFkv5033285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Apr 2022 22:15:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <286f411f-8482-6c0b-c005-01d7d20f9dbe@I-love.SAKURA.ne.jp>
Date:   Tue, 5 Apr 2022 22:15:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] INFO: task can't die in blkdev_common_ioctl
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     syzbot <syzbot+4f1a237abaf14719db49@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
References: <0000000000007a4a2d05dba6baa6@google.com>
 <d3213c1a-f82a-02f6-b5b2-0d3242e0242a@I-love.SAKURA.ne.jp>
 <Ykp63pk7aSj/bNRT@infradead.org>
 <67179a84-8be7-4c93-e355-2ca50666f960@I-love.SAKURA.ne.jp>
 <YkvlRnO3Ho/mrk0V@infradead.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YkvlRnO3Ho/mrk0V@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/05 15:44, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 02:12:14PM +0900, Tetsuo Handa wrote:
>> On 2022/04/04 13:58, Christoph Hellwig wrote:
>> My patch proposes filemap_invalidate_lock_killable() and converts only
>> blkdev_fallocate() case as a starting point. Nothing prevents us from
>> converting e.g. blk_ioctl_zeroout() case as well. The "not come through
>> blkdev_fallocate" is bogus.
> 
> Sure, we could try to convert most of the > 50 instances of
> filemap_invalidate_lock to be killable.  But that:
> 
>   a) isn't what your patch actuall did

We can step by step convert all possible locations.

>   b) doesn't solve the underlying issue that is wasn't designed to to be
>      held over very extremely long running operations

Do you want to introduce state variables like Lo_rundown in order to
avoid holding this invalidate lock? That will be a lot of complication.

> 
> Or to get back to what I said before - I don't think we can just hold
> the lock over manually zeroing potentially gigabytes of blocks.
> 

Periodically releasing this invalidate lock may result in inconsistent
output. One can issue conflicting request (e.g. enlarging a file and
truncating that file). If truncate happens while partially enlarged (or
writing non-zero values while partially zeroed), resuming will need to
undo what was done during this invalidate lock was released. (Or do you
want to make conflicting requests fail with e.g. -EBUSY, possibly breaking
userspace programs?)

Serialization via holding throughout this zeroing/fallocate operation
is needed for returning consistent output.

> In other words:  we'll need to chunk the zeroing up if we want
> to hold the invalidate lock, I see no ther way to properly fix this.

I don't think that we can chunk the zeroing/fallocate up, for
I don't think that we can determine appropriate chunk size.
It might be 4KB, it might be 1MB, it might be 1GB, but who knows which
size is safe for avoiding hung task warning on this invalidate lock.

The block device might be super slow (e.g. as slow as floppy disk, or
networking block device over very slow network). Also, hung task watchdog
timeout and concurrent requests colliding on this invalidate lock are not
visible to current thread doing actual zeroing/fallocate.

All we could afford will be to make this invalidate lock killable and
sometimes check fatal_signal_pending() inside zeroing/fallocate loop.

