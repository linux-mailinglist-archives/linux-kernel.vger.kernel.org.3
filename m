Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF1552637
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243194AbiFTVC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiFTVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7762D0;
        Mon, 20 Jun 2022 14:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A9E461151;
        Mon, 20 Jun 2022 21:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A819C3411B;
        Mon, 20 Jun 2022 21:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655758975;
        bh=YXHELCkM/DaDMHJEhftBobWPAAsBACKzdTfooNhF3xo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AihOai6z5WodejxapxdG/Gh+CAzGZfabSqHcZQbPnNr15qoCfvqUIevadlSPZhn4C
         LGRoL6AGtPrpTv6DZHgkqQ1Lvg9gkjqKgZiJKFwUG/F82ovq63Dw4Gwz6pM9lKnOZA
         nhna/6d/hg9dCqr3A6hgiXuB7+tFKmWZvIR6+ygHnj5v2EASXrYlGhlRzmUxs9VbvL
         dkYUBlIei7DT7N37TRfXmll8F2mTvM2TeJKSloxY29tq9G90V5+mQO/AcyJFeelfez
         b6fti4fjC4LzmOhVQdP3rQSuihxlDcW5nBR7QSfc3NAosS1OVKcltF925X3ehTBbUQ
         akAHSbtZY0Htw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 00D025C0564; Mon, 20 Jun 2022 14:02:54 -0700 (PDT)
Date:   Mon, 20 Jun 2022 14:02:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, arnd@arndb.de,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] asm-generic: Add memory barrier dma_mb()
Message-ID: <20220620210254.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-2-wangkefeng.wang@huawei.com>
 <CANpmjNNPf5J2OcVxoMgVtFYjWJhJ2JE+UBFyqnt6+WrPobPOHQ@mail.gmail.com>
 <20220616231350.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMnA0VtExcvpV=Sr57RQ3xxVkHxhrTkvEKeHZ27bhud+w@mail.gmail.com>
 <Yq7wMj30T/mJp+FZ@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq7wMj30T/mJp+FZ@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 10:45:22AM +0100, Catalin Marinas wrote:
> On Fri, Jun 17, 2022 at 12:18:41PM +0200, Marco Elver wrote:
> > On Fri, 17 Jun 2022 at 01:13, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Mon, May 23, 2022 at 01:35:27PM +0200, Marco Elver wrote:
> > > > On Mon, 23 May 2022 at 13:21, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > > > >
> > > > > The memory barrier dma_mb() is introduced by commit a76a37777f2c
> > > > > ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> > > > > which is used to ensure that prior (both reads and writes) accesses
> > > > > to memory by a CPU are ordered w.r.t. a subsequent MMIO write.
> > > > >
> > > > > Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> > > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > >
> > > > Reviewed-by: Marco Elver <elver@google.com>
> > >
> > > Just checking...  Did these ever get picked up?  It was suggested
> > > that they go up via the arm64 tree, if I remember correctly.
> > 
> > I don't see them in -next, and as far as I can tell, they're not in
> > the arm64 tree.
> 
> Since v4 was posted during the merging window, it hasn't been queued for
> 5.19-rc1. I normally only merge patches with a Fixes tag during the -rc
> period (though there are some exceptions). Mark commented in v1 that
> such tag isn't necessary, so I thought I'd leave it for the 5.20 merging
> window.
> 
> That said, the diffstat is small, so if it helps having this in 5.19, I
> can queue it for -rc4.

As long as it is not going to be lost, I am good.  ;-)

So v5.20 is fine.

							Thanx, Paul
