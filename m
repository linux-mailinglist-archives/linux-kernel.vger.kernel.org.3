Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE55AFD4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIGHWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiIGHWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:22:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81290C5E;
        Wed,  7 Sep 2022 00:22:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 698B76732D; Wed,  7 Sep 2022 09:22:31 +0200 (CEST)
Date:   Wed, 7 Sep 2022 09:22:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dusty Mabe <dusty@dustymabe.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <20220907072231.GA23826@lst.de>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just curious:  what is the underlying device (or more speicifically
driver) under the md raids?

On Fri, Aug 26, 2022 at 12:15:22PM -0400, Dusty Mabe wrote:
> Hey All,
> 
> I think I've found a regression introduced by:
> 
> a09b314 o block: freeze the queue earlier in del_gendisk
> 
> In Fedora CoreOS we have tests that set up RAID1 on the /boot/ and /root/ partitions
> and then subsequently removes one of the disks to simulate a failure. Sometime recently
> this test started timing out occasionally. Looking a bit closer it appears instances are
> getting stuck during reboot with a bunch of looping messages:
> 
> ```
> [   17.978854] block device autoloading is deprecated and will be removed.
> [   17.982555] block device autoloading is deprecated and will be removed.
> [   17.985537] block device autoloading is deprecated and will be removed.
> [   17.987546] block device autoloading is deprecated and will be removed.
> [   17.989540] block device autoloading is deprecated and will be removed.
> [   17.991547] block device autoloading is deprecated and will be removed.
> [   17.993555] block device autoloading is deprecated and will be removed.
> [   17.995539] block device autoloading is deprecated and will be removed.
> [   17.997577] block device autoloading is deprecated and will be removed.
> [   17.999544] block device autoloading is deprecated and will be removed.
> [   22.979465] blkdev_get_no_open: 1666 callbacks suppressed
> ...
> ...
> ...
> [  618.221270] blkdev_get_no_open: 1664 callbacks suppressed
> [  618.221273] block device autoloading is deprecated and will be removed.
> [  618.224274] block device autoloading is deprecated and will be removed.
> [  618.227267] block device autoloading is deprecated and will be removed.
> [  618.229274] block device autoloading is deprecated and will be removed.
> [  618.231277] block device autoloading is deprecated and will be removed.
> [  618.233277] block device autoloading is deprecated and will be removed.
> [  618.235282] block device autoloading is deprecated and will be removed.
> [  618.237370] block device autoloading is deprecated and will be removed.
> [  618.239356] block device autoloading is deprecated and will be removed.
> [  618.241290] block device autoloading is deprecated and will be removed.
> ```
> 
> Using the Fedora kernels I narrowed it down to being introduced between 
> `kernel-5.19.0-0.rc3.27.fc37` (good) and `kernel-5.19.0-0.rc4.33.fc37` (bad).
> 
> I then did a bisect and found:
> 
> ```
> $ git bisect bad
> a09b314005f3a0956ebf56e01b3b80339df577cc is the first bad commit
> commit a09b314005f3a0956ebf56e01b3b80339df577cc
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Jun 14 09:48:27 2022 +0200
> 
>     block: freeze the queue earlier in del_gendisk
>     
>     Freeze the queue earlier in del_gendisk so that the state does not
>     change while we remove debugfs and sysfs files.
>     
>     Ming mentioned that being able to observer request in debugfs might
>     be useful while the queue is being frozen in del_gendisk, which is
>     made possible by this change.
>     
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Link: https://lore.kernel.org/r/20220614074827.458955-5-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
>  block/genhd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> ```
> 
> Reverting this commit on top of latest git master (4c612826b) gave me successful results.
> 
> Any ideas on what could be amiss here? Luckily the patch is tiny so hopefully it might
> be obvious.
> 
> More details (including logs) in the following locations:
> 
> - https://bugzilla.redhat.com/show_bug.cgi?id=2121791
> - https://github.com/coreos/fedora-coreos-tracker/issues/1282
> 
> 
> Thanks!
> Dusty
---end quoted text---
