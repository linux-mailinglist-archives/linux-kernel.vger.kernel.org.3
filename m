Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087F549BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiFMSgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiFMSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:36:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A80CE5D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VercitidOszaGDjS+BMhFv5MEfnrKBbaE0pJ9WADgZw=; b=o408WJyjnfJecMp+5RgXCA7Fqa
        04pyM6jxVc6WfSx3wJY1WH0iEbewQ7TJKdUJYJHg4e1nBjGbkS6IHOeSq3gqUSmayeM5d0ZRsCBg8
        kWoqHu8a6fXDtUwcw8mrDw2cpOkAY4WK5/+YpQigyXnq7sWJl/tmsl5fW830IFS/Ntw6N8d5evFnE
        vIgAb5hV0bd7iS8wuoXK1epsVtpF1njIjoez8GZe2AT5k4FU1ked9Tzzk7JDgcwyQQ8LFrM01TDlK
        5kX7rRRmwlR5KT9+dGQCeDTxREtN5WXE/JqB4qZcNy5PR2lVg1R6F+doIV5B1KYXKtvEQQ7vk5GrX
        Vji1RjQQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0lTV-007aym-3u; Mon, 13 Jun 2022 14:55:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FE99300472;
        Mon, 13 Jun 2022 16:55:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3011D201A578F; Mon, 13 Jun 2022 16:55:28 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:55:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YqdP4NExuwOHdC0G@hirez.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> @@ -12125,6 +12232,8 @@ SYSCALL_DEFINE5(perf_event_open,
>  		goto err_task;
>  	}
>  
> +	// XXX premature; what if this is allowed, but we get moved to a PMU
> +	// that doesn't have this.
>  	if (is_sampling_event(event)) {
>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>  			err = -EOPNOTSUPP;

No; this really should be against the event's native PMU. If the event
can't natively sample, it can't sample when placed in another group
either.
