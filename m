Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2954B857
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbiFNSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352365AbiFNSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:10:47 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A314927E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:10:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VGONEUp_1655230234;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VGONEUp_1655230234)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 02:10:36 +0800
Date:   Wed, 15 Jun 2022 02:10:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Daeho Jeong <daehojeong@google.com>,
        Nathan Huckleberry <nhuck@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle decompress only post processing
 in softirq
Message-ID: <YqjPGpZTUjH4IfZT@B-P7TQMD6M-0146.local>
References: <20220613155612.402297-1-daeho43@gmail.com>
 <Yqge0XS7jbSnNWvq@sol.localdomain>
 <YqhRBZMYPp/kyxoe@B-P7TQMD6M-0146.local>
 <CACOAw_wjCyTmwusY6S4+NgMuLOZm9fwGfrvCT272GJ01-RP6PQ@mail.gmail.com>
 <Yqi+vyY4K0mzEdeP@B-P7TQMD6M-0146.local>
 <CACOAw_xw3jN2KQaiG7AgCttaQr+uqJme=rsj8AT9wdsGWj3iVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACOAw_xw3jN2KQaiG7AgCttaQr+uqJme=rsj8AT9wdsGWj3iVQ@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:49:37AM -0700, Daeho Jeong wrote:
> > Yeah, I heard that you folks are really suffered from the scheduling
> > issues. But for my own previous experience, extra memory footprints are
> > really critical in Android low memory scenarios (no matter low-ended
> > devices or artificial workloads), it tossed me a lot. So I finally
> > ntroduced many inplace I/O to handle/minimize that, including inplace
> > I/O for compressed pages and temporary pages.
> >
> > But I'm not quite sure what's currently happening now, since we once
> > didn't have such non-deterministic workqueues, and I don't hear from
> > other landed vendors.  I think it'd be better to analyse what's going
> > on for these kworkers from scheduling POV and why they don't schedule
> > in time.
> >
> > I also have an idea is much like what I'm doing now for sync
> > decompression, is that just before lock page and ->read_folio, we can
> > trigger some decompression in addition to kworker decompression, but it
> > needs some MM modification, as below:
> >
> >    !PageUptodate(page)
> >
> >    some callback to decompress in addition to kworker
> >
> >    lock_page()
> >    ->read_folio()
> >
> > If mm folks don't like it, I think RT thread is also fine after we
> > analysed the root cause of the kworker delay I think.
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > Thanks,
> 
> I don't think this is not a problem with most devices, since the
> allocated memory is not too big and it'll be kept just as long as I/O
> processing is on. However, I still understand what you're worried
> about, so I think I can make a new mount option like "memory=low",
> which can be used to give a hint to F2FS to have a priority on as
> little memory as possible. In this mode, we will try to keep minimal
> memory and we can use the previous implementation for decompression.

Okay, one of our previous tests was that how many applications are
still there after many other applications boot. That makes sense since
most users need to leave as many apps as possible, I know for now we
have swap-like thing, but once it was done without swap. If you reserve
too much memory (with page mempool or even for inflight I/O), it will
impact the alive app numbers compared to uncompressed cases for all
devices (even high-ended devices).

BTW, most crypto algorithms have hardware instructions to boost up,
actually we have some in-house neon lz4 assembly as well. but it still
somewhat slow than crypto algorithms, not to mention some algorithms
like zstd or lzma. Anyway, I personally prefer RT Thread way since it's
more flexible, also for dm-verity at least try with WQ_HIGHPRI, and I've
seen:
https://android-review.googlesource.com/c/kernel/common/+/204421

But I'm not sure why it wasn't upstreamed though.

Thanks,
Gao Xiang

> 
> Thanks,
