Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447735AD5F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiIEPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiIEPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B6B7D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D9B160F5B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EE3C433C1;
        Mon,  5 Sep 2022 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662390870;
        bh=CP4NcXDfCymQFvUZRnFGWcms/v7Hz+fmcT03tOXmkiM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gy66a6AZYzpOdaqzupomz3qx4JCM+cE1iAPogPai1oyAvfMtl5IP+1KCgOMuFyL9f
         O4lgmpBdLCe6YrtNCpoHV1V9pPS4xlY9MFw/lZnNXRG7v+Jn53Lz3+0eKI0JhDe6Sl
         bjjdMG3jAVE1SH62Y8+epSUV4Omo0HLQkrwXmgx1sBxnhIb51OfFhoLcyjHGdiPOEn
         Ip+XDgX5jtQyz4gpVhqmMVm3xh2e76zsbVsMtJpYdnMAGgnhUpZCK+QhgoOFkr1JLl
         a2Bx0UKJBVrjnJIeaxSvUXC83FJUemak9Xy7j62FG7WNe6MZqwlghAx34S+G53YwuC
         DRwaqnj7pJohw==
Message-ID: <977a4e45-43e7-485e-fb31-7fd0754f888d@kernel.org>
Date:   Mon, 5 Sep 2022 23:14:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] erofs: fix pcluster use-after-free on UP platforms
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/2 12:57, Gao Xiang wrote:
> During stress testing with CONFIG_SMP disabled, KASAN reports as below:
> 
> ==================================================================
> BUG: KASAN: use-after-free in __mutex_lock+0xe5/0xc30
> Read of size 8 at addr ffff8881094223f8 by task stress/7789
> [ 3482.258885]
> CPU: 0 PID: 7789 Comm: stress Not tainted 6.0.0-rc1-00002-g0d53d2e882f9 #3
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Call Trace:
>   <TASK>
> ..
>   __mutex_lock+0xe5/0xc30
> ..
>   z_erofs_do_read_page+0x8ce/0x1560
> ..
>   z_erofs_readahead+0x31c/0x580
> ..
> Freed by task 7787
>   kasan_save_stack+0x1e/0x40
>   kasan_set_track+0x20/0x30
>   kasan_set_free_info+0x20/0x40
>   __kasan_slab_free+0x10c/0x190
>   kmem_cache_free+0xed/0x380
>   rcu_core+0x3d5/0xc90
>   __do_softirq+0x12d/0x389
> [ 3482.295630]
> Last potentially related work creation:
>   kasan_save_stack+0x1e/0x40
>   __kasan_record_aux_stack+0x97/0xb0
>   call_rcu+0x3d/0x3f0
>   erofs_shrink_workstation+0x11f/0x210
>   erofs_shrink_scan+0xdc/0x170
>   shrink_slab.constprop.0+0x296/0x530
>   drop_slab+0x1c/0x70
>   drop_caches_sysctl_handler+0x70/0x80
>   proc_sys_call_handler+0x20a/0x2f0
>   vfs_write+0x555/0x6c0
>   ksys_write+0xbe/0x160
>   do_syscall_64+0x3b/0x90
> 
> The root cause is that erofs_workgroup_unfreeze() doesn't reset
> to orig_val thus it causes a race that the pcluster reuses unexpectedly
> before freeing.
> 
> Since UP platforms are quite rare now, such path becomes unnecessary.
> Let's drop such specific-designed path directly instead.
> 
> Fixes: 73f5c66df3e2 ("staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
