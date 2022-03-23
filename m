Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436364E4DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbiCWIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbiCWIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:15:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722C66D386;
        Wed, 23 Mar 2022 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2ggSoRFKh0G1dKQFttVqUzAVwqtOX7Y3mA+081Turu8=; b=FKjxn9u6R6LAfSreq3RMO6doF6
        A0j/KB+lvNGml3FUMTFXmgJkNs+r0bBuJaGeRAula1+PNsamC5OAg4qoenHSt9BP0/kXlo33UPnU/
        nzp3dGtEb5IliJq2XCFNOnyciMB38Z7tkbeJYnZ9P/+xsMRKlWlbIeXUX2uo7VLopSCcygg7RVytp
        X6RurDqZaEpj+EaawH2VrEMo1hPiS+4LsysZ41GUTLffegC6sp11jJRvrNloxBMEFsE+qDLdWk3oB
        FjN92v/BMIgGIGSw1vLxLJM0NhHqRshwG/zZeL9meYjUIxlG7F914YxT1F+5mDGafJq+x4X1JF5nY
        sMvY8e5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWw80-003hq3-9v; Wed, 23 Mar 2022 08:14:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 777D93000E6;
        Wed, 23 Mar 2022 09:13:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 565EE20C5903E; Wed, 23 Mar 2022 09:13:58 +0100 (CET)
Date:   Wed, 23 Mar 2022 09:13:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [External] Re: [PATCH v2 2/6] perf/core: Introduce percpu
 perf_cgroup
Message-ID: <YjrWxnnIZvn3PWoX@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <YjnIpn/PCM6wKpOC@hirez.programming.kicks-ass.net>
 <0a7ebd49-cfdd-911e-3982-44f594320b0f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a7ebd49-cfdd-911e-3982-44f594320b0f@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 12:33:51AM +0800, Chengming Zhou wrote:
> On 2022/3/22 9:01 下午, Peter Zijlstra wrote:
> > On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
> >> Although we don't have incosistency problem any more, we can
> >> have other problem like:
> >>
> >> CPU1					CPU2
> >> (in context_switch)			(attach running task)
> >> 					prev->cgroups = cgrp2
> >> perf_cgroup_sched_switch(prev, next)
> >> 	cgrp2 == cgrp2 is True
> >>
> > 
> > Again, I'm not following, how can you attach to a running task from
> > another CPU ?
> 
> Hi Peter, I make a little testcase which can reproduce the race
> problem, on system with PSI disabled. Because when PSI enabled,
> cgroup_move_task() will hold rq lock to assign task->cgroups.

No, the problem is that you're talking about cgroup attach while I'm
thinking of attaching a event to a task. And your picture has nothing to
clarify.

Those pictures of yours could really do with a few more function names
in them, otherwise it's absolutely unclear what code is running where.
