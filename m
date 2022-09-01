Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1715A9CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiIAQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiIAQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:10:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2B33E0A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 801F2B82868
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC415C433D6;
        Thu,  1 Sep 2022 16:10:38 +0000 (UTC)
Date:   Thu, 1 Sep 2022 12:11:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220901121109.2a71d779@gandalf.local.home>
In-Reply-To: <YxDWlgulBijTzj3y@kroah.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <YxDWlgulBijTzj3y@kroah.com>
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

On Thu, 1 Sep 2022 17:58:14 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Aug 26, 2022 at 05:44:16PM -0700, Brian Norris wrote:
> > Users may have explicitly configured their debugfs permissions; we
> > shouldn't overwrite those just because a second mount appeared.  
> 
> What userspace mounts debugfs twice?
> 
> > Only clobber if the options were provided at mount time.
> > 
> >   # Don't change /sys/kernel/debug/ permissions.
> >   mount -t debugfs none /mnt/foo
> > 
> >   # Change /sys/kernel/debug/ mode and uid, but not gid.
> >   mount -t debugfs -o uid=bar,mode=0750 none /mnt/baz  
> 
> So what happens today with this change?  Without it?
> 
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > I'm open to writing an LTP test case for this, if that seems like a good
> > idea.  
> 
> If it's really needed, again, why would debugfs be ever mounted more
> than once?
>

The real issue is with tracefs, and I think the debugfs patch is just for
consistency. But I (and others) do have debugfs mounted more that once. ;-)

  # mount |grep debugfs
  debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
  debugfs on /debug type debugfs (rw,relatime)

I added /debug (and I know others that just add /d) for shortcuts to get to
the debugfs directory easier.

This patch series came about because ideally tracefs should be mounted in
/sys/kernel/tracing. But because a lot of scripts use the old path of
/sys/kernel/debug/tracing, I have tracefs mounted there automatically
when debugfs is mounted. This is so that scripts do not break.

I would love to deprecate the /sys/kernel/debug/tracing automatic mounting,
but I do not know what user space will break if that happens. libtracefs
handles finding where tracefs is, so anything that uses that is fine.

But anyway, because tracefs is mounted more than once, if someone has
tracefs mounted in the correct location "/sys/kernel/tracing" and updates
the permissions to the files, but then mounts debugfs, due to the automatic
mounting, all their changes go away.

Perhaps we only need the second patch because of the automatic mounting.
Maybe people do not care if things get reset if they manually mount debugfs
more than once. I (and others) have it in my fstab, so it's done at boot up
and any changes should affect both.

-- Steve
