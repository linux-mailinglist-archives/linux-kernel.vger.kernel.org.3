Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332D4E6644
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351381AbiCXPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCXPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:47:38 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F628A1447
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648136767; x=1679672767;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=L3OkSQZxRRvVfIIG+Cdml9Xl0GKcyK9pZQQERSUUIuM=;
  b=RzL5f4uYx1JOodVAPrveHRGj6CZfsOsRloYl9vffTd54n5p5q5bedwBh
   VYnTdlgw5w8YLmQfoaNojelJdhOvINxkTkM0XSC9I/TXDehB+oAwuz1dj
   B8HEtSyNdcUuhJNnCPYDCmYMhNIP+YxHBW3X99d3zA6eoQHflAqQDDgYS
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Mar 2022 08:46:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 08:46:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 08:46:05 -0700
Received: from [10.216.20.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 08:46:01 -0700
Message-ID: <602dcc82-519b-bafd-19e6-b373abe572d4@quicinc.com>
Date:   Thu, 24 Mar 2022 21:15:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 2/2] mm: madvise: return exact bytes advised with
 process_madvise under error
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <surenb@google.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <nadav.amit@gmail.com>, <edgararriaga@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <cover.1648046642.git.quic_charante@quicinc.com>
 <0fa1bdb5009e898189f339610b90ecca16f243f4.1648046642.git.quic_charante@quicinc.com>
 <Yjxutr35QLGhjJ57@dhcp22.suse.cz>
Content-Language: en-US
In-Reply-To: <Yjxutr35QLGhjJ57@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal for the inputs.

On 3/24/2022 6:44 PM, Michal Hocko wrote:
> On Wed 23-03-22 20:54:10, Charan Teja Kalla wrote:
>> From: Charan Teja Reddy <quic_charante@quicinc.com>
>>
>> The commit 5bd009c7c9a9 ("mm: madvise: return correct bytes advised with
>> process_madvise") fixes the issue to return number of bytes that are
>> successfully advised before hitting error with iovec elements
>> processing. But, when the user passed unmapped ranges in iovec, the
>> syscall ignores these holes and continues processing and returns ENOMEM
>> in the end, which is same as madvise semantic. This is a problem for
>> vector processing where user may want to know how many bytes were
>> exactly processed in a iovec element to make better decissions in the
>> user space. As in ENOMEM case, we processed all bytes in a iovec element
>> but still returned error which will confuse the user whether it is
>> failed or succeeded to advise.
> Do you have any specific example where the initial semantic is really
> problematic or is this mostly a theoretical problem you have found when
> reading the code?
> 
> 
>> As an example, consider below ranges were passed by the user in struct
>> iovec: iovec1(ranges: vma1), iovec2(ranges: vma2 -- vma3 -- hole) and
>> iovec3(ranges: vma4). In the current implementation, it fully advise
>> iovec1 and iovec2 but just returns number of processed bytes as iovec1
>> range. Then user may repeat the processing of iovec2, which is already
>> processed, which then returns with ENOMEM. Then user may want to skip
>> iovec2 and starts processing from iovec3. Here because of wrong return
>> processed bytes, iovec2 is processed twice.
> I think you should be much more specific why this is actually a problem.
> This would surely be less optimal but is this a correctness issue?
> 

Yes, this is a problem found when reading the code, but IMO we can
easily expect an invalid vma/hole in the passed range because we are
operating on other process VMA. More than solving the problem of being
less optimal, this can be looked in the direction of helping the user to
take better policy decisions with this syscall. And, not better policy
decisions from user is just being sub optimal(i.e. issuing the syscall
again on the processed range) with this syscall.

Having said that, at present I don't have any reports/unit test showing
the existing semantic is really a problematic.

> [...]
>> +	vma = find_vma_prev(mm, start, &prev);
>> +	if (vma && start > vma->vm_start)
>> +		prev = vma;
>> +
>> +	blk_start_plug(&plug);
>> +	for (;;) {
>> +		/*
>> +		 * It it hits a unmapped address range in the [start, end),
>> +		 * stop processing and return ENOMEM.
>> +		 */
>> +		if (!vma || start < vma->vm_start) {
>> +			error = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		tmp = vma->vm_end;
>> +		if (end < tmp)
>> +			tmp = end;
>> +
>> +		error = madvise_vma_behavior(vma, &prev, start, tmp, behavior);
>> +		if (error)
>> +			goto out;
>> +		tmp_bytes_advised += tmp - start;
>> +		start = tmp;
>> +		if (prev && start < prev->vm_end)
>> +			start = prev->vm_end;
>> +		if (start >= end)
>> +			goto out;
>> +		if (prev)
>> +			vma = prev->vm_next;
>> +		else
>> +			vma = find_vma(mm, start);
>> +	}
>> +out:
>> +	/*
>> +	 * partial_bytes_advised may contain non-zero bytes indicating
>> +	 * the number of bytes advised before failure. Holds zero incase
>> +	 * of success.
>> +	 */
>> +	*partial_bytes_advised = error ? tmp_bytes_advised : 0;
> Although this looks like a fix I am not sure it is future proof.
> madvise_vma_behavior doesn't report which part of the range has been
> really processed. I do not think that currently supported madvise modes
> for process_madvise support an early break out with return to the
> userspace (madvise_cold_or_pageout_pte_range bails on fatal signals for
> example) but this can change in the future and then you are back to
> "imprecise" return value problem. Yes, this is a theoretical problem

Agree here with the "imprecise" return value problem with processing a
VMA range. Yes when it is decided to return proper processed value from
madvise_vma_behavior(), this code too may need the maintenance.

> but so it sounds the problem you are trying to fix IMHO. I think it
> would be better to live with imprecise return values reporting rather
> than aiming for perfection which would be fragile and add a future
> maintenance burden.
>
Hmm. Should atleast this imprecise return values be documented in man
page or in madvise.c file?

> On the other hand if there are _real_ workloads which suffer from the
> existing semantic then sure the above seems to be an appropriate fix
> AFAICS.


> -- Michal Hocko SUSE Labs
