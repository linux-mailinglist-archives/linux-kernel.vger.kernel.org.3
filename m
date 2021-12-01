Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCC46683C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359617AbhLBQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347878AbhLBQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638462418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYCh2dhHffxrJlRcZGBoZYUArmtQ7dENpgOfY14c6PY=;
        b=FajmVESk7sxNlez5Q5y8dFCubK2BMUX7wkUc2APl775QUB81lR7F/CFolXyey9Vw1DtkYL
        T0q1Qw+uonfm7fj7W0+HXAkBoAKB9WBaXYiyslVl7ySM5GHq0tk2zymdDg+E2Xodws408V
        s9gt4M3lVYythyQPjqDVnVDLNpxugnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-mXFpOi1mOk-kiYIYOoKZ4Q-1; Thu, 02 Dec 2021 11:26:53 -0500
X-MC-Unique: mXFpOi1mOk-kiYIYOoKZ4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A8AC10151E6;
        Thu,  2 Dec 2021 16:26:51 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC27819C46;
        Thu,  2 Dec 2021 16:26:50 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 89AD5416CE5D; Wed,  1 Dec 2021 11:01:50 -0300 (-03)
Date:   Wed, 1 Dec 2021 11:01:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        nilal@redhat.com, mgorman@suse.de, linux-rt-users@vger.kernel.org,
        cl@linux.com, ppandit@redhat.com
Subject: Re: [PATCH v2 0/3] mm/page_alloc: Remote per-cpu page list drain
 support
Message-ID: <20211201140149.GA12861@fuller.cnet>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
 <7549db15-5149-160f-86e3-55136fe482ce@suse.cz>
 <43462fe11258395f4e885c3d594a3ed1b604b858.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43462fe11258395f4e885c3d594a3ed1b604b858.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 07:09:23PM +0100, Nicolas Saenz Julienne wrote:
> Hi Vlastimil, sorry for the late reply and thanks for your feedback. :)
> 
> On Tue, 2021-11-23 at 15:58 +0100, Vlastimil Babka wrote:
> > > [1] Other approaches can be found here:
> > > 
> > >   - Static branch conditional on nohz_full, no performance loss, the extra
> > >     config option makes is painful to maintain (v1):
> > >     https://lore.kernel.org/linux-mm/20210921161323.607817-5-nsaenzju@redhat.com/
> > > 
> > >   - RCU based approach, complex, yet a bit less taxing performance wise
> > >     (RFC):
> > >     https://lore.kernel.org/linux-mm/20211008161922.942459-4-nsaenzju@redhat.com/
> > 
> > Hm I wonder if there might still be another alternative possible. IIRC I did
> > propose at some point a local drain on the NOHZ cpu before returning to
> > userspace, and then avoiding that cpu in remote drains, but tglx didn't like
> > the idea of making entering the NOHZ full mode more expensive [1].
> > 
> > But what if we instead set pcp->high = 0 for these cpus so they would avoid
> > populating the pcplists in the first place? Then there wouldn't have to be a
> > drain at all. On the other hand page allocator operations would not benefit
> > from zone lock batching on those cpus. But perhaps that would be acceptable
> > tradeoff, as a nohz cpu is expected to run in userspace most of the time,
> > and page allocator operations are rare except maybe some initial page
> > faults? (I assume those kind of workloads pre-populate and/or mlock their
> > address space anyway).
> 
> I've looked a bit into this and it seems straightforward. Our workloads
> pre-populate everything, and a slight statup performance hit is not that tragic
> (I'll measure it nonetheless). The per-cpu nohz_full state at some point will
> be dynamic, but the feature seems simple to disable/enable. I'll have to teach
> __drain_all_pages(zone, force_all_cpus=true) to bypass this special case
> but that's all. I might have a go at this.
> 
> Thanks!
> 
> -- 
> Nicolás Sáenz

True, but a nohz cpu does not necessarily have to run in userspace most
of the time. For example, an application can enter nohz full mode, 
go back to userspace, idle, return from idle all without leaving
nohz_full mode.

So its not clear that nohz_full is an appropriate trigger for setting
pcp->high = 0. Perhaps a task isolation feature would be an appropriate
location.



