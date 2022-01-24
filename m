Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01449A815
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316279AbiAYCzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3413314AbiAYAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:38:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFFFC061344
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:22:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l16so17755733pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8CStIv8gWVcbwkpZIV3t9cr9JCPK3W/EzXr/N1vDHDQ=;
        b=a3sjhR1W/0gJU/Z264ICYZpnu2bMWB04KHm59D9hScDkQf7aKJ6Gj8RvuJey4xiC+C
         QnIkj57ghqWEwz6MrKdKplZNogaX9X0gTYHtCwc75WYKUMpR82+CiDFuzIeVXfJiiLP7
         mRxWndDdm1NvRp4ITy6Jj19llN/7gGPeWO7wxyFxQa7pdEtTBFMJ71mWuqACY682wQbl
         KAkT7OGkDIsDxdQaWJgLXg77CgaBAMgDfRSNFdmpHseA69bGQMYQE7JvQmVr2UTRZLP6
         zVyTx/rvyPJ6OPxOiSVMP4UVN0uEt1cDkTtMQP7fkDJ2zOkg+XBbmy7Dp2DGNreDA88B
         hRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8CStIv8gWVcbwkpZIV3t9cr9JCPK3W/EzXr/N1vDHDQ=;
        b=aikhjBJ7vzTI1hpRimNiPOUsxFUxlD5NqPkZ7vFjcIC2VWf+EaTD+VtjzV2b+b0ZXg
         lAX+dWC/RKozYzwnj5oV6bI6+LqQywJYs9Ojl9SwEjR1NNyc3rf+5HW5IyPSTH3xh6O6
         /gd+tVnRQrpiQhoY0EE7oeUlu8DQvCFxUQLZ0zq6o+GpcPGRm8UisuFKEtqlPE/MCflH
         nVQQnjtnNh20ku7Ljm8Ca5W0gzLndiAmj/ZTyBYLN+y1tONH/hQ4eVQfrPeu0Oe4PIQQ
         Y8QS5TwpjYrdGOfO54GrcsdQ19Hsdc5wnaFRUYbqK7rdmlhkpyd59gAxYBheblYZSz6S
         o3Tg==
X-Gm-Message-State: AOAM5336oD/4ZRn+pYx8Ik30Fs85AshJhDeQGCcZdZsNIPlQST/rGAkT
        AWIaorsM/95WJgpDp7o3QFk=
X-Google-Smtp-Source: ABdhPJwlxStjO9LleOKukjnqzaOR9g9H559VVJIMQw0oL8Q3C/NYJRgHb96mhc2gTQinZ2kP4jc+xw==
X-Received: by 2002:a17:902:e8c9:b0:149:b88d:5980 with SMTP id v9-20020a170902e8c900b00149b88d5980mr16033490plg.171.1643062926493;
        Mon, 24 Jan 2022 14:22:06 -0800 (PST)
Received: from google.com ([2620:15c:211:201:ab64:bd9c:3c16:89c8])
        by smtp.gmail.com with ESMTPSA id y41sm4707418pfa.213.2022.01.24.14.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:22:05 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 24 Jan 2022 14:22:03 -0800
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
Message-ID: <Ye8mi80ObVZvLdS1@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
 <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
 <YenPK/JVNOhbxjtr@google.com>
 <YeqEBAKJ6NUjLQhr@dhcp22.suse.cz>
 <YessDywpsnCyrfIy@google.com>
 <Ye54ELlNBpeHoXsj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye54ELlNBpeHoXsj@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:57:36AM +0100, Michal Hocko wrote:
> On Fri 21-01-22 13:56:31, Minchan Kim wrote:
> > On Fri, Jan 21, 2022 at 10:59:32AM +0100, Michal Hocko wrote:
> > > On Thu 20-01-22 13:07:55, Minchan Kim wrote:
> > > > On Thu, Jan 20, 2022 at 09:24:22AM +0100, Michal Hocko wrote:
> > > > > On Wed 19-01-22 20:25:54, Minchan Kim wrote:
> > > > > > On Wed, Jan 19, 2022 at 10:20:22AM +0100, Michal Hocko wrote:
> > > > > [...]
> > > > > > > What does prevent you from calling lru_cache_{disable,enable} this way
> > > > > > > with the existing implementation? AFAICS calls can be nested just fine.
> > > > > > > Or am I missing something?
> > > > > > 
> > > > > > It just increases more IPI calls since we drain the lru cache
> > > > > > both upper layer and lower layer. That's I'd like to avoid
> > > > > > in this patch. Just disable lru cache one time for entire
> > > > > > allocation path.
> > > > > 
> > > > > I do not follow. Once you call lru_cache_disable at the higher level
> > > > > then no new pages are going to be added to the pcp caches. At the same
> > > > > time existing caches are flushed so the inner lru_cache_disable will not
> > > > > trigger any new IPIs.
> > > > 
> > > > lru_cache_disable calls __lru_add_drain_all with force_all_cpus
> > > > unconditionally so keep calling the IPI.
> > > 
> > > OK, this is something I have missed. Why cannot we remove the force_all
> > > mode for lru_disable_count>0 when there are no pcp caches populated?
> > 
> > Couldn't gaurantee whether the IPI is finished with only atomic counter.
> > 
> > CPU 0                               CPU 1
> > lru_cache_disable                   lru_cache_disable
> >   ret = atomic_inc_return
> >                                     
> >                                    ret = atomic_inc_return
> >   lru_add_drain_all(ret == 1);     lru_add_drain_all(ret == 1)
> >     IPI ongoing                    skip IPI
> >                                    alloc_contig_range
> >                                    fail
> >     ..
> >     ..
> > 
> >    IPI done
> 
> But __lru_add_drain_all uses a local mutex while the IPI flushing is
> done so the racing lru_cache_disable would block until
> flush_work(&per_cpu(lru_add_drain_work, cpu)) completes so all IPIs are
> handled. Or am I missing something?

 CPU 0                               CPU 1

 lru_cache_disable                  lru_cache_disable
   ret = atomic_inc_return;(ret = 1)
                                     
                                    ret = atomic_inc_return;(ret = 2)
                                    
   lru_add_drain_all(true);         
                                    lru_add_drain_all(false)
                                    mutex_lock() is holding
   mutex_lock() is waiting

                                    IPI with !force_all_cpus
                                    ...
                                    ...
                                    IPI done but it skipped some CPUs
               
     ..
     ..
 

Thus, lru_cache_disable on CPU 1 doesn't run with every CPUs so it
introduces race of lru_disable_count so some pages on cores
which didn't run the IPI could accept upcoming pages into per-cpu
cache.
