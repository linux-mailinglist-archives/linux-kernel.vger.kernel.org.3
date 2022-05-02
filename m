Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FFC517505
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbiEBQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiEBQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:54:52 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437436245;
        Mon,  2 May 2022 09:51:22 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id A92E1E804AA;
        Mon,  2 May 2022 18:51:19 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 50F04160011; Mon,  2 May 2022 18:51:19 +0200 (CEST)
Date:   Mon, 2 May 2022 18:51:19 +0200
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
Message-ID: <YnAMBzhcJhGR5XOK@gardel-login>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnAC00VtU8MGb7vO@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 02.05.22 18:12, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> > > In order to inform userspace of virtual machine forks, this commit adds
> > > a "fork_event" sysctl, which does not return any data, but allows
> > > userspace processes to poll() on it for notification of VM forks.
> > >
> > > It avoids exposing the actual vmgenid from the hypervisor to userspace,
> > > in case there is any randomness value in keeping it secret. Rather,
> > > userspace is expected to simply use getrandom() if it wants a fresh
> > > value.
> >
> > Wouldn't it make sense to expose a monotonic 64bit counter of detected
> > VM forks since boot through read()? It might be interesting to know
> > for userspace how many forks it missed the fork events for. Moreover it
> > might be interesting to userspace to know if any fork happened so far
> > *at* *all*, by checking if the counter is non-zero.
>
> "Might be interesting" is different from "definitely useful". I'm not
> going to add this without a clear use case. This feature is pretty
> narrowly scoped in its objectives right now, and I intend to keep it
> that way if possible.

Sure, whatever. I mean, if you think it's preferable to have 3 API
abstractions for the same concept each for it's special usecase, then
that's certainly one way to do things. I personally would try to
figure out a modicum of generalization for things like this. But maybe
that' just me…

I can just tell you, that in systemd we'd have a usecase for consuming
such a generation counter: we try to provide stable MAC addresses for
synthetic network interfaces managed by networkd, so we hash them from
/etc/machine-id, but otoh people also want them to change when they
clone their VMs. We could very nicely solve this if we had a
generation counter easily accessible from userspace, that starts at 0
initially. Because then we can hash as we always did when the counter
is zero, but otherwise use something else, possibly hashed from the
generation counter.

But anyway, I understand you are not interested in
generalization/other usecases, so I'll shut up.

Lennart

--
Lennart Poettering, Berlin
