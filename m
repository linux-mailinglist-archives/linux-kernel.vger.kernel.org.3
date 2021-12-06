Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3BD46AE82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377407AbhLFXhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350946AbhLFXhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:37:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75256C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:34:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so8139398plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 15:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p8EW1Ac6IzpAeuuHrkE2OKk7Spc6Hw56mWD40d+uSE8=;
        b=Hn7ft3bHGqdFcYx037N7qCj/mnnzh0pf81Bmim2KDg4gIfTADuPGC7YwsAqq0asjpu
         8cGCAErt8FmjnZ+o/yyThMjIMUNizmxHDzy1l3mGJFiSSwnXLVYRatiU4IDHuPdmdOsG
         wCTkxsbu8TeyLKh1Bcs4ges3KMhafYuXsLzGzscjuBAxJ89TR/SrY+KyB94W669YSqbk
         ajP9d5/48cpEPuVEJmQJQy7y/QLBzHmkJT3Lm/D+jZg21cTzTJ4EP2VZ5sCLH9C9tV16
         QmJgU0tr2XaBZSzazbCAFysujmtCHqJQsSxwpBq5XyKxW2mtRV8jLs4JqvZh0iiSf58Q
         OYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=p8EW1Ac6IzpAeuuHrkE2OKk7Spc6Hw56mWD40d+uSE8=;
        b=xNmkoOpPPCPnBDtGJAqalZV6H3k6v6X2/NW9sVU2lGckTykcoKdWWcy8ZnBJ+woTGm
         W84ht3UiggXNcTFR/O/aDJjsbsoLfCbLv2SDI9LMgPyvLW+Y6sA4vErbQV8zD3ykuoee
         YIMM7et+lfT8Oxlfws4qNqQZuVU7L+GJeTDJPFdakzAB4EfQjl+WN89F5CZnggT0Yvjn
         U9tWoLaFvk6bdISEInIRGdcLrl2VSqZ689hxD+qBf786L2rdJO3vdO0v7VOaFznjzCAK
         aAyUjnJHnbLOM95Vy6nGhfp8chHaNigh9/RPHeDPVBAb8ZtZIMo6ATZUuTCypXBbgZ3R
         bE8g==
X-Gm-Message-State: AOAM533Swfyz8so3LwPPIuGxMxPwg1XE1QAxHnwSurbCogMcTpFh7AeL
        qtn6jhQLdy3s+S+YknUj7l8=
X-Google-Smtp-Source: ABdhPJyv+ENk2j94NlhoLFkMFT4av9j5znmw0xgAcTBizJCNYfWANaRZRDXauJnqUIOTXgCLuoz78A==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr2090680pjb.153.1638833661859;
        Mon, 06 Dec 2021 15:34:21 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2d37:bc7d:9c01:7721])
        by smtp.gmail.com with ESMTPSA id d6sm10770471pgv.48.2021.12.06.15.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:34:21 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 6 Dec 2021 15:34:19 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <Ya6d+zC/CsYAp0Gf@google.com>
References: <20211206221006.946661-1-minchan@kernel.org>
 <20211206150421.fc06972fac949a5f6bc8b725@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206150421.fc06972fac949a5f6bc8b725@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:04:21PM -0800, Andrew Morton wrote:
> On Mon,  6 Dec 2021 14:10:06 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > lru_cache_disable involves IPIs to drain pagevec of each core,
> > which sometimes takes quite long time to complete depending
> > on cpu's business, which makes allocation too slow up to
> > sveral hundredth milliseconds. Furthermore, the repeated draining
> > in the alloc_contig_range makes thing worse considering caller
> > of alloc_contig_range usually tries multiple times in the loop.
> > 
> > This patch makes the lru_cache_disable aware of the fact the
> > pagevec was already disabled. With that, user of alloc_contig_range
> > can disable the lru cache in advance in their context during the
> > repeated trial so they can avoid the multiple costly draining
> > in cma allocation.
> 
> Isn't this racy?
>  
> > ...
> >
> > @@ -859,7 +869,12 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
> >   */
> >  void lru_cache_disable(void)
> >  {
> > -	atomic_inc(&lru_disable_count);
> > +	/*
> > +	 * If someone is already disabled lru_cache, just return with
> > +	 * increasing the lru_disable_count.
> > +	 */
> > +	if (atomic_inc_not_zero(&lru_disable_count))
> > +		return;
> >  #ifdef CONFIG_SMP
> >  	/*
> >  	 * lru_add_drain_all in the force mode will schedule draining on
> > @@ -873,6 +888,7 @@ void lru_cache_disable(void)
> >  #else
> >  	lru_add_and_bh_lrus_drain();
> >  #endif
> 
> There's a window here where lru_disable_count==0 and new pages can get
> added to lru?

Indeed. If __lru_add_drain_all in core A didn't run yet but increased
the disable count already, lru_cache_disable in core B will not see
those pages in the LRU. Need to be fixed it.

Thanks, Andrew.
