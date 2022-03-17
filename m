Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CF4DC007
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiCQHRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCQHR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:17:29 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359BB1868BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647501373; x=1679037373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VMuPTzjUtfWWz+ZHfaPYTTyjUsRiOTqgMlVmWqJJSg4=;
  b=XmjD+9sfRf4DxA/SQUlWq+5efo9tAW9UtsnzIHL/tkJiGcJIAEmwz6r0
   p8i9kNRU6G30xPQSDJsH5YtIR2fSLK9YxUERUg//zmmn5wocoMivr6p1w
   13jIaXbTxbR9I8uKS0qW1Dp62apaq+0hk8KsCYGvRTOVh1RG9PQtvIcsJ
   Y3iKMXEnu89szzHrK+2innLFPHzXMgefJmfRcyCuDm1JtQb4KDBU+9M+j
   ZUSUjnCnrA2PR3DO/XYQibxBEdOYQdsOP1PzFLJcpLiQHA3jhcGyhmvWE
   8xV5wr74zJeQ77uzUHVhDi8HnDevKyf/1OFYQcsWB4qgYg8N8HgI1n4x6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317519879"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="317519879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 00:16:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="557813131"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 00:16:11 -0700
Date:   Thu, 17 Mar 2022 15:16:08 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [fixup! EXP srcu]  7bf8d644f8:
 WARNING:at_kernel/rcu/srcutree.c:#process_srcu
Message-ID: <20220317071608.GB735@xsang-OptiPlex-9020>
References: <20220312155919.GD1189@xsang-OptiPlex-9020>
 <20220314203814.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220316165342.GA1931135@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316165342.GA1931135@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Paul,

On Wed, Mar 16, 2022 at 09:53:42AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 14, 2022 at 01:38:14PM -0700, Paul E. McKenney wrote:
> > On Sat, Mar 12, 2022 at 11:59:19PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: 7bf8d644f869260f63eaaedebabdd2054f59ecc4 ("fixup! EXP srcu: Check for too many zero-delay srcu_reschedule() calls")
> > > https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.03.01a
> > > 
> > > in testcase: boot
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > > 
> > > [ 27.088275][ T42] WARNING: CPU: 1 PID: 42 at kernel/rcu/srcutree.c:1555 process_srcu (kernel/rcu/srcutree.c:1555 (discriminator 3)) 
> > > [   27.089252][   T42] Modules linked in: libata(+) serio_raw i2c_piix4 parport_pc(+) parport ip_tables
> > > [   27.090253][   T42] CPU: 1 PID: 42 Comm: kworker/1:1 Not tainted 5.17.0-rc1-00191-g7bf8d644f869 #1
> > > [   27.091212][   T42] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > > [   27.092176][   T42] Workqueue: rcu_gp process_srcu
> > > [ 27.092718][ T42] RIP: 0010:process_srcu (kernel/rcu/srcutree.c:1555 (discriminator 3)) 
> > > [ 27.093653][ T42] Code: 6b f8 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 91 02 00 00 48 8b 43 f8 31 f6 48 83 f8 32 0f 86 02 fe ff ff <0f> 0b e9 fb fd ff ff 4c 8d b3 58 ff ff ff 48 b8 00 00 00 00 00 fc
> > 
> > I had a feeling that the simple fix wasn't going to cut it, so thank you
> > for finding a scenario that proves that to be the case.  Fix in progress,
> > to be folded into the original with attribution.
> 
> OK, the attribution isn't quite there yet, but the squished-together
> commit is here:
> 
> ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> 
> Does this version behave better for you?

we tested this commit, found the issue gone.
please be noted the issue on 7bf8d644f8 is random and ~25% rate.
so I queued to run 100 times for this new commit, which is finally clean
according to tests.

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-9/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/1/vm-snb/boot

commit:
  feebd043ec6b ("Revert "srcu: Avoid expedited GPs and blocking readers from consuming CPU"")
  7bf8d644f869 ("fixup! EXP srcu: Check for too many zero-delay srcu_reschedule() calls")
  ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")

feebd043ec6b9eab 7bf8d644f869260f63eaaedebab ea0098f191152c7fe3db5181a2e
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :16          25%           4:16           0%            :100   dmesg.RIP:process_srcu
           :16          25%           4:16           0%            :100   dmesg.WARNING:at_kernel/rcu/srcutree.c:#process_srcu


> 
> 							Thanx, Paul
> 
