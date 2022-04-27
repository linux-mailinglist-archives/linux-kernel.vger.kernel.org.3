Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018C0511F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiD0PZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbiD0PZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5462EC35F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651072942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LNAyzMhGrm56//UE4/ZGodPQJ3CS7zahQHt/zd8A0Jg=;
        b=TI+WtwdFA5DXsd6+RECnE85bMtjxuHk/9vdo+GlkPQomThxieBWjXILyp6V95VB8acX9/J
        K/r2h6KpdOPNWjWSRLW+FknoXOROI7TX1QPGDJBH4L6BI5ju0jDoFRN9c5qbKLzGuLVowu
        bjy4Q+q3EQ0XKxdFuJv1aN0Fgl0xHMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-N_FnrifQOxWIGho6WLXR_g-1; Wed, 27 Apr 2022 11:22:19 -0400
X-MC-Unique: N_FnrifQOxWIGho6WLXR_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C24280418C;
        Wed, 27 Apr 2022 15:22:19 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5A21468F21;
        Wed, 27 Apr 2022 15:22:19 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E7726416F574; Wed, 27 Apr 2022 12:21:47 -0300 (-03)
Date:   Wed, 27 Apr 2022 12:21:47 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly
Message-ID: <Ymlfi2vas76Tgk4W@fuller.cnet>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
 <YmcnmZBtZEgJrrUv@google.com>
 <cf861ff3bf106b71994886cad7c4570b6ce9af0d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf861ff3bf106b71994886cad7c4570b6ce9af0d.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 01:06:12PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2022-04-25 at 15:58 -0700, Minchan Kim wrote:
> > On Wed, Apr 20, 2022 at 10:59:00AM +0100, Mel Gorman wrote:
> > > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > > per-cpu lists drain support" -- avoid interference of a high priority
> > > task due to a workqueue item draining per-cpu page lists. While many
> > > workloads can tolerate a brief interruption, it may be cause a real-time
> > > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> > > the draining in non-deterministic.
> > 
> > Yeah, the non-deterministic is a problem. I saw the kworker-based draining
> > takes 100+ms(up to 300ms observed) sometimes in alloc_contig_range if CPUs
> > are heavily loaded.
> > 
> > I am not sure Nicolas already observed. it's not only problem of
> > per_cpu_pages but it is also lru_pvecs (pagevec) draining.
> > Do we need to introduce similar(allow remote drainning with spin_lock)
> > solution for pagevec?
> 
> Yes, I'm aware of the lru problem. I'll start working on it too once we're done
> with the page allocator (and if no-one beats me to it). That said, I don't know
> if we can apply the exact same approach, the devil is in the details. :)

I think one necessary step for that (adding spinlock to protect per-CPU
lru_pvecs) would be to find a suitable testcase.

Mel, do you have anything in mind ?



> 
> -- 
> Nicolás Sáenz
> 
> 

