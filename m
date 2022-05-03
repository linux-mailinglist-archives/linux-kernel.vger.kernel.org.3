Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4230D518111
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiECJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiECJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:36:02 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7BC289B7;
        Tue,  3 May 2022 02:32:29 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 434ACE804AA;
        Tue,  3 May 2022 11:32:27 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id B99BF160011; Tue,  3 May 2022 11:32:26 +0200 (CEST)
Date:   Tue, 3 May 2022 11:32:26 +0200
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
Message-ID: <YnD2qu8eVn5ix5H7@gardel-login>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
 <YnDc8A+oTxsQs/hq@gardel-login>
 <YnDxK/O2E6LUhP/2@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnDxK/O2E6LUhP/2@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 03.05.22 11:08, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> Hey Lennart,
>
> On Tue, May 03, 2022 at 09:42:40AM +0200, Lennart Poettering wrote:
> > For this MAC address usecase it's entirely sufficient to be able to
> > distinguish if the system was closed at all, i.e. if the counter is
> > zero or is non-zero. Because that would already be great for a policy
> > of "hash it in a stable way from /etc/machine-id, if counter == 0" +
> > "use random MAC once counter > 0".
>
> Hm, are you sure that's actually what you want? It turns out this
> vmgenid notification from the hypervisor might not be sufficiently
> granular for this use case:
>
> - vmgenid changes when you fork a new snapshot, so now you have two VMs
> - vmgenid also changes when you rewind to 2 minutes ago
>
> The first is what I assume you care about for this networkd business.
> The second is probably not what any networkd user expects.

So first of all, it appears to me that rewinding a VM is something people
would do for debugging things, i.e. not how things are done on
deployment.

> >From the perspective of randomness, both of these events imply the same
> thing. The situation is BAD; reseed immediately. From the perspective of
> MAC addresses, though, these events would imply different behavior,
> right? So it seems like vmgenid might need an additional field for this
> use case. Relatedly, VMware has that prompt where you select about your
> VM whether, "I moved it" or "I copied it." Presumably something like
> that would play a part in what is decided as part of this hypothetical
> second field.

networkd doesn't change MAC addresses in the middle of everything, but
only when a network interface is downed and upped again. This for
example happens when a link beat goes away and comes back. In the
rewind-2min case i'd assume the link beat would probably be restored
to what it was 2min ago (and thus stay online), but in the clone case
it would probably drop momentarily and be restored than, to tell
software to reacquire dhcp and so on.

or in other words: if the hypervisor wants the system to
reconfigure/reacquire its network there are explicit ways already, and
they work afaics. what's missing tehre is simply a reasonable way to
ensure that we won't end up sticking to the same fixed MAC address
when we set things up in order to acquire a new DHCP lease.

So I am not too concerned.

Lennart

--
Lennart Poettering, Berlin
