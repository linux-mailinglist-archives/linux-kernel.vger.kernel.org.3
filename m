Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4D48C7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355054AbiALQL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354983AbiALQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:10:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6786C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/W8SEIIQmiWMQWtlkvLK99xQHSUvadSNsXTuHZvrmos=; b=f8KMzwOD3kOV6VI3KiODnTCYm/
        FMuCvqr8/3+fj9J3+fFdI90hgqRo4MhbftFAbtdR7CQDeHAYj1sRNJyeEEGBkZYIkgboRA1D1GQo2
        nRc4MxerBmw1rG5iWcoSDI7q+WXuoTjQinzK0W0CcXOdgMsu3deXmiy5qkVUTGGjUg3aOKg+8rUCv
        79+m3fG8smp8TynImopDEk7ham1Z+NLH0NC9OwDT1LYqf/k1OGAjT22JxbLs4ncdzwAFQ+XPRKYxa
        yT6uzsdNllCJu2YnN9cOAcz35pYXXaqV3Ri8J3UFxZfYyvhjvpxluL+w1A3/ANCT7Ny0vlWEkNAUm
        vAopbPTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7gCi-000pNZ-2J; Wed, 12 Jan 2022 16:10:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 882EA300237;
        Wed, 12 Jan 2022 17:10:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 703CE2133FEEB; Wed, 12 Jan 2022 17:10:23 +0100 (CET)
Date:   Wed, 12 Jan 2022 17:10:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Subject: Re: [PATCH -V10 RESEND 0/6] NUMA balancing: optimize memory
 placement for memory tiering system
Message-ID: <Yd79b6PptQMNzDRw@hirez.programming.kicks-ass.net>
References: <20211207022757.2523359-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207022757.2523359-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:27:51AM +0800, Huang Ying wrote:
> After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
> for use like normal RAM"), the PMEM could be used as the
> cost-effective volatile memory in separate NUMA nodes.  In a typical
> memory tiering system, there are CPUs, DRAM and PMEM in each physical
> NUMA node.  The CPUs and the DRAM will be put in one logical node,
> while the PMEM will be put in another (faked) logical node.

So what does a system like that actually look like, SLIT table wise, and
how does that affect init_numa_topology_type() ?
