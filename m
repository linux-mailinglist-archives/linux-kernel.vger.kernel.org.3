Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278894EDA68
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiCaNW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCaNW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E8B21DEAB3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648732869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+w6PvnKvqRPLK7dP9n2WRW7fwC2UrijjnF9LxNx4Mc=;
        b=c5bKxGxgHHESKIcBnYKN23TiPlBA7ae7SUNmQ+XTrMT7ziM7oklRfRpD8peXSL9CTUbP7w
        l64/rKtsLqyu6/hTq5jsH+5kF7JwOGx+K+Ip0bxzAdJWZq6ijtrSHU5y61qAoOy7O9YFPb
        G7xj05OAjzce5oNf1obfDGsl1yIQoSY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-US1-0cXaN8qssD-_WsKH5g-1; Thu, 31 Mar 2022 09:21:06 -0400
X-MC-Unique: US1-0cXaN8qssD-_WsKH5g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78AE13822202;
        Thu, 31 Mar 2022 13:21:05 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E42401E2A;
        Thu, 31 Mar 2022 13:21:05 +0000 (UTC)
Date:   Thu, 31 Mar 2022 09:21:04 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arch/arm64: Fix topology initialization for core
 scheduling
Message-ID: <20220331132103.GB17613@pauld.bos.csb>
References: <20220330155611.30216-1-pauld@redhat.com>
 <66f29bee-e26c-b40e-c3af-79d5297565d8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f29bee-e26c-b40e-c3af-79d5297565d8@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:04:31AM +0200 Dietmar Eggemann wrote:
> On 30/03/2022 17:56, Phil Auld wrote:
> > Arm64 systems rely on store_cpu_topology() to call update_siblings_masks()
> > to transfer the toplogy to the various cpu masks. This needs to be done 
> > before the call to notify_cpu_starting() which tells the scheduler about 
> > each cpu found, otherwise the core scheduling data structures are setup 
> > in a way that does not match the actual topology.
> > 
> > Without this change stress-ng (which enables core scheduling in its prctl 
> > tests) causes a warning and then a crash (trimmed for legibility):
> > 
> > [ 1853.805168] ------------[ cut here ]------------
> > [ 1853.809784] task_rq(b)->core != rq->core
> > [ 1853.809792] WARNING: CPU: 117 PID: 0 at kernel/sched/fair.c:11102 cfs_prio_less+0x1b4/0x1c4
> > ...
> > [ 1854.015210] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> > ...
> > [ 1854.231256] Call trace:
> > [ 1854.233689]  pick_next_task+0x3dc/0x81c
> > [ 1854.237512]  __schedule+0x10c/0x4cc
> > [ 1854.240988]  schedule_idle+0x34/0x54
> > 
> > Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> > This is a similar issue to 
> >   f2703def339c ("MIPS: smp: fill in sibling and core maps earlier") 
> > which fixed it for MIPS. 
> > 
> > v2: Fixed the commit message. No code change.
> 
> Ah, the reason is that smt_mask is not correctly setup, so we bail on
> `cpumask_weight(smt_mask) == 1` for !leaders in:
> 
> notify_cpu_starting()
>   cpuhp_invoke_callback_range()
>     sched_cpu_starting()
>       sched_core_cpu_starting()
> 
> which leads to rq->core not being correctly set for !leader-rq's.
> 

Exactly, sorry I was not clearer.  smt_mask must be setup correctly 
by the time sched_core_cpu_starting() is called. (Maybe I should crib
some of the above lines into the commit message?)


> LGTM. Tested on: HPE Apollo 70 X1
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 

Thanks!



Cheers,
Phil


> [...]
> 

-- 

