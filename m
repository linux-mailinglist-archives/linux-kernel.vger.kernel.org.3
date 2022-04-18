Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A71504E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiDRJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiDRJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671AA15FEF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0635061178
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750EBC385A7;
        Mon, 18 Apr 2022 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650274064;
        bh=78ipSubuEt83d9OlB0v+oZf6e8ais0MrE8bFB7G1RcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n52Vfu1vt31Ptm88LVO38DixE0LCJ7EYKQm/gUzeh5vUnwQW9/qtX7WQe+ZadYcVv
         7uASQ1/Whmw9pXnPeYwyux3ZhqL21wP/Lp2nFtmh3iPxSvGbgzS6kjweeV8eZ8fXWz
         evtljKZda8KHeAJCRvSGV8u8KbO0B7OwoPeuGz6rRj2yh75LB/1EJKUKlWwLy9AV5U
         nh7gKT5h0FOT6nUcXLlmWPS448WUO96JBBj/APdxIt5HEc7GIK+H626OkFHgU01bfb
         p/+aVFuXvXP7kk1hnR6epH7Mm6Mp588TpwWG3C4SBgLV8hOtFepmzyj0k41QbmvwCg
         HwEo538L2X7Cw==
Date:   Mon, 18 Apr 2022 12:27:36 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl0vCDE44VeU8qxC@kernel.org>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
> There are 50+ different shrinkers in the kernel, many with their own bells and
> whistles. Under the memory pressure the kernel applies some pressure on each of
> them in the order of which they were created/registered in the system. Some
> of them can contain only few objects, some can be quite large. Some can be
> effective at reclaiming memory, some not.
> 
> The only existing debugging mechanism is a couple of tracepoints in
> do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> covering everything though: shrinkers which report 0 objects will never show up,
> there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> scan function, which is not always enough (e.g. hard to guess which super
> block's shrinker it is having only "super_cache_scan"). They are a passive
> mechanism: there is no way to call into counting and scanning of an individual
> shrinker and profile it.
> 
> To provide a better visibility and debug options for memory shrinkers
> this patchset introduces a /sys/kernel/shrinker interface, to some extent
> similar to /sys/kernel/slab.

Wouldn't debugfs better fit the purpose of shrinker debugging?
 
-- 
Sincerely yours,
Mike.
