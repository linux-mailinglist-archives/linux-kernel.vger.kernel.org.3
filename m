Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D104E477A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiCVU2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCVU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:28:27 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EB6661B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:26:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWl5i-00Faic-Ar; Tue, 22 Mar 2022 20:26:54 +0000
Date:   Tue, 22 Mar 2022 20:26:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <YjoxDicNK1pTkrKJ@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
 <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
 <YjjP5ldCCGYqD+UV@slm.duckdns.org>
 <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
 <YjoCqqs+UDxZ55nM@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjoCqqs+UDxZ55nM@slm.duckdns.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 07:08:58AM -1000, Tejun Heo wrote:

> > That's interesting...  My impression had been that some of these functions
> > could be called from interrupt contexts (judging by the spin_lock_irqsave()
> > in there).  What kind of async contexts those are, and what do you use to
> > make sure they don't leak into overlap with kernfs_remove()?
> 
> The spin_lock_irqsave()'s are there because they're often used when printing
> messages which can happen from any context. e.g. cpuset ends up calling into
> them to print current's cgroup under rcu_read_lock(), iocost to print
> warning message under an irq-safe lock. In both and similar cases, the
> caller knows that the cgroup is accessible which in turn guarantees that the
> kernfs node hasn't be deleted.

Wait a sec.  Choice of spin_lock_irqsave() vs. spin_lock_irq() is affected by
having it called with interrupts disabled; choice of either vs. spin_lock()
is not - that's needed only if you might end up taking the spinlock in question
from interrupt handler.  "Under rcu_read_lock()" is irrelevant here...

The point of spin_lock_irq/spin_lock_irqsave is the prevention of
	spin_lock(&LOCK); // locked
take an interrupt, enter interrupt handler and there run into
	spin_lock(&LOCK); // and we spin forever
If there's no users in interrupt contexts, we are just fine with plain
spin_lock().

The only thing that matter wrt rcu_read_lock() is that we can't block there;
there are tons of plain spin_lock() calls done in those conditions.  And
rcu_read_lock() doesn't disable interrupts, so spin_lock_irq() is usable
under it.  Now, holding another spinlock with spin_lock_irq{,save}() *does*
prohibit the use of spin_lock_irq() - there you can use only spin_lock()
or spin_lock_irqsave().

The callchains that prohibit spin_lock() do exist - for example, there's
pr_cont_kernfs_path <- pr_cont_cgroup_path <- transfer_surpluses <- ioc_timer_fn.

	Out of curiosity, what guarantees that kernfs_remove() won't do
fun things to ancestors of iocg_to_blkg(iocg)->blkcg->css.cgroup for some
iocg in ioc->active_iocgs, until after ioc_rqos_exit(ioc) has finished
del_timer_sync()?
