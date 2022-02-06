Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD14AB2A6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347314AbiBFW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiBFW2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:28:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A674C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 14:28:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id on2so2658173pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MOMhnq0ObWXdnjvkc+JCn5dFhi6wxP+jaPhFzcfiR+Y=;
        b=g6mjE7ZN/EP3S8f/BrpdDLzIByOJjKdAQfSFWyMryO64GjtxeG90+v+J4oRMoOzAIo
         24Nc8Zc366/eiIpYTsbMitDpzvmsqufM/+QNEiUCTro7ZiyTMMyWMkvibCIbMxKUwhJt
         o2ASViHoKe7tNQYl6N3xz0gLhh4NbwVF8NjZm6MTt0BtG86OiSzy1n1cNol8bej8ClNR
         GbFHGMb4M+wt2pKEacDu3WPLO907LnkOMOKno1r/rHovW3DaMEzjFt3P/tkfRob4Y4GR
         PPyVzlWLnOmnW4D2+L0OhBr6YzYlP2aANUQFcEqWCBbEOPQoc4wllqjvupGnktwqujOy
         0XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MOMhnq0ObWXdnjvkc+JCn5dFhi6wxP+jaPhFzcfiR+Y=;
        b=hc2/BOJadDHhSLBqvRyp2MqYxubHFJz7rivdRABZGAWP4OHUWM8BwMYljKb/bsffUf
         tbdx5fePeeMElWAN9+MyaC6oZZSuT9vQsvynptuvlD4JAnqCb+5ltaCsgx/ft3fKK9ql
         a6SBUWzAkOBK7DEX7KOQQrmpDHeu+xnOHwlOGVFN8FRHKmi+O0xwbzC6OjcfcU9M45o/
         DkD3LT9ZWyNMBkMi1dY4PN7NpJ8Ghkg+yR+YNtl3uDHhckCsESJiSXCcxzxghs/+dT8D
         lkZIGOauXAJCUrJx9wmZrrylVk3ZuyW4w2qVUcy6Hw92DW3ktQCYmNc13e/Rfl/jcEIT
         fC7w==
X-Gm-Message-State: AOAM532Fe2zvquW546ac2jSIODr8qGRMs8AiG/QFTr0vwef2gGM4NbRa
        nCxD5S87gKYuVpq8SIHGMFWDCg==
X-Google-Smtp-Source: ABdhPJziKUeovI/Gs3yGvpBH1Wdvr4nAodeg+i2AL7iqhM2iP7EiD0H2mV0ji4sZRwUCAozcIAgtjQ==
X-Received: by 2002:a17:90a:4144:: with SMTP id m4mr13481227pjg.77.1644186499779;
        Sun, 06 Feb 2022 14:28:19 -0800 (PST)
Received: from [2620:15c:29:204:dae1:9bee:7b85:4b01] ([2620:15c:29:204:dae1:9bee:7b85:4b01])
        by smtp.gmail.com with ESMTPSA id q32sm6621852pgm.26.2022.02.06.14.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:28:19 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:28:18 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Rebase DAMON_RECALIM watermarks for NUMA
 nodes
In-Reply-To: <20220204110318.GA9391@swarm08>
Message-ID: <bee4cb14-15d5-bef5-674-c0f574c35bc4@google.com>
References: <20220204064059.6244-1-tome01@ajou.ac.kr> <20220204090642.2425-1-sj@kernel.org> <20220204110318.GA9391@swarm08>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022, Jonghyeon Kim wrote:

> > > This patch allows kdamond thread to select watermark options for monitoring
> > > specific node or whole system free memory.
> > 
> > Why only specific NUMA node or whole system, instead of each NUMA node?  Are
> > you running DARC for only specific NUMA node?  If that's the case, I think
> > implementing your own DAMON-based policy in user space might be a better
> > choice.  For example, you could implement and use a user-space daemon that
> > monitors free memory ratio of each NUMA node and adjusts the watermarks.
> > 
> 
> I have tested DAMON_RECLAIM for each NUMA node by using a module. But, I felt
> that the goal of DAMON_RECLAIM is dealing with the entire system memory or
> specific monitoring regions by using module parameters. So, I hoped to add more
> options for DAMON_RECLAIM on the NUMA system.
> 
> Another thing I considered is the problem of correlation between NUMA node range
> and monitoring start/end addresses, such as "What if we monitor target that
> spans multiple nodes?".
> In that case, I guess we have to decide the policy for watermarks.
> 
> > Hope I'm not making you get me wrong.  You found the important limitation of
> > DAMON_RECLAIM, thank you!  I really hope DAMON_RECLAIM to evolve to handle the
> > case.  I'm just saying this patch looks like specialized for your special case,
> > and there could be a better approach for that.
> > 
> 
> If you agree that each NUMA node is able to have its own DAMON_RECLAIM daemon
> threads, I will add that codes in the next patch.
> 

It seems like one DAMON context per NUMA node is required for this, no?  

In other words, since each context has its own set of memory regions that 
it monitors and set of watermarks that it must abide by, if we want per 
NUMA node proactive reclaim then each node must have its own context that 
is coordinated by userspace if we want to do system-wide proactive 
reclaim.
