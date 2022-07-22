Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93F957E493
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiGVQlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiGVQlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:41:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4F32048
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9SLaDrK5tRcSR7Loc6X3TUEFVyae8NMhj0dJu7y1PB8=; b=rbMjdKZFn2TfSM7eZbFp5WUAeb
        ERtNUKiK40IFpqA04fz2tZJ0yFt6Eo++0oYQBI4s5F4ZHiVr/oS2xlxlPsC39sAZB7ARQsPt7dOmT
        uWJcGl8cV+xS5MknYhvd2C6fp0gu0IejlOIlHZbZPhwbe9HW7IeDlVifbOInoca6JqnJ9AguLhDZ3
        vL7qgnnh/m0uQ67ZZ64pp8J0l2U7WqQxcWXLV0QIfCaC2GS+DUTpCEIrNIDaHNwUQNlminnMZC344
        /YdaITUaWyhsod26DHyKQ3kO2us1UM+ZiUC6+9w68OaRydutYz20WfpV2n3hfaNX7zrx0q+XKfv5m
        ZTL+nfUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEvi7-007zu1-3e; Fri, 22 Jul 2022 16:41:07 +0000
Date:   Fri, 22 Jul 2022 09:41:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/3] dm-verity: optionally use tasklets in dm-verity
Message-ID: <YtrTI/CJMoLihA/1@infradead.org>
References: <20220722093823.4158756-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722093823.4158756-1-nhuck@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been tying to kill off task lets for about 15 years.  I don't
think adding new users will make you a whole lot of friends..

On Fri, Jul 22, 2022 at 09:38:20AM +0000, Nathan Huckleberry wrote:
> Using tasklets for disk verification can reduce IO latency.  When there are
> accelerated hash instructions it is often better to compute the hash immediately
> using a tasklet rather than deferring verification to a work-queue.  This
> reduces time spent waiting to schedule work-queue jobs, but requires spending
> slightly more time in interrupt context.
> 
> A tasklet can only be used for verification if all the required hashes are
> already in the dm-bufio cache.  If verification cannot be done in a tasklet, we
> fallback the existing work-queue implementation.
> 
> To allow tasklets to query the dm-bufio cache, the dm-bufio code must not sleep.
> This patchset adds a flag to dm-bufio that disallows sleeping.
> 
> The following shows a speed comparison of random reads on a dm-verity device.
> The dm-verity device uses a 1G ramdisk for data and a 1G ramdisk for hashes.
> One test was run using tasklets and one test was run using the existing
> work-queue solution.  Both tests were run when the dm-bufio cache was hot.  The
> tasklet implementation performs significantly better since there is no time
> waiting for work-queue jobs to be scheduled.
> 
> # /data/fio /data/tasklet.fio | grep READ
>    READ: bw=181MiB/s (190MB/s), 181MiB/s-181MiB/s (190MB/s-190MB/s), io=512MiB
>    (537MB), run=2827-2827msec
> # /data/fio /data/workqueue.fio | grep READ
>    READ: bw=23.6MiB/s (24.8MB/s), 23.6MiB/s-23.6MiB/s (24.8MB/s-24.8MB/s),
>    io=512MiB (537MB), run=21688-21688msec
> 
> Nathan Huckleberry (3):
>   dm-bufio: Add flags for dm_bufio_client_create
>   dm-bufio: Add DM_BUFIO_GET_CANT_SLEEP
>   dm-verity: Add try_verify_in_tasklet
> 
>  drivers/md/dm-bufio.c                         | 29 +++++--
>  drivers/md/dm-ebs-target.c                    |  3 +-
>  drivers/md/dm-integrity.c                     |  2 +-
>  drivers/md/dm-snap-persistent.c               |  2 +-
>  drivers/md/dm-verity-fec.c                    |  4 +-
>  drivers/md/dm-verity-target.c                 | 87 ++++++++++++++++---
>  drivers/md/dm-verity.h                        |  5 ++
>  drivers/md/persistent-data/dm-block-manager.c |  3 +-
>  include/linux/dm-bufio.h                      |  8 +-
>  9 files changed, 119 insertions(+), 24 deletions(-)
> 
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
---end quoted text---
