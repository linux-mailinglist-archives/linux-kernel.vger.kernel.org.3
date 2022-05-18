Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC052BBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiERNkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiERNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:39:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18171BE11D;
        Wed, 18 May 2022 06:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5296DB820BF;
        Wed, 18 May 2022 13:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E96C385A5;
        Wed, 18 May 2022 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652881195;
        bh=YAGu07lD7nk9Sec8Z4RqDJGNVMRvtX91QuhoK9EteBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBhRzGBkhJ/WS21W8UymKR/Yj7C9/5Idf0bT5jKtz2m/7qX77Ydy3/D/Gxt8mpFAy
         m7Gn+S6iy7zsm/GjIuSiU5gYw/mQHit5V4radJO3h6m0NTmPcjR+sxljfoKN/zCRsn
         gLo0ACR7qA1u9iAjrB+Yw5DroprSEp96IOtSkJPmxN5JTuO2iTv7ki6DofkfRFdJss
         DwK2WK13qd4UTb65ZRR13MQedDzJIYWleNj5RI/J7Cn9rJdMMwFprNq6gWogWl2HmX
         dDjSgKkTOwo+xaOfo9hILAgFvEW9QbTfTvUxOLuca4HAMquqajnPjg4tIBzoIgIFQj
         mZRdk6/KEVTvw==
Date:   Wed, 18 May 2022 08:49:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, johnny.chenyi@huawei.com,
        chenjiahao16@huawei.com, chenlifu@huawei.com,
        lizhengyu3@huawei.com, liaochang1@huawei.com, wangzhu9@huawei.com,
        xuyihang@huawei.com, chris.zjh@huawei.com, zouyipeng@huawei.com
Subject: Re: [PATCH -next] x86/events:Use struct_size() helper in kzalloc()
Message-ID: <20220518134920.GA8361@embeddedor>
References: <20220518131626.109123-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518131626.109123-1-linyujun809@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:16:26PM +0800, Lin Yujun wrote:
> Replace sizeof() with struct_size() to avoid potential integer
> or heap overflow.

This is not exactly what the patch does.

Your patch is replacing the open-coded calculation of the total amount
of memory to be allocated for rapl_pmus with struct_size().

> 
> Also, address the following sparse warnings:
> arch/x86/events/rapl.c:685:16: warning: using sizeof on a
> flexible structure

This does not address this warning because struct_size()
still make use of sizeof on the struct-with-flex-array,
internally.

So, the mention to the sparse warning should be removed from
this changelog text.

> 
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>  arch/x86/events/rapl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 77e3a47af5ad..c7e79f0ac04f 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -685,7 +685,7 @@ static int __init init_rapl_pmus(void)
>  	int maxdie = topology_max_packages() * topology_max_die_per_package();
>  	size_t size;
>  
> -	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
> +	size = struct_size(rapl_pmus, pmus, maxdie);
>  	rapl_pmus = kzalloc(size, GFP_KERNEL);

It seems that in this case, size could be entirely replaced by
struct_size().

Thanks
--
Gustavo
