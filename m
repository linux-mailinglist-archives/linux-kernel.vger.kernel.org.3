Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B7509CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388021AbiDUJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387984AbiDUJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:57:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F283DF98;
        Thu, 21 Apr 2022 02:55:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3AD711F748;
        Thu, 21 Apr 2022 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650534900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMrQB8Mg6VKJYObqAvv9nuVQ8BrTb7/yb5RzzVbXM7Y=;
        b=G40LNoD3gBMlHBEsNDKoq/6Oq/g0SlkYZV73W0xvZQE1eWRGhEW0QAikzYvEJafzth6L/f
        X0EoFGAizGC2hXIVWEW7XVFJz5JgPJGrg8RAf5ZzyaJpYB98iyxWp79DMOczk9edacNc6J
        kZTS0et16KBC5Uuah/PvhaqjlanqNzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650534900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMrQB8Mg6VKJYObqAvv9nuVQ8BrTb7/yb5RzzVbXM7Y=;
        b=QhliLrVy5IuCYIEAoFyqO7AU0uWiNDURI5tVdsz1bcke8wRdm5QMNaWd/jG6f8tw/MEy6j
        MAjIkbXQNVUhVhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28F6913A84;
        Thu, 21 Apr 2022 09:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DDIgCfQpYWJ9UAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 21 Apr 2022 09:55:00 +0000
Date:   Thu, 21 Apr 2022 11:57:16 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Spencer Baugh <sbaugh@catern.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcin@juszkiewicz.com.pl, torvalds@linux-foundation.org,
        arnd@arndb.de
Subject: Re: Explicitly defining the userspace API
Message-ID: <YmEqfFdYN0Rml6V2@yuki>
References: <874k2nhgtg.fsf@catern.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k2nhgtg.fsf@catern.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Linux guarantees the stability of its userspace API, but the API
> itself is only informally described, primarily with English prose.  I
> want to add an explicit, authoritative machine-readable definition of
> the Linux userspace API.

My background is in kernel testing I do maintain the Linux Test Project
for more than a decade now. During the years we did create many "unit
tests" for kernel syscalls that are watching over the syscall API and
making sure that we get right results for both valid and invalid inputs.
These tests can also be considered to be a form of a documentation. The
same goes for some of the selftests that have been added to kernel repo
in the recent years. In a sense these are the most detailed descriptions
of the interfaces we have.

The main problem is that the kernel userspace boundary is large, we have
thousands of tests and I'm pretty sure that we don't cover even half of
it.

Also some of the interfaces are too complex to be even described in any
formal system, mostly the modern stuff such as io_uring or bfp. I have
had hard time even understading how to use these and I doubt I would be
even able to build a formal system to describe them. Especially since
the io_uring is mostly syscall less and we talk to the kernel by shared
buffers and atomic data updates.

> As background, in a conventional libc like glibc, read(2) calls the
> Linux system call read, passing arguments in an architecture-specific
> way according to the specific details of read.
> 
> The details of these syscalls are at best documented in manpages, and
> often defined only by the implementation.  Anyone else who wants to
> work with a syscall, in any way, needs to duplicate all those details.
> 
> So the most basic definition of the API would just represent the
> information already present in SYSCALL_DEFINE macros: the C types of
> arguments and return values.  More usefully, it would describe the
> formats of those arguments and return values: that the first argument
> to read is a file descriptor rather than an arbitrary integer, and
> what flags are valid in the flags argument of openat, and that open
> returns a file descriptor.  A step beyond that would be describing, in
> some limited way, the effects of syscalls; for example, that read
> writes into the passed buffer the number of bytes that it returned.

Having this would be awesome, this is just one step from actually
generating automated tests for the syscalls. However my estimate is that
even if you started to work on this now it will take decade to get
somewhere, but maybe I'm too pesimistic.

Stil fingers crossed.

-- 
Cyril Hrubis
chrubis@suse.cz
