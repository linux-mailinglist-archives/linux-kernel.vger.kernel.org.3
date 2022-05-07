Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32051EA3B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 23:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbiEGVNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiEGVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 17:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C391FA5C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 14:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5FC760F1D
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 21:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FABDC385A6;
        Sat,  7 May 2022 21:09:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pznzHB1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651957762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lk30THO3HB5kPajzetw4xF9bAtWD4Cc08LXbxNpuCnE=;
        b=pznzHB1MnuQ84bHBqoMHwKbfYxAue5B2MNLxtVQX6HEhkiK/rsWenOkMHOb+gj/jW/KR4N
        J95ZcmhYpI4OWqy9S7Dbxvkar7TOrUiYdqBSgxOmIHi3EkbiHJmcmVwBoJFkCTPZjIDPov
        hhsy3rUphNFmKJ1atQlRRNVk5nsJn08=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f85603cf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 7 May 2022 21:09:22 +0000 (UTC)
Date:   Sat, 7 May 2022 23:09:20 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] init: call time_init() before rand_initialize()
Message-ID: <YnbgAGgC0DFBvLcL@zx2c4.com>
References: <20220505003114.177552-1-Jason@zx2c4.com>
 <20220507122653.e5ea43e8200568b348b7a16d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220507122653.e5ea43e8200568b348b7a16d@linux-foundation.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, May 07, 2022 at 12:26:53PM -0700, Andrew Morton wrote:
> On Thu,  5 May 2022 02:31:14 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> 
> > Currently time_init() is called before rand_initialize(), but
> 
> You mean "after"!  Changelog was really confusing until I went and
> looked at the code.

Oh dear, yes. Will fix that.

> 
> > rand_initialize() makes use of the timer on various platforms, and
> > sometimes this timer needs to be initialized by time_init() first. In
> > order to not return zero, 
> 
> return zero from what?

random_get_entropy_fallback(). I'll fix that in the commit message.

> > reverse the order of these two calls. The
> > block doing random initialization was right before time_init() before,
> > so changing the order shouldn't have any complicated effects.
> 
> I hope you're right.  Moving these things around tends to fix one thing
> and break another.

I hope so too. Reading the platform code for every arch I can't see
where breakage would be. Nothing in the time init functions relies on
the rng being available, and actually, the rng is already quasi
functional before the call to rand_initialize(), so I think it should be
good. Nonetheless:

> No probs.  Plenty of testing in linux-next, please.

Exactly this. Plus the CI on build.wireguard.com and such is churning on
it on a variety of different archs.

Jason
