Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D000E4F1FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiDDXBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiDDXAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:00:33 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C1CA69712;
        Mon,  4 Apr 2022 15:16:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B6385534A83;
        Tue,  5 Apr 2022 08:16:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbUzV-00Dp8B-4K; Tue, 05 Apr 2022 08:16:05 +1000
Date:   Tue, 5 Apr 2022 08:16:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: Build regressions/improvements in v5.18-rc1
Message-ID: <20220404221605.GS1544202@dread.disaster.area>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <20220404092655.GR1544202@dread.disaster.area>
 <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
 <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=624b6e2a
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=tBb2bbeoAAAA:8 a=7-415B0cAAAA:8
        a=oQ5jPsdEZ40rj4-7sxsA:9 a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:45:05PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 4, 2022 at 12:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > >
> > > /kisskb/src/fs/xfs/./xfs_trace.h:432:2: note: in expansion of macro 'TP_printk'
> > >   TP_printk("dev %d:%d daddr 0x%llx bbcount 0x%x hold %d pincount %d "
> > >   ^
> > > /kisskb/src/fs/xfs/./xfs_trace.h:440:5: note: in expansion of macro '__print_flags'
> > >      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
> > >      ^
> > > /kisskb/src/fs/xfs/xfs_buf.h:67:4: note: in expansion of macro 'XBF_UNMAPPED'
> > >   { XBF_UNMAPPED,  "UNMAPPED" }
> > >     ^
> > > /kisskb/src/fs/xfs/./xfs_trace.h:440:40: note: in expansion of macro 'XFS_BUF_FLAGS'
> > >      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
> > >                                         ^
> > > /kisskb/src/fs/xfs/./xfs_trace.h: In function 'trace_raw_output_xfs_buf_flags_class':
> > > /kisskb/src/fs/xfs/xfs_buf.h:46:23: error: initializer element is not constant
> > >  #define XBF_UNMAPPED  (1 << 31)/* do not map the buffer */
> > >
> > > This doesn't make a whole lotta sense to me. It's blown up in a
> > > tracepoint macro in XFS that was not changed at all in 5.18-rc1, nor
> > > was any of the surrounding XFS code or contexts.  Perhaps something
> > > outside XFS changed to cause this on these platforms?
> >
> > Upon closer look, all builds showing this issue are using gcc-5...
> >
> > > Can you bisect this, please?
> >
> > Fortunately I still have gcc-5 installed on an older machine,
> > and I could reproduce the issue on amd64 with
> > "make allmodconfig fs/xfs/xfs_trace.o".
> >
> > Bisection points to commit e8c07082a810fbb9 ("Kbuild: move to
> > -std=gnu11").
> >
> > [1] gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1
> 
> Thanks for the report. I've produced it and can see that the problem
> is assigning
> the value of "(1 << 31)" to an 'unsigned long' struct member. Since this is
> a signed integer overflow, the result is technically undefined behavior,
> which gcc-5 does not accept as an integer constant.
> 
> The patch below fixes it for me, but I have not checked if there are any
> other instances. This could also be done using the 'BIT()' macro if the
> XFS maintainers prefer:

So XFS only uses these flags in unsigned int fields that are
typed via:

typedef unsigned int xfs_buf_flags_t;

So on the surface, declaring the flag values as ULONG and then writing
them into a UINT field is not a nice thing to be doing.

I really don't want to change the xfs_buf_flags_t type to an
unsigned long, because that changes the packing of the first
cacheline of the struct xfs_buf and the contents of that cacheline
are performance critical for the lookup fastpath....

Looking at __print_flags, the internal array type declaration is:

struct trace_print_flags {
        unsigned long           mask;
        const char              *name;
};

and that's the source of the problem.  I notice __print_flags_u64()
exists, but __print_flags_u32() does not. Should it?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
