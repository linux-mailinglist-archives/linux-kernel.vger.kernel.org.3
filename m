Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D174E69C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353395AbiCXU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbiCXU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A8B823E;
        Thu, 24 Mar 2022 13:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A03C760E01;
        Thu, 24 Mar 2022 20:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC92CC340F0;
        Thu, 24 Mar 2022 20:25:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UKzXx7U8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648153519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RkY9t7umYKBJP6+uc9ba6GvtcEtEBbhdHDYPRUrWRlc=;
        b=UKzXx7U8WCZWGwlO54cB9EN+wv46ugCyBf/fGCFV91sgFvt+Vjj8UPbItwnfSQEt4LxUdd
        i81f6FBG158uyccfJ1M+cNnWnC96sW0SLEn1Umv5U58rUW+rSK4iDS67lEgGbF1sv084D8
        kx0/ZOC1RKcn4Gi8tppAXiHa95JMDZs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83bc1b55 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Mar 2022 20:25:19 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2d07ae0b1c4so62964897b3.11;
        Thu, 24 Mar 2022 13:25:19 -0700 (PDT)
X-Gm-Message-State: AOAM530/AXtb18kdmyeH0S4ou5muQ1Zrrz6RIttcmTRSjhDx+vnzeEOU
        BmkOIw87zSVoPs2glLvWOO9j4V1Su5T8mxKO0uA=
X-Google-Smtp-Source: ABdhPJyfLXCOd61Ph2/cBM4evWAEx0bqS9FKRm7joOPMaRaXSmvEIO1NXSG5Dzi3XtTMfKG5caw07YEl8Qa/wWQVAcU=
X-Received: by 2002:a0d:e005:0:b0:2d7:fb79:8f36 with SMTP id
 j5-20020a0de005000000b002d7fb798f36mr7297942ywe.404.1648153517687; Thu, 24
 Mar 2022 13:25:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:4707:b0:171:cd8f:b3d2 with HTTP; Thu, 24 Mar 2022
 13:25:17 -0700 (PDT)
In-Reply-To: <YjzMPymC3uXQUTrq@gmail.com>
References: <20220322191436.110963-1-Jason@zx2c4.com> <YjzMPymC3uXQUTrq@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Mar 2022 14:25:17 -0600
X-Gmail-Original-Message-ID: <CAHmME9p7k2Z2f3aYctHxV9oNwe_GKd62Sghh9Ck1-nRyPaEypA@mail.gmail.com>
Message-ID: <CAHmME9p7k2Z2f3aYctHxV9oNwe_GKd62Sghh9Ck1-nRyPaEypA@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>, Jann Horn <jannh@google.com>
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

On 3/24/22, Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Mar 22, 2022 at 01:14:36PM -0600, Jason A. Donenfeld wrote:
>> For as far back as I can tell, writing to /dev/urandom or /dev/random
>> will put entropy into the pool, but won't immediately use it, and won't
>> credit it either.
>
> Did you check kernels v4.7 and earlier?  It looks like this actually changed
> in
> v4.8 when the ChaCha20 CRNG was introduced.  v4.7 would mix the data written
> to
> /dev/{u,}random into {non,}blocking_pool, which would immediately be
> reflected
> in reads from /dev/{u,}random, sys_getrandom(), and get_random_bytes().
> Writes
> to /dev/{u,}random didn't affect the input_pool, which was separate.

Oh, I suppose you might be right, actually, that v4.7 and below would
hash the non blocking pool, and let /dev/urandom write directly into
it, as something distinct from the input pool. This changed with v4.8,
6 years ago, and now there are no LTS kernels that old, with most
small devices even having vendor kernels v4.9+. v4.8 apparently did
this while fixing a more extreme vulnerability of allowing
unprivileged users to bruteforce input bytes (in addition to allowing
unbounded unprivileged lock contention). Of those who have been
seeding via /dev/random, the ones who additionally issued the ioctl to
credit those bits haven't been affected since the crediting solved the
issue by invoking a reseeding. And those who didn't issue the ioctl
never had their RNG initialize in the first place, causing getrandom()
to block until entropy was collected from elsewhere, until it was
safe, so the harm there was minimal. So it's not great, but it's not
horrific either, and I still think the cons strongly outweigh the pros
in trying to change the behavior from what it is now.

Jason
