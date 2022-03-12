Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837A24D71A0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiCLX7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiCLX73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:59:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C27A98D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:58:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02B59B80A0A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D5C340EE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:58:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xy4tq4tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647129498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f017QJBEVKHLfOiZF1LFbsVrRrDIA/0lqnFdabyKKHQ=;
        b=Xy4tq4tkI4ofAWEP0hL5zQ05nzvLPNEphQNjVczPSKKV0Vh1a/Z1oYsUImkKPWOg3XasQm
        E22CkkPv2qJEK4eM3qkMxvFLvx1/8l1bPtVyzlPjF9eo7qAqXXO7ed84qz+/fV9K/7aApN
        Jp2hrfleQ/SeONxFjd3DkPZ0zKmQZwI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7021d6a2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 12 Mar 2022 23:58:17 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2dc28791ecbso129485017b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:58:17 -0800 (PST)
X-Gm-Message-State: AOAM530VdkIInWR/ZsxLfeZ0DnzIymVlSAbXWJgvZX3Y2c8L3S9T6ReN
        JKF3qWQJL+3tG7uaAGLQZMMJVH/5F3qFfX2gB7U=
X-Google-Smtp-Source: ABdhPJwzO0vgTgNVFihOutsNikyUIbJ+MpmFka0G9PCz+QTmWWmm+Owk+dBhWmI/R9BJt5LSHkiSV5j2DMKBARbITPY=
X-Received: by 2002:a81:8984:0:b0:2db:6b04:be0c with SMTP id
 z126-20020a818984000000b002db6b04be0cmr13311592ywf.2.1647129497236; Sat, 12
 Mar 2022 15:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20220308182517.273662-1-Jason@zx2c4.com> <Yiz98wP1hiPR5Azm@sol.localdomain>
In-Reply-To: <Yiz98wP1hiPR5Azm@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 12 Mar 2022 16:58:06 -0700
X-Gmail-Original-Message-ID: <CAHmME9p2v664oLNAv74H=tu3CFVwxtEUw5M9neOAred6pR3FDg@mail.gmail.com>
Message-ID: <CAHmME9p2v664oLNAv74H=tu3CFVwxtEUw5M9neOAred6pR3FDg@mail.gmail.com>
Subject: Re: [PATCH] random: make consistent usage of crng_ready()
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

Hi Eric,

On Sat, Mar 12, 2022 at 1:09 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Mar 08, 2022 at 11:25:17AM -0700, Jason A. Donenfeld wrote:
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 69591d599338..e37ae7ef039c 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -123,7 +123,7 @@ static void try_to_generate_entropy(void);
> >   */
> >  int wait_for_random_bytes(void)
> >  {
> > -     if (likely(crng_ready()))
> > +     if (crng_ready())
> >               return 0;
> >
> >       do {
> ...
> >       } while (!crng_ready());
>
> I guess the reason why the above doesn't simply use a 'while' loop is because
> someone wanted 'likely()' on the first crng_ready()?  That doesn't actually
> apply, since crng_ready() has likely() itself, it should just be a 'while' loop.

Nice catch, thanks.

Jason
