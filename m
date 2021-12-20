Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8CF47A924
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhLTL60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:58:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53966 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLTL6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:58:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41FF321116;
        Mon, 20 Dec 2021 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640001504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lyu92K3KNUQI+miSQ0I6NCto7SdzSqFDwh12c/n/tyA=;
        b=JvGdUX+E8HT3To2fRqgrKwt3CPvrj5pR4S7g4TQ4sCsK27gzgZHGyfPYBAh8bKhpvBjrsd
        Yk1zF+vA2IibW3X5kFzHFKwGVKlW+TyurchWpoZqyDOxN7TeEMvtsb9ah4EvP7rNwms9QX
        zEce2u13vqAjfGKS8rdSXp17W7uZLy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640001504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lyu92K3KNUQI+miSQ0I6NCto7SdzSqFDwh12c/n/tyA=;
        b=wd81YJ/ZaqTiPx57/r/zITbr8MA250oIhRsRTj50znOJ+06QuVtJc7zjc//YbrszfNUKLc
        /4KvWXupviVQAxBg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 07ED7A3B89;
        Mon, 20 Dec 2021 11:58:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 93E841E1649; Mon, 20 Dec 2021 12:58:23 +0100 (CET)
Date:   Mon, 20 Dec 2021 12:58:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [loop] 322c4293ec: xfstests.xfs.049.fail
Message-ID: <20211220115823.GB20005@quack2.suse.cz>
References: <20211219150933.GJ14057@xsang-OptiPlex-9020>
 <dd707dfd-6421-b1df-4820-e30787b84181@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd707dfd-6421-b1df-4820-e30787b84181@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-12-21 00:45:46, Tetsuo Handa wrote:
> On 2021/12/20 0:09, kernel test robot wrote:
> >     @@ -13,3 +13,5 @@
> >      --- clean
> >      --- umount ext2 on xfs
> >      --- umount xfs
> >     +!!! umount xfs failed
> >     +(see /lkp/benchmarks/xfstests/results//xfs/049.full for details)
> >     ...
> >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/049.out /lkp/benchmarks/xfstests/results//xfs/049.out.bad'  to see the entire diff)
> 
> Yes, we know this race condition can happen.
> 
> https://lkml.kernel.org/r/16c7d304-60ef-103f-1b2c-8592b48f47c6@i-love.sakura.ne.jp
> https://lkml.kernel.org/r/YaYfu0H2k0PSQL6W@infradead.org
> 
> Should we try to wait for autoclear operation to complete?

So I think we should try to fix this because as Dave writes in the
changelog for a1ecac3b0656 ("loop: Make explicit loop device destruction
lazy") which started all this, having random EBUSY failures (either from
losetup or umount) is annoying and you need to work it around it lots of
unexpected places.

We cannot easily wait for work completion in the loop device code without
reintroducing the deadlock - whole lo_release() is called under
disk->open_mutex which you also need to grab in __loop_clr_fd(). So to
avoid holding backing file busy longer than expected, we could use
task_work instead of ordinary work as I suggested - but you were right that
we need to be somewhat careful and in case we are running in a kthread, we
would still need to offload to a normal work (but in that case we don't
care about delaying file release anyway).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
