Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8C4E3F06
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiCVNBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiCVNBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:01:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84B75E75A;
        Tue, 22 Mar 2022 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wX3ulTkOwK6cNsfSRHuPSnQJorwmOeUK3CnYO+WGXfM=; b=vleTkf026MnOc7bkIDTtNZbY5Z
        zNDcBu+VIUPDGn08ebNzrq0fhkBiVkieqrsiJulUzH63Cyu33381SFsbUUYos8y7+dwf8EEwDDkl8
        VNwc5U4hNPpdoWocitnQNyzZVMyzhPvBrU/rPlG8uWy1gCU3xry75UBN1/9YGztAmehfvhYU6q537
        /4ObUE9iMxsONb1fb+hyjTbLitMoXBOfMhQvSul/elcAM2l5zFy9ENAwg4NBaKEDD7N7qmzK4g57I
        ZY+pfCf5Rkyw3c8w7uxoPVTVmOxRGL5+1svdjHKuBVm+iLE6+aPWwtPrKuZHL3B2TtAnO3zXHvfnb
        73Z7CdzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWe6d-00BbLO-BD; Tue, 22 Mar 2022 12:59:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A72330007E;
        Tue, 22 Mar 2022 13:59:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 678BB2019FD09; Tue, 22 Mar 2022 13:59:20 +0100 (CET)
Date:   Tue, 22 Mar 2022 13:59:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v2 1/6] perf/core: Fix incosistency between cgroup
 sched_out and sched_in
Message-ID: <YjnIKCIRV+ePJVCN@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322120834.98637-2-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:08:29PM +0800, Chengming Zhou wrote:
> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
> in perf_cgroup_switch().
> 
> CPU1					CPU2
> (in context_switch)			(attach running task)
> perf_cgroup_sched_out(prev, next)
> 	cgrp1 == cgrp2 is True
> 					next->cgroups = cgrp3
> 					perf_cgroup_attach()
> perf_cgroup_sched_in(prev, next)
> 	cgrp1 == cgrp3 is False
> 
> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
> context switch code") would save cpuctx switch out/in when the
> perf_cgroup of "prev" and "next" are the same.
> 
> But perf_cgroup of task can change in concurrent with context_switch.

Can you clarify? IIRC then a task changes cgroup it goes throught the
whole ->attach() dance, and that serializes against the context switch
code.

