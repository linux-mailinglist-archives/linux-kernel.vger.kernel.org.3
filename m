Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4352CD97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiESHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiESHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:52:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065FE33E10;
        Thu, 19 May 2022 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nKzj507PnvmU6tWquJarj51kT1ZEzYPrh2E1b2RWop4=; b=ptHscJGRRhul1kYbwzl8G2zpeV
        E1SoROq9zvUgnbo18b+S0Cc/1rvzYtDDwDzEc2GRGEcTjhEXEI6w3Asz5d+wSBiCJulXsaC8vMv9Y
        eakSBGp2v3z4wy4IZxZRDvxuIQLyVn1/9XlDJ2p/71n2RfAnsusoRQMu9pCWBEDk+IEKjRlB7zIwR
        2eky6a3Eh+VVf3R/OiA0nH+ib9UCkx1Fxtg+/4ZCPMe8SC3yAEYIYC7nKSu+/g7ciKFejkdfe0OvM
        DEmaDYTkversB0KUnIqzaKaUO+/QrIM4qhC2/Eb7N+N9VCM0N1UCs66I7wBLxMUxfnV/+vOfdZeBZ
        GWfEM9bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nraxJ-001lp7-Gi; Thu, 19 May 2022 07:52:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 196A2980E0B; Thu, 19 May 2022 09:52:21 +0200 (CEST)
Date:   Thu, 19 May 2022 09:52:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org, johnny.chenyi@huawei.com,
        chenjiahao16@huawei.com, chenlifu@huawei.com,
        lizhengyu3@huawei.com, liaochang1@huawei.com, wangzhu9@huawei.com,
        xuyihang@huawei.com, chris.zjh@huawei.com, zouyipeng@huawei.com
Subject: Re: [PATCH -next v2] x86/events:Use struct_size() helper in kzalloc()
Message-ID: <20220519075220.GD2578@worktop.programming.kicks-ass.net>
References: <20220519023600.241591-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519023600.241591-1-linyujun809@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:36:00AM +0800, Lin Yujun wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>  arch/x86/events/rapl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 77e3a47af5ad..8da003e02010 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -683,10 +683,8 @@ static const struct attribute_group *rapl_attr_update[] = {
>  static int __init init_rapl_pmus(void)
>  {
>  	int maxdie = topology_max_packages() * topology_max_die_per_package();
> -	size_t size;
>  
> -	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
> -	rapl_pmus = kzalloc(size, GFP_KERNEL);
> +	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, maxdie), GFP_KERNEL);

So I really hate that thing; it's pointless obfuscation. If you're
really worried about the type confusion, write it like:

	size = sizeof(*rapl_pmus) + sizeof(rapl_pmus->pmus[0]) * maxdie;

or something. Otherwise, just go away.
