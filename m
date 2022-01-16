Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB20248FA9C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 05:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiAPD70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 22:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiAPD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 22:59:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 19:59:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593B460C6C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 03:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D903EC36AE9;
        Sun, 16 Jan 2022 03:59:21 +0000 (UTC)
Date:   Sat, 15 Jan 2022 22:59:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        llvm@lists.linux.dev
Subject: Re: [for-next][PATCH 10/31] scripts: ftrace - move the
 sort-processing in ftrace_init
Message-ID: <20220115225920.0e5939aa@gandalf.local.home>
In-Reply-To: <YeMwNEfNaGErFthk@archlinux-ax161>
References: <20220111173030.999527342@goodmis.org>
        <20220111173115.079437896@goodmis.org>
        <YeMwNEfNaGErFthk@archlinux-ax161>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 13:36:04 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Steven and Yinan,
> 
> On Tue, Jan 11, 2022 at 12:30:41PM -0500, Steven Rostedt wrote:
> > From: Yinan Liu <yinan@linux.alibaba.com>
> > 
> > When the kernel starts, the initialization of ftrace takes
> > up a portion of the time (approximately 6~8ms) to sort mcount
> > addresses. We can save this time by moving mcount-sorting to
> > compile time.
> > 
> > Link: https://lkml.kernel.org/r/20211212113358.34208-2-yinan@linux.alibaba.com
> > 
> > Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> 
> This change as commit 72b3942a173c ("scripts: ftrace - move the
> sort-processing in ftrace_init") in -next causes a bunch of warnings at
> the beginning of the build when using clang as the host compiler:
> 


> 
> Should mcount_sort_thread be zero initialized or is there something else
> going on here? I am currently hunting down a bunch of other regressions
> so apologies for just the report rather than a patch to fix it.

Can this really happen? We have:

        if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
                fprintf(stderr,
                        "pthread_create mcount_sort_thread failed '%s': %s\n",
                        strerror(errno), fname);
                goto out;
        }
[..]

        if (mcount_sort_thread) {
                void *retval = NULL;
                /* wait for mcount sort done */
                rc = pthread_join(mcount_sort_thread, &retval);
                if (rc) {
                        fprintf(stderr,
                                "pthread_join failed '%s': %s\n",
                                strerror(errno), fname);
                } else if (retval) {
                        rc = -1;
                        fprintf(stderr,
                                "failed to sort mcount '%s': %s\n",
                                (char *)retval, fname);
                }
        }

Shouldn't the pthread_create() initialize it? And I'm not even sure if we
need that if statement?

Or is there a path to get there without pthread_create() initializing it?

-- Steve

