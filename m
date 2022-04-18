Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3556A505D80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbiDRRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbiDRRaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:30:30 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC536416
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:27:42 -0700 (PDT)
Date:   Mon, 18 Apr 2022 10:27:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650302861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Gp18eUoW03iuPGj3GLuowLyhOcAU8RggWp55xHDiug=;
        b=YOzUkpmXwDTK8OBKTvkVHeeh6b7M8TfcYAqpT4+k8uxZSRvkpWNPd8elMnjNOnEu8sybek
        jMTg6/6gOLCJ4jwFUQH8mO1SdLzlSVd0Jm7mPmTmxQw25N+e+Q+Mw2G3IDzdKktQmrWwCX
        GldI0fnvHg6eAaQAO9QGWaWfv70VUnk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl2fhgcW5pL66nPK@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <Yl0vCDE44VeU8qxC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl0vCDE44VeU8qxC@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:27:36PM +0300, Mike Rapoport wrote:
> On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
> > There are 50+ different shrinkers in the kernel, many with their own bells and
> > whistles. Under the memory pressure the kernel applies some pressure on each of
> > them in the order of which they were created/registered in the system. Some
> > of them can contain only few objects, some can be quite large. Some can be
> > effective at reclaiming memory, some not.
> > 
> > The only existing debugging mechanism is a couple of tracepoints in
> > do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> > covering everything though: shrinkers which report 0 objects will never show up,
> > there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> > scan function, which is not always enough (e.g. hard to guess which super
> > block's shrinker it is having only "super_cache_scan"). They are a passive
> > mechanism: there is no way to call into counting and scanning of an individual
> > shrinker and profile it.
> > 
> > To provide a better visibility and debug options for memory shrinkers
> > this patchset introduces a /sys/kernel/shrinker interface, to some extent
> > similar to /sys/kernel/slab.
> 
> Wouldn't debugfs better fit the purpose of shrinker debugging?

I think sysfs fits better, but not a very strong opinion.

Even though the interface is likely not very useful for the general
public, big cloud instances might wanna enable it to gather statistics
(and it's certainly what we gonna do at Facebook) and to provide
additional data when something is off.  They might not have debugfs
mounted. And it's really similar to /sys/kernel/slab.

Are there any reasons why debugfs is preferable?

Thanks!
