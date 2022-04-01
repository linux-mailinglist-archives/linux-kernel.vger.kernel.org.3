Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229D24EEDCD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiDANIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiDANIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:08:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF023F3AF;
        Fri,  1 Apr 2022 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FqhmqTHZDYbK7rpDGzSEd7NaJE8qX/JOo+U6Wj3cPhc=; b=gD572FGLXukdLX5wsjLhBZQums
        Vw2yIq5PeFtNs1Hf+w/pD1sYSLHK+IblSr01S9sgPzsDkDjnsOurqk9RxcIlRGgjpldqZfCbQrU6Q
        LAa9ZOZD1uVz+kXVZ9x7/7VeSsCMuPyJkKRXjWlMzjcpBvk0jLvh98AZXS/2qT+bRxfRAnwKA2Psf
        IMUsNk3JJVnd4E40psnXy0slMwvQ58HzZvGLbq/rX+TdTR5GJ1kSzHkf7M5aR5dCxQaJrMymcaMs9
        fobwYvP6a02sRMluxfq1bL00bcCmrNW4nDBT1ZCtXbTs7OnILES+V92gkNN3BoNKPyxS8iR2gKoNS
        BnopFHOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naGz1-003D4E-12; Fri, 01 Apr 2022 13:06:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3041C30027B;
        Fri,  1 Apr 2022 15:06:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E49DA2008B7BF; Fri,  1 Apr 2022 15:06:27 +0200 (CEST)
Date:   Fri, 1 Apr 2022 15:06:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dongli Si <kvmx86@gmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        joro@8bytes.org, kim.phillips@amd.com, liam.merwick@oracle.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v4] perf/x86/amd: Don't touch the Host-only bit inside
 the guest hypervisor
Message-ID: <Ykb400opkmZFsnVN@hirez.programming.kicks-ass.net>
References: <20220328140358.GF8939@worktop.programming.kicks-ass.net>
 <20220401082911.2527878-1-sidongli1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401082911.2527878-1-sidongli1997@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 04:29:11PM +0800, Dongli Si wrote:
> On 28/03/2022 14:03, Peter Zijlstra wrote:
> > Better I suppose, but I think the comments can be improved by covering
> > the 'why' of things. We can all read the code to see the what of it.
> 
> I will add comments to the code to explain 'why'.
> 
> > Anyway, doesn't this also affect behaviour? I'm guessing this HO bit is
> > only set by perf-record for events it wants to record on the host. But
> > by not setting it, we'll also record the activity of the guest.
> 
> I think the HO/GO bit can only be set on the host, and should only be set
> if SVM is enabled.
> 
> When the SVM is disabled, set the HO/GO bit will cause the performance
> counters to not work.
> 
> Set the HO/GO bit inside the guest will cause the guest emitted
> "unchecked MSR access error" warning, can be triggered by running
> "perf stat -e instructions:G ls" in the guest, because this will set
> the GO bit in the guest, and perf_ctr_virt_mask just mask the HO bit.
> 
> My patch does not affect the host, it just fixes the bug in the guest.
> 
> > So suppose we create a CPU wide HO event, then it will only count L0
> > activity, right? Any L1 (or higher) activite will be invisible.
> 
> I don't quite understand your question.
> 
> > But with this change on, the L1 HV doesn't provide these same semantics,
> > it's guest will be included in that host counter.
> 
> I don't think applying this patch will cause L2 guests to be included in
> the host counter.
> 
> > Or is there additional counter {dis,en}abling on virt enter,exit (resp.)
> > to achieve these semantics?
> 
> I don't think there is such a counter.

If SVM enter/exit don't twiddle with counter EN bits, how is all this
supposed to work consistently then?
