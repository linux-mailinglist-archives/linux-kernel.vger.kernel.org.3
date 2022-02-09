Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3914AF7F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiBIRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiBIRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:20:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0169C05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x1X3FTuSVUcFvgRZ0OU8phylFC2Mu51rICaELBAjm9k=; b=kpRt0GF2c01nPJfTN5hfVoqK1R
        IQ2StJwlrC3g4xcNYFTjF2XLMmHUCXHDVV5JCibebqwQvrz7/2P/nV6SlQAm+fbYEECtKh/4ftbTm
        KZgGNdDNhG6laaLnsHIHjqVvVDlZs+JaRDZeZCd7yVfFGLCin+4UqeQyJhPXP9zxdeXh7joOmwsFc
        5CpibkVYtSTU99xuFU8trIxlV1OV2Clvrdg0VUivrxjgDXE259W1j6RGDYUAAamWfM65/Ha+kRt8n
        cPvY28SC3+SvLwFBLFulW91g7+JKmcAoio/JV16w0IQgoX5zFcM1utlVR3P51ZyNQir2clgJV38Wm
        nl8nSjTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHqdh-008EMU-Af; Wed, 09 Feb 2022 17:20:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8474430022C;
        Wed,  9 Feb 2022 18:20:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C2C5201BECDB; Wed,  9 Feb 2022 18:20:18 +0100 (CET)
Date:   Wed, 9 Feb 2022 18:20:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Nayak, K Prateek" <KPrateek.Nayak@amd.com>
Cc:     "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "efault@gmx.de" <efault@gmx.de>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <YgP30sLEQfYPsMZE@hirez.programming.kicks-ass.net>
References: <20220207155921.21321-1-kprateek.nayak@amd.com>
 <20220209104625.GM23216@worktop.programming.kicks-ass.net>
 <MW2PR12MB237955DEA3F949359A96E031982E9@MW2PR12MB2379.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR12MB237955DEA3F949359A96E031982E9@MW2PR12MB2379.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:14:32PM +0000, Nayak, K Prateek wrote:
> [AMD Official Use Only]

I think you need to invest in a new mail setup.

> > Where does this affinity come from?
> 
> The affinity comes from limiting the process to a certain subset of
> available cpus by modifying the cpus_ptr member of task_struck
> via taskset or numactl.

That's obviously not an answer. Why is that done?
