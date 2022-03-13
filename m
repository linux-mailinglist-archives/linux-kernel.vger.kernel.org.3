Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463774D71DA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiCMA0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiCMA0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:26:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A768E10875C;
        Sat, 12 Mar 2022 16:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AF94B80A0B;
        Sun, 13 Mar 2022 00:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71CAC340EB;
        Sun, 13 Mar 2022 00:24:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ggPzpYKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647131092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LPruWuplVVSMGlwKplBJprJmZCwY6gYq6gxy74Sdb4E=;
        b=ggPzpYKJY7fQOh88JB2h6aYEhJjqKKD0MyFdtnQBicDeOQe0bzXCKruxF94JFIzNlqk4Yq
        8NxSYlRHqagGz0VV8QUqZG5JPjfUNr9nPnvUTh5q/FSIxhIdTIJQ4Q1MzzZYP3EItUZ+CP
        W6Dt5HVAB+2vXwvw3oOhR1+R5FlOtlc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8530a524 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Mar 2022 00:24:52 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d07ae0b1c0so130149177b3.2;
        Sat, 12 Mar 2022 16:24:52 -0800 (PST)
X-Gm-Message-State: AOAM530eMhelu+bhvx8CeFRzex7PAkBdmkEqTtvIhfbTiOsr0dnAj/IN
        Lv8RulsPYcFPktvFhJU4hg9fWOgP6P9gSZO90l4=
X-Google-Smtp-Source: ABdhPJznYYGDgtOrX3fCo4I+NxKlhVX0LrPcpi0IY/GWp8TwYV9ym8l29CUajkUCtaOtJtjsT2i/+MMRod78ZE1TE/k=
X-Received: by 2002:a81:49d5:0:b0:2dc:5709:4d91 with SMTP id
 w204-20020a8149d5000000b002dc57094d91mr13838610ywa.231.1647131091615; Sat, 12
 Mar 2022 16:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20220306165123.71024-1-Jason@zx2c4.com> <Yi0TA1r81AXh7nP/@sol.localdomain>
 <CAHmME9rYWyT=t8tU5MZfg6hKUqrz49haKRc51FUC+HjXFGoOdw@mail.gmail.com> <Yi05ciQRhqa4MoF7@sol.localdomain>
In-Reply-To: <Yi05ciQRhqa4MoF7@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 12 Mar 2022 17:24:40 -0700
X-Gmail-Original-Message-ID: <CAHmME9ownep6XxBo_3ui452hH3J7MA5VzJ2aJBne_uLXN69VMg@mail.gmail.com>
Message-ID: <CAHmME9ownep6XxBo_3ui452hH3J7MA5VzJ2aJBne_uLXN69VMg@mail.gmail.com>
Subject: Re: [PATCH v2] random: use SipHash as interrupt entropy accumulator
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
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

On Sat, Mar 12, 2022 at 5:23 PM Eric Biggers <ebiggers@kernel.org> wrote:
> That isn't mentioned in Documentation/security/siphash.rst at all.  It actually
> makes it pretty clear that hsiphash() is "HalfSipHash".

Send a documentation patch and I'll queue it up.

>
> > > So on 64-bit platforms it now throws away half of the pool.
> > >
> > > It should use 'u8 pool[sizeof(fast_pool->pool)]' to avoid hardcoding a size.
> >
> > Actually the commit message notes that we intentionally dump half of
> > it on 64bit. This is intentional.
> >
>
> It doesn't explain *why* it does that.  Also, the code is much more important
> than the commit message, and there's no explanation in the code at all; it just
> looks like a bug.

Yea. I'll augment that and send a v+1.

Jason
