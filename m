Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7856C475
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiGHWNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiGHWNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:13:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E23A469;
        Fri,  8 Jul 2022 15:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C621CB8299F;
        Fri,  8 Jul 2022 22:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA0C341C0;
        Fri,  8 Jul 2022 22:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657318410;
        bh=qr9hXyMtBnv4Vq7MoL7+czDkG7MtG1o0tmvCrXRDC6g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DqL5PeTbNUlDvoTSwNfxSjrege045KYRB2xgaMAbQ7vDkGwkLhNsVabxY54rmiy5u
         6tR7sbpvQwdtfPWzy8N9FPz6+e3+KMTVc6iwhG8RPEq8TIFV7GG5KEvC6dJqsy9kyE
         TsqVCdtD3DQss1WTIwIsrKbDpPdmeQZKPlt60/DfjIXSYiiCehqjxUaPSvfFaWtZYm
         3qTVgIpLduSNcYNu+fYFcUtKcBACdHB5kw18ike4msyfVMMcCseJn3o5YQKq6bNURO
         WysBBevhWAjcNNNrgHCh7FqllYjrcmynLhWvCdeNrIpIdP+FOKcywSJCFf0BqmiH6y
         Hn/Lky+5iQVDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01A965C0835; Fri,  8 Jul 2022 15:13:29 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:13:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Message-ID: <20220708221329.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220701024404.2228367-1-qiang1.zhang@intel.com>
 <20220705174109.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880370195C11E8E943069CBDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220706035040.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880E86FD8C97088EC65B0A1DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880176B380D4177EC6E8C61DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880176B380D4177EC6E8C61DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:24:03AM +0000, Zhang, Qiang1 wrote:
> 
> On Wed, Jul 06, 2022 at 02:00:51AM +0000, Zhang, Qiang1 wrote:
> > On Fri, Jul 01, 2022 at 10:44:04AM +0800, Zqiang wrote:
> > > Currently, only tree RCU support leak callbacks setting when do
> > > duplicate call_rcu(). this commit add leak callbacks setting when
> > > fo duplicate call_rcu() for tiny RCU.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > 
> > >This does look plausible, thank you!
> > >
> > >What testing have you done?
> > >
> > >One important test for Tiny RCU is that the size of the kernel not
> > >grow without a very good reason.  In this case, the added code should
> > >be dead code in a production build (CONFIG_DEBUG_OBJECTS_RCU_HEAD=n),
> > >but it is good to check.
> > >
> > >It is of course also good to check that the messages print as expected,
> > >which is what rcutorture.object_debug is there to help with.
> > 
> > In the condition that the CONFIG_DEBUG_OBJECTS_RCU_HEAD=n, the function directly returns zero.
> > 
> > #else   /* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > static inline int debug_rcu_head_queue(struct rcu_head *head)
> > {
> >         return 0;
> > }
> >
> >Yes, like I said, the added code -should- be dead code.  But there is
> >often a gap between "should" and "is", for example, compilers don't
> >always do what we would like them to.  So please use the "size vmlinux"
> >command with and without your patch for a kernel built (both times)
> >with CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD==n.
> >
> >The rest of the test results look good, thank you!
> 
> Hi Paul
> 
> 1. CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> 
> Original:
> text                      data                   bss                   dec                     hex       filename
> 26291319        20160143        15212544        61664006        3aceb06    vmlinux
> 
> Applay patch:
> text                       data                  bss                     dec                 hex    filename
> 26291319        20160431        15212544        61664294        3acec26 vmlinux
> 
> 2. CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> 
> Original:
> text                    data                   bss                          dec     hex filename
> 26290663        20159823        15212544        61663030        3ace736 vmlinux
> 
> Applay patch:
> text                     data                     bss                    dec     hex filename
> 26290663        20159823        15212544        61663030        3ace736 vmlinux

Much better, thank you!

Please see below for the commit updated with this information and
wordsmithed a bit.  As always, please let me know if I messed something
up.

							Thanx, Paul

------------------------------------------------------------------------

commit 88cea4e18ed430aa1187063450236fc00408eaac
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Fri Jul 1 10:44:04 2022 +0800

    rcu: Make tiny RCU support leak callbacks for debug-object errors
    
    Currently, only Tree RCU leaks callbacks setting when it detects a
    duplicate call_rcu().  This commit causes Tiny RCU to also leak
    callbacks in this situation.
    
    Because this is Tiny RCU, kernel size is important:
    
    1. CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
       (Production kernel)
    
        Original:
        text      data      bss       dec       hex     filename
        26290663  20159823  15212544  61663030  3ace736 vmlinux
    
        With this commit:
        text      data      bss       dec       hex     filename
        26290663  20159823  15212544  61663030  3ace736 vmlinux
    
    2. CONFIG_TINY_RCU=y and CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
       (Debugging kernel)
    
        Original:
        text      data      bss       dec       hex     filename
        26291319  20160143  15212544  61664006  3aceb06 vmlinux
    
        With this commit:
        text      data      bss       dec       hex     filename
        26291319  20160431  15212544  61664294  3acec26 vmlinux
    
    These results show that the kernel size is unchanged for production
    kernels, as desired.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index f0561ee16b9c2..943d431b908f6 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -158,6 +158,10 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
+static void tiny_rcu_leak_callback(struct rcu_head *rhp)
+{
+}
+
 /*
  * Post an RCU callback to be invoked after the end of an RCU grace
  * period.  But since we have but one CPU, that would be after any
@@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	static atomic_t doublefrees;
 	unsigned long flags;
 
-	debug_rcu_head_queue(head);
+	if (debug_rcu_head_queue(head)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
+			mem_dump_obj(head);
+		}
+
+		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
+			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
+		return;
+	}
+
 	head->func = func;
 	head->next = NULL;
 
