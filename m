Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05C4D2034
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbiCHS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbiCHS0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:26:43 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C70326112;
        Tue,  8 Mar 2022 10:25:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w12so9419457lfr.9;
        Tue, 08 Mar 2022 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vvffHUrzjEmVtlp+Y2Xsgt8CHrDNJiwaK1f48maOz2U=;
        b=SWQLN6PWd4COaUmnVPN0qI4SG70QpRqNhN3jZOQtYhbB8vQuhsbTjOHjfwj0QJlbvN
         0OWiTH9oFkO61pTm+hykxIEeA3D0kyc9g/MZS1mMO94+oH28LioTw9QXtYXRsOcgwARW
         cxUfA71CzkG13WLm3kp4ZcjLyMA2QgsB33Y/OxmxgXRfW8I05Am2GBPDIhHvj/B4axFx
         +6e+QUgB7ZRjyZyNsAV9Pg8Ih2kVy7/wjTGUQgjlEDpLUFWjpqXawfW2uP0jRl2WcEKQ
         Is+dxioyCnfhAC0x/u1z6Vo0zj5i1mGF09w01ZguNXs5mpWMtia9NOPbZKSTciX1Shiq
         S4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vvffHUrzjEmVtlp+Y2Xsgt8CHrDNJiwaK1f48maOz2U=;
        b=QIm8d0pNMXn3cUvJfvW01dtvHIVzyCYrv6YoHxZw+vT2J6LsamQe3kgDnj75/dGKLj
         f9GW50tYgYWuxOj9f6+Q3q2SzblHRuAneBwRCtown2nh8Z/mbdvZeIWBXqXq/cyXuJqZ
         BPGXmxLdL7HTilHEgvsMg9zV6eHKUtCq4OUzHPaI9ZDUWsjhgq/uLDVooSscAK/DTKx9
         nvd73WiOkCWLZBeQKakZx5rFSww1MFPzyyFhuvaGyvS1syR2yWqUx/P00YFqoDc1HAg7
         7J79Rk7JXL1+ivBeyediHLiIfQrd4Dzkg+okA/jsQloyKpX50VsYCsO8yG2weyl1OYQ3
         mbLA==
X-Gm-Message-State: AOAM53137HcHexaqXBPQgLQK+7ouqx1jPQR3x2A9XLqkTeYTzikSLXEP
        n0AIK+/En3nIxFAM6jzMIXg=
X-Google-Smtp-Source: ABdhPJyVwU803jgtvUTHHDLN05KAyDhy+QhRMHvepREc7JP8k+jfT33upTGovaakOPb+dPiYVR1e/Q==
X-Received: by 2002:a05:6512:348f:b0:441:e30:82c8 with SMTP id v15-20020a056512348f00b004410e3082c8mr11725536lfr.451.1646763918105;
        Tue, 08 Mar 2022 10:25:18 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id h6-20020a2e5306000000b00247e893075asm1374434ljb.37.2022.03.08.10.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:25:17 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 8 Mar 2022 19:25:15 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com
Subject: Re: [PATCH] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <Yiefi86aKclyFG5N@pc638.lan>
References: <20220304092631.4123188-1-qiang1.zhang@intel.com>
 <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
 <PH0PR11MB5880026EBBE3E195549E2245DA089@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220307191512.GN4285@paulmck-ThinkPad-P17-Gen-1>
 <YieapfzKvy2chaHT@pc638.lan>
 <20220308181355.GW4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308181355.GW4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:13:55AM -0800, Paul E. McKenney wrote:
> On Tue, Mar 08, 2022 at 07:04:21PM +0100, Uladzislau Rezki wrote:
> > > On Mon, Mar 07, 2022 at 02:03:17AM +0000, Zhang, Qiang1 wrote:
> > > > On 3/4/2022 2:56 PM, Zqiang wrote:
> > > > > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > > > > who are blocking a given grace period, if the current reader tasks
> > > > > have a higher priority than boost kthreads(the boost kthreads priority
> > > > > not always 1, if the kthread_prio is set), boosting is useless, skip
> > > > > current task and select next task to boosting, reduce the time for a
> > > > > given grace period.
> > > > > 
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > 
> > > Adding to CC to get more eyes on this.  I am not necessarily opposed to
> > > it, but I don't do that much RT work myself these days.
> > > 
> > > 							Thanx, Paul
> > > 
> > > > > ---
> > > > >   kernel/rcu/tree_plugin.h | 10 +++++++++-
> > > > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index c3d212bc5338..d35b6da66bbd 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -12,6 +12,7 @@
> > > > >    */
> > > > >   
> > > > >   #include "../locking/rtmutex_common.h"
> > > > > +#include <linux/sched/deadline.h>
> > > > >   
> > > > >   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> > > > >   {
> > > > > @@ -1065,13 +1066,20 @@ static int rcu_boost(struct rcu_node *rnp)
> > > > >   	 * section.
> > > > >   	 */
> > > > >   	t = container_of(tb, struct task_struct, rcu_node_entry);
> > > > > +	if (!rnp->exp_tasks && (dl_task(t) || t->prio <= current->prio)) {
> > > > > +		tb = rcu_next_node_entry(t, rnp);
> > > > > +		WRITE_ONCE(rnp->boost_tasks, tb);
> > > > > +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > > +		goto end;
> > > > > +	}
> > > > > +
> > Why do you bypass the expedited grace period and boost any tasks anyway?
> > Same way the expedited gp can be blocked by higher prior tasks SCHED_DEADLINE
> > or SCHED_FIFO.
> 
> Just to make sure that I understand...
> 
> Are you pointing out that a SCHED_DEADLINE task might have exhausted
> its budget, so that boosting might nonetheless be helpful?
> 
SCHED_DEADLINE we can not preempt nor stop it somehow(highest prio class),
it has some budget it makes use of. If it is in critical section then it
will leave asap, i do not take into account here IRQs and so on. I do not
see a reason to boost it.

>
> Me, I honestly don't know what happens in that case, so I am just asking
> the question.  And adding Juri on CC.  ;-)
> 
Juri should know more :)

--
Vlad Rezki
