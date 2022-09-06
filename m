Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131865AF389
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIFSXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiIFSXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:23:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76499263
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ejsbWc7jxzdVv9EfTlV6LG/ILo5vqEFK0R9Sl/pPsw=; b=RcFeeBEBSNmBmJhbE5bo1gSZ/S
        Q0PPGU/Y24JkA4LbeK/L6cNKW9pN+rJSZKAS/PLfwAxf70EubNOTY90DX//vg7TDOnbRcuEC1kqJ6
        yyfyXhPPAeEEq+FEcfE4nY/EZcL8lcm5GviAzxj13p8uBlJleJo+geC8AMCgpLmRnmRy/UBRw75GZ
        WbQ9ldohcl0U82HjcvImBEgkHAZulUrCLUbI0o8ZhQ2qqYufjlPRz0X1HR3cAITvHUNPnYYl9VhTh
        euUoKXcggwKM34/V9DgpcyCiZOguaWuyI6Ult8FqgoT1LKR08JkecWnw1wJyvv1V6yCbS9zp1R9I1
        xx1W8P1g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVdDz-00GKFq-Le; Tue, 06 Sep 2022 18:23:03 +0000
Date:   Tue, 6 Sep 2022 11:23:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, npiggin@suse.de,
        ying.huang@intel.com, hannes@cmpxchg.org, corbet@lwn.net,
        mgorman@suse.de, keescook@chromium.org, yzaikin@google.com,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        osalvador@suse.de, surenb@google.com, rppt@kernel.org,
        charante@codeaurora.org, jsavitz@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -next v3 2/2] mm: sysctl: Introduce per zone
 watermark_scale_factor
Message-ID: <YxeQB2jawNwpOB5y@bombadil.infradead.org>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-3-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905032858.1462927-3-mawupeng1@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:28:58AM +0800, Wupeng Ma wrote:
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 205d605cacc5..d16d06c71e5a 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2251,8 +2251,6 @@ static struct ctl_table vm_table[] = {
>  		.maxlen		= sizeof(watermark_scale_factor),
>  		.mode		= 0644,
>  		.proc_handler	= watermark_scale_factor_sysctl_handler,
> -		.extra1		= SYSCTL_ONE,
> -		.extra2		= SYSCTL_THREE_THOUSAND,
>  	},
>  	{
>  		.procname	= "percpu_pagelist_high_fraction",

Please move the sysctl from kernel/sysctl.c to mm/page_alloc.c while
at it, you can git log the kernel/sysctl.c for prior moves and for
the motivations. No need to keep expanding on the existing table.

  Luis
