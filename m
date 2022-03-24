Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2387F4E64A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350717AbiCXOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCXOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:05:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A66BDE1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648130645; x=1679666645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PIk/w/RBaLqMusauG9U27ohA+VfrT1MXk+SdCIDQlq8=;
  b=kKkaDdb7q4GjAXXSJP6dITFnKmKSd0H7b+RgQpch/yukAcJ1BbWKiLBb
   qBvhOnc5MpVeWI3/hVqZbPOePcnpZHyZ4uxMRRqWQRaOo32870TbQV5z9
   f5ULH10JDyn7K4Oy7au865nlSQ1WL77YB/K7E43wUhTq2kbknBOtdVfsz
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 24 Mar 2022 07:04:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 07:04:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 07:04:04 -0700
Received: from [10.216.20.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 07:04:00 -0700
Message-ID: <d69a9b5a-7421-5a7d-9e5f-06b062769315@quicinc.com>
Date:   Thu, 24 Mar 2022 19:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] Revert "mm: madvise: skip unmapped vma holes passed
 to process_madvise"
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <surenb@google.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <nadav.amit@gmail.com>, <edgararriaga@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1648046642.git.quic_charante@quicinc.com>
 <e73da1304a88b6a8a11907045117cccf4c2b8374.1648046642.git.quic_charante@quicinc.com>
 <Yjxoha4PLlKjEayl@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <Yjxoha4PLlKjEayl@dhcp22.suse.cz>
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

Thanks Michal.

On 3/24/2022 6:18 PM, Michal Hocko wrote:
> On Wed 23-03-22 20:54:09, Charan Teja Kalla wrote:
>> This reverts commit 08095d6310a7 ("mm: madvise: skip unmapped vma holes
>> passed to process_madvise") as process_madvise() fails to return exact
>> processed bytes at other cases too. As an example: if the
>> process_madvise() hits mlocked pages after processing some initial bytes
>> passed in [start, end), it just returns EINVAL though some bytes are
>> processed. Thus making an exception only for ENOMEM is partially fixing
>> the problem of returning the proper advised bytes.
>>
>> Thus revert this patch and return proper bytes advised, if there any,
>> for all the error types in the following patch.
> 
> I do agree with the revert. I am not sure the above really is a proper
> justification though. 08095d6310a7 was changing one (arguably) dubious
> semantic by another one without a proper justification and wider
> consensus which I would expect from a patch which changes an existing
> semantic. Not to mention it being marked for stable tree.

Thanks for pointing this out. Since 08095d6310a7 is marked for stable
tree, doing the same for this change.

Cc: <stable@vger.kernel.org> # 5.10+

> 
> But let's not nit pick on that now. Let's send this revert ASAP and use
> some more time to discuss the semantic and whether any change is really
> required.
> 
>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
Thanks for the quick ack.
>> ---
>>  mm/madvise.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 39b712f..0d8fd17 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1433,16 +1433,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>>  
>>  	while (iov_iter_count(&iter)) {
>>  		iovec = iov_iter_iovec(&iter);
>> -		/*
>> -		 * do_madvise returns ENOMEM if unmapped holes are present
>> -		 * in the passed VMA. process_madvise() is expected to skip
>> -		 * unmapped holes passed to it in the 'struct iovec' list
>> -		 * and not fail because of them. Thus treat -ENOMEM return
>> -		 * from do_madvise as valid and continue processing.
>> -		 */
>>  		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
>>  					iovec.iov_len, behavior);
>> -		if (ret < 0 && ret != -ENOMEM)
>> +		if (ret < 0)
>>  			break;
>>  		iov_iter_advance(&iter, iovec.iov_len);
>>  	}
>> -- 
>> 2.7.4
> 
