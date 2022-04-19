Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A865062EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347181AbiDSD6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbiDSD6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:58:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6CD13E86
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 101BAB8118D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E316C385A7;
        Tue, 19 Apr 2022 03:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650340532;
        bh=nibgm+F/f0uCqZcCAC6pQ5BE8cFf97BjnCM7yu3WDcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x3HUvsmJ98Fg2AORmS7dNPTHsUkdoXLB+QBZ9l9ra7yTPsuluL8hOVQ9T4DK+WUs/
         xC3pDpSNTqQ13lRQngWTJCYLdpl/LIxNa5hwWqx0R7Vw2BAnALet5Jj/46kU/WWhjv
         DluZUnMUXrrc1ulU79pNPDhgp/VY1QRzKORTaCuk=
Date:   Mon, 18 Apr 2022 20:55:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 09/12] mm: compaction: avoid possible NULL pointer
 dereference in kcompactd_cpu_online
Message-Id: <20220418205531.2e4ed0f72e0e537ef55c6468@linux-foundation.org>
In-Reply-To: <20220418141253.24298-10-linmiaohe@huawei.com>
References: <20220418141253.24298-1-linmiaohe@huawei.com>
        <20220418141253.24298-10-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc David H on memhotplug stuff.

On Mon, 18 Apr 2022 22:12:50 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> It's possible that kcompactd_run could fail to run kcompactd for a hot
> added node and leave pgdat->kcompactd as NULL. So pgdat->kcompactd should
> be checked here to avoid possible NULL pointer dereference.
>
> ..
>
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -3052,7 +3052,8 @@ static int kcompactd_cpu_online(unsigned int cpu)
>  
>  		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
>  			/* One of our CPUs online: restore mask */
> -			set_cpus_allowed_ptr(pgdat->kcompactd, mask);
> +			if (pgdat->kcompactd)
> +				set_cpus_allowed_ptr(pgdat->kcompactd, mask);
>  	}
>  	return 0;
>  }

Why not fail to bring the node online if kcompactd_run() failed?

Also, should we panic the system if kcompactd_run() failed in
kcompactd_init()?

