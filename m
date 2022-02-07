Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235F54AB341
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiBGB4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiBGB4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:56:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1838CC061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:56:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso4033215pjg.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 17:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ns9nrjNUptIXwjY2mn7TbbkWxwvjecCtuZhyj8ZgjZ4=;
        b=ajDD3kAa4rYS4QDTFjBTnSqYnb/r8UsBS5F+ryGtPR/mtMFLANNOxKo4zYBq8ygPJl
         94Wfsu6Ba4K4YtWRyr14DRjKtSUeRvh+Sa+6273bO1IukqjFAxdKwZp23djc77ahEF24
         sm0x1aAJ8GZDHauDlrwBkznhwNm5MKZOJn75Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ns9nrjNUptIXwjY2mn7TbbkWxwvjecCtuZhyj8ZgjZ4=;
        b=i0AlYmAtJagaVScSjzK9Y9vYPtrk0YknooHIC80iZdWvxMWJWG5dhXlFwVPCkC+ocw
         HHsX3YMIt5/hpWB3Wo/S+8TT+J0PQjaqp+hLim/Yes2mZMDTfLIYlG2ws106u0wrs+/y
         7Z8camtulxaPtL1ZlUw/9kqYRTulD/2F4NnV/hUVALcwydjQtBcuxhSPLI5lVzuNH3Un
         W2VZEI8X35bN0wY220pwoVdgNAGJp6tb5ve4Pyh84FJ5u4siIeiaeS8QyVoxiBFjRjPn
         ub/vAie43ktlw4SGmThtZPd8VIlxIjQh4ORZWPW3SNBY9kOGGUXDoLcgW+H00gl9Yc5a
         qeTA==
X-Gm-Message-State: AOAM530pYmNJ+O2EyNAYXIBbwqWNsh02VUlFxlhsEQ5mpbFQ6zhT7SR4
        d82YmvinI4AX/5aGfLxBTWSQig==
X-Google-Smtp-Source: ABdhPJyQSfXQRfnmdKsKDCeLrettCOmyX6eq5emkGZUWKlmjODQ36Vwkk0W8vKqKrOWYotOroo8xQg==
X-Received: by 2002:a17:902:be11:: with SMTP id r17mr14858693pls.22.1644198980325;
        Sun, 06 Feb 2022 17:56:20 -0800 (PST)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id lj3sm8519396pjb.37.2022.02.06.17.56.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Feb 2022 17:56:19 -0800 (PST)
Date:   Mon, 7 Feb 2022 10:56:16 +0900
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     David Rientjes <rientjes@google.com>
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Rebase DAMON_RECALIM watermarks for NUMA nodes
Message-ID: <20220207015616.GA7661@swarm08>
References: <20220204064059.6244-1-tome01@ajou.ac.kr>
 <20220204090642.2425-1-sj@kernel.org>
 <20220204110318.GA9391@swarm08>
 <bee4cb14-15d5-bef5-674-c0f574c35bc4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee4cb14-15d5-bef5-674-c0f574c35bc4@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 02:28:18PM -0800, David Rientjes wrote:
> On Fri, 4 Feb 2022, Jonghyeon Kim wrote:
> 
> > > > This patch allows kdamond thread to select watermark options for monitoring
> > > > specific node or whole system free memory.
> > > 
> > > Why only specific NUMA node or whole system, instead of each NUMA node?  Are
> > > you running DARC for only specific NUMA node?  If that's the case, I think
> > > implementing your own DAMON-based policy in user space might be a better
> > > choice.  For example, you could implement and use a user-space daemon that
> > > monitors free memory ratio of each NUMA node and adjusts the watermarks.
> > > 
> > 
> > I have tested DAMON_RECLAIM for each NUMA node by using a module. But, I felt
> > that the goal of DAMON_RECLAIM is dealing with the entire system memory or
> > specific monitoring regions by using module parameters. So, I hoped to add more
> > options for DAMON_RECLAIM on the NUMA system.
> > 
> > Another thing I considered is the problem of correlation between NUMA node range
> > and monitoring start/end addresses, such as "What if we monitor target that
> > spans multiple nodes?".
> > In that case, I guess we have to decide the policy for watermarks.
> > 
> > > Hope I'm not making you get me wrong.  You found the important limitation of
> > > DAMON_RECLAIM, thank you!  I really hope DAMON_RECLAIM to evolve to handle the
> > > case.  I'm just saying this patch looks like specialized for your special case,
> > > and there could be a better approach for that.
> > > 
> > 
> > If you agree that each NUMA node is able to have its own DAMON_RECLAIM daemon
> > threads, I will add that codes in the next patch.
> > 
> 
> It seems like one DAMON context per NUMA node is required for this, no?  
> 

Exactly, what I intend it.

> In other words, since each context has its own set of memory regions that 
> it monitors and set of watermarks that it must abide by, if we want per 
> NUMA node proactive reclaim then each node must have its own context that 
> is coordinated by userspace if we want to do system-wide proactive 
> reclaim.

Yes, that's why I was concerned about the correlation between the NUMA range and
monitoring regions by userspace parameter. Therefore, I plan to add new
parameters for per NUMA node proactive reclaim and specific monitoring target
regions including system-wide proactive reclaim.
