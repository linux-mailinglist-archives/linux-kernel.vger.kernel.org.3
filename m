Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325154EEA9E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbiDAJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbiDAJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE5102424
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE046167F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC24C2BBE4;
        Fri,  1 Apr 2022 09:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648806151;
        bh=8MK1etsxuL825Aji7CJDLK+CCyk819YFJzs+mMzML+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcupHnPxni/fpScxSsbonvIh30ygh4OsbpX6+WOdxX6QU5tF/3/QnEhPo7Blgm79F
         qt7ZcVwrvX+xSIWRSOa2z2gio6eSwtv+v9IJFuZqgoouOL/or8pxtdrisUzOZkVfIk
         nWRkVjUn5M6NGxjKUo/CockFf9tQhz/MlZh7lWN36ZeC4Mj7jQC1G0le33tZYc5A7W
         2pEIjaFh/Ln+abH9YaFA3j0+Fe6MpPs214pXSmYuEpkUmAd6d+ukB7/n5SK2S4oHy8
         NN5yuJQ2+DnxWKrsQ+ygsNUNSPAcOYY6uhvS1TgJSIS2yIP3s6FwJOU3Nbk8ILAXQw
         wnGoMo4lKP/9w==
Date:   Fri, 1 Apr 2022 11:42:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alois Wohlschlager <alwoju@gmx.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Allow creation of pidfds to threads
Message-ID: <20220401094225.epianrz3afrhfrqp@wittgenstein>
References: <3412128.IC5jYiYEAv@genesis>
 <20220401070942.odjbuc5wecfayyok@wittgenstein>
 <5392366.5i5WIIk9Ns@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5392366.5i5WIIk9Ns@genesis>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:00:27AM +0200, Alois Wohlschlager wrote:
> Hello Christian,
> 
> > We originally blocked this because it is not as easy as simply allowing
> > pidfds to be created for non-thread-group leaders.
> > For a start, pidfd_poll() currently doens't work if pidfd_task() isn't a
> > thread-group leader
> 
> I did notice the hang there, that's why my patch changes pidfd_poll to return
> error on tasks which are not thread-group leaders. IIRC, waiting on specific
> threads is not supported by Linux at all, so I don't see a problem with not
> supporting it here either.

In general, it would be quite neat if we could get notified about thread
exit through poll though. That'd be pretty useful. But maybe it's indeed
ok to just not support this (for now at least).

I know that systemd is using pidfds in their event loop so I'd need to
see whether they'd want support for this behavior.

> 
> > and you'll just hang for CLONE_PIDFD | CLONE_THREAD.
> 
> No, CLONE_PIDFD | CLONE_THREAD behavior is unchanged, it will still fail with
> EINVAL. I actually confirmed this by double-checking right now.

I just used the two flags as a shorthand for pidfds referring to
threads. That might've been misleading here.

> 
> > So at least that needs to be adapated as well and there's likely a bunch
> > of other corner-cases I'm forgetting about.
> 
> I'd be happy to hear about other corner-cases so I can fix them.

I need to play with this patch a little and see what current
expectations we do have in the code.

There are various consumers of pidfds and they all have been added with
the assumption that a pidfd refers to a thread-group leader. We should
go through them and see whether changing them to operate on threads is
sane before we can just switch the generic helper.

Bot process_madvise() and process_mrelease() should be fine to operate
on threads afaict from the discussion when they were added.

For pidfd_send_signal() we likely want to at least consider adding the
ability to send a thread-specific signal, i.e. supporting tgkill()
behavior. As it stands it currently only supports kill()-like behavior
where the signal that gets sent is thread-group directed.

I roughly had originally envisioned this to be supportable through the
addition of a new flag to pidfd_send_signal() so callers would be able
to select whether to send a thread-specific signal or not. What do
people think of that?

> 
> > Do you have a concrete use-case you want this for?
> 
> My use-case is basically making pidfd_getfd actually useful for its intended
> purpose: there is a seccomp_unotify-based supervisor that wants to obtain a
> file descriptor from its guest. This currently does not work if the action to
> be forwarded to the supervisor is performed in a secondary thread, since there
> is no way to obtain the required pidfd.

Yeah, I'm well aware of that. I've been working around this limitation
in our implementation for the seccomp notifier for quite a long time
when intercepting the bpf()-syscall.
