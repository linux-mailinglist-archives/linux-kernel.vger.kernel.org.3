Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9775250791D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357273AbiDSSbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357445AbiDSS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A932ED4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:20:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t26so4241372qtn.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zeR3V0x/d5dS+XbGlGq1iYQwImzuhf524PVpciJ0wyA=;
        b=f5MU9YQh2Eunm+v3zEufTrXY3X1K+ZReCWqTSryDhoUg5tqzZbCHuntywVLW4Nrj6T
         eS3a8FNZ7JhNWz/Mcwt2BdW20BCxmuxR4dA1Tx9M2lJpyDUpNkVwjmYYdjIQbexud61h
         NSY7ItILuCfFvzk42D8a9+0k9Wdh9pAlc4KDk8QjCQMjFOk7zNYPu35ohvTft8tkAPIm
         yl9Oxg7/5+HHzCfvXA9V8x6jH4RdwXF/30DxlSar4NPGGNqDzl3zU1NWAcS2oA8FbQ7d
         r/RdKJFFc3EgwU2+2jeXGdvgDEPMVrIdAZU/E8VpyzSw76zEcrsB8YCy9U4f+rtt1VLJ
         qq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zeR3V0x/d5dS+XbGlGq1iYQwImzuhf524PVpciJ0wyA=;
        b=vjPx0V/N3JwRI37p8CCA6w3XqHXHCefGBuxTd1N2uR06fBFg0xygG8orSlEUNSfIvg
         UsWIHJIOExr+BgYxvXpPKbmv9cqXkNcVrpMCTc16hFIhy9pwQM0tfIcjWIVcBCIumPDM
         pCZzWJxrFaf/kzPG2kT9CYH1rfg0tyDiVF0+pQ8JmgTPSjIhoH7L4aMgzamOPFl6hyJx
         jNyD8mJGstH+W9W00HHiC+VFFBlPhuvPHdrI66R71vJGq7nUnS8/MzGd92O/DPuauvy7
         +Cn8xTomicJD+If8TCAFH9mSQ0kZ1vWnRw85A0mspuDpd64oemeFKCUoqLP3duhq2+r8
         vXzA==
X-Gm-Message-State: AOAM533BmEPKrhd9XJ8SA6/GbWDkQty3iaaaVCNiMBsZQU92jp0LEAqT
        8n1K7azgw9Fyhh3pqa+4VQ==
X-Google-Smtp-Source: ABdhPJyWhY5AlGyL4nF/Zmhqbckoo3GR+ES0yQigZFUARWQO7ZzpOXeGJ8v+v296DWXyfRUh4KlRZw==
X-Received: by 2002:ac8:578b:0:b0:2e2:324a:7b6c with SMTP id v11-20020ac8578b000000b002e2324a7b6cmr11081009qta.267.1650392432986;
        Tue, 19 Apr 2022 11:20:32 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s18-20020a05622a1a9200b002f335693f4bsm400640qtc.38.2022.04.19.11.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:20:32 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:20:30 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <20220419182030.idqqmtim4slhbked@moria.home.lan>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
> 
> For each shrinker registered in the system a folder is created. The folder
> contains "count" and "scan" files, which allow to trigger count_objects()
> and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> and scan_memcg_node are additionally provided. They allow to get per-memcg
> and/or per-node object count and shrink only a specific memcg/node.

Cool!

I've been starting to sketch out some shrinker improvements of my own, perhaps
we could combine efforts. The issue I've been targeting is that when we hit an
OOM, we currently don't get a lot of useful information - shrinkers ought to be
included, and we really want information on shrinker's internal state (e.g.
object dirtyness) if we're to have a chance at understanding why memory isn't
getting reclaimed.

https://evilpiepirate.org/git/bcachefs.git/log/?h=shrinker_to_text

This adds a .to_text() method - a pretty-printer - that shrinkers can
implement, and then on OOM we report on the top 10 shrinkers by memory usage, in
sorted order.

Another thing I'd like to do is have shrinkers report usage not just in object
counts but in bytes; I think it should be obvious why that's desirable.

Maybe we could have a memory-reporting-and-shrinker-improvements session at LSF?
I'd love to do some collective brainstorming and get some real momementum going
in this area.
