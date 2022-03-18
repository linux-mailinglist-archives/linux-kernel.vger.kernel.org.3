Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F87F4DD4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiCRGRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiCRGR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:17:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5D2B3D49
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647584168; x=1679120168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eqTcK21Pg5YOgEKX8Gi54DOK6hT4tSxuIyCswR9mBog=;
  b=XdLgOJ2U2k84gpwiR2bc6law4BRHh7r08Zljla+GdBLHuQVa0U7vn4kk
   Dz8As8eUE7ItHnSNQNloX27q/bB6g8se84hLZ1SORscMm/iXOhfgmWsm0
   IindX/yMueQqDIxgTQu+52jaThZ0d1b9LXITjY+Z0L5nRUp1kZY8etCJt
   ekrNY3i4JuUhMMOegOqVJVMAP45QGGnTraTpeQdV5BBfwVAA0jZiRbVG7
   IfTCvW/5cDddm0MQfTLwyyCsc6WXAExhhU1iBwlYVgvZIOThvqGZYpVyg
   qREnXHpP6mvpWAYxOkX8UGN52XFvt/FQOv1DKQTOOLcVR5tP1ZEJwfmfV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237008025"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="237008025"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:16:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="691196747"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:16:06 -0700
Date:   Fri, 18 Mar 2022 14:16:03 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [fixup! EXP srcu]  7bf8d644f8:
 WARNING:at_kernel/rcu/srcutree.c:#process_srcu
Message-ID: <20220318061603.GC12658@xsang-OptiPlex-9020>
References: <20220312155919.GD1189@xsang-OptiPlex-9020>
 <20220314203814.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220316165342.GA1931135@paulmck-ThinkPad-P17-Gen-1>
 <20220317071608.GB735@xsang-OptiPlex-9020>
 <20220317180129.GR4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317180129.GR4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Mar 17, 2022 at 11:01:29AM -0700, Paul E. McKenney wrote:
> On Thu, Mar 17, 2022 at 03:16:08PM +0800, Oliver Sang wrote:
> > hi, Paul,
> > 
> > On Wed, Mar 16, 2022 at 09:53:42AM -0700, Paul E. McKenney wrote:
> > > > 
> > > > I had a feeling that the simple fix wasn't going to cut it, so thank you
> > > > for finding a scenario that proves that to be the case.  Fix in progress,
> > > > to be folded into the original with attribution.
> > > 
> > > OK, the attribution isn't quite there yet, but the squished-together
> > > commit is here:
> > > 
> > > ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> > > 
> > > Does this version behave better for you?
> > 
> > we tested this commit, found the issue gone.
> > please be noted the issue on 7bf8d644f8 is random and ~25% rate.
> > so I queued to run 100 times for this new commit, which is finally clean
> > according to tests.
> > 
> > =========================================================================================
> > compiler/kconfig/rootfs/sleep/tbox_group/testcase:
> >   gcc-9/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/1/vm-snb/boot
> > 
> > commit:
> >   feebd043ec6b ("Revert "srcu: Avoid expedited GPs and blocking readers from consuming CPU"")
> >   7bf8d644f869 ("fixup! EXP srcu: Check for too many zero-delay srcu_reschedule() calls")
> >   ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> > 
> > feebd043ec6b9eab 7bf8d644f869260f63eaaedebab ea0098f191152c7fe3db5181a2e
> > ---------------- --------------------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
> >            |             |             |             |             |
> >            :16          25%           4:16           0%            :100   dmesg.RIP:process_srcu
> >            :16          25%           4:16           0%            :100   dmesg.WARNING:at_kernel/rcu/srcutree.c:#process_srcu
> 
> Thank you for testing this!  Tested-by?

sure!

Tested-by: kernel test robot <oliver.sang@intel.com>

(and will add this in early mail about testing if I have enough confidence
in the future :) Thanks)


> 							Thanx, Paul
