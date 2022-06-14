Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7354AD08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiFNJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiFNJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:12:46 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437532CE14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:12:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VGMmk6n_1655197957;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VGMmk6n_1655197957)
          by smtp.aliyun-inc.com;
          Tue, 14 Jun 2022 17:12:39 +0800
Date:   Tue, 14 Jun 2022 17:12:37 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>,
        Nathan Huckleberry <nhuck@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle decompress only post processing
 in softirq
Message-ID: <YqhRBZMYPp/kyxoe@B-P7TQMD6M-0146.local>
References: <20220613155612.402297-1-daeho43@gmail.com>
 <Yqge0XS7jbSnNWvq@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yqge0XS7jbSnNWvq@sol.localdomain>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Jun 13, 2022 at 10:38:25PM -0700, Eric Biggers wrote:
> [+Cc Nathan Huckleberry who is looking into a similar problem in dm-verity]
> 
> On Mon, Jun 13, 2022 at 08:56:12AM -0700, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > Now decompression is being handled in workqueue and it makes read I/O
> > latency non-deterministic, because of the non-deterministic scheduling
> > nature of workqueues. So, I made it handled in softirq context only if
> > possible.
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>

...

> 
> One question: is this (the bio endio callback) actually guaranteed to be
> executed from a softirq?  If you look at dm-crypt's support for workqueue-less
> decryption, for example, it explicitly checks 'in_hardirq() || irqs_disabled()'
> and schedules a tasklet if either of those is the case.
> 
> - Eric
> 

Some my own previous thoughts about this strategy:

 - If we allocate all memory and map these before I/Os, all inflight I/Os
   will keep such temporary pages all the time until decompression is
   finished. In contrast, if we allocate or reuse such pages just before
   decompression, it would minimize the memory footprints.

   I think it will impact the memory numbers at least on the very
   low-ended devices with bslow storage. (I've seen f2fs has some big
   mempool already)

 - Many compression algorithms are not suitable in the softirq contexts,
   also I vaguely remembered if softirq context lasts for > 2ms, it will
   push into ksoftirqd instead so it's actually another process context.
   And it may delay other important interrupt handling.

 - Go back to the non-deterministic scheduling of workqueues. I guess it
   may be just due to scheduling punishment due to a lot of CPU consuming
   due to decompression before so the priority becomes low, but that is
   just a pure guess. May be we need to use RT scheduling policy instead.

   At least with WQ_HIGHPRI for dm-verity at least, but I don't find
   WQ_HIGHPRI mark for dm-verity.

Thanks,
Gao Xiang
