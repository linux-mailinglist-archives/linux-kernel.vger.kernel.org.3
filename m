Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6605728C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiGLVr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGLVrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:47:52 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFC65B0FB8;
        Tue, 12 Jul 2022 14:47:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E17C262C671;
        Wed, 13 Jul 2022 07:47:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oBNjN-0009ZB-QR; Wed, 13 Jul 2022 07:47:45 +1000
Date:   Wed, 13 Jul 2022 07:47:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  47a6df7cd3: Assertion_failed
Message-ID: <20220712214745.GL3861211@dread.disaster.area>
References: <Ys0gqOUcLr+2dle5@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys0gqOUcLr+2dle5@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62cdec06
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
        a=7-415B0cAAAA:8 a=YwEIx2iJiV63Uv_QZbwA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:20:08PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 47a6df7cd3174b91c6c862eae0b8d4e13591df52 ("xfs: shut down filesystem if we xfs_trans_cancel with deferred work items")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-c1144bf-1_20220704
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group-07
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
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   94.271323][ T9089] XFS (sda5): Mounting V5 Filesystem
> [   94.369992][ T9089] XFS (sda5): Ending clean mount
> [   94.376046][ T9089] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
> [  112.154792][  T311] xfs/076       IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
> [  112.154805][  T311]
> [  161.426026][T29384] XFS: Assertion failed: xfs_is_shutdown(mp) || list_empty(&tp->t_dfops), file: fs/xfs/xfs_trans.c, line: 951
> [  161.437713][T29384] ------------[ cut here ]------------
> [  161.443155][T29384] kernel BUG at fs/xfs/xfs_message.c:110!
> [  161.448854][T29384] invalid opcode: 0000 [#1] SMP KASAN PTI
> [  161.454536][T29384] CPU: 1 PID: 29384 Comm: touch Not tainted 5.16.0-rc5-00001-g47a6df7cd317 #1

5.16-rc5? Seems like a really old kernel to be testing....

Does this reproduce on a current 5.19-rc6 kernel?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
