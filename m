Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28FF4E9ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiC1PQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiC1PQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D01E3EB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D71612F4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF02C004DD;
        Mon, 28 Mar 2022 15:15:05 +0000 (UTC)
Date:   Mon, 28 Mar 2022 11:15:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/trace_events_user.c:747:16: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <20220328111503.1629c464@gandalf.local.home>
In-Reply-To: <202203281558.fjXyftuw-lkp@intel.com>
References: <202203281558.fjXyftuw-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 15:39:22 +0800
kernel test robot <lkp@intel.com> wrote:

> sparse warnings: (new ones prefixed by >>)
> >> kernel/trace/trace_events_user.c:747:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> kernel/trace/trace_events_user.c:747:16: sparse:    void [noderef] __rcu *
> >> kernel/trace/trace_events_user.c:747:16: sparse:    void *
> >> kernel/trace/trace_events_user.c:811:13: sparse: sparse: cast removes address space '__user' of expression
> >> kernel/trace/trace_events_user.c:811:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@  
>    kernel/trace/trace_events_user.c:811:13: sparse:     expected void [noderef] __user *buf
>    kernel/trace/trace_events_user.c:811:13: sparse:     got char *
>    kernel/trace/trace_events_user.c:827:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/trace/trace_events_user.c:827:16: sparse:    void [noderef] __rcu *
>    kernel/trace/trace_events_user.c:827:16: sparse:    void *
>    kernel/trace/trace_events_user.c:854:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/trace/trace_events_user.c:854:9: sparse:    void [noderef] __rcu *
>    kernel/trace/trace_events_user.c:854:9: sparse:    void *
> 
> vim +747 kernel/trace/trace_events_user.c
> 
>    730	
>    731	/*
>    732	 * Validates the user payload and writes via iterator.
>    733	 */
>    734	static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>    735	{
>    736		struct user_event_refs *refs;

Looks like the above needs to be:

			struct user_event_refs __rcu *refs;

>    737		struct user_event *user = NULL;
>    738		struct tracepoint *tp;
>    739		ssize_t ret = i->count;
>    740		int idx;
>    741	
>    742		if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
>    743			return -EFAULT;
>    744	
>    745		rcu_read_lock_sched();
>    746	
>  > 747		refs = rcu_dereference_sched(file->private_data);  
>    748	
>    749		/*
>    750		 * The refs->events array is protected by RCU, and new items may be
>    751		 * added. But the user retrieved from indexing into the events array
>    752		 * shall be immutable while the file is opened.
>    753		 */
>    754		if (likely(refs && idx < refs->count))
>    755			user = refs->events[idx];
>    756	
>    757		rcu_read_unlock_sched();
>    758	
>    759		if (unlikely(user == NULL))
>    760			return -ENOENT;
>    761	
>    762		tp = &user->tracepoint;
>    763	
>    764		/*
>    765		 * It's possible key.enabled disables after this check, however
>    766		 * we don't mind if a few events are included in this condition.
>    767		 */
>    768		if (likely(atomic_read(&tp->key.enabled) > 0)) {
>    769			struct tracepoint_func *probe_func_ptr;
>    770			user_event_func_t probe_func;
>    771			void *tpdata;
>    772			void *kdata;
>    773			u32 datalen;
>    774	
>    775			kdata = kmalloc(i->count, GFP_KERNEL);
>    776	
>    777			if (unlikely(!kdata))
>    778				return -ENOMEM;
>    779	
>    780			datalen = copy_from_iter(kdata, i->count, i);
>    781	
>    782			rcu_read_lock_sched();
>    783	
>    784			probe_func_ptr = rcu_dereference_sched(tp->funcs);
>    785	
>    786			if (probe_func_ptr) {
>    787				do {
>    788					probe_func = probe_func_ptr->func;
>    789					tpdata = probe_func_ptr->data;
>    790					probe_func(user, kdata, datalen, tpdata);
>    791				} while ((++probe_func_ptr)->func);
>    792			}
>    793	
>    794			rcu_read_unlock_sched();
>    795	
>    796			kfree(kdata);
>    797		}
>    798	
>    799		return ret;
>    800	}
>    801	
>    802	static ssize_t user_events_write(struct file *file, const char __user *ubuf,
>    803					 size_t count, loff_t *ppos)
>    804	{
>    805		struct iovec iov;
>    806		struct iov_iter i;
>    807	
>    808		if (unlikely(*ppos != 0))
>    809			return -EFAULT;
>    810	
>  > 811		if (unlikely(import_single_range(READ, (char *)ubuf, count, &iov, &i)))  

						(char __user *)ubuf

-- Steve

>    812			return -EFAULT;
>    813	
>    814		return user_events_write_core(file, &i);
>    815	}
>    816	
> 

