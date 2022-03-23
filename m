Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0C4E4B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiCWCwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiCWCwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46B424BC;
        Tue, 22 Mar 2022 19:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 316DA614BB;
        Wed, 23 Mar 2022 02:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBD2C340EC;
        Wed, 23 Mar 2022 02:50:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="poRXks2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648003845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8lqUtskFi5/phmZS/7w/6wHcFNDZz88pVD3yzMOtmE=;
        b=poRXks2ZqAlyrhowVfj78TCEO1u+sqJoy64CvMmeiefhDY/RYqUQI8la451MQPYB5rw7uI
        k6qV2y/eT4I+bKlgVkJD8lpJX7mbwFdHR7f8pPOJ7t/ho4VL9sTYrKmmWLrGrAj3luRkg+
        s7WHiAYNOeCfxoX7SeBMix1m+FAPmhQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 434f7487 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Mar 2022 02:50:44 +0000 (UTC)
Date:   Tue, 22 Mar 2022 20:50:41 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <YjqLAWbZ8K7eg3Fw@zx2c4.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <6716f3ffefae4ed8b5fd332bfcca8a9a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6716f3ffefae4ed8b5fd332bfcca8a9a@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David (and Linus),

On Tue, Mar 22, 2022 at 8:16 PM David Laight <David.Laight@aculab.com> wrote:
> Never mind scripts that try to immediately save a new seedfile [1].
>
> What about code run by later startup scripts that wants random numbers.
> They really do want the seedfile data to be used.
> If it isn't used then they are likely to get very weak random numbers.
>
> You can't really expect startup scripts to be issuing ioctl requests.

To be clear, this "expect[ation]" of yours is very much a new
expectation. Crediting bits has required an ioctl since forever. Those
shell scripts have been broken forever. The proposal here is to add new
behavior to support those old broken shell scripts.

Fortunately, it seems sort of fixable. But only sort of. There are also
a lot of complications, as detailed above. Part of it is that some
people use /dev/urandom writes expecting it not to credit, while others
use that and then later manually credit it with the ioctl. Both of those
in general seem like not a very good interface for seeding the rng. The
correct interface to use is RNDADDENTROPY, which takes both the data and
whether it should be credited, since then the kernel knows what the
intentions are and can do something smart with it. Barring that
knowledge, we're in this vague middle ground where it's unclear what the
user intends to do.

"But I want my shell scripts to work, even if they have never worked,"
you fairly protest. I'll do my best here to figure something out, but
note that introducing sane behavior to /dev/urandom writes might imply
breaking compatibility with the behavior /dev/urandom writes have always
had in the past. So the "perfect" solution for a shell script seeding
interface might prove elusive, and we'll be left with something merely,
"not terrible."

However, if you do think you have a "perfect" solution that takes into
account all these concerns and doesn't break any prior contracts, please
do pipe up.

Two more thoughts, also for Linus' consideration:

- Had we not needed to revert the /dev/urandom + /dev/random unification
  patch, we wouldn't be facing this problem. So a last minute creative
  solution to save that effort would be quite welcome. I'm not
  optimistic about us finding that right away, but if a lightbulb goes
  off, I'd be quite happy.

- Since these seeding shell scripts have always been broken, because
  this is how the rng has always been, rather than trying to bolt on a
  very imperfect fix in the kernel for something that never worked
  right, we could suggest shell scripts take the path that I implemented
  for systemd:
  https://github.com/systemd/systemd/commit/da2862ef06f22fc8d31dafced6d2d6dc14f2ee0b
  In shell, this would look like:

    #!/bin/bash
    cat seedfile > /dev/urandom
    { cat seedfile; head -c 32 /dev/urandom; } | sha256sum | cut -d ' ' -f 1 > seedfile
 
  This seems better in nearly every way to trying to retroactively fix it
  in the kernel by changing the semantics of an extremely old interface.
  The more I think about it, the more I'm inclined to go with this "do
  nothing" approach. Open to hearing your thoughts though.

Jason
