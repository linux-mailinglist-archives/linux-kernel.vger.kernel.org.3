Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE354E68F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiCXTBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbiCXTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD5DD5A16F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648148400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEZsPU6ScEAA3keGh0hVCGrvQvsoW7+VZCfIyHrin5I=;
        b=PKEQsHYshmAHfjI9P8V2Mvq11nlxvLOhz+3isa4dKtuxkdj6mSaxOj5u4kvH5lg6dlqGcJ
        6CsG2ahTB6YJ9wPFpk8rucL/NjFswAXxUUSIdkzaDXOb+mldJyVm4TS+S0Db+1lZnjOw4n
        xPH1QcBdY7UI95T42sZkdttk+4JUzCs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-grCKVaTjPUaUoyuQll4Tjw-1; Thu, 24 Mar 2022 14:59:59 -0400
X-MC-Unique: grCKVaTjPUaUoyuQll4Tjw-1
Received: by mail-wr1-f71.google.com with SMTP id p16-20020adfc390000000b00204006989c2so1977102wrf.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BEZsPU6ScEAA3keGh0hVCGrvQvsoW7+VZCfIyHrin5I=;
        b=0YYMsTLqN70wkM7BVrWYf4B5uvo3lDYuoRDccAIIHokjgPMTcPYkEP343+sRKRT7lL
         oBOd3mKeidhb8b5mv4XxmPUV0NkGgyQ9LHCEQJ9ekzzt2RP1gvP9CFIUIK4F1MuzJJnh
         UBG6xQmaya/4YrPX74Lv/LfKonGnC/vF5KyovPmdsZWGm3duZ4fIvK7oJ6J2V1plyCd+
         PE6i3h2AnGom4E1rjz7XEQWgdrkjJzxwCnujmEOVehUNcZEzG79nKBZ9nDn/v935htBN
         oGEx92Go3VNcf+RUF6ijlpoQHMiNOWJ9/cnVBvqdDOLIi24dyqfL7vO4yjlhH6y/6DUG
         TZCQ==
X-Gm-Message-State: AOAM532dYbM7dRdM6pvXRrLKTQAIKWrpSzUcxPkm+WhZBNkJHzJgRKyY
        WUUFanQAczxR06tdcpmAjBmsBGoBe4wYYzhSUMHm6wMAg0Wyz8c5PfKDPyJIIsyUjz+PHKzz3N1
        FTAj55RfKk+2fEph7anEqHjFj
X-Received: by 2002:a5d:6101:0:b0:204:871e:9912 with SMTP id v1-20020a5d6101000000b00204871e9912mr5764238wrt.60.1648148398296;
        Thu, 24 Mar 2022 11:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9rLBD0bceg0ZUAVQjV9g6B7JHVhv+FAZqMk/+BCNICmA66CnX4VjHlcEvcDu1+G+z22/Sng==
X-Received: by 2002:a5d:6101:0:b0:204:871e:9912 with SMTP id v1-20020a5d6101000000b00204871e9912mr5764218wrt.60.1648148398054;
        Thu, 24 Mar 2022 11:59:58 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3506:3400:69b5:c807:1d52:ff67? ([2a0c:5a80:3506:3400:69b5:c807:1d52:ff67])
        by smtp.gmail.com with ESMTPSA id 2-20020a056000154200b00203ee1fd1desm3442514wry.64.2022.03.24.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:59:57 -0700 (PDT)
Message-ID: <3c24840e8378c69224974f321ec5c06a36a33dd3.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Date:   Thu, 24 Mar 2022 19:59:56 +0100
In-Reply-To: <20220303114550.GE4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220303114550.GE4363@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Thu, 2022-03-03 at 11:45 +0000, Mel Gorman wrote:
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
> 
> It's still waiting on tests to complete and not all the changelogs are
> complete which is why it's not posted.
> 
> This is a comparison of vanilla vs "local_locks to per-cpu spinlocks"
> versus the git series up to "mm/page_alloc: Remotely drain per-cpu lists"
> for the page faulting microbench I originally complained about.  The test
> machine is a 2-socket CascadeLake machine.
> 
> pft timings
>                                  5.17.0-rc5             5.17.0-rc5             5.17.0-rc5
>                                     vanilla    mm-remotedrain-v2r1       mm-pcpdrain-v1r1
> Amean     elapsed-1        32.54 (   0.00%)       33.08 *  -1.66%*       32.82 *  -0.86%*
> Amean     elapsed-4         8.66 (   0.00%)        9.24 *  -6.72%*        8.69 *  -0.38%*
> Amean     elapsed-7         5.02 (   0.00%)        5.43 *  -8.16%*        5.05 *  -0.55%*
> Amean     elapsed-12        3.07 (   0.00%)        3.38 * -10.00%*        3.09 *  -0.72%*
> Amean     elapsed-21        2.36 (   0.00%)        2.38 *  -0.89%*        2.19 *   7.39%*
> Amean     elapsed-30        1.75 (   0.00%)        1.87 *  -6.50%*        1.62 *   7.59%*
> Amean     elapsed-48        1.71 (   0.00%)        2.00 * -17.32%*        1.71 (  -0.08%)
> Amean     elapsed-79        1.56 (   0.00%)        1.62 *  -3.84%*        1.56 (  -0.02%)
> Amean     elapsed-80        1.57 (   0.00%)        1.65 *  -5.31%*        1.57 (  -0.04%)
> 
> Note the local_lock conversion took 1 1-17% penalty while the git tree
> takes a negligile penalty while still allowing remote drains. It might
> have some potential while being less complex than the RCU approach.

I finally got some time to look at this and made some progress:

First, I belive your 'mm-remotedrain-v2r1' results are wrong/inflated due to a
bug in my series. Essentially, all 'this_cpu_ptr()' calls should've been
'raw_cpu_ptr()' and your build, which I bet enables CONFIG_DEBUG_PREEMPT,
wasted time trowing warnings about per-cpu variable usage with preemption
enabled. Making the overall performance look worse than it actually is. My
build didn't enable it, which made me miss this whole issue. I'm sorry for the
noise and time wasted on such a silly thing. Note that the local_lock to
spin_lock conversion can handle the preeemption alright, it is part of the
design[1].

As for your idea of not disabling interrupts in the hot paths, it seems to
close the performance gap created by the lock conversion. That said, I'm not
sure I understand why you find the need to keep the local_locks around, not
only it casuses problems for RT systems, but IIUC they aren't really protecting
anything other than the 'this_cpu_ptr()' usage (which isn't really needed). I
rewrote your patch on top of my lock conversion series and I'm in the process
of testing it on multiple systems[2].

Let me know what you think.
Thanks!

[1] It follows this pattern:

	struct per_cpu_pages *pcp;

	pcp = raw_cpu_ptr(page_zone(page)->per_cpu_pageset);
	// <- Migration here is OK: spin_lock protects vs eventual pcplist
	// access from local CPU as long as all list access happens through the
	// pcp pointer.
	spin_lock(&pcp->lock);
	do_stuff_with_pcp_lists(pcp);
	spin_unlock(&pcp->lock);

[2] See:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git pcpdrain-sl-v3r1

-- 
Nicolás Sáenz

