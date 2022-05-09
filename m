Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BDB51F27F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiEIBdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiEIBbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 21:31:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D113F01
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:24:35 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxNjn6Xf3zhZ1W;
        Mon,  9 May 2022 09:23:57 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 09:24:33 +0800
Message-ID: <55b319f1-77dd-5049-f734-462dfbf59d31@huawei.com>
Date:   Mon, 9 May 2022 09:24:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] jffs2: fix memory leak in jffs2_do_fill_super
To:     <richard@nod.at>, <dwmw2@infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20220412093816.2280678-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
In-Reply-To: <20220412093816.2280678-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping.

在 2022/4/12 17:38, Baokun Li 写道:
> If jffs2_iget() or d_make_root() in jffs2_do_fill_super() returns
> an error, we can observe the following kmemleak report:
>
> --------------------------------------------
> unreferenced object 0xffff888105a65340 (size 64):
>    comm "mount", pid 710, jiffies 4302851558 (age 58.239s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff859c45e5>] kmem_cache_alloc_trace+0x475/0x8a0
>      [<ffffffff86160146>] jffs2_sum_init+0x96/0x1a0
>      [<ffffffff86140e25>] jffs2_do_mount_fs+0x745/0x2120
>      [<ffffffff86149fec>] jffs2_do_fill_super+0x35c/0x810
>      [<ffffffff8614aae9>] jffs2_fill_super+0x2b9/0x3b0
>      [...]
> unreferenced object 0xffff8881bd7f0000 (size 65536):
>    comm "mount", pid 710, jiffies 4302851558 (age 58.239s)
>    hex dump (first 32 bytes):
>      bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
>      bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
>    backtrace:
>      [<ffffffff858579ba>] kmalloc_order+0xda/0x110
>      [<ffffffff85857a11>] kmalloc_order_trace+0x21/0x130
>      [<ffffffff859c2ed1>] __kmalloc+0x711/0x8a0
>      [<ffffffff86160189>] jffs2_sum_init+0xd9/0x1a0
>      [<ffffffff86140e25>] jffs2_do_mount_fs+0x745/0x2120
>      [<ffffffff86149fec>] jffs2_do_fill_super+0x35c/0x810
>      [<ffffffff8614aae9>] jffs2_fill_super+0x2b9/0x3b0
>      [...]
> --------------------------------------------
>
> This is because the resources allocated in jffs2_sum_init() are not
> released. Call jffs2_sum_exit() to release these resources to solve
> the problem.
>
> Fixes: e631ddba5887 ("[JFFS2] Add erase block summary support (mount time improvement)")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/jffs2/fs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
> index 71f03a5d36ed..f83a468b6488 100644
> --- a/fs/jffs2/fs.c
> +++ b/fs/jffs2/fs.c
> @@ -604,6 +604,7 @@ int jffs2_do_fill_super(struct super_block *sb, struct fs_context *fc)
>   	jffs2_free_raw_node_refs(c);
>   	kvfree(c->blocks);
>   	jffs2_clear_xattr_subsystem(c);
> +	jffs2_sum_exit(c);
>    out_inohash:
>   	kfree(c->inocache_list);
>    out_wbuf:


