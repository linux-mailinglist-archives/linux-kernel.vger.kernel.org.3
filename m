Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161E4FA0F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiDIBRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDIBRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59772615E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 18:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E672E621DC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 01:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F30C385A3;
        Sat,  9 Apr 2022 01:14:54 +0000 (UTC)
Date:   Fri, 8 Apr 2022 21:14:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220408211453.52d7c9a5@rorschach.local.home>
In-Reply-To: <CAHk-=wg6ZTjCoWev039ijHkzJGOE8v1Psc=yDANkt5r3GBxc0w@mail.gmail.com>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <87pmlrkgi3.ffs@tglx>
        <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
        <87v8vjiaih.ffs@tglx>
        <20220408202230.0ea5388f@rorschach.local.home>
        <CAHk-=wg3icnjr+6aU-Wyw+kBoSRBM28P4o4iTgimOWDuuUiStQ@mail.gmail.com>
        <20220408204925.16361b44@rorschach.local.home>
        <CAHk-=wg6ZTjCoWev039ijHkzJGOE8v1Psc=yDANkt5r3GBxc0w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 15:00:43 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Apr 8, 2022 at 2:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Hmm, well, I'm not sure it would work for all architectures, but what
> > about the MSB?  Setting it to zero on "shutdown"?  
> 
> Let's just clear the whole thing for now. We don't actually _have_ any
> timer_restart() cases yet.

OK, so this has gone toward the handling all sorts of situations tangent.

Thus, I want to get back to the current situation at hand. We have a
bunch of places that use del_timer(), and possibly del_timer_sync() but
can then have it rearm, and then the timer gets freed and BOOM we get a
crash in the timer code. Worse yet, we have no idea what timer it was
that did the UAF.

So, we could just add that "timer_shutdown()" function that clears the
function and mod_timer() would no longer rearm it. It would also need
to do the synchronization as well. Which means it can't be called with
locks that might be taken in the timer itself.

We can look into more elaborate APIs if we want to help fix other
issues later, but for now, it would be nice to go audit the kernel for
all locations that do a del_timer(_sync) followed by freeing the timer,
and replace it with a timer_shutdown() call.

For the del_timer() cases, we will have to make sure it's not done that
way due to locking. But they will still need to be dealt with because
they are still prone to UAF.

-- Steve
