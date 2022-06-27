Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C443F55B58A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiF0C4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiF0C4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:56:15 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80838AD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:56:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VHRLgaG_1656298568;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VHRLgaG_1656298568)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 10:56:10 +0800
Date:   Mon, 27 Jun 2022 10:56:08 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yuwen Chen <chenyuwen1@meizu.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Message-ID: <YrkcSB3MmvtCiVN3@B-P7TQMD6M-0146.local>
References: <20220625145000.2720-1-chenyuwen1@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220625145000.2720-1-chenyuwen1@meizu.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 10:50:00PM +0800, Yuwen Chen wrote:
> When the user mounts the erofs second times, the decompression thread
> may hung. The problem happens due to a sequence of steps like the
> following:
> 
> 1) Task A called z_erofs_load_lzma_config which obtain all of the node
>    from the z_erofs_lzma_head.
> 
> 2) At this time, task B called the z_erofs_lzma_decompress and wanted to
>    get a node. But the z_erofs_lzma_head was empty, the Task B had to
>    sleep.
> 
> 3) Task A release nodes and push nodes into the z_erofs_lzma_head. But
>    task B was still sleeping.
> 
> One example report when the hung happens:
> task:kworker/u3:1 state:D stack:14384 pid: 86 ppid: 2 flags:0x00004000
> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> Call Trace:
>  <TASK>
>  __schedule+0x281/0x760
>  schedule+0x49/0xb0
>  z_erofs_lzma_decompress+0x4bc/0x580
>  ? cpu_core_flags+0x10/0x10
>  z_erofs_decompress_pcluster+0x49b/0xba0
>  ? __update_load_avg_se+0x2b0/0x330
>  ? __update_load_avg_se+0x2b0/0x330
>  ? update_load_avg+0x5f/0x690
>  ? update_load_avg+0x5f/0x690
>  ? set_next_entity+0xbd/0x110
>  ? _raw_spin_unlock+0xd/0x20
>  z_erofs_decompress_queue.isra.0+0x2e/0x50
>  z_erofs_decompressqueue_work+0x30/0x60
>  process_one_work+0x1d3/0x3a0
>  worker_thread+0x45/0x3a0
>  ? process_one_work+0x3a0/0x3a0
>  kthread+0xe2/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>  </TASK>
> 
> Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
