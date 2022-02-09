Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD284AF0A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiBIMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBIMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08873C03C180
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644406567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XfermB6CMKU1zKQ537x6yTA+IzQs5j2AWlksK8pCcRU=;
        b=RTTwdLCVIBcSbOth+M/OZx1x1gfPdvw8oOU6lo31GHp+gjyFd2vdt8RwPD7Yc1HJWNZQC8
        HD5FfEH5rYcy/JJBsOvzdglnhvbBvUeIKZT6ECuNMOF0t+UmobjdNqwvfmITtyCvXRQSUe
        7QG+1SsK47G/UVxH7Bwksamf8nnAB0Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-_M7WPzw_MVGb_NkfRXv0aw-1; Wed, 09 Feb 2022 06:36:06 -0500
X-MC-Unique: _M7WPzw_MVGb_NkfRXv0aw-1
Received: by mail-wm1-f72.google.com with SMTP id p24-20020a05600c1d9800b0037be98d03a1so1946479wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 03:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XfermB6CMKU1zKQ537x6yTA+IzQs5j2AWlksK8pCcRU=;
        b=sNYnyzalmzHxUrSusOZcIOmdFxQdkeuNcqeNp/McF+Aaz8f+fU6rMm5ISPGfxOuZm1
         Ta6nmMlzVz8Q2vPw96VNbZewLZH5LJTlyp24oITyasPCzlkwCL8/BlAkEZuTWcE61JSd
         eK4fGzVNoD2smdGY7n39Qf0c+vC+7JtkUfYwsSyzA9hQAyuFY1zb6Xl9l7GsVwOVnEKC
         KNG2qVi8Nv9cRSsmQVFMHR2E9lUl+59B6VynpNa8zjoUJ0XGPgSxfBlpVj7QEuLwXVZg
         8cgPo4hOsKDh1SG2USo/KNQRKZGrl9+T/k8ZSmfYp47KFJxwrVQDSNnXn7pBcQsQGLZu
         DMyg==
X-Gm-Message-State: AOAM531j6j9CmfkdFdVmEou3T/m0CcbOMYuAxX5LnK5CBdMnBrtiKDf+
        8jfkMVZ7Ci/SHHrbAU5kbx+Z+KCrfWF7CC4skD+TeU+/Z0y+O/6YsuKRAzkZji1ZZHrLCcV1WSO
        Aaf6ibyT3u6z3B82kNFRbtiqN
X-Received: by 2002:a05:600c:3b97:: with SMTP id n23mr640442wms.116.1644406564898;
        Wed, 09 Feb 2022 03:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0JWcCTHjUFiG4IzG96xqlvCJC9eJ8y4HTIUnEUHpgEQcFZRU1VGpZWbVwcZeHh2mrYMIrCw==
X-Received: by 2002:a05:600c:3b97:: with SMTP id n23mr640405wms.116.1644406564445;
        Wed, 09 Feb 2022 03:36:04 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id z17sm4531039wmf.11.2022.02.09.03.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 03:36:04 -0800 (PST)
Message-ID: <035d9c7a21eb024e336dce0942fa3f85b864aaea.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Date:   Wed, 09 Feb 2022 12:36:02 +0100
In-Reply-To: <b2e7ea31-0a56-6415-474b-a952fb1d36ef@huawei.com>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
         <b5363ced8e17d07d41554da8fde06c410e6688e0.camel@redhat.com>
         <b2e7ea31-0a56-6415-474b-a952fb1d36ef@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-09 at 19:26 +0800, Xiongfeng Wang wrote:
> Hi,
> 
> On 2022/2/9 17:45, Nicolas Saenz Julienne wrote:
> > Hi Xiongfeng, thanks for taking the time to look at this.
> > 
> > On Wed, 2022-02-09 at 16:55 +0800, Xiongfeng Wang wrote:
> > > Hi Nicolas，
> > > 
> > > When I applied the patchset on the following commit and tested on QEMU, I came
> > > accross the following CallTrace.
> > >   commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
> > > 
> > > I wrote a userspace application to consume the memory. When the memory is used
> > > out, the OOM killer is triggered and the following Calltrace is printed. I am
> > > not sure if it is related to this patchset. But when I reverted this patchset,
> > > the 'NULL pointer' Calltrace didn't show.
> > 
> > It's a silly mistake on my part, while cleaning up the code I messed up one of
> > the 'struct per_cpu_pages' accessors. This should fix it:
> > 
> > ------------------------->8-------------------------
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0caa7155ca34..e65b991c3dc8 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3279,7 +3279,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
> >                                 has_pcps = true;
> >                 } else {
> >                         for_each_populated_zone(z) {
> > -                               pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> > +                               pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
> >                                 lp = rcu_dereference_protected(pcp->lp,
> >                                                 mutex_is_locked(&pcpu_drain_mutex));
> >                                 if (lp->count) {
> 
> I have tested it. It works well. No more 'NULL pointer' Calltrace.

Thanks!

-- 
Nicolás Sáenz

