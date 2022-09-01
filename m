Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417E5A90B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiIAHmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiIAHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D51090AC;
        Thu,  1 Sep 2022 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3R95H7o4Ps0Xt8Fb2RGRK8ftexUpMSTfRccKzarlwv8=; b=Eg80MMaySfuaV1ldmooclI5Nle
        IN65bkkyoGAXjGnjvZ9Dz97arRuZEhWCpPPCP1gw1nVSAW07lMYUIubOMxvASCB4vmoiTLGUvHrLv
        mnlyZtBunER3vltL8aBUMSfY4OGfxQTUnrR0dVTN+q9nK3Ed9aJ7y3lLrPOxju5X4dgv8lB4Rw2/S
        M4qKtJDbH/5MyAfn5zL3v6Z2qbXeFnlVENhNiHvxEi1N3ly1LlBYvlGl7CCxhftPsoPtvO9AoJQWv
        yv5KTzNibXIV76seLfOwEBNoqddr2AJkeDRRPmkEtfLxUWCG6NSjcEJWY7wpS3gtx9W2q+ItfapFU
        +bbvPyyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqK-005qQi-Us; Thu, 01 Sep 2022 07:42:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 447DF3004C7;
        Thu,  1 Sep 2022 09:42:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 344DD2B871FC3; Thu,  1 Sep 2022 09:42:27 +0200 (CEST)
Date:   Thu, 1 Sep 2022 09:42:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Mel Gorman <mgorman@suse.de>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, void@manifault.com,
        juri.lelli@redhat.com, ldufour@linux.ibm.com, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, changbin.du@intel.com,
        ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, arnd@arndb.de,
        jbaron@akamai.com, rientjes@google.com, minchan@google.com,
        kaleshsingh@google.com, kernel-team@android.com,
        linux-mm@kvack.org, iommu@lists.linux.dev,
        kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
        linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
Message-ID: <YxBiY5hDUSE4ZqKM@hirez.programming.kicks-ass.net>
References: <20220830214919.53220-1-surenb@google.com>
 <Yw8P8xZ4zqu121xL@hirez.programming.kicks-ass.net>
 <20220831084230.3ti3vitrzhzsu3fs@moria.home.lan>
 <20220831101948.f3etturccmp5ovkl@suse.de>
 <20220831155941.q5umplytbx6offku@moria.home.lan>
 <YxBZv1pZ6N2vwcP3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBZv1pZ6N2vwcP3@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:05:36AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 31, 2022 at 11:59:41AM -0400, Kent Overstreet wrote:
> 
> > Also, ftrace can drop events. Not really ideal if under system load your memory
> > accounting numbers start to drift.
> 
> You could attach custom handlers to tracepoints. If you were to replace
> these unconditional code hooks of yours with tracepoints then you could
> conditionally (say at boot) register custom handlers that do the
> accounting you want.
> 
> Nobody is mandating you use the ftrace ringbuffer to consume tracepoints.
> Many people these days attach eBPF scripts to them and do whatever they
> want.

Look at kernel/trace/blktrace.c for a fine in-kernel !BFP example of this.
