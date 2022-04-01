Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3024E4EF85F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348977AbiDAQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350049AbiDAQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:52:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62712BFB1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:42:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h1so3630483edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTqDBZtRO8QnWfL23gP1DRPpXrltO+NA5FczV05jkD4=;
        b=Rj8zofv7tpaZZsXfSXIPeMTTZecFcaCZtKaXdRKsKSpG1YkDdZe+uGGKP8s3aMdCR2
         8NXFd3LIiuNIzkQy+kI+QQcbu1s/9Hzw9B2WuysWFOCNiiwPlTBg5Tb5BZuQKxakX8eo
         jseGFMmGBHZgoK+AXE5Mboi4dv44hMm1UxGAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTqDBZtRO8QnWfL23gP1DRPpXrltO+NA5FczV05jkD4=;
        b=VsswWG8DcX8OUX2f0DYBL0gB0vA9JxC7qAvpGLZBB1K8fMaTw83FQT/QoIDncnwSbo
         179Hx7hbLzQtaN9cA62TIXN6DwOOMNgjnwqC05+YvedUFIVmmftEuieAvyZGxZ+T8/Kq
         WrRreXuw7XP4v8zBgASBhTFrODcXl3jhWgWOP14ez725GG4hO8GVh4Qg6lXJ8tn7gN36
         V8/GUFSMD6XIub2PQ9y9osNc15dJm9IWIag6B3qgs/zVEGG92G6Ke767Fa9E9FxEcDFt
         7uw50aJTydoMB5FgrvsEIbBvijgjDqkI1xrOLIKyw+G/drHgfIjdF2m1xEXwY/hIV55v
         bxsA==
X-Gm-Message-State: AOAM53306vdCJBSu2XFD/ndEkXuqmYWF5J6qR7ZhrRdKWzExYwRNIHTr
        sPsEhj9k19sWcvrdwCJKreHjVwQj8EPBCDTMqZI=
X-Google-Smtp-Source: ABdhPJz26q5OAFl/Fl4L46/DLwM/42OsX2z5hdmoa1ny/tTkGWJDxgwVcQ663+LzzqDkEsDwerVzeQ==
X-Received: by 2002:aa7:c64c:0:b0:418:ecf7:afaa with SMTP id z12-20020aa7c64c000000b00418ecf7afaamr22188154edr.38.1648831349833;
        Fri, 01 Apr 2022 09:42:29 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id jg15-20020a170907970f00b006e0466dcc42sm1171856ejc.134.2022.04.01.09.42.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 09:42:29 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id u16so5076349wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:42:29 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr14234891lja.443.1648830941043; Fri, 01
 Apr 2022 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220401094214.GA8368@xsang-OptiPlex-9020>
In-Reply-To: <20220401094214.GA8368@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 09:35:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+mJrTvun6qkdEnkZk9FSyj6vNYU2j7QY-iPn0g_y1nw@mail.gmail.com>
Message-ID: <CAHk-=wg+mJrTvun6qkdEnkZk9FSyj6vNYU2j7QY-iPn0g_y1nw@mail.gmail.com>
Subject: Re: [NUMA Balancing] e39bb6be9f: will-it-scale.per_thread_ops 64.4% improvement
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 2:42 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> FYI, we noticed a 64.4% improvement of will-it-scale.per_thread_ops due to commit:
> e39bb6be9f2b ("NUMA Balancing: add page promotion counter")

That looks odd and unlikely.

That commit only modifies some page counting statistics. Sure, it
could be another cache layout thing, and maybe it's due to the subtle
change in how NUMA_PAGE_MIGRATE gets counted, but it still looks a bit
odd.

               Linus
