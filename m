Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85D52E0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbiETAAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiETAAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD478E1A5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFB2618D3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB80C34116
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:00:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J7mtwgRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653004819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAf+9bb45OCjD9+tc2mnJ4RbdTvw8XAUzNhGDT5kgLo=;
        b=J7mtwgRZPYPxlKHkSssJLpp+KUXu2+mcJQaaRPReQDed8cvMpoxNHFz6r9hFnWcBAo9ce7
        EqP6T5u6DgK3hRkf6T2DpPiP4Zcmc7Kww7bASSu6CDHr5rSbxbGdnqMOH7TO9egcdYxgX6
        SU4PcWieRNF12rF4bmEQDgGA2bw8f9g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff98562a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 20 May 2022 00:00:19 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id x2so11330710ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:00:19 -0700 (PDT)
X-Gm-Message-State: AOAM533ZOW8par7o8PN7MjpG/vecqXiGsdbz5+3h6NMKnuIVZZEh17fe
        q/GV7KlfGYLUwe1NmAYwg+1JaEQ63mmwWNnVwB8=
X-Google-Smtp-Source: ABdhPJzy3BpkOgC2LunI9aQfxaONR+84wzAomthj6DSfBB0tceE3i5tTas+3b9R9WiJOZPgzpqiXXY8DMu7/V6ozsf4=
X-Received: by 2002:a25:bf85:0:b0:64a:422c:24e7 with SMTP id
 l5-20020a25bf85000000b0064a422c24e7mr7098138ybk.637.1653004818108; Thu, 19
 May 2022 17:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220519193133.194138-1-axboe@kernel.dk> <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk> <YobPB27Ozl7uqUEu@zx2c4.com>
 <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk> <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk> <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
In-Reply-To: <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 20 May 2022 02:00:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
Message-ID: <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, May 20, 2022 at 1:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/19/22 5:27 PM, Jason A. Donenfeld wrote:
> > Hi Jens,
> >
> > On Fri, May 20, 2022 at 1:25 AM Jens Axboe <axboe@kernel.dk> wrote:
> >> I'll leave that to you :-)
> >
> > Alright, I'll have a look. Which one do I want here? This series adds
> > splice_read/splice_write. The new thing would be sendpage? Or
> > copy_file_range? Or something else?
>
> For copying kernel memory? It's really the same thing, you just
> initialize the iter as an ITER_KVEC instead. The nice thing about the
> iov_iter iterator that it then hides that for you, call the same copy
> in/out helpers for it.

Err, maybe we're talking about different things? I was thinking about
the plumbing to make splice/sendfile work on non-pipes.

get_random_bytes() itself doesn't need to become iovec'd, as that has
no IO callers.

Jason
