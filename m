Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF25A7A38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiHaJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiHaJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:30:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D443F1C7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:30:18 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHf2M61TQzlWd5;
        Wed, 31 Aug 2022 17:26:51 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 17:30:16 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 17:30:15 +0800
Message-ID: <a21358e0-c8b0-368c-5ebb-061598c0f3a6@huawei.com>
Date:   Wed, 31 Aug 2022 17:30:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] sched/deadline: Add should_push_task_away helper
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220829100533.19153-1-shangxiaojing@huawei.com>
 <95f8c01c-12b2-5f2e-bc8f-288f16bfa5d3@redhat.com>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <95f8c01c-12b2-5f2e-bc8f-288f16bfa5d3@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/31 17:23, Daniel Bristot de Oliveira wrote:
> On 8/29/22 12:05, Shang XiaoJing wrote:
>> +static inline bool should_push_task_away(struct task_struct *a,
>> +					  struct task_struct *b)
> static inline bool should_push_task_dl(struct task_struct *curr, struct task_struct *p)
>
> a and b are not good variable names, and add the _dl suffix (instead of away).
ok, i like that :-). This will be done in patch v2.
>> +{
>> +	return unlikely(dl_task(a)) &&
>> +	       (a->nr_cpus_allowed < 2 ||
>> +		!dl_entity_preempt(&b->dl, &a->dl)) &&
>> +	       b->nr_cpus_allowed > 1;
>> +}
>> +
> -- Daniel

Thanks,

Shang XiaoJing

