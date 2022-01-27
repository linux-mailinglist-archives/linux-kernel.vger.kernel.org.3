Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6039149EB39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbiA0Tmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbiA0Tms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:42:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293AC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:42:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k25so8260547ejp.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlWIcHy/3XR7mwnK/GHpmwHwVvr/nhApahfqBZocrNU=;
        b=YqCrznekqjJGqxJTiBCV9J98MH4sLOY2AlzJgugPm5/1S+vb4pcJxV9Zwm2mcVL5sq
         yOPmh7MmaQfsM0y7I43NHEJJesuDa7jaPzANYVQYPXe/kubBYmv+/msm7zagHrutr6QN
         L7Wk9Blrv1JS4QjFiEsYcfIxdd0N+UgCW6sZnnqKNn/vsbb5p9+SNSzu+Udg2f4pR2e3
         4S5keBjy2zohERuHuVzADnODSIZMZiT7cky9vprdIm74ZstoTdru90283pSzQttQs+Ei
         b8XtsBlGpgPnU5l+YQK4dP3TUw8HDrLnTPZfGGDMvRpNvYln48idGU1LpLbjXwhw5/5R
         u9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlWIcHy/3XR7mwnK/GHpmwHwVvr/nhApahfqBZocrNU=;
        b=LydJViDv13c/0huGqm4CQqxogzEbQyyDyxgBjYZw9jy/6XtWiybMBQFByFfjufYLKq
         DaxFZu4GzLXYspF0NRPZahsbhsMcbgXGEViL7c47kOwr3UiXfQhQ/tM7IV/t7teXMDzy
         RyZoCqsmXs6ZA42U18gze9N2r0SB5gRJiNCzhBKnHPC1qJjpstsHI3Gke6z9/JQbsQho
         s5H8i70W1xsP5Hc5yiM6sXEmrw3A4vVNQps/7NzwETgDCj9WvLxLhMisBzP+/DOglnjj
         KYZYf6PsygdeR+RkNDq5Vyw/rLWtv763/UaYt/0clwpZh0f4VeAR+eIheWDmw35HomsB
         OhBg==
X-Gm-Message-State: AOAM533BoPfD/6qXMJgl8qB5rTDppAnGzcheLIQVq/EXkGjo6OBJATy7
        cKLRec5+nDqtolNSK5bRM+fMotX2f4Tn//q9cALZvw==
X-Google-Smtp-Source: ABdhPJyRYphRCJufijT8nLWfSafgBSzq7ruAzTjmpKHgO1/ZkxNEN0MqTxVHWccur1KVci8YLBBrAKSYGIwvmUfOKJE=
X-Received: by 2002:a17:907:2d92:: with SMTP id gt18mr3911682ejc.579.1643312566461;
 Thu, 27 Jan 2022 11:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
 <20220126183429.1840447-2-pasha.tatashin@soleen.com> <72cae3c0-e06e-4fe5-24d5-a2c94d99780f@suse.cz>
In-Reply-To: <72cae3c0-e06e-4fe5-24d5-a2c94d99780f@suse.cz>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 27 Jan 2022 14:42:09 -0500
Message-ID: <CA+CK2bCP0iFAdr-4VxiS2ubQT0O0c_j-qS4Q0khhRBCLJqQBrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add overflow and underflow checks for page->_refcount
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> > index 2e677e6ad09f..fe4864f7f69c 100644
> > --- a/include/linux/page_ref.h
> > +++ b/include/linux/page_ref.h
> > @@ -117,7 +117,10 @@ static inline void init_page_count(struct page *page)
> >
> >  static inline void page_ref_add(struct page *page, int nr)
> >  {
> > -     atomic_add(nr, &page->_refcount);
> > +     int old_val = atomic_fetch_add(nr, &page->_refcount);
> > +     int new_val = old_val + nr;
> > +
> > +     VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
>
> This seems somewhat weird, as it will trigger not just on overflow, but also
> if nr is negative. Which I think is valid usage, even though the function
> has 'add' in name, because 'nr' is signed?

I have not found any places in the mainline kernel where nr is
negative in page_ref_add(). I think, by adding this assert we ensure
that when 'add' shows up in backtraces it can be assured that the ref
count has increased, and if page_ref_sub() showed up it means it
decreased. It is strange to have both functions, and yet allow them to
do the opposite. We can also change the type to unsigned.

Pasha
