Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6251764E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244613AbiEBSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiEBSJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:09:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A6824F;
        Mon,  2 May 2022 11:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8452DB81995;
        Mon,  2 May 2022 18:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2319FC385A4;
        Mon,  2 May 2022 18:05:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="foTQPk/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651514748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctDsXsKXvAtZj691w4iWAEq9RykXl3vWrD9DktFiGVY=;
        b=foTQPk/HYdy167gL1/7PpthZ+BJtH/emMh3g9JqQsWiye7suZmTFXAoDLqutHT6ZJS/cmq
        n1ko2twM3MeT/jcKNO+Qqhe4jHuDdqxZpg2p1UYkHrOQjVwGqqHvGEKBgUrL71G69WYM/B
        GbP1nSXoT0ngZedfSfHzrFNIuVPyIH8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83a2e9c6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 18:05:45 +0000 (UTC)
Date:   Mon, 2 May 2022 20:04:21 +0200
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
Message-ID: <YnAc4hwPyByF4kZ5@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnAMBzhcJhGR5XOK@gardel-login>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lennart,

On Mon, May 02, 2022 at 06:51:19PM +0200, Lennart Poettering wrote:
> On Mo, 02.05.22 18:12, Jason A. Donenfeld (Jason@zx2c4.com) wrote:
> 
> > > > In order to inform userspace of virtual machine forks, this commit adds
> > > > a "fork_event" sysctl, which does not return any data, but allows
> > > > userspace processes to poll() on it for notification of VM forks.
> > > >
> > > > It avoids exposing the actual vmgenid from the hypervisor to userspace,
> > > > in case there is any randomness value in keeping it secret. Rather,
> > > > userspace is expected to simply use getrandom() if it wants a fresh
> > > > value.
> > >
> > > Wouldn't it make sense to expose a monotonic 64bit counter of detected
> > > VM forks since boot through read()? It might be interesting to know
> > > for userspace how many forks it missed the fork events for. Moreover it
> > > might be interesting to userspace to know if any fork happened so far
> > > *at* *all*, by checking if the counter is non-zero.
> >
> > "Might be interesting" is different from "definitely useful". I'm not
> > going to add this without a clear use case. This feature is pretty
> > narrowly scoped in its objectives right now, and I intend to keep it
> > that way if possible.
> 
> Sure, whatever. I mean, if you think it's preferable to have 3 API
> abstractions for the same concept each for it's special usecase, then
> that's certainly one way to do things. I personally would try to
> figure out a modicum of generalization for things like this. But maybe
> that' just me…
> 
> I can just tell you, that in systemd we'd have a usecase for consuming
> such a generation counter: we try to provide stable MAC addresses for
> synthetic network interfaces managed by networkd, so we hash them from
> /etc/machine-id, but otoh people also want them to change when they
> clone their VMs. We could very nicely solve this if we had a
> generation counter easily accessible from userspace, that starts at 0
> initially. Because then we can hash as we always did when the counter
> is zero, but otherwise use something else, possibly hashed from the
> generation counter.

This doesn't work, because you could have memory-A split into memory-A.1
and memory-A.2, and both A.2 and A.1 would ++counter, and wind up with
the same new value "2". The solution is to instead have the hypervisor
pass a unique value and a counter. We currently have a 16 byte unique
value from the hypervisor, which I'm keeping as a kernel space secret
for the RNG; we're waiting on a word-sized monotonic counter interface
from hypervisors in the future. When we have the latter, then we can
start talking about mmapable things. Your use case would probably be
served by exposing that 16-byte unique value (hashed with some constant
for safety I suppose), but I'm hesitant to start going down that route
all at once, especially if we're to have a more useful counter in the
future.

Jason
