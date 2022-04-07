Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7664F7EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiDGMVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiDGMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:21:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC217A90
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f4Rmugru2mhvwGQ3fXEf3//3fTpZD2XMq6oiWTDtyQc=; b=nvp9Sxez94VVk6+ArZfaBLCB3z
        wChIaMCgO0bTTgkfQfdyCA3e8V6YL5euWDxN83j+uDmC2QCHNU+Lh8uNji3iCIBMD8YJtnKTWrzVc
        RgBc+Rxo1Gbex78H/WFAU6wUhqUqtfsz4uTrxkHRhpHcAfEo2H3GZD9/NpF0Q0rDoxOWV7OZ7sPUp
        Pje+BPfSQSS/+GuknG3GMU0UV3F/QmeTsLuVbCq1cs56O2kw/LkMoQYWs51rdk1iEtgHLfhopWRkn
        H8vCuNfhk9PDndRTVXQ8XmAyfv7uSmxY26TH/Q7BBJPTHg0U6djcCCbe4Q4nbaOyWvad1HEKuODBY
        V9eaWeKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncR6d-008oVb-O3; Thu, 07 Apr 2022 12:19:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F7549862CF; Thu,  7 Apr 2022 14:19:19 +0200 (CEST)
Date:   Thu, 7 Apr 2022 14:19:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jthierry@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, ardb@kernel.org, masahiroy@kernel.org,
        jpoimboe@redhat.com, ycote@redhat.com
Subject: Re: [RFC PATCH v3 13/13] objtool: arm64: Enable stack validation for
 arm64
Message-ID: <20220407121919.GK2731@worktop.programming.kicks-ass.net>
References: <20220407120141.43801-1-chenzhongjin@huawei.com>
 <20220407120141.43801-14-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407120141.43801-14-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:01:41PM +0800, Chen Zhongjin wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> Add build option to run stack validation at compile time.
> 
> When requiring stack validation, jump tables are disabled as it
> simplifies objtool analysis (without having to introduce unreliable
> artifacs). In local testing, this does not appear to significaly
> affect final binary size nor system performance.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  arch/arm64/Kconfig  | 1 +
>  arch/arm64/Makefile | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 23048be0333b..119cfce4117f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -201,6 +201,7 @@ config ARM64
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_RSEQ
>  	select HAVE_STACKPROTECTOR
> +	select HAVE_STACK_VALIDATION
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
>  	select HAVE_KRETPROBES
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2f1de88651e6..ad2f4a5e8f6c 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -133,6 +133,10 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
>    CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>  endif
>  
> +ifeq ($(CONFIG_STACK_VALIDATION),y)
> +KBUILD_CFLAGS	+= -fno-jump-tables
> +endif

IIRC this is a sore spot for the whole endeavour..

