Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617505740EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiGNBY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiGNBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:24:25 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA28205D6;
        Wed, 13 Jul 2022 18:24:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8827310E976F;
        Thu, 14 Jul 2022 11:24:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oBnaX-000bgE-9j; Thu, 14 Jul 2022 11:24:21 +1000
Date:   Thu, 14 Jul 2022 11:24:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  47a6df7cd3: Assertion_failed
Message-ID: <20220714012421.GO3861211@dread.disaster.area>
References: <Ys0gqOUcLr+2dle5@xsang-OptiPlex-9020>
 <20220712214745.GL3861211@dread.disaster.area>
 <Ys5lVZF3V53LQ+Ty@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys5lVZF3V53LQ+Ty@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62cf7048
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8
        a=Nusv4dcQFhBjhKgVRc0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:25:25PM +0800, Oliver Sang wrote:
> hi Dave,
> 
> On Wed, Jul 13, 2022 at 07:47:45AM +1000, Dave Chinner wrote:
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > > 
> > > [   94.271323][ T9089] XFS (sda5): Mounting V5 Filesystem
> > > [   94.369992][ T9089] XFS (sda5): Ending clean mount
> > > [   94.376046][ T9089] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
> > > [  112.154792][  T311] xfs/076       IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
> > > [  112.154805][  T311]
> > > [  161.426026][T29384] XFS: Assertion failed: xfs_is_shutdown(mp) || list_empty(&tp->t_dfops), file: fs/xfs/xfs_trans.c, line: 951
> > > [  161.437713][T29384] ------------[ cut here ]------------
> > > [  161.443155][T29384] kernel BUG at fs/xfs/xfs_message.c:110!
> > > [  161.448854][T29384] invalid opcode: 0000 [#1] SMP KASAN PTI
> > > [  161.454536][T29384] CPU: 1 PID: 29384 Comm: touch Not tainted 5.16.0-rc5-00001-g47a6df7cd317 #1
> > 
> > 5.16-rc5? Seems like a really old kernel to be testing....
> > 
> > Does this reproduce on a current 5.19-rc6 kernel?
> 
> yes, it's still reproducible. however, it's actually random on both 47a6df7cd3
> and 5.19-rc6, as below.
> it's clean on 40 runs of v5.16-rc5,
> on 47a6df7cd3, it's reproduced 9 times out of 40 runs,

Of course, 47a6df7cd3 introduced the ASSERT that is firing. You'll
never see the failure on kernels before this, even if the issue is
occurring. It also points out this isn't a new issue, it's been
around since before we added detection of it.

> on v5.19-rc6, it's reprodced 7 times out of 20 runs.

Hmmm. I've just run 50 iterations here on my 5.19-rc6 based VMs
and I haven't seen a single failure. So it's not failing regularly
here which means it is influenced by environmental factors.

How big are the disks you are testing with?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
