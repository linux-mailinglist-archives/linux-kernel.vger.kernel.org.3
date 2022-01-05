Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8D485A74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiAEVMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbiAEVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:12:38 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC9C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:12:38 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o1so371383ilo.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+IvGtL/Cdr/WsdAI8BblKEPdwrJXksPcRkkKFt5itRQ=;
        b=ZaehH+x5c0zMI/IfYQs/P2s8KjVJpoFcoUPnh+aQ843si2v3nD3DC7aBVH2zE+H7IV
         XtKaomiGdT9vzvdrdiYMNczQ4NKF5buM1kOQS4NV1m8sbZ7/KvWCfG6wlcavCzgDRu3z
         IcI7k4fHp3NQ8f1SrS8r5KhG3fearM36RhnFmjv5QN+q4bMI8CpX03N+yOPa4NpnXfdV
         u7ez66TZ5917ahjPpH/7swu5B4GjVkgttA13c7TRCjugt20r8n4f0zTa9bIJ1pCFcC69
         PhdYDdzGv14ETQauuHZaLzl4lRqnrBcSApmHgmYtJAwIvVNNup/UqMg0qa8XdhM6Q1XM
         f0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+IvGtL/Cdr/WsdAI8BblKEPdwrJXksPcRkkKFt5itRQ=;
        b=1A8fu5Qdi0SI0AWnb18F2YcbkJ3ho7CN/4XCs+3aUkExv2J9Qy45jQTFRmPaGz+lCK
         bAdDc7+X/5yOBjHG963pVMhyfmpyHf0y/6F13+6p7748vnF61+OsyvcTJuIjnpiBxDQE
         EWJiGYglt9sLUhIP4i+J9ukldZCD99qrcM4lOx6USZgSajJQ1IOnu4tqDpCcrMiraZeJ
         SJTQSMXOEYkvcWADaUKf2QdxPmtOL62+LHQQzAACfwjdIVqmxBxdiCUeIZyvgAicLTsN
         GB50LfSqdmeR2R4vwE+VPmuo/EJuiaiDzkL/TOito5MVmhUQGvv7Nm/XWturC5tcrHtF
         V8Ow==
X-Gm-Message-State: AOAM532aFlSE+E3iaXz9+/CinDvXNYjsYnJ7R6h2lhE1mRreksCwaSA8
        IC1ZU+Gh5CDtC8CCle9MiLkMmA==
X-Google-Smtp-Source: ABdhPJw1baUlWmMI6qXqkj6NLFvmqM5nQ0X8KL8YRZ2jVPVCm0ebJk8cq3iWAIKjjYEoHOCd/Ir/iA==
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr27203549ilk.51.1641417157408;
        Wed, 05 Jan 2022 13:12:37 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5b02:855e:267d:5b0])
        by smtp.gmail.com with ESMTPSA id z16sm907465ilz.60.2022.01.05.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:12:36 -0800 (PST)
Date:   Wed, 5 Jan 2022 14:12:33 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <YdYJwRQ22qgRsS63@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com>
 <CAHk-=whMbX+GUBY=Fyxo3r-XVvfNyFA+4hUJS7UxgYDxf9Wbcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whMbX+GUBY=Fyxo3r-XVvfNyFA+4hUJS7UxgYDxf9Wbcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:43:13PM -0800, Linus Torvalds wrote:
> On Tue, Jan 4, 2022 at 12:30 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > My goal is to get it merged asap so that users can reap the benefits
> > and I can push the sequels. Please examine the data provided -- I
> > think the unprecedented coverage and the magnitude of the improvements
> > warrant a green light.
> 
> I'll leave this to Andrew. I had some stylistic nits, but all the
> actual complexity is in that aging and eviction, and while I looked at
> the patches, I certainly couldn't make much of a judgement on them.
> 
> The proof is in the numbers, and they look fine, but who knows what
> happens when others test it. I don't see anything that looks worrisome
> per se, I just see the silly small things that made me go "Eww".

I appreciate your time, I'll address all your comments togather with
others' in the next spin, after I hear from Andrew. (I'm assuming he
will have comments too.)
