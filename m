Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47DD486B95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiAFVFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244069AbiAFVFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641503131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfNEPHx1xDfNOOR4ZfuMpjosG1jEJyn3a9yDJ8UdTKY=;
        b=ZLKlFr4C/HWFUXDCwBLknBS18TzBJ+XskL5d1Hnof86EIpIEekJe3iETWUWYExBBJa/ij8
        +GjsmuBJiEPKvOmpR3rBCWf9Ldd9bpFWSRP5b0T/uvz4M0itp66FBberIwK7o1ZBDQvAn5
        qaaG5lSjzI8I4ns2NNmRjzuMa7XXSb4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-Ar8RuZ7ROFSlzKCAzmGNmg-1; Thu, 06 Jan 2022 16:05:30 -0500
X-MC-Unique: Ar8RuZ7ROFSlzKCAzmGNmg-1
Received: by mail-oo1-f69.google.com with SMTP id r25-20020a4ae5d9000000b002c9ad00c5a5so2215538oov.22
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfNEPHx1xDfNOOR4ZfuMpjosG1jEJyn3a9yDJ8UdTKY=;
        b=R9QKhd6w6yjeZRRfYvPYdwdg1qM7gG2e3Nsjz0jeYei0swJBGKXmUa0+5VvR/HH8m7
         shEDlfHyke4OlJMuFnXma8PfYIaDTxMUSzRY+tvJjNVdF6Yr2dqhqCZpGYDob+Na7tJW
         a+vIBvv0QywfWfRZWt59iDQCrqXeXWQYRjlT1VYTDN4/QXYACbYrYuKymsXcstJLkTWM
         NWCZDLBBdDjcje4zYRtaTpITqysaTlq5K+AH4JOiFdSsD/Lw/lhuQVOxZ1VFJ755wo8P
         25uPakmxDBv1IpDEtPLR8Eg12eiDMiH5TWQJyFb6kOz8WTiDzUlZ+7alxz4KfjIhRvEz
         v3IA==
X-Gm-Message-State: AOAM532f6fUJ6lrEWlqMcrdzo+hV2T9d13aW7U63QbsLsHzKD2KQTR9d
        t+S76hQbZWR2XIM/mVBL+vFYzRssrDd5bsGpi0ZWo+Wm8Ho9nh/c2X9nqLAhpdPVXOuDm7UQVQ5
        or1Wu8h100Ti8mbbKw3MMEgIr
X-Received: by 2002:a4a:dd08:: with SMTP id m8mr37690417oou.25.1641503129793;
        Thu, 06 Jan 2022 13:05:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJJHuHyvhX6fNO7GsfowW/AaCDltzBsOD9eqaeIHK+3O5wnNGjVkNDhjuWIf6dAb0cTtDPNA==
X-Received: by 2002:a4a:dd08:: with SMTP id m8mr37690401oou.25.1641503129553;
        Thu, 06 Jan 2022 13:05:29 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r23sm615480oiw.20.2022.01.06.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:05:29 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:05:27 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC 08/16] vfio/type1: Cache locked_vm to ease mmap_lock
 contention
Message-ID: <20220106140527.5c292d34.alex.williamson@redhat.com>
In-Reply-To: <20220106123456.GZ2328285@nvidia.com>
References: <20220106004656.126790-1-daniel.m.jordan@oracle.com>
        <20220106004656.126790-9-daniel.m.jordan@oracle.com>
        <20220106005339.GX2328285@nvidia.com>
        <20220106011708.6ajbhzgreevu62gl@oracle.com>
        <20220106123456.GZ2328285@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 08:34:56 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jan 05, 2022 at 08:17:08PM -0500, Daniel Jordan wrote:
> > On Wed, Jan 05, 2022 at 08:53:39PM -0400, Jason Gunthorpe wrote:  
> > > On Wed, Jan 05, 2022 at 07:46:48PM -0500, Daniel Jordan wrote:  
> > > > padata threads hold mmap_lock as reader for the majority of their
> > > > runtime in order to call pin_user_pages_remote(), but they also
> > > > periodically take mmap_lock as writer for short periods to adjust
> > > > mm->locked_vm, hurting parallelism.
> > > > 
> > > > Alleviate the write-side contention with a per-thread cache of locked_vm
> > > > which allows taking mmap_lock as writer far less frequently.
> > > > 
> > > > Failure to refill the cache due to insufficient locked_vm will not cause
> > > > the entire pinning operation to error out.  This avoids spurious failure
> > > > in case some pinned pages aren't accounted to locked_vm.
> > > > 
> > > > Cache size is limited to provide some protection in the unlikely event
> > > > of a concurrent locked_vm accounting operation in the same address space
> > > > needlessly failing in case the cache takes more locked_vm than it needs.  
> > > 
> > > Why not just do the pinned page accounting once at the start? Why does
> > > it have to be done incrementally?  
> > 
> > Yeah, good question.  I tried doing it that way recently and it did
> > improve performance a bit, but I thought it wasn't enough of a gain to
> > justify how it overaccounted by the size of the entire pin.  
> 
> Why would it over account?

We'd be guessing that the entire virtual address mapping counts against
locked memory limits, but it might include PFNMAP pages or pages that
are already account via the page pinning interface that mdev devices
use.  At that point we're risking that the user isn't concurrently
doing something else that could fail as a result of pre-accounting and
fixup later schemes like this.  Thanks,

Alex

