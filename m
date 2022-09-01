Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D45A9093
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiIAHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiIAHlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:41:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768310D4FC;
        Thu,  1 Sep 2022 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qqD5irythXcXnrZi3fFnP54DNBcaxZAOs7bCGWArgiE=; b=ZhvYUfsOVZfpS5Hal0dOI4T8sU
        PNc+vhmIUmOhTzG2jygS6fZDnv4E7A8cEH34MHu/GJW5fxW0FsWlJpiJjUenDHQqSnwxEI5GXxOfi
        ieFRy6iseDaQxWHqkKo+aE3IWTS2iT8jcbgwVHviCi1gvBk1EpqhUD/IxzFVA43sXpGAoI//tD4o7
        DTq74As/XL+IUxAUoQcOMw9+Echuc+WtLNgyHhVHwco+lUUk18VbMVD+vebmmLUbv71Ofs9lwD97H
        rLOOmkKjdINa5JkLcdScQbPyypaLsZb7x9/x0p1oU1C7YpIc541zuWJSdEwkNQlWeNWbSa+YEesS7
        0Tt++BmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeoy-005qNM-GL; Thu, 01 Sep 2022 07:41:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A96683004C3;
        Thu,  1 Sep 2022 09:41:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 925E52B871FC0; Thu,  1 Sep 2022 09:41:02 +0200 (CEST)
Date:   Thu, 1 Sep 2022 09:41:02 +0200
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
Subject: Re: [RFC PATCH 10/30] mm: enable page allocation tagging for
 __get_free_pages and alloc_pages
Message-ID: <YxBiDmmhn4wlwIHC@hirez.programming.kicks-ass.net>
References: <20220830214919.53220-1-surenb@google.com>
 <20220830214919.53220-11-surenb@google.com>
 <20220831101103.fj5hjgy3dbb44fit@suse.de>
 <20220831174629.zpa2pu6hpxmytqya@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831174629.zpa2pu6hpxmytqya@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 01:46:29PM -0400, Kent Overstreet wrote:

> Because all the counters are statically allocated, without even a pointer deref
> to get to them in the allocation path (one pointer deref to get to them in the
> deallocate path), that makes this _much, much_ cheaper than anything that could
> be done with tracing - cheap enough that I expect many users will want to enable
> it in production.

You're contributing to death-by-a-thousand-cuts here. By making all this
unconditional you're putting distros in a bind. Most of their users will
likely not care about this, but if they enable it, they'll still pay the
price for having it.

Even static counters will have cache misses etc..

So yes, for the few people that actually care about this stuff, this
might be a bit faster, but IMO it gets the econimics all backwards,
you're making everybody pay the price instead of only those that care.

Also note that you can have your tracepoint based handler have
statically allocated data just fine.

