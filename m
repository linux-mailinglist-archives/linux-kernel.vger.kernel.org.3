Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64A358E2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiHIWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiHIWFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:19 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ABB8A8;
        Tue,  9 Aug 2022 15:05:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2C7A110E85DA;
        Wed, 10 Aug 2022 08:05:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oLXLb-00BCHm-Hu; Wed, 10 Aug 2022 08:05:11 +1000
Date:   Wed, 10 Aug 2022 08:05:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fs/xfs: Use atomic64_try_cmpxchg in
 xlog_grant_{add,sub}_space
Message-ID: <20220809220511.GI3600936@dread.disaster.area>
References: <20220809165615.9694-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809165615.9694-1-ubizjak@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62f2da19
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=qgxBokI5hthhnRxBgHsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 06:56:15PM +0200, Uros Bizjak wrote:
> Use `!atomic64_try_cmpxchg(ptr, &old, new)` instead of
> `atomic64_cmpxchg(ptr, old, new) != old` in xlog_grant_{add,sub}_space.
> This has two benefits:
> 
> - The x86 cmpxchg instruction returns success in the ZF flag, so this
>   change saves a compare after cmpxchg, as well as a related move
>   instruction in the front of cmpxchg.
> 
> - atomic64_try_cmpxchg implicitly assigns the *ptr value to &old when
>   cmpxchg fails, enabling further code simplifications.

Do the two cmpxchg operations have the same memory ordering
semantics on failure?

> This patch has no functional change.

The patch looks ok, but ....

... I'm about 2 hours away from posting a patchset that completely
removes the cmpxchg and the new grant head accounting has
significantly lower fast path overhead. It also opens the door for
tracking more than 2GB of log space in the grant heads.

So I don't think we need to be micro-optimising this code given that
there are much bigger perf gains about to land...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
