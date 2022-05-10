Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043A252273A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiEJWub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiEJWuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1B24E023;
        Tue, 10 May 2022 15:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FCEBB82004;
        Tue, 10 May 2022 22:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9148BC385D0;
        Tue, 10 May 2022 22:50:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="m2qHVslI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652223014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+CqMPmHp+6ac0+Sm4AN/wwxvPotPYL1MZ4jUenJ3jE=;
        b=m2qHVslIkinT8gFrhEc7CNtoppYkDVjiQ3rO6iYQ6YJew5wu6LSGAGEaXRrd5QgJkHVOBF
        anEbwNAgvrudnrfVYIVe3wP5vg2QbT0O1n7SBZESlRh8ozDaOcB3+yLvA6YYCuuRtRRwtf
        xrlfj/bNgWVvcYsI99nBRYDpJBV4CWs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e7faad4f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 10 May 2022 22:50:14 +0000 (UTC)
Date:   Wed, 11 May 2022 00:50:11 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Simo Sorce <simo@redhat.com>
Cc:     dodis@cs.nyu.edu, tytso@mit.edu, nadiah@cs.ucsd.edu,
        noahsd@gmail.com, tessaro@cs.washington.edu,
        torvalds@linux-foundation.org, jeanphilippe.aumasson@gmail.com,
        jann@thejh.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peter@cryptojedi.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, "D. J. Bernstein" <djb@cr.yp.to>
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
Message-ID: <YnrsI3wdrbnW7gjS@zx2c4.com>
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
 <Ym3ZM1P+uYYABtRm@mit.edu>
 <Ym5sICj5iBMn2w/E@zx2c4.com>
 <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
 <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
 <YnqDC25iR8mcL3XB@zx2c4.com>
 <20220510185123.80607.qmail@cr.yp.to>
 <YnrGYMyEL8qPMRGt@zx2c4.com>
 <5b63a8a37b415db66ffe6b660859e3900c054909.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b63a8a37b415db66ffe6b660859e3900c054909.camel@redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simo,

On Tue, May 10, 2022 at 05:33:34PM -0400, Simo Sorce wrote:
> On Tue, 2022-05-10 at 22:09 +0200, Jason A. Donenfeld wrote:
> > For 5.19 (or at this point, more likely 5.20), there's a userspace
> > notifier in store, maybe, if I can figure out how to do it right.
> > There's a pretty bikesheddy thread here on what shape that interface
> > should take: https://lore.kernel.org/lkml/YnA5CUJKvqmXJxf2@zx2c4.com/
> > But basically there are some details about how an async interface should
> > work, and what the virtual hardware future, if any, looks like for a
> > memory mapped race-free polling interface. Plus some considerations on
> > how much we should care etc.
> 
> Perhaps it might be simpler to add an "epoch" number or similar exposed
> [...]

Could you send these ideas to the bikeshed thread that I linked rather
than this premature next one. I think it'd be a good idea to keep Alex
and Lennart looped in to that discussion, since they represent userspace
projects that probably care about it, and not bog this one down with
systems programming things pretty far from premature next threat model
stuff. It's a bikeshed thing, after all...

Thanks,
Jason
