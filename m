Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814814B3B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiBMNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:14:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiBMNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:14:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91E5DE66
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:14:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38B66B80ADA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE6BC004E1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:14:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h/kQZ0g0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644758083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufpXyc7vzeeei3yPZgdGVCOKmPsaVuw/LBlob67IqPQ=;
        b=h/kQZ0g0sBpUACrnMZCgxm5zZmVYcTaFzfhAQLRsIZjKXiayWqBeNuKPjxHqE+pWCWTH92
        XLwzstSc2H08CN2qDs4k2EgGzA9f3od4HeF8d81JWxFqplzUODfnWFTSou4uuylum20yDQ
        +9WSx0qSRkoYEhJQ71pPw+ZPho6CXOg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fed48833 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 13 Feb 2022 13:14:43 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id e140so19349399ybh.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:14:43 -0800 (PST)
X-Gm-Message-State: AOAM532hw4Odg3UEEKCHaGyRLFQQ11bsnZavejbn29PfQloXxHkivf+4
        Rwwt439fcAjfhbvrWqGv+/IhGgidyYXSXC2yL0U=
X-Google-Smtp-Source: ABdhPJyRWu7w7wrhhEb2TwJLpfmpIWdNsXQ35J1y/gPLnJCVF7e/5lqFaz8kMfFrZzOgX1j+PwValE05w7aWU0At/2E=
X-Received: by 2002:a81:3283:: with SMTP id y125mr9940020ywy.100.1644758082629;
 Sun, 13 Feb 2022 05:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20220212122318.623435-1-Jason@zx2c4.com> <20220212122318.623435-6-Jason@zx2c4.com>
 <YgirLX70xHFXTMDf@owl.dominikbrodowski.net>
In-Reply-To: <YgirLX70xHFXTMDf@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 14:14:32 +0100
X-Gmail-Original-Message-ID: <CAHmME9qLOWKHeA13bfzq9OKRi_M0ANqz4CXZHrLzAjesVGTOdg@mail.gmail.com>
Message-ID: <CAHmME9qLOWKHeA13bfzq9OKRi_M0ANqz4CXZHrLzAjesVGTOdg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] random: group crng functions
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

Hi Dominik,

On Sun, Feb 13, 2022 at 7:57 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> No, it's for crng_init == 0 only.

Right! Nice catch, thanks.

> > + * Batched entropy returns random integers. The quality of the random
> > + * number is good as /dev/urandom. In order to ensure that the randomness
>
> /dev/random

/dev/urandom is the right analogy, actually, since batched entropy won't wait.

> > +size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
>
> Sidenote: We should get rid of the sole caller of that function, and then of
> this function. AFAICS, using get_random_bytes() (once rand_initialize() has
> been called) should never be less secure than get_random_bytes_arch() IFF
> arch_get_random_long() exists -- which is what the sole caller seems to be
> interested in.

I agree entirely that we should get rid of this. I think the issue is
vsprintf needs a stable key for siphash that never changes once
initialized, and the earlier they can get something good enough, the
better. If they can't get something good, vsprintf needs to know so it
can defer that to later. So I'm not yet sure the right way to solve
it, but I agree we should find some way to ditch this function.

Jason
