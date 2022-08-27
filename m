Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C945A3A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 00:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiH0WJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 18:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0WI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 18:08:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4E133E2B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 15:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 352C960EB3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 22:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1AAC433D6;
        Sat, 27 Aug 2022 22:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661638136;
        bh=EetUzY2Orm6TubMy5lXXo7jyaxG/w2IE8VsBq71JB/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TH/oR8PL1TUQCxixiMDVlk+JuwZxSGKlID6RD90O92rMgxwUoKhLctUJiaaCQsPl2
         86mIkQgzxCLOAB8OV+t6Z3CksQ/cU3jMcgv/BDgoSLA/Y3EsZyVYYGdwHhpIKGmY+t
         hwrbCEgeZ+CXVjwo2+PKT+6YwRptid7A0AT5ZtEw=
Date:   Sat, 27 Aug 2022 15:08:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2] mm: fix null-ptr-deref in kswapd_is_running()
Message-Id: <20220827150855.b8885a5c4f09df712d619760@linux-foundation.org>
In-Reply-To: <20220827111959.186838-1-wangkefeng.wang@huawei.com>
References: <20220827111959.186838-1-wangkefeng.wang@huawei.com>
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

On Sat, 27 Aug 2022 19:19:59 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> The kswapd_run/stop() will set pgdat->kswapd to NULL, which
> could race with kswapd_is_running() in kcompactd(),
> 
> kswapd_run/stop()                       kcompactd()
>                                           kswapd_is_running()
>   pgdat->kswapd // error or nomal ptr
>                                           verify pgdat->kswapd
>                                             // load non-NULL
> pgdat->kswapd
>   pgdat->kswapd = NULL
>                                           task_is_running(pgdat->kswapd)
>                                             // Null pointer derefence
> 
> The KASAN report the null-ptr-deref shown below,
> 
>   vmscan: Failed to start kswapd on node 0
>   ...
>   BUG: KASAN: null-ptr-deref in kcompactd+0x440/0x504
>   Read of size 8 at addr 0000000000000024 by task kcompactd0/37
> 
>   CPU: 0 PID: 37 Comm: kcompactd0 Kdump: loaded Tainted: G           OE     5.10.60 #1
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Call trace:
>    dump_backtrace+0x0/0x394
>    show_stack+0x34/0x4c
>    dump_stack+0x158/0x1e4
>    __kasan_report+0x138/0x140
>    kasan_report+0x44/0xdc
>    __asan_load8+0x94/0xd0
>    kcompactd+0x440/0x504
>    kthread+0x1a4/0x1f0
>    ret_from_fork+0x10/0x18
> 
> For now, kswapd/kcompactd_run() and kswapd/kcompactd_stop() protected
> by mem_hotplug_begin/done(), but without kcompactd(). It is no need to
> involve memory hotplug lock in kcompactd(), so let's add new mutex to
> protect pgdat->kswapd accessed concurrently, also because kcompactd task
> will check the state of kswapd task, it's better to call kcompactd_stop()
> before kswapd_stop() to reduce lock conflicts.
> 

Looks right to me.

I think the below will make the code a little more maintainable?

--- a/include/linux/memory_hotplug.h~mm-fix-null-ptr-deref-in-kswapd_is_running-fix
+++ a/include/linux/memory_hotplug.h
@@ -215,6 +215,7 @@ void put_online_mems(void);
 void mem_hotplug_begin(void);
 void mem_hotplug_done(void);
 
+/* See kswapd_is_running() */
 static inline void pgdat_kswapd_lock(pg_data_t *pgdat)
 {
 	mutex_lock(&pgdat->kswapd_lock);
--- a/mm/compaction.c~mm-fix-null-ptr-deref-in-kswapd_is_running-fix
+++ a/mm/compaction.c
@@ -1980,6 +1980,12 @@ static inline bool is_via_compact_memory
 	return order == -1;
 }
 
+/*
+ * Determine whether kswapd is (or recently was!) running on this node.
+ *
+ * pgdat_kswapd_lock() pins pgdat->kswapd, so a concurrent kswapd_stop() can't
+ * zero it.
+ */
 static bool kswapd_is_running(pg_data_t *pgdat)
 {
 	bool running;
_

