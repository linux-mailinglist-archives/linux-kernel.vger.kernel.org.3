Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC5595466
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiHPIDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiHPICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:02:38 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A212104B26
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:24:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VMOlw4x_1660627453;
Received: from 30.97.49.25(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VMOlw4x_1660627453)
          by smtp.aliyun-inc.com;
          Tue, 16 Aug 2022 13:24:14 +0800
Message-ID: <988f6a55-739e-8eab-4755-302716ea908e@linux.alibaba.com>
Date:   Tue, 16 Aug 2022 13:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] sched/fair: limit burst to zero when cfs bandwidth is
 toggled off
Content-Language: en-US
To:     Zhao Wenhui <zhaowenhui8@huawei.com>
Cc:     zhaogongyi@huawei.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        shanpeic@linux.alibaba.com, changhuaixin@linux.alibaba.com,
        tj@kernel.org, linux-kernel@vger.kernel.org
References: <20220809120320.19496-1-zhaowenhui8@huawei.com>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20220809120320.19496-1-zhaowenhui8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/9 20:03, Zhao Wenhui wrote:
> When the quota value in CFS bandwidth is set to -1, that imples the
> cfs bandwidth is toggled off. So the burst feature is supposed to
> be disable as well.
> 
> Currently, when quota is -1, burst will not be check, so that it can be
> set to almost arbitery value. Examples:
>          mkdir /sys/fs/cgroup/cpu/test
>          echo -1 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>          echo 10000000000000000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
> 
> Moreover, after the burst modified by this way, quota can't be set
> to any value:
>          echo 100000 > cpu.cfs_quota_us
>          -bash: echo: write error: Invalid argument
> 
> This patch can ensure the burst value being zero and unalterable,
> when quota is set to -1.
> 
> Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> Signed-off-by: Zhao Wenhui <zhaowenhui8@huawei.com>

Nice catch! Thanks for the fix.
Reviewed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
