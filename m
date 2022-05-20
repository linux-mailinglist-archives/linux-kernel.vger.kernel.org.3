Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7439D52E15C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiETAtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiETAtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:49:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B92131282
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99422B828D4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A8C385AA;
        Fri, 20 May 2022 00:48:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qj0iwbCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653007736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/SmuBpUnACD+gjGhsMEzSbn7shiIkGrkuOq4wbp68o=;
        b=Qj0iwbCYyLFkB6gH+MildCAXPIvaiDYreUiAyOMl2R1sVyIY/+QWWiSjFbLGumkj9xKV36
        NYH3wO8BVb1n12HLegFoRvTa46jDYDSQPDdklW+fgJ8xHtYdZdTRVobLU4oZJnZppMFBEY
        Lg4Vpy1sIEIUR45sQXzltkeOQHE8gsI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1085d6bd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 00:48:56 +0000 (UTC)
Date:   Fri, 20 May 2022 02:48:54 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <YobldmDn6pU9mr4f@zx2c4.com>
References: <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <YobPB27Ozl7uqUEu@zx2c4.com>
 <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
 <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
 <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
 <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk>
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

On Thu, May 19, 2022 at 06:02:55PM -0600, Jens Axboe wrote:
> On 5/19/22 6:00 PM, Jason A. Donenfeld wrote:
> > Hi Jens,
> > 
> > On Fri, May 20, 2022 at 1:57 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 5/19/22 5:27 PM, Jason A. Donenfeld wrote:
> >>> Hi Jens,
> >>>
> >>> On Fri, May 20, 2022 at 1:25 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>> I'll leave that to you :-)
> >>>
> >>> Alright, I'll have a look. Which one do I want here? This series adds
> >>> splice_read/splice_write. The new thing would be sendpage? Or
> >>> copy_file_range? Or something else?
> >>
> >> For copying kernel memory? It's really the same thing, you just
> >> initialize the iter as an ITER_KVEC instead. The nice thing about the
> >> iov_iter iterator that it then hides that for you, call the same copy
> >> in/out helpers for it.
> > 
> > Err, maybe we're talking about different things? I was thinking about
> > the plumbing to make splice/sendfile work on non-pipes.
> 
> Ah I see. sendfile() just uses splice() internally, so that'll work
> (again) with my changes. splice(), by definition, either moves to and
> from a pipe. Hence one of the fds must be a pipe. Does that answer the
> question?

sendfile() returns -EINVAL even with your patches. Only splicing to pipes
seems to work.

Jason
