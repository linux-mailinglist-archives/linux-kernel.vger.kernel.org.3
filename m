Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18884F823E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbiDGO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbiDGO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D61EF5C0;
        Thu,  7 Apr 2022 07:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E22061CBF;
        Thu,  7 Apr 2022 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F97C385A0;
        Thu,  7 Apr 2022 14:54:48 +0000 (UTC)
Date:   Thu, 7 Apr 2022 10:54:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Message-ID: <20220407105446.186114c3@gandalf.local.home>
In-Reply-To: <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
References: <20220407144524.2a592ed6@canb.auug.org.au>
        <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
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

On Thu, 7 Apr 2022 13:48:54 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > event svc_defer_recv has unsafe dereference of argument 1
> > print_fmt: "addr=%pISpc dr=%p xid=0x%08x", (struct sockaddr *)__get_dynamic_array(addr), REC->dr, REC->xid
> > event svc_defer_queue has unsafe dereference of argument 1
> > print_fmt: "addr=%pISpc dr=%p xid=0x%08x", (struct sockaddr *)__get_dynamic_array(addr), REC->dr, REC->xid
> > event svc_defer_drop has unsafe dereference of argument 1
> > print_fmt: "addr=%pISpc dr=%p xid=0x%08x", (struct sockaddr *)__get_dynamic_array(addr), REC->dr, REC->xid
> > NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
> > rcu: srcu_init: Setting srcu_struct sizes based on contention.
> > 
> > Introduced by commit
> > 
> >  e2e917f8677d ("SUNRPC: Fix the svc_deferred_event trace class")
> > 
> > At least reverting that commit makes the warning go away.
> > 
> > I have left that commit reverted for today.  
> 
> Thank you, Stephen. The NFS community has already discussed a
> fix for this issue. I'll push it out as soon as I can.

Hmm, I know we added code to handle "__get_sockaddr()" but I guess this
should also be fine for "__get_dynamic_array()" as well.

I could write a patch to cover those too.

-- Steve
