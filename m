Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93427478B07
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbhLQMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:09:19 -0500
Received: from foss.arm.com ([217.140.110.172]:56794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236070AbhLQMJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:09:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C221435;
        Fri, 17 Dec 2021 04:09:13 -0800 (PST)
Received: from [10.57.7.47] (unknown [10.57.7.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 494F33F5A1;
        Fri, 17 Dec 2021 04:09:11 -0800 (PST)
Subject: Re: [PATCH v4 4/6] perf tools: enable dwarf_callchain_users on arm64
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211215151139.40854-1-german.gomez@arm.com>
 <20211215151139.40854-5-german.gomez@arm.com> <YboZ24EMD/4lVkyp@FVFF77S0Q05N>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <e7538b32-365e-7f0a-e77a-59d47febdd2e@arm.com>
Date:   Fri, 17 Dec 2021 12:08:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YboZ24EMD/4lVkyp@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/12/2021 16:37, Mark Rutland wrote:
> On Wed, Dec 15, 2021 at 03:11:36PM +0000, German Gomez wrote:
>> [...]
>>
>> +
>> +	/*
>> +	 * It's possible to determine the caller of leaf frames with omitted
>> +	 * frame pointers on aarch64 using libunwind, so enable it.
>> +	 */
> I reckon it's worth mentioning *why* we need to do this; how about:
>
> 	/*
> 	 * It's necessary to use libunwind to reliably determine the caller of
> 	 * a leaf function on aarch64, as otherwise we cannot know whether to
> 	 * start from the LR or FP.
> 	 *
> 	 * Always starting from the LR can result in duplicate or entirely
> 	 * erroneous entries. Always skipping the LR and starting from the FP
> 	 * can result in missing entries.
> 	 */
>
> Other than that, this looks fine to me!
>
> Thanks,
> Mark.


Ack, I will update this

Thanks,
German

>
>> +	if (callchain_param.record_mode == CALLCHAIN_FP && !strcmp(arch, "arm64"))
>> +		dwarf_callchain_users = true;
>>  }
>>  
>>  static bool chain_match(struct callchain_list *base_chain,
>> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
>> index 77fba053c677..d95615daed73 100644
>> --- a/tools/perf/util/callchain.h
>> +++ b/tools/perf/util/callchain.h
>> @@ -300,7 +300,7 @@ int callchain_branch_counts(struct callchain_root *root,
>>  			    u64 *branch_count, u64 *predicted_count,
>>  			    u64 *abort_count, u64 *cycles_count);
>>  
>> -void callchain_param_setup(u64 sample_type);
>> +void callchain_param_setup(u64 sample_type, const char *arch);
>>  
>>  bool callchain_cnode_matched(struct callchain_node *base_cnode,
>>  			     struct callchain_node *pair_cnode);
>> -- 
>> 2.25.1
>>
