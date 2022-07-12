Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1C3572944
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiGLWZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiGLWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:24:59 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 951C29E47C;
        Tue, 12 Jul 2022 15:24:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7C7FA62C731;
        Wed, 13 Jul 2022 08:24:57 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oBOJK-000A9E-NE; Wed, 13 Jul 2022 08:24:54 +1000
Date:   Wed, 13 Jul 2022 08:24:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, lkp@lists.01.org
Subject: Re: [xfs]  65cf4eb83e: xfstests.xfs.011.fail
Message-ID: <20220712222454.GN3861211@dread.disaster.area>
References: <20220708015558.1134330-9-david@fromorbit.com>
 <Ys0wxcjQa7ehVuXz@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys0wxcjQa7ehVuXz@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62cdf4b9
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=QyXUC8HyAAAA:8 a=LhnTwE4SJcGP-2LhAFgA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:28:53PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 65cf4eb83e2179b565c7943fd685ddb93d2b146a ("[PATCH 8/8] xfs: grant heads track byte counts, not LSNs")
> url: https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/xfs-byte-base-grant-head-reservation-tracking/20220708-095642
> base: https://git.kernel.org/cgit/fs/xfs/xfs-linux.git for-next
> patch link: https://lore.kernel.org/linux-xfs/20220708015558.1134330-9-david@fromorbit.com
> 
> in testcase: xfstests
> version: xfstests-x86_64-c1144bf-1_20220704
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group-01
> 	ucode: 0x21
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> xfs/011       - output mismatch (see /lkp/benchmarks/xfstests/results//xfs/011.out.bad)
>     --- tests/xfs/011.out	2022-07-04 16:34:35.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/011.out.bad	2022-07-11 12:33:58.535910570 +0000
>     @@ -1,2 +1,14 @@
>      QA output created by 011
>      Silence is golden.
>     +reserve_grant_head (4096:) does not match log_head_lsn (1:8192), possible leak detected.
>     +write_grant_head (4096:) does not match log_head_lsn (1:8192), possible leak detected.
>     +reserve_grant_head (4096:) does not match log_head_lsn (1:446464), possible leak detected.
>     +write_grant_head (4096:) does not match log_head_lsn (1:446464), possible leak detected.
>     +reserve_grant_head (4096:) does not match log_head_lsn (1:991232), possible leak detected.

Yes, this commit changes the structure of the write and reserve
grant heads and the output of the relevant sysfs files, so the test
will need fixing (or removing) as the leak detection debug
information has changed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
