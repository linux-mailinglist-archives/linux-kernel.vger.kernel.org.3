Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B45B2B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIIBFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIIBFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4006C105
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 815F861DBB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0E2C433D6;
        Fri,  9 Sep 2022 01:05:05 +0000 (UTC)
Date:   Thu, 8 Sep 2022 21:05:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220908210503.6e96e36d@rorschach.local.home>
In-Reply-To: <YxqPZ4Yfus+an0Lg@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <YxDWlgulBijTzj3y@kroah.com>
        <YxEy8mTO1nZ1sxHV@google.com>
        <YxGYepQlLZTE84HB@kroah.com>
        <YxqF0bWoJPK4KFHb@google.com>
        <20220908204332.0cbd850c@gandalf.local.home>
        <YxqPZ4Yfus+an0Lg@google.com>
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

On Thu, 8 Sep 2022 17:57:11 -0700
Brian Norris <briannorris@chromium.org> wrote:

> On Thu, Sep 08, 2022 at 08:43:32PM -0400, Steven Rostedt wrote:
> > On Thu, 8 Sep 2022 17:16:17 -0700
> > Instead of doing an LTP test, could you just write a script that could test
> > it in the kernel selftests?
> > 
> > See tools/testing/selftests/...
> > 
> > in the kernel repository.  
> 
> I honestly don't know why both LTP and kselftests exist. But I *did*

Well, LTP started off great, but then became overwhelming, and would
fail on a lot that I didn't care about. Then we started the kernel
selftests which is suppose to be small unit tests where tests get added
along with new features. And because the tests are in the kernel tree,
they get added together. That was one of the issues with LTP, it was
harder to coordinate what tests went with which kernel.

I have not run LTP in years, but run selftests weekly.

> specifically ask about LTP and got a "yes" from both you and Greg.

I was just saying "yes" to testing, I must have overlooked that you
mentioned LTP. All I saw was "testing" and thought "Yes!" ;-)

> 
> I suppose I can go back and remove all the LTP niceties that I just
> added to my bare script (setup, cleanup, clean handling of individual
> test cases, unified reporting stats; does selftests have any of
> that?)... But that'll have to be next week, if I can find the time at
> all.

Nah, you did the work, and it doesn't hurt to have it in LTP too. I may
no longer use LTP, but I'm sure there are a lot of others that do.

> 
> > If you create a tracefs one, it could go into the ftrace directory.  
> 
> Since the tests cases are so similar, my current script tests both
> debugfs and tracefs. So I probably won't create two separate buckets for
> this.

If you have a script that tests both, I'm happy to add it in the ftrace
selftests.

Sorry for the confusion.

-- Steve
