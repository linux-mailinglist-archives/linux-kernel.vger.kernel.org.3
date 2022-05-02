Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9275176C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349221AbiEBSsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiEBSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:48:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46117630C;
        Mon,  2 May 2022 11:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08E7CB8189B;
        Mon,  2 May 2022 18:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F4AC385A4;
        Mon,  2 May 2022 18:45:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E0jTeuTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651517101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngT+dxmZ+phqFLY0ltuLJNhJ9ikGaeg4l5pQC/Bb7fA=;
        b=E0jTeuTlKkxy9lDYvmZlLhh0ekMEpwlLoSsKFlxExAx90L5v0gD4GqdGhWEqvfVbwZ1Opn
        ViqT5JADtiohu35kfe33IzWH0Q9g3x7yFeP5dp7lSp5YEALWCfyFzNO6GFtV3ege7zwYwY
        dSwcZvLkv0IhO+zLcCkdKh9fKxfg0Xc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 33445ff8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 18:45:00 +0000 (UTC)
Date:   Mon, 2 May 2022 20:44:52 +0200
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
Message-ID: <YnAmpDZZIQLbNkpi@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnAc4hwPyByF4kZ5@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Err...

On Mon, May 02, 2022 at 08:04:21PM +0200, Jason A. Donenfeld wrote:
> This doesn't work, because you could have memory-A split into memory-A.1
> and memory-A.2, and both A.2 and A.1 would ++counter, and wind up with
> the same new value "2". The solution is to instead have the hypervisor
> pass a unique value and a counter. We currently have a 16 byte unique
> value from the hypervisor, which I'm keeping as a kernel space secret
> for the RNG; we're waiting on a word-sized monotonic counter interface
> from hypervisors in the future. When we have the latter, then we can
> start talking about mmapable things. Your use case would probably be
> served by exposing that 16-byte unique value (hashed with some constant
> for safety I suppose), but I'm hesitant to start going down that route
> all at once, especially if we're to have a more useful counter in the
> future.

I kind of muddled things a bit by conflating two issues.

I'd like the hypervisor to provide a counter so that we can mmap it to
userspace so that userspace programs can do word-sized comparisons on
mmap'd counters, avoiding the race that currently exists from relying on
the async ACPI notification, which arrives after the system is already
up and running. That's one thing, but not what we're talking about here
with the MAC addresses.

The point over here is that neither the guest *nor* the hypervisor can
maintain a counter that actually represents something unique. A.1 and
A.2 will both ++counter to the same value in the example above. The
guest can't do it (neither in systemd nor in the kernel), because it
will always start with the same counter value of A and ++ it to the same
next value. The hypervisor can't do it either, because snapshots can be
shipped around to different computers that aren't coordinated.

So, put that way, the counter thing that I'd like wouldn't be for having
a unique snapshot ID, but just as a mmap-able way of learning when a
snapshot forks. It wouldn't be more useful than that.

If you want a unique ID, we have two options for that: the first is
exposing the vmgenid 16 byte value to userspace (which I don't want to
do). The second is just calling getrandom() after you get a poll()
notification, and that'll be guaranteed to be unique to that VM because
of the vmgenid driver in 5.18.

This last suggestion is thus what you should do for your MAC addresses.

Jason
