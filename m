Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF354CC85A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCCVs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiCCVsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:48:23 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F233135D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:47:36 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 185so5067366qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rji+h/iFnFLj8FpzIOhwbt0hO9QMBbgpXl1+qKfBYuc=;
        b=0QaRtijCQd+4yLPVDNG6t4KItjzq5cv6Cz4j3pJ31MSFEfTZ2QL6t4iC0+IbhpcRhL
         XA1asggnqVblhI7DD4KmNbRvLZ6qsGAiIDXPwCg08Q7PBPWoKQ6xShB8uLhuLVEd3UjC
         G/LMYCDVM4Vz60u4gMlT5y8wyP83lrUq+YMIbDxfnjH15YWTBf0jJRqoJBAIrApsIyit
         cKZT6zLJsu3aoQYdF1rJaEBCFFsoakDASpbwinSohf15+B8lhlbhIKq4IlGeIEYdpCGz
         noyWtm2tApSbQVmH+55T/3KIDWuU1e4jDXza05PyYwZKFtK/gejbbS1uor/kGJ6P1CEr
         LMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rji+h/iFnFLj8FpzIOhwbt0hO9QMBbgpXl1+qKfBYuc=;
        b=GudfSQWNolz/d0XuuhGYVeQqnrnWe9fH39WktgOd4YQ7f57cqSXMJBV0pHneQVBz8/
         8ib4/AxRIKOHPJY09s3OfxvtMtqdz3bATGgEI/Gn9xqqmrdYCDiH4OBFysQQeZ5h7U6M
         t8yc08OMZjTCUC/zrpkYXpQMWXqbXgH77ggKJKowT2GOZNnfyeOINyW2ZVAGEz2B1BQj
         hVJJXbwMQK4ry53xigHsHlWA84PZ7VvGH/uIaxsS92NotCody6AiXPqSSuedA4m7C1xR
         rqOudcOddH31VGRfLLVubID6zCht+c1XENqTBtVsV59cpEBlXQKgllmYglJHwtBYoCVq
         37+w==
X-Gm-Message-State: AOAM531tLAojygpr4DEfkXZ6b0amWMPPBvTQc+HdmIvKB46eGMPYxIcg
        mtwPyubAIgL1nZzMGRxsZJnswsBzFZ5dBA==
X-Google-Smtp-Source: ABdhPJzJUziCNDJnJB8R8sdQIxVfsij1G+IbtCXV/19jQT6cDwa4QUOpUlh+W4wxFA5Chnfo25XxHw==
X-Received: by 2002:a05:620a:66c:b0:663:f4:ee5 with SMTP id a12-20020a05620a066c00b0066300f40ee5mr788391qkh.560.1646344055990;
        Thu, 03 Mar 2022 13:47:35 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id o200-20020a37a5d1000000b0064904a35862sm1561405qke.96.2022.03.03.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 13:47:35 -0800 (PST)
Date:   Thu, 3 Mar 2022 16:47:34 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Message-ID: <YiE3do4qCmJ6RsmP@cmpxchg.org>
References: <20220303212956.229409-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303212956.229409-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:29:56PM -0500, Johannes Weiner wrote:
> MADV_DONTNEED historically rejects mlocked ranges, but with
> MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
> there are valid use cases for depopulating locked ranges as well.
> 
> Users mlock memory to protect secrets. There are allocators for secure
> buffers that want in-use memory generally mlocked, but cleared and
> invalidated memory to give up the physical pages. This could be done
> with explicit munlock -> mlock calls on free -> alloc of course, but
> that adds two unnecessary syscalls, heavy mmap_sem write locks, vma
> splits and re-merges - only to get rid of the backing pages.
> 
> Users also mlockall(MCL_ONFAULT) to suppress sustained paging, but are
> okay with on-demand initial population. It seems valid to selectively
> free some memory during the lifetime of such a process, without having
> to mess with its overall policy.
> 
> Why add a separate flag? Isn't this a pretty niche usecase?
> 
> - MADV_DONTNEED has been bailing on locked vmas forever. It's at least
>   conceivable that someone, somewhere is relying on mlock to protect
>   data from perhaps broader invalidation calls. Changing this behavior
>   now could lead to quiet data corruption.
> 
> - It also clarifies expectations around MADV_FREE and maybe
>   MADV_REMOVE. It avoids the situation where one quietly behaves
>   different than the others. MADV_FREE_LOCKED can be added later.
> 
> - The combination of mlock() and madvise() in the first place is
>   probably niche. But where it happens, I'd say that dropping pages
>   from a locked region once they don't contain secrets or won't page
>   anymore is much saner than relying on mlock to protect memory from
>   speculative or errant invalidation calls. It's just that we can't
>   change the default behavior because of the two previous points.
> 
> Given that, an explicit new flag seems to make the most sense.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Just for context, I found this discussion back from 2018:

https://lkml.iu.edu/hypermail/linux/kernel/1806.1/00483.html

It seems to me that the usecase wasn't really in question, but people
weren't sure about the API, and then Jason found a workaround before
the discussion really concluded. I was asked internally about this
feature, so I'm submitting another patch in this direction, but with
more thoughts on why I chose to go with a new flag. Hopefully we can
work it out this time around :-)

Thanks
