Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC255735DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiGML4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiGML4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:56:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD3D1034ED;
        Wed, 13 Jul 2022 04:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zQ/ZVt480ezifkPZehDb75C3ZE/sBmWOTZFlFXYsE1Q=; b=ehNWRgt/QUVkgcdcEueXaNh5X5
        b0rF/ru4ecjZqewzB3D//ugVio7xMFxxD2ARzI+iylV7AZQ77/rSF0y2sR75VVXvJC8gU5pqiU6NU
        RIJWAG3JqxKobfpeRmjG8WiRmFgTkDkqNZPRirB0LuXdgXKRx/4nB7hwgPRy9St6y1VNonDALgPen
        sRxfFRnW1BanpKFXs7Z9Xl01+kdjtfkJbTkcEgGj8hpmrgPzIFQJuTBKreo+znzVjApfClqENNxEB
        BMdt0/Glc8z+jRz3h84C581a15d1J+NynoFNldmk8REnOwkHEtL/GXwauvNnh1KQ8S/nEmONyskrI
        1OJFxAgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBayK-003JZA-Ey; Wed, 13 Jul 2022 11:56:04 +0000
Date:   Wed, 13 Jul 2022 04:56:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Message-ID: <Ys6y1AYTl8r/i3UX@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
 <YsWHHcCfSVFklh4M@infradead.org>
 <ff78a1ee-8bc5-6e8e-040f-978cd07eacfe@veeam.com>
 <YscXTGXumE5Ust15@infradead.org>
 <aec88137-070e-7c1d-215f-86a1e6d4b10a@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec88137-070e-7c1d-215f-86a1e6d4b10a@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 12:45:33PM +0200, Sergei Shtepa wrote:
> 1. Work at the partition or disk level?
> At the user level, programs operate with block devices.
> In fact, the "disk" entity makes sense only for the kernel level. 
> When the user chooses which block devices to backup and which not,
> he operates with mounting points, which are converted into block
> devices, partitions. Therefore, it is better to handle bio before
> remapping to disk.
> If the filtering is performed after remapping, then we will be
> forced to apply a filter to the entire disk, or complicate the
> filtering algorithm by calculating which range of sectors bio is
> addressed to. And if bio is addressed to the partition boundary...
> Filtering at the block device level seems to me a simpler solution.
> But this is not the biggest problem.

Note that bi_bdev stays for the partition things came from.  So we
could still do filtering after blk_partition_remap has been called,
the filter driver just needs to be careful on how to interpret the
sector numbers.

> 2. Can the filter sleep or postpone bio processing to the worker thread?

I think all of te above is fine, just for normal submit_bio based
drivers.

> The problem is in the implementation of the COW algorithm.
> If I send a bio to read a chunk (one bio), and then pass a write bio,
> then with some probability I am reading partially overwritten data.
> Writing overtakes reading. And flags REQ_SYNC and REQ_PREFLUSH don't help.
> Maybe it's a disk driver issue, or a hypervisor, or a NAS, or a RAID,
> or maybe normal behavior. I don't know. Although, maybe I'm not working
> correctly with flags. I have seen the comments on patch 11/20, but I am
> not sure that the fixes will solve this problem.
> But because of this, I have to postpone the write until the read completes.

In the I/O stack there really isn't any ordering.  While a general
reordering looks a bit odd to be, it absolutely it always possible.

> 2.1 The easiest way to solve the problem is to block the writer's thread
> with a semaphore. And for bio with a flag REQ_NOWAIT, complete processing
> with bio_wouldblock_error(). This is the solution currently being used.

This sounds ok.  The other option would be to put the write on hold and
only queue it up from the read completion (or rather a workqueue kicked
off from the read completion).  But this is basically the same, just
without blocking the I/O submitter, so we could do the semaphore first
and optimize later as needed.

> If I am blocked by the q->q_usage_counter counter, then I will not
> be able to execute COW in the context of the current thread due to deadlocks.
> I will have to use a scheme with an additional worker thread.
> Bio filtering will become much more complicated.

q_usage_counter itself doesn't really block you from doing anything.
You can still sleep inside of it, and most driver do that.
