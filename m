Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB1533130
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiEXTDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiEXTDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:03:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF53DA66
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:01:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g3so15424752qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1NyblKLcbohBQoY7VD4CeyW8jWo8CQASjSrNPOY/Yo=;
        b=5jbLkbR/uOOEGcHuRkQuqxaY6Whn0WWZJI73E9T6SlozE5nWJfDFv28tOhdw2Irpoo
         ynu/oD5zPSoRnvOuieUuisexDncUJ9EhvY4IxA0FYIs846o/GA08BcTErhQHfklV/qf0
         jg0IcxxINtvlr2Bxdr4w1FKtN4Hr/+eb58jqrlcI8O9fldRZrzN4qtR3yJ5NQHkSSx87
         QVBY1FH1zFqA1zpBb6JeXcIx3cjBFrwrFWuWBTy1j0DS5ZAGQwmItNhPF5kCU5Dw8Pmf
         843ZDy7B/DAg+XUmHuEO5HppBvbMLLsifaMMzS6+fo5EuIPCFt1xQwZG7gG/nNEj74ye
         IG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1NyblKLcbohBQoY7VD4CeyW8jWo8CQASjSrNPOY/Yo=;
        b=F15Jd4/MQPzgjQxOR9swKWAFlsYQmy0b38IyJP5arI5AYP8xfxCEsXy8Cj/bXxwv0a
         s9UQOX7/YGuVhATjPXJ//5zOW0F1Cf0L2URNrytwX92gmPQQN99JkxG5uqEeqVyoSPp0
         CGUdBSU9/7tdUa6qe8RgZFh024Czl1hTlQjWPzXrELWnqAD5yb5Pfj7GVF+tEZPw1Kft
         UPf1hKeR1I074KF1LBcCAdGWs5SBt1asCY7IhrBbqFpRnT47sVENY/KKcUcn3wL8Eidf
         +SNI0fGHFa4EbxdGUa1fpO2UvphPj8gdqDQLHfE7aFxAZHC2qUxNUOUzlITXS0EuHm5Z
         eDdg==
X-Gm-Message-State: AOAM530FdZnfi175hYC+6PCHkJSMnNiW5ovfi4j0a9rSn0ZVKgI4VCu4
        Xu62IUa5wRaVsxU+KTouiszOD9S6/ZRUBQ==
X-Google-Smtp-Source: ABdhPJwyJDma/cDSH1QDMd/26bP9vKjCHlXwU76/B8cVC9D3MAicjzWFuXlvICvkqo3oAg4VMZPAjQ==
X-Received: by 2002:a05:622a:110c:b0:2f3:d347:6f8d with SMTP id e12-20020a05622a110c00b002f3d3476f8dmr21461556qty.403.1653418886409;
        Tue, 24 May 2022 12:01:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id l11-20020ac84a8b000000b002f39b99f6c4sm48783qtq.94.2022.05.24.12.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:01:26 -0700 (PDT)
Date:   Tue, 24 May 2022 15:01:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <Yo0rhX2LFNPTv47b@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-2-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 02:05:41PM +0800, Muchun Song wrote:
> Pagecache pages are charged at the allocation time and holding a
> reference to the original memory cgroup until being reclaimed.
> Depending on the memory pressure, specific patterns of the page
> sharing between different cgroups and the cgroup creation and
> destruction rates, a large number of dying memory cgroups can be
> pinned by pagecache pages. It makes the page reclaim less efficient
> and wastes memory.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer.
> 
> Therefore, the infrastructure of objcg no longer only serves
> CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> can reuse it to charge pages.
> 
> We know that the LRU pages are not accounted at the root level. But
> the page->memcg_data points to the root_mem_cgroup. So the
> page->memcg_data of the LRU pages always points to a valid pointer.
> But the root_mem_cgroup dose not have an object cgroup. If we use
> obj_cgroup APIs to charge the LRU pages, we should set the
> page->memcg_data to a root object cgroup. So we also allocate an
> object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Looks good to me. Also gets rid of some use_hierarchy cruft.
