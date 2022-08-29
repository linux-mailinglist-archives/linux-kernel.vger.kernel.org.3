Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766565A4EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiH2N7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH2N67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:58:59 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE97E004;
        Mon, 29 Aug 2022 06:58:57 -0700 (PDT)
Received: from [192.168.0.6] (ip5f5aec76.dynamic.kabel-deutschland.de [95.90.236.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 75D2861EA192D;
        Mon, 29 Aug 2022 15:58:54 +0200 (CEST)
Message-ID: <70172016-8ae5-92b8-2a43-8f0d4a2f6668@molgen.mpg.de>
Date:   Mon, 29 Aug 2022 15:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220829131502.165356-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Thank you for your patches.

Am 29.08.22 um 15:14 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> patch 1 is a small problem found by code review.
> patch 2 avoid holding resync_lock in fast path.
> patch 3 avoid holding lock in wake_up() in fast path.
> 
> Test environment:
> 
> Architecture: aarch64
> Cpu: Huawei KUNPENG 920, there are four numa nodes
> 
> Raid10 initialize:
> mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
> 
> Test cmd:
> fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 -randseed=2022 -rwmixread=70 -refill_buffers -filename=/dev/md0 -numjobs=16 -runtime=60s -bs=4k -iodepth=256 -rw=randread
> 
> Test result:
> before this patchset:	2.9 GiB/s
> after this patchset:	6.6 Gib/s

Could you please give more details about the test setup, like the drives 
used?

Did you use some tools like ftrace to figure out the bottleneck?

> Please noted that in kunpeng-920, memory access latency is very bad
> accross nodes compare to local node, and in other architecture
> performance improvement might not be significant.
> 
> Yu Kuai (3):
>    md/raid10: fix improper BUG_ON() in raise_barrier()
>    md/raid10: convert resync_lock to use seqlock
>    md/raid10: prevent unnecessary calls to wake_up() in fast path
> 
>   drivers/md/raid10.c | 88 +++++++++++++++++++++++++++++----------------
>   drivers/md/raid10.h |  2 +-
>   2 files changed, 59 insertions(+), 31 deletions(-)


Kind regards,

Paul
