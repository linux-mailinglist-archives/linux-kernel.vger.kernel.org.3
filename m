Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6990751820E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiECKK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiECKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA02FFF4;
        Tue,  3 May 2022 03:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 039246153D;
        Tue,  3 May 2022 10:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52930C385A4;
        Tue,  3 May 2022 10:07:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lVTSwIln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651572441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7UxGkhXCJlG8WWWYKGGbJamcKRqHIIV1otkdn0vx7dc=;
        b=lVTSwIln0eZsCJOrDzFsfCm6362bPxr4P58KLzBSMf41S+3f2ZU5B1LwnEeZPG13aO/FfZ
        MpLM6/dg407ibxPULxM00VJU0L0gTOud0e7B6LB77J8jkBTHb0xgjYi8ewH1K5UbIfzoV7
        QtHdpcbMvWo+BLMMK1bALU+6kCPRLT4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c11e06fb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 3 May 2022 10:07:21 +0000 (UTC)
Date:   Tue, 3 May 2022 12:07:19 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnD+17hDdbFBcaj5@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
 <YnDc8A+oTxsQs/hq@gardel-login>
 <YnDxK/O2E6LUhP/2@zx2c4.com>
 <YnD2qu8eVn5ix5H7@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnD2qu8eVn5ix5H7@gardel-login>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 11:32:26AM +0200, Lennart Poettering wrote:
> So first of all, it appears to me that rewinding a VM is something people
> would do for debugging things, i.e. not how things are done on
> deployment.

I wouldn't be so sure here... Some people have processes around, "always
start out from the same place", like for build machines, and employ a
single VM snapshot that's always rewound after use. It's never forked
into multiple snapshots, but just always goes back to that same starting
point.

> > >From the perspective of randomness, both of these events imply the same
> > thing. The situation is BAD; reseed immediately. From the perspective of
> > MAC addresses, though, these events would imply different behavior,
> > right? So it seems like vmgenid might need an additional field for this
> > use case. Relatedly, VMware has that prompt where you select about your
> > VM whether, "I moved it" or "I copied it." Presumably something like
> > that would play a part in what is decided as part of this hypothetical
> > second field.
> 
> networkd doesn't change MAC addresses in the middle of everything, but
> only when a network interface is downed and upped again. This for
> example happens when a link beat goes away and comes back. In the
> rewind-2min case i'd assume the link beat would probably be restored
> to what it was 2min ago (and thus stay online), but in the clone case
> it would probably drop momentarily and be restored than, to tell
> software to reacquire dhcp and so on.

That sounds like it's going to be sort of confusing. Let's say we've got
some VM scenario in which rewinds are common due to whatever weird
process (such as a build machine that wants to start out at the same
place each time). During its course of execution, it reboots, or maybe
there's some network connectivity issue and the link goes down. In that
case, when the link comes up, it's going to have a different MAC
address? That doesn't make much sense to me, but maybe I'm missing some
bigger picture detail.

Jason
