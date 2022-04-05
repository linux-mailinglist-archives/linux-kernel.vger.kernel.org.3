Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7714F51EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848701AbiDFC14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355453AbiDEVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:25:07 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CD3B45781;
        Tue,  5 Apr 2022 14:05:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 192125343E2;
        Wed,  6 Apr 2022 07:05:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbqMT-00ECQO-OU; Wed, 06 Apr 2022 07:05:13 +1000
Date:   Wed, 6 Apr 2022 07:05:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: Build regressions/improvements in v5.18-rc1
Message-ID: <20220405210513.GX1544202@dread.disaster.area>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <20220404092655.GR1544202@dread.disaster.area>
 <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
 <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
 <20220404221605.GS1544202@dread.disaster.area>
 <CAMuHMdWak-zarKA_eCxWm5uhejWAXi0XkAuekfpAKRczLfhq3g@mail.gmail.com>
 <CAK8P3a1JArChbzRDFU0YPCy-7QZgqSoHe8JTH4g0yOz_Mi_MEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1JArChbzRDFU0YPCy-7QZgqSoHe8JTH4g0yOz_Mi_MEA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=624caf0e
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=tBb2bbeoAAAA:8 a=7-415B0cAAAA:8
        a=1b_iF-D28r213wdehakA:9 a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:08:13AM +0200, Arnd Bergmann wrote:
> ?On Tue, Apr 5, 2022 at 8:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Apr 5, 2022 at 12:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > > So XFS only uses these flags in unsigned int fields that are
> > > typed via:
> > >
> > > typedef unsigned int xfs_buf_flags_t;
> > >
> > > So on the surface, declaring the flag values as ULONG and then writing
> > > them into a UINT field is not a nice thing to be doing.
> > >
> > > I really don't want to change the xfs_buf_flags_t type to an
> > > unsigned long, because that changes the packing of the first
> > > cacheline of the struct xfs_buf and the contents of that cacheline
> > > are performance critical for the lookup fastpath....
> >
> > Hence just use "1u << n" instead of "1ul << n"?
> 
> Right, that avoids the error as well. I picked '1ul' to match the type of
> the variable it's assigned to, but as Dave said the intended type is
> 'u32', so '1u' is better here.

Ok, I'll queue up a patch to make this modification. I'll also need
to check all the other trace flags fields we print as well, as they
likely have the same issue but there's no warnings from them because
they don't use the high bit in the 32 bit field yet...

> > > Looking at __print_flags, the internal array type declaration is:
> > >
> > > struct trace_print_flags {
> > >         unsigned long           mask;
> > >         const char              *name;
> > > };
> > >
> > > and that's the source of the problem.  I notice __print_flags_u64()
> > > exists, but __print_flags_u32() does not. Should it?
> 
> It's not the source of the error, as there is no signed integer
> overflow when assigning an unsigned int to an unsigned long.

Thanks for the clarification!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
