Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6388C4F0EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358322AbiDDFOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiDDFOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:14:37 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFE381AA;
        Sun,  3 Apr 2022 22:12:41 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2345CHiA029025;
        Mon, 4 Apr 2022 14:12:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Mon, 04 Apr 2022 14:12:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2345CGDP029017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Apr 2022 14:12:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <67179a84-8be7-4c93-e355-2ca50666f960@I-love.SAKURA.ne.jp>
Date:   Mon, 4 Apr 2022 14:12:14 +0900
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Ykp63pk7aSj/bNRT@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/04 13:58, Christoph Hellwig wrote:
> On Sat, Apr 02, 2022 at 08:26:23PM +0900, Tetsuo Handa wrote:
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=168d578db00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=4f1a237abaf14719db49
>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> This is a known problem, and Christoph does not like a mitigation patch.
>> https://lkml.kernel.org/r/YgoQBTzb3b0l1SzP@infradead.org
> 
> And this report shows why: your patch makes the lock acquisition in
> blkdev_fallocate killable.  Which would not help with this problem at
> all, as it does not come through blkdev_fallocate.

My patch proposes filemap_invalidate_lock_killable() and converts only
blkdev_fallocate() case as a starting point. Nothing prevents us from
converting e.g. blk_ioctl_zeroout() case as well. The "not come through
blkdev_fallocate" is bogus.

>                                                     The problem is that
> the loop writing actual zeroes to the disk can take forever, and we
> hold the invalidate_lock over that.

There can be several locations which cannot be converted to
filemap_invalidate_lock_killable() (like we had to use mutex_lock(&lo->lo_mutex)
for lo_release() case). But many locations can be converted to
filemap_invalidate_lock_killable() (like we use mutex_lock_killable(&lo->lo_mutex)
for almost all locations).

Being responsive to SIGKILL is good (even if we cannot afford making all locks
killable). I made many locations killable. Therefore, I wonder why not?

