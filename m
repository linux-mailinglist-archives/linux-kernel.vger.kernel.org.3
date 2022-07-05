Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA873567946
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGEVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGEVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:25:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE7DF3C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8704DB8181D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC10C341C7;
        Tue,  5 Jul 2022 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657056348;
        bh=qgaHL+Oy4XLYeWHuy+YRXq0lAlKIINOPcoxSgLDujR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iseEPz9CBsjg0Ck3NM7/woJoafbfgFUfYuM6DDdvrqEu75mNKvFn6LRWQgKXe+uCO
         4KV3fYifHbNp6obLmBXzNX3eapYC8oDFhq3/HiSPA+9ARBQ38LzOgbPQaq3IW9DL6n
         2x3nwA79TM5rk+2vKndeTqazOYmTNUWsj9SGGraw=
Date:   Tue, 5 Jul 2022 14:25:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, hugetlb: skip irrelevant nodes in
 show_free_areas()
Message-Id: <20220705142547.da3ea5a7383a7eeec3a93665@linux-foundation.org>
In-Reply-To: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
References: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
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

On Tue,  5 Jul 2022 17:21:19 +0800 Gang Li <ligang.bdlg@bytedance.com> wrote:

> show_free_areas() allows to filter out node specific data which is
> irrelevant to the allocation request. But hugetlb_show_meminfo() still
> shows hugetlb on all nodes, which is redundant and unnecessary.
> 
> Use show_mem_node_skip() to skip irrelevant nodes. And replace
> hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid).

It would be helpful to include before-and-after sample output text in
the changelog to help others assess the proposed change.

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6202,7 +6202,11 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  		printk(KERN_CONT "= %lukB\n", K(total));
>  	}
>  
> -	hugetlb_show_meminfo();
> +	for_each_online_node(nid) {
> +		if (show_mem_node_skip(filter, nid, nodemask))
> +			continue;
> +		hugetlb_show_meminfo_node(nid);
> +	}
>  

Does this mean that potentially useful info about presently-offline
nodes will no longer be available?

