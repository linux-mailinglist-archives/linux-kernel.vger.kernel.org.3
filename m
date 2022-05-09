Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA451F792
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiEII6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbiEIItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:49:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3294517B84E;
        Mon,  9 May 2022 01:45:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 954951042;
        Mon,  9 May 2022 01:45:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964263F66F;
        Mon,  9 May 2022 01:45:37 -0700 (PDT)
Date:   Mon, 9 May 2022 09:45:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: perf: no need to initialise statics to 0
Message-ID: <YnjUqm3lu75+LjqH@FVFF77S0Q05N>
References: <20220508022312.93905-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508022312.93905-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 10:23:12AM +0800, Jason Wang wrote:
> Static variables do not need to be initialised to 0, because compiler
> will initialise all uninitialised statics to 0. Thus, remove the
> unneeded initializations.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

I would strongly prefer that we leave this as-is.

There is no problem with explicitly initializing a static variable to 0, and it
clearly aligns with the cmpxchg arguments below. Removing the initialization
makes that *less* clear.

Thanks,
Mark.

> ---
>  arch/arm64/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1e6138..919fdcf8fce6 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1226,7 +1226,7 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
>  
>  static void armv8_pmu_register_sysctl_table(void)
>  {
> -	static u32 tbl_registered = 0;
> +	static u32 tbl_registered;
>  
>  	if (!cmpxchg_relaxed(&tbl_registered, 0, 1))
>  		register_sysctl("kernel", armv8_pmu_sysctl_table);
> -- 
> 2.35.1
> 
> 
