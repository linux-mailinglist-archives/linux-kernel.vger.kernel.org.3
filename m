Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338F849B0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiAYJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:47:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39002 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiAYJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:40:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C1C881F381;
        Tue, 25 Jan 2022 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643103635;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjLef+eHR65gSrHBUwJYgL8VczDBRD6PtowiaRp8cqg=;
        b=V2hf9WhYVmPenYoQzKChrh0nsB0PQioiYNLQUrnwuWOtckSlBXL/PG4a22f0pShotdLkMh
        6aLik9Bz/6cHPeoQFJzf1mU/8y7d+p/ux+CbSjg74DX0nb1yi1DMNGvVCyW0N43Kn5tSZG
        Iw/b4UsRZwLkVzGUrno2xRJY8SXw8k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643103635;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjLef+eHR65gSrHBUwJYgL8VczDBRD6PtowiaRp8cqg=;
        b=8GlYzYvBEcCCBr+9cTRi9mfPfMAd6QoqhINOtop7egkKKZxKCbFV7bo/SCV5bEPS6bhU8P
        9R0/O75lzTPU2+Cg==
Received: from g78 (unknown [10.163.24.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 00244A3B84;
        Tue, 25 Jan 2022 09:40:34 +0000 (UTC)
References: <20210912123429.GA25450@xsang-OptiPlex-9020>
 <YT8HqsXsHFeMdDxS@yuki> <20210917121331.GA14905@quack2.suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        Miklos Szeredi <mszeredi@redhat.com>, lkp@intel.com,
        Chi Wu <wuchi.zero@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ltp@lists.linux.it
Subject: Re: [LTP] [mm/page]  ab19939a6a: ltp.msync04.fail
Date:   Tue, 25 Jan 2022 09:27:30 +0000
Reply-To: rpalethorpe@suse.de
In-reply-to: <20210917121331.GA14905@quack2.suse.cz>
Message-ID: <87o840xiel.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jan Kara <jack@suse.cz> writes:

> On Mon 13-09-21 10:11:22, Cyril Hrubis wrote:
>> Hi!
>> > FYI, we noticed the following commit (built with gcc-9):
>> > 
>> > commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> > 
>> > 
>> > in testcase: ltp
>> > version: ltp-x86_64-14c1f76-1_20210907
>> > with following parameters:
>> > 
>> > 	disk: 1HDD
>> > 	fs: xfs
>> > 	test: syscalls-03
>> > 	ucode: 0xe2
>> > 
>> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
>> > test-url: http://linux-test-project.github.io/
>> 
>> The msync04 test formats a device with a diffrent filesystems, for each
>> filesystem it maps a file, writes to the mapped page and the checks a
>> dirty bit in /proc/kpageflags before and after msync() on that page.
>> 
>> This seems to be broken after this patch for ntfs over FUSE and it looks
>> like the page does not have a dirty bit set right after it has been
>> written to.
>> 
>> Also I guess that we should increase the number of the pages we dirty or
>> attempt to retry since a single page may be flushed to the storage if we
>> are unlucky and the process is preempted between the write and the
>> initial check for the dirty bit.
>
> Yes, I agree. The most likely explanation I see for this is that the
> identified commit results in waking flush worker earlier so it may now
> succeed in cleaning the page before get_dirty_bit() in the LTP testcase
> manages to see it. This is a principial race in this testcase, you can
> perhaps make it less likely but not completely fix it AFAICT.
>
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

If the dirty bit is not set, then I guess dropping the pagecache will
not write anything to the underlying storage?

So when we see no dirty bit is set, we can drop the pagecache then read
the file to check the value was written correctly? If so then we can
exit with TCONF saying msync couldn't be tested because the storage was
written to too quickly.

Also I guess we can optimize the get_dirty_bit function. It's doing 3
syscalls instead of 1 AFAICT.

-- 
Thank you,
Richard.
