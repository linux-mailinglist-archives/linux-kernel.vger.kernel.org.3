Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7345AD17A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiIELWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiIELWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:22:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A63DBCB;
        Mon,  5 Sep 2022 04:22:03 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLmGb73YLzkWxF;
        Mon,  5 Sep 2022 19:18:15 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 19:22:02 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 19:22:01 +0800
Message-ID: <7bb62639-a94e-907c-7110-aad45dda4db4@huawei.com>
Date:   Mon, 5 Sep 2022 19:22:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 3/3] perf c2c: Prevent potential memory leak in
 c2c_he_zalloc
To:     Jiri Olsa <olsajiri@gmail.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220903072542.27678-1-shangxiaojing@huawei.com>
 <20220903072542.27678-4-shangxiaojing@huawei.com> <YxXNHtXoOeZG9Bzb@krava>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <YxXNHtXoOeZG9Bzb@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/5 18:19, Jiri Olsa wrote:
> On Sat, Sep 03, 2022 at 03:25:42PM +0800, Shang XiaoJing wrote:
>> Free allocated resources when zalloc is failed for members in c2c_he, to
>> prevent potential memory leak in c2c_he_zalloc.
>>
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>> ---
>>   tools/perf/builtin-c2c.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>> index 12f272811487..5530433eda80 100644
>> --- a/tools/perf/builtin-c2c.c
>> +++ b/tools/perf/builtin-c2c.c
>> @@ -146,15 +146,15 @@ static void *c2c_he_zalloc(size_t size)
>>   
>>   	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
>>   	if (!c2c_he->cpuset)
>> -		return NULL;
>> +		goto out_free_he;
>>   
>>   	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
>>   	if (!c2c_he->nodeset)
>> -		return NULL;
>> +		goto out_free_cpuset;
>>   
>>   	c2c_he->node_stats = zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_stats));
>>   	if (!c2c_he->node_stats)
>> -		return NULL;
>> +		goto out_free_nodeset;
>>   
>>   	init_stats(&c2c_he->cstats.lcl_hitm);
>>   	init_stats(&c2c_he->cstats.rmt_hitm);
>> @@ -163,6 +163,14 @@ static void *c2c_he_zalloc(size_t size)
>>   	init_stats(&c2c_he->cstats.load);
>>   
>>   	return &c2c_he->he;
> nit, given that c2c_he is zero allocated we could just have
> single error label that would free everything
>
> for the patchset:
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka

right, i'll be mindful of that in future.

this will be done in v2.

>> +
>> +out_free_nodeset:
>> +	free(c2c_he->nodeset);
>> +out_free_cpuset:
>> +	free(c2c_he->cpuset);
>> +out_free_he:
>> +	free(c2c_he);
>> +	return NULL;
>>   }
>>   
>>   static void c2c_he_free(void *he)
>> -- 
>> 2.17.1

Thanks,

Shang XiaoJing

