Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40D4CB314
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiCBXwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiCBXwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:52:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3315963BC2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:51:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBC460AC9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B2BC004E1;
        Wed,  2 Mar 2022 23:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646264074;
        bh=cBDUYSR0eSGUbg7hhpGZJrrV34Qa8/yXz+XpHML8nss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1JgUhuuJ/QdaNR6BRFyaTi/ih7S/l6BxWJXA4fT24VBaELET4VCQ9vB71VbPFT/GS
         dyeDNzKASdloj8ZLaW7y7Jy3FTu5nuSqQZdDnRYPa1Lnq265vm4xVSNFKco51K7+LP
         FxiI+rdxk6OH7GnAii5jnvynPZAl2pRTk2jyEC3Q=
Date:   Wed, 2 Mar 2022 15:34:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wangjianxing <wangjianxing@loongson.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
Message-Id: <20220302153433.719caef31bd9e99319c5e6a2@linux-foundation.org>
In-Reply-To: <20220302013825.2290315-1-wangjianxing@loongson.cn>
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
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

On Tue,  1 Mar 2022 20:38:25 -0500 wangjianxing <wangjianxing@loongson.cn> wrote:

> free a large list of pages maybe cause rcu_sched starved on
> non-preemptible kernels
> 
> rcu: rcu_sched kthread starved for 5359 jiffies! g454793 f0x0
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=19
> [...]
> Call Trace:
>   free_unref_page_list+0x19c/0x270
>   release_pages+0x3cc/0x498
>   tlb_flush_mmu_free+0x44/0x70
>   zap_pte_range+0x450/0x738
>   unmap_page_range+0x108/0x240
>   unmap_vmas+0x74/0xf0
>   unmap_region+0xb0/0x120
>   do_munmap+0x264/0x438
>   vm_munmap+0x58/0xa0
>   sys_munmap+0x10/0x20
>   syscall_common+0x24/0x38

Thanks.

How did this large list of pages come about?

Will people be seeing this message in upstream kernels, or is it
specific to some caller code which you have added?

Please always include details such as this so that others can determine
whether the fix should be backported into -stable kernels.

