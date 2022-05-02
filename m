Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809DB517689
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386868AbiEBSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244630AbiEBSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67082A18E;
        Mon,  2 May 2022 11:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BEE6B81993;
        Mon,  2 May 2022 18:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6768C385AC;
        Mon,  2 May 2022 18:29:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="km1BOBr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651516162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fT/ZO4MRn1mE8ke5ueoSvGQBtzZFvFBsQi3J5N7udw=;
        b=km1BOBr0xEObFETcqhHSD3EWsKWRp8drIkeVvTeEK4wOwvMermCN1T8ZZoACvTZ4vROQZ7
        88KoDEdLWozvbXmpfPbK4hJYNrec57hOOqGE4A6S0DkiSstKF20s5B1b0PNpK/dgYfwNxK
        kCX3y59fkLIP0A/20xQUT19gPBWDPjA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7171b4a8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 18:29:22 +0000 (UTC)
Date:   Mon, 2 May 2022 20:29:11 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnAiylnSytuYM53z@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
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

On Mon, May 02, 2022 at 07:59:08PM +0200, Alexander Graf wrote:
> to collect the use cases we all have and evaluate whether this patch is 
> a good stepping stone towards the final solution.

Indeed, I'm all for collecting use cases. What I meant to say is that
we're not going to add something "just 'cuz"; I'd like to have some
concrete things in mind.

To date, I've basically had your s2n case in mind, but as you haven't
responded to this in the last month, I started looking to see if this
was useful elsewhere or if I should abandon it, so I filed this issue
with the Go project: <https://github.com/golang/go/issues/52544>. We're
over halfway through 5.18 now, and only at this point have you arrived
to discuss and finalize things. So in all likelihood we'll wind up
tabling this until 5.20 or never, since what I thought was an easy
consensus before now apparently is not.

> 1) A way for libraries such as s2n to identify that a clone occurred. 
> Because it's a deep-down library with no access to its own thread or the 
> main loop, it can not rely on poll/select. Mmap of a file however would 
> work great, as you can create transactions on top of a 64bit mmap'ed 
> value for example.

I didn't realize that s2n can't poll. That's surprising. In the worst
case, can't you just spawn a thread?

> 2) A way to notify larger applications (think Java here) that a system 
> is going to be suspended soon so it can wipe PII before it gets cloned 
> for example.

Suspension, like S3 power notification stuff? Talk to Rafael about that;
this isn't related to the VM fork issue. I use those PM notifiers
happily in kernel space but AFAICT, there's still no userspace thing for
it. This seems orthogonal to this conversation though, so let's not veer
off into that topic.

If you didn't mean S3 but actually meant notification prior to snapshot
taking, we don't have any virtual hardware for that, so it's a moot
point.

> 3) Notifications after clone so applications know they can regenerate VM 
> unique data based on randomness.

You mean this as "the same as (1) but with poll() instead of mmap()",
right?

> Lennart, looking at the current sysctl proposal, systemd could poll() on 
> the fork file. It would then be able to generate a /run/fork-id file 
> which it can use for the flow above, right?

For the reasons I gave in my last email to Lennart, I don't think
there's a good way for systemd to generate a fork-id file on its own
either. I don't think systemd should really be involved here as a
provider of values, just as a potential consumer of what the kernel
provides.

> The sysctl proposal also gives us 3, if we implement the inhibitor 
> proposal [1] in systemd.

These userspace components you're proposing seem like a lot of
overengineering for little gain, which is why this conversation went
nowhere when Amazon attempted all this year. But it sounds like you
agree with me based on your remark below about systemd-less interfaces
provided by the kernel.

> Overall, it sounds to me like the sysctl poll based kernel interface in 
> this patch in combination with systemd inhibitors gives us an answer to 
> most of the flows above.
> 
> I can see attractiveness in providing the /run/fork-id directly from the 
> kernel though, to remove the dependency on systemd for poll-less 
> notification of libraries.
>
> Jason, how much complexity would it add to provide an mmap() and read() 
> interface to a fork counter value to the sysctl? Read sounds like a 
> trivial change on top of what you have already, mmap a bit more heavy 
> lift. If we had both, it would allow us to implement a Linux standard 
> fork detect path in libraries that does not rely on systemd.

mmap() does not give us anything if we're not going to expose the raw
ACPI-mapped ID directly. It will still be a racy mechanism until we do
that. So I think we should wait until there's a proper vmgenid
word-sized counter to expose something mmap()able. If you have the
energy to talk to Microsoft about this and make it happen, please be my
guest. As I wrote at the beginning of this email. I haven't gotten a
response from you at all about this stuff in quite some time, so I'm not
really itching take that on alone now.

Jason
