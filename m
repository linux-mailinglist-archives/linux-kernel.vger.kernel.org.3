Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2355A8BC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiFYJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFYJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:44:55 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D92036B47
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:44:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHKrxCi_1656150289;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VHKrxCi_1656150289)
          by smtp.aliyun-inc.com;
          Sat, 25 Jun 2022 17:44:50 +0800
Date:   Sat, 25 Jun 2022 17:44:48 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Even <cheny_wen@126.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Even <chenyuwen1@meizu.com>
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Message-ID: <YrbZEIxC62XjVBwL@B-P7TQMD6M-0146.local>
References: <20220625085738.12834-1-cheny_wen@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220625085738.12834-1-cheny_wen@126.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 25, 2022 at 04:57:38PM +0800, Even wrote:
> From: Even <chenyuwen1@meizu.com>
> 
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
> Signed-off-by: Even <chenyuwen1@meizu.com>

Thanks a lot for catching this!

The patch itself looks good, but could you use your real name to sign
off the patch and resend a version? see,
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
