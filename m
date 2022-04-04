Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216744F1E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiDDWKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381583AbiDDVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0E26ADF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D15460DC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E7EC340F3;
        Mon,  4 Apr 2022 21:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649107284;
        bh=LeIYKOsHQ9xZRpneElo70LVSJagsyRu9RsikNx7wcD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v6WEvpfHhKGsMluXjeaxmBT0vUFY/X3Pfd7doDDK0i8NZmwSEJEHnrGzkYQxpWzvp
         v7XyuLiag+iWlB0savMLw7oolXvdBXlTGZLCqGgygOm9ti+31E2x42LXWaJ8N9Tr2Q
         /qPNE8LTg83sd8pbVB29FTHIIYwpxfH/HcHJ1E3w=
Date:   Mon, 4 Apr 2022 14:21:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Nick Terrell <terrelln@fb.com>, Guo Xuenan <guoxuenan@huawei.com>,
        Chengyang Fan <cy.fan@huawei.com>, Yann Collet <cyan@fb.com>,
        "fangwei1@huawei.com" <fangwei1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com" 
        <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>,
        "wangli74@huawei.com" <wangli74@huawei.com>
Subject: Re: [PATCH v3] lz4: fix LZ4_decompress_safe_partial read out of
 bound
Message-Id: <20220404142123.7de8d3a291d6484e7fb4c8a0@linux-foundation.org>
In-Reply-To: <YkfXSzePVEhlajCU@B-P7TQMD6M-0146.local>
References: <20211111085058.1940591-1-guoxuenan@huawei.com>
        <20211111105048.2006070-1-guoxuenan@huawei.com>
        <CCE83845-DC40-4E14-9105-6319C048FACB@fb.com>
        <YkfXSzePVEhlajCU@B-P7TQMD6M-0146.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2022 12:55:39 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Fri, Nov 19, 2021 at 06:23:24PM +0000, Nick Terrell wrote:
> > 
> > 
> > > On Nov 11, 2021, at 2:50 AM, Guo Xuenan <guoxuenan@huawei.com> wrote:
> > > 
> > > When partialDecoding, it is EOF if we've either, filled the output
> > > buffer or can't proceed with reading an offset for following match.
> > > 
> > > In some extreme corner cases when compressed data is crusted corrupted,
> > > UAF will occur. As reported by KASAN [1], LZ4_decompress_safe_partial
> > > may lead to read out of bound problem during decoding. lz4 upstream has
> > > fixed it [2] and this issue has been disscussed here [3] before.
> > > 
> > > current decompression routine was ported from lz4 v1.8.3, bumping lib/lz4
> > > to v1.9.+ is certainly a huge work to be done later, so, we'd better fix
> > > it first.
> > > 
> > > [1] https://lore.kernel.org/all/000000000000830d1205cf7f0477@google.com/
> > > [2] https://github.com/lz4/lz4/commit/c5d6f8a8be3927c0bec91bcc58667a6cfad244ad#
> > > [3] https://lore.kernel.org/all/CC666AE8-4CA4-4951-B6FB-A2EFDE3AC03B@fb.com/
> > > 
> > > Reported-by: syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com
> > > Cc: hsiangkao@linux.alibaba.com
> > > Cc: terrelln@fb.com
> > > Cc: cyan@fb.com
> > > Cc: cy.fan@huawei.com
> > > Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> > 
> > Sorry I’m a bit late to the party, but this looks good to me!
> > 
> > Reviewed-by: Nick Terrell <terrelln@fb.com>
> 
> Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Hi Andrew,
> 
> This patch has already been pending for 2 release cycles.. Would you
> mind submitting it upstream? Or are there other concerns about this?

Sorry, I'd not noticed that this was from lz4 upstream.

I'll put a cc:stable in there and shall send it upstream this week.

In the changelog, can someone please explain what "crusted corrupted"
is saying?
