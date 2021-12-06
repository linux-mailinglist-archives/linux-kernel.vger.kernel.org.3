Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1EC46A8E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349949AbhLFVBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:01:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:62128 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349927AbhLFVBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:01:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="234919413"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="234919413"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 12:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="611377349"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2021 12:57:50 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B6KvnGS024029;
        Mon, 6 Dec 2021 20:57:49 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] numa: mark __next_node() as __always_inline to fix section mismatch
Date:   Mon,  6 Dec 2021 21:57:24 +0100
Message-Id: <CAKwvOdnoxaHHYMN-=fW6-W_bN+VrWvD32cidGa7qnYHmR=k2YA@mail.gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 6 Dec 2021 11:43:47 -0800

> On Mon, Dec 6, 2021 at 8:19 AM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> >
> > Clang (13) uninlines __next_node() which emits the following warning
> > due to that this function is used in init code (amd_numa_init(),
> > sched_init_numa() etc.):
> >
> > WARNING: modpost: vmlinux.o(.text+0x927ee): Section mismatch
> > in reference from the function __next_node() to the variable
> > .init.data:numa_nodes_parsed
> > The function __next_node() references
> > the variable __initdata numa_nodes_parsed.
> > This is often because __next_node lacks a __initdata
> > annotation or the annotation of numa_nodes_parsed is wrong.
> >
> > Mark __next_node() as __always_inline() so it won't get uninlined.
> > bloat-o-meter over x86_64 binaries says this:
> >
> > scripts/bloat-o-meter -c vmlinux.baseline vmlinux
> > add/remove: 1/1 grow/shrink: 2/7 up/down: 446/-2166 (-1720)
> > Function                                     old     new   delta
> > apply_wqattrs_cleanup                          -     410    +410
> > amd_numa_init                                814     842     +28
> > sched_init_numa                             1338    1346      +8
> > find_next_bit                                 38      19     -19
> > __next_node                                   45       -     -45
> > apply_wqattrs_prepare                       1069     799    -270
> > wq_nice_store                                688     414    -274
> > wq_numa_store                                805     433    -372
> > wq_cpumask_store                             789     402    -387
> > apply_workqueue_attrs                        538     147    -391
> > workqueue_set_unbound_cpumask                947     539    -408
> > Total: Before=14422603, After=14420883, chg -0.01%
> >
> > So it's both win-win in terms of resolving section mismatch and
> > saving some text size (-1.7 Kb is quite nice).
> >
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> 
> Thanks for the patch.  See this thread:
> https://github.com/ClangBuiltLinux/linux/issues/1302
> 
> There's a lot more instances of these based on config.  Something like
> https://github.com/ClangBuiltLinux/linux/issues/1302#issuecomment-807260475
> would be more appropriate for fixing all instances, but I think this
> is more so an issue with the inline cost model in LLVM.
> 
> I need to finish off https://reviews.llvm.org/D111456, and request
> that https://reviews.llvm.org/D111272 which landed in clang-14 get
> backported to the 13.0.1 release which should also help.

Oh I see. Sorry for redundant posting, non-applicable then.
We'll wait for these Clang/LLVM works to be finised, thanks!

> 
> > ---
> >  include/linux/nodemask.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> > index 567c3ddba2c4..55ba2c56f39b 100644
> > --- a/include/linux/nodemask.h
> > +++ b/include/linux/nodemask.h
> > @@ -266,7 +266,7 @@ static inline int __first_node(const nodemask_t *srcp)
> >  }
> >
> >  #define next_node(n, src) __next_node((n), &(src))
> > -static inline int __next_node(int n, const nodemask_t *srcp)
> > +static __always_inline int __next_node(int n, const nodemask_t *srcp)
> >  {
> >         return min_t(int,MAX_NUMNODES,find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
> >  }
> > --
> > 2.33.1
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

Al
