Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD044BDC27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379337AbiBUPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:39:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344377AbiBUPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:39:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A7BF61
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:39:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ACE5611B2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54985C340E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:39:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EhTBZpfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645457957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecbWHbIWQWLoIepapTzrHia8QmhlQF1YDdabEBXn4hE=;
        b=EhTBZpfob8gSnhGNWHyJlDp7LOjV4VZvuOMASofDBomI/x9IOOoXf/u/tnon2KqP/fQDFp
        XCdEOMPmmU25hwFO8GLuFPKSEdWuqUcmw6q+ys/DrIIVdN+eFhrmSrk6aWIOmXMzBaF1U3
        xJrAN+JNPV+QyTjrpc4Ylhd8lP23PPs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0c5bdaae (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 15:39:16 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d07ae0b1c4so142244677b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:39:16 -0800 (PST)
X-Gm-Message-State: AOAM531SgoINpJGIG6sBQj5jNzoSPHNqeJrHLxythAjrZCcZVc3+cI5b
        nxEwJLrvbrStb+EOmpkSmWDgSwSuQuSukWT40bM=
X-Google-Smtp-Source: ABdhPJzjlbAYLeTw1XFPhc6Tce630FK103+HjeKcQjWN5SeHAOqBdqcNspF+DdLUFYYg0jZCATxsmHj7yjJDna3+NLA=
X-Received: by 2002:a81:5c83:0:b0:2d2:c136:70f3 with SMTP id
 q125-20020a815c83000000b002d2c13670f3mr21079339ywb.404.1645457955646; Mon, 21
 Feb 2022 07:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-10-Jason@zx2c4.com>
 <YhMhbKdIH2wwEDxc@sol.localdomain> <CAHmME9o5FhAWYS7bfnXzNzLBtCadAYWXHjmE2tZNMG3C64NeKw@mail.gmail.com>
In-Reply-To: <CAHmME9o5FhAWYS7bfnXzNzLBtCadAYWXHjmE2tZNMG3C64NeKw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 16:39:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9r0H7BzU2B+X=twh7JWAo7EaaRv6NRVK3sEbDh2v=VLYA@mail.gmail.com>
Message-ID: <CAHmME9r0H7BzU2B+X=twh7JWAo7EaaRv6NRVK3sEbDh2v=VLYA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] random: group sysctl functions
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Mon, Feb 21, 2022 at 4:27 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Mon, Feb 21, 2022 at 6:21 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > This is a nice explanation, but shouldn't
> > Documentation/admin-guide/sysctl/kernel.rst be updated instead, and this comment
> > point to there?
>
> I'll update kernel.rst for this and for the other thing in a separate
> commit to make merge conflicts less annoying.

Actually, it's not that bad. I'll update kernel.rst in the commits
where the behavior needs updating, but I'm fine with the slightly
different wording there for the most part.
