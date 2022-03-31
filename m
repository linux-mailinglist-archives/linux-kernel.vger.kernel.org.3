Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D684ED1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiCaCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCaCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3078D70856
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7B26B81E94
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A9FC340EC;
        Thu, 31 Mar 2022 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648694508;
        bh=fFqDny+IW58LisJ6+taIO+4NpYn6YxJw3Mdt7OIWU0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MZbGRtlePXflgbljaguji7KawLCzAaU2Rj87PxNV7ta18e2gEdOzyPt6V0/JNJpom
         1iHh6+SkDtZztAt6yCB2LV/2L2UYDvs9CUjLaAws9pj+wjGMmJWd6LuZ41FPlVhtUZ
         noN3FEJblCWRJf3k9IdR1YgRAWAzOPsStqUmM6tA=
Date:   Wed, 30 Mar 2022 19:41:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     will@kernel.org, david@redhat.com, bodeddub@amazon.com,
        osalvador@suse.de, mike.kravetz@oracle.com, rientjes@google.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
        21cnbao@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Subject: Re: [PATCH v3] arm64: mm: hugetlb: Enable HUGETLB_PAGE_FREE_VMEMMAP
 for arm64
Message-Id: <20220330194147.000c80ef35345397756e096e@linux-foundation.org>
In-Reply-To: <20220330145400.18565-1-songmuchun@bytedance.com>
References: <20220330145400.18565-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 22:54:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -247,7 +247,7 @@ config HUGETLB_PAGE
>  
>  config HUGETLB_PAGE_FREE_VMEMMAP
>  	def_bool HUGETLB_PAGE
> -	depends on X86_64
> +	depends on X86_64 || ARM64

This list is just going to get longer, until someone goes and switches
it to use ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP or whatever.  Why not do
that now?

>  	depends on SPARSEMEM_VMEMMAP
