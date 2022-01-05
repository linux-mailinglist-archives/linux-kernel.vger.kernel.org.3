Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9522E485A65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiAEVGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiAEVG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:06:29 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900EC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:06:29 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y18so652855iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EolGbdgsNcnhwpXhAEL04icCDLJTUPTjvI9j2SgExNc=;
        b=hjEtr3Wm65nDdvFeBKPgdi6ecGQx2AMgYvAL1GIG2JFvfaR8bvZfXlr+3C4UNqtgCY
         tGt3ZR+DCES7x1oweqv+V/SjgIyUD3XBY51D+qf75Jsp5ToIn5bKz+rb8akGq8GGCtM1
         7/s4sRtkED0EZ1tg3lSmLccqe9B+JYGumPgJnNSSlCUirczEknhsSFuBlBTHRsdJhneo
         4UgUt5FMJDlj2rRm5gQVs814iwNGWTfWnfpoKGZfgk1DcIsnwyTH9WP1mZbR4IuWEzAR
         uO9IasOlN41P1Yuaf1EzsVl1R0piiDZ99wNbzK7chG/GzLlkDdVEprhucf9ThCq5c326
         Pj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EolGbdgsNcnhwpXhAEL04icCDLJTUPTjvI9j2SgExNc=;
        b=FgHF7+ajonEOj/e6v2mFhtBzLnPPFxVaCH7aPK1sUXxie1yeaAzXKs0Yus2AKYxgHg
         LDejnflpRO+CmW/zmKodx7Q2+z436q7iQIdhR52Jw5h9IFtbYF94Fh9AtO5EpRtBdyc4
         gFPcUjdWAsLH20dyPIARV8sQzgyJuelPMNjt7haymLlfF8+nzyUyoCVAJHwxTdF7x7xJ
         zdHJGq8kEGvy81p7fOyOs9JrHhJOsD4m7Lwg/FX2QU9R9X/a7M9ELqVwjMV5TNf+TYkU
         RB4jpGHy562YVny0D+6zpkHrmCkbrKQTI98acVNL91wBCfYSw2geUV0toZ9gXIUaCqfv
         4SJQ==
X-Gm-Message-State: AOAM532bGggGj0BeXcuKRUCJmNROF2mTqekdtCMdwAn3Z9IdQUJBwtHU
        7dOif1vZkS5lTh0XTJO8XioS4w==
X-Google-Smtp-Source: ABdhPJzylreqnU7T8VfsIRP9gdym6+PSAMgz3s5D6kp+H/7MxNiBwyiVi2f3QxuAuHm3sb7CQnNMDg==
X-Received: by 2002:a02:a40a:: with SMTP id c10mr23211642jal.18.1641416788894;
        Wed, 05 Jan 2022 13:06:28 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5b02:855e:267d:5b0])
        by smtp.gmail.com with ESMTPSA id f2sm22517868iow.33.2022.01.05.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:06:28 -0800 (PST)
Date:   Wed, 5 Jan 2022 14:06:24 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     SeongJae Park <sj@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <YdYIUAC0gopuy8r/@google.com>
References: <YdV4k1+zEbtzmUkK@google.com>
 <20220105112527.23399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105112527.23399-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 11:25:27AM +0000, SeongJae Park wrote:
> On Wed, 5 Jan 2022 03:53:07 -0700 Yu Zhao <yuzhao@google.com> wrote:
> 
> > On Wed, Jan 05, 2022 at 08:55:34AM +0000, SeongJae Park wrote:
> > > Hi Yu,
> > > 
> > > On Tue, 4 Jan 2022 13:22:19 -0700 Yu Zhao <yuzhao@google.com> wrote:
> [...]
> > > I think similar works are already available out of the box with the latest
> > > mainline tree, though it might be suboptimal in some cases.
> > 
> > Ok, I will sound harsh because I hate it when people challenge facts
> > while having no idea what they are talking about.
> > 
> > Our jobs are help the leadership make best decisions by providing them
> > with facts, not feeding them crap.
> 
> I was using the word "similar", to represent this is only for a rough concept
> level similarity, rather than detailed facts.  But, seems it was not enough,
> sorry.  Anyway, I will not talk more and thus disturb you having the important
> discussion with leaders here, as you are asking.

First of all, I want to apologize.

I detested what I read, and I still don't like "a rough concept level
similarity" sitting next to a factual statement. But as Borislav has
reminded me, my tone did cross the line. I should have had used an
objective approach to express my (very) different views.

I hope that's all water under the bridge now. And I do plan to carry
on with what I should have had done.
