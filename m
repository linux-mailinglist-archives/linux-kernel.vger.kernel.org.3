Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0554AA4FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378679AbiBEAUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbiBEAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:20:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC0EDF8E3CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:20:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d1so6463250plh.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 16:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GDyjcpi8vHQ1agJqGTPZSuuudSAi9QTyQsSvsAWA4Y=;
        b=MvBO/8hngqIcKHzGEnGS4QtxuvdFzrLeGWn2ecnLcqh4XYPJB9liEUjruIa3/Zk/4o
         LgRlwzm9pt5Z+gKKQdV/AyR6c7I86uMD6GJ8C4uc2/V4tvX8uo8vKY7WCoOWk+fpBXMi
         UBL5P8QARq7njELSs3IPB4jOJHDywMqRHLwukfmnjbGCVW+6olknVSzoW22wsY8K/1qi
         77HeJOudnpcCdrFnBQitEFu5QtvGij0H1SlLYxyFVot1PuxgFN04PQcKeJ0orrK0Zemy
         15xcdqGFdV6UhKVU4PYYCux9k/qaPMksSHvJbu0D/Xudu+8ik87PGzl3IEO84+USkiTt
         JG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GDyjcpi8vHQ1agJqGTPZSuuudSAi9QTyQsSvsAWA4Y=;
        b=JMEtrd2OoDAIabABpMlxw+6BAnxeGzSD8q7U5iQrDqDJSZfoDNVTYoG3eooOlMHGJI
         kPbgr4TxxOvR5KR7fOw05j2JWXuk6mdN/wk2wcTyFvuMbNIcZhFio415C5RR1qrB/lF3
         uMEf4NfMiHluqF27NkkFNJcj81x2UFd+Oxp34MnNK09tx2bEDkRc4hgTEb9fWCqYqpFJ
         w/Cmuy2+TCSonwVO7dBhakp9cC4XyoNhzohNP9NxHyEKPTNA3nXLlWRxSuWvrIsMUoQQ
         CX8s07sBrPu7wig/D/Ygv/qQdVCfacBEet+geo84clTQ6U5g6fYTjVOCXv8Dd5bW87DA
         hqxg==
X-Gm-Message-State: AOAM533rLG1cxwaaovkOJ0zuj5W5LpCaCQvN0UjYAHgfms548RIxd1kp
        j2FM/hr0ChNBUKZe9LAoCiNsRbxoYckbWBeWc05a6A==
X-Google-Smtp-Source: ABdhPJxMXaL/MN6VAzpBxip43hS5m0dlmvUn9t8wNi7jfw1i0zh8gaz+8+FFufjKXZpoSVh2D4kL9L4o1TzOLu7LwuU=
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr5806897pls.147.1644020406999;
 Fri, 04 Feb 2022 16:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-39-ira.weiny@intel.com>
 <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com> <20220205000953.GD785175@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220205000953.GD785175@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 16:19:56 -0800
Message-ID: <CAPcyv4jmnUbywDcXOAL9DwKxGaUf9cw9iDYbDcz6_CHyYPtytw@mail.gmail.com>
Subject: Re: [PATCH V8 38/44] memremap_pages: Define pgmap_mk_{readwrite|noaccess}()
 calls
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 4:10 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Feb 04, 2022 at 10:35:59AM -0800, Dan Williams wrote:
> > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > >
>
> [snip]
>
> I'll address the other comments later but wanted to address the idea below.
>
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index f5b2be39a78c..5020ed7e67b7 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1492,6 +1492,13 @@ struct task_struct {
> > >         struct callback_head            l1d_flush_kill;
> > >  #endif
> > >
> > > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > > +       /*
> > > +        * NOTE: pgmap_prot_count is modified within a single thread of
> > > +        * execution.  So it does not need to be atomic_t.
> > > +        */
> > > +       u32                             pgmap_prot_count;
> > > +#endif
> >
> > It's not at all clear why the task struct needs to be burdened with
> > this accounting. Given that a devmap instance is needed to manage page
> > protections, why not move the nested protection tracking to a percpu
> > variable relative to an @pgmap arg? Something like:
> >
> > void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> > {
> >        migrate_disable();
> >        preempt_disable();
>
> Why burden threads like this?  kmap_local_page() is perfectly able to migrate
> or be preempted?
>
> I think this is way to restrictive.

kmap_local_page() holds migrate_disable() over the entire mapping, so
we're only talking about preempt_disable(). I tend to think that
bloating task_struct for something that is rarely used "kmap on dax
pmem pages" is not the right tradeoff.
