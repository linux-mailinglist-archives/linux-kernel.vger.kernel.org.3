Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2950E3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbiDYPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiDYPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 543DC119ED4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650898750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVm3XyH4Eb2jKqWQvAzp0aH5DM2Lzwo7rp3slkzqeHQ=;
        b=XRdkXCrNqkoLHbvVoefR947/QsqR5UJlvBHX85HufYTDNu0UiytWwAENhr4gNTD0wJI2HU
        ckpAnJJuGk8Xi5ezlUrwjdsF4KUoWiRAjf3dqLv4EGJ/VK4AR9mkYkezExrsLvu5QnwCYe
        6PQ8n6f9XK13v9XS4CH8SkXccf1m3Q4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-vKj1gQFrOCGo-ysHu3sa4Q-1; Mon, 25 Apr 2022 10:59:06 -0400
X-MC-Unique: vKj1gQFrOCGo-ysHu3sa4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D93921E13795;
        Mon, 25 Apr 2022 14:59:05 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86206C27EBC;
        Mon, 25 Apr 2022 14:59:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3B9DE416F574; Mon, 25 Apr 2022 11:57:31 -0300 (-03)
Date:   Mon, 25 Apr 2022 11:57:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Aaron Tomlin <atomlin@redhat.com>, frederic@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <Yma229h8meLFvCI1@fuller.cnet>
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2204251603570.25814@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2204251603570.25814@gentwo.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:06:04PM +0200, Christoph Lameter wrote:
> On Mon, 25 Apr 2022, Peter Zijlstra wrote:
> 
> > > Folding the vmstat diffs *always* when entering idle prevents unnecessary
> > > wakeups and processing in the future and also provides more accurate
> > > counters for the VM allowing better decision to be made on reclaim.
> >
> > I'm thinking you're going to find a ton of regressions if you try it
> > though; some workloads go idle *very* shortly, doing all this accounting
> > is going to be counter-productive.
> 
> Well there is usually not much to do in terms of accounting. 

static int refresh_cpu_vm_stats(bool do_pagesets)
{
        struct pglist_data *pgdat;
        struct zone *zone;
        int i;
        int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
        int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
        int changes = 0;

        for_each_populated_zone(zone) {
                struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
#ifdef CONFIG_NUMA
                struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
#endif

                for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
                        int v;

                        v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);
                        if (v) {

This loop is quite heavy. Maybe reducing the data necessary to be read
to a couple of cachelines would improve it considerably.

> If there are
> a lot of updates then it is worthwhile because if the numbers are off too
> much then the VM has trouble assessing its own situation.
> 
> It may depend though on how long the idle periods are. Do we have
> statistics on the duration? Always folding the vmstat deltas may also
> increase the length of the idle periods.

"Products such as the Intel® Optane™ SSD DC P4800X series have a read and write
latency of 10 microseconds, compared with a write latency of about 220 
microseconds for a typical NAND flash SSD."


