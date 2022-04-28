Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95267513DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352348AbiD1VfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351487AbiD1VfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:35:17 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89438A889C;
        Thu, 28 Apr 2022 14:32:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-32-1.pa.nsw.optusnet.com.au [49.180.32.1])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B72145345E5;
        Fri, 29 Apr 2022 07:31:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nkBjx-005hLq-LH; Fri, 29 Apr 2022 07:31:57 +1000
Date:   Fri, 29 Apr 2022 07:31:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] xfs: fixes for 5.18-rc5
Message-ID: <20220428213157.GT1098723@dread.disaster.area>
References: <20220428061921.GS1098723@dread.disaster.area>
 <CAHk-=wiVgPPczqyLyOg8fmGYc1z+-ngPKkS_bCTwefcLXfp4CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVgPPczqyLyOg8fmGYc1z+-ngPKkS_bCTwefcLXfp4CQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=626b07d0
        a=0Ysg4n7SwsYHWQMxibB6iw==:117 a=0Ysg4n7SwsYHWQMxibB6iw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=0XOVABRBHEpsqNIeq8QA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 09:46:14AM -0700, Linus Torvalds wrote:
> On Wed, Apr 27, 2022 at 11:19 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > It's all minor stuff;  a 5.18 build regession fix, a deadlock fix
> > and an update to remove redundant fields from the XFS entry in the
> > MAINTAINERS file.
> 
> Done.

Thanks!

> I had to look twice at that patch going "why does it complain about
> the xfs flags thing" until I realized it was due to XBF_UNMAPPED being
> (1 <<31) and the compiler then seeing explicit negative values being
> assigned.
> 
> We have a lot of "int flags" in various places, very much not just
> xfs, and yeah, we should probably try to clean them up.

Yup, I've already got a bunch of similar cleanup patches for
XFS ready for the next merge window.

> But 99% of the time it's just not worth the noise.

Mostly I agree, but in coverting another dozen+ sets of flags the
biggest benefit I've seen comes from the bit flag definitions all
having a consistent format across the code base.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
