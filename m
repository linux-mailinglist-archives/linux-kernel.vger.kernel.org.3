Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9454E4B86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiCWDhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiCWDhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:37:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FFB7087E;
        Tue, 22 Mar 2022 20:35:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22N3ZN3u001577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 23:35:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D2EF915C0038; Tue, 22 Mar 2022 23:35:22 -0400 (EDT)
Date:   Tue, 22 Mar 2022 23:35:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <YjqVemCkZCU1pOzj@mit.edu>
References: <20220322191436.110963-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322191436.110963-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:14:36PM -0600, Jason A. Donenfeld wrote:
> So this patch fixes the issue by including /dev/urandom writes as part
> of the "fast init", but not crediting it as part of the fast init
> counter. This is more or less exactly what's already done for
> kernel-sourced entropy whose quality we don't know, when we use
> add_device_randomness(), which both contributes to the input pool and to
> the fast init key.

One of the big issues with /dev/urandom writes is that *anyone*,
including malicious user space, can force specific bytes to be mixed
in.  That's the source of the reluctance to immediate use inputs from
writes into /dev/[u]random until there is a chance for it to be mixed
in with other entropy which is hopefully not under the control of
malicious userspace.

Now, I recognize that things are a bit special in early boot, and if
we have a malicious script running in a systemd unit script, we might
as well go home.  But something to consider is whether we want to do
soemthing special if the process writing to /dev/[u]random has
CAP_SYS_ADMIN, or some such.

> There is one caveat to consider, which is what happens if the user
> additionally calls RNDADDTOENTCNT after having written to /dev/urandom,
> expecting to credit that write. That might give way to this pathological
> pattern:

Yeah, no one should ever ver ever be using RNDADDTOENTCNT.  It's an
ioctl which requires root privilegs, and if it breaks, you get to keep
both pieces.

> The better interface for userspace is RNDADDENTROPY, which takes the
> input buffer and the entropy credit all at once, so we can make the
> right decision. For the RNDADDENTROPY, we do not take part in fast init
> if entropy is being credited.
> 
> And perhaps we might consider attempting to deprecate RNDADDTOENTCNT at
> some point in the future.

That would be a good idea.  :-)

						- Ted
