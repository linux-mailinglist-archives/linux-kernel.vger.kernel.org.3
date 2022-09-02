Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4730D5AA75C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiIBFpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBFpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA74A132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C587861FC9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DADC433D6;
        Fri,  2 Sep 2022 05:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662097534;
        bh=C7tV2XoRZugY9Jp39eiSNu4b8iV+v2WndlYbNXd66TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLjRs0RI4MSHV6C67otnhJjN013ru2/gY/ufaSEKGmG3lrgSmjxtZrhplc0zE6nHk
         Ym0ECns81YqnN6RiF+E6MKWeGOVZwFsFsaTCXbipSE5wgtSXe0OGxC6Dcx+EAgQv/i
         SSzcs67aKUmSWr4nedVTIpVUXe+xNtlijoDyfses=
Date:   Fri, 2 Sep 2022 07:45:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <YxGYepQlLZTE84HB@kroah.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
 <YxDWlgulBijTzj3y@kroah.com>
 <YxEy8mTO1nZ1sxHV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxEy8mTO1nZ1sxHV@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:32:18PM -0700, Brian Norris wrote:
> On Thu, Sep 01, 2022 at 05:58:14PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Aug 26, 2022 at 05:44:16PM -0700, Brian Norris wrote:
> > > Users may have explicitly configured their debugfs permissions; we
> > > shouldn't overwrite those just because a second mount appeared.
> > 
> > What userspace mounts debugfs twice?
> 
> I'll admit, my particular userspace in question (Chrom{e,ium}OS) does
> not. There are several debugfs mounts, but they are bind mounts, which
> don't hit this problem.
> 
> But Steven hits the nail on the head for most of my reasoning; my main
> motivation is for tracefs (patch 2), whose automount makes this very
> surprising. I included patch 1 for consistency (tracefs essentially
> copy/pasted debugfs). I could drop patch 1 if that helps somehow, but
> I'd still like to consider the automount difficulties in patch 2.
> 
> > > Only clobber if the options were provided at mount time.
> > > 
> > >   # Don't change /sys/kernel/debug/ permissions.
> > >   mount -t debugfs none /mnt/foo
> > > 
> > >   # Change /sys/kernel/debug/ mode and uid, but not gid.
> > >   mount -t debugfs -o uid=bar,mode=0750 none /mnt/baz
> > 
> > So what happens today with this change?  Without it?
> 
> Sorry, this was probably a bit too implied -- the gid changes to its
> default (0 if we never set it in a mount option before; or it will reset
> to any previous gid= mount setting).
> 
> # ls -ld /sys/kernel/debug/.
> drwxr-x---. 45 root debugfs-access 0 Dec 31  1969 /sys/kernel/debug/.
> # chown root:power /sys/kernel/debug/
> # ls -ld /sys/kernel/debug/.
> drwxr-x---. 45 root power 0 Dec 31  1969 /sys/kernel/debug/.
> # mount -t debugfs -o uid=power,mode=0750 none /tmp/mnt
> # ls -ld /sys/kernel/debug/.
> drwxr-x---. 45 power debugfs-access 0 Dec 31  1969 /sys/kernel/debug/.
> # mount | grep '\/sys\/kernel\/debug '
> debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime,seclabel,uid=228,gid=605,mode=750)
> 
> I can include more before/after examples in the commit message if you
> want. Honestly, that's kind of why I offered to write test cases; test
> cases show what's happening better than narrative descriptions.

before/after in the changelog comments are very good, thanks.  And yes,
tests are also good, I'd gladly take that too if you do a v2 of this
patch.

And make it independant of the tracefs change please, these would go
through two different trees as they have different maintainers.

thanks,

greg k-h
