Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90055825E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiG0LxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiG0LxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:53:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9C533E30
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E7C4B82022
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A84C433D6;
        Wed, 27 Jul 2022 11:52:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="icKsJe67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658922776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nAk1JDN+XhLzlzzkZr2i7osqynHxkpD7l3bi3JVECoE=;
        b=icKsJe673P3y7lDgpEimTtWlXPcwhYXs9Y5iqFw3F07jEc3OIspnZrJRK4oJLe8Fl1XSJI
        xeA8ztDlCbCkze46H1g6Azp2vj09aOjHtZ0nas30ytcMKGn/149rGBbFJsfhkawazGjzfb
        MHGCZszUCdQHHm3UMzhY1kRRC5CTPXM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 59388ba0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 27 Jul 2022 11:52:56 +0000 (UTC)
Date:   Wed, 27 Jul 2022 13:52:54 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] powerpc rng cleanups
Message-ID: <YuEnFgFoauUlS9kj@zx2c4.com>
References: <20220711232448.136765-1-Jason@zx2c4.com>
 <YtVbbMpRbfCWEIFn@zx2c4.com>
 <CAHmME9pMOQKnMUQQyOA+CkN5scQjtLN79pvdYSu70MkuU207cw@mail.gmail.com>
 <87wnbz9pnk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnbz9pnk.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Jul 27, 2022 at 01:54:07PM +1000, Michael Ellerman wrote:
> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> > On Mon, Jul 18, 2022 at 3:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >> On Tue, Jul 12, 2022 at 01:24:46AM +0200, Jason A. Donenfeld wrote:
> >> > These are two small cleanups for -next. This v5 rebases on the latest
> >> > git master, as some whitespace was added that made v4 no longer apply.
> >> >
> >> > Jason A. Donenfeld (2):
> >> >   powerpc/powernv: rename remaining rng powernv_ functions to pnv_
> >> >   powerpc/kvm: don't crash on missing rng, and use darn
> >> >
> >> >  arch/powerpc/include/asm/archrandom.h |  7 +--
> >> >  arch/powerpc/kvm/book3s_hv_builtin.c  |  7 +--
> >> >  arch/powerpc/platforms/powernv/rng.c  | 66 ++++++++++-----------------
> >> >  drivers/char/hw_random/powernv-rng.c  |  2 +-
> >> >  4 files changed, 30 insertions(+), 52 deletions(-)
> >>
> >> I think v5 has reached a completion point. Could you queue these up in
> >> some PPC tree for 5.20?
> >
> > Just paging again. Do you think you could queue these up for 5.20?
> > This trivial series is over a month old now.
> 
> It can't claim to fix a guest-triggerable hypervisor crash and also be
> "trivial" :)

:)

> 
> But yes I plan to queue it for v5.20.

Okay great. Would be nice to see this in -next sooner rather than later.

Jason
