Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1735D52EFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351308AbiETQDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351327AbiETQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:03:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2ED17997B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AE30B82C7C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE89C34100;
        Fri, 20 May 2022 16:03:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jvghYB3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653062604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxK/166niZcoEyIlhxcsA5FExBrWFEE1gjPJTAretrY=;
        b=jvghYB3Mjr+uTh0z/fUkliKoagb2JlTzh/cpznczbWeL8ctfatbWEGAuk30sf8cC6yLfYw
        BJRv3GvSOroLh7RWTNwR0Qk25GcXDyiUNpoz7IRQ4iwA1K1Hnt56xf6SuPWK913R7e3P6f
        hw6Y4jY5vhbz668pUlRZft2ZXTW7OhI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 428e6b79 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 16:03:23 +0000 (UTC)
Date:   Fri, 20 May 2022 18:03:22 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoe7ykNXjUerhywY@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe2PPA/pzqhf+GZ@zx2c4.com>
 <0a6ed6b9-0917-0d83-5c45-70ff58fad429@kernel.dk>
 <Yoe52RaMayvgodVW@zx2c4.com>
 <79024675-9a4a-cb2b-a0ed-91067ef05783@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79024675-9a4a-cb2b-a0ed-91067ef05783@kernel.dk>
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

On Fri, May 20, 2022 at 09:58:28AM -0600, Jens Axboe wrote:
> On 5/20/22 9:55 AM, Jason A. Donenfeld wrote:
> > Hi Jens,
> > 
> > On Fri, May 20, 2022 at 09:44:25AM -0600, Jens Axboe wrote:
> >> Ran 32, 1k, 4k here and it does seem to be down aboout 3%. Which is
> >> definitely bigger than I expected, particularly for larger reads. If
> >> anything, the 32b read seems comparably better than eg 1k or 4k, which
> >> is also unexpected. Let me do a bit of profiling to see what is up.
> > 
> > Something to keep in mind wrt 32b is that for complicated crypto
> > reasons, the function has this logic:
> > 
> > - If len <= 32, generate one 64 byte block and give <= 32 bytes of it to
> >   the caller.
> > 
> > - If len > 32, generate one 64 byte block, but give 0 of it to the
> >   caller. Then generate ?len/64? blocks for the caller.
> > 
> > Put together, this means:
> > 
> > - 1..32, 1 block
> > - 33..64, 2 blocks
> > - 65..128, 3 blocks
> > - 129..196, 4 blocks
> > 
> > So you get this sort of shelf where the amortization benefits don't
> > really kick in until after 3 blocks.
> 
> Ah I see, I can see if 64b is closer to the change for eg 1k.

What I meant by providing all that detail is that from a cycles-per-byte
perspective, smaller=more expensive. So it's possible that the
difference in the patchset is less visible as it gets lost in the more
expensive operation.

> >> If you're worried about it, I'd just keep the read/write and add the
> >> iter variants on the side.
> >  
> > Not a chance of that. These functions are already finicky as-is; I would
> > really hate to have to duplicate all of these paths.
> 
> Then I'd say there are only two options:
> 
> - Add a helper that provides splice for something that only has
>   read/write set.

That'd be fine with me, but wouldn't it involve bringing back set_fs(),
because of the copy_to_user() in there?

> - Just accept that we're 3% slower reading from /dev/urandom for now,
>   and maybe 1-2% for small reads. Can't really imagine this being a huge
>   issue, how many high throughput /dev/urandom read situations exist in
>   the real world?

An option three might be that eventually the VFS overhead is worked out
and read_iter() reaches parity. One can hope, I guess.

Jason
