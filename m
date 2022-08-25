Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A05A0B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiHYIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiHYIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:10:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6F5491CE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:10:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y127so16002127pfy.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=sHta+Xumm5TPzZXK7bJLVYQpxC1udJ2MrrQDJt5hubI=;
        b=VJjltSXBNv1cG3m2viryIQXbG7/J1MrsSttkycy238/NZ4jJCywTrlus6h7szA4h86
         7B6TAhti+CaMWd0c+L9qGbqNcutWEnU0geO83vRkQYTTNZEMp1j5WLnpiw7P29vl0bJT
         0oXqNAH0S0vkTntdGtX0D5NvR6IUfZ6gckI8nz9ivfbjKR9vYlX+0yXkJktzReMyF7za
         s/XQhakYzKQ0/Y4sOak7mCn3QDPQdD99P/RA+wGbVipEOYVnAmPqf/E0J8lKuLBq6U3F
         OXq/jABLBCUBWg2muDeDBzIE/PMw71Uee0L0KNkuutlM7or0GXGhNaTVP2uc3HIhzgNl
         J3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=sHta+Xumm5TPzZXK7bJLVYQpxC1udJ2MrrQDJt5hubI=;
        b=MyckiV37MiyNL2lneb7q4zMJnjuXAnusSUWMgKBBCBQTQGyxewGLX2HKW7pefQkF7F
         cjtDFobdoXKTYcUg1zFs+ozAkpdLxoCUlkowqwMHaaLH0lKPfFAKS3j/UyVwx7x4mxEn
         hg92LqeyD5HJvYmxNTgaRQjTUo0drIDmnosyPLRB1cqQbOSLICncgDqfFAhAYDLKo75o
         aSfD+ElJh4q6O22E9Hq9Ef0uRddXYlO3pDgP/CKkG6ADfHhErLCKCZCL5Dl5o1l5TdaY
         HoNWai76iE0zs69z2mCzZ7nVAsLCiD+/0SdyVovSLSPtXJXjtyYiImLw5OZRUhg8ydYD
         wQVQ==
X-Gm-Message-State: ACgBeo3WTaIV+vop871Zd/I2SbquzdJLOsAEeSRxYuX9vgZWnu9wSDeq
        yh5xcgFYcC8d9imhjj7bfYlKXA==
X-Google-Smtp-Source: AA6agR50TRZnG7/8jbkzmctodD/hNb+AaPcz1zw7wLGGLDG3KNC0knVZScnQ9eUKXzLtVXset3YWpg==
X-Received: by 2002:a05:6a00:2387:b0:52f:17a0:628c with SMTP id f7-20020a056a00238700b0052f17a0628cmr2709899pfc.17.1661415045659;
        Thu, 25 Aug 2022 01:10:45 -0700 (PDT)
Received: from [10.255.242.27] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 88-20020a17090a09e100b001f94d25bfabsm2806912pjo.28.2022.08.25.01.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:10:45 -0700 (PDT)
Message-ID: <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
Date:   Thu, 25 Aug 2022 16:10:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [External] Re: [PATCH v2] iommu/iova: Optimize alloc_iova with
 rbtree_augmented
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here is a real example. The version of kernel is 5.4.56.
Occurs when a lot of iova are not released for a long time.

[Wed May 25 05:27:59 2022] watchdog: BUG: soft lockup - CPU#58 stuck for 
23s! [ksoftirqd/58:302]
[Wed May 25 05:27:59 2022] Call Trace:
[Wed May 25 05:27:59 2022]  alloc_iova+0xf2/0x140
[Wed May 25 05:27:59 2022]  alloc_iova_fast+0x56/0x251
[Wed May 25 05:27:59 2022]  dma_ops_alloc_iova.isra.27+0x4b/0x70
[Wed May 25 05:27:59 2022]  __map_single.isra.28+0x4a/0x1d0
[Wed May 25 05:27:59 2022]  mlx5e_sq_xmit+0x98d/0x12b0 [mlx5_core]
[Wed May 25 05:27:59 2022]  ? packet_rcv+0x43/0x460
[Wed May 25 05:27:59 2022]  ? dev_hard_start_xmit+0x90/0x1e0
[Wed May 25 05:27:59 2022]  ? sch_direct_xmit+0x111/0x320
[Wed May 25 05:27:59 2022]  ? __qdisc_run+0x143/0x540
[Wed May 25 05:27:59 2022]  ? __dev_queue_xmit+0x6c3/0x8e0
[Wed May 25 05:27:59 2022]  ? ip_finish_output2+0x2d5/0x580
[Wed May 25 05:27:59 2022]  ? __ip_finish_output+0xe9/0x1b0
[Wed May 25 05:27:59 2022]  ? ip_output+0x6c/0xe0
[Wed May 25 05:27:59 2022]  ? __ip_finish_output+0x1b0/0x1b0
[Wed May 25 05:27:59 2022]  ? __ip_queue_xmit+0x15d/0x420
[Wed May 25 05:27:59 2022]  ? __tcp_transmit_skb+0x405/0x600
[Wed May 25 05:27:59 2022]  ? tcp_delack_timer_handler+0xb7/0x1b0
[Wed May 25 05:27:59 2022]  ? tcp_delack_timer+0x8b/0xa0
[Wed May 25 05:27:59 2022]  ? tcp_delack_timer_handler+0x1b0/0x1b0
[Wed May 25 05:27:59 2022]  ? call_timer_fn+0x2b/0x120
[Wed May 25 05:27:59 2022]  ? run_timer_softirq+0x1a6/0x420
[Wed May 25 05:27:59 2022]  ? update_load_avg+0x7e/0x640
[Wed May 25 05:27:59 2022]  ? update_curr+0xe1/0x1d0
[Wed May 25 05:27:59 2022]  ? __switch_to+0x7a/0x3e0
[Wed May 25 05:27:59 2022]  ? __do_softirq+0xda/0x2da
[Wed May 25 05:27:59 2022]  ? sort_range+0x20/0x20
[Wed May 25 05:27:59 2022]  ? run_ksoftirqd+0x26/0x40
[Wed May 25 05:27:59 2022]  ? smpboot_thread_fn+0xb8/0x150
[Wed May 25 05:27:59 2022]  ? kthread+0x110/0x130
[Wed May 25 05:27:59 2022]  ? kthread_park+0x80/0x80
[Wed May 25 05:27:59 2022]  ? ret_from_fork+0x1f/0x30

I did some more tests.

The test is single threaded.
Granule is 4k, limit is 2^20.

When the 1/4 address space is occupied by iova,
Repeat the following two steps：

1. Randomly releases an iova.
2. Allocate an iova of size 1 within the allocation limit of 2^20.

Before improvement:
> Tracing 1 functions for "alloc_iova"... Hit Ctrl-C to end.
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 352      |                                        |
>        512 -> 1023       : 258078   |****************************************|
>       1024 -> 2047       : 3612     |                                        |
>       2048 -> 4095       : 426      |                                        |
>       4096 -> 8191       : 183      |                                        |
>       8192 -> 16383      : 6        |                                        |
>      16384 -> 32767      : 5        |                                        |
>      32768 -> 65535      : 9        |                                        |
>      65536 -> 131071     : 18       |                                        |
>     131072 -> 262143     : 28       |                                        |
>     262144 -> 524287     : 74       |                                        |
>     524288 -> 1048575    : 109      |                                        |
>    1048576 -> 2097151    : 170      |                                        |
>    2097152 -> 4194303    : 100      |                                        |
>    4194304 -> 8388607    : 1        |                                        |
> 
> avg = 3110 nsecs, total: 818614399 nsecs, count: 263171
> 
> Tracing 1 functions for "remove_iova"... Hit Ctrl-C to end.
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 250651   |****************************************|
>        512 -> 1023       : 12405    |*                                       |
>       1024 -> 2047       : 111      |                                        |
>       2048 -> 4095       : 1        |                                        |
> 
> avg = 433 nsecs, total: 114136319 nsecs, count: 263168

With improvement:
> Tracing 1 functions for "alloc_iova"... Hit Ctrl-C to end.
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 0        |                                        |
>        512 -> 1023       : 258975   |****************************************|
>       1024 -> 2047       : 3618     |                                        |
>       2048 -> 4095       : 497      |                                        |
>       4096 -> 8191       : 74       |                                        |
>       8192 -> 16383      : 4        |                                        |
>      16384 -> 32767      : 1        |                                        |
> 
> avg = 637 nsecs, total: 167854061 nsecs, count: 263169
> 
> Tracing 1 functions for "remove_iova"... Hit Ctrl-C to end.
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 221560   |****************************************|
>        512 -> 1023       : 41427    |*******                                 |
>       1024 -> 2047       : 179      |                                        |
>       2048 -> 4095       : 2        |                                        |
> 
> avg = 477 nsecs, total: 125540399 nsecs, count: 263168


> s/distbution/distribution ?
Sorry, it's a typo.

I don't have a test program for "alloc_iova_fast + free_iova_fast"
right now.

Thanks,

Peng
