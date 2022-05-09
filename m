Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13EC51FC3F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiEIMJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiEIMJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:09:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C81D307;
        Mon,  9 May 2022 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T936nS0c1PlBSkfemIA4Yr0nLy+zvmfIGCESj7ohdNM=; b=ISDH7a2NmvTVbSC/jhfnbKdlie
        VTT0zlprFQGml5t7MPV4H/nnA6ET14ySqaBM442ysIOxQ79cya95H+YBlTTUaxhp4zaCp00qXyMr5
        GxhhRK+pnzWcJy+WBHRZIrF5XcGZwKVpDdSV/kXGwkM2ZZuyUi4zMLSS9Axl3g1qo4eCE0n/U1wnZ
        7Ww4PPaYwmyuu/lc6sXKVhn3AOKYmqZWbeRQEkjBzUvSkm3ajkxRH+9RwA7YVWxJ+VAsFWTavIRsA
        2AfYJ6U6V6i4fiqHfRhcKS8htkigkZzjVU0asjmm9v7FogmIH3fVH7Itx1z222/MDy2xoSdNo/oYX
        9E8OrdXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no28d-003Q2C-DW; Mon, 09 May 2022 12:05:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29F3A300252;
        Mon,  9 May 2022 14:05:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14DB32026965B; Mon,  9 May 2022 14:05:17 +0200 (CEST)
Date:   Mon, 9 May 2022 14:05:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 3/8] perf/amd/ibs: Add support for L3 miss filtering
Message-ID: <YnkDfRIRyztvXv6o@hirez.programming.kicks-ass.net>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509044914.1473-4-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:19:09AM +0530, Ravi Bangoria wrote:
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index b06e4c573add..a24b637a6e1d 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -391,6 +391,7 @@ struct pebs_xmm {
>  #define IBS_CAPS_OPBRNFUSE		(1U<<8)
>  #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
>  #define IBS_CAPS_OPDATA4		(1U<<10)
> +#define IBS_CAPS_ZEN4IBSEXTENSIONS	(1U<<11)
>  
>  #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
>  					 | IBS_CAPS_FETCHSAM	\

Would you mind terribly if I do:

  's/IBS_CAPS_ZEN4IBSEXTENSIONS/IBS_CAPS_ZEN4/'

on it? Per the IBS_ suffix, we're already talking about IBS, per the
CAPS thing we're talking about capabilities and I'm thinking that makes
EXTENTION somewhat redundant, which then leaves:

  IBS_CAPS_ZEN4


