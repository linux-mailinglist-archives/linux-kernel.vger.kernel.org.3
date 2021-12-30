Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27A748184F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhL3CAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:00:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:24757 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhL3CAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640829653; x=1672365653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Udnw99HBsy0KbtlGgwoErMwND1kwq1XS+ZN01+qHvXU=;
  b=Zd2L8Xd4d/V4bW3W+ds2XvcOJ3ZfD3xKwDOPSJoEgcFWO92pLc8eipTD
   iPzUy1v4WhBebZNtpcD8/FR9sBG9CEOvmVq6QZVtQ/ibM4As0+AoMgruI
   Gk6C39CD0TVrbTNZBLopUL35+OA1ZBMg43/idcAKn2vOqIWHqp7AyxF7q
   WXy+IHnkAjKoi8icvBaAff3zKFNEZqCCv1PvpMSLk/GRSIfZkvQvX1o9e
   elbhS2z7glBWsHR0wUjWlwvyEF/GSCBOJI8VUWzZITDbM2ilEO3QJKBsx
   2eY1Z49FeIb/j4lWfsAuG7vOUb2F50iGjCM0AISxBG+zRy+PJa/O6EVey
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241809896"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="241809896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 18:00:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="619238323"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 18:00:51 -0800
Date:   Thu, 30 Dec 2021 10:00:44 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [rcutorture]  82e310033d:
 WARNING:possible_recursive_locking_detected
Message-ID: <20211230020044.GA17043@xsang-OptiPlex-9020>
References: <20211228151135.GB31268@xsang-OptiPlex-9020>
 <20211229000609.GY4109570@paulmck-ThinkPad-P17-Gen-1>
 <20211229140121.GA10390@xsang-OptiPlex-9020>
 <20211229172441.GA4109570@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229172441.GA4109570@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Paul,

On Wed, Dec 29, 2021 at 09:24:41AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 29, 2021 at 10:01:21PM +0800, Oliver Sang wrote:
> > hi Paul,
> > 
> > we applied below patch upon next-20211224,
> > confirmed no "WARNING:possible_recursive_locking_detected" after patch.
> > 
> 
> Good to hear!  May I add your Tested-by?

sure (:

Tested-by: Oliver Sang <oliver.sang@intel.com>

> 
> Many of the remainder appear to be due to memory exhaustion, FWIW.

thanks for information

> 
> 							Thanx, Paul
> 
> > > ------------------------------------------------------------------------
> > > 
> > > commit dd47cbdcc2f72ba3df1248fb7fe210acca18d09c
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Dec 28 15:59:38 2021 -0800
> > > 
> > >     rcutorture: Fix rcu_fwd_mutex deadlock
> > >     
> > >     The rcu_torture_fwd_cb_hist() function acquires rcu_fwd_mutex, but is
> > >     invoked from rcutorture_oom_notify() function, which hold this same
> > >     mutex across this call.  This commit fixes the resulting deadlock.
> > >     
> > >     Reported-by: kernel test robot <oliver.sang@intel.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 918a2ea34ba13..9190dce686208 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -2184,7 +2184,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
> > >  	for (i = ARRAY_SIZE(rfp->n_launders_hist) - 1; i > 0; i--)
> > >  		if (rfp->n_launders_hist[i].n_launders > 0)
> > >  			break;
> > > -	mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
> > >  	pr_alert("%s: Callback-invocation histogram %d (duration %lu jiffies):",
> > >  		 __func__, rfp->rcu_fwd_id, jiffies - rfp->rcu_fwd_startat);
> > >  	gps_old = rfp->rcu_launder_gp_seq_start;
> > > @@ -2197,7 +2196,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
> > >  		gps_old = gps;
> > >  	}
> > >  	pr_cont("\n");
> > > -	mutex_unlock(&rcu_fwd_mutex);
> > >  }
> > >  
> > >  /* Callback function for continuous-flood RCU callbacks. */
> > > @@ -2435,7 +2433,9 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
> > >  			 n_launders, n_launders_sa,
> > >  			 n_max_gps, n_max_cbs, cver, gps);
> > >  		atomic_long_add(n_max_cbs, &rcu_fwd_max_cbs);
> > > +		mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
> > >  		rcu_torture_fwd_cb_hist(rfp);
> > > +		mutex_unlock(&rcu_fwd_mutex);
> > >  	}
> > >  	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
> > >  	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
