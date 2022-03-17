Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D54DBBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbiCQArk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbiCQArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:47:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF301CFD2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647477979; x=1679013979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2maoY5dDuJR6w79Y8GuUi000TKhwHyElOgz3d8GtASY=;
  b=FqmgtVoPqWsjaeC9hnZni+YEGg/guzQdnLrQy8H8L6rtYLbXych/a4q4
   GoOySeNW0bEh5b6rLdQ6TWb5xNxs1Kjcjc3N9sx8cXOZ3XOjOwyAobvQE
   w7cgYsM7ALIE83FxhbkNGRcvWpQwF/VAwNYOP/K8Fj/lN+ZAOC8q1trI9
   jG4VAlMviY6nKJjF0I5BrI6FFGV+l82126SScwPMWqVH21mt8AFOhLCjr
   g1N12VHJwVusZYNooZfCVGlaCqC/+2Ht3O2jgfO+anzvT+ocWODx29UHz
   wf9ToML8DVGVprUlE6bZr8WOyvJ4kcpEI0NFuTUMYilCVZ4BxD+FYC7QY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255579601"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255579601"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:46:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="714837139"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:46:04 -0700
Date:   Thu, 17 Mar 2022 08:45:56 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [rcu]  758cf1496b: BUG:spinlock_bad_magic_on_CPU
Message-ID: <20220317004556.GA32394@xsang-OptiPlex-9020>
References: <20220314055057.GC24245@xsang-OptiPlex-9020>
 <20220314140653.GR4285@paulmck-ThinkPad-P17-Gen-1>
 <20220316061628.GA19825@xsang-OptiPlex-9020>
 <20220316170437.GJ4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316170437.GJ4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Paul,

On Wed, Mar 16, 2022 at 10:04:37AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 16, 2022 at 02:16:28PM +0800, Oliver Sang wrote:
> > hi, Paul,
> > 
> > On Mon, Mar 14, 2022 at 07:06:53AM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 14, 2022 at 01:50:57PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed the following commit (built with gcc-9):
> > > > 
> > > > commit: 758cf1496b94442c47c339b10d80cbaadf613425 ("rcu: Make UP-vacuous normal grace period advance sequence")
> > > > https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.03.09a
> > > > 
> > > > in testcase: boot
> > > > 
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu Icelake-Server -smp 4 -m 16G
> > > > 
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > 
> > > > 
> > > > +--------------------------------------+------------+------------+
> > > > |                                      | 6129c2b2dc | 758cf1496b |
> > > > +--------------------------------------+------------+------------+
> > > > | BUG:spinlock_bad_magic_on_CPU        | 0          | 16         |
> > > > | WARNING:at_init/main.c:#start_kernel | 0          | 16         |
> > > > | RIP:start_kernel                     | 0          | 16         |
> > > > +--------------------------------------+------------+------------+
> > > > 
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > > Does this fix it for you?
> > > 
> > > 67792d475181 ("fixup! rcu: Make UP-vacuous normal grace period advance sequence")
> > 
> > yes, this fixed:
> > 
> > 6129c2b2dc65abde 758cf1496b94442c47c339b10d8 67792d4751810a675c5690ce2e9
> > ---------------- --------------------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
> >            |             |             |             |             |
> >            :6          100%           6:6            0%            :20    dmesg.BUG:spinlock_bad_magic_on_CPU
> >            :6          100%           6:6            0%            :20    dmesg.RIP:start_kernel
> >            :6          100%           6:6            0%            :20    dmesg.WARNING:at_init/main.c:#start_kernel
> 
> Very good, thank you!
> 
> May I add your Tested-by?

sure! our great pleasure :)

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> 							Thanx, Paul
> 
