Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71752E09E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbiESXje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiESXjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:39:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5647ED78E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F877617FF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE52C385AA;
        Thu, 19 May 2022 23:39:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C1I8xTFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653003568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edjvbY7HX7Lcrbc+aJx5o8Hn+MKLeaVB2jN9HDZFfS8=;
        b=C1I8xTFfxz9WdxLF7BHNwQYRMHm820W30KjpGT5tD45asjE/7Mm5FF/tXJXCBmz/3gSihm
        TeXVwRaz0kP5J7s+A+b1NXyipneBaoXKpItUMT/rDY8CtMn1WPO/Xyw4pypV5LpddU09xA
        F6z2T+piJkJLldQB67E8TKhsn4IFJDo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ad65c0f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 19 May 2022 23:39:28 +0000 (UTC)
Date:   Fri, 20 May 2022 01:39:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <YobVLs3mpEFjJCh3@zx2c4.com>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk>
 <YobPfgkzGrNPDDFI@zx2c4.com>
 <60b82026-9c46-16ea-d9fa-05eb96ae2218@kernel.dk>
 <CAHmME9rdJ=Pa=KOY6voryiHffWSkRKxC75+Wz-xoQOpowObwWw@mail.gmail.com>
 <3bcbfde4-3247-b4ff-9a7c-963a9a510703@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3bcbfde4-3247-b4ff-9a7c-963a9a510703@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, May 19, 2022 at 05:33:01PM -0600, Jens Axboe wrote:
> On 5/19/22 5:25 PM, Jason A. Donenfeld wrote:
> > Hi Jens,
> > 
> > On Fri, May 20, 2022 at 1:22 AM Jens Axboe <axboe@kernel.dk> wrote:
> >> I can certainly do the write side too. To fix this regression, I just
> >> valued doing read_iter first and I'd hate to hold that up to do the
> >> write side too. I'll do the write side later today, but let's keep them
> >> separate.
> > 
> > Excellent, thanks. I plan to queue these up all in a row.
> 
> Built and tested v2, just sent it out. Note that it deviates from your
> proposal a bit since with that we lost the
> 
> if (!len)
> 	break;
> 
> check, which is kind of important if you ever want to be done :-)

Heh, noticed that too, thanks.

> I'll do the write_iter side, but as mentioned, I'd prefer to keep it
> separate from this patchset as this one fixes a real regression that we
> need to get backported too.
 
No problem. Because of all the flux in random.c lately, I've been
preparing a massive backports branch, 2 branches actually, so I'll make
sure this is in there. Backport concern aside, though, I'll look for
your write_iter patch today. Thanks a bunch for doing this.

Jason
