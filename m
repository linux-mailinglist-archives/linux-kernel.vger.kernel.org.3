Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE94D008D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiCGN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbiCGN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B6E71FCFC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646661471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wM6VOulZtYrylaSH6OVQrZB6SV0lfkKkm0v+oBQEvPk=;
        b=eJ5bmaaJhzay6jOhQFqjAFz+6SvdRhGCzgEiw+/hVRl3kKEO/ogyRddtjJwG2nBfwGkKnq
        DSUx5gUi4y0oJYo9PhwbCCJgep9ylo96zShf32bc4aDuH4aZTn+PQ/ELQrbrSfG6E9Hm3C
        svTZmz6DvqLOZE/lWzzqSNJgDjt8oxc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-XFKtOYXaObGPt6y9rseyLA-1; Mon, 07 Mar 2022 08:57:50 -0500
X-MC-Unique: XFKtOYXaObGPt6y9rseyLA-1
Received: by mail-wr1-f70.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so4566550wri.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wM6VOulZtYrylaSH6OVQrZB6SV0lfkKkm0v+oBQEvPk=;
        b=MpYj5RRUbvPsulDZGwUkCOgl1pxa7yX63xOClJ5jvwgsbfFy9xG+G9EWabq0y/vRZl
         nBJ3nhIQhU3P0lksG+/2YF/iEV66JKNndT9RUX1G+MN0Sk/30Ax8PPjzpbzUymxb5L4q
         tTgi6H6FgU1lWXh5jxE8wmzry1BCh6V7QdZdOIdgzxv+hrgMcj9QF66xThJF8Em8bg+U
         LvA/DHFFpgA9+q/gDpvmL3lUNJi6E6OgSQlhuvYdHdhRZAixR/FjYEOO+xwwKSWh8+Ei
         6DTzQV9eNuK5+g+MmVMd2GPDBkYeM7K9w3k9QBJqrHqtoZWJyGqVsxuKkr5C4ntVUCxf
         PJEg==
X-Gm-Message-State: AOAM5319EEVy8WQcD0DJ7rRqHdPwfuOX6bEV1ps+8GO4cVP3DlBoL5dD
        Y8MMPgEHyqovyYC811Atar/UaneiR/O4JcLOAugxk4LDd1oswmVZwyoCtTFgR42vrc+4WITmdMr
        qldAZ3XjQkUKT7ECnGiOekAbs
X-Received: by 2002:adf:d1e4:0:b0:1fd:bcc4:66c8 with SMTP id g4-20020adfd1e4000000b001fdbcc466c8mr822265wrd.488.1646661469374;
        Mon, 07 Mar 2022 05:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoPAJ77EFUcVlCEoryGdZ4Di7c8IlBBuTKzrsfodTyiISnPTIgOVliwHERXJfFacwYmqHQlQ==
X-Received: by 2002:adf:d1e4:0:b0:1fd:bcc4:66c8 with SMTP id g4-20020adfd1e4000000b001fdbcc466c8mr822240wrd.488.1646661469127;
        Mon, 07 Mar 2022 05:57:49 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d6745000000b001f1e4e40e42sm5589858wrw.77.2022.03.07.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:57:48 -0800 (PST)
Message-ID: <fcdaacf58296dfd826bfdbbd5ef3a06b6e05a456.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Date:   Mon, 07 Mar 2022 14:57:47 +0100
In-Reply-To: <20220303114550.GE4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220303114550.GE4363@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,
Thanks for having a look at this.

On Thu, 2022-03-03 at 11:45 +0000, Mel Gorman wrote:
> On Tue, Feb 08, 2022 at 11:07:48AM +0100, Nicolas Saenz Julienne wrote:
> > This series replaces mm/page_alloc's per-cpu page lists drain mechanism with
> > one that allows accessing the lists remotely. Currently, only a local CPU is
> > permitted to change its per-cpu lists, and it's expected to do so, on-demand,
> > whenever a process demands it by means of queueing a drain task on the local
> > CPU. This causes problems for NOHZ_FULL CPUs and real-time systems that can't
> > take any sort of interruption and to some lesser extent inconveniences idle and
> > virtualised systems.
> > 
> 
> I know this has been sitting here for a long while. Last few weeks have
> not been fun.

No problem.

> > Note that this is not the first attempt at fixing this per-cpu page lists:
> >  - The first attempt[1] tried to conditionally change the pagesets locking
> >    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
> >    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
> >    for NOHZ_FULL setups, which isn't ideal.
> >  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
> >    performance degradation was too big.
> > 
> 
> For unrelated reasons I looked at using llist to avoid locks entirely. It
> turns out it's not possible and needs a lock. We know "local_locks to
> per-cpu spinlocks" took a large penalty so I considered alternatives on
> how a lock could be used.  I found it's possible to both remote drain
> the lists and avoid the disable/enable of IRQs entirely as long as a
> preempting IRQ is willing to take the zone lock instead (should be very
> rare). The IRQ part is a bit hairy though as softirqs are also a problem
> and preempt-rt needs different rules and the llist has to sort PCP
> refills which might be a loss in total. However, the remote draining may
> still be interesting. The full series is at
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2

I'll have a proper look at it soon.

Regards,

-- 
Nicolás Sáenz

