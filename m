Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67358E37C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiHIXCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHIXCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:02:49 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A59167C80;
        Tue,  9 Aug 2022 16:02:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 527B762D44C;
        Wed, 10 Aug 2022 09:02:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oLYFI-00BDH8-PC; Wed, 10 Aug 2022 09:02:44 +1000
Date:   Wed, 10 Aug 2022 09:02:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fs/xfs: Use atomic64_try_cmpxchg in
 xlog_grant_{add,sub}_space
Message-ID: <20220809230244.GJ3600936@dread.disaster.area>
References: <20220809165615.9694-1-ubizjak@gmail.com>
 <20220809220511.GI3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809220511.GI3600936@dread.disaster.area>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62f2e797
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=8C0a8iNh18_4KdS3VZMA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 08:05:11AM +1000, Dave Chinner wrote:
> On Tue, Aug 09, 2022 at 06:56:15PM +0200, Uros Bizjak wrote:
> > Use `!atomic64_try_cmpxchg(ptr, &old, new)` instead of
> > `atomic64_cmpxchg(ptr, old, new) != old` in xlog_grant_{add,sub}_space.
> > This has two benefits:
> > 
> > - The x86 cmpxchg instruction returns success in the ZF flag, so this
> >   change saves a compare after cmpxchg, as well as a related move
> >   instruction in the front of cmpxchg.
> > 
> > - atomic64_try_cmpxchg implicitly assigns the *ptr value to &old when
> >   cmpxchg fails, enabling further code simplifications.
> 
> Do the two cmpxchg operations have the same memory ordering
> semantics on failure?
> 
> > This patch has no functional change.
> 
> The patch looks ok, but ....
> 
> ... I'm about 2 hours away from posting a patchset that completely
> removes the cmpxchg and the new grant head accounting has
> significantly lower fast path overhead. It also opens the door for
> tracking more than 2GB of log space in the grant heads.

FYI, the original RFC for this was posted a bit over a month ago:

https://lore.kernel.org/linux-xfs/20220708015558.1134330-1-david@fromorbit.com/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
