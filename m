Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7649E2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiA0MwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiA0MwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:52:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CA0C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eIzwTN2BcMJQImC/a1uWhGGlkWD5r7FpubShtuBZn0I=; b=WRNQKebB3REHhq5bmczN8/8/0+
        hsao9FEsLaXDE36l4hivdAo9dmJTMdJnw1EVVoZdgS2uvw+AGxuwiF2+fmuwvFYI2Q4jSrBQ1crUr
        hN3kulGVMb1nSIxjTF+mcOENydP/N20QrLUzgZYZ1MlWkzqwK31LBT/NIdEwEhwXusUs9HIrP3LAt
        9nFnf40/J154d5N4sXzULUUksbc8QjOcOpBL3FM7i5RGhxhLjyllx1/y7MjNwGGK+97xBXYvvTJKb
        XoxOFR2abjrC6Yihs3cqOpXfJKlcf9+cg5RqevQ7MabaRB9kH+0+MZPnUBlU1IIvTU4Ko4uINBnYl
        8nWLIcXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD4Ff-004AbJ-3o; Thu, 27 Jan 2022 12:51:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9982300268;
        Thu, 27 Jan 2022 13:51:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 982972B52092A; Thu, 27 Jan 2022 13:51:45 +0100 (CET)
Date:   Thu, 27 Jan 2022 13:51:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Subject: Re: [PATCH v5 07/13] perf/x86/amd: make Zen3 branch sampling opt-in
Message-ID: <YfKVYbYDYfIOq32I@hirez.programming.kicks-ass.net>
References: <20220126233454.3362047-1-eranian@google.com>
 <20220126233454.3362047-8-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126233454.3362047-8-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:34:48PM -0800, Stephane Eranian wrote:
> This patch adds a kernel config option to make support
> for AMD Zen3 Branch Sampling (BRS) an opt-in compile
> time option.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/Kconfig      |  8 ++++++
>  arch/x86/events/amd/Makefile |  3 ++-
>  arch/x86/events/perf_event.h | 49 ++++++++++++++++++++++++++++--------
>  3 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
> index d6cdfe631674..1dc002ef66da 100644
> --- a/arch/x86/events/Kconfig
> +++ b/arch/x86/events/Kconfig
> @@ -44,4 +44,12 @@ config PERF_EVENTS_AMD_UNCORE
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called 'amd-uncore'.
> +
> +config PERF_EVENTS_AMD_BRS
> +	depends on PERF_EVENTS && CPU_SUP_AMD
> +	tristate "AMD Zen3 Branch Sampling support"

tristate ?!
