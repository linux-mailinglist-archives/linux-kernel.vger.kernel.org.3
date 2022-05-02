Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82195177A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349643AbiEBUHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiEBUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A08BC3F;
        Mon,  2 May 2022 13:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C769A614E3;
        Mon,  2 May 2022 20:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031AFC385A4;
        Mon,  2 May 2022 20:03:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RVNBaSAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651521807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQ49h26zaKpjAUeQljwnaf9r3WN1R89i6oAXsSSE18I=;
        b=RVNBaSANisHa5WiEuHDWzCrh7+tIA5oziEIdE9Hnu+ePF6XkfSXz3BP+8XeZOXaKwtD9zT
        Uln1eQ8xX2GZTh8XhaCo+crluZ+3GSK09mG1vAdxUSbPXVsvUzT2jf198pEHM9Y4AGLRl+
        9Mv5NubEd32GzzAi46uWjGnm/+ZW7mc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a578e43 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 20:03:26 +0000 (UTC)
Date:   Mon, 2 May 2022 22:03:21 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnA5CUJKvqmXJxf2@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
 <YnAiylnSytuYM53z@zx2c4.com>
 <f90d5e06-8cd7-14b3-43d5-c4799597d023@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f90d5e06-8cd7-14b3-43d5-c4799597d023@amazon.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Mon, May 02, 2022 at 08:57:01PM +0200, Alexander Graf wrote:
> So far I see little that would block your patch? It seems to go into a 
> good direction from all I can tell.

With kernel code for the kernel, if it's good enough, it's good enough,
and can be made better later. With kernel code for userspace, it might
not be possible to make it better later, so if we've got a plethora of
options, it makes the incrementalism I was enthusiastic about a little
bit more risky.

Here's where we're at:

- /proc/sys has this easy to use poll() interface [which currently breaks
  normal poll() semantics; see patch 1/2]. It'd be nice to use this as
  an async notifier interface.

- A race-free mmap()d mechanism needs virtual hardware support to be
  useful, so I don't want to add it now. But when we do have it, where
  should it be added?

  * Atop the same /proc/sys file that this patch has returning -ENODATA
    at the moment? /proc/sys doesn't do mmap now so that'd be some
    plumbing work, which would be pretty odd for the sysctl abstraction.

  * Atop some new file elsewhere? Not hard to do, but also begs the
    question of which driver should do it, where the file should be, and
    a whole host of bikesheddy questions.

  * In the VDSO? This would make the most sense to me if we're ever
    going to do a VDSO RNG, and to design it along with the userspace
    RNG stuff people think they want, even if it's maybe not the best
    idea in the end. This is a huge can of worms. Termites, even, and
    they'll eat through the beams of your house.

  * Nowhere, because even though this race-free mechanism is attractive,
    it's way too hard to program for, and nobody is going to use it, and
    not many people care /that/ much about having this mechanism being
    100% race-free. Colm said Amazon doesn't, for example, since it uses
    quiescent states. And apparently Microsoft doesn't care much either,
    and they don't even use quiescent states. Maybe I'm the only one
    raising a fuss about the race window (while hypocritically also not
    being very eager to write code around an interface that has to check
    a variable all the time).

- A file in /proc/sys can return -ENODATA, as this patch has it doing,
  or it can return something else:

  * A counter. Flawed for reasons discussed elsewhere.

  * A UUID, just like /proc/sys/kernel/random/boot_id, except we'd name
    it generation_id or something and it'd change on VM fork. An earlier
    version of this patch did that.

  * -ENODATA, as this patch does, because each caller can get a new unique
    value with getrandom(), as there's no point in having some global
    identifier like with boot_id. This is what I'm leaning toward. It
    seems like getrandom() would handle Lennart's case, Go's case, s2n's
    case, and we don't need a particular ID.

  * The direct value of the ACPI vmgenid value. Discussed in earlier
    emails; I don't want to do this.

- You don't care about race-free, but you do care about mmap(), for
  "programming reasons" in s2n. I'm not yet sympathetic to this case
  :-P. The point of mmap() should be for the race-free stuff. Otherwise
  poll() should do the job, and if you can't poll, you can hack around
  it with another process or a thread or whatever other trick. Your
  systemd proposal with a file was just punting the idea elsewhere in
  userspace (which I think is a bit ugly too...).

This state of affairs inclines me to:

- Have a /proc/sys/kernel/random/fork_event that has a poll() interface
  with reads returning -ENODATA (this patch).

- Try to convince whomever that poll()ing on fork_event and then calling
  getrandom() for a process-local snapshot ID is better than poll()ing
  on and subsequently read()ing a /proc/sys/kernel/random/generation_id
  that returns a global UUID like boot_id. [Lennart - I'm specifically
  interested in trying to convince you of this. Thoughts?]

- Given that you are okay with an async mechanism, figure out how poll()
  can work for s2n rather than mmap().

- Not really pursue the race-free mmap() thing unless Microsoft goes
  full steam ahead with it because it's complicated to program for and
  maybe (or maybe not? I don't know? data please?) a theoretical
  concern.
 
> You block the thread on poll, so the only option is a thread. I was 
> until now always under the working assumption that we can't do this in a 
> thread because you don't want your single threaded application to turn 
> into a pthreaded one, but you make me wonder. Let me check with Torben 
> tomorrow.

Can't you use raw clone() and just have a super dirty thread that shares
a single page mapping and nothing else? Poll on the pidfd of the parent
and the fork_event fd, quit on the former, and ++ on the latter.

> >> 2) A way to notify larger applications (think Java here) that a system
> >> is going to be suspended soon so it can wipe PII before it gets cloned
> >> for example.
> > Suspension, like S3 power notification stuff? Talk to Rafael about that;
> 
> 
> Whether you go running -> S3 -> clone or you go running -> paused -> 
> clone is an implementation detail I'm not terribly worried about. Users 
> can do either, because on both cases the VM is in paused state.

Ahh, I see.
https://lore.kernel.org/lkml/20220501123849.3858-1-Jason@zx2c4.com/
might interest you.

Jason
