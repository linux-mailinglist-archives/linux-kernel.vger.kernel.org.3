Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896F14B3A52
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiBMIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 03:52:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 03:52:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC851132;
        Sun, 13 Feb 2022 00:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BFA25CE0A56;
        Sun, 13 Feb 2022 08:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32E2C004E1;
        Sun, 13 Feb 2022 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644742339;
        bh=B/EBfaegPNI+dBkInnAmuSfvhqk9AvrQYIlPmH2+oYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yd5zIkOM1+5Td2FmpGTYaf5RyVUT+Xe3TPCoH/trZBr9TcLCJtfF0zqcZYV4pEk63
         N51+cDMMr79fbYmAdGtaGmKdp29usUysCzdiWRH49bchaYX578GJ7IQySwKDSwyY0e
         XmclR3U19tqGoDQhH3f24zxgxA4c/E7eYxasYVT9sbJG0/1yHi8gbq8Ynucv84jE0F
         NaIBBYoR6wYOgnjuMvrJBWxubyYMj80PuHDbgtF26fvslB3ClRUoSSMqqGSYIY3nfy
         VwITjsMYj109w5e+PsaiJvqnMeqNGE73Trgmr8j8AY9ORb6GXgHcFDnKWF09JE6uIA
         5m7G0Qt4g3RYQ==
Date:   Sun, 13 Feb 2022 09:52:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Will Drewry <wad@chromium.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC] Get siginfo from unreaped task
Message-ID: <20220213085212.cwzuqlrabpgbnbac@wittgenstein>
References: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
 <CF5167CE-FA1C-4CEC-9EA8-5EE8041FE7C4@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CF5167CE-FA1C-4CEC-9EA8-5EE8041FE7C4@amacapital.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 06:32:08PM -0800, Andy Lutomirski wrote:
> 
> > On Feb 12, 2022, at 3:24 AM, Robert Święcki <robert@swiecki.net> wrote:
> > 
> > ﻿sob., 12 lut 2022 o 05:28 Kees Cook <keescook@chromium.org> napisał(a):
> >> 
> >> Make siginfo available through PTRACE_GETSIGINFO after process death,
> >> without needing to have already used PTRACE_ATTACH. Uses 48 more bytes
> >> in task_struct, though I bet there might be somewhere else we could
> >> stash a copy of it?
> > 
> > An alternative way of accessing this info could be abusing the
> > waitid() interface, with some additional, custom to Linux, flag
> > 
> > waitid(P_ALL, 0, &si, __WCHILDSIGINFO);
> > 
> > which would change what is put into si.
> > 
> > But maybe ptrace() is better, because it's mostly incompatible with
> > other OSes anyway on the behavior/flag level, while waitd() seems to
> > be POSIX/BSD standard, even if Linux specifies some additional flags.
> > 
> > 
> 
> I had a kind of opposite thought, which is that it would be very nice
> to be able to get all the waitid() data without reaping a process or
> even necessarily being its parent.  Maybe these can be combined?  A
> new waitid() option like you’re suggesting could add siginfo (and
> might need permissions).  And we could have a different waitid() flag
> that says “maybe not my child, don’t reap” (and also needs
> permissions).
> 
> Although the “don’t reap” thing is fundamentally racy. What a sane
> process manager actually wants is an interface to read all this info
> from a pidfd, which means it all needs to get stuck in struct pid. And

/me briefly pops out from vacation

Agreed and not just siginfo I would expect(?). We already came to that
conclusion when we first introduced them.

> task_struct needs a completion or wait queue so you can actually wait
> for a pidfd to exit (unless someone already did this — I had patches a
> while back).  And this would be awesome.

Currently, you can wait for a pidfd to exit via polling and you can use
a pidfd to pass it to waitid(P_PIDFD, pidfd, ...).

/me pops back into vacation
