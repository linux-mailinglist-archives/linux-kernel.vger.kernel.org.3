Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711AD484951
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiADUaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiADUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:30:06 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:30:06 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id f17so29163346ilj.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bul4qlld97QBjtDSOOsdxIpEMimKYTW5dlcNbaowlwI=;
        b=mtOJsGe1HP0q/Qhh/bycX0h7Jl/2jwzWfmiCyFlRg7R9A2TbdfKxdP8MT5k8D3hwYG
         dT7Ui1OUrpbhvH9QaHr78W0WdOnp64FBmr+S7Q0Vpeg5LpyfuffPNRR9HI3Xbxe8isPN
         F1Sjctn+bJI+/w+T9FmffZPNjQUR5pzoQaQXQWByf530JChpNIL06htkS0sLXiE/CxEA
         gLcuxfQ6BwNSvI3d995Wjh3kaRM06X91TN6q8ctqymYXrDluJ4ns16GLmg4BF0TWfb+K
         rTRwjSYscljigBMSX1uYI63ZSp0B+NmdoJSZ0rSu3In2kLIawYXWswXTAj4tL5YXTQGP
         BRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bul4qlld97QBjtDSOOsdxIpEMimKYTW5dlcNbaowlwI=;
        b=19gZOde4rbFKMWtp1UDyc0+4d/zT+27TENB7B//dUPaLvU9sXffen+M/CE0G3vkNAD
         0WzCvEIfYuUnJ8SGPCU3ZH22gMSexMgETudG8zX6xOcsSCorhLylV9gH8SLCgs8AZQoZ
         YHkIyDLLC7XWVmvdtUNRgmtgeuFUILmHBarBmOPsRx7suHmzOj6VK+t69l36elFLTDqt
         FAN+tpvRwZrueXMebhGpooaUPzbfubmeKPeJ6LyHwNVeuwn50ANt/DBrw1XHuoCotE94
         HwzNUFikMTK07z06qBLoqBkOTLpd/BP1HFltS3kpHzaMsnK8SxdsNqHieMepK1NuefEU
         kbrA==
X-Gm-Message-State: AOAM533rYrd2IYIp3HMR+1PWntWx2LTP9APzMzvGXVxQvEaTy+uMpcDN
        4A7B+nMu6k/9KAE/0saKFX6bPA==
X-Google-Smtp-Source: ABdhPJwvrfas8nfe+PA6BOX0tHt36uxsoseV9gaRTUzX91V4WBmk/Mv40lM9zPNj86T6Z6k0gl7T1Q==
X-Received: by 2002:a05:6e02:1567:: with SMTP id k7mr23098838ilu.46.1641328205445;
        Tue, 04 Jan 2022 12:30:05 -0800 (PST)
Received: from google.com ([2620:15c:183:200:6c8c:5506:7ca2:9dfd])
        by smtp.gmail.com with ESMTPSA id k13sm29592220iow.45.2022.01.04.12.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:30:05 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:30:00 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
Message-ID: <YdSuSHa/Vjl6bPkg@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:22:19PM -0700, Yu Zhao wrote:
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.

<snipped>

> Summery
> =======
> The facts are:
> 1. The independent lab results and the real-world applications
>    indicate substantial improvements; there are no known regressions.
> 2. Thrashing prevention, working set estimation and proactive reclaim
>    work out of the box; there are no equivalent solutions.
> 3. There is a lot of new code; nobody has demonstrated smaller changes
>    with similar effects.
> 
> Our options, accordingly, are:
> 1. Given the amount of evidence, the reported improvements will likely
>    materialize for a wide range of workloads.
> 2. Gauging the interest from the past discussions [14][15][16], the
>    new features will likely be put to use for both personal computers
>    and data centers.
> 3. Based on Google's track record, the new code will likely be well
>    maintained in the long term. It'd be more difficult if not
>    impossible to achieve similar effects on top of the existing
>    design.

Hi Andrew, Linus,

Can you please take a look at this patchset and let me know if it's
5.17 material?

My goal is to get it merged asap so that users can reap the benefits
and I can push the sequels. Please examine the data provided -- I
think the unprecedented coverage and the magnitude of the improvements
warrant a green light.

Thanks!
