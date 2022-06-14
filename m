Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D57B54B742
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244764AbiFNRCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344573AbiFNRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:01:49 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2337C4991C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:00:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VGOFTul_1655226047;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VGOFTul_1655226047)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 01:00:49 +0800
Date:   Wed, 15 Jun 2022 01:00:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Daeho Jeong <daehojeong@google.com>,
        Nathan Huckleberry <nhuck@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle decompress only post processing
 in softirq
Message-ID: <Yqi+vyY4K0mzEdeP@B-P7TQMD6M-0146.local>
References: <20220613155612.402297-1-daeho43@gmail.com>
 <Yqge0XS7jbSnNWvq@sol.localdomain>
 <YqhRBZMYPp/kyxoe@B-P7TQMD6M-0146.local>
 <CACOAw_wjCyTmwusY6S4+NgMuLOZm9fwGfrvCT272GJ01-RP6PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACOAw_wjCyTmwusY6S4+NgMuLOZm9fwGfrvCT272GJ01-RP6PQ@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daeho,

On Tue, Jun 14, 2022 at 09:46:50AM -0700, Daeho Jeong wrote:
> >
> > Some my own previous thoughts about this strategy:
> >
> >  - If we allocate all memory and map these before I/Os, all inflight I/Os
> >    will keep such temporary pages all the time until decompression is
> >    finished. In contrast, if we allocate or reuse such pages just before
> >    decompression, it would minimize the memory footprints.
> >
> >    I think it will impact the memory numbers at least on the very
> >    low-ended devices with bslow storage. (I've seen f2fs has some big
> >    mempool already)
> >
> >  - Many compression algorithms are not suitable in the softirq contexts,
> >    also I vaguely remembered if softirq context lasts for > 2ms, it will
> >    push into ksoftirqd instead so it's actually another process context.
> >    And it may delay other important interrupt handling.
> >
> >  - Go back to the non-deterministic scheduling of workqueues. I guess it
> >    may be just due to scheduling punishment due to a lot of CPU consuming
> >    due to decompression before so the priority becomes low, but that is
> >    just a pure guess. May be we need to use RT scheduling policy instead.
> >
> >    At least with WQ_HIGHPRI for dm-verity at least, but I don't find
> >    WQ_HIGHPRI mark for dm-verity.
> >
> > Thanks,
> > Gao Xiang
> 
> I totally understand what you are worried about. However, in the real
> world, non-determinism from workqueues is more harsh than we expected.
> As you know, reading I/Os in the system are critical paths most of the
> time and now I/O variations with workqueue are too bad.
> 
> I also think it's better that we have RT scheduling like things here.
> We could think about it more.

Yeah, I heard that you folks are really suffered from the scheduling
issues. But for my own previous experience, extra memory footprints are
really critical in Android low memory scenarios (no matter low-ended
devices or artificial workloads), it tossed me a lot. So I finally 
ntroduced many inplace I/O to handle/minimize that, including inplace
I/O for compressed pages and temporary pages.

But I'm not quite sure what's currently happening now, since we once
didn't have such non-deterministic workqueues, and I don't hear from
other landed vendors.  I think it'd be better to analyse what's going
on for these kworkers from scheduling POV and why they don't schedule
in time.

I also have an idea is much like what I'm doing now for sync
decompression, is that just before lock page and ->read_folio, we can
trigger some decompression in addition to kworker decompression, but it
needs some MM modification, as below:

   !PageUptodate(page)

   some callback to decompress in addition to kworker

   lock_page()
   ->read_folio()

If mm folks don't like it, I think RT thread is also fine after we
analysed the root cause of the kworker delay I think.

Thanks,
Gao Xiang

> 
> Thanks,
