Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675C4EAE90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiC2NgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiC2NgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:36:02 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB01F626;
        Tue, 29 Mar 2022 06:34:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0V8ZK4JR_1648560852;
Received: from 30.240.123.174(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V8ZK4JR_1648560852)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Mar 2022 21:34:14 +0800
Message-ID: <48b2cf46-d96b-4d2d-5a56-97a88566edcc@linux.alibaba.com>
Date:   Tue, 29 Mar 2022 21:34:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
To:     Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220326194327.32239-1-alisaidi@amazon.com>
 <20220328030805.14175-1-alisaidi@amazon.com>
 <20220328130547.GA360814@leoy-ThinkPad-X240s>
Content-Language: en-US
In-Reply-To: <20220328130547.GA360814@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo, Ali,

Thank you for your great work and valuable discussion.

在 2022/3/27 AM3:43, Ali Saidi 写道:> Hi Leo,
> On Sat, 26 Mar 2022 21:47:54 +0800, Leo Yan wrote:
>> Hi Ali, German,
>>
>> On Thu, Mar 24, 2022 at 06:33:21PM +0000, Ali Saidi wrote:
>>
>> [...]
>>
>>> +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
>>> +						union perf_mem_data_src *data_src)
>>>  {
>>> -	union perf_mem_data_src	data_src = { 0 };
>>> +	/*
>>> +	 * Even though four levels of cache hierarchy are possible, no known
>>> +	 * production Neoverse systems currently include more than three levels
>>> +	 * so for the time being we assume three exist. If a production system
>>> +	 * is built with four the this function would have to be changed to
>>> +	 * detect the number of levels for reporting.
>>> +	 */
>>>
>>> -	if (record->op == ARM_SPE_LD)
>>> -		data_src.mem_op = PERF_MEM_OP_LOAD;
>>> -	else
>>> -		data_src.mem_op = PERF_MEM_OP_STORE;
>>
>> Firstly, apologize that I didn't give clear idea when Ali sent patch sets
>> v2 and v3.
>>
>> IMHO, we need to consider two kinds of information which can guide us
>> for a reliable implementation.  The first thing is to summarize the data
>> source configuration for x86 PEBS, we can dive in more details for this
>> part; the second thing is we can refer to the AMBA architecture document
>> ARM IHI 0050E.b, section 11.1.2 'Crossing a chip-to-chip interface' and
>> its sub section 'Suggested DataSource values', which would help us
>> much for mapping the cache topology to Arm SPE data source.
>>
>> As a result, I summarized the data source configurations for PEBS and
>> Arm SPE Neoverse in the spreadsheet:
>> https://docs.google.com/spreadsheets/d/11YmjG0TyRjH7IXgvsREFgTg3AVtxh2dvLloRK1EdNjU/edit?usp=sharing
>
> Thanks for putting this together and digging into the details, but you're making
> assumptions in neoverse data sources about the core configurations that aren't
> correct. The Neoverse cores have all have integrated L1 and L2 cache, so if the
> line is coming from a peer-core we don't know which level it's actually coming
> from.  Similarly, if it's coming from a local cluster, that could mean a cluster
> l3, but it's not the L2.

As far as I know, Neoverse N2 microarchitecture L3 Cache is non-inclusive, and L1
and L2 are strictly inclusive, like  Intel Skylake SP (SKX), i.e., the L2 may
or may not be in the L3 (no guarantee is made). That is to say, we can not tell
it is from cluster L2 or L3. Could you confirm this?

[...]


> I still think we should consider to extend the memory levels to
> demonstrate clear momory hierarchy on Arm archs, I personally like the
> definitions for "PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE",
> though these cache levels are not precise like L1/L2/L3 levels, they can
> help us to map very well for the cache topology on Arm archs and without
> any confusion.  We could take this as an enhancement if you don't want
> to bother the current patch set's upstreaming.

Agree. In my opinion, imprecise cache levels can lead to wrong conclusions.
"PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE" are more intuitive.

Best Regards,
Shuai


