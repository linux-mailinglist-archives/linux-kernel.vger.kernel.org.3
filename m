Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4648A59E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbiAKC0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiAKC0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:26:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA732C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:26:13 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id j83so43433396ybg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1ENhSWsAV/dz7z50ZJCYCuaP4VRXWxn4r2j+Sg+6UA=;
        b=T55GOK2PpaNsrGqiMFTAqH2V7QdMHJhf0a3BMQ7I8S2f2h7BI4JXGBsntFUbrKsnrl
         rEzOH+AqALeZAy8Qhyi3rFQo8NaIqguy97C9ERCdlxVx+n7E8WH64/TjwHln91YBdBBk
         AWYzFw4wU9mhtUfJSXGLzZymCyI9uQqeU39t+zioXUDqxTWAI0BMcwXbJxPBATEie6rv
         xQARIPZV9m3Nn76w+UJ2xS8QDkRdVgio/eXbMdoElnUL60H99TIz4WO/aNSZ8URTri7U
         84EE4GnWjFwaNRNtzSO8JCOqqvhya0pINZ5DHiHwfs7OeADtTaDkmdukFBkr8yOlXG57
         zZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1ENhSWsAV/dz7z50ZJCYCuaP4VRXWxn4r2j+Sg+6UA=;
        b=sprBonu+zBN9hg0h2cfa0YHED8ajGjxfCbGbWu/z18tp9ToHAnxNuGLB46sQyuUxlb
         E7KsKdTEMATNm9JWZqAVvLg/uQu7dnX/PNbuJ7T5QSzaRgfJfq0h/8TG/MmtmLH1PChb
         XWc9kwF1vQZgg8pg4zP6SOrVlzXWzCwqPaXhlfSFnoOqzmnCzWfUhQ/9LB4UlEPV3ZfG
         nbELCWuq+H5Bw2FuhpnQT/vlmTpRvP1ux9zsv0U+TBl+yXhSwOQGEVh6aovSsx7xVSpj
         gPpgC3AOvesYpKH1yekwN4bGtPuYNlEsccxNc5M3VJcZxnJK4mnGL+7lWWDqBhMATngI
         A0wA==
X-Gm-Message-State: AOAM532IeQ70JqW8Fg20T/eZ5yw5hksEimEcXg31CPCul296bz+r1b+2
        EcqRvovRjLgKoxLiP+YhKib5m6VDc16/JjFm7swysw==
X-Google-Smtp-Source: ABdhPJxowJER3pmqEV7tisAM0wfJwlxJtB+yz5CCw6efvbLqhAjzPpwfWxGFtuk58ztzM2xStozGxj4PibwWfRfK6RY=
X-Received: by 2002:a25:b194:: with SMTP id h20mr3367724ybj.485.1641867973020;
 Mon, 10 Jan 2022 18:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20220111010302.8864-1-richard.weiyang@gmail.com> <20220111010302.8864-2-richard.weiyang@gmail.com>
In-Reply-To: <20220111010302.8864-2-richard.weiyang@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 11 Jan 2022 10:25:37 +0800
Message-ID: <CAMZfGtWBt+qYB1-NS+G8Tzk0pm6UZGvENZFBWrz+i35=N1kOAw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/memcg: mem_cgroup_per_node is already set to 0 on allocation
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:03 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> kzalloc_node() would set data to 0, so it's not necessary to set it
> again.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
