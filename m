Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C245A4967A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiAUV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiAUV4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:56:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D08C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:56:34 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so9747483pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WB/i8Zno/EA3UrQ+waTtgBHLjvayEDHdGDDDKHDQtoY=;
        b=mz6hq5mpAMEhKxZp313MsiLVlDOudEcTc/cLj3qPUUHOWVR50CWEjpAPxkIPz2lE7N
         QEjl9CL9ShR2o3RrnURvsVwjdaOTBG0wk5bjgBBz0fKCGKnnJxgp0ZTocainI0UVmaPr
         5Qq040Klo/mPPMwviNYREtRHRrjwYVOWfOHa4/Bfh0Q+kBXvbD+CcdZ5yJr4Dwk20Ai9
         CatHFs2OJIiDBRXCRm8EWqC3D93I6uBsiJoaHxtWC5zq8q88+IcoMU4wt7r2kumebra8
         ZSErCUvkSmOQMD7E1yEhY5scrlW5huUsieGOSc38gF3u5Dl3aUoEo9Oy3v9btf0F0wna
         bZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WB/i8Zno/EA3UrQ+waTtgBHLjvayEDHdGDDDKHDQtoY=;
        b=BiE/2e/mb95j1tXu1Y9016pl2hRe9rD5vX+ZqcUApiNGuM35GKm3YrZ3aKQybKGGBy
         Yb/YkQ7h4znH3QU1AA5wn90zsbInGfvUIAToN1o3li0LrCSrrJHftwjlWykQLB1xaMh+
         F0QkHPug4/qfDUWMgINSQB5Nd6HD2+KXTKz5RbnS8QzvhB0Cv7r69cSBaShKOKe8wRrQ
         Kn5/sVhHBdmaRU8VXz18mIrNxJfCI6nbneei5hF7xbEgHtotTO/UK0r+OsQLzCqWw9UP
         M7M0EzXycfYz5tw10/pzowz2oaqeLS1YyCYbqvIBWAbARyvE1ShURVYQExyo1TVaDWNw
         fqiA==
X-Gm-Message-State: AOAM533Ib6tPMT67/Ui6estddvoxaci5AnuTmoSUYnWV4HchaYD7YGPT
        hcKRyhuqTh9jHoF2yIqgPf8=
X-Google-Smtp-Source: ABdhPJydBlBHM5eX5KYl3wNuArOmn/hiQvWabvZkfPlhdTcqWMI16whV737dEy1Ohdrr3/+NP/GLFA==
X-Received: by 2002:a17:902:b414:b0:142:431f:3d1c with SMTP id x20-20020a170902b41400b00142431f3d1cmr5537210plr.32.1642802194129;
        Fri, 21 Jan 2022 13:56:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8ee4:9dbe:c4bd:f5f8])
        by smtp.gmail.com with ESMTPSA id r19sm5928935pjz.6.2022.01.21.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:56:33 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 21 Jan 2022 13:56:31 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YessDywpsnCyrfIy@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
 <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
 <YenPK/JVNOhbxjtr@google.com>
 <YeqEBAKJ6NUjLQhr@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeqEBAKJ6NUjLQhr@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:59:32AM +0100, Michal Hocko wrote:
> On Thu 20-01-22 13:07:55, Minchan Kim wrote:
> > On Thu, Jan 20, 2022 at 09:24:22AM +0100, Michal Hocko wrote:
> > > On Wed 19-01-22 20:25:54, Minchan Kim wrote:
> > > > On Wed, Jan 19, 2022 at 10:20:22AM +0100, Michal Hocko wrote:
> > > [...]
> > > > > What does prevent you from calling lru_cache_{disable,enable} this way
> > > > > with the existing implementation? AFAICS calls can be nested just fine.
> > > > > Or am I missing something?
> > > > 
> > > > It just increases more IPI calls since we drain the lru cache
> > > > both upper layer and lower layer. That's I'd like to avoid
> > > > in this patch. Just disable lru cache one time for entire
> > > > allocation path.
> > > 
> > > I do not follow. Once you call lru_cache_disable at the higher level
> > > then no new pages are going to be added to the pcp caches. At the same
> > > time existing caches are flushed so the inner lru_cache_disable will not
> > > trigger any new IPIs.
> > 
> > lru_cache_disable calls __lru_add_drain_all with force_all_cpus
> > unconditionally so keep calling the IPI.
> 
> OK, this is something I have missed. Why cannot we remove the force_all
> mode for lru_disable_count>0 when there are no pcp caches populated?

Couldn't gaurantee whether the IPI is finished with only atomic counter.

CPU 0                               CPU 1
lru_cache_disable                   lru_cache_disable
  ret = atomic_inc_return
                                    
                                   ret = atomic_inc_return
  lru_add_drain_all(ret == 1);     lru_add_drain_all(ret == 1)
    IPI ongoing                    skip IPI
                                   alloc_contig_range
                                   fail
    ..
    ..

   IPI done



