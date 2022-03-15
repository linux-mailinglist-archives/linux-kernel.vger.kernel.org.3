Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166C44DA182
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350692AbiCORqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiCORqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:46:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB94ECD5;
        Tue, 15 Mar 2022 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+TV4u+fka6NmbVTg8AiuGEnj8KksGrxh2QycKle+auE=; b=mU8BsnmCdFVS0xbV8+QIe5FBhG
        xnk/PFuUpA6SmByVnVwctQI5JM+09DS6kRPtaE64zXhePkamEy07A5wY/dDDddTUDaZAwsmf0xqrA
        HLoQt9pzKNHLcNZy3RQ23DY3z1QLlSb1T8bXsXw5BISSL9e5Er0qlCDeILYFfMjqqNZbPiOnsD+TU
        AdEai8gGPXocgfYC4z7MgsMkJMPQ/EthBZ6Ny9NUmDswqWkP1se19PjnZ/n8kBDd0MGntpVhICZ5W
        n4A7D8RGbs3vGpkepFccxf0NNDSww8RMVYpl+QLxxrzFS7z/BIyVhdtLWzEKLnts7iqI/Veo4GHMq
        ZqcBdv/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUBDz-005FDw-Ut; Tue, 15 Mar 2022 17:44:47 +0000
Date:   Tue, 15 Mar 2022 17:44:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
Message-ID: <YjDQj9dr34Jpw3cU@casper.infradead.org>
References: <20220315172221.9522-1-bgeffon@google.com>
 <YjDMo35Q/cvPLkxu@casper.infradead.org>
 <CADyq12yK+qODV2ut1acjwkyXKDbh_YS3MHpRoJaq_g9G1HAyEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12yK+qODV2ut1acjwkyXKDbh_YS3MHpRoJaq_g9G1HAyEw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:34:21PM -0400, Brian Geffon wrote:
> On Tue, Mar 15, 2022 at 1:28 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Mar 15, 2022 at 10:22:21AM -0700, Brian Geffon wrote:
> > > Today it's only possible to write back as a page, idle, or huge.
> > > A user might want to writeback pages which are huge and idle first
> > > as these idle pages do not require decompression and make a good
> > > first pass for writeback.
> >
> > We're moving towards having many different sizes of page in play,
> > not just PMD and PTE sizes.  Is this patch actually a good idea in
> > a case where we have, eg, a 32kB anonymous page on a system with 4kB
> > pages?  How should zram handle this case?  What's our cut-off for
> > declaring a page to be "huge"?
> >
> 
> Huge isn't a great term IMO, but it is what it is. ZRAM_HUGE is used
> to identify pages which are incompressible. Since zram is a block
> device which presents PAGE_SIZED blocks, do these new changes which
> involve many different page sizes matter as that seems orthogonal to
> the block subsystem. Correct me if I'm misunderstanding.

Oh, so ZRAM's concept of huge is not the same as the "huge" in
"hugetlbfs" or "THP"?  That's not at all confusing ...
