Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5325996AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347394AbiHSIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbiHSIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:06:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4FDC0B9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bu5ugniIGJnOwBi0tX7bF/9ypxKtudKwkowqlczQRFs=; b=Dq7IBbNokXaq8uuhQCkYxp3xw2
        5yqeVXClgdF7YOEVAwFZp4hXLJebgHNTAUrMd2t0avrcvZuRwwUf96zQrtrPTUEE/+F7FmI5AMfsw
        jqPir1wIOePidmnWg8J06dFSKpJsM4GuT2pF3rrM6wT/uo7rx5x1Ugt3gcEVvXOIUqqTh4CX0e/tv
        wq5EOktnB6idz+M8Kmi5kDNCIE/JETj54I/pv+TLAo1+3jY1bz3S4nfb9qeKw+NG7bo7fxbKCnYen
        a4aYbl/+v1SdcFjNh8NP44ZZ9E05idpgyHPv8Ny6nDuW+VRsSTgSQ8WgnOoL+8uMOKExCKHRYX++n
        asOhXboQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOx0h-003ovk-E5; Fri, 19 Aug 2022 08:05:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AE22980120; Fri, 19 Aug 2022 10:05:40 +0200 (CEST)
Date:   Fri, 19 Aug 2022 10:05:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <Yv9EVP6O9r867om4@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818181530.2355034-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:

> The Alder Lake N only has e-cores. The X86_FEATURE_HYBRID_CPU flag is
> not set. The perf cannot retrieve the correct CPU type via
> get_this_hybrid_cpu_type(). The model specific get_hybrid_cpu_type() is
> hardcode to p-core. The wrong CPU type is given to the PMU of the
> Alder Lake N.

If ADL-N isn't in fact a hybrid CPU, then *WHY* are we running
init_hybrid_pmu() and setting up all that nonsense?

That is, wouldn't the right thing be to remove ALDERLAKE_N from the rest
of {ALDER,RAPTOP}LAKE and create a non-hybrid PMU setup for it?
