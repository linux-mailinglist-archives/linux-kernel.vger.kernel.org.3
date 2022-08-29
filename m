Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD05A4E61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiH2NlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiH2NlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:41:11 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5395870B2;
        Mon, 29 Aug 2022 06:41:08 -0700 (PDT)
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661780466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VEV6GFAzy/gsMJZuWPvxfq1rP508BA9FNyORPVsiWE=;
        b=KDYkNnjLvN2oiF7EMvXDDjWOWlw2zEohCutgHJbdmGX62mNDosP6WdOFO2EPQaACr8Y+RP
        8XfG4yNa0JhUZOUZYZkrPn0eIQCaP/C7mzjxlFASbsKUbXEhBD2NCckOcaIExPwzI30qxe
        xjoWQHtxTp/qU6Apl2/7PbUD9+ReTvc=
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <691f9d94-f650-0f04-2d49-74fe84c24bfe@linux.dev>
Date:   Mon, 29 Aug 2022 21:40:51 +0800
MIME-Version: 1.0
In-Reply-To: <20220829131502.165356-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/22 9:14 PM, Yu Kuai wrote:
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

Impressive! Pls try mdadm test suites too to avoid regression.

> Please noted that in kunpeng-920, memory access latency is very bad
> accross nodes compare to local node, and in other architecture
> performance improvement might not be significant.

By any chance can someone try with x64?

Thanks,
Guoqing
