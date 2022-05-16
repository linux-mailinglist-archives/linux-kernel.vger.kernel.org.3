Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E198D529358
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349590AbiEPWHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349598AbiEPWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:07:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632263DDC3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06D7DB81643
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28715C385AA;
        Mon, 16 May 2022 22:07:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cA35lvvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652738836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Ij941pgPSObJ5yDgX33gwExzpgdb5NtjJSN0FhK17c=;
        b=cA35lvvlF3dISnP3mUllrkBDgKy5JwiEdHbog5pwo+PVtnyBS/fXelK4hUcGelK0UT3Ctb
        5KrusRDCZNg+HYaNfJK/RabxRq8TnAxZXfp9gyDygP1RroRX/gajzHDMsHLFsDPpZTG4mA
        MVUZ1ZJdMWZLb1Y+vSUvBWU1xVo5OLY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d65a96fc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 16 May 2022 22:07:15 +0000 (UTC)
Date:   Tue, 17 May 2022 00:07:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: move randomize_page() into mm where it belongs
Message-ID: <YoLLEHpcFbV2LHtR@zx2c4.com>
References: <20220514120556.363559-1-Jason@zx2c4.com>
 <20220516142800.4730a41ec1498d5e3d7863c0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220516142800.4730a41ec1498d5e3d7863c0@linux-foundation.org>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, May 16, 2022 at 02:28:00PM -0700, Andrew Morton wrote:
> On Sat, 14 May 2022 14:05:56 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> 
> > randomize_page is an mm function. It is documented like one. It contains
> > the history of one. It has the naming convention of one. It looks
> > just like another very similar function in mm, randomize_stack_top().
> > And it has always been maintained and updated by mm people. There is no
> > need for it to be in random.c. In the "which shape does not look like
> > the other ones" test, pointing to randomize_page() is correct.
> > 
> > So move randomize_page() into mm/util.c, right next to the similar
> > randomize_stack_top() function.
> > 
> > This commit contains no actual code changes.
> 
> hm, does it make sense?
> 
> Probably randomize_page() (which used to be called randomize_range())
> should have been called randomize_address().  Is it an MM function
> then?  Not really - it's simply an application of the random number
> generator.  So I think it's more a random thing than an MM thing.

There are many uses of randomness in the Linux kernel. Your use in mm is
not a special snowflake usage. You want good random integers with
various crypto properties? No problem, you got it. But what you do
with those is your own business. (I'm just a random number dealer.) The
particulars of addresses or page aligned addresses or whatever weird
properties you need out of this thing is your own mm puzzle. It has no
business hanging out here. And as evidence of this, randomize_stack_
top() is also in mm/util.c where it belongs and where the various things
it does can be maintained by people who know a thing or two about mm.
Just imagine all the different types of domain-specific objects that we
could randomize according to certain rules, and how insane it would be
if those all wound up in random.c. 

So with all due respect, I must disagree with you.

> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -343,6 +343,38 @@ unsigned long randomize_stack_top(unsigned long stack_top)
> >  #endif
> >  }
> >  
> > +/**
> > + * randomize_page - Generate a random, page aligned address
> 
> The patch assumes that drivers/char/random.o is always built into
> vmlinux, which appears to be the case.  If some space-conscious person
> goes and makes random.o build-time optional then they'll need to make
> the appropriate adjustments in util.c.  I see no problems with this.

random.o has random_init() that is called by main.o, so just for that
reason alone, it's un-=m-able. Plus the zillion call sites everywhere in
the kernel. It'll always be a builtin (and rightly so too, I think).

Jason

> 
