Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEAB518480
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiECMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiECMqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:46:34 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EF1CB05;
        Tue,  3 May 2022 05:43:01 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 068E7E804AA;
        Tue,  3 May 2022 14:43:00 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 89B62160062; Tue,  3 May 2022 14:42:59 +0200 (CEST)
Date:   Tue, 3 May 2022 14:42:59 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnEjU7+b/9K+HSow@gardel-login>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
 <YnDc8A+oTxsQs/hq@gardel-login>
 <YnDxK/O2E6LUhP/2@zx2c4.com>
 <YnD2qu8eVn5ix5H7@gardel-login>
 <YnD+17hDdbFBcaj5@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnD+17hDdbFBcaj5@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 03.05.22 12:07, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> I wouldn't be so sure here... Some people have processes around, "always
> start out from the same place", like for build machines, and employ a
> single VM snapshot that's always rewound after use. It's never forked
> into multiple snapshots, but just always goes back to that same starting
> point.

At sometimes it's futile phantasizing which exotic usecases people
might have.

> > > >From the perspective of randomness, both of these events imply the same
> > > thing. The situation is BAD; reseed immediately. From the perspective of
> > > MAC addresses, though, these events would imply different behavior,
> > > right? So it seems like vmgenid might need an additional field for this
> > > use case. Relatedly, VMware has that prompt where you select about your
> > > VM whether, "I moved it" or "I copied it." Presumably something like
> > > that would play a part in what is decided as part of this hypothetical
> > > second field.
> >
> > networkd doesn't change MAC addresses in the middle of everything, but
> > only when a network interface is downed and upped again. This for
> > example happens when a link beat goes away and comes back. In the
> > rewind-2min case i'd assume the link beat would probably be restored
> > to what it was 2min ago (and thus stay online), but in the clone case
> > it would probably drop momentarily and be restored than, to tell
> > software to reacquire dhcp and so on.
>
> That sounds like it's going to be sort of confusing. Let's say we've got
> some VM scenario in which rewinds are common due to whatever weird
> process (such as a build machine that wants to start out at the same
> place each time). During its course of execution, it reboots, or maybe
> there's some network connectivity issue and the link goes down. In that
> case, when the link comes up, it's going to have a different MAC
> address? That doesn't make much sense to me, but maybe I'm missing some
> bigger picture detail.

It's still better than sticking to the same MAC address for all clones
in all cases...

Dunno, in systemd the MAC address policies are configurable, for a
reason. We'll never find a default that really makes everyone
happy. Some people prefer the anonmymity of randomized MAC addresses,
others like the stability promises of hashed MAC addresses. We support
both policies. I think it would make sense to add a policy that says
"stable MAC until the first clone, then random" for example. In fact
I think it's a choice that has the chance of being a better default
than the current "always stable" approach we employ. So at the very
least we should have the option to come up with a policy taking vm
generations into account, it's a separate discussion to decide whether
to make it opt-in or the default then, and I doubt that part of the
discussion really matters here...

Lennart

--
Lennart Poettering, Berlin
