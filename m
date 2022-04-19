Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549E507A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356153AbiDSTtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiDSTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:49:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D1817045
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:46:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z19so13082383qtw.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6c/SYxIqnOgc3xBGN6vD+FrBpi82jfjixKS1MM7raAU=;
        b=NaSE6YR0VC7zL6mT+HnXJcNbQMXg2BWx2hIw39GpTsJ8iTMU8P06u34PdmpK9qyX/H
         W5cbb8Mo5Wa6yDXI56wUcknyqttuz7/Xn2xf6IMF829Z3m/av41ibnvYZWgiZnUXGxMI
         +toI6FfzkCjC95ibEst4iaPOsp9E3ysx1HWXrtfNZIhgiBTs2zQygNi4SDKT/xmp4Uu8
         LXBnP1mNTPkixg/X9toQBDLDjX+CKfJsixahDBzAWtad5gDURJdAJY8Dz8k29j7NJMxH
         vE6q42dymGzkmDGO/s70LwYfcyy/VivZsAsdzmqStWTUber5zYymByEgIvJ/4TPF9Oji
         lCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6c/SYxIqnOgc3xBGN6vD+FrBpi82jfjixKS1MM7raAU=;
        b=RlRCGEMrd6v/Wxcv9Uf+3ul/khcgbH0CV4P0F6zQQhJqGt0jzHG597ZAYlwDo75fhg
         h8oyZCZ9sUN+/KIJ4z4YBI6bMq0gh2ntQZpxujrPUZCn+6YMv73aG+deBUCPISuDI0M2
         G6NC/cZVG6jXEE4WRP7Y+nAcjUDq15luEhNokR83tDb/d9J5D152E5e4QgH4ZxAIExah
         3+kKe2gVVMnbMZAla7U7pwdio9xtGuQOjuoNgxdmhZepOJIBoo39bh9df/b0B4G4bX6y
         k1dv1X185phfhzJDC1FpiYFGAgiYBDB664FGYVjkQ97JmniHlSb/84/Li1hJoKLvEMLF
         0ZkQ==
X-Gm-Message-State: AOAM533MX5YZckyv8bgyNsTDbMj3OaviR7IUP631ry9714OIrZ/lbDhZ
        ZOCK1WWQmPxHtu0awBiyfQ==
X-Google-Smtp-Source: ABdhPJwQLSruYgNAvqwATc+rxQQ6zl2eWrpsyG7q2uP5SC0I0JajaAkYPC2ZaWrqf7z5Qrr6XGgLWw==
X-Received: by 2002:a05:622a:1d4:b0:2f1:f278:d387 with SMTP id t20-20020a05622a01d400b002f1f278d387mr11834366qtw.645.1650397611565;
        Tue, 19 Apr 2022 12:46:51 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id d65-20020a37b444000000b0069e9f79795fsm466094qkf.67.2022.04.19.12.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:46:50 -0700 (PDT)
Date:   Tue, 19 Apr 2022 15:46:49 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <20220419194649.32f3v45fgr2wztf5@moria.home.lan>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <20220419182030.idqqmtim4slhbked@moria.home.lan>
 <Yl8GOJd/iUHkTEL3@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8GOJd/iUHkTEL3@carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:58:00AM -0700, Roman Gushchin wrote:
> On Tue, Apr 19, 2022 at 02:20:30PM -0400, Kent Overstreet wrote:
> > On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
> > > There are 50+ different shrinkers in the kernel, many with their own bells and
> > > whistles. Under the memory pressure the kernel applies some pressure on each of
> > > them in the order of which they were created/registered in the system. Some
> > > of them can contain only few objects, some can be quite large. Some can be
> > > effective at reclaiming memory, some not.
> > > 
> > > The only existing debugging mechanism is a couple of tracepoints in
> > > do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> > > covering everything though: shrinkers which report 0 objects will never show up,
> > > there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> > > scan function, which is not always enough (e.g. hard to guess which super
> > > block's shrinker it is having only "super_cache_scan"). They are a passive
> > > mechanism: there is no way to call into counting and scanning of an individual
> > > shrinker and profile it.
> > > 
> > > To provide a better visibility and debug options for memory shrinkers
> > > this patchset introduces a /sys/kernel/shrinker interface, to some extent
> > > similar to /sys/kernel/slab.
> > > 
> > > For each shrinker registered in the system a folder is created. The folder
> > > contains "count" and "scan" files, which allow to trigger count_objects()
> > > and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> > > count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> > > and scan_memcg_node are additionally provided. They allow to get per-memcg
> > > and/or per-node object count and shrink only a specific memcg/node.
> > 
> > Cool!
> > 
> > I've been starting to sketch out some shrinker improvements of my own, perhaps
> > we could combine efforts.
> 
> Thanks! Absolutely!
> 
> > The issue I've been targeting is that when we hit an
> > OOM, we currently don't get a lot of useful information - shrinkers ought to be
> > included, and we really want information on shrinker's internal state (e.g.
> > object dirtyness) if we're to have a chance at understanding why memory isn't
> > getting reclaimed.
> > 
> > https://evilpiepirate.org/git/bcachefs.git/log/?h=shrinker_to_text
> > 
> > This adds a .to_text() method - a pretty-printer - that shrinkers can
> > implement, and then on OOM we report on the top 10 shrinkers by memory usage, in
> > sorted order.
> 
> We must be really careful with describing what's allowed and not allowed
> by these callbacks. In-kernel OOM is the last-resort mechanism and it should
> be able to make forward progress in really nasty circumstances. So there are
> significant (and not very well described) limitations on what can be done
> from the oom context.

Yep. The only "interesting" thing my patches add is that we heap-allocate the
strings the .to_text methods generate (which is good! it means they can be used
both for printing to the console, and by sysfs code). Memory allocation failure
here is hardly the end of the world; those messages will just get truncated, and
I'm also going to mempool-ify printbufs (might do that today).

> > Another thing I'd like to do is have shrinkers report usage not just in object
> > counts but in bytes; I think it should be obvious why that's desirable.
> 
> I totally agree, it's actually on my short-term todo list.

Wonderful. A request I often get is for bcachefs's caches to show up as cached
memory via the free command - a perfectly reasonable request - and reporting
byte counts would make this possible.
