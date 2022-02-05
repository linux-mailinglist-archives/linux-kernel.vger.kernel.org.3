Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C364AA507
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378735AbiBEA0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiBEA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:26:06 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05FC00056B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:26:03 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i30so6433965pfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 16:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUcDtskC/MpS1ZZYsW5rzEoA89IqcWaCPaEQuwNjGpE=;
        b=d7pedpjch1Lrd1t3Fdos5da71cQzVEkApNy3lDkZeNPnRzGcMsGhUKj2e76y7InELE
         /BWb0JleoeX4IX0GkpSNmm3Wism63RVG4MxHo+/9jJd5Mh7LOCQCJhZtiv9wzvbE5KHr
         1SCI7SgELEonxw5i//0r0DFKgCgRY/hhO/cdYK+Uf9Z5IYxnW7KjWtdyBq2dDkFNGpY5
         kVHGjGVyWSLzjUj+SSnZJ3xFuywhq6jDUWDbRIRSpmCIRyC33+huPSnh6iXaJ3PwCdHx
         0StsZReligTszxbvTbG3rVuIsfJd+hyTKlCBBfT44CVLJLY9vS/yIFsWYS1ziATlouyW
         FiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUcDtskC/MpS1ZZYsW5rzEoA89IqcWaCPaEQuwNjGpE=;
        b=u0jXBmvoqpSa122tESXO91SiWpDIuCHr9aAVSjz5hP11nvMm9FjI6y13cYIgZ2NuGi
         Pe7OAyBk0l9DxR4a/gNfHEzYz74CPKTYau6tHbc1WdyjxrP27A48cCRnML1r0J3jnHGg
         utlD87HJmdnQ4F+tBR56MDjV77Z2wZVkG092elXPvMr5BFJ8gXZHY1n3AvOwfN7jsNNU
         SUzc/oA4SWb04nNrhtaDBeWp131UArrOtYN9afnatLakyepfOws7BQw5wcxFP1XJxHF1
         G1E+f2Fosj8f2PCM97MMppYA9F1bEB//fpyq3SP7dYvAooFY+RhSgz1Ea7kfeQyrnge+
         z3tg==
X-Gm-Message-State: AOAM530o5OIry95mwwEFc12JCRVgXA5o83Ntharj6En4F2rXSpvwT96y
        7CCFPFGVbhQsMSWhg3IqKnINQS3D3abrUzRIAPGrrg==
X-Google-Smtp-Source: ABdhPJwIycZ0HR6zcJpAF3BkyOAcyZe/Fas9H2CdLd+q+wYSW2HXplSTFHEREKCmLs+bwT0AdjuRiVCsWI+hMa/2gf0=
X-Received: by 2002:a63:550f:: with SMTP id j15mr1222755pgb.40.1644020763110;
 Fri, 04 Feb 2022 16:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-39-ira.weiny@intel.com>
 <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
 <20220205000953.GD785175@iweiny-DESK2.sc.intel.com> <CAPcyv4jmnUbywDcXOAL9DwKxGaUf9cw9iDYbDcz6_CHyYPtytw@mail.gmail.com>
In-Reply-To: <CAPcyv4jmnUbywDcXOAL9DwKxGaUf9cw9iDYbDcz6_CHyYPtytw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 16:25:52 -0800
Message-ID: <CAPcyv4iLVh_BesJLcZb=Pktd-h5x6-xuos5Cj4TzuWYC=Q-vLg@mail.gmail.com>
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

On Fri, Feb 4, 2022 at 4:19 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Feb 4, 2022 at 4:10 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Feb 04, 2022 at 10:35:59AM -0800, Dan Williams wrote:
> > > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > > >
> >
> > [snip]
> >
> > I'll address the other comments later but wanted to address the idea below.
> >
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index f5b2be39a78c..5020ed7e67b7 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -1492,6 +1492,13 @@ struct task_struct {
> > > >         struct callback_head            l1d_flush_kill;
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > > > +       /*
> > > > +        * NOTE: pgmap_prot_count is modified within a single thread of
> > > > +        * execution.  So it does not need to be atomic_t.
> > > > +        */
> > > > +       u32                             pgmap_prot_count;
> > > > +#endif
> > >
> > > It's not at all clear why the task struct needs to be burdened with
> > > this accounting. Given that a devmap instance is needed to manage page
> > > protections, why not move the nested protection tracking to a percpu
> > > variable relative to an @pgmap arg? Something like:
> > >
> > > void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> > > {
> > >        migrate_disable();
> > >        preempt_disable();
> >
> > Why burden threads like this?  kmap_local_page() is perfectly able to migrate
> > or be preempted?
> >
> > I think this is way to restrictive.
>
> kmap_local_page() holds migrate_disable() over the entire mapping, so
> we're only talking about preempt_disable(). I tend to think that
> bloating task_struct for something that is rarely used "kmap on dax
> pmem pages" is not the right tradeoff.

Now, I can see an argument that promoting kmap_local_page() to
preempt_disable() could cause problems, but I'd like help confirming
that before committing to extending task_struct.
