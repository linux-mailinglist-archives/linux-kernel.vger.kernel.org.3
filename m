Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5D48FA9F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 05:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiAPEKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 23:10:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43086 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiAPEKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 23:10:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25A0FCE0B6D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D064C36AE3;
        Sun, 16 Jan 2022 04:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642306243;
        bh=nYYJymzK0ORvrcLSkNfDIC0dMacCVTMv4xlMVpNGGaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRB8opdqda5gkgfZqYFzA1K+zrdynf4o4Z55i1zRhvm9bY8ATH/G95DRwIFt8M53O
         QXzAH+XUjtzhMcazooaZJZkQ9R8/a/D4s2ceXYi7J69+PYbAKafwXfW/it7RIGmTya
         SnExWlGzM1YCWNzCqbxd5x1swGgrPxI2k6wZrtVM71fOSUWbCNOZ+OjGzlS7EYD45K
         DhD2dR9GeClWaEUUrz2UnEY9e8djaMnRQSEBOZQjZb+hk/GvjiagGtq4Qc+2g7dygs
         0QgOLXZtZZZOsSchmZQAEAnx77gHDWrD68ROugg3e42+Og57Dh9lOBM1BWGa585e6b
         BkxymCc70JJrA==
Date:   Sat, 15 Jan 2022 21:10:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        llvm@lists.linux.dev
Subject: Re: [for-next][PATCH 10/31] scripts: ftrace - move the
 sort-processing in ftrace_init
Message-ID: <YeOavpztGp7bCB5Q@archlinux-ax161>
References: <20220111173030.999527342@goodmis.org>
 <20220111173115.079437896@goodmis.org>
 <YeMwNEfNaGErFthk@archlinux-ax161>
 <20220115225920.0e5939aa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115225920.0e5939aa@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 10:59:20PM -0500, Steven Rostedt wrote:
> On Sat, 15 Jan 2022 13:36:04 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Hi Steven and Yinan,
> > 
> > On Tue, Jan 11, 2022 at 12:30:41PM -0500, Steven Rostedt wrote:
> > > From: Yinan Liu <yinan@linux.alibaba.com>
> > > 
> > > When the kernel starts, the initialization of ftrace takes
> > > up a portion of the time (approximately 6~8ms) to sort mcount
> > > addresses. We can save this time by moving mcount-sorting to
> > > compile time.
> > > 
> > > Link: https://lkml.kernel.org/r/20211212113358.34208-2-yinan@linux.alibaba.com
> > > 
> > > Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> > 
> > This change as commit 72b3942a173c ("scripts: ftrace - move the
> > sort-processing in ftrace_init") in -next causes a bunch of warnings at
> > the beginning of the build when using clang as the host compiler:
> > 
> 
> 
> > 
> > Should mcount_sort_thread be zero initialized or is there something else
> > going on here? I am currently hunting down a bunch of other regressions
> > so apologies for just the report rather than a patch to fix it.
> 
> Can this really happen? We have:

The way the code is written now, yes.

>         if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
>                 fprintf(stderr,
>                         "pthread_create mcount_sort_thread failed '%s': %s\n",
>                         strerror(errno), fname);
>                 goto out;
>         }
> [..]
> 
>         if (mcount_sort_thread) {
>                 void *retval = NULL;
>                 /* wait for mcount sort done */
>                 rc = pthread_join(mcount_sort_thread, &retval);
>                 if (rc) {
>                         fprintf(stderr,
>                                 "pthread_join failed '%s': %s\n",
>                                 strerror(errno), fname);
>                 } else if (retval) {
>                         rc = -1;
>                         fprintf(stderr,
>                                 "failed to sort mcount '%s': %s\n",
>                                 (char *)retval, fname);
>                 }
>         }
> 
> Shouldn't the pthread_create() initialize it? And I'm not even sure if we
> need that if statement?
> 
> Or is there a path to get there without pthread_create() initializing it?

Yes. If the if statment right above the pthread_create() call triggers,
we jump to the out label, which hits the if (mcount_sort_thread), and
mcount_sort_thread won't be initialized.

	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
		fprintf(stderr,
			"incomplete mcount's sort in file: %s\n",
			fname);
		goto out;
	}

	if (pthread_create(&mcount_sort_thread, ...)) {
...

out:
...
	if (mcount_sort_thread) {

If I am misunderstanding something, please let me know.

Cheers,
Nathan
