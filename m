Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0915528D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiFUA6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiFUA6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:58:08 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA33D9FC1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:58:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VH-cNEa_1655773082;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VH-cNEa_1655773082)
          by smtp.aliyun-inc.com;
          Tue, 21 Jun 2022 08:58:03 +0800
Date:   Tue, 21 Jun 2022 08:58:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: handle decompress only post
 processing in softirq
Message-ID: <YrEXmiRH+DcbW2EI@B-P7TQMD6M-0146.local>
References: <20220620173843.1462198-1-daeho43@gmail.com>
 <20220620173843.1462198-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220620173843.1462198-2-daeho43@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:38:43AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now decompression is being handled in workqueue and it makes read I/O
> latency non-deterministic, because of the non-deterministic scheduling
> nature of workqueues. So, I made it handled in softirq context only if
> possible, not in low memory devices, since this modification will
> maintain decompresion related memory a little longer.
> 

Again, I don't think this method scalable.  Since you already handle
all decompression algorithms in this way.  Laterly, I wonder if you'd
like to handle all:
 - decompression algorithms;
 - verity algorithms;
 - decrypt algorithms;

in this way, regardless of slow decompression algorithms, that would be a
long latency and CPU overhead of softirq context.  This is my last words
on this, I will not talk anymore.

Thanks,
Gao Xiang
